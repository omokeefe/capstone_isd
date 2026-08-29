# Workflow: Update the Architecture

For sessions touching the SysML/Cameo model, the domain decomposition, or the XML
export — covers `Project_To-Do List.md` §10 and related architecture work threaded
through §6-§9.

## Ground rules

- **Cameo is the source of truth; `nas_system_of_systems_architecture.xml` is a
  generated artifact.** If Cameo is available, make the change there and re-export.
  If working from the XML directly (e.g. no Cameo access in this session), clearly mark
  the change as a draft that needs to be reconciled back into the actual Cameo model
  later — note it in `assistant/tasks/task-board.md`.
- Every new architecture element should be traceable to *something*: a stakeholder need
  (`stakeholder-register.md`), a source's evidence (`source-register.md`), or the
  trajectory-intent chain (`project-brief.md`). An element with no traceability is a
  smell — flag it in `open-questions.md` rather than silently adding it.

## Steps

1. Bootstrap per `assistant/workflows/new-session-bootstrap.md`, paying particular
   attention to `assistant/memory/decisions-log.md` D-002 (the current domain
   decomposition) and any open decomposition question in `open-questions.md`.
2. Identify which `Project_To-Do List.md` §10 bullet this session addresses (context
   diagram, package organization, stakeholder model, BDD, IBD, information-object model,
   interface/item-flow model, activity diagram, responsibility swimlane, sequence
   diagram, requirements model, or a specific trace).
3. Before adding a new element, check whether it already exists under a different name —
   skim the current package structure / XML rather than assuming.
4. Make the change. For structural changes (new domain, new package, renamed boundary),
   also update `assistant/memory/project-brief.md`'s "Candidate top-level domains"
   section and log the change in `assistant/memory/decisions-log.md` if it's a real
   decision (not just filling in detail within an already-agreed structure).
5. Update the relevant trace: stakeholder need -> objective -> requirement -> system ->
   activity -> information exchange -> decision -> aircraft behavior (per §10's trace
   bullets). Partial traces are fine mid-project; note the gap in `open-questions.md`.
6. Check off the corresponding `Project_To-Do List.md` §10 box(es).
7. Wrap up per `assistant/workflows/session-wrap-up.md`.

## Notes

- Resist adding architecture detail that isn't traceable to a stakeholder need or a
  piece of literature evidence just because it "seems right" for the NAS — per
  `project-brief.md`'s working assumptions, the point is a defensible, bounded model,
  not an exhaustive one.
