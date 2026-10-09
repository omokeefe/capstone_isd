# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-10-08 (see `journal/2026-10-08.md`, 22:38 Sign-Off, written 2026-10-09). The "Active" list below was last fully reviewed 2026-09-26 and has stale entries.

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

- Operational IBDs (§10, ECD 10-25): aircraft IBD built and hand-reviewed 2026-10-08 (D-011, D-012); links not evidence-graded. Airspace IBD is a placeholder with the `atc` umbrella question open. See journal 2026-10-08.

- Context diagram (§10, slipped from 09-07): revised per the owner's hand review 2026-10-08 (D-012). Box still open: the reason behind each link is not written. See `open-questions.md` "Diagram review".

- Nominal-flight activity diagram (§10, slipped from 10-01): in progress 2026-10-06. Inputs/outputs on `PrepareForDeparture`, `Prework` and `SupplyFuel` added, view renders. No swimlanes, sub-actions still placeholders. See journal 2026-10-06.

- Python `.venv/` with `syside` 0.11.0 created 2026-10-06 (git-ignored). Import tested only; licence for the Python package unverified.

- §11 experiment definition (2026-10-04): reframed, baseline sourced, prior work read; nothing decided yet. See journal 2026-10-04 (14:20, 16:30, 20:30) and `evidence/prior-work-experiment-definition/prior-work-writeup.md`.

- §11 central claim questioned (2026-10-05): candidate reframing is a model-wide check for decisions made without needed information, with the simulation as one measured example. Not decided. Sheth dispatcher-ratings evidence added. See journal 2026-10-05 and `open-questions.md` §11.

- Three unregistered PDFs in `evidence/sources/` (two Sheth papers, SESAR Solutions Catalogue 2019). See `open-questions.md` "Reference-register housekeeping".

- Blocked on adviser: scope option (a/b/c) and current-state metric. No record that the meeting happened.

- JO 7110.65BB: ~65 ¶ read in full 2026-09-26 and approved by user. Admin follow-through deferred to 09-27 (to-do §4 status/boxes, source-register, interaction-catalog §7, exchange-evidence, open-questions). See journal 2026-09-26 19:25. Seamster crosswalk "owner to confirm" rows (ATC Coordinator, TMU/Command Center, Radar Associate, load planner) are still open.

- Advisor meeting this week, date TBD. Goal: arrive with the context diagram closed and BDD questions written down.

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

See `journal/2026-10-08.md` (22:38 Sign-Off) for reasoning; item 1's detail is in `journal/2026-10-05.md` (21:26 Sign-Off).

1. Review the drafted experiment one-pager (`knowledge/models/experiment-definition.md`, AI draft 2026-10-06) and make its four "Decide" items, central claim first. Capped at one hour. Do the hand check on three or four context-diagram decisions. Take it and the scope question (a/b/c) to the adviser.
2. Re-date the traceability chain (ECD 10-12, not started) and its dependents (10-17, 10-20) against Interim Report #2 (10-25).
3. Grade the default aircraft IBD links and work the "Diagram review" questions in `open-questions.md`; then the `atc` umbrella question on the airspace IBD.
4. Carried over: finish the activity diagram (connect `Prework`, real sub-actions, swimlanes, hub-to-hub walkthrough); confirm the Syside licence from Python in `.venv`; register the three new PDFs and confirm the ten-factor table's source; deferred §4 admin updates; sequence diagrams.
