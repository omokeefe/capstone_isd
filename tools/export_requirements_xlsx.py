"""Export the requirements in cameo_models/ to an Excel workbook for review.

Reads the three requirement files of the SysML v2 model (the source of truth, D-006):

    requirements_stakeholders.sysml        stakeholder requirements (SN-*)
    requirements_nas_system.sysml          system requirements (SLR-*) and their allocation
    requirements_constituent_systems.sysml constituent system requirements (HLR-*) and theirs

and writes a workbook whose first sheet is the decomposition: stakeholder requirement on
the left, the system requirements that answer it in the middle, and the HLRs that come
from each system requirement on the right. One sheet per tier follows with every
attribute. The workbook is a derived copy for reading and marking up; changes go back
into the .sysml files.

Usage (from the repo root):
    .venv/Scripts/python.exe tools/export_requirements_xlsx.py [--out PATH]

Needs openpyxl. The parser is a plain-text reader of the attribute style these three
files use (`:>> name = value;` on one line, the requirement text as its doc comment),
not a SysML parser; run `syside check` for validity.
"""

from __future__ import annotations

import argparse
import datetime as dt
import re
import subprocess
from pathlib import Path

from openpyxl import Workbook
from openpyxl.styles import Alignment, Border, Font, PatternFill, Side
from openpyxl.utils import get_column_letter

REPO = Path(__file__).resolve().parent.parent
MODEL = REPO / "projects" / "nas-sos-capstone" / "cameo_models"
DEFAULT_OUT = MODEL / "print" / "requirements-review.xlsx"
ONTOLOGY = REPO / "knowledge" / "models" / "stakeholder-objective-ontology.md"

FILES = {
    "SN": MODEL / "requirements_stakeholders.sysml",
    "SLR": MODEL / "requirements_nas_system.sysml",
    "HLR": MODEL / "requirements_constituent_systems.sysml",
}

REQ_RE = re.compile(r"^(?P<ind>[ \t]*)requirement <'(?P<id>[^']+)'> (?P<name>\w+) : (?P<type>\w+) \{", re.M)
PKG_RE = re.compile(r"^[ \t]*package (?P<name>\w+) \{\s*\n[ \t]*doc /\*(?P<doc>.*?)\*/", re.M | re.S)
ATTR_RE = re.compile(r"^[ \t]*:>> (?P<name>\w+) = (?P<value>.*)$")
SATISFY_RE = re.compile(r"satisfy requirement \w+ :> (?P<req>[\w:]+) by (?P<part>[\w.]+);")
TOKEN_RE = re.compile(r'"((?:[^"\\]|\\.)*)"|([A-Za-z_][\w:]*(?:\.\d+)?|\d+(?:\.\d+)?)')

# Readable names for the parts named in the Allocation packages (the same names the
# readable copy, knowledge/models/requirements-and-traceability.md, uses).
PART_NAMES = {
    "flightOperations.airlineOperationsCenter": "Airline operations center",
    "flightOperations.airlineOperationsCenter.dispatcher": "Dispatcher",
    "flightOperations.airlineOperationsCenter.loadPlanner": "Load planner",
    "flightOperations.airlineOperationsCenter.decisionSupport": "AOC decision support",
    "flightCrew.flightDeckCrew": "Flight deck crew",
    "airspaceManagement.atc": "Air traffic control",
    "airspaceManagement.atc.decisionSupport": "ATC decision support",
    "airspaceManagement.artcc": "En-route center (ARTCC)",
    "airspaceManagement.tracon": "Terminal approach control (TRACON)",
    "airspaceManagement.atcscc": "Command Center (ATCSCC)",
    "aircraftSystems.aircraft.avionics.communicationSystem": "Aircraft communication system",
    "aircraftSystems.aircraft.avionics.flightManagementSystem": "Flight management system",
    "aircraftSystems.aircraft.avionics.autoFlightControlSystem": "Auto flight control system",
    "airportOperations.airport.groundHandling": "Ground handling",
    "airportOperations.airport.fuelDistributionSystem": "Fuel distribution system",
    "airportOperations.airport.airportManagementSystem": "Airport management system",
    "airportOperations.airport.controlTower": "Control tower",
    "flightOperations.airlineOperationsCenter.atcCoordinator": "AOC ATC coordinator",
    "flightOperations.airlineOperationsCenter.crewScheduler": "Crew scheduler",
    "aircraftSystems.aircraft.avionics.surveillanceSystem": "Aircraft surveillance system",
    "aircraftSystems.aircraft.flightDeckControls": "Flight deck controls",
}

# Display order of the stakeholder groups on the Decomposition sheet.
GROUP_NAMES = {
    "operators": "Airline",
    "airTrafficControl": "Air traffic control",
    "flightCrews": "Flight crew",
    "governmentsAndStandardsOrganizations": "Regulator",
    "environmentalAndSocietalOrganizations": "Communities and environment",
    "airportAuthority": "Airport operator",
    "passengers": "Passengers",
    "military": "Military airspace users",
}

SCOPE_TAGS = {"outOfStudy": "OUT OF STUDY", "background": "BACKGROUND"}

ENUM_WORDS = {
    "byInspection": "Inspection", "byAnalysis": "Analysis",
    "byDemonstration": "Demonstration", "byTest": "Test",
    "functional": "Functional", "performance": "Performance",
    "interfaceRequirement": "Interface", "designConstraint": "Constraint",
    "qualityAttribute": "Quality attribute",
    "normativeSource": "[A]", "literature": "[B]", "ownerExpertise": "[SME]",
    "generalKnowledge": "[C]",
    "ruleOfThumb": "rule of thumb (A)", "lowFidelityModel": "low-fidelity model (B)",
    "highFidelityModel": "high-fidelity model (C)",
    "highFidelityModelWithConnections": "high-fidelity model plus connections (D)",
}


def clean_doc(raw: str) -> str:
    lines = [re.sub(r"^\s*\*?\s?", "", ln).rstrip() for ln in raw.strip().splitlines()]
    return re.sub(r"\s+", " ", " ".join(ln for ln in lines if ln)).strip()


def parse_value(raw: str) -> list[str]:
    """Values of one attribute line: quoted strings, or the last segment of a name."""
    out = []
    for m in TOKEN_RE.finditer(raw):
        if m.group(1) is not None:
            out.append(m.group(1).replace('\\"', '"'))
        elif m.group(2) == "//":
            break
        else:
            out.append(m.group(2).split("::")[-1])
    return out


def strip_line_comment(raw: str) -> str:
    """Drop a trailing // comment that sits outside any string."""
    in_str = False
    for i, ch in enumerate(raw):
        if ch == '"' and (i == 0 or raw[i - 1] != "\\"):
            in_str = not in_str
        elif not in_str and raw.startswith("//", i):
            return raw[:i]
    return raw


def parse_requirements(path: Path, tier: str) -> list[dict]:
    text = path.read_text(encoding="utf-8")
    pkgs = [(m.start(), m.group("name"), clean_doc(m.group("doc"))) for m in PKG_RE.finditer(text)]
    reqs = []
    for m in REQ_RE.finditer(text):
        end = text.index("\n" + m.group("ind") + "}", m.end())
        body = text[m.end():end]
        doc = re.search(r"doc /\*(.*?)\*/", body, re.S)
        req = {"tier": tier, "id": m.group("id"), "name": m.group("name"),
               "text": clean_doc(doc.group(1)) if doc else "", "attrs": {}}
        for line in body.splitlines():
            a = ATTR_RE.match(line)
            if a:
                val = strip_line_comment(a.group("value")).rstrip().rstrip(";")
                req["attrs"][a.group("name")] = parse_value(val)
        owner = [p for p in pkgs if p[0] < m.start()]
        req["package"], req["package_doc"] = (owner[-1][1], owner[-1][2]) if owner else ("", "")
        reqs.append(req)
    allocation: dict[str, list[str]] = {}
    for s in SATISFY_RE.finditer(text):
        name = s.group("req").split("::")[-1]
        allocation.setdefault(name, []).append(PART_NAMES.get(s.group("part"), s.group("part")))
    for r in reqs:
        r["allocated"] = allocation.get(r["name"], [])
    return reqs


def parse_objective_rows() -> list[tuple[str, str, str]]:
    """(category, objective, trajectory impact) for each row of the ontology's tables."""
    rows, cat = [], None
    for line in ONTOLOGY.read_text(encoding="utf-8").splitlines():
        if line.startswith("## "):
            cat = line[3:].strip()
        elif line.startswith("| ") and not line.startswith(("| Objective", "|---")) and cat and not cat.startswith(("How", "Synthesis", "Status")):
            cells = [c.strip() for c in line.strip("|").split("|")]
            if len(cells) >= 5:
                rows.append((cat, cells[0], re.sub(r"\*+", "", cells[4]).split(" ")[0].rstrip(",;")))
    return rows


def words(values: list[str]) -> str:
    return "; ".join(ENUM_WORDS.get(v, v) for v in values)


def one(req: dict, key: str, default: str = "") -> str:
    v = req["attrs"].get(key)
    return words(v) if v else default


def measure(req: dict) -> str:
    mop = one(req, "measureOfPerformance")
    if not mop:
        return ""
    unit = one(req, "unitOfMeasure")
    s = f"{mop} ({unit})" if unit else mop
    thr = one(req, "thresholdValue")
    return f"{s}. Value: {float(thr):g}" if thr else s


# ---------------------------------------------------------------- workbook styling

THIN = Side(style="thin", color="B7B7B7")
BORDER = Border(left=THIN, right=THIN, top=THIN, bottom=THIN)
WRAP_TOP = Alignment(wrap_text=True, vertical="top")
HEAD_FONT = Font(bold=True, color="FFFFFF")
TIER_FILL = {
    "SN": PatternFill("solid", fgColor="1F4E79"),
    "SLR": PatternFill("solid", fgColor="375623"),
    "HLR": PatternFill("solid", fgColor="7F6000"),
    "note": PatternFill("solid", fgColor="595959"),
}
TIER_TINT = {
    "SN": PatternFill("solid", fgColor="DDEBF7"),
    "SLR": PatternFill("solid", fgColor="E2EFDA"),
    "HLR": PatternFill("solid", fgColor="FFF2CC"),
}
IMPROVED_FILL = PatternFill("solid", fgColor="F8CBAD")
GROUP_FILL = PatternFill("solid", fgColor="D9D9D9")
OUT_FILL = PatternFill("solid", fgColor="EDEDED")
BACKGROUND_FILL = PatternFill("solid", fgColor="E4DFEC")
GREY = "7F7F7F"


def header(ws, row: int, cols: list[tuple[str, str, int]]) -> None:
    for c, (title, tier, width) in enumerate(cols, start=1):
        cell = ws.cell(row=row, column=c, value=title)
        cell.font, cell.fill, cell.alignment, cell.border = HEAD_FONT, TIER_FILL[tier], WRAP_TOP, BORDER
        ws.column_dimensions[get_column_letter(c)].width = width
    ws.freeze_panes = ws.cell(row=row + 1, column=1)


def put(ws, row: int, col: int, value, fill=None, bold=False, italic=False, color=None):
    cell = ws.cell(row=row, column=col, value=value)
    cell.alignment, cell.border = WRAP_TOP, BORDER
    if fill:
        cell.fill = fill
    if bold or italic or color:
        cell.font = Font(bold=bold, italic=italic, color=color)
    return cell


def scope(req: dict) -> str:
    return one(req, "studyScope", "inStudy")


def fill_for(req: dict, tint):
    """Cell fill for a requirement: out of study and background override improved and the tier tint."""
    s = scope(req)
    if s == "outOfStudy":
        return OUT_FILL
    if s == "background":
        return BACKGROUND_FILL
    return IMPROVED_FILL if one(req, "architectureState") == "improved" else tint


def label(req: dict) -> str:
    """Requirement text with its goal / improved markers, for the decomposition sheet."""
    tags = [SCOPE_TAGS[scope(req)]] if scope(req) in SCOPE_TAGS else []
    if one(req, "obligation") == "goal":
        tags.append("GOAL")
    if one(req, "architectureState") == "improved":
        tags.append("IMPROVED")
    return (f"[{', '.join(tags)}] " if tags else "") + req["text"]


def build(out: Path) -> dict:
    sn = parse_requirements(FILES["SN"], "SN")
    slr = parse_requirements(FILES["SLR"], "SLR")
    hlr = parse_requirements(FILES["HLR"], "HLR")
    by_name = {r["name"]: r for r in sn + slr + hlr}
    by_id = {r["id"]: r for r in sn + slr + hlr}
    groups = list(GROUP_NAMES)
    sn.sort(key=lambda r: (groups.index(one(r, "stakeholderGroup")) if one(r, "stakeholderGroup") in groups else 99, r["id"]))
    areas = list(dict.fromkeys(r["package"] for r in slr))
    slr.sort(key=lambda r: (areas.index(r["package"]), r["id"]))

    slr_parents = {r["id"]: [by_name[n]["id"] for n in r["attrs"].get("parentNeeds", [])] for r in slr}
    hlr_parents = {r["id"]: [by_name[n]["id"] for n in r["attrs"].get("parentRequirements", [])] for r in hlr}
    slr_under = {s["id"]: [r for r in slr if s["id"] in slr_parents[r["id"]]] for s in sn}
    hlr_under = {s["id"]: [r for r in hlr if s["id"] in hlr_parents[r["id"]]] for s in slr}

    wb = Workbook()

    # ---- Sheet 1: decomposition
    ws = wb.active
    ws.title = "Decomposition"
    header(ws, 1, [
        ("SN ID", "SN", 11), ("Stakeholder requirement", "SN", 48),
        ("SLR ID", "SLR", 12), ("System requirement (the NAS shall)", "SLR", 48),
        ("HLR ID", "HLR", 12), ("Sub-system HLR (constituent system shall)", "HLR", 52),
        ("Review notes", "note", 40),
    ])
    row = 2
    group = None
    for s in sn:
        g = GROUP_NAMES.get(one(s, "stakeholderGroup"), one(s, "stakeholderGroup"))
        if g != group:
            group = g
            for c in range(1, 8):
                put(ws, row, c, None, fill=GROUP_FILL)
            ws.cell(row=row, column=1, value=f"Stakeholder: {g}").font = Font(bold=True)
            row += 1
        sn_start = row
        for r in slr_under[s["id"]] or [None]:
            r_start = row
            kids = hlr_under[r["id"]] if r else []
            for h in kids or [None]:
                if h:
                    others = [p for p in hlr_parents[h["id"]] if p != r["id"]]
                    put(ws, row, 5, h["id"], fill=TIER_TINT["HLR"], bold=True)
                    txt = label(h)
                    if others:
                        txt += f"\n(also comes from {', '.join(others)})"
                    put(ws, row, 6, txt, fill=fill_for(h, TIER_TINT["HLR"]))
                else:
                    put(ws, row, 5, None)
                    if r is None:
                        put(ws, row, 6, None)
                    elif scope(r) == "inStudy":
                        put(ws, row, 6, "(no HLR: gap)", italic=True, bold=True, color="C00000")
                    else:
                        put(ws, row, 6, "(no HLR: not carried into the study)", italic=True, color=GREY)
                put(ws, row, 7, None)
                row += 1
            if r:
                others = [p for p in slr_parents[r["id"]] if p != s["id"]]
                txt = label(r) + (f"\n(also answers {', '.join(others)})" if others else "")
                put(ws, r_start, 3, r["id"], fill=TIER_TINT["SLR"], bold=True)
                put(ws, r_start, 4, txt, fill=fill_for(r, TIER_TINT["SLR"]), italic=one(r, "obligation") == "goal",
                    color=GREY if scope(r) == "outOfStudy" else None)
                if row - 1 > r_start:
                    ws.merge_cells(start_row=r_start, end_row=row - 1, start_column=3, end_column=3)
                    ws.merge_cells(start_row=r_start, end_row=row - 1, start_column=4, end_column=4)
        put(ws, sn_start, 1, s["id"], fill=TIER_TINT["SN"], bold=True)
        put(ws, sn_start, 2, label(s), fill=fill_for(s, TIER_TINT["SN"]), color=GREY if scope(s) == "outOfStudy" else None)
        if row - 1 > sn_start:
            ws.merge_cells(start_row=sn_start, end_row=row - 1, start_column=1, end_column=1)
            ws.merge_cells(start_row=sn_start, end_row=row - 1, start_column=2, end_column=2)
    ws.auto_filter.ref = f"A1:G{row - 1}"

    # ---- Sheets 2-4: one per tier, every attribute
    def tier_sheet(title, tier, reqs, cols):
        t = wb.create_sheet(title)
        header(t, 1, [(c[0], tier if c[0] != "Review notes" else "note", c[1]) for c in cols])
        for i, r in enumerate(reqs, start=2):
            for j, c in enumerate(cols, start=1):
                v = c[2](r) if c[2] else None
                fill = IMPROVED_FILL if (c[0] == "State" and v == "improved") else None
                if c[0] == "Scope":
                    fill = {"outOfStudy": OUT_FILL, "background": BACKGROUND_FILL}.get(v)
                put(t, i, j, v, fill=fill, bold=(j == 1))
        t.auto_filter.ref = f"A1:{get_column_letter(len(cols))}{len(reqs) + 1}"

    common_tail = [
        ("Scope", 11, scope),
        ("Status", 10, lambda r: one(r, "status")),
        ("Basis", 8, lambda r: one(r, "basis")),
        ("Evidence", 28, lambda r: one(r, "evidenceRefs")),
        ("Rationale (from the model)", 70, lambda r: one(r, "rationale")),
        ("Review notes", 40, None),
    ]
    tier_sheet("Stakeholder reqs", "SN", sn, [
        ("ID", 11, lambda r: r["id"]),
        ("Group", 16, lambda r: GROUP_NAMES.get(one(r, "stakeholderGroup"), one(r, "stakeholderGroup"))),
        ("Requirement", 55, lambda r: r["text"]),
        ("Objective rows", 30, lambda r: one(r, "objectiveRefs", "none")),
        ("Answered by", 22, lambda r: ", ".join(x["id"] for x in slr_under[r["id"]])),
    ] + common_tail)
    tier_sheet("System reqs", "SLR", slr, [
        ("ID", 12, lambda r: r["id"]),
        ("Area", 18, lambda r: r["package_doc"].split(".")[0]),
        ("Requirement", 55, lambda r: r["text"]),
        ("Kind", 12, lambda r: one(r, "kind") + (" (goal)" if one(r, "obligation") == "goal" else "")),
        ("State", 10, lambda r: one(r, "architectureState", "baseline")),
        ("Traces to", 18, lambda r: ", ".join(slr_parents[r["id"]])),
        ("Allocated to (accountable first)", 30, lambda r: "; ".join(r["allocated"])),
        ("HLRs under it", 22, lambda r: ", ".join(x["id"] for x in hlr_under[r["id"]])),
        ("Check", 14, lambda r: one(r, "verificationMethod")),
        ("Measure", 30, measure),
    ] + common_tail)
    tier_sheet("Sub-system HLRs", "HLR", hlr, [
        ("ID", 12, lambda r: r["id"]),
        ("Constituent system", 18, lambda r: one(r, "constituentSystem")),
        ("Requirement", 55, lambda r: r["text"]),
        ("Objective", 40, lambda r: one(r, "objectiveStatement")),
        ("Kind", 12, lambda r: one(r, "kind") + (" (goal)" if one(r, "obligation") == "goal" else "")),
        ("State", 10, lambda r: one(r, "architectureState", "baseline")),
        ("Comes from", 22, lambda r: ", ".join(hlr_parents[r["id"]])),
        ("Allocated to", 26, lambda r: "; ".join(r["allocated"])),
        ("Means", 34, lambda r: one(r, "candidateMeans") + (". Scored." if one(r, "meansScoredInExperiment") == "true" else "")),
        ("Check", 14, lambda r: one(r, "verificationMethod")),
        ("Measure", 30, measure),
    ] + common_tail)

    # ---- Sheet: objectives, read from the objective rows down
    ob = wb.create_sheet("Objectives", 1)
    header(ob, 1, [
        ("Category", "SN", 18), ("Objective row", "SN", 24), ("Trajectory impact", "SN", 12),
        ("Stakeholder requirements in the study", "SN", 30), ("Background / out of study", "SN", 30),
        ("In-study system requirements reached", "SLR", 34), ("HLRs reached", "HLR", 34),
        ("Review notes", "note", 40),
    ])
    refs: dict[str, list[dict]] = {}
    for s in sn:
        for o in s["attrs"].get("objectiveRefs", []):
            refs.setdefault(o, []).append(s)
    rows = parse_objective_rows()
    known = {f"{c}: {o}" for c, o, _ in rows}
    i = 2
    for c, o, impact in rows:
        needs = refs.get(f"{c}: {o}", [])
        inside = [s for s in needs if scope(s) == "inStudy"]
        outside = [s for s in needs if scope(s) != "inStudy"]
        reached = [r for r in slr if scope(r) == "inStudy" and any(s["id"] in slr_parents[r["id"]] for s in needs if scope(s) != "outOfStudy")]
        hl = [h for h in hlr if any(r["id"] in hlr_parents[h["id"]] for r in reached)]
        fill = None if inside else (OUT_FILL if outside else None)
        put(ob, i, 1, c, fill=fill)
        put(ob, i, 2, o, fill=fill, bold=bool(inside))
        put(ob, i, 3, impact, fill=fill)
        put(ob, i, 4, ", ".join(s["id"] for s in inside), fill=TIER_TINT["SN"] if inside else fill)
        put(ob, i, 5, ", ".join(f"{s['id']} ({SCOPE_TAGS[scope(s)].lower()})" for s in outside) or ("(no requirement)" if not inside else None),
            fill=fill, italic=not needs, color=GREY if not needs else None)
        put(ob, i, 6, ", ".join(r["id"] for r in reached), fill=TIER_TINT["SLR"] if reached else fill)
        put(ob, i, 7, ", ".join(h["id"] for h in hl), fill=TIER_TINT["HLR"] if hl else fill)
        put(ob, i, 8, None)
        i += 1
    for s in sn:
        if not s["attrs"].get("objectiveRefs"):
            put(ob, i, 1, GROUP_NAMES.get(one(s, "stakeholderGroup")), fill=GROUP_FILL)
            put(ob, i, 2, "(no objective row)", italic=True, fill=GROUP_FILL)
            put(ob, i, 3, None, fill=GROUP_FILL)
            put(ob, i, 4 if scope(s) == "inStudy" else 5, f"{s['id']} ({SCOPE_TAGS.get(scope(s), 'in study').lower()})", fill=GROUP_FILL)
            for col in (4, 5, 6, 7, 8):
                if ob.cell(row=i, column=col).value is None:
                    put(ob, i, col, None, fill=GROUP_FILL)
            i += 1
    unknown = sorted(k for k in refs if k not in known)
    if unknown:
        put(ob, i, 1, "objectiveRefs with no matching row", bold=True, color="C00000")
        put(ob, i, 2, "; ".join(unknown), color="C00000")
    ob.auto_filter.ref = f"A1:H{max(i - 1, 1)}"

    # ---- Sheet 5: coverage
    cv = wb.create_sheet("Coverage", 1)
    cv.column_dimensions["A"].width = 62
    cv.column_dimensions["B"].width = 10
    cv.column_dimensions["C"].width = 70
    header(cv, 1, [("Check", "note", 62), ("Count", "note", 10), ("Which", "note", 70)])
    in_slr = [r for r in slr if scope(r) == "inStudy"]
    checks = [
        ("Stakeholder requirements in the study", [s for s in sn if scope(s) == "inStudy"]),
        ("Stakeholder requirements tagged background", [s for s in sn if scope(s) == "background"]),
        ("Stakeholder requirements out of the study", [s for s in sn if scope(s) == "outOfStudy"]),
        ("System requirements in the study", in_slr),
        ("System requirements out of the study", [r for r in slr if scope(r) == "outOfStudy"]),
        ("Sub-system HLRs", hlr),
        ("GAP: stakeholder requirement with no system requirement", [s for s in sn if not slr_under[s["id"]]]),
        ("GAP: system requirement with no stakeholder parent", [r for r in slr if not slr_parents[r["id"]]]),
        ("GAP: system requirement in the study with no HLR", [r for r in in_slr if not hlr_under[r["id"]]]),
        ("GAP: system requirement with no allocation", [r for r in slr if not r["allocated"]]),
        ("GAP: HLR with no allocation", [h for h in hlr if not h["allocated"]]),
        ("CHECK: out-of-study system requirement that has an HLR", [r for r in slr if scope(r) == "outOfStudy" and hlr_under[r["id"]]]),
        ("CHECK: in-study system requirement whose only parents are out of study",
         [r for r in in_slr if all(scope(by_id[p]) == "outOfStudy" for p in slr_parents[r["id"]])]),
        ("CHECK: HLR reached only through out-of-study system requirements",
         [h for h in hlr if all(scope(by_id[p]) == "outOfStudy" for p in hlr_parents[h["id"]])]),
    ]
    for i, (name, items) in enumerate(checks, start=2):
        bad = name.startswith(("GAP", "CHECK")) and items
        put(cv, i, 1, name, bold=name.startswith(("GAP", "CHECK")))
        put(cv, i, 2, len(items), bold=bool(bad), color="C00000" if bad else None)
        put(cv, i, 3, ", ".join(x["id"] for x in items))

    # ---- Sheet 6: about
    a = wb.create_sheet("About")
    a.column_dimensions["A"].width = 110
    try:
        commit = subprocess.run(["git", "-C", str(REPO), "rev-parse", "--short", "HEAD"],
                                capture_output=True, text=True, check=True).stdout.strip()
    except (OSError, subprocess.CalledProcessError):
        commit = "unknown"
    lines = [
        ("Requirements review workbook", True),
        (f"Generated {dt.datetime.now():%Y-%m-%d %H:%M} from commit {commit} by tools/export_requirements_xlsx.py.", False),
        ("Source of truth: the .sysml files in projects/nas-sos-capstone/cameo_models/ (D-006). This workbook is a derived copy: mark it up, then apply the changes to the .sysml files and regenerate.", False),
        (f"Counts: {len(sn)} stakeholder requirements, {len(slr)} system requirements, {len(hlr)} sub-system HLRs. The Coverage sheet counts each by scope and lists any trace gap.", False),
        ("", False),
        ("Objectives sheet: reads the other way, from each objective row of knowledge/models/stakeholder-objective-ontology.md to the stakeholder requirements that name it (attribute objectiveRefs), and on to the in-study system requirements and HLRs below them. Bold objective: carried into the study. Grey: carried only by a background or out-of-study requirement. '(no requirement)': no stakeholder requirement names it. Requirements that name no objective row are listed at the end.", False),
        ("", False),
        ("How the Decomposition sheet reads", True),
        ("Left to right: stakeholder requirement (SN) -> the system requirements (SLR) that answer it -> the HLRs that come from each SLR. Merged cells span the rows beneath them.", False),
        ("The trace is many-to-many, so an SLR that answers two stakeholder requirements appears under both, marked '(also answers ...)'. An HLR with two parents is marked '(also comes from ...)'.", False),
        ("[IMPROVED] and orange fill: architectureState = improved, something today's NAS does not do (D-018). [GOAL] and italics: obligation = goal, written with 'should' (D-020).", False),
        ("[OUT OF STUDY], grey fill and grey text: studyScope = outOfStudy (D-031). Every stakeholder requirement of the first draft is kept, with the system requirements that answer it; the study's cut is made at the HLR tier, so these stop at the system level with '(no HLR: not carried into the study)'. [BACKGROUND] and lilac fill: a boundary actor's requirement the study holds fixed and uses as input (the operating rules, the CO2 factor). '(no HLR: gap)' in red would be an in-study system requirement with nothing under it.", False),
        ("", False),
        ("Review status (from knowledge/models/requirements-and-traceability.md)", True),
        ("In-study stakeholder and system requirements: hand-reviewed by the owner three times (D-020, D-021, D-031). Out-of-study ones: restored on 2026-10-20 from the 10-10 and 10-11 prints with the text they had when struck.", False),
        ("Sub-system HLRs: Claude's draft of 2026-10-11 (D-022), hand-reviewed by the owner on 2026-10-20 (D-031). Edits applied from a question on that print say so in their rationale and await the owner's confirmation; HLR-ACF-06 is new.", False),
        ("Every requirement has status = draft. Nothing is baselined.", False),
    ]
    for i, (txt, bold) in enumerate(lines, start=1):
        c = a.cell(row=i, column=1, value=txt)
        c.alignment = Alignment(wrap_text=True, vertical="top")
        c.font = Font(bold=bold, size=13 if i == 1 else 11)

    out.parent.mkdir(parents=True, exist_ok=True)
    wb.save(out)
    orphans_slr = [r["id"] for r in in_slr if not hlr_under[r["id"]]]
    orphans_sn = [s["id"] for s in sn if not slr_under[s["id"]]]
    return {"sn": len(sn), "slr": len(slr), "hlr": len(hlr), "rows": row - 2,
            "sn_without_slr": orphans_sn, "slr_without_hlr": orphans_slr}


def main() -> None:
    p = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    p.add_argument("--out", type=Path, default=DEFAULT_OUT)
    args = p.parse_args()
    info = build(args.out)
    print(f"Wrote {args.out.relative_to(REPO) if args.out.is_relative_to(REPO) else args.out}")
    print(f"  {info['sn']} SN, {info['slr']} SLR, {info['hlr']} HLR; {info['rows']} rows on the Decomposition sheet")
    print(f"  SN with no SLR: {info['sn_without_slr'] or 'none'}; in-study SLR with no HLR: {info['slr_without_hlr'] or 'none'}")


if __name__ == "__main__":
    main()
