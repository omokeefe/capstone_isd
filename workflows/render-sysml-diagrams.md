# Workflow: Render the SysML Diagrams into the Report

For requests to render, regenerate or refresh the SysML diagrams, to bring the report's diagrams up to date with the model, or after any session that changed a `.sysml` file or a view.

## What it does

One script, `tools/render_sysml_diagrams.py`, draws every `view` in `projects/nas-sos-capstone/cameo_models/` and writes the results to `projects/nas-sos-capstone/report/figures/sysml/`:

- `diagram-<viewName>.png`, one per view.
- `sysml_figures.tex`, one LaTeX figure per view, in the order the views appear in the model.
- `manifest.json`, the hash and render date of each image.

The appendix "Full SysML Diagram Set" (`report/sections/09_appendices.tex`) contains `\input{figures/sysml/sysml_figures}`. So the report shows whatever views the model has: add a view and it appears, remove one and it goes, with no edit to any `.tex` file. Everything in `report/figures/sysml/` is generated. Do not edit it by hand.

## Steps

1. From the repo root, run:

   ```
   python tools/render_sysml_diagrams.py
   ```

   It takes about a minute. Use `--check` first to see what would change without writing anything.
2. Read the printed list. Each view is `new`, `changed`, `unchanged` or `removed`. Report that list to the user. A view marked `(no caption line)` needs step 4.
3. Compile the report per [compile-report.md](compile-report.md) and confirm the page count and that there are no undefined references.
4. If a view has no caption, add one line directly above it in the `.sysml` file and rerun:

   ```sysml
   // caption: Aircraft internal block diagram, default level of detail
   view aircraftIbd : InterconnectionView {
   ```

   Caption wording in a graded report is the owner's. Propose a plain label and say that it is a proposal.

   To explain a diagram to a report reader (what the diagram can't say, such as which real system a block stands for), add `// note:` lines in the same comment block. They follow the caption in the figure, several lines joining into one paragraph, and the list of figures keeps the caption alone (added 2026-11-24; first used to say that ATC's decision support is EDST). Note wording, like caption wording, is the owner's.

   If Syside can't run, `--tex-only` rewrites the figure `.tex` files (captions, notes, placement) around the images already rendered and draws nothing. A view with no image yet is left out, and an image rendered before a model change still shows the old diagram.
5. Log the run in today's journal: which views changed and which were added or removed.

## How to refer to a figure from the report body

Each figure's label is `fig:sysml-<viewName>`, for example `Figure~\ref{fig:sysml-systemContext}`. The label follows the view name, so renaming a view in the model breaks references to it. The compile step reports this as an undefined reference; fix the `\ref` to the new name.

To show a diagram in the main body as well as the appendix, include the generated image directly: `\includegraphics[width=\linewidth]{sysml/diagram-<viewName>}` with `\pdfimageresolution=300` inside the same figure. Give it a different label.

## Fix yourself

- **The script cannot find Syside.** It needs the Syside CLI that has the `viz` subcommand (`C:\Users\omoke\AppData\Local\Programs\Syside\syside.exe` on this machine). The `syside` in `.venv` is a different program and has no `viz`. Set the `SYSIDE_EXE` environment variable to the full path if it is installed elsewhere.
- **A render with no matching view, or a view with no render.** The script finds views by reading the text for lines of the form `view name : Kind`. A view written another way is missed. Fix the pattern in the script, not the model.

## Flag to the user instead of guessing

- **`syside viz failed`.** Syside draws nothing if any included file has a model error. The script then stops and leaves the report's figures as they were. Run `syside check projects/nas-sos-capstone/cameo_models/` and report the errors. Do not exclude more files or edit the model to get a picture out without asking.
- **`Failed to load license key`.** The CLI cannot read the VS Code extension's key. The owner fixes this once per machine: [sysml-diagram-rendering.md](../knowledge/models/sysml-diagram-rendering.md) §1.
- **A diagram that cannot be read at page size.** The two aircraft IBDs are five to six times wider than tall. Splitting a view or changing what it shows is a modeling decision for the owner.
- **`DLL load failed while importing … An Application Control policy has blocked this file`.** Windows Smart App Control refused one of the drawer's own files. Confirmed 2026-11-24 from Event Viewer (Microsoft → Windows → CodeIntegrity → Operational, event 3077, policy `VerifiedAndReputableDesktop`): 115 of the 118 DLL and `.pyd` files under `Syside\drawer` are unsigned, and Smart App Control blocks unsigned files that Microsoft's cloud does not rate as safe. The log shows blocks on 2026-10-06, 10-29, 11-10, 11-14, 11-17, 11-23 and 11-24, a different module each time, with good renders in between. The 11-17 recovery credited to a Java repair was not the fix: Java plays no part, and the same policy blocked a drawer file that day. The fix is outside the repo and the owner's call ([sysml-diagram-rendering.md](../knowledge/models/sysml-diagram-rendering.md) §5), so do not attempt it. Until it is fixed, `--tex-only` keeps the figure files consistent.
- **`raster downscaled to fit memory budget`.** Syside lowered the resolution of a very large diagram. It is a warning, the image is still written. Mention it.

## Notes

- The requirement files and `scenarios/` are left out of the render because they have known name-clash errors and no view uses them (`EXCLUDES` at the top of the script; [sysml-diagram-rendering.md](../knowledge/models/sysml-diagram-rendering.md) §6). Remove an entry once that file checks clean.
- A render of an unchanged model gives a byte-identical image (tested 2026-10-10, Syside 0.10.3). The script only replaces an image whose content changed, so the "rendered" date in a caption is the date the diagram last changed, and git shows no change for the others.
- `cameo_models/print/` holds earlier one-off renders, including the ones the hand-marked scans refer to. The script does not touch that folder and the report no longer reads from it.
- How to write a view so that it draws what is intended is in [sysml-diagram-rendering.md](../knowledge/models/sysml-diagram-rendering.md) §2, §7 and §8.
