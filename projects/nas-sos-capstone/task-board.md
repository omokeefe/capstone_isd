# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-10-10, evening (plan adopted as D-016; see `journal/2026-10-10.md`). The "Active" list was rewritten the same evening.

## Current phase

**Turn 1 of the nine-turn plan (Oct 10 to 18; D-016).** Interim Report #2 is due Sun 2026-10-25. The plan of record is the turn table at the top of `to-do-list.md`; each turn has an exit test. Report #1 was submitted 2026-09-17 with all content reviewed and finalized by the owner.

**Still open from Report #1 (Track C edits):** the literature-review annotation-coverage claim, citation spot-checks against skimmed-only sources, the 1998-dollar disruption-cost figure.

## Active

- Requirements (Track A): owner's review in progress per the `#TODO` block at the top of `knowledge/models/requirements-and-traceability.md` (27 stakeholder requirements first, then the 15 on the thread, then the three-to-five next-tier ones). Five requirements tagged `improved` (D-018). See journal 2026-10-10.

- Experiment (Track B): OpenAP chosen and installed (D-017); `simulation/experiment_scoring.py` runs the base scenario end to end, 14 tests pass; first result C minus B = 0 (`experiment-options-and-scoring.md` §8). Every scenario number is a Decide item in `knowledge/models/experiment-scenario-numbers.md`. Two OpenAP figures in `report/figures/`.

- Model (Track A): `nas_analysis.sysml` (fidelity levels, calc defs, analysis def), `nas_verification.sysml` (six verification cases), and the D-019 interface (`AirlinePerformanceShare`, ports on the AOC and ATC, unrendered interface usage on the context diagram) added 2026-10-10; whole folder passes `syside check`. The other two thread interfaces (FMS → AOC, ATC → crew) are turn 2. Swimlane answer recorded in `sysml-diagram-rendering.md` §9; sequence view untested.

- Report (Track C): `\irtwo` call-outs mark every part Interim Report #2 needs; checklist in `report/README.md`. Section 3 has the SE-approach table skeleton, the two-claims and proposed-interface subsections; Section 4 has the two figure slots and the experiment tables. Owner writes the prose.

- Operational IBDs (§10, ECD 10-25): aircraft IBD built and hand-reviewed 2026-10-08 (D-011, D-012); links not evidence-graded. Airspace IBD is a placeholder with the `atc` umbrella question open. See journal 2026-10-08.

- Context diagram (§10, slipped from 09-07): revised per the owner's hand review 2026-10-08 (D-012). Box still open: the reason behind each link is not written. See `open-questions.md` "Diagram review".

- Nominal-flight activity diagram (§10, slipped from 10-01): in progress 2026-10-06. Inputs/outputs on `PrepareForDeparture`, `Prework` and `SupplyFuel` added, view renders. No swimlanes, sub-actions still placeholders. See journal 2026-10-06.

- Python `.venv/` with `syside` 0.11.0 created 2026-10-06 (git-ignored). Import tested only; licence for the Python package unverified.

- §11 experiment definition (2026-10-04): reframed, baseline sourced, prior work read; nothing decided yet. See journal 2026-10-04 (14:20, 16:30, 20:30) and `evidence/prior-work-experiment-definition/prior-work-writeup.md`.

- §11 central claim questioned (2026-10-05): candidate reframing is a model-wide check for decisions made without needed information, with the simulation as one measured example. Not decided. Sheth dispatcher-ratings evidence added. See journal 2026-10-05 and `open-questions.md` §11.

- Sources: every file in `evidence/sources/` has a ledger row as of 2026-10-10 (the two Sheth papers and the SESAR catalogue registered; OpenAP, the INCOSE Guide to Writing Requirements and ISO/IEC/IEEE 15288 as web-only entries). Confirm the GtWR document number before citing.

- Adviser meeting held (reported by the owner 2026-10-10; meeting date not recorded). The adviser endorsed the project, its focus, and a scope that varies with schedule and availability. No longer blocked on the scope option (a/b/c): the owner sets scope against the schedule. The owner did not report an answer on the current-state metric, so it is treated as still open and the owner's to propose.

- JO 7110.65BB: ~65 ¶ read in full 2026-09-26 and approved by user. Admin follow-through deferred to 09-27 (to-do §4 status/boxes, source-register, interaction-catalog §7, exchange-evidence, open-questions). See journal 2026-09-26 19:25. Seamster crosswalk "owner to confirm" rows (ATC Coordinator, TMU/Command Center, Radar Associate, load planner) are still open.

- Plan adopted 2026-10-10 as D-016 after the owner's line-by-line review; `to-do-list.md` restructured (turns, four tracks, Future work). `project-plan-proposal-2026-10-10.md` is superseded and kept as history. The owner may still change any tailoring row.

- First-pass SysML v2 BDD in the model (file map: `cameo_models/sysmlv2_exploration.md`;
  2026-09-19): NAS + 9 D-002 domains as packages, constituent systems populated from
  `../../knowledge/models/candidate-systems-inventory.md`, filtered to the pre-ratification
  SOI boundary. This text is the source of truth (D-006); it is not in Cameo, and Cameo
  hand-off is optional and deferred. Gaps logged in
  `../../knowledge/questions/open-questions.md` ("SysML draft reconciliation").

- New capability, same day: instance/scenario modeling and a vehicle-dynamics simulation
  capability, plus two new workflows/skills (`sysml-instance-modeling`,
  `vehicle-simulation-model`) to do more of this going forward. Built a first
  end-to-end example: `cameo_models/scenarios/hub-to-hub-example.sysml` (flight + two
  airports + SID/approach procedures + an initial `AircraftState`) driving
  `simulation/vehicle_dynamics.py` (point-mass kinematic model, tests passing). See
  D-005 and `journal/2026-09-19.md` (11:52 entry) for the file-layout/integration
  decisions. Gaps: placeholder procedure names, `individual` SysML keyword unconfirmed —
  both in `open-questions.md`.

- Drafted the full §8 pass in
  `../../knowledge/models/stakeholder-objective-ontology.md` — objective,
  classification, MOP, MOE, trajectory-decision impact, and abstraction comment for all
  seven §8 stakeholder categories, plus a cross-category conflicts/alignments/
  externalities/timescales synthesis. See
  `sessions/2026-09-06-stakeholder-objective-ontology.md`. Flags Military and
  Environmental/Societal as the least-grounded categories (no persona, no literature yet)
  — revisit once §2-§4 annotation reaches relevant sources. Named a front-runner §11
  optimization-study candidate (airline fuel cost vs. ATC/ANSP sector workload) and a
  `knowledge/claims/` candidate (CO2 vs. contrail/non-CO2 climate effects, an
  intra-stakeholder conflict).


- Reconcile the SysML BDD and context/stakeholder views with the ratified SOI in D-007 —
  see `journal/2026-09-21.md`.

- Drafted a candidate §5 ConOps scenario ("Hub-to-Hub Trajectory Cost vs. Sector
  Workload Tradeoff") in `../../knowledge/models/conops-scenarios.md` and a full
  phase-by-phase elaboration in
  `../../knowledge/models/conops-hub-to-hub-trajectory-cost.md`. Not yet reviewed by the
  user — see `journal/2026-09-17.md` (20:37, 20:49, 21:09 entries) for the reasoning and
  open issues (city pair, background-bank size, monetization placeholders unset).

- New: `session-welcome`/`session-signoff` skills replace the old
  `session-bootstrap`/`session-tagup`/`session-wrap-up` skills — session narrative now
  lives in the daily journal instead of `sessions/`. See `journal/2026-09-17.md` (21:24
  Sign-Off) for what changed. Unexercised so far; watch for rough edges.


## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and open
  design questions. Partially addressed by the 2026-09-05 reorg (workflows/personas/
  templates are now workspace-level, ready to be reused if a second project starts) —
  revisit whether a separate portable template folder is still wanted, or whether "reuse
  this repo's structure" is now sufficient. No target date.

## Next session priority

Turn 1 exit test (by Sun 2026-10-18): the central claim and four decisions logged (done, D-016 to D-019); OpenAP returns B39M numbers and both figures render (done); the owner has reviewed the 27 stakeholder requirements; Assumptions and Methodology drafted. See `journal/2026-10-10.md`.

1. Owner: confirm or change the Decide items in `knowledge/models/experiment-scenario-numbers.md` (city pairs, masses, cost indexes, hold length, tie-breaker) and re-run `tools/run_experiment.py`. The first run's C minus B = 0 hangs on the hold length and the pair's level.
2. Owner: the 27 stakeholder requirements (`requirements-and-traceability.md`, `#TODO` item (a)), about 3 hours; then draft Assumptions and Methodology from the `\irtwo` call-outs in `report/sections/03_assumptions_methodology.tex`.
3. Owner: re-word the five view captions in `cameo_models/nas_package_my_views.sysml` and the appendix lead-in; restate or strike the eight candidate entries in `lessons-learned.md`.
4. Claude, turn 2: the FMS → AOC and ATC → crew interface defs; test one `SequenceView` example; `tools/check_model.py` on the Syside Python API.
5. Carried over: the two hand checks (`experiment-definition.md` §9); grade the aircraft IBD links; the `atc` umbrella question; whether the adviser meeting counts as the Report #2 review meeting.
