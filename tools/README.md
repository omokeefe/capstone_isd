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
