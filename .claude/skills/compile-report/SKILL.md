---
name: compile-report
description: Compile the LaTeX capstone report (report/main.tex) into report/main.pdf, keeping build artifacts out of the top level. Use when asked to compile the LaTeX, build/generate the report PDF, or check that the report still compiles.
---

Follow `assistant/workflows/compile-report.md` exactly: run latexmk from `report/` with
`-outdir=.` and `-auxdir=build_artifacts` (matching `capstone.code-workspace`'s LaTeX
Workshop settings), verify the PDF built cleanly, and fix straightforward LaTeX errors
(missing packages, unescaped special characters, typo'd refs/labels, wrong file
extensions) yourself before reporting back. Flag anything requiring a content or
bibliography-key judgment call to the user instead of guessing.
