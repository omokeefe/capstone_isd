"""Run the whole experiment pipeline from one command (D-017).

Steps, in order:
  0. confirm the Python matches the model (simulation/test_model_conformance.py); stop if
     it does not, so no results are produced from a tool out of step with the model (D-036);
  1. score the experiment at the requested fidelity (simulation/experiment_scoring.py),
     writing the CSV and LaTeX tables and the results .sysml file;
  2. draw the two OpenAP figures (simulation/b739_envelope.py);
  3. check the model (syside check), including the generated results file;
  4. re-render every SysML view and regenerate the appendix figure list
     (tools/render_sysml_diagrams.py), unless --no-render;
  5. compile the report (latexmk), unless --no-compile.

Usage (from the repo root, with the project venv):
    .venv/Scripts/python.exe tools/run_experiment.py [--fidelity conceptual|nominalMass|actualMass]
        [--variation similar-weights] [--no-render] [--no-compile]
"""

from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parent.parent
PROJECT = REPO / "projects" / "nas-sos-capstone"
SIM = PROJECT / "simulation"
SYSIDE_DEFAULT = Path.home() / "AppData" / "Local" / "Programs" / "Syside" / "syside.exe"


def run(cmd: list[str], cwd: Path = REPO) -> None:
    print("$", " ".join(str(c) for c in cmd))
    subprocess.run(cmd, cwd=cwd, check=True)


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--fidelity", choices=["conceptual", "nominalMass", "actualMass"], default="actualMass")
    ap.add_argument("--variation", choices=["similar-weights"], default=None)
    ap.add_argument("--no-render", action="store_true")
    ap.add_argument("--no-compile", action="store_true")
    args = ap.parse_args()

    py = sys.executable
    run([py, "-m", "pytest", str(SIM / "test_model_conformance.py"), "-q"])
    score =[py, str(SIM / "experiment_scoring.py"), "--fidelity", args.fidelity]
    if args.variation:
        score += ["--variation", args.variation]
    run(score)
    run([py, str(SIM / "b739_envelope.py")])

    syside = os.environ.get("SYSIDE_EXE") or (str(SYSIDE_DEFAULT) if SYSIDE_DEFAULT.exists() else shutil.which("syside"))
    if syside:
        run([syside, "check", str(PROJECT / "cameo_models")])
    else:
        print("syside CLI not found; model check skipped")

    if not args.no_render:
        run([py, str(REPO / "tools" / "render_sysml_diagrams.py")])
    if not args.no_compile and shutil.which("latexmk"):
        run(["latexmk", "-pdf", "-interaction=nonstopmode", "-outdir=.", "-auxdir=build_artifacts", "main.tex"], cwd=PROJECT / "report")
    elif not args.no_compile:
        print("latexmk not found; report not compiled")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
