# Report Scaffold

LaTeX outline for the ISD 503 capstone report, structured from
[prework/503_ReportTemplate_v26.docx](../prework/503_ReportTemplate_v26.docx).
Populate `sections/*.tex` as work in `to-do-list.md` completes — each
section carries `\plantodo{...}` markers (visible in the compiled PDF via the
`todonotes` package) tagged with the relevant to-do-list.md section
number(s), so it's traceable which plan item feeds which report section. The
mapping table is also in a comment block at the top of `main.tex`.

## Compiling

Requires a LaTeX distribution with `biber` and `latexmk` (TeX Live or
MiKTeX; Overleaf works out of the box).

### Via VSCode (LaTeX Workshop)

Just open `main.tex` and build (the extension auto-detects the root file and
runs on save, or use its "Build LaTeX project" command/button). The
workspace's `capstone.code-workspace` settings already split the output:

- `latex-workshop.latex.outDir` = `%DIR%` → the compiled PDF (and its small
  `.synctex.gz` companion, needed for click-to-jump between the PDF and
  source) land directly in `report/`.
- `latex-workshop.latex.auxDir` = `%DIR%/build_artifacts` → everything else
  (`.aux`, `.log`, `.bbl`, `.bcf`, `.blg`, `.fls`, `.fdb_latexmk`, `.toc`,
  `.out`) is buried in `report/build_artifacts/`, which is gitignored.

### Via command line

```
cd report
latexmk -pdf -interaction=nonstopmode -outdir=. -auxdir=build_artifacts main.tex
```

`latexmk` detects the `biblatex`+`biber` backend from `main.bcf` and runs
`biber` automatically — no separate `biber main` step needed.

The bibliography pulls directly from
[references/references.bib](../references/references.bib) — no need to
duplicate or sync entries.

## Figures

Put new charts/diagrams made specifically for this report in
[figures/](figures/). Existing artifacts that already live elsewhere in the
repo (Cameo diagram exports in `cameo_models/`, `ACM_diagram.pdf` at the
repo root) should be referenced from their original location, not copied in
— `main.tex` sets `\graphicspath{{figures/}{../cameo_models/}{../}}`, so
`\includegraphics{filename}` finds a file in any of those three locations by
plain filename without needing a relative path or a duplicate copy.

## Removing TODO markers for a final submission

Once a section is fully populated, delete its `\plantodo{...}` calls. To
strip all visible TODO markers at once for a clean submission draft, swap
`todonotes` options in `main.tex` from `colorinlistoftodos` to
`disable` (this removes the notes but leaves the LaTeX source easy to revert
during interim reviews).
