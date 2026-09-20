# Workflow: Update the Architecture

For sessions touching the SysML v2 model, the domain decomposition, or the legacy XML
draft — covers `to-do-list.md` §10 and related architecture work threaded
through §6-§9.

## Ground rules

- **The `.sysml` text under `cameo_models/` is the source of truth** (D-006), authored in
  Syside Modeler in VS Code. Make architecture changes there. Cameo is optional and
  downstream — anything in a Cameo project is a derived copy that gets regenerated or
  fixed to match the text, never the other way round.
- **`prework/nas_system_of_systems_architecture.xml` is a pre-modeling draft**, not
  generated from the model and not kept in sync. Don't update it as part of routine
  architecture changes; if it disagrees with the `.sysml` files, the `.sysml` files win.
  Retire or regenerate it deliberately if it starts to mislead.
- Every new architecture element should be traceable to *something*: a stakeholder need
  (`stakeholder-register.md`), a source's evidence (`source-register.md`), or the
  trajectory-intent chain (`index.md`). An element with no traceability is a
  smell — flag it in `open-questions.md` rather than silently adding it.

## Steps

1. Bootstrap per `workflows/session-welcome.md`, paying particular
   attention to `decisions/decisions-log.md` D-002 (the current domain
   decomposition) and any open decomposition question in `open-questions.md`.
2. Identify which `projects/nas-sos-capstone/to-do-list.md` §10 bullet this session
   addresses (context diagram, package organization, stakeholder model, BDD, IBD,
   information-object model, interface/item-flow model, activity diagram, responsibility
   swimlane, sequence diagram, requirements model, or a specific trace).
3. Before adding a new element, check whether it already exists under a different name —
   skim the current `.sysml` package structure rather than assuming.
4. Make the change. For structural changes (new domain, new package, renamed boundary),
   also update `projects/nas-sos-capstone/index.md`'s "Candidate top-level domains"
   section and log the change in `decisions/decisions-log.md` if it's a real
   decision (not just filling in detail within an already-agreed structure).
5. Update the relevant trace: stakeholder need -> objective -> requirement -> system ->
   activity -> information exchange -> decision -> aircraft behavior (per §10's trace
   bullets). Partial traces are fine mid-project; note the gap in
   `knowledge/questions/open-questions.md`.
6. Check off the corresponding `projects/nas-sos-capstone/to-do-list.md` §10 box(es).
7. Sign off per `workflows/session-signoff.md`.

## Getting the model into Cameo (not planned)

Not needed: the adviser (Mark Petrotta) recommended Syside/SysML v2 and accepts it as the
model deliverable (D-006). This section is only a record of options in case that changes.
The university's Cameo (2024x Refresh 1, checked 2026-09-19) does not support SysML v2 out
of the box, so there is no direct import. Options, roughly least to most effort — no path
has been tried:

1. **Get a Cameo release with SysML v2 support** (believed to start with 2024x Refresh 2
   as a beta, fuller in 2025x — verify) through the university's license/download
   admin. The user has chosen not to pursue this. If obtained, import the `.sysml` text
   directly.
2. **Script it:** a Python script using Syside's Python API dumps the model to JSON, and
   a Groovy macro run inside Cameo (OpenAPI) builds SysML v1 Blocks, Parts, and value
   properties from it (`part def` → Block, part usage → part property, `attribute def` →
   ValueType, specialization → generalization). Repeatable; costs two scripts.
3. **Rebuild by hand** in Cameo BDDs, using the `.sysml` as the spec. Cheapest if the
   model is mostly finished; the copy drifts from the text.
4. **Skip Cameo** and deliver from Syside-generated views. This is the current plan.

Whichever is chosen, log it in `decisions/decisions-log.md`. Don't hand-generate Cameo
XMI — it depends on internal profile IDs and fails opaquely.

## Notes

- Resist adding architecture detail that isn't traceable to a stakeholder need or a
  piece of literature evidence just because it "seems right" for the NAS — per
  `index.md`'s working assumptions, the point is a defensible, bounded model,
  not an exhaustive one.
