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
- **`extract_seamster_interactions.py`** — extracts the interaction tables (2.1–2.10, 3.1, A, C, D, E-1..E-13) from
  Seamster et al. (2011) in `evidence/sources/` into a CSV plus a readable markdown file under
  `evidence/literature-notes/annotations/`, using PyMuPDF table geometry, and prints a token-coverage check with
  `--verify` (runs ~1 minute; deterministic). If `seamster2011collabSystems-bb-rules.csv` exists it also fills a candidate
  JO 7110.65BB paragraph column by keyword rule. Specific to that one report — not a general table extractor. See the annotation
  note `seamster2011collabSystems.md` for what it does and does not cover.
