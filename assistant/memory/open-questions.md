# Open Questions

A parking lot for unresolved scope/boundary/definitional questions. When one gets
resolved, move the resolution into the relevant memory file (usually
`project-brief.md` or `decisions-log.md`) and delete it from here — don't let answered
questions linger.

## System boundary (Project_To-Do List.md §1 "Define initial System of Interest")

- [ ] What is explicitly **included** in the SOI? (Working draft in `project-brief.md`
  names 9 candidate domains — not yet ratified as a boundary.)
- [ ] What is explicitly **excluded**? (E.g., is general aviation in scope? Military
  airspace operations beyond their role as a PESTLE/objective stakeholder? International
  airspace outside US NAS?)
- [ ] What level(s) of abstraction will the model operate at? (Enterprise-level policy
  down to control-surface deflection is an enormous range — the trajectory-intent chain
  in `project-brief.md` spans all of it conceptually, but the model itself likely can't
  render every level in equal detail.)
- [ ] What criteria decide where a *system* boundary is drawn (vs. just listing
  components)?
- [ ] What criteria decide where a *stakeholder/actor* boundary is drawn?

## Decomposition choice (§6)

- [ ] Is the "domains built around authority/responsibility/information ownership"
  decomposition ([[decisions-log]] D-002) the final one, or will the project retain
  multiple parallel viewpoints (organization-based, lifecycle-based, physical,
  information-flow, decision-authority) as §6 suggests might be the right call?

## Literature gaps

- [ ] Several `references.bib` entries have no PDF yet ( `yan2008integrated`,
  `timetableFleetPassengerChoice`, `crewSchedulingReview`,
  `aircraftMaintenanceRoutingReview`, `turnaroundCDM`, `garg2024integrated`,
  `loadControl2026`, `eurocontrolACDMManual` — see [[source-register]]). Track down PDFs
  or confirm access before their "read and annotate" checklist items can start.
- [ ] Nominal ATC/IFR flight-execution research (to-do §4) hasn't identified specific FAA
  source documents yet (AIM? 7110.65? specific advisory circulars?).
- [ ] `yan2008integrated`'s bib entry is explicitly flagged "verify authors, volume,
  issue, pages, and DOI" — needs bibliographic confirmation, not just a PDF.

## Optimization study scope (§11)

- [ ] Which "tractable representative operational scenario" will actually be used for
  the multi-objective optimization demonstration? Not yet chosen — depends on how far
  the architecture and stakeholder-objective work (§7–§8) get first.
- [ ] §12 as written (full experiment matrix, Pareto fronts, sensitivity analysis,
  tipping-point identification) reads as a full optimization research study, which sits
  in tension with the project's own working assumption that optimization should stay a
  bounded capability inside the architecture, not the whole subject (README.md "Working
  Assumptions"; CLAUDE.md's "not an optimization paper" guidance), and with the report's
  15–40 page length cap (`prework/503_ReportTemplate_v26.docx`). Flagged 2026-08-29 while
  building `report/` — recommend scoping the §11–§14 demonstration to one representative
  scenario with a single weight sweep and one Pareto-style comparison, with any broader
  sweep/sensitivity work kept as an appendix or future-work item rather than the main
  narrative. Not yet decided; revisit once §7–§8 are further along.
