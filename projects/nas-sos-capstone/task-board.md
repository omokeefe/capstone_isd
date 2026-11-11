# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-11-07, morning (owner's presentation slot and slide deck recorded; 11-02 to 11-05 work committed as `af4109c`). Last sign-off: `journal/2026-11-05.md`.

## Current phase

**Turn 4 of the nine-turn plan (Nov 2 to 8; D-016).** Next graded dates: **presentation Thu Nov 19, 10 AM** (slot registered by the owner weeks ago; upload by Fri Nov 20), Review #3 Nov 22 (option resolved by the owner). OpenAP fallback closed (D-038).

**Still open from Report #1 (Track C edits):** the literature-review annotation-coverage claim, citation spot-checks against skimmed-only sources, the 1998-dollar disruption-cost figure.

## Active

- Presentation (Track C), 2026-11-07: slot Thu Nov 19, 10 AM. Working deck: `report/presentations/503 Project Presentation - O'Keefe (210055806) - NAS SoI.pptx`, saved from the template on 11-07; not yet in git. `503 Project Presentation Template-v26.pptx` in the same folder holds the 11-05 copy (committed) and is no longer the working file. The deck has 13 slides: six of the owner's (title, overview, methodology, preliminary results, benefits, thank you) and the template's seven example slides (7 to 13), still to remove. Slides complete by Sun Nov 15 (Turn 5 exit test).

- Report (Track C), 2026-10-14: the owner wrote the literature review and research gap in Section 1 and stated the two claims there (not yet in the Executive Summary). `\cite{great2023}` is undefined; fix before rebuilding. See journal 2026-10-14 21:44.

- Report and model (all tracks), 2026-11-05: owner's print review transcribed (`handwritten/2026-11-05_main.md`) and applied (D-039, D-040). Owner-prose items and Claude drafts to review are listed there. See journal 2026-11-05.

- Requirements (Track A), 2026-11-05: second HLR review applied (D-040). 30 SN / 42 SLR / 31 HLR; SLR-CLR-13 "shall", split into HLR-ATC-10/11/05; no overlap (owner rule). Open: SLR-CLR-13 measure TBD. HLR-ATC-10, 11 and 05 and SLR-CLR-13 baseline, every case judged by its own estimate (D-042 to D-044, 2026-11-08 and 11-10); Table 5 has two HLRs (HLR-OPS-05, HLR-ATC-08). See journal 2026-11-05.

- Experiment (Track B), 2026-11-10: sixth run (D-047; O8 closed, AC1 cannot pass FL360): A and B O10, C/D O4; B − A = 0, C − B = −28.8 kg. Slide 5's results-table image and the notes on slides 5 and 6 still show the fifth run. Fallback closed (D-038); hand checks done (D-042); low-CI run is "if time". See journal 2026-11-10.

- Behavior views (Track A): sequence updated to the fifth run and G1/G2 closed 2026-11-05 (D-040); owner hand review open. G4 down to three drafted item defs. See journal 2026-11-05.

- Syside rendering unblocked by 2026-11-02 (renders with `.venv/Scripts/python.exe`; plain `python` not on PATH).

- Model (Track A): `nas_analysis.sysml` (fidelity levels, calc defs, analysis def), `nas_verification.sysml` (six verification cases), and the D-019 interface (`AirlinePerformanceShare`, ports on the AOC and ATC, unrendered interface usage on the context diagram) added 2026-10-10; whole folder passes `syside check`. The other two thread interfaces (FMS → AOC, ATC → crew) are turn 2. Swimlane answer recorded in `sysml-diagram-rendering.md` §9; sequence view untested.

- Report (Track C), 2026-10-13: second hand review of the print applied (D-027; `handwritten/2026-10-13_main.md`). Section 1 is "Introduction" with nine subsections; the worked example and the decider's equation are gone; 43 pages, builds clean. Twelve passages are marked blue for the owner to rewrite, eight of them new. Open for the owner: where the proposed interface goes, the empty status of "Integration into MBSE Architecture" in the old-plan table, the "expand upon" paragraph at the head of Section 2.

- Report (Track C), 2026-10-11: restructured from the owner's hand review of the print (D-026; `handwritten/2026-10-11_main.md`). Six sections; the experiment is Section 3. Eight passages are Claude's drafts, marked blue in the PDF, for the owner to rewrite; five notes are still open (list at the end of the transcription). Before that: `\irtwo` call-outs mark every part Interim Report #2 needs; checklist in `report/README.md`. Section 3 has the SE-approach table skeleton, the two-claims and proposed-interface subsections; Section 4 has the two figure slots and the experiment tables. Owner writes the prose.

- Operational IBDs (§10, ECD 10-25): aircraft IBD built and hand-reviewed 2026-10-08 (D-011, D-012); links not evidence-graded. Airspace IBD: `atc` one box (D-038), its decision support drawn inside it (D-040), moved to the appendix (D-039). Aircraft default view simplified 2026-11-05 (D-040). See journal 2026-10-08, 2026-11-05.

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

Turn 4 ends Nov 8; slides complete by Nov 15 (Turn 5 exit test); presenting Thu Nov 19, 10 AM. See journal 2026-11-05 Sign-Off and 2026-11-07.

1. Review the D-040 drafts: two verification statements in Table 5 (HLR-ATC-05, 10 and 11 settled, D-042 to D-044, and out of Table 5), Section 3.6 "same obstacle" passage (manufacturer claim unsourced), Section 5 reliability paragraph; answer transcription item 3.2.
2. Finish the slides in the working deck (above): remove the template's example slides 7 to 13; add the deck to git when ready (leave out the `~$…pptx` lock file).
3. Hand-review the updated sequence and do the O4 hand check.
