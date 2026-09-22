# Open Questions

A parking lot for unresolved scope/boundary/definitional questions. When one gets
resolved, move the resolution into the relevant file (usually
`../../projects/nas-sos-capstone/index.md` or `../../decisions/decisions-log.md`) and
delete it from here — don't let answered questions linger.

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

## Course minimum requirements fit (from `prework/course-info-canvas.md`, 2026-09-21)

The course sets minimum requirements for academic credit. Each needs an explicit answer
in the report; none is answered anywhere in the repo yet.

- [ ] **Current-state metric.** The course requires "a metric (or set of quantifiable
  measurables) to summarize current state conditions" that can also show improvement or
  potential for improvement. What is the metric for an architecture project? Candidates
  live in the §11 optimization study (e.g. airline fuel cost vs. ATC/ANSP sector
  workload), but the study scenario is still undecided.
- [ ] **Improvement claim.** The course accepts actual improvement or "evidence and/or
  effective logic-based arguments" of potential improvement, including via simulation.
  Which of those will this project rely on? This is the adviser's call to confirm.
- [ ] **Value to the sponsor.** Who is the sponsor for this project (faculty adviser only?),
  and what does "value-added" mean to them? Dollar benefits are preferred but the report's
  Impact section already flags that a literal dollar figure may not be meaningful (see
  `report/sections/06_impact_financial_benefits.tex`). Ask the adviser whether an
  operational-terms headline with a caveated dollar estimate is acceptable.
- [ ] **Course page says "Winter 2026"** but the dates (Sep 20-Dec 13) are Fall 2026.
  Probably stale template text; the dates are what matter, but worth a glance.

## Decomposition choice (§6)

- [ ] Is the authority/responsibility/information-ownership decomposition
  ([[decisions-log]] D-002) final, or will the project retain multiple parallel
  viewpoints (organization-based, lifecycle-based, physical, information-flow,
  decision-authority) as §6 suggests?

## Literature gaps

- [ ] Nominal ATC/IFR flight-execution research (§4): **partly answered 2026-09-20** — the
  ATC-side source is FAA JO 7110.65BB (`faa2025jo711065bb`, in the register), and
  `seamster2011collabSystems` supplies the interaction sequence; paragraph pointers are in
  [[interaction-catalog-flight-execution]] but BB's decision-authority text has not been read
  or extracted yet. Still open: the flight-crew side (AIM, 14 CFR 91/121, airline FOM) and the
  dispatch side (14 CFR 121 / AC 121-32A).

## Actor abstraction (Seamster crosswalk, 2026-09-20)

Raised by mapping the source's roles onto the personas — details in
[[interaction-catalog-flight-execution]] §1.

- [ ] Does the project need an **ATC Coordinator** persona (the airline-side single contact with ATC / the
  Command Center), or is it folded into Airline Dispatcher? The source and `berry2011aocActors`
  describe different authority and information for the two.
- [ ] How should the source's **"TMU"** (a unit) and **"Command Center"** map onto the three ARTCC and three
  national traffic-management persona stubs? Proposal: keep the group as the counterpart and split by role
  only when a scenario needs a different authority.
- [ ] **Radar Associates** at TRACON/tower (and the En Route Radar Coordinator and sector Supervisor) have no
  persona — fold into the radar-position personas, or add stubs? And does "Data / Assistant Controller" mean
  BB's Radar Associate ("D-side"), Radar Flight Data ("A-side"), or both?
- [ ] **Load planner** sits in the airline OCC in this project's tree but in a separate RAMP group in the source —
  which placement does the model use?
- [ ] Is ATC modeled at **position level or team level**? JO 7110.65BB ¶2-10 treats the team as responsible and
  lets one controller fill several positions.
- [ ] Is **automation** (ACARS, HOST/ERAM, PVD, EDST, FMS) a collaborator/actor or a system? The 2011 report treats it as
  part of a group today and as a fourth collaborator under NextGen.

## Reference-register housekeeping


## Optimization study scope (§11)

- [ ] §12 as written (full experiment matrix, Pareto fronts, sensitivity analysis,
  tipping-point identification) reads as a full optimization study — in tension with the
  "not an optimization paper" guardrail (README.md, CLAUDE.md) and the report's 15–40
  page cap. Recommend scoping §11–§14 to one representative scenario, a single weight
  sweep, and one Pareto-style comparison, with broader sweep/sensitivity work kept as
  future work. Not yet decided; revisit once §7–§8 progress.
