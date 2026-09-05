# Workflow: Extract PDF Annotations

Pulls your digital highlights, underlines, and typed sticky-note/comment annotations out
of a PDF in `evidence/sources/` and stages them as an untriaged capture, so they can feed
into that source's summary or deep annotation instead of staying trapped in the PDF
viewer. Handwritten (ink/freehand) annotations are **not** processed by default — see
"Handwritten notes" below.

## When to use

The user has added digital highlights/underlines/comments to a PDF in
`evidence/sources/` and wants that emphasis reflected in the notes — either as prep
before running `/annotate-source` on it, or just to capture what they marked up before
it's forgotten.

## Steps

1. Confirm the source file exists in `evidence/sources/` (add it to
   `evidence/source-register.md` first via `/process-references` if it's not registered
   yet — this workflow extracts markup, it doesn't replace triage).
2. Make sure dependencies are installed: `python -m pip install -r tools/requirements.txt`
   (one-time; only needed again if the environment is rebuilt).
3. Run the extractor:
   ```
   python tools/extract_pdf_annotations.py "evidence/sources/<file>.pdf" --out inbox/<bib-key-or-slug>-pdf-highlights.md
   ```
   This writes a page-by-page markdown dump of every highlight, underline, strikeout,
   squiggly-underline, and typed comment/sticky note, with the underlying quoted text and
   any attached comment. Ink (handwritten) annotations are counted at the bottom but not
   extracted.
4. Read the generated `inbox/` file. Treat it exactly like any other inbox capture (per
   `workflows/process-inbox.md`):
   - If the source is getting a full pass right now, use the highlighted passages
     directly as signal while filling in `templates/source-annotation-template.md`
     (`/annotate-source`) — the user's own emphasis is a strong hint for which
     actors/decisions/objectives/etc. matter most in that source.
   - Otherwise leave it in `inbox/` for a later triage pass, or fold especially notable
     quotes straight into the source's existing summary/annotation note.
   - Once its content is merged somewhere durable, delete the `inbox/` file — it's a
     staging capture, not a permanent record (the annotation/summary note is the record).
5. If comments attached to highlights surface a new term, stakeholder, decision, or
   objective, route it the same way `/annotate-source` does: glossary, stakeholder
   register, or `knowledge/questions/open-questions.md` if it needs a judgment call.

## Handwritten notes (opt-in only)

Ink/freehand annotations are vector strokes, not text — there's nothing to extract
programmatically, only something to look at. Because rendering and reading every
handwritten note on every page is slow and not always wanted, it never runs unless asked
for explicitly:

```
python tools/extract_pdf_annotations.py "evidence/sources/<file>.pdf" --include-handwritten
```

This renders a cropped image (`.tmp/pdf-annotation-images/`, gitignored) around each ink
annotation and lists them in the output. Read each image with the Read tool and
transcribe/summarize what it says by hand before merging it in — don't guess at illegible
handwriting; note it as illegible instead of inventing content.

## Notes

- This tool extracts what's in the PDF's annotation layer, not full-text search — a
  passage the user meant to highlight but didn't actually mark won't show up.
- `--json` emits machine-readable output instead of markdown, if a future workflow needs
  to consume this programmatically rather than reading it.
- Multiple PDFs can be passed in one call; each gets its own section in the output.
