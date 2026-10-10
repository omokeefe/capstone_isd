"""Render every SysML v2 view to a PNG and regenerate the report's figure list.

Runs `syside viz view` over projects/nas-sos-capstone/cameo_models/ with no view
name, so every `view` in the model is drawn. Then writes two generated things under
projects/nas-sos-capstone/report/figures/sysml/:

  diagram-<viewName>.png   one per view
  sysml_figures.tex        one LaTeX figure per view, \\input by 08_appendices.tex
  manifest.json            hash and render date per view (keeps dates stable)

Because the appendix inputs sysml_figures.tex, a view added to, renamed in, or
removed from the model shows up in the report the next time this script runs and
the report is compiled. Nothing in that folder is edited by hand.

Caption text comes from a `// caption: ...` line directly above the view in the
.sysml file. A view without one gets its name as the caption.

Usage (from the repo root):
    python tools/render_sysml_diagrams.py [--check] [--zoom 3.0]

Standard library only. Needs the Syside CLI with a license key; see
knowledge/models/sysml-diagram-rendering.md section 1.
"""

from __future__ import annotations

import argparse
import datetime
import hashlib
import json
import os
import re
import shutil
import struct
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
PROJECT = REPO / "projects" / "nas-sos-capstone"
MODEL_DIR = PROJECT / "cameo_models"
OUT_DIR = PROJECT / "report" / "figures" / "sysml"
TEX_NAME = "sysml_figures.tex"
MANIFEST_NAME = "manifest.json"
SCRATCH = REPO / ".tmp" / "sysml-render"

# Files to leave out of the render. `syside viz` draws nothing if any included file has
# an error or an unresolved reference (sysml-diagram-rendering.md section 6). As of
# 2026-10-10 the whole folder checks clean and nas_verification.sysml refers to the
# requirements files, so nothing is excluded. Add a glob here only while a file is broken.
EXCLUDES: list[str] = []

DEFAULT_EXE = Path.home() / "AppData" / "Local" / "Programs" / "Syside" / "syside.exe"

# Wider than this (width / height) and the figure goes on a landscape page.
LANDSCAPE_ASPECT = 1.3

VIEW_RE = re.compile(r"^\s*view\s+(\w+)\s*:\s*(\w+)")
CAPTION_RE = re.compile(r"^\s*//\s*caption:\s*(.+?)\s*$", re.IGNORECASE)
EXPOSE_RE = re.compile(r"^\s*expose\s+(\w+)::")
PACKAGE_RE = re.compile(r"^\s*(?:library\s+)?package\s+(\w+)")


def find_syside() -> str:
    """Return a syside executable that has the `viz` subcommand.

    The `syside` in .venv/Scripts is the Python package's CLI and has no `viz`,
    so each candidate is tested rather than trusting PATH order.
    """
    candidates = []
    if os.environ.get("SYSIDE_EXE"):
        candidates.append(os.environ["SYSIDE_EXE"])
    candidates.append(str(DEFAULT_EXE))
    for folder in os.environ.get("PATH", "").split(os.pathsep):
        found = shutil.which("syside", path=folder)
        if found:
            candidates.append(found)
    for exe in candidates:
        try:
            done = subprocess.run([exe, "viz", "--help"], capture_output=True)
        except OSError:
            continue
        if done.returncode == 0:
            return exe
    sys.exit(
        "No syside executable with a `viz` subcommand was found. Install the Syside "
        "CLI or set SYSIDE_EXE to its full path."
    )


def is_excluded(path: Path) -> bool:
    rel = path.relative_to(MODEL_DIR)
    return rel.name.startswith("requirements_") or "scenarios" in rel.parts


def read_views() -> list[dict]:
    """Find every view in the model, in file order, with its caption and source file."""
    files = sorted(p for p in MODEL_DIR.rglob("*.sysml") if not is_excluded(p))
    package_file: dict[str, str] = {}
    lines_by_file: dict[Path, list[str]] = {}
    for path in files:
        lines = path.read_text(encoding="utf-8").splitlines()
        lines_by_file[path] = lines
        for line in lines:
            match = PACKAGE_RE.match(line)
            if match:
                package_file.setdefault(match.group(1), path.name)

    views = []
    for path, lines in lines_by_file.items():
        for i, line in enumerate(lines):
            match = VIEW_RE.match(line)
            if not match:
                continue
            name, kind = match.groups()
            caption = None
            if i > 0:
                above = CAPTION_RE.match(lines[i - 1])
                if above:
                    caption = above.group(1)
            source = path.name
            for later in lines[i + 1 :]:
                if VIEW_RE.match(later):
                    break
                exposed = EXPOSE_RE.match(later)
                if exposed:
                    source = package_file.get(exposed.group(1), path.name)
                    break
            views.append({"name": name, "kind": kind, "caption": caption, "source": source})
    return views


def render(exe: str, zoom: float) -> Path:
    """Render all views into a scratch folder and return it. Exits on failure."""
    if SCRATCH.exists():
        shutil.rmtree(SCRATCH)
    SCRATCH.mkdir(parents=True)
    command = [exe, "viz", "view", str(MODEL_DIR)]
    for pattern in EXCLUDES:
        command += ["-e", pattern]
    command += ["-f", "png", "-z", str(zoom), "-o", str(SCRATCH)]
    done = subprocess.run(command, cwd=REPO, capture_output=True, text=True)
    output = (done.stdout + done.stderr).replace("\x00", "")
    for line in output.splitlines():
        if line.strip() and not line.startswith("Wrote "):
            print("  syside:", line)
    if done.returncode != 0:
        sys.exit(f"syside viz failed (exit {done.returncode}). The report figures were left as they were.")
    return SCRATCH


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def png_size(path: Path) -> tuple[int, int]:
    with path.open("rb") as handle:
        header = handle.read(24)
    return struct.unpack(">II", header[16:24])


def tex_escape(text: str) -> str:
    replacements = {
        "\\": r"\textbackslash{}", "&": r"\&", "%": r"\%", "$": r"\$", "#": r"\#",
        "_": r"\_", "{": r"\{", "}": r"\}", "~": r"\textasciitilde{}", "^": r"\textasciicircum{}",
    }
    return "".join(replacements.get(ch, ch) for ch in text)


def figure_tex(view: dict, rendered: str) -> str:
    name = view["name"]
    caption = view["caption"] or f"View {name}"
    caption = tex_escape(caption.rstrip("."))
    return "\n".join([
        r"\begin{figure}[!htbp]",
        r"\centering",
        # The PNGs carry no resolution, so pdfTeX assumes 72 dpi; a render 16,384 px wide
        # is then over TeX's largest length ("Dimension too large"). 300 dpi keeps it under.
        r"\pdfimageresolution=300",
        rf"\includegraphics[width=\linewidth,height=0.8\textheight,keepaspectratio]{{sysml/diagram-{name}}}",
        rf"\caption{{{caption}. View \texttt{{{tex_escape(name)}}}; source "
        rf"\texttt{{{tex_escape(view['source'])}}}; rendered {rendered}.}}",
        rf"\label{{fig:sysml-{name}}}",
        r"\end{figure}",
    ])


def build_tex(views: list[dict], manifest: dict) -> str:
    out = [
        "% GENERATED by tools/render_sysml_diagrams.py. Do not edit: the next run overwrites it.",
        "% To change a caption, edit the `// caption:` line above the view in the .sysml file.",
        "% To add or remove a figure, add or remove the view in the model.",
        "",
    ]
    in_landscape = False
    for view in views:
        width, height = png_size(OUT_DIR / f"diagram-{view['name']}.png")
        wide = width / height > LANDSCAPE_ASPECT
        if wide and not in_landscape:
            out += [r"\begin{landscape}", ""]
        if not wide and in_landscape:
            out += [r"\end{landscape}", ""]
        in_landscape = wide
        out += [figure_tex(view, manifest[view["name"]]["rendered"]), ""]
    if in_landscape:
        out += [r"\end{landscape}", ""]
    return "\n".join(out)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    parser.add_argument("--check", action="store_true",
                        help="render to scratch and report what would change; write nothing to the report")
    parser.add_argument("--zoom", type=float, default=3.0, help="PNG resolution factor (syside -z), default 3.0")
    args = parser.parse_args()

    views = read_views()
    if not views:
        sys.exit(f"No `view` found in {MODEL_DIR}.")
    exe = find_syside()
    print(f"Rendering {len(views)} views with {exe} (about a minute)...")
    scratch = render(exe, args.zoom)

    rendered_names = {p.stem.removeprefix("diagram-") for p in scratch.glob("diagram-*.png")}
    missing = [v["name"] for v in views if v["name"] not in rendered_names]
    extra = sorted(rendered_names - {v["name"] for v in views})
    if missing:
        print("  WARNING: views in the model with no render (left out of the report):", ", ".join(missing))
    if extra:
        print("  WARNING: renders with no matching view found by this script (left out):", ", ".join(extra))
    views = [v for v in views if v["name"] in rendered_names]

    manifest_path = OUT_DIR / MANIFEST_NAME
    old = json.loads(manifest_path.read_text(encoding="utf-8")) if manifest_path.exists() else {}
    today = datetime.date.today().isoformat()
    manifest, status = {}, {}
    for view in views:
        name = view["name"]
        digest = sha256(scratch / f"diagram-{name}.png")
        target = OUT_DIR / f"diagram-{name}.png"
        if name in old and old[name]["sha256"] == digest and target.exists():
            manifest[name] = old[name]
            status[name] = "unchanged"
        else:
            manifest[name] = {"sha256": digest, "rendered": today}
            status[name] = "changed" if name in old else "new"
    removed = sorted(set(old) - set(manifest))

    for view in views:
        flag = "" if view["caption"] else "   (no `// caption:` line)"
        print(f"  {status[view['name']]:9} {view['name']}  <- {view['source']}{flag}")
    for name in removed:
        print(f"  removed   {name}")

    if args.check:
        print("Check only: nothing written.")
        return 0

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for view in views:
        name = view["name"]
        if status[name] != "unchanged":
            shutil.copyfile(scratch / f"diagram-{name}.png", OUT_DIR / f"diagram-{name}.png")
    keep = {f"diagram-{v['name']}.png" for v in views}
    for stale in OUT_DIR.glob("diagram-*.png"):
        if stale.name not in keep:
            stale.unlink()
    manifest_path.write_text(json.dumps(manifest, indent=2) + "\n", encoding="utf-8")
    (OUT_DIR / TEX_NAME).write_text(build_tex(views, manifest), encoding="utf-8")
    shutil.rmtree(SCRATCH, ignore_errors=True)
    print(f"Wrote {len(views)} figures and {TEX_NAME} to {OUT_DIR.relative_to(REPO).as_posix()}/")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
