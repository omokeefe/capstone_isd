---
name: render-sysml-diagrams
description: Render every SysML v2 view in cameo_models/ to an image and regenerate the report's figure list so the appendix always matches the model, then compile the report. Use when asked to render, regenerate or refresh the SysML diagrams, to update the report's diagrams, or after a session that changed a .sysml file or a view.
---

Follow `workflows/render-sysml-diagrams.md` exactly: run `python tools/render_sysml_diagrams.py` from the repo root (it draws every view with the Syside CLI and rewrites `projects/nas-sos-capstone/report/figures/sysml/`, including the `sysml_figures.tex` that `08_appendices.tex` inputs), report which views are new, changed, unchanged or removed, then compile the report per `workflows/compile-report.md`. Never edit the generated folder by hand and never add a SysML figure to a `.tex` file directly: add or change the view in the model and rerun. If Syside refuses to draw because of model errors, or a view has no `// caption:` line, flag it to the user as the workflow says instead of working around it.
