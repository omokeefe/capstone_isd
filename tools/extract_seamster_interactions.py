#!/usr/bin/env python3
"""Extract the interaction tables from Seamster, Chevalley & Kanki (2011),
"Collaborative Systems Assessment: Flightdeck, Air Traffic Control, Flight Operations
Center and Automation" (NASA Ames / FAA draft report), into one CSV plus a readable
markdown rendering.

Tables covered: 2.1-2.10 (interaction examples and survey results), 3.1, Appendix A
(pilot survey items), C-1..C-3 (ATC interactions by controller position), D-1..D-4
(dispatcher survey items), E-1..E-13 (the flightdeck-ATC-FOC interaction matrix).
Not covered: future-state NextGen tables (Sections 4-5) and the Appendix B process-chart
figures.

The tables are vector tables, so PyMuPDF's find_tables() gives row/cell geometry; text is
then read per cell/column from that geometry (pdftotext scrambles wrapped cells).

Usage (from the repo root):
    python tools/extract_seamster_interactions.py            # write CSV + markdown
    python tools/extract_seamster_interactions.py --verify   # also print coverage report

Optional BB crosswalk: if evidence/literature-notes/annotations/seamster2011collabSystems-bb-rules.csv
exists, its rules (regex on interaction text -> JO 7110.65BB paragraph) are applied to
ATC-involved rows and written to the bb_paragraph column. Output is deterministic.
"""
import argparse
import csv
import re
import sys
from collections import Counter
from pathlib import Path

import pymupdf

REPO = Path(__file__).resolve().parent.parent
PDF = REPO / "evidence/sources/Collaborative Systems Assessment - Flightdeck, Air Traffic Control, Flight Operations Center and Automation.pdf"
OUT_DIR = REPO / "evidence/literature-notes/annotations"
CSV_OUT = OUT_DIR / "seamster2011collabSystems-interactions.csv"
MD_OUT = OUT_DIR / "seamster2011collabSystems-interactions.md"
BB_RULES = OUT_DIR / "seamster2011collabSystems-bb-rules.csv"

GROUPS = {"ATC", "FOC", "FD", "RAMP"}
PILOT_SRC = "pilot survey (n=11, one operator)"
DISP_SRC = "dispatcher survey (n=4, one domestic operator)"

FIELDS = [
    "interaction_id", "table_id", "row_type", "pdf_page", "report_page", "table_title",
    "condition_nominal", "phase", "sub_step", "off_nominal_event", "context", "seq",
    "media", "subj_group", "subj_position", "obj_group", "obj_position",
    "interaction", "condition", "text_as_printed", "controller_positions",
    "freq", "crit", "rating_source", "cited_7110_65", "bb_paragraph", "extraction_flags",
]

# (table_id, pdf_page (1-based), table index on page, family, nominal?, default groups)
REGISTRY = [
    ("2.1", 28, 0, "fd_list", "off-nominal", ("FD", "ATC")),
    ("2.2", 29, 0, "fd_list", "off-nominal", ("FD", "FOC")),
    ("2.3", 30, 0, "pilot_rated", "nominal", ("FD", "")),
    ("2.4", 30, 1, "pilot_rated", "off-nominal", ("FD", "")),
    ("2.5", 31, 0, "pilot_rated", "nominal", ("FD", "")),
    ("2.6", 31, 1, "pilot_rated", "off-nominal", ("FD", "")),
    ("2.7", 33, 0, "atc_hier", "nominal", ("ATC", "")),
    ("2.8", 34, 0, "atc_hier", "off-nominal", ("ATC", "")),
    ("2.9", 37, 0, "foc_rated", "nominal", ("FOC", "")),
    ("2.10", 38, 0, "foc_rated", "off-nominal", ("FOC", "")),
    ("3.1", 49, 0, "table31", "mixed", ("", "")),
    ("A.1", 91, 0, "survey", "nominal", ("FD", "")),
    ("A.2", 92, 0, "survey", "off-nominal", ("FD", "")),
    ("C-1", 96, 0, "atc_hier", "nominal", ("ATC", "")),
    ("C-2", 97, 0, "atc_hier", "nominal", ("ATC", "ATC")),
    ("C-3", 98, 0, "atc_hier", "off-nominal", ("ATC", "")),
    ("D-1", 100, 0, "survey", "nominal", ("FOC", "FD")),
    ("D-2", 100, 1, "survey", "off-nominal", ("FOC", "FD")),
    ("D-3", 101, 0, "survey", "mixed", ("FOC", "ATC")),
    ("D-4", 101, 1, "survey", "mixed", ("FOC", "")),
] + [(f"E-{i}", 102 + i, 0, "matrix", "mixed", ("", "")) for i in range(1, 14)]


def norm(t):
    t = " ".join(t.replace("–", "-").split())  # en dash printed in some position labels -> "-"
    # re-join words hyphen-wrapped across lines ("de- icing" -> "de-icing")
    return re.sub(r"(?<=[a-z])-\s+(?=[a-z])", "-", t)


def cell_text(page, rect):
    return norm(page.get_textbox(pymupdf.Rect(rect)))


def span_style(page, rect):
    """(bold, italic, white_text, size) for the first non-empty span inside rect."""
    for b in page.get_text("dict", clip=pymupdf.Rect(rect))["blocks"]:
        for ln in b.get("lines", []):
            for s in ln["spans"]:
                if s["text"].strip():
                    f = s["flags"]
                    return bool(f & 16), bool(f & 2), s["color"] == 16777215, round(s["size"], 1)
    return False, False, False, 0.0


def report_page(page):
    m = re.search(r"Draft Report[^\n]*?(Appendices )?page (\d+) of (\d+)", page.get_text())
    if not m:
        return ""
    return ("App. p." if m.group(1) else "p.") + m.group(2)


POSITION_GROUP = [
    (r"Captain|First Officer|Pilot (Flying|Monitoring)|Crew", "FD"),
    (r"Dispatcher|coordinator", "FOC"),
    (r"Load Planner|Pushback|ground personnel", "RAMP"),
    (r"Tower|Departure|Approach|Center|TMU|Host|[Ss]ector", "ATC"),
]


def split_group_words(ws, cell_x0):
    """Group is the left-most GROUPS word, in the cell's left sub-column; the rest is the position.
    (Reading order alone is unreliable: the group is vertically centred when the position wraps.)
    Returns (group, position, flag). If the source omits the group, it is inferred from the
    position and flagged."""
    if not ws:
        return "", "", ""
    left = min(w[0] for w in ws)
    cand = [w for w in ws if w[4] in GROUPS and w[0] <= left + 15]
    if cand:
        g = min(cand, key=lambda w: w[0])
        return g[4], " ".join(w[4] for w in ws if w is not g).replace("–", "-"), ""
    pos = " ".join(w[4] for w in ws).replace("–", "-")
    for pat, grp in POSITION_GROUP:
        if re.search(pat, pos):
            return grp, pos, "group-inferred-from-position (source omits group)"
    return "", pos, "group-missing"


def words_list(page, x0, y0, x1, y1):
    ws = page.get_text("words", clip=pymupdf.Rect(x0, y0, x1, y1))
    ws.sort(key=lambda w: (round(w[1] / 3), w[0]))
    return ws


def words_in(page, x0, y0, x1, y1):
    return norm(" ".join(w[4] for w in words_list(page, x0, y0, x1, y1)))


def norm_media(m):
    m = re.sub(r"-\s+", "-", m)  # "Face-to- Face" -> "Face-to-Face"
    return m


COND_PREFIX = re.compile(r"^(If [^:]{1,70}?):\s*(.*)$")
COND_SUFFIX = re.compile(r"^(.*?)\s*\((If [^)]*)\)\s*$")


def split_condition(text):
    m = COND_PREFIX.match(text)
    if m:
        return m.group(2), m.group(1)
    m = COND_SUFFIX.match(text)
    if m:
        return m.group(1), m.group(2)
    return text, ""


def infer_obj_group(text):
    t = text.lower()
    has_atc, has_foc = "atc" in t or "controller" in t, "dispatch" in t or "foc" in t
    if has_atc and has_foc:
        return "ATC/FOC"
    return "ATC" if has_atc else ("FOC" if has_foc else "")


def blank_row(tid, page, title, nominal):
    r = {k: "" for k in FIELDS}
    r.update(table_id=tid, pdf_page=page.number + 1, report_page=report_page(page),
             table_title=title, condition_nominal=nominal)
    return r


def data_rows(tb):
    """Rows with at least one non-None cell, as (row_index, y0, y1, [rects])."""
    out = []
    full = tb.bbox[2] - tb.bbox[0]
    for i, row in enumerate(tb.rows):
        cells = [c for c in row.cells if c is not None]
        # shaded rows produce spurious part-width "rows" (highlight rectangles); real rows span the table
        if cells and (row.bbox[2] - row.bbox[0]) >= 0.6 * full:
            out.append((i, row.bbox[1], row.bbox[3], cells))
    return out


# ---------------------------------------------------------------- families
def parse_matrix(page, tb, tid, nominal):
    rows_out, skipped = [], []
    rows = data_rows(tb)
    title_parts, colx, start = [], None, 0
    for k, (i, y0, y1, cells) in enumerate(rows):
        texts = [cell_text(page, c) for c in cells]
        if any(t == "Media" for t in texts):
            mc = next(c for c, t in zip(cells, texts) if t == "Media")
            sc = next(c for c, t in zip(cells, texts) if t == "Subject")
            oc = next(c for c, t in zip(cells, texts) if t == "Interacting with")
            ic = next(c for c, t in zip(cells, texts) if t == "Interactions")
            colx = (mc[0], sc[0], oc[0], ic[0], tb.bbox[2])
            start = k + 1
            # skip the sub-header row ("Group Position") that follows
            while start < len(rows) and any("Group" in cell_text(page, c) for c in rows[start][3]) \
                    and not any(t for t in [cell_text(page, c) for c in rows[start][3]] if t.startswith("Flight")):
                skipped.append(" ".join(cell_text(page, c) for c in rows[start][3]))
                start += 1
            break
        title_parts.extend(t for t in texts if t)
    title = norm(" ".join(title_parts))
    skipped.append(title)
    skipped.append("Media Subject Interacting with Interactions Group Position Group Position")
    title = re.sub(r"^Table E-\d+\.\s*", "", title)
    title = re.sub(r"\bR\b\s+of a", "of a", title)
    phase = re.sub(r"^.*? During (the |an )?", "", title).replace(" of a Generic Flight.", "").strip(". ") or title
    sub_step, off_event, seq = "", "", 0
    base = blank_row(tid, page, title, nominal)
    for (i, y0, y1, cells) in rows[start:]:
        wide = [c for c in cells if c[2] - c[0] > 300]
        raw = [cell_text(page, c) for c in cells]
        if not any(raw):
            continue
        if wide:
            txt = cell_text(page, wide[0])
            bold, ital, white, size = span_style(page, wide[0])
            r = dict(base, row_type="header")
            if ital:
                off_event, kind = txt, "off-nominal event"
                r["off_nominal_event"] = txt
            elif white:
                phase, sub_step, off_event, kind = txt, "", "", "phase"
                r["phase"] = txt
            else:
                sub_step, kind = txt, "sub-step"
                r["sub_step"] = txt
            r["context"] = kind
            r["interaction"] = txt
            rows_out.append(r)
            continue
        m = norm_media(words_in(page, colx[0], y0 + 0.5, colx[1], y1 - 0.5))
        sw = words_list(page, colx[1], y0 + 0.5, colx[2], y1 - 0.5)
        ow = words_list(page, colx[2], y0 + 0.5, colx[3], y1 - 0.5)
        s, o = " ".join(w[4] for w in sw), " ".join(w[4] for w in ow)
        t = words_in(page, colx[3], y0 + 0.5, colx[4], y1 - 0.5)
        if not any(ch.isalnum() for ch in m + s + o + t):  # "..." rows are drawn as U+2026 glyphs
            rows_out.append(dict(base, row_type="gap", phase=phase, sub_step=sub_step,
                                 off_nominal_event=off_event, interaction="\u2026",
                                 text_as_printed="\u2026", extraction_flags="time-gap marker (indeterminate lapse of time)"))
            continue
        seq += 1
        sg, sp, sf = split_group_words(sw, colx[1])
        og, op, of = split_group_words(ow, colx[2])
        body, cond = split_condition(t)
        flags = [f"subject {sf}" if sf else "", f"interacting-with {of}" if of else ""]
        flags = [f for f in flags if f]
        if not m:
            flags.append("media-blank")
        r = dict(base, row_type="interaction", phase=phase, sub_step=sub_step,
                 off_nominal_event=off_event, seq=seq, interaction_id=f"{tid}#{seq:02d}",
                 media=m, subj_group=sg, subj_position=sp, obj_group=og, obj_position=op,
                 interaction=body, condition=cond, text_as_printed=t,
                 condition_nominal="off-nominal" if off_event else "nominal",
                 extraction_flags="; ".join(flags))
        rows_out.append(r)
    return rows_out, skipped


def parse_fd_list(page, tb, tid, nominal, groups):
    """Tables 2.1 / 2.2: Flight Phase | numbered communication interaction."""
    rows_out, seq, phase, title, skipped = [], 0, "", "", []
    base = blank_row(tid, page, "", nominal)
    for (i, y0, y1, cells) in data_rows(tb):
        texts = [cell_text(page, c) for c in cells]
        if texts[0] == "Flight Phase":
            skipped.append(" ".join(texts))
            continue
        if len(texts) < 2:
            continue
        flags = []
        if texts[0]:
            phase = texts[0]
        else:
            flags.append("phase-carried")
        m = re.match(r"^(\d+)\.\s*(.*)$", texts[1])
        num, body = (m.group(1), m.group(2)) if m else ("", texts[1])
        body, cond = split_condition(body)
        seq += 1
        rows_out.append(dict(base, row_type="interaction", phase=phase, seq=seq,
                             interaction_id=f"{tid}#{seq:02d}", subj_group=groups[0],
                             obj_group=groups[1], interaction=body, condition=cond,
                             text_as_printed=texts[1], extraction_flags="; ".join(flags),
                             context=f"report item no. {num}" if num else ""))
    return rows_out, skipped


def parse_pilot_rated(page, tb, tid, nominal, groups):
    """Tables 2.3-2.6: Flight Phase | interaction (only above-threshold items listed)."""
    rows_out, seq, phase, skipped = [], 0, "", []
    base = blank_row(tid, page, "", nominal)
    freq_tbl = tid in ("2.3", "2.4")
    for (i, y0, y1, cells) in data_rows(tb):
        texts = [cell_text(page, c) for c in cells]
        if len(texts) < 2 or texts[0].startswith("Flight"):
            skipped.append(" ".join(texts))
            continue
        flags = []
        if texts[0]:
            phase = texts[0]
        else:
            flags.append("phase-carried")
        body, cond = split_condition(texts[1])
        og = infer_obj_group(body)
        if og:
            flags.append("obj_group-inferred-from-text")
        seq += 1
        rows_out.append(dict(
            base, row_type="interaction", phase=phase, seq=seq, interaction_id=f"{tid}#{seq:02d}",
            subj_group="FD", obj_group=og, interaction=body, condition=cond, text_as_printed=texts[1],
            freq=">2 of 4 (listed only if above threshold)" if freq_tbl else "",
            crit="" if freq_tbl else ">2.5 of 3 (listed only if above threshold)",
            rating_source=PILOT_SRC, extraction_flags="; ".join(flags)))
    return rows_out, skipped


def parse_foc_rated(page, tb, tid, nominal, groups):
    """Tables 2.9 / 2.10: Phase | interaction | criticality | frequency (blank = below threshold)."""
    rows_out, seq, phase, obj, skipped = [], 0, "", "", []
    base = blank_row(tid, page, "", nominal)
    for (i, y0, y1, cells) in data_rows(tb):
        texts = [cell_text(page, c) for c in cells]
        joined = " ".join(texts)
        if texts and texts[0].startswith("Flight"):
            skipped.append(" ".join(texts))
            continue
        real = [t for t in texts if t]
        if len(real) == 1 and re.search(r"Interactions with (Flightdeck|ATC)", real[0]):
            obj = "FD" if "Flightdeck" in real[0] else "ATC"
            base = dict(base, context=real[0])
            rows_out.append(dict(base, row_type="header", interaction=real[0], obj_group=obj,
                                 subj_group="FOC"))
            continue
        # data row: use the 4 named columns by x-range
        px0, tx0, cx0, fx0 = 72, 126, 405, 482
        ph = words_in(page, px0, y0 + 0.5, tx0, y1 - 0.5)
        tx = words_in(page, tx0, y0 + 0.5, cx0, y1 - 0.5)
        cr = words_in(page, cx0, y0 + 0.5, fx0, y1 - 0.5)
        fr = words_in(page, fx0, y0 + 0.5, 549, y1 - 0.5)
        if not tx:
            continue
        flags = []
        if ph:
            phase = ph
        else:
            flags.append("phase-carried")
        if not cr:
            flags.append("crit-below-threshold-or-blank")
        if not fr:
            flags.append("freq-below-threshold-or-blank")
        seq += 1
        rows_out.append(dict(
            base, row_type="interaction", phase=phase, seq=seq, interaction_id=f"{tid}#{seq:02d}",
            subj_group="FOC", obj_group=obj, interaction=tx, text_as_printed=tx, crit=cr, freq=fr,
            rating_source=DISP_SRC, extraction_flags="; ".join(flags)))
    return rows_out, skipped


def parse_atc_hier(page, tb, tid, nominal, groups):
    """Tables 2.7, 2.8, C-1..C-3: bold/italic headers, item rows, optional position column."""
    rows_out, seq = [], 0
    h1 = h2 = ""
    base = blank_row(tid, page, "", nominal)
    has_pos = tid.startswith("C-")
    skipped = []
    for (i, y0, y1, cells) in data_rows(tb):
        texts = [cell_text(page, c) for c in cells]
        if not any(texts):
            continue
        ne = [(c, t) for c, t in zip(cells, texts) if t]
        first, txt = max(ne, key=lambda a: a[0][2] - a[0][0]) if len(ne) > 1 and not has_pos else ne[0]
        bold, ital, _, _ = span_style(page, first)
        pos = ""
        # position column (C tables): cell right of the text cell
        if has_pos and len(cells) >= 2:
            pos = texts[-1] if texts[-1] != txt else ""
            if pos == "Controller position":
                skipped.append(pos)
                pos = ""
        if bold and not ital:  # bold = level-1 header; bold+italic (flags 18) = level-2 sub-header
            if txt.startswith("Table ") or txt in (".",):
                skipped.append(" ".join(texts))
                continue
            if txt.startswith("Interactions under"):
                skipped.append(txt)
                base = dict(base, condition_nominal="nominal" if "Nominal" in txt and "Off" not in txt else "off-nominal")
                continue
            h1, h2 = txt, ""
            rows_out.append(dict(base, row_type="header", context=h1, interaction=txt))
            continue
        if ital:
            h2 = txt
            rows_out.append(dict(base, row_type="header", context=f"{h1} | {h2}".strip(" |"), interaction=txt))
            continue
        if not txt:
            continue
        ctx = f"{h1} | {h2}".strip(" |")
        obj = ""
        tl = ctx.lower()
        if "flightdeck or foc" in tl:
            obj = "FD/FOC"
        elif "flightdeck" in tl:
            obj = "FD"
        elif "foc" in tl:
            obj = "FOC"
        elif "within atc" in tl or tid == "C-2":
            obj = "ATC"
        flags = []
        if not obj:
            tx = txt.lower()
            if "pilot" in tx or "flightdeck" in tx:
                obj = "FD"
            elif "dispatch" in tx or "foc" in tx:
                obj = "FOC"
            elif re.search(r"sector|controller|facilit|flow control|tmu|supervisor|tower|tracon|flight strip|datablock|handoff", tx):
                obj = "ATC"
            flags.append("obj_group-inferred-from-text" if obj else "obj_group-not-stated")
        seq += 1
        rows_out.append(dict(
            base, row_type="interaction", context=ctx, seq=seq, interaction_id=f"{tid}#{seq:02d}",
            subj_group="ATC", subj_position=h2.replace("By ", "").strip() if h2.startswith("By ") else "",
            obj_group=obj, interaction=txt, text_as_printed=txt, controller_positions=pos,
            extraction_flags="; ".join(flags)))
    return rows_out, skipped


def parse_survey(page, tb, tid, nominal, groups):
    """Appendix A / D survey instruments: item text only (rating cells are blank forms)."""
    rows_out, seq, phase, skipped = [], 0, "", []
    base = blank_row(tid, page, "", nominal)
    if tid == "D-4":  # blank write-in form ("With aircraft/pilot ____"): no source content to extract
        return [], [" ".join(cell_text(page, c) for c in cells) for (_, _, _, cells) in data_rows(tb)]
    for (i, y0, y1, cells) in data_rows(tb):
        texts = [cell_text(page, c) for c in cells]
        real = [t for t in texts if t]
        if not real or any(t.startswith(("Flight Phase", "Table ", "Description")) for t in texts):
            skipped.append(" ".join(texts))
            continue
        if tid.startswith("A."):  # phase + item share one cell: "Preflight  Call dispatch..."
            m = re.match(r"^(Preflight|Taxi/takeoff|Taxi|Takeoff|Inflight|In-flight|Approach|Landing)\s+(.*)$", texts[0])
            ph, item = (m.group(1), m.group(2)) if m else ("", texts[0])
        else:
            ph = texts[0] if len(texts) > 1 and re.match(r"^(Preflight|Taxi|Inflight|Approach|Landing)", texts[0]) else ""
            item = next((t for t in texts[1:] if t and t not in ("VL L M H", "L M H")), "")
            if not ph and not item:
                item = texts[0]
        if re.fullmatch(r"(VL\s*L\s*M\s*H|L\s*M\s*H)?", item or ""):
            skipped.append(" ".join(texts))
            continue
        skipped.extend(t for t in texts if re.fullmatch(r"(VL\s*L\s*M\s*H|L\s*M\s*H)", t))
        if not item.strip():
            skipped.append(" ".join(texts))
            continue
        flags = []
        if ph:
            phase = ph
        else:
            flags.append("phase-carried")
        body, cond = split_condition(item)
        seq += 1
        rows_out.append(dict(
            base, row_type="interaction", phase=phase, seq=seq, interaction_id=f"{tid}#{seq:02d}",
            subj_group=groups[0], obj_group=groups[1] or infer_obj_group(body), interaction=body,
            condition=cond, text_as_printed=item, rating_source="survey instrument item (rating cells blank)",
            extraction_flags="; ".join(flags)))
    return rows_out, skipped


# Table 3.1 (report p.47, PDF p.49) has overlapping row geometry (media/group cells vertically
# centred on 1-2 line area cells), so find_tables() cannot separate its rows. It is transcribed
# here from the word-position dump of that page; the coverage check in --verify still applies
# and every row carries a flag asking for a visual check.
# (section, off-nominal event, media as printed, groups as printed, area of interaction)
TABLE31 = [
    ("Flight Planning", "", "Telcon", "FOC & ATC", "Traffic routes & delays"),
    ("Flight Planning", "", "Telephone", "Flightdeck & FOC", "Flight plan modifications"),
    ("Pilots in the flightdeck", "", "Radio", "Flightdeck & ATC", "EDCT modification (when applicable)"),
    ("Taxi-out", "", "Radio", "Flightdeck & ATC", "De-icing (off-nominal)"),
    ("Taxi-out", "", "Face-to-Face", "GC & LC (ATC)", "Runway crossing"),
    ("Cruise", "", "Telephone", "R/RA & R/RA (ATC)", "Control instructions before flight enters in a new sector (when applicable)"),
    ("Cruise", "", "Radio", "Flightdeck & ATC", "Fly direct to fix point (when applicable)"),
    ("Cruise", "", "Radio", "Flightdeck & ATC", "Other deviations to Flight plans (when applicable)"),
    ("Cruise", "", "Satcom / ACARS", "Flightdeck & FOC", "Rerouting flight"),
    ("Cruise", "Off-Nominal: CC decision to reroute traffic due to weather", "Relephone", "TMU at CC & En route & APP & LC (ATC)", "Diversion of traffic due to RWY closure"),
    ("Cruise", "Off-Nominal: CC decision to reroute traffic due to weather", "Telcon", "FOC & ATC", "Strategy for rerouting flights"),
    ("Cruise", "Off-Nominal: CC decision to reroute traffic due to weather", "Satcom / ACARS", "Flightdeck & FOC", "Rerouting flight"),
    ("Cruise", "Off-Nominal: Holding", "Telephone", "APP & En route (ATC)", "Holding flights"),
    ("Cruise", "Off-Nominal: Holding", "Satcom / ACARS", "FOC & Flightdeck", "Minimum fuel and alternate destination (if applicable)"),
    ("Cruise", "Off-Nominal: Holding", "Radio", "Flightdeck & ATC", "Alternate destination"),
    ("Cruise", "Off-Nominal: Holding", "Telephone", "FOC & ATC", "Alternate destination (optional)"),
    ("Descent", "", "Radio", "Flightdeck & ATC", "Alternative approach (if applicable)"),
    ("Final Approach", "Off-Nominal: Missed approach", "Telephone", "LC & DEP (ATC)", "Coordinate go around (altitude, heading, speed)"),
    ("Final Approach", "Off-Nominal: Missed approach", "Telephone", "DEP & APP (ATC)", "Merging 'go-around' flight back into the approach flow"),
]


def parse_table31(page, tb, tid, nominal, groups):
    rows_out = []
    base = blank_row(tid, page, "Current Possible Collaborative Interactions", "mixed")
    for seq, (sec, off, media, grp, area) in enumerate(TABLE31, start=1):
        sub = ""
        if sec == "Pilots in the flightdeck":  # grey sub-step header under Flight Planning
            sec, sub = "Flight Planning", "Pilots in the flightdeck"
        flags = ["hand-transcribed from PDF p.49 word positions; verify visually"]
        m = media
        if media == "Relephone":
            m = "Telephone"
            flags.append("source-typo: printed as 'Relephone'")
        body, cond = split_condition(area)
        rows_out.append(dict(
            base, row_type="interaction", phase=sec, sub_step=sub, off_nominal_event=off, seq=seq,
            interaction_id=f"{tid}#{seq:02d}", media=m, context=grp, interaction=body,
            condition=cond, text_as_printed=area, condition_nominal="off-nominal" if off else "nominal",
            extraction_flags="; ".join(flags)))
    # column headers / section headers count as covered boilerplate for the coverage check
    skipped = ["Media Groups Area of Interaction", "Flight Planning", "Pilots in the flightdeck",
               "Taxi-out", "Cruise", "Off-Nominal: CC decision to reroute traffic due to weather",
               "Off-Nominal: Holding", "Descent", "Final Approach", "Off-Nominal: Missed approach",
               "Relephone"]  # printed typo for "Telephone", normalized in the media column
    return rows_out, skipped


# ---------------------------------------------------------------- driver
def caption_for(page, tb):
    cap = []
    for (i, y0, y1, cells) in data_rows(tb)[:3]:
        t = cell_text(page, cells[0])
        if t.startswith("Table "):
            cap.append(t)
    return cap[0] if cap else ""


def caption_from_text(page, tid):
    """Caption line printed above tables 2.x / 3.1 / A / D (outside the table geometry)."""
    for ln in page.get_text().splitlines():
        t = " ".join(ln.split())
        if re.match(rf"^Table {re.escape(tid)}[:.]\s", t):
            return t
    return ""


def extract_all(doc):
    all_rows, coverage = [], []
    for tid, pn, ti, fam, nominal, groups in REGISTRY:
        page = doc[pn - 1]
        tb = page.find_tables().tables[ti]
        skipped = []
        if fam == "matrix":
            rows, skipped = parse_matrix(page, tb, tid, nominal)
        elif fam == "fd_list":
            rows, skipped = parse_fd_list(page, tb, tid, nominal, groups)
        elif fam == "pilot_rated":
            rows, skipped = parse_pilot_rated(page, tb, tid, nominal, groups)
        elif fam == "foc_rated":
            rows, skipped = parse_foc_rated(page, tb, tid, nominal, groups)
        elif fam == "atc_hier":
            rows, skipped = parse_atc_hier(page, tb, tid, nominal, groups)
        elif fam == "survey":
            rows, skipped = parse_survey(page, tb, tid, nominal, groups)
        else:
            rows, skipped = parse_table31(page, tb, tid, nominal, groups)
        cap = caption_for(page, tb) or caption_from_text(page, tid)
        for r in rows:
            if not r["table_title"]:
                r["table_title"] = cap
        all_rows.extend(rows)
        # coverage: page words inside the table bbox vs tokens emitted for this table
        page_words = " ".join(w[4] for w in page.get_text("words", clip=pymupdf.Rect(tb.bbox))).replace("–", "-")
        page_tok = Counter(re.sub(r"(?<=\w)-\s+(?=\w)", "-", page_words).split())  # same de-wrapping as norm_media
        page_tok.pop("…", None)  # gap-marker glyphs are recorded once per gap row, not per cell
        emit = Counter()
        for r in rows:
            for k in FIELDS:
                if k in ("interaction_id", "table_id", "row_type", "pdf_page", "report_page", "seq",
                         "extraction_flags", "condition_nominal", "rating_source", "table_title"):
                    continue
                if k == "interaction" and r.get("text_as_printed") and k != "text_as_printed":
                    pass
                emit.update(str(r[k]).split())
            # rated-table threshold words, caption words and skipped rows count as covered
        for s in skipped:
            emit.update(s.split())
        coverage.append((tid, pn, len(rows), page_tok, emit))
    return all_rows, coverage


def apply_bb_rules(rows):
    if not BB_RULES.exists():
        return
    rules = list(csv.DictReader(BB_RULES.open(encoding="utf-8", newline="")))
    for r in rows:
        if r["row_type"] != "interaction":
            continue
        # only rows in which ATC is a party can be governed by JO 7110.65 (FD and FOC rows cannot)
        if not ("ATC" in r["subj_group"] or "ATC" in r["obj_group"]):
            continue
        # flight-crew / FOC-initiated procedure lists (AFM, survey items) are outside JO 7110.65;
        # in the Appendix E matrix a pilot request to ATC is paired with an ATC service, so rules apply there
        if r["subj_group"] != "ATC" and not r["table_id"].startswith("E-"):
            r["bb_paragraph"] = "n/a (flight-crew or FOC procedure; outside JO 7110.65)"
            continue
        text = f'{r["interaction"]} {r["condition"]}'
        hits = []
        for rule in rules:
            if re.search(rule["pattern"], text, re.I):
                hits.extend(p.strip() for p in rule["bb_paragraph"].split(";"))
        r["bb_paragraph"] = "; ".join(dict.fromkeys(hits)) if hits else "no rule matched"


def write_csv(rows):
    with CSV_OUT.open("w", encoding="utf-8", newline="") as f:
        w = csv.DictWriter(f, fieldnames=FIELDS, lineterminator="\n")
        w.writeheader()
        w.writerows(rows)


def md_escape(s):
    return str(s).replace("|", "\\|")


def write_md(rows):
    by_table = {}
    for r in rows:
        by_table.setdefault(r["table_id"], []).append(r)
    n_int = sum(1 for r in rows if r["row_type"] == "interaction")
    out = [
        "# Seamster et al. (2011) — extracted interaction tables\n",
        "_Generated by `tools/extract_seamster_interactions.py` from "
        "`evidence/sources/Collaborative Systems Assessment - ….pdf`. Do not hand-edit: re-run the script. "
        "The machine-readable twin is `seamster2011collabSystems-interactions.csv` (same rows, more columns). "
        "Interpretation lives in [[seamster2011collabSystems]] (annotation) and "
        "[[interaction-catalog-flight-execution]] (project-vocabulary synthesis)._\n",
        f"**{n_int} interaction rows** across {len(by_table)} tables. Caveats that apply to every row: draft report (Aug 2011); "
        "the Appendix E matrix is one constructed SFO→JFK flight (FlightAware logs + LiveATC monitoring); ATC content comes from 3 "
        "retired-controller SMEs; pilot ratings n=11 (one operator), dispatcher ratings n=4 (one domestic operator); rated tables "
        "list only items above threshold; the report cites JO 7110.65**T** (2010), not BB. Interaction IDs (`E-7#04`) are stable "
        "for a given script version and are how other notes cite rows.\n",
    ]
    for tid, trs in by_table.items():
        first = trs[0]
        out.append(f"\n## Table {tid} — {first['table_title']}\n")
        out.append(f"_PDF p.{first['pdf_page']} ({first['report_page']})_\n")
        fam = next(f for t, _, _, f, _, _ in REGISTRY if t == tid)
        if fam == "matrix":
            out.append("| ID | Media | Subject (group · position) | Interacting with (group · position) | Interaction | Condition | BB ¶ | Flags |")
            out.append("|---|---|---|---|---|---|---|---|")
        elif fam in ("atc_hier",):
            out.append("| ID | Context | Interaction | Controller positions | BB ¶ | Flags |")
            out.append("|---|---|---|---|---|---|")
        elif fam in ("foc_rated", "pilot_rated"):
            out.append("| ID | Phase | Interaction | Condition | Crit | Freq | BB ¶ | Flags |")
            out.append("|---|---|---|---|---|---|---|---|")
        elif fam == "table31":
            out.append("| ID | Section | Media | Groups | Area of interaction | Flags |")
            out.append("|---|---|---|---|---|---|")
        else:
            out.append("| ID | Phase | Interaction | Condition | BB ¶ | Flags |")
            out.append("|---|---|---|---|---|---|")
        for r in trs:
            rt = r["row_type"]
            if rt == "gap":
                out.append("| | _… (indeterminate lapse of time)_ | | | | | | |" if fam == "matrix" else "")
                continue
            if rt == "header":
                out.append(f"| | **{md_escape(r['interaction'])}** _({md_escape(r['context'] if r['context'] in ('phase','sub-step','off-nominal event') else 'header')})_ |" + " |" * (7 if fam == "matrix" else 4))
                continue
            f = md_escape(r["extraction_flags"])
            if fam == "matrix":
                out.append(f"| {r['interaction_id']} | {md_escape(r['media'])} | {md_escape(r['subj_group'])} · {md_escape(r['subj_position'])} | "
                           f"{md_escape(r['obj_group'])} · {md_escape(r['obj_position'])} | {md_escape(r['interaction'])} | {md_escape(r['condition'])} | "
                           f"{md_escape(r['bb_paragraph'])} | {f} |")
            elif fam == "atc_hier":
                out.append(f"| {r['interaction_id']} | {md_escape(r['context'])} | {md_escape(r['interaction'])} | {md_escape(r['controller_positions'])} | {md_escape(r['bb_paragraph'])} | {f} |")
            elif fam in ("foc_rated", "pilot_rated"):
                out.append(f"| {r['interaction_id']} | {md_escape(r['phase'])} | {md_escape(r['interaction'])} | {md_escape(r['condition'])} | "
                           f"{md_escape(r['crit'])} | {md_escape(r['freq'])} | {md_escape(r['bb_paragraph'])} | {f} |")
            elif fam == "table31":
                out.append(f"| {r['interaction_id']} | {md_escape(r['phase'] or r['off_nominal_event'])} | {md_escape(r['media'])} | {md_escape(r['context'])} | {md_escape(r['interaction'])} | {f} |")
            else:
                out.append(f"| {r['interaction_id']} | {md_escape(r['phase'])} | {md_escape(r['interaction'])} | {md_escape(r['condition'])} | {md_escape(r['bb_paragraph'])} | {f} |")
    MD_OUT.write_text("\n".join(o for o in out if o is not None) + "\n", encoding="utf-8")


def verify(coverage, rows):
    print(f"{'table':6} {'pg':>4} {'rows':>5} {'page-tokens':>11} {'covered':>8}  missing (first 12)")
    tot_p = tot_c = 0
    for tid, pn, n, page_tok, emit in coverage:
        missing = page_tok - emit
        p = sum(page_tok.values())
        c = p - sum(missing.values())
        tot_p += p
        tot_c += c
        print(f"{tid:6} {pn:>4} {n:>5} {p:>11} {100 * c / max(p, 1):>7.1f}%  {dict(list(missing.items())[:12])}")
    print(f"TOTAL tokens {tot_p}, covered {tot_c} ({100 * tot_c / tot_p:.2f}%)")
    e = [r for r in rows if r["table_id"].startswith("E-") and r["row_type"] == "interaction"]
    print(f"Appendix E interaction rows: {len(e)} (report says 'a little over 300 entries')")
    print("rows by type:", dict(Counter(r["row_type"] for r in rows)))
    flags = Counter(f for r in rows for f in r["extraction_flags"].split("; ") if f)
    print("flags:", dict(flags))


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("--verify", action="store_true", help="print token-coverage report")
    args = ap.parse_args()
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    doc = pymupdf.open(PDF)
    rows, coverage = extract_all(doc)
    apply_bb_rules(rows)
    OUT_DIR.mkdir(parents=True, exist_ok=True)
    write_csv(rows)
    write_md(rows)
    print(f"wrote {CSV_OUT.relative_to(REPO)} and {MD_OUT.relative_to(REPO)} "
          f"({sum(1 for r in rows if r['row_type'] == 'interaction')} interaction rows)")
    if args.verify:
        verify(coverage, rows)


if __name__ == "__main__":
    main()
