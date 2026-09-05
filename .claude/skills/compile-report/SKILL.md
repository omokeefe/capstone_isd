---
name: compile-report
description: Compile the LaTeX capstone report (projects/nas-sos-capstone/report/main.tex) into main.pdf, keeping build artifacts out of the top level. Use when asked to compile the LaTeX, build/generate the report PDF, or check that the report still compiles.
---

Follow `workflows/compile-report.md` exactly: run latexmk from
`projects/nas-sos-capstone/report/` with `-outdir=.` and `-auxdir=build_artifacts`
(matching `capstone.code-workspace`'s LaTeX Workshop settings, which use the `%DIR%`
macro so no path is hardcoded there), verify the PDF built cleanly, and fix
straightforward LaTeX errors (missing packages, unescaped special characters, typo'd
refs/labels, wrong file extensions) yourself before reporting back. Flag anything
requiring a content or bibliography-key judgment call to the user instead of guessing.
