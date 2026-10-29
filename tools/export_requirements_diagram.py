"""Draw SysML-style requirement diagrams from the requirement files in cameo_models/.

Reads the same three .sysml files as tools/export_requirements_xlsx.py (the source of
truth, D-006) through that script's parser, and writes Graphviz diagrams to
projects/nas-sos-capstone/cameo_models/print/requirements-diagrams/:

    00_overview      the stakeholder requirements on the NAS: package StakeholderRequirements
                     owns one package per stakeholder group, which owns its requirements
                     (circle-plus ownership lines, as on a SysML requirement diagram)
    SN-xxx-nn        one page per stakeholder requirement: it, the system requirements
                     derived from it and the HLRs derived from those (dashed <<deriveReqt>>
                     arrows pointing from the derived requirement to its source)
    requirements-diagrams.pdf  every page in one file, overview first

The trace is drawn from the attributes the model keeps it in (`parentNeeds` on a system
requirement, `parentRequirements` on an HLR). Those are many-to-many, so below the
stakeholder tier the diagram uses derive arrows, not ownership. A parent that is not on
the page is named in the box ("also from ..."). Grey: out of study (D-031); lilac:
background. These are derived pictures; change the model and rerun.

Usage (from the repo root):
    .venv/Scripts/python.exe tools/export_requirements_diagram.py [--out DIR] [--format pdf,png]

Needs Graphviz (`dot`; set GRAPHVIZ_DOT to its full path if it is not on PATH) and
PyMuPDF to join the pages.
"""

from __future__ import annotations

import argparse
import datetime as dt
import html
import os
import re
import shutil
import subprocess
import sys
import textwrap
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import export_requirements_xlsx as ex  # noqa: E402

DEFAULT_OUT = ex.MODEL / "print" / "requirements-diagrams"

TINT = {"SN": "#DDEBF7", "SLR": "#E2EFDA", "HLR": "#FFF2CC"}  # the workbook's tier tints
SCOPE_FILL = {"outOfStudy": "#EDEDED", "background": "#E4DFEC"}
GREY = "#7F7F7F"
WRAP = 52
# Acronyms the camelCase names spell in lower case (fmsFiguresSentToAirline).
ACRONYMS = {"fms": "FMS", "atc": "ATC", "aoc": "AOC", "adsb": "ADS-B", "co2": "CO2", "nas": "NAS",
            "sua": "SUA", "eta": "ETA", "ifr": "IFR", "tfm": "TFM"}


def find_dot() -> str:
    for exe in (os.environ.get("GRAPHVIZ_DOT"), shutil.which("dot"), r"C:\Program Files\Graphviz\bin\dot.exe"):
        if exe and Path(exe).exists():
            return exe
    sys.exit("Graphviz `dot` was not found. Install Graphviz or set GRAPHVIZ_DOT to dot.exe.")


def words(name: str) -> str:
    """lowestCostTrajectory -> Lowest cost trajectory (keeps acronyms such as ATC, CO2)."""
    parts = re.findall(r"[A-Z]{2,}[0-9]*(?=[A-Z][a-z]|$|[^A-Za-z])|[A-Z]?[a-z0-9]+|[A-Z]+[0-9]*", name)
    out = " ".join(ACRONYMS.get(p.lower(), p if (p.isupper() and len(p) > 1) else p.lower()) for p in parts)
    return out[:1].upper() + out[1:]


def esc(s: str) -> str:
    return html.escape(s, quote=True)


def wrapped(s: str, width: int = WRAP, limit: int | None = None) -> str:
    if limit and len(s) > limit:
        s = s[:limit].rsplit(" ", 1)[0] + " ..."
    return '<br align="left"/>'.join(esc(ln) for ln in textwrap.wrap(s, width)) + '<br align="left"/>'


def tags(req: dict) -> list[str]:
    t = [ex.SCOPE_TAGS[ex.scope(req)].lower()] if ex.scope(req) in ex.SCOPE_TAGS else []
    if ex.one(req, "obligation") == "goal":
        t.append("goal")
    if ex.one(req, "architectureState") == "improved":
        t.append("improved")
    return t


def req_node(req: dict, *, limit: int | None = None, extra: str = "") -> str:
    """A SysML requirement box: stereotype and name, then id = and text = compartments."""
    grey = ex.scope(req) == "outOfStudy"
    fill = SCOPE_FILL.get(ex.scope(req), TINT[req["tier"]])
    color = GREY if grey else "black"
    stereo = "&#171;requirement&#187;" + (f" [{', '.join(tags(req))}]" if tags(req) else "")
    body = f'id = {esc(req["id"])}<br align="left"/>text = {wrapped(req["text"], limit=limit)}'
    if extra:
        body += f'<i>{wrapped(extra)}</i>'
    border = ' color="#C55A11"' if "improved" in tags(req) else ""
    label = (f'<<table border="1" cellborder="0" cellspacing="0" cellpadding="4" bgcolor="{fill}"{border}>'
             f'<tr><td><font point-size="9" color="{color}">{stereo}</font></td></tr>'
             f'<tr><td><font color="{color}"><b>{esc(words(req["name"]))}</b></font></td></tr>'
             f'<tr><td align="left" sides="t"><font point-size="9" color="{color}">{body}</font></td></tr>'
             '</table>>')
    return f'"{req["id"]}" [shape=plain, label={label}];'


def package_node(key: str, name: str, subtitle: str) -> str:
    label = (f'<<font point-size="9">&#171;package&#187;</font><br/><b>{esc(name)}</b>'
             f'<br/><font point-size="9">{esc(subtitle)}</font>>')
    return f'"{key}" [shape=tab, style=filled, fillcolor="#F2F2F2", label={label}];'


def graph(body: list[str], note: str, splines: str = "ortho") -> str:
    # The key and stamp are the graph's caption, below the drawing, so no edge can reach them.
    caption = esc(note).replace("\n", "\\l") + "\\l"
    return "\n".join([
        "digraph R {",
        f'  graph [rankdir=LR, nodesep=0.18, ranksep=0.55, fontname="Helvetica", splines={splines}, pad=0.3,',
        f'         labelloc=b, labeljust=l, fontsize=8, fontcolor="{GREY}", label="{caption}"];',
        '  node [fontname="Helvetica", fontsize=10];',
        '  edge [fontname="Helvetica", fontsize=8, color="#404040"];',
        *("  " + b for b in body),
        "}",
    ])


def owns(parent: str, kids: list[str]) -> list[str]:
    """Circle-plus ownership: a line from the parent to one shared crosshair, then to each child."""
    j = f"own_{parent}"
    out = [f'"{j}" [shape=circle, label="+", fontsize=11, width=0.2, height=0.2, fixedsize=true, margin=0];',
           f'"{parent}" -> "{j}" [arrowhead=none];']
    out += [f'"{j}" -> "{k}" [arrowhead=none];' for k in kids]
    return out


def derives(source: str, derived: str) -> str:
    # Drawn source -> derived so the layout reads left to right; dir=back puts the arrowhead
    # on the source end, as SysML draws deriveReqt (derived requirement -> source).
    return (f'"{source}" -> "{derived}" [dir=back, arrowtail=vee, arrowsize=0.7, style=dashed, '
            f'xlabel="«deriveReqt»"];')


def render(dot: str, text: str, stem: Path, formats: list[str]) -> list[Path]:
    src = stem.with_suffix(".dot")
    src.write_text(text, encoding="utf-8")
    made = []
    for f in formats:
        out = stem.with_suffix("." + f)
        args = [dot, f"-T{f}", str(src), "-o", str(out)] + (["-Gdpi=150"] if f == "png" else [])
        done = subprocess.run(args, capture_output=True, text=True)
        if done.returncode:
            sys.exit(f"dot failed on {src.name}: {done.stderr.strip()}")
        made.append(out)
    src.unlink()
    return made


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    p.add_argument("--out", type=Path, default=DEFAULT_OUT)
    p.add_argument("--format", default="pdf,png", help="comma-separated Graphviz formats (default pdf,png)")
    args = p.parse_args()
    formats = [f.strip() for f in args.format.split(",") if f.strip()]
    dot = find_dot()

    sn = ex.parse_requirements(ex.FILES["SN"], "SN")
    slr = ex.parse_requirements(ex.FILES["SLR"], "SLR")
    hlr = ex.parse_requirements(ex.FILES["HLR"], "HLR")
    by_name = {r["name"]: r for r in sn + slr + hlr}
    groups = list(ex.GROUP_NAMES)
    sn.sort(key=lambda r: (groups.index(ex.one(r, "stakeholderGroup")) if ex.one(r, "stakeholderGroup") in groups else 99, r["id"]))
    slr_parents = {r["id"]: [by_name[n]["id"] for n in r["attrs"].get("parentNeeds", [])] for r in slr}
    hlr_parents = {r["id"]: [by_name[n]["id"] for n in r["attrs"].get("parentRequirements", [])] for r in hlr}

    commit = subprocess.run(["git", "rev-parse", "--short", "HEAD"], capture_output=True, text=True, cwd=ex.REPO).stdout.strip()
    stamp = f"Generated {dt.datetime.now():%Y-%m-%d %H:%M} from commit {commit} (plus any uncommitted edits) by tools/export_requirements_diagram.py."
    key = ("Circle-plus: ownership (the package or requirement on the left owns those on the right). "
           "Dashed arrow: deriveReqt, pointing from the derived requirement to its source. "
           "Grey: out of study (D-031). Lilac: background. Orange border: improved architecture (D-018).")

    args.out.mkdir(parents=True, exist_ok=True)
    for old in args.out.glob("*"):
        if old.suffix in {".pdf", ".png", ".svg", ".dot"}:
            old.unlink()

    # ---- overview: StakeholderRequirements -> group packages -> stakeholder requirements
    body = [package_node("StakeholderRequirements", "StakeholderRequirements",
                         "stakeholder requirements on the National Airspace System")]
    pkgs = list(dict.fromkeys(s["package"] for s in sn))
    body += owns("StakeholderRequirements", pkgs)
    for pk in pkgs:
        members = [s for s in sn if s["package"] == pk]
        group = ex.GROUP_NAMES.get(ex.one(members[0], "stakeholderGroup"), "")
        body.append(package_node(pk, pk, group))
        body += owns(pk, [s["id"] for s in members])
        body += [req_node(s, limit=110) for s in members]
    # Curved lines here: right-angle routing merges neighbouring groups' fans, hiding which owns what.
    pages = [render(dot, graph(body, f"{key}\n{stamp}\nRequirements: requirements_stakeholders.sysml", splines="spline"),
                    args.out / "00_overview", formats)]

    # ---- one page per stakeholder requirement
    for s in sn:
        kids = [r for r in slr if s["id"] in slr_parents[r["id"]]]
        grand = [h for h in hlr if any(r["id"] in hlr_parents[h["id"]] for r in kids)]
        on_page = {s["id"]} | {r["id"] for r in kids} | {h["id"] for h in grand}

        def also(req, parents):
            others = [p for p in parents if p not in on_page]
            return f"also from {', '.join(others)}" if others else ""

        group = ex.GROUP_NAMES.get(ex.one(s, "stakeholderGroup"), "")
        body = [req_node(s, extra=f"owner: StakeholderRequirements::{s['package']} ({group})")]
        body += [req_node(r, extra=also(r, slr_parents[r["id"]])) for r in kids]
        body += [req_node(h, extra=also(h, hlr_parents[h["id"]])) for h in grand]
        body += [derives(s["id"], r["id"]) for r in kids]
        body += [derives(r["id"], h["id"]) for h in grand for r in kids if r["id"] in hlr_parents[h["id"]]]
        if not grand and kids and ex.scope(s) != "inStudy":
            body.append(f'"cut" [shape=plaintext, fontsize=9, fontcolor="{GREY}", '
                        f'label="No HLRs: the study is cut at the HLR tier (D-031)."];')
        pages.append(render(dot, graph(body, f"{key}\n{stamp}"), args.out / s["id"], formats))

    if "pdf" in formats:
        import pymupdf

        book = pymupdf.open()
        for made in pages:
            book.insert_pdf(pymupdf.open(next(m for m in made if m.suffix == ".pdf")))
        book.save(args.out / "requirements-diagrams.pdf")
    print(f"Wrote {len(pages)} pages ({', '.join(formats)}) and requirements-diagrams.pdf to {args.out}")
    print(f"  {len(sn)} SN, {len(slr)} SLR, {len(hlr)} HLR")


if __name__ == "__main__":
    main()
