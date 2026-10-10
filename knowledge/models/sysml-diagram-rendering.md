# Rendering SysML v2 diagrams (Syside CLI and VS Code)

How to turn the `.sysml` model in `projects/nas-sos-capstone/cameo_models/` into diagrams: once-per-machine setup, how to write a view that shows exactly what you intend, and how to render it from the VS Code extension (quick look) or the `syside` CLI (report figures). Companion to [sysml-modelling-methods.md](sysml-modelling-methods.md), which covers *what* to model and the textual patterns for each diagram type. This note covers *getting the picture out*. The `.sysml` text is the source of truth (D-006); a diagram is always a view of it, never edited by hand.

Status: written 2026-09-27 after getting `MyViews::NASMyViews::systemContext` to render cleanly with Syside CLI 0.10.3. Items marked **(tested)** were run in this repo that day; the rest come from the Syside docs or the methods note and have not been re-checked here.

---

## 1. One-time setup

1. **VS Code extension:** install *Syside Modeler* (Sensmetry). Enter the license key when the extension prompts for it. Keep the status bar's **Mode: Folder** so every `.sysml` file in `cameo_models/` resolves as one model (Standalone shows cross-file references as `<placeholder>`).
2. **CLI:** install the Syside CLI. On this machine it is `C:\Users\omoke\AppData\Local\Programs\Syside\syside.exe` (version 0.10.3). A terminal opened *before* the install won't have it on `PATH`; restart VS Code or call the full path.
3. **License for the CLI (tested):** the key you typed into the extension stays in VS Code's own storage, and the CLI can't read it. Copy it to the OS keyring: `Ctrl+Shift+P` → **Syside Modeler: Add Syside license key to keyring**. On Windows it lands in Credential Manager as `license-key.syside`. Alternatives the CLI also accepts: a `SYSIDE_LICENSE_KEY` environment variable or a key file named in `SYSIDE_LICENSE_KEY_FILE`. Without a key, `syside viz` fails with `ImportError: Failed to load license key`.

## 2. Writing a view that shows only what you want

Views live in [nas_package_my_views.sysml](../../projects/nas-sos-capstone/cameo_models/nas_package_my_views.sysml). What appears on a diagram is decided by tags in the model file, not by the view. The view just says "show the tagged things."

**The pattern that works (tested, context diagram):**

```sysml
// In the diagram's model file (e.g. nas_context_diagram.sysml)
metadata def ContextVisible;

part def NASContextDiagram {
    #ContextVisible part airportOps: AirportOperationsDomain {
        #ContextVisible part :>> airport;      // tagged: drawn
    }                                         // airport's own sub-parts: untagged, hidden
    #ContextVisible connection aocAirport connect flightOps.airlineOperationsCenter to airportOps.airport;
}

// In nas_package_my_views.sysml
view systemContext : InterconnectionView {
    expose ContextDiagram::NASContextDiagram::*::**;
    filter @ContextDiagram::ContextVisible;
    attribute exposeMode = "subtree";
}
```

**Rules behind it:**

- **Tag every level you want drawn.** The domain (`airportOps`), the part inside it (`airport`), and each connection. A nested part is only visible if its container is too. To tag an inherited part, redefine it: `#ContextVisible part :>> airport;` (the type doesn't change).
- **Use a view-level `filter`, not only an inline `[@Tag]` on the expose.** `expose X::**[@Tag]` only chooses which elements the view starts from. The renderer then draws each one's full contents, including every sub-part inherited from its definition. That's how `airport` brought `maintenanceHangar`, `groundHandling`, `fuelDistributionSystem` and the rest onto the diagram. A `filter` statement is applied to everything drawn, at every level.
- **Expose `X::*::**`, not `X::**`.** `X::**` includes `X` itself. `NASContextDiagram` is not tagged, so with the filter on and the default `subtree` mode it is dropped *with its whole subtree*: the diagram comes out empty. `X::*::**` starts one level down.
- **Untagged is the default for hiding.** To take something off the diagram, remove its tag. Don't delete it or give it multiplicity `[0]` to tidy a picture. That changes what the model says.
- **Interconnection views need usages, not definitions.** That's why each diagram file has a wrapper `part def` (e.g. `NASContextDiagram`) that instantiates the domains as parts.
- **A connection only draws if both of its ends are drawn.**

**Expose mode** (`attribute exposeMode = "...";`, CLI only) decides what happens to elements the filter drops. On the context diagram (tested):

| Mode | Syside's definition | Result on `systemContext` |
| --- | --- | --- |
| `subtree` (default) | A dropped element takes its whole subtree with it | Correct with `*::**`; empty with `**` |
| `promoted` | Dropped elements vanish; their tagged descendants move up to the view frame | Same as `subtree` with `*::**`; connections only (no parts) with `**` |
| `flat` | Every exposed element is its own sibling; no containment | Connections as loose boxes, no parts. Not useful here |

**Other view attributes** (from Syside's docs; "Both" = VS Code and CLI):

| Attribute | Scope | Effect |
| --- | --- | --- |
| `depth` | Both | Levels of descendants to show; `-1` = all. Elements past the limit become compartment rows rather than disappearing. `depth = 0/1` with the `**[@Tag]` expose gave an empty diagram (tested) |
| `render asTreeDiagram` | Both | Tree layout instead of nested boxes |
| `exposeMode` | CLI | See table above |
| `showInheritedRows = false` | CLI | Hides inherited (`^`) compartment rows |
| `maxCompartmentEntries` | CLI | `-1` all rows, `0` hides attribute/action compartments, `N` first N rows |
| `fileType`, `fileName` | CLI | Output format and file name |

## 3. Rendering in VS Code (quick look)

From the methods note (§2); not re-verified with the `*::**` expose:

- **Render a view:** put the cursor on the `view` and press `Ctrl+Alt+V`, or right-click → *Visualize view*. It resolves across all files in the folder.
- **Render one element's subtree:** `Ctrl+Alt+E`. **Render the whole file:** `Ctrl+Shift+V` (rarely useful here).
- **Layout:** Orthogonal for context diagrams and IBDs; Hierarchical for trees. *Save As Image* exports a PNG/SVG.
- **Save first.** The renderer reads the file on disk.
- CLI-only attributes (`exposeMode`, `showInheritedRows`, `maxCompartmentEntries`) are ignored here, so a VS Code render can differ from the CLI render. Use the CLI for anything that goes in the report.

## 4. Rendering with the CLI (report figures)

**For the report, use the script (added 2026-10-10):** `python tools/render_sysml_diagrams.py` renders every view and regenerates the figure list the appendix reads, so nothing has to be copied or renamed by hand. Steps are in [render-sysml-diagrams.md](../../workflows/render-sysml-diagrams.md). The commands below are for one-off and test renders.

Run from the repo root. Write test renders to a scratch folder; write report figures to `projects/nas-sos-capstone/report/figures/` (or `cameo_models/print/`) once you're happy with them.

```powershell
$syside = "C:\Users\omoke\AppData\Local\Programs\Syside\syside.exe"   # or just `syside` once it's on PATH

# 1. Check the model (reports errors; nothing is drawn)
& $syside check "projects/nas-sos-capstone/cameo_models/"

# 2. Render one view (tested)
& $syside viz view projects/nas-sos-capstone/cameo_models/ `
    -e "**/requirements_*.sysml" -e "**/scenarios/**" `
    -n "MyViews::NASMyViews::systemContext" -f png -o <output-dir>
```

- **Output name:** `diagram-<viewName>.png` in the `-o` folder (default `./output`). Leave out `-n` to render every view in the model.
- **Useful `viz view` flags:** `-f svg|png|jpeg` · `-z <zoom>` (PNG/JPEG resolution, default 3.0) · `-t light|dark|light_mono|dark_mono` · `-d <depth>` (overrides every view's depth) · `-r tree|nested` · `--expose subtree|promoted|flat` (overrides `exposeMode`, handy for comparing modes without editing the file) · `-e <glob>` exclude · `-i <path>` include · `-c syside.toml`.
- **One element instead of a view:** `syside viz element <paths> -n 'Package::Element' -v interconnection -d 2 -f png -o <dir>`. `-v` picks the view kind (general, interconnection, action_flow, state_transition, sequence).
- **Tables/matrices:** `syside table export <paths> -n "<view>" -o <dir>` writes CSV.
- **The whole model must be error-free.** `viz` refuses to draw anything if any included file has an error (`Aborted: N errors in model. No output written.`). Until the errors are fixed, leave out files the view doesn't use with `-e`.
- **Defaults in `syside.toml`:** the CLI finds a `syside.toml` by walking up from the current folder (stops at the `.git` folder). Its `include`/`exclude` and `[viz.*]` settings (e.g. `[viz.expose].mode`) apply when no flag is given. There isn't one in this repo yet. Adding one with the `exclude` list would shorten the command.

```powershell
cd .\capstone_isd\
& "C:\Users\omoke\AppData\Local\Programs\Syside\syside.exe" viz view projects/nas-sos-capstone/  cameo_models/ -e "**/requirements_*.sysml" -e "**/scenarios/**" -n "MyViews::NASMyViews::systemContext" -f png -o projects/nas-sos-capstone/cameo_models/print
Move-Item projects/nas-sos-capstone/cameo_models/print/diagram-systemContext.png projects/nas-sos-capstone/cameo_models/print/NAS_Context_Diagram_reduced.png

```

## 5. Troubleshooting

| Symptom | Cause | Fix |
| --- | --- | --- |
| A tagged part drags in every sub-part from its definition | Only the inline `[@Tag]` on the expose; no view `filter` | Add `filter @Pkg::Tag;` |
| Diagram is empty | `expose X::**` includes untagged `X`; `subtree` drops it with everything inside | `expose X::*::**` |
| Connections drawn as loose boxes, no parts | `exposeMode = "flat"` (or `promoted` with `X::**`) | `subtree` with `X::*::**` |
| An edge is missing | One end isn't drawn (untagged or past `depth`) | Tag both ends and their containers |
| `ImportError: Failed to load license key` | CLI can't see the extension's key | Add it to the keyring (§1) |
| `Aborted: N errors in model` | Errors in any included file | Fix them, or leave the files out with `-e` |
| `syside: command not found` | Terminal started before the install | Restart VS Code or use the full path |
| Cross-file names show as `<placeholder>` in VS Code | Mode: Standalone | Switch to Mode: Folder |

## 6. Known issues (2026-09-27)

- **69 model errors block a full-folder render.** They're name clashes (`namespace-distinguishability`) in `requirements_nas_system.sysml`, `requirements_stakeholders.sysml` and `scenarios/hub-to-hub-example.sysml`: members such as `status`, `kind`, `stakeholderGroup`, `yaw`, `flightNumber` reuse a name they already inherit. Until fixed, render with `-e "**/requirements_*.sysml" -e "**/scenarios/**"`.
- **Most connection names don't show on the context diagram.** Only the five environment links (`rulesToAoc`, `rulesToAtc`, `weatherToTfm`, `weatherToAoc`, `suaToTfm`) are labeled. They're the only ones declared without a `{ doc ... }` body. Cause confirmed and fixed 2026-10-08: see §8.
- **The Airspace Management IBD view** (`airspaceManagementIbd`) used the `::**[@IBDVisible]` expose with no view `filter` and rendered an empty frame. Fixed 2026-10-08: it now uses `expose …::*::**` plus `filter`, and draws.

## 7. Levels of detail on one diagram (2026-10-08, D-011)

To keep detail in the model but off the default picture, use two tags and two views over the same wrapper `part def`. The aircraft IBD (`nas_ibd_aircraft.sysml`) does this:

- `#IBDVisible` on what the default view draws; `#IBDDetail` on what only the detailed view adds.
- Default view: `filter @AircraftIBD::IBDVisible;`. Detailed view: `filter @AircraftIBD::IBDVisible or @AircraftIBD::IBDDetail;` (tested, syside viz).
- Anything left untagged stays in the definitions and is drawn by neither view. To show it, redefine it in the diagram file with a tag (`#IBDDetail part :>> fan;`).
- With a prefix tag on a referenced part, `ref` goes first: `ref #IBDVisible part crew: FlightDeckCrew;`. The other order is a syntax error.

## 8. Connection labels and ports (tested 2026-10-08, syside viz 0.10.3, D-012)

**Labels.** A connection's name is printed on its line unless the connection's body owns a `doc` or a `comment`. An empty body `{ }` or no body keeps the name.

- To keep both the name on the diagram and the description in the model, put the description next to the connection as `comment about <name> /* ... */`:

  ```sysml
  #ContextVisible connection aocTfm connect flightOps.airlineOperationsCenter to airspaceMgmt.atcscc;
  comment about aocTfm /* [A] Traffic flow management link. ... */
  ```

- **Where the comment sits matters.** A comment owned by a part that is drawn is printed in a "comments" compartment inside that part's box. For connections inside a drawn part (the ones inside `airliner` on the aircraft IBD), put the comments in the enclosing, undrawn `part def` and use the qualified name: `comment about airliner::navData /* ... */`.
- A name in single quotes prints with its spaces, if a longer label is wanted: `connection 'surveillance: aircraft to ATC' connect ...`. Not used in the model yet.
- The tag prints in front of every label (`«#ContextVisible» aocTfm`). No way to hide it was found.
- The text at each end of a line is the name of the part or port the line ends on.

**Ports.** A tagged port is drawn as a small square on the edge of its part, with its name beside it, whether or not anything is connected to it. A connection may end on a port (`connect x to part.port`). A port redefined in the diagram file to carry a tag prints as `weatherIn :>> weatherIn`, the same as redefined parts. A `flow of <Item> from a to b` is drawn as a line with a filled arrowhead labeled with the item, which is the way to show direction and content on one line.

**Not possible:** placing parts by hand (for example around an outline of the aircraft). Syside lays the diagram out itself. The only route is to export SVG and arrange it in a drawing tool, which makes a picture that is no longer generated from the model.

## 9. Swimlanes, allocation and what each view kind draws (tested 2026-10-10, syside viz 0.10.3; docs read the same day)

**What the docs say.** Syside supports five of the eight standard view definitions: `GeneralView`, `InterconnectionView` (parts wired through ports), `ActionFlowView` (actions and control flow), `StateTransitionView`, `SequenceView` (lifelines and messages). The docs do not say what the action-flow and sequence views draw beyond that, and name no swimlane or partition support ([Configure diagram views](https://docs.sensmetry.com/modeler/diagram-views/configuring/)). Diagram generation is a Labs feature and "may change." Relationship edges need both ends rendered as nodes, and `depth` can demote elements into compartment rows, which turns arrows into text.

**What was tested** (`syside viz element ... -n NominalOpsActivity::NominalOpsContext`, the part def that `perform`s the nominal-flight actions per domain, in `nas_activity_diagram-nominal_ops.sysml`):

| Render | Result |
| --- | --- |
| `-v general -d 3` and `-v interconnection -d 3` | Each domain part is a box; inside it, every performed action draws as its own `«perform action»` box (`planFlight ::> nominalFlight.planFlight`), beside the domain's inherited sub-parts. **This is the allocation picture: lanes as boxes.** |
| `-v action_flow -d 3` | Same boxes, no flow lines. |
| Flows restated inside `NominalOpsContext` (`flow nominalFlight.planFlight.release to nominalFlight.prepareForDeparture.release;`), any view | No lines drawn between the performed actions. Reverted. |
| `-d 2` | Performed actions drop to compartment rows and vanish. Use depth 3 or more. |

**What to do.** Two views, not one: (1) `nominalOpsActivity` (`ActionFlowView` over `NominalFlightOperations`) for the ordering and item flows; (2) a `GeneralView` over `NominalOpsContext` for who performs what. To keep (2) readable, tag the domain parts and the `perform` usages with a metadata tag and filter, as the IBDs do, so the inherited sub-parts and attributes stay off it; untested. For a reviewer-facing allocation matrix, Syside's grid views give one: `view :> MVD::AllocationMatrixView` with rows exposing the actions and columns the domain parts, exported with `syside table export` ([Matrix views](https://docs.sensmetry.com/modeler/grid-views/matrix-views/)). The preset recognizes `allocate` usages, not `perform`, so the matrix needs `allocate nominalFlight.planFlight to flightOps;` lines beside the performs; untested.

**Sequence view.** `SequenceView` is listed as supported (lifelines and messages). The docs give no example of the model elements it needs. Before drawing the conflict-resolution sequence (plan turn 3), test one small `occurrence`/`message` example from the SysML v2 specification against `syside viz element -v sequence` and record the result here.

Sources: [Syside — Diagram Views](https://docs.sensmetry.com/modeler/diagram-views.html); [Syside — Configure diagram views](https://docs.sensmetry.com/modeler/diagram-views/configuring/); [Syside — CLI commands](https://docs.sensmetry.com/modeler/cli/commands/); [Syside — CLI diagram generation](https://docs.sensmetry.com/modeler/cli/diagram-generation.html); [Syside — Matrix views](https://docs.sensmetry.com/modeler/grid-views/matrix-views/); [Syside — Install Modeler](https://docs.sensmetry.com/modeler/install/); `syside --help` output, v0.10.3.
