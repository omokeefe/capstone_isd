# Open Questions

A parking lot for unresolved scope/boundary/definitional questions. When one gets
resolved, move the resolution into the relevant file (usually
`../../projects/nas-sos-capstone/index.md` or `../../decisions/decisions-log.md`) and
delete it from here — don't let answered questions linger.

## System boundary (to-do-list.md §1 "Define initial System of Interest")

- [x] Included/excluded scope has a working draft: `index.md` names 9 candidate domains;
  general aviation, military airspace (beyond its PESTLE/objective stakeholder role), and
  international airspace are provisionally excluded. Not yet ratified as a formal
  boundary.
- [ ] What level(s) of abstraction will the model operate at? (Enterprise policy down to
  control-surface deflection is an enormous range — the trajectory-intent chain in
  `index.md` spans it conceptually, but the model can't render every level in equal
  detail.)
- [ ] What criteria decide where a *system* boundary is drawn (vs. just listing
  components)?
- [ ] What criteria decide where a *stakeholder/actor* boundary is drawn?

## SysML draft reconciliation (§10)

- [ ] Several candidate-systems-inventory.md items were left out of that draft pending
  verification: AMAN and ETFMS under Airspace Management (ETFMS reads as
  EUROCONTROL-specific rather than a NAS system; AMAN was itself marked uncertain on the
  source diagram), and GMTOs/ANSPs (generic international terms, not confirmed NAS
  entities). Verify against real FAA nomenclature before adding.
- [ ] Constituent systems in that draft trace to candidate-systems-inventory.md (evidence)
  but not yet to any formal stakeholder need / requirement — the
  need → objective → requirement → system trace (to-do-list.md §10) is not started for
  this content.

## Scenario / simulation content (§10, §12-§13)

- [ ] `cameo_models/scenarios/hub-to-hub-example.sysml` (2026-09-19) is a pattern demo,
  not a decided scenario: ORD/JFK, the SID name "BENKY4," and the approach name "ILS RWY
  22L" are placeholders, not verified against real published procedures. Replace with a
  real scenario once one is chosen (see `knowledge/models/conops-scenarios.md`), or
  verify the procedure names if this specific scenario is kept.
- [ ] `simulation/vehicle_dynamics.py`'s point-mass model (2026-09-19 first pass) is
  kinematic, not aerodynamic — no drag, wind, or weight-dependent performance. Fine as a
  §12 "minimum viable simulation," but don't treat its output as physically validated
  beyond that.
- [ ] SysML v2's `individual` modifier (specific occurrence-with-a-lifetime) wasn't
  confirmed against this project's tool as of 2026-09-19 — public documentation didn't
  have a worked example. `workflows/sysml-instance-modeling.md` uses plain usages with
  bound values instead; revisit `individual` if a real need for identity/lifetime
  semantics (vs. just concrete values) comes up.

## Decomposition choice (§6)

- [ ] Is the authority/responsibility/information-ownership decomposition
  ([[decisions-log]] D-002) final, or will the project retain multiple parallel
  viewpoints (organization-based, lifecycle-based, physical, information-flow,
  decision-authority) as §6 suggests?

## Literature gaps

- [ ] Nominal ATC/IFR flight-execution research (§4) hasn't identified specific FAA
  source documents yet (AIM? 7110.65? advisory circulars?).

## Reference-register housekeeping


## Optimization study scope (§11)

- [ ] §12 as written (full experiment matrix, Pareto fronts, sensitivity analysis,
  tipping-point identification) reads as a full optimization study — in tension with the
  "not an optimization paper" guardrail (README.md, CLAUDE.md) and the report's 15–40
  page cap. Recommend scoping §11–§14 to one representative scenario, a single weight
  sweep, and one Pareto-style comparison, with broader sweep/sensitivity work kept as
  future work. Not yet decided; revisit once §7–§8 progress.
