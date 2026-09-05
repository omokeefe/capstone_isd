# Assets

Uncurated general attachments — screenshots, pulled diagrams, misc PDFs — that aren't yet
tied to a specific deliverable. Root-level because they aren't specific to the one
project that currently exists (a sibling of `knowledge/`/`evidence/` in that sense), not
because there's already a second project to share them with.

## How this differs from a project's own figures folder

`projects/nas-sos-capstone/report/figures/` is the **curated, report-bound** set of
images that actually get `\includegraphics`'d into `main.tex` — everything there is a
deliberate inclusion in the compiled report. `assets/` is upstream of that: things land
here first; once something is confirmed for inclusion in the report (or another project's
deliverable), move or copy it into that project's own figures/media folder rather than
having `main.tex` (or any other deliverable) reach into `assets/` directly.

Empty as of the 2026-09-05 reorg — this folder was added on request, ahead of an
immediate need, so the pattern is in place before the first real asset arrives.
