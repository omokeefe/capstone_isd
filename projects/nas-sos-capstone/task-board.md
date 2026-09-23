# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-09-22 (see `journal/2026-09-22.md`, context-diagram connection sign-off)

## Current phase

**ISD 503 Interim Report #1 was submitted 2026-09-17**, ahead of its 2026-09-20 ECD —
the user rewrote the six required subsections into their own judgment before
submitting, emailed the Word copy to faculty adviser Mark Petrotta, and completed
Progress Status Update #1 on Canvas. See `to-do-list.md` §1 for the full checkbox
state.

`to-do-list.md` §1 ("Establish Research Framework") remains the current phase, but its
SOI boundary and research-question work were ratified and closed on 2026-09-21 through
D-007. §8 (Objective / Cost / Value Ontology) is fully drafted out of sequence;
§2-§7, §9-§16 otherwise remain in progress or not yet started.

**Resolved (2026-09-17) — AI-drafted content in the report (flagged 2026-09-14):**
the ghostwriting concern from 2026-09-14 (Claude drafted full prose for all six
required subsections in `report/sections/02_introduction.tex` without being asked) is
now resolved — the user rewrote that content into their own judgment/words before
submitting. See memory `feedback_coach-not-ghostwrite-coursework` and
`project_interim-report-1-2026-09-20` (now marked closed).

**Still open — independent capstone work:** the literature-review
annotation-coverage claim, citation spot-checks against skimmed-only sources, the
1998-dollar disruption-cost figure, and the §11 optimization-study scenario choice.
The SOI boundary is no longer provisional; see D-007 and the SOI definition.

## Active

- 2026-09-22: finalize the NAS context-diagram connection set in `cameo_models/nas_context_diagram.sysml`; keep the diagram scoped to the D-007 SOI boundary and omit unnecessary environment links until the stakeholder model is reconciled.

- 2026-09-20: extracted the Seamster et al. (2011) interaction tables (702 rows) and mapped its actors to the personas (`../../knowledge/models/interaction-catalog-flight-execution.md`); JO 7110.65BB added to the register. Waiting on the user: confirm the crosswalk rows marked "owner to confirm" (ATC Coordinator, TMU/Command Center, Radar Associate, load planner) and read BB ¶2-10, 3-7-2, 3-9-10, 4-3-2/-4, 5-4-5..-9 for decision-authority text (§4 boxes intentionally unchecked).

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

See `journal/2026-09-21.md` (21:17 Sign-Off) for full reasoning. Terse version:

1. Verify or replace the demo scenario's placeholder procedure names (BENKY4, ILS RWY
   22L), or replace `cameo_models/scenarios/hub-to-hub-example.sysml` entirely once a
   real ConOps scenario/city-pair is decided.
2. Create the NAS context diagram (§10, slipped since 2026-09-07).
3. Create the stakeholder model / map (§10, slipped since 2026-09-07) — likely
   derivable from `../../knowledge/models/stakeholder-register.md`.
4. Verify ETFMS/AMAN/GMTOs/ANSPs against real FAA nomenclature before adding to
   `cameo_models/nas_sysml_package_definitions.sysml`'s Airspace Management package.
5. Fix the missing D-003/D-004 entries in `decisions/decisions-log.md` (index.md
   references them; the log itself skips from D-002 to today's new D-005).
6. Still open from before: work `to-do-list.md` start §2-§4 literature-review sessions
   (5-rated sources first: `eltoukhy2017airline`, `hassanDisruptionReview`,
   `schultz2017turnaround`, `clarke1998irregular`, `dispatcherWorkload2025`,
   `eurocontrolACDMSpec`).
