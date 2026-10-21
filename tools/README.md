# Tools

Small scripts that support the workflows in `workflows/` — not part of the capstone
deliverable itself. Python 3, dependencies in `tools/requirements.txt`
(`python -m pip install -r tools/requirements.txt`).

- **`extract_pdf_annotations.py`** — pulls structured (text-layer) annotations —
  highlights, underlines, strikeouts, squiggly-underlines, typed sticky notes/comments —
  out of an annotated PDF in `evidence/sources/`. Handwritten (ink/freehand) annotations
  are counted but not extracted unless `--include-handwritten` is passed, since they're
  strokes, not text, and need a visual (not textual) read. See
  `workflows/extract-pdf-annotations.md` for how this fits into the literature pipeline.
- **`export_requirements_xlsx.py`** — reads the three requirement files in `projects/nas-sos-capstone/cameo_models/` and writes a review workbook, `cameo_models/print/requirements-review.xlsx`. Its first sheet is the decomposition: stakeholder requirement, then the system requirements that answer it, then the HLRs under each. A Coverage sheet counts requirements by scope (in the study, background, out of study; D-031) and lists any trace gap, and one sheet per tier follows with every attribute and a blank Review notes column. The workbook is a derived copy (D-006): mark it up, apply the changes to the `.sysml` files, and regenerate. Needs `openpyxl`.
- **`extract_seamster_interactions.py`** — extracts the interaction tables (2.1–2.10, 3.1, A, C, D, E-1..E-13) from
  Seamster et al. (2011) in `evidence/sources/` into a CSV plus a readable markdown file under
  `evidence/literature-notes/annotations/`, using PyMuPDF table geometry, and prints a token-coverage check with
  `--verify` (runs ~1 minute; deterministic). If `seamster2011collabSystems-bb-rules.csv` exists it also fills a candidate
  JO 7110.65BB paragraph column by keyword rule. Specific to that one report — not a general table extractor. See the annotation
  note `seamster2011collabSystems.md` for what it does and does not cover.
- **`render_sysml_diagrams.py`** — draws every SysML v2 `view` in `projects/nas-sos-capstone/cameo_models/` with the Syside CLI and writes the images plus a generated `sysml_figures.tex` to `projects/nas-sos-capstone/report/figures/sysml/`, which the report appendix inputs. Standard library only; needs the Syside CLI and its license key. `--check` shows what would change without writing. See `workflows/render-sysml-diagrams.md`.
- **`run_experiment.py`** — runs the experiment pipeline from one command (D-017): scores the conflict-resolution experiment at the chosen fidelity (`--fidelity conceptual|nominalMass|actualMass`, `--variation similar-weights`), draws the two OpenAP figures, checks the model, re-renders the views and compiles the report. Needs the project venv (`.venv`, with `openap`, `matplotlib`, `pyyaml`, `pytest`) and the Syside CLI. The scoring itself is `projects/nas-sos-capstone/simulation/experiment_scoring.py`; its tests run with `python -m pytest projects/nas-sos-capstone/simulation`, which includes `test_model_conformance.py`: the check that the Python types in `simulation/nas_types.py` and the keys of `scenario_base.yaml` match the definitions in `cameo_models/` (D-025).
