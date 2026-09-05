---
name: extract-pdf-annotations
description: Extract digital highlights, underlines, and typed comments/sticky notes from an annotated PDF in evidence/sources/ and stage them as an inbox capture for merging into that source's notes. Handwritten/ink annotations are only processed if explicitly requested. Use when asked to pull highlights/annotations/markup out of a PDF, or to "contextualize" a user's PDF markup into the notes.
---

Follow `workflows/extract-pdf-annotations.md` exactly. Run
`tools/extract_pdf_annotations.py` against the named PDF (installing
`tools/requirements.txt` first if `pymupdf` isn't available), write the result to
`inbox/<bib-key-or-slug>-pdf-highlights.md`, then triage it per the workflow — either
straight into an `/annotate-source` pass or left for `/process-inbox`. Only pass
`--include-handwritten` when the user explicitly asks for handwritten/ink notes to be
read too; it is off by default.
