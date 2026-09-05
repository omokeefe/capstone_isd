# Open Questions

A parking lot for unresolved scope/boundary/definitional questions. When one gets
resolved, move the resolution into the relevant file (usually
`../../projects/nas-sos-capstone/index.md` or `../../decisions/decisions-log.md`) and
delete it from here — don't let answered questions linger.

## System boundary (to-do-list.md §1 "Define initial System of Interest")

- [ ] What is explicitly **included** in the SOI? (Working draft in `index.md`
  names 9 candidate domains — not yet ratified as a boundary.)
- [ ] What is explicitly **excluded**? (E.g., is general aviation in scope? Military
  airspace operations beyond their role as a PESTLE/objective stakeholder? International
  airspace outside US NAS?)
- [ ] What level(s) of abstraction will the model operate at? (Enterprise-level policy
  down to control-surface deflection is an enormous range — the trajectory-intent chain
  in `index.md` spans all of it conceptually, but the model itself likely can't
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

## Reference-register housekeeping (2026-09-04 sweep)

- [ ] `jain2011pkm` ("Personal Knowledge Management: The Foundation of Organisational
  Knowledge Management") rated 1/5 — off-topic for this register (library/information
  science, zero aerospace/MBSE content). Decide whether to keep it in
  `evidence/sources/` or remove it. See [[source-register]].
- [ ] `yao2026loAltitudeSoSSafety` cites a DeLaurentis 2005 SoS-taxonomy paper ("A
  Taxonomy-Based Perspective for Systems-of-Systems Design Methods," IEEE SMC 2005) that
  may be a *different* work from the PDF registered as `delaurentis2005sosTransportation`
  ("Understanding Transportation as a System-of-Systems Design Problem," AIAA 2005-123).
  Confirm which paper the registered PDF actually is before citing either.
- [ ] `younus2026fmeaOntology` cites the same Lu et al. design-ontology work as
  `luDesignOntologyMBSE2020` but gives its venue/year as *IEEE Systems Journal*, 2022,
  vs. the registered arXiv 2020 entry — reconcile which is the authoritative citation.

## Optimization study scope (§11)

- [ ] Which "tractable representative operational scenario" will actually be used for
  the multi-objective optimization demonstration? Not yet chosen — depends on how far
  the architecture and stakeholder-objective work (§7–§8) get first.
- [ ] §12 as written (full experiment matrix, Pareto fronts, sensitivity analysis,
  tipping-point identification) reads as a full optimization research study, which sits
  in tension with the project's own working assumption that optimization should stay a
  bounded capability inside the architecture, not the whole subject (README.md "Working
  Assumptions"; CLAUDE.md's "not an optimization paper" guidance), and with the report's
  15–40 page length cap
  (`projects/nas-sos-capstone/prework/503_ReportTemplate_v26.docx`). Flagged 2026-08-29
  while building `projects/nas-sos-capstone/report/` — recommend scoping the §11–§14
  demonstration to one representative
  scenario with a single weight sweep and one Pareto-style comparison, with any broader
  sweep/sensitivity work kept as an appendix or future-work item rather than the main
  narrative. Not yet decided; revisit once §7–§8 are further along.
