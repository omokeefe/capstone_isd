#!/usr/bin/env python3
"""Extract structured (text-layer) annotations from an annotated PDF.

Pulls highlights, underlines, strikeouts, squiggly-underlines, and typed
sticky-note/free-text comments -- the annotation types that carry real text
and so can be extracted precisely. Handwritten (ink/freehand) annotations are
vector strokes, not text, so they are only *counted* by default; pass
--include-handwritten to additionally locate them and render an image crop of
each one so they can be reviewed visually (e.g. via Claude Code's Read tool).

Usage:
    python tools/extract_pdf_annotations.py "evidence/sources/some paper.pdf"
    python tools/extract_pdf_annotations.py "evidence/sources/some paper.pdf" --include-handwritten
    python tools/extract_pdf_annotations.py "evidence/sources/some paper.pdf" --out inbox/some-paper-pdf-highlights.md
    python tools/extract_pdf_annotations.py "evidence/sources/some paper.pdf" --json

Requires: pymupdf (see tools/requirements.txt).
"""
from __future__ import annotations

import argparse
import datetime
import json
import sys
from pathlib import Path

import pymupdf

# PyMuPDF annotation subtype names for the categories we care about.
TEXT_MARKUP_TYPES = {"Highlight", "Underline", "Squiggly", "StrikeOut"}
NOTE_TYPES = {"Text", "FreeText"}
INK_TYPE = "Ink"


def quoted_text_for(page: "pymupdf.Page", annot: "pymupdf.Annot") -> str:
    """Text under a markup annotation's quad points (the highlighted/underlined span)."""
    quads = annot.vertices
    if not quads:
        return ""
    rects = []
    for i in range(0, len(quads), 4):
        rects.append(pymupdf.Quad(quads[i : i + 4]).rect)
    pieces = [page.get_textbox(r).strip() for r in rects]
    return " ".join(p for p in pieces if p)


def cluster_rects(rects: list, pad: float = 12.0) -> list[list[int]]:
    """Group rect indices into clusters of mutually-close rects (union-find on
    padded-rect intersection). Handwriting apps record one Ink annotation per
    pen stroke, so a single handwritten note/word is many small adjacent
    rects that need merging back into one before rendering -- otherwise each
    stroke would render as its own illegible letter-sized crop."""
    n = len(rects)
    parent = list(range(n))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    def union(i, j):
        ri, rj = find(i), find(j)
        if ri != rj:
            parent[ri] = rj

    padded = [r + (-pad, -pad, pad, pad) for r in rects]
    for i in range(n):
        for j in range(i + 1, n):
            if padded[i].intersects(padded[j]):
                union(i, j)

    clusters: dict[int, list[int]] = {}
    for i in range(n):
        clusters.setdefault(find(i), []).append(i)
    return list(clusters.values())


def process_pdf(path: Path, include_handwritten: bool, image_dir: Path):
    doc = pymupdf.open(path)
    entries = []
    ink_total = 0
    for page_index in range(len(doc)):
        page = doc[page_index]
        ink_annots = []
        for annot in page.annots() or []:
            subtype = annot.type[1]
            info = annot.info
            comment = (info.get("content") or "").strip()
            author = (info.get("title") or "").strip()

            if subtype in TEXT_MARKUP_TYPES:
                entries.append(
                    {
                        "page": page_index + 1,
                        "type": subtype,
                        "quoted_text": quoted_text_for(page, annot),
                        "comment": comment,
                        "author": author,
                    }
                )
            elif subtype in NOTE_TYPES:
                entries.append(
                    {
                        "page": page_index + 1,
                        "type": subtype,
                        "quoted_text": "",
                        "comment": comment,
                        "author": author,
                    }
                )
            elif subtype == INK_TYPE:
                ink_total += 1
                ink_annots.append((annot.rect, comment))

        if ink_annots:
            clusters = cluster_rects([r for r, _ in ink_annots])
            for cluster_num, idxs in enumerate(clusters, start=1):
                cluster_rect = ink_annots[idxs[0]][0]
                for i in idxs[1:]:
                    cluster_rect |= ink_annots[i][0]
                comments = [ink_annots[i][1] for i in idxs if ink_annots[i][1]]
                entry = {
                    "page": page_index + 1,
                    "type": "Ink (handwritten)",
                    "quoted_text": "",
                    "comment": " / ".join(comments),
                    "author": "",
                    "stroke_count": len(idxs),
                }
                if include_handwritten:
                    pad = 20
                    clip = (cluster_rect + (-pad, -pad, pad, pad)) & page.rect
                    pix = page.get_pixmap(clip=clip, dpi=200)
                    image_dir.mkdir(parents=True, exist_ok=True)
                    img_path = image_dir / f"{path.stem}-p{page_index + 1}-note{cluster_num}.png"
                    pix.save(str(img_path))
                    entry["image"] = str(img_path)
                entries.append(entry)
    doc.close()
    return entries, ink_total


def render_markdown(pdf_path: Path, entries: list, ink_total: int, include_handwritten: bool) -> str:
    lines = [
        f"# PDF annotation extract: {pdf_path.name}",
        "",
        f"_Extracted {datetime.date.today().isoformat()} via `tools/extract_pdf_annotations.py`. "
        "Untriaged raw material -- merge relevant points into the source's annotation/summary "
        "note or discard, per `workflows/process-inbox.md`._",
        "",
    ]

    by_page: dict[int, list] = {}
    for e in entries:
        by_page.setdefault(e["page"], []).append(e)

    non_ink_pages = sorted(p for p, es in by_page.items() if any(e["type"] != "Ink (handwritten)" for e in es))
    for page in non_ink_pages:
        lines.append(f"## Page {page}")
        for e in by_page[page]:
            if e["type"] == "Ink (handwritten)":
                continue
            label = e["type"]
            bits = []
            if e["quoted_text"]:
                bits.append(f'"{e["quoted_text"]}"')
            if e["comment"]:
                bits.append(f'comment: "{e["comment"]}"')
            if e["author"]:
                bits.append(f'author: {e["author"]}')
            body = " -- ".join(bits) if bits else "(no extractable text)"
            lines.append(f"- **{label}:** {body}")
        lines.append("")

    ink_entries = [e for e in entries if e["type"] == "Ink (handwritten)"]
    lines.append("## Handwritten (ink) annotations")
    if ink_total == 0:
        lines.append("None found.")
    elif not include_handwritten:
        lines.append(
            f"~{len(ink_entries)} handwritten note(s) found ({ink_total} raw pen strokes), not extracted "
            "(handwriting is off by default). Re-run with `--include-handwritten` to render one image "
            "per clustered note for visual review."
        )
    else:
        for e in ink_entries:
            bits = [f'image: `{e["image"]}`', f'{e["stroke_count"]} strokes']
            if e["comment"]:
                bits.append(f'comment: "{e["comment"]}"')
            lines.append(f"- Page {e['page']} -- {' -- '.join(bits)}")
        lines.append("")
        lines.append(
            "(Open each image with the Read tool and transcribe/summarize the handwriting visually "
            "-- ink strokes are not text-extractable.)"
        )

    lines.append("")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("pdf", type=Path, nargs="+", help="Path(s) to annotated PDF file(s).")
    parser.add_argument(
        "--include-handwritten",
        action="store_true",
        help="Also locate ink/freehand annotations and render image crops for visual review. Off by default.",
    )
    parser.add_argument(
        "--image-dir",
        type=Path,
        default=Path(".tmp/pdf-annotation-images"),
        help="Where to save handwritten-annotation image crops (default: .tmp/pdf-annotation-images/).",
    )
    parser.add_argument("--out", type=Path, help="Write markdown output to this file instead of stdout.")
    parser.add_argument("--json", action="store_true", help="Emit raw JSON instead of markdown.")
    args = parser.parse_args()

    all_output = []
    for pdf_path in args.pdf:
        if not pdf_path.exists():
            print(f"error: not found: {pdf_path}", file=sys.stderr)
            sys.exit(1)
        entries, ink_total = process_pdf(pdf_path, args.include_handwritten, args.image_dir)
        if args.json:
            all_output.append({"file": str(pdf_path), "annotations": entries, "ink_count": ink_total})
        else:
            all_output.append(render_markdown(pdf_path, entries, ink_total, args.include_handwritten))

    if args.json:
        text = json.dumps(all_output, indent=2)
    else:
        text = "\n\n---\n\n".join(all_output)

    if args.out:
        args.out.parent.mkdir(parents=True, exist_ok=True)
        args.out.write_text(text, encoding="utf-8")
        print(f"wrote {args.out}")
    else:
        print(text)


if __name__ == "__main__":
    main()
