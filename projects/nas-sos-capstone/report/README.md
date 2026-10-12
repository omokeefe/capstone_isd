# Report Scaffold

LaTeX outline for the ISD 503 capstone report, structured from
[prework/503_ReportTemplate_v26.docx](../prework/503_ReportTemplate_v26.docx).
Populate `sections/*.tex` as work in `to-do-list.md` completes — each
section carries `\plantodo{...}` markers (visible in the compiled PDF via the
`todonotes` package) tagged with the relevant to-do-list.md section
number(s), so it's traceable which plan item feeds which report section. The
mapping table is also in a comment block at the top of `main.tex`.

## Interim Report #2 checklist (due Sun 2026-10-25, 11:59 pm ET)

From `prework/course-info-canvas.md`. The compiled PDF shows every required part as a red
`REQUIRED FOR INTERIM REPORT #2` note (the `\irtwo` macro in `main.tex`); delete each note
when the owner has written that part.

- [ ] **Introduction** updated (Section 1): the two claims stated, current-state paragraphs describe October (drafted by Claude 2026-10-11, owner to rewrite), research-gap paragraph written, scope question answered, timing shows the nine turns.
- [ ] **Assumptions and Methodology** (Section 2): working assumptions and limits, systems engineering approach table (process names checked against 15288) and tailoring paragraph, MBSE method, the proposed interface.
- [ ] **Experiment** (Section 3, added 2026-10-11, D-026): scenario, cases and options, scoring, aircraft model and simplifications, worked example.
- [ ] **Results and Discussion (preliminary)** (Section 4): operational concept, objectives, architecture figures (now in the body), the two hand checks, the outcome table and its discussion, trace back, emissions; marked preliminary in the heading.
- [ ] **References**: every cited key exists in `evidence/sources/references.bib`; remove `\nocite{*}` from `main.tex` if the list should show only what is cited.
- [ ] **Generative AI disclosure** drafted (Appendix). It must cover the passages Claude drafted on 2026-10-11 unless each has been rewritten.
- [ ] Every blue `AI-DRAFTED, owner to rewrite` note rewritten and deleted (the `\aidraft` macro in `main.tex`).
- [x] Title page says Interim Report #2 (changed 2026-10-11).
- [ ] Review meeting with the adviser held (or confirm the earlier meeting counts).
- [ ] Word copy produced and sent to the adviser (Mark Petrotta, mpetrott@umich.edu).
- [ ] Progress Update #2 confirmed in Canvas.
- [ ] Ask the adviser which Project Review #3 option (Nov 22) they want.

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

### SysML diagrams (generated)

`figures/sysml/` is written by `tools/render_sysml_diagrams.py`: one PNG per `view` in the SysML model, one `fig-<viewName>.tex` per view, and `sysml_figures.tex`, which `sections/08_appendices.tex` inputs. A view with a `// placement: body` line above its caption line is left out of `sysml_figures.tex`; a body section inputs its `fig-<viewName>.tex` instead (D-026). Do not edit that folder or add SysML figures to a `.tex` file by hand. Change the view in the model and rerun the script; see [workflows/render-sysml-diagrams.md](../../../workflows/render-sysml-diagrams.md). Figure labels are `fig:sysml-<viewName>`.

## Removing TODO markers for a final submission

Once a section is fully populated, delete its `\plantodo{...}` calls. To
strip all visible TODO markers at once for a clean submission draft, swap
`todonotes` options in `main.tex` from `colorinlistoftodos` to
`disable` (this removes the notes but leaves the LaTeX source easy to revert
during interim reviews).
