# Decisions Log

ADR-style record of decisions and why they were made. Append new entries at the top
(newest first). Don't rewrite old entries when a decision changes — add a new entry that
supersedes it and link back with `[[decisions-log]]`-style references or a direct note.

---

## D-031 — Keep every stakeholder requirement; make the study's cut at the HLR tier

**Date:** 2026-10-20
**Status:** active. Owner direction from the hand-marked print (`projects/nas-sos-capstone/handwritten/2026-10-20_requirements-and-traceability.md`) and the owner's answers in session. Partly amends D-020 and D-021: what they struck is back in the model, tagged out of study, not deleted.

**Decision:**

1. **Every stakeholder requirement of the first draft is kept.** The 17 struck in the hand reviews of 2026-10-10 and 2026-10-11 are restored, with the system requirements that answered them (19). Each carries `studyScope = outOfStudy`, a new attribute in `requirements_definitions.sysml`. None has an HLR: the sub-system (HLR) tier is where the study's cut is now made. The text is what each had when struck, read off the two earlier prints; the owner's mark is kept in the rationale.
2. **Not restored:** derived system requirements (no stakeholder parent), SLR-INF-03 and SLR-INF-04 (merged into SLR-INF-02), and struck system requirements whose stakeholder parents are all in the study.
3. **SN-GOV-01 and SN-ENV-01 are tagged `background`.** The owner questioned both: the regulator's rules and the CO2 factor are inputs the study holds fixed, not objectives it weighs.
4. **Word changes applied as marked:** SN-AIR-01, SN-CRW-03, HLR-CRW-03, HLR-CRW-04 (trigger struck), HLR-OPS-06, HLR-ATC-03. SLR-CLR-15 accepted. The measure of SLR-CLR-13 is TBD.
5. **Edits made from the owner's questions, for the owner to confirm:** HLR-OPS-05 and HLR-ATC-08 name a performance model and a relative cost of flight time in place of cost index, and HLR-ATC-08 uses the best information available; HLR-ATC-05 says "systems involved"; HLR-ACF-05 no longer fixes the route to the airline; new HLR-ACF-06 (ADS-B Out broadcast).
6. **HLR-ATC-07 keeps "unable":** the held summary of JO 7110.65BB 2-1-18 uses UNABLE, not "negative".

**Rationale:** the owner's note on section 8: "I think I need to keep all stakeholder requirements, even those I won't be keeping... drop at the sub-system/HLR level", and on section 2: "How do I convey that the reqts I identify are a subset of those that would otherwise be created w/o D-007?" Keeping the full set with a scope tag shows the study's requirements as a subset of the NAS's, and the decomposition shows where each one stops.

**Alternatives considered:** restoring the stakeholder requirements without their system requirements (the cut would then sit at the system tier, not the HLR tier); removing SN-GOV-01 and SN-ENV-01 (their seven system requirements would lose a parent); recording the note as an open question only.

**Evidence / source:** the three marked-up prints in `projects/nas-sos-capstone/handwritten/`; `evidence/literature-notes/summaries/5 - faa2025jo711065bb.md` for 2-1-18.

**Consequences:** 30 stakeholder requirements (11 in the study, 2 background, 17 out), 42 system requirements (23 in, 19 out), 29 HLRs. `syside check` passes; the 32 simulation tests pass. The review workbook (`cameo_models/print/requirements-review.xlsx`, from `tools/export_requirements_xlsx.py`) shows scope and has a Coverage sheet; every gap count is 0. Supersedes the "requirements scoped to the study" practice in that the struck requirements are now carried, out of study, instead of deleted.

---

## D-030 — Hand review of the 2026-10-19 print: port sides, the conflict-resolution activity, and two performers chosen

**Date:** 2026-10-19
**Status:** active. Owner direction from the hand-marked print (`projects/nas-sos-capstone/handwritten/2026-10-19_main.md`); the `ResolveConflict` steps are Claude's draft for review.

**Decision:**

1. **Inputs on the left, outputs on the right.** Boundary ports carry a direction (`in port` / `out port`), which Syside uses to place them (tested 2026-10-19). Applied to the AOC, ATC and ATCSCC inputs, and the aircraft's ADS-B, emissions and air-data ports.
2. **The airspace management domain has a boundary:** `surveillanceIn`, `flightPlansIn`, `requestsIn` and `clearancesOut`, wired to `atc` on its IBD. Its two connections are renamed after what they carry (`trafficManagementInitiatives`, `sectorFlowRestrictions`). `tfmTools` links the ATCSCC to its tools. New item def `AirspaceManagement::Clearance`.
3. **The performance data can be located on a diagram.** ATC's `performanceShareIn` (airspace IBD) and the AOC's `performanceShareOut` (flight ops IBD) are drawn, though both are improved architecture. This reverses D-029 item 3's "not drawn".
4. **`atcResolveConflict` is decomposed** as `action def ResolveConflict`: assess, generate options, then a branch on the information level (rule only for case A, nominal weight for B, shared data for C and D), select, issue the clearance, read-back, execute, confirm separation. Its inputs are surveillance, flight plans and the performance share (missing today). The aircraft's broadcast state flows into it. View `resolveConflictActivity`, in Section 3.4 after Fly Enroute.
5. **Performers chosen:** the tower issues pushback clearance (`towerIssuePushbackClearance`); the arrival plan goes ATC → dispatch → crew (`atcSendArrivalPlanToAoc`, `aocRelayArrivalPlanToCrew`).
6. **Scope note:** the nominal operations activity is one flight's operations, not NAS operations (which would add flow management, monitoring and conflict resolution across all traffic). Prework's doc is the owner's wording.
7. **No RACCI matrix.** Appendix A.2 is "Full Stakeholder Register".
8. **Appendix landscape figures each get their own landscape block** (`tools/render_sysml_diagrams.py`). Several figures in one block printed rotated and cropped.

**Rationale:** the owner's review asked for exchanges over conceptual flow ("get away from conceptual logic flow and more into actual exchanges"), for the studied decision to be decomposed ("DO"), and for the performance data to be locatable at a port. Items 1 to 4 make the studied exchange traceable from the AOC's port, through ATC's port, into the decision's inputs.

**Alternatives considered:** one comprehensive NAS IBD (deferred: open question; the recommendation is to trace one exchange across the existing diagrams); trimming the aircraft IBD now (deferred: removing surveillance also removes the ADS-B path, and the owner's note re-routes it through the comm system, which needs a decision first).

**Evidence / source:** the owner's print; the `ResolveConflict` docs cite fothergill2013resolutionHeuristics, kirwan2001coraStrategies, engility2014tasarAlaska and JO 7110.65BB.

**Consequences:** 10 views re-rendered, 1 new; the report compiles at 56 pages. The open questions on pushback and the arrival-plan sender are resolved. New open questions: the justification pass, one NAS IBD or many, an aircraft state machine, the GREAT comparison, and Prepare for Departure.

---

## D-029 — A composition-only NAS BDD and one IBD per modeled domain

**Date:** 2026-10-19
**Status:** active. Owner direction in a working session; the links on the new IBDs are Claude's draft and are not yet reviewed.

**Decision:**

1. **New file `cameo_models/nas_block_diagrams.sysml`** holds the structure diagrams that were missing.
2. **Top-level BDD (`nasBdd`), composition only.** It shows the `NationalAirspaceSystem` block, the five modeled domains (D-007, D-008) and the systems drawn on the context diagram (atc, atcscc, airline operations center, airport, aircraft, flight deck crew), with composition lines only: no ports, attributes or exchange links, which stay on the context diagram. Systems the context diagram doesn't draw (tracon, artcc, tmu, tfmAutomation, ticketingSystem, cabinCrew) and the Environment are untagged, so they stay in the model but off the view.
3. **One IBD per modeled domain.** The aircraft and airspace management IBDs stay in their own files. Three new ones are in this file: Flight Operations (the AOC's eight roles, its decision support, and the weather and rules inputs), Airport Operations (the airport's parts, with the AMS-hub links from the prework draft), and Flight Crew (captain, first officer, EFB, cabin crew). Per D-010 each IBD holds only links inside its domain. The improved-architecture `performanceShareOut` port isn't drawn, so the views show the baseline, as the context diagram does.
4. **Every new link carries an evidence tag** in the context diagram's review key. The cabin crew to flight deck link moves here from the context diagram's commented-out draft.

**Rationale:** the context diagram shows exchanges between systems but no hierarchy. A reader following the model (BDD, then IBD, as in the standard model organization the owner attached in the 2026-10-19 journal) had no BDD and no IBD for three of the five domains.

**Alternatives considered:** consolidating the aircraft and airspace IBDs into the new file (rejected by the owner: a bigger diff, and the views and report references would move); one IBD per context-diagram system rather than per domain (rejected by the owner); a top-level view with exchange links (rejected: that duplicates the context diagram).

**Evidence / source:** owner direction; the existing definitions' docs (Berry & Pace 2011, Munro 2018, Seamster 2011, Clarke 1998, JO 7110.65BB 3-4-x); `knowledge/models/interface-exchange-draft.md` for the airport hub ([C]).

**Consequences:** four new views go to the report appendix (54 pages, builds clean). The open question "Review the three new domain IBDs" is in `open-questions.md`. The to-do Track A table has two new rows.

---

## D-028 — The report gets a System Model section between the methodology and the experiment

**Date:** 2026-10-17
**Status:** active. Owner direction in a working session; amends D-027 item 1 and settles the open question in D-027's Consequences about where the proposed interface goes.

**Decision:**

1. **New Section 3, "System Model"** (`report/sections/04_system_model.tex`), in this order: 3.1 Stakeholders (identification, candidate objectives, selection, objectives and conflicts); 3.2 Constituent Systems; 3.3 System of Interest (with the context diagram); 3.4 Operational Concept; 3.5 Architecture; 3.6 Proposed Airline-to-ATC Interface. Each subsection leads to the next, and 3.6 leads into the experiment, which measures what the interface is worth.
2. **The Introduction keeps a short summary,** "Stakeholders and Study Boundary", that names the kept stakeholders and objectives and points to Section 3. The course template expects stakeholders and scope in the Introduction; the detail lives in Section 3.
3. **Scope is not a heading.** Project scope (which decision is studied) is in the Introduction's summary; the de-scoping reasons are 3.1.3 Selection (which carries `\label{sec:scope}`); the boundary of the system is 3.3 System of Interest (`\label{sec:soi}`).
4. **Objectives and Conflicts closes 3.1** (the owner's suggestion), after Selection, because it speaks only of the stakeholders and objectives kept there.
5. **Results and Discussion stays one section** for Interim Report #2, and now carries a call-out to report the model's measures (traceability and coverage against the Deliverables measures), so the systems engineering work is assessed and not only described.
6. **Section files 04 to 08 renumbered 05 to 09;** every `\label` kept, so cross-references resolve unchanged.
7. **Claude moved blocks whole and drafted seven short passages,** each marked `AI-DRAFTED, owner to rewrite`: the section opener, a one-line description of each candidate objective (owner's request), the transition into 3.2 and a reading of the Miro board (owner's request), two sentences for 3.3, the closing link from 3.6 to the experiment (owner's request), the Introduction summary, and the experiment's opening sentence. The owner's experience behind the Miro board is a call-out for the owner.

**Rationale:** the operational concept and architecture were in Results but are not results of the experiment; the proposed interface had no home in the methodology (owner's question on the 2026-10-13 print, page 17). Grouping the stakeholder work and the model in one section lets the report read from the stakeholders' conflict, through the model, to the interface the experiment tests.

**Alternatives considered:** move Stakeholders and Scope out of the Introduction completely (rejected: a grader following the template would not find them); split Results from Discussion (deferred: one scenario gives one table and two hand checks, and a separate Discussion would sit beside Impact and Conclusions); name the section "Modelling" (British spelling; "System Model" names the deliverable).

**Evidence / source:** this session; `prework/503-ReportGuidelines-v26.docx` (Introduction lists Project Stakeholders and Project Scope).

**Consequences:** section numbers shift (Experiment 4, Results 5, Impact 6, Conclusions 7). `main.tex` mapping comment, `report/README.md`, the render-sysml-diagrams workflow, skill and script comment, `to-do-list.md`, `open-questions.md` and `conops-scenarios.md` updated to the new file names. Open: the Working Assumptions paragraph on how the System of Interest was drawn ("An entity is modeled when...") may belong in 3.3; not moved.

---

## D-027 — Second hand review of the report: Section 1 reorganized, the worked example and the decider's equation removed, decision numbers out of the text

**Date:** 2026-10-13
**Status:** active. Owner direction from the hand review of the second print (`projects/nas-sos-capstone/handwritten/2026-10-13_main.md`). Amends items 1 and 4 of D-026.

**Decision:**

1. **Section 1 is "Introduction".** Its subsections are Overview, Literature Review, Current State (new), Stakeholder Selection, System Identification and Selection (new), Scope, Stakeholder Objectives (moved from Results), Project Deliverables, Project Timing.
2. **The exploration lists are not repeated in text where a figure shows them.** The eight-item stakeholder list is removed; the figures carry it.
3. **De-scoping reasons are the owner's:** profitability falls out of the other objectives; reliability is captured with schedule reliability; maintenance and lifecycle cost are set by flight cycles, takeoff performance, distance and climb controls; throughput and capacity are left for another study and are close to the author's ongoing work.
4. **The August milestone table is kept as the old plan, with a status on each row** (not started, draft, complete, will not implement). State machines and the authority and responsibility models will not be implemented.
5. **Will not implement:** the paragraph naming alternative decompositions (August §6) and the table of abstractions with reason and risk.
6. **The report keeps one numbered equation,** the aircraft's cost. The decider's equation and the worked example are removed (amends D-026 item 4).
7. **Decision numbers (D-0xx) do not appear in the report's text, tables or captions.** Claude's reading of seven strikes; one more was removed on that reading.
8. **The limits of the experiment are assumptions and discussion in Section 2.2,** not a separate list: accurate reporting and the static snapshot are assumptions; the share of crossing conflicts, the single sector and the FL350 rule are discussion.
9. **As on 2026-10-11, Claude edited the owner's prose and drafted new passages,** each marked `AI-DRAFTED, owner to rewrite`. Twelve such call-outs are in the PDF, eight of them new. The standing agreement (the owner writes the report's prose) is unchanged.

**Rationale:** the owner's notes: Figure 3 shows "systems, not stakeholders"; the stakeholder list "becomes redundant w/ the image"; the trace back to the model "doesn't need its own section".

**Alternatives considered:** leave Stakeholder Objectives in Results (the owner's note ends in a question mark; it was moved because it speaks only of what Scope keeps). Move the proposed interface out of Section 2 now (the owner asked where it would fit; not moved, Claude's suggestion is in a call-out).

**Evidence / source:** `projects/nas-sos-capstone/handwritten/2026-10-13_main.pdf` and `.md`.

**Consequences:** section numbers in Results shift (Architecture 4.2, Experiment Results 4.3, Emissions 4.4). `report/main.tex` loads `placeins`. Open: where the proposed interface goes; the status of one milestone row; the note that the three things the project adds "need to be clear in my models" (Track A).

---

## D-026 — Report structure changed after the owner's hand review: the experiment is its own section, SysML figures can sit in the body

**Date:** 2026-10-11
**Status:** active. Owner direction from the hand review of the printed report (`projects/nas-sos-capstone/handwritten/2026-10-11_main.md`) and four answers given before the work started.

**Decision:**

1. **The report body has six sections:** 1 Introduction and Current State; 2 Assumptions and Methodology; 3 Experiment (new); 4 Results and Discussion; 5 Impact/Financial Benefits; 6 Conclusions and Recommendations (merged).
2. **"The Two Claims" is not a subsection.** The claims are stated in the Executive Summary and the Introduction.
3. **The emissions discussion is part of Results** (4.6), not of Impact.
4. **The scoring write-up cites the OpenAP and Bartel and Young papers** in place of repeating their equations. The report keeps the cost equation, the decider's estimate, the table of values, the worked example and the list of simplifications.
5. **A SysML view can be placed in the body.** A `// placement: body` line above a view's caption line takes it out of the generated appendix list; `tools/render_sysml_diagrams.py` writes `fig-<viewName>.tex` for a body section to input. All five current views are in the body.
6. **For this pass only, Claude edited the owner's prose and drafted new passages,** at the owner's explicit request. Each drafted passage is marked `AI-DRAFTED, owner to rewrite` in the PDF. The standing agreement (the owner writes the report's prose) is unchanged.

**Rationale:** the owner's notes: the experiment was buried as two subsections of the methodology; a subsection for the claims duplicated what the summary and introduction must say; the emissions subsection "doesn't warrant its own section"; the equations re-created published work. The course page allows sections of the template to be modified, added or removed with the adviser.

**Alternatives considered:** keep the experiment under Section 2 to preserve the template's numbering (offered; the owner chose a separate section); move Assumptions and Methodology ahead of Stakeholders (the owner's own question on the print; the owner chose to leave it).

**Evidence / source:** `projects/nas-sos-capstone/handwritten/2026-10-11_main.pdf` and `.md`; `projects/nas-sos-capstone/prework/course-info-canvas.md` (the template is a general guide).

**Consequences:** `report/sections/04_experiment.tex` is new; `04_results_discussion.tex` is renamed `05_results_discussion.tex`; `05_recommendations.tex` is removed; section numbers in `report/README.md`, `to-do-list.md`, `task-board.md` and `index.md` follow. Not yet told to the adviser: the departure from the template's section list.

---

## D-025 — The simulation code uses the model's definitions, and a test checks that it does

**Date:** 2026-10-11
**Status:** active. Owner direction in session ("update my python content to use the same definitions of aircraft, etc. as present in my project package definitions"), with the owner's answers on four points recorded as items 2 to 5. The names of the new definitions and attributes are Claude's, accepted by the owner the same day. Amends D-005 (the trace was by hand only) and D-019 (one attribute of the share).

**Decision:**

1. **One Python class per SysML definition the code uses, same names.** `simulation/nas_types.py` mirrors `FidelityLevel`, `MeansOfAchievement`, `ManeuverKind`, `Position`, `AircraftState`, `CruiseCondition`, `Flight`, `AirlinePerformanceShare`, `Maneuver`, `ResolutionOption` and `ScenarioFlight`. `simulation/test_model_conformance.py` reads the `.sysml` text and fails when a Python field, an enumeration value, a performance-function parameter or a camelCase key of `scenario_base.yaml` is not in the model. The model is changed first, then the Python (D-006).
2. **Units stay as the model has them.** `AircraftSystems::AircraftState` stays in SI and is what `vehicle_dynamics.py` steps. The experiment works in feet, Mach and kilograms through a new `NasAnalysis::CruiseCondition` (`massKg`, `machNumber`, `altitudeFt`), the three inputs the performance functions already took. Nothing converts one into the other. `AircraftState.fuelOnBoard` is corrected from liters to kilograms: the code and the example scenario already added it to zero-fuel weight.
3. **The share carries a delay margin in place of a priority number.** `AirlinePerformanceShare.connectionPriority : Integer` becomes `delayMarginMin : Real[0..1]`: the minutes of further delay the flight can take before connections are lost, absent when there is no connection constraint. The airline works it out from its own schedule and connection data (the connection threshold minus how late the flight already is) and sends only the result. The requirement and verification wording still says "connection priority"; this is how that priority is stated.
4. **Resolution options are defined in the model.** `NasAnalysis::ManeuverKind` (`altitude`, `vector`, `speed`, `slow`), `Maneuver` and `ResolutionOption`. `NasAnalysis::ScenarioFlight` holds what the scoring reads about one flight: the facts the truth model uses (cruise condition, cost index, schedule delta, connections) and the share derived from them. Cases C and D read the share only; cases A and B are not given it.
5. **The scenario's values stay in `scenario_base.yaml` and are cited by file.** No copy of the four flights is written in SysML. `VerifyByExperimentCase` in `nas_verification.sysml` gains a `scenarioFile` attribute.
6. **The model's performance functions are brought up to the code.** `CruiseFuelFlow` gains a vertical-speed input; `CanHoldLevel` gains the minimum climb rate and its text now states the D-023 test; `AvailableClimbRate` is added (D-024). `PerformanceModel` gains `nominalMassKg`. `Flight` gains `airline`.

**Rationale:** the project's claim is that the fidelity of a model can change with the architecture unchanged. That needs the code to be an implementation of what the architecture defines, by something stronger than a comment. Before this the experiment's one `Aircraft` class mixed what the model keeps apart (the aircraft's condition, the flight, and what the airline shares), so the code could not show which party knew what. Item 3: an airline would not hand its connection data or an unexplained rank to another party; one number in minutes is what the deciding party can use and is the least the airline has to reveal.

**Alternatives considered:** a SysML parser or the Syside Python API for the check (not needed for flat definitions; `tools/check_model.py`, turn 5, is where that API is used); the experiment in SI throughout (rejected: levels are compared exactly and every source is in feet); keeping `connectionPriority` and deriving an integer in Python (rejected, item 3); the four flights written as SysML instances (rejected by the owner: one copy, cited).

**Evidence / source:** owner direction, 2026-10-11. Item 3: the owner's judgment of what an airline would share [SME], with one published precedent found the same day, `pilon2019udppMargins` [B]. In SESAR's User Driven Prioritisation Process an airline assigns each delayed flight a "Time not before" and "Time not after" (Section III.C.3, p. 3) and the flight's cost structure "is only known by the AU" (Section II.A, p. 2); delay costs "surge" when the first connecting passengers risk missing their flights (p. 2). That is planning-phase slot prioritisation among one airline's own flights, with the Network Manager as receiver. The project's use, a margin sent to the party resolving an en-route conflict, is the project's proposal and is not in the paper. The paper states a clock time; `delayMarginMin` is that time less the flight's current estimate.

**Consequences:** `cameo_models/nas_analysis.sysml`, `nas_sysml_package_definitions.sysml`, `nas_verification.sysml`; new `simulation/nas_types.py` and `test_model_conformance.py`; `experiment_scoring.py` (class `Performance` is now `PerformanceModel`, methods named after the calc defs), `scenario_base.yaml` (model keys renamed; `aircraft` is now `flights`), `b739_envelope.py`, `openap_smoke.py`, `vehicle_dynamics.py`, `test_experiment_scoring.py`; `workflows/vehicle-simulation-model.md`; `tools/README.md`. **No number changed:** the three tables, `results/experiment_results.sysml` and both figures are byte-identical to the commit before. 32 tests pass; `syside check` passes. Earlier entries (D-017, D-023, D-024) name the old Python and YAML names and are left as written.

---

## D-024 — Climbs are costed at the rate maximum thrust allows; no compressibility drag is a stated assumption

**Date:** 2026-10-11
**Status:** active. Owner direction in session, on both items.

**Decision:**

1. **A climb is flown at maximum thrust at the rate that thrust allows,** not at a fixed 1,500 ft/min: the climb left at the mid-altitude of the climb (excess thrust times speed over weight), capped at 1,500 ft/min. This applies to a climb to a higher level and to the climb back after a descent. Descents stay at 1,500 ft/min.
2. **Leaving out compressibility drag is stated as an assumption** in the report's scoring-method subsection, with the FAA circular's speed ranges (`faa2015ac61107b` para. 1-4e: subsonic below Mach 0.75, transonic from 0.75 to 1.20) and the size of the effect as far as it has been estimated.

**Rationale:** item 1: the fixed rate needed about 56 kN where the thrust model gives 42 kN, so the scoring and the level test contradicted each other. Item 2: OpenAP's drag polar has no Mach-number term unless its experimental wave-drag option is switched on.

**What the estimate of item 2 shows, and it is not all small.** With the wave-drag option on, drag at Mach 0.80 rises 2 to 4 percent at the scenario's weights and levels, and under 1 percent at Mach 0.76. Fuel flow moves by the same few percent. The climb left moves a lot more, because it is the difference of two nearly equal numbers: the heavy aircraft at FL380 goes from 181 to 93 ft/min, under the 100 ft/min service ceiling; the light aircraft at FL400 from 322 to 239 ft/min. So the D-023 weights hold only with the term off. Open; see `knowledge/questions/open-questions.md`.

**Consequences:** `simulation/experiment_scoring.py`; tables and `cameo_models/results/experiment_results.sysml` regenerated; third run recorded in `knowledge/models/experiment-options-and-scoring.md` section 8 (cases C and D still choose O4, now by 3.6 kg and two calls over case B's option). `test_similar_weights_variation_makes_c_match_b` now fails and is left failing: with equal weights case C still differs from case B, because knowing the weight lifts the FL350 rule. That overturns the last sentence of D-023's rationale (67,000 kg was chosen partly to keep that check passing).

---

## D-023 — A level is usable only with climb left: 100 ft/min defines the service ceiling, 150 ft/min is the experiment's margin; scenario weights lowered to fit

**Date:** 2026-10-11
**Status:** active. Items 1 and 2 are owner direction in session. Item 3, the new weights, is Claude's recommendation applied to `scenario_base.yaml` and is the **owner's to confirm**.

**Decision:**

1. **Service ceiling is defined by 100 ft/min of climb left,** per `faa2015ac61107b` para. 1-4r (p. 2) [A]. "Thrust equals drag" is no longer the test of whether an aircraft can hold a level.
2. **The experiment asks for 150 ft/min.** Owner: many airlines keep 150 ft/min to allow for clear air turbulence and other errors and unknowns [SME]. It is `geometry.min_climb_rate_ft_min` in `scenario_base.yaml`. `b739_envelope.py` shades as usable only the speeds and levels with that much climb left and draws the 0, 100 and 150 ft/min lines; `experiment_scoring.py` uses the same number for whether an aircraft can be cleared to a level (cases C and D, and the truth model).
3. **Weights: nominal 67,000 kg (was 70,000), heavy 71,020 kg (was 74,200), light 62,980 kg (was 65,800). The ±6 percent spread, FL380 and Mach 0.80 are unchanged.** At 74,200 kg and Mach 0.80 the model leaves 70 ft/min at FL380, so the heavy aircraft was above its own service ceiling at the level the scenario put it. The model's limits at FL380 and Mach 0.80 are 73,300 kg for 100 ft/min and 71,900 kg for 150 ft/min.
4. **Mach is not changed.** At 74,200 kg and FL380 the most climb left at any Mach is 87 ft/min (Mach 0.76), still under 100. Slowing down cannot fix it; only weight or level can.

**Rationale:** with the new weights the heavy aircraft has 181 ft/min at FL380 (meets 150) and 8 ft/min at FL400 (cannot be cleared up); the light one has 322 ft/min at FL400 (can). The asymmetry D-013 item 4 asks for is kept, and it now rests on a published definition plus a stated margin. The nominal mass was lowered, not the spread, because the 6 percent is the owner's direction with a source (`coppenbarger1999climbPrediction` Table 3) and the 70,000 kg nominal was Claude's unsourced estimate [C]. 67,000 kg was chosen over a value nearer the limit so the nominal aircraft still has 150 ft/min at FL400 (160 ft/min), which keeps the similar-weights check behaving as before.

**Alternatives considered:** heavy alone lowered to 71,800 kg with the nominal kept (rejected: the spread would no longer be ±6 percent); the crossing moved to FL360 (rejected: FL380 is owner direction, and AC3 and AC4 would have to move too); 100 ft/min as the experiment's number (rejected on the owner's SME statement; it is one line in the YAML to change).

**Evidence / source:** `faa2015ac61107b` para. 1-4r; owner [SME] for 150 ft/min (no document held); OpenAP figures computed 2026-10-11 (ISA, still air, drag polar borrowed from the 737 MAX 8, D-017).

**Consequences:** `simulation/scenario_base.yaml`, `b739_envelope.py`, `experiment_scoring.py`, `test_experiment_scoring.py`; both figures and the three tables under `report/figures/` regenerated; `cameo_models/results/experiment_results.sysml` regenerated; `knowledge/models/experiment-scenario-numbers.md`; `knowledge/models/experiment-options-and-scoring.md` section 8. **The experiment's answer changed:** cases C and D now choose the light aircraft's climb (O4), where the first run had them choose the same option as case B. See section 8 of the options file. Amends D-017's consequence line ("about 74,000 kg and 66,000 kg").

---

## D-022 — A third requirements tier: one set per constituent system, each with a stated objective and, where there is more than one way, named means scored by the experiment

**Date:** 2026-10-11
**Status:** active as a draft. Owner direction in session ("Author the next level of requirements, where each system is allocated requirements... the HLR should state an objective explicitly and the 3+ ways of achieving it will be scored in the experiment"). The 28 requirements are Claude's wording except HLR-CRW-01, which is the owner's sentence. **Not reviewed by the owner.**

**Decision:**

1. **A tier below the system requirements is added,** with the constituent system as the subject of each sentence: `ConstituentSystemRequirement` in `requirements_definitions.sysml`, instances in the new `cameo_models/requirements_constituent_systems.sysml`, IDs `HLR-<system>-nn`. "Constituent system" is read as D-007's five modeled systems: flight crew (5 requirements), flight operations (7), air traffic control (9), aircraft (5), airport operations (2). Each is allocated to named parts of the model.
2. **Every requirement at this tier states its objective** (`objectiveStatement`) and names the system requirement(s) it comes from (`parentRequirements`). Every one of the 23 system requirements has at least one requirement under it.
3. **Means of achievement are named in the model.** `enum def MeansOfAchievement { ruleOfThumb; lowFidelityModel; highFidelityModel; highFidelityModelWithConnections; }`. They are the experiment's cases A, B, C and D. They are distinct from `NasAnalysis::FidelityLevel`, which is the fidelity of the truth model that scores (D-017 item 3).
4. **Three requirements have means the experiment scores side by side:** HLR-ATC-04 (the clearance is flyable), HLR-ATC-05 (lowest impact; a goal) and HLR-ATC-06 (instructions within workload). `nas_verification.sysml` gains one verification case per means for each, twelve in all. HLR-OPS-01 (flight planning) lists three means and is not scored.
5. **Three owner answers of 2026-10-11 are applied at the tiers above.** (a) SLR-PLN-05: "DES" in the hand note is descent. A descent can always be achieved; a climb cannot be assumed, and the joint release is what leads to that conclusion in the rule-of-thumb case. (b) SN-AIR-03 is carried by the crew and the dispatchers coordinating: SLR-CLR-04 now answers it too, with HLR-CRW-04 and HLR-OPS-06 below. (c) SN-CRW-07 reads "weather, traffic and other safety considerations"; traffic management initiatives are removed from it.

**Rationale:** the owner's cuts left the system requirements general on purpose ("the information needed to preserve safety and pursue optimality", "lowest impact"). This tier is where they become checkable, and naming the means is what ties the requirements to the experiment: the same objective, achieved four ways, scored by one truth model. That is the project's interchangeable-fidelity claim stated as requirements.

**Alternatives considered:** requirements on every part of every system (rejected: D-020's test; parts with nothing in the study are listed with the reason instead); the means as separate requirements (rejected: they are ways of meeting one requirement, not four requirements; the owner's "test cases/verifications, I guess" points the same way); folding case D into the high-fidelity means (left open for the owner).

**Evidence / source:** owner direction, 2026-10-11; `knowledge/models/experiment-options-and-scoring.md` section 2 (what each case knows); D-013 (FL350 rule); D-017; D-019.

**Consequences:** `knowledge/models/requirements-and-traceability.md` gains section 11. `simulation/experiment_scoring.py` is unchanged; its cases already are the four means. This supersedes the plan's "owner writes the next-tier three to five" (D-016, turn 4): the owner's task is now to review the 28. Airport operations is the weakest fit under D-020 and is flagged in section 11.

---

## D-021 — Second requirements review: the study is tactical; workload is a ceiling, not a goal; airline cost is not mandated

**Date:** 2026-10-11
**Status:** active. Owner direction from the hand review of the second requirements print (`projects/nas-sos-capstone/handwritten/2026-10-11_requirements-and-traceability_v2.pdf`). Amends D-020 (items 2 and 3). Item 3's new requirement is Claude's wording and is the **owner's to confirm**.

**Decision:**

1. **No traffic flow management requirement remains.** SLR-FLW-03 and SLR-PLN-08 are struck. Owner: "While relevant to the NAS, the TMIs aren't relevant to tactical interventions. The same look @ MBSE applies to TMIs, but they're not my focus." The study is about tactical interventions; initiatives are named as a place the same method could be applied, not examined.
2. **The NAS does not mandate what the airline optimizes.** SLR-PLN-03 (select the plan to minimize the airline's cost) is struck, and "at its lowest operating cost" is struck from SN-AIR-01. Owner: "This is an airline's prerogative. Maximize revenue, profit, or min cost."
3. **Controller workload is a stakeholder requirement again, as a ceiling.** SN-ATC-04 is restored. The goal SLR-CLR-12 (fewest instructions) is struck: "This isn't a safety objective. If not overworked, controllers can give as many as they want!" A new SLR-CLR-15, written by Claude so SN-ATC-04 has an answer, says the instructions needed to resolve a conflict stay within what the sector team can sustain. It carries no number.
4. **The remaining goal is about impact, not cost.** SLR-CLR-13 now reads "the one with the lowest impact on the aircraft involved", without "with the same number of control instructions". Owner: "'impact' is generic and leaves that up to each controller to decide." The experiment's cost formula (fuel plus cost index times time) is the experiment's chosen measure of impact and is no longer stated in any requirement. D-020 item 3 becomes: one goal.
5. **Also struck:** SLR-INF-06 (weather to dispatcher and crew: "Winds & weather 'should' be factored into account by controllers, but that's not a SLR") and SLR-APT-02 (runway capacity).
6. **Re-worded:** SLR-CLR-04 ("for the whole flight"), SLR-EXE-02 (adds speed), SLR-EXE-03 (no longer "on board"), SLR-EXE-06 (alerts dispatchers and controllers as well as the crew).
7. **Objective rows with no stakeholder requirement are derived requirements at the next tier down,** where they matter to the thread (owner's note on section 8 of the print).

The count is now 13 stakeholder and 23 system requirements; one goal (SLR-CLR-13); three `improved` (SLR-CLR-10, SLR-CLR-13, SLR-INF-02).

**Rationale:** each cut removes a statement the NAS does not owe anyone in a tactical conflict, or one that told a constituent system how to run its own business. Restoring SN-ATC-04 closes the gap named in D-020's consequences.

**Alternatives considered:** leave SN-ATC-04 restored with no system requirement under it (rejected by Claude: the trace would be broken and the experiment's workload column would hang from nothing; the owner may still prefer it).

**Evidence / source:** the marked-up PDF named above.

**Consequences:** `requirements_stakeholders.sysml`, `requirements_nas_system.sysml`, `nas_verification.sysml` edited; `knowledge/models/requirements-and-traceability.md` regenerated. Two gaps are recorded in its section 7: SN-AIR-03 is answered only by the arrival-estimate update (SLR-INF-07), and SN-CRW-07 still names initiatives though nothing below it does.

---

## D-020 — Requirements are limited to the study's decision; two statements become goals; data confidentiality is an assumption only

**Date:** 2026-10-10
**Status:** active in principle. Owner direction from the hand review of the first requirements draft (`projects/nas-sos-capstone/handwritten/2026-10-10_requirements-and-traceability.pdf`) and the instruction that followed ("I want something focused on my systems, concerning my study. This is a D-007 must."). The wording of item 1 is Claude's statement of the owner's marks; **owner to confirm**. Amends D-018 (item 2), D-019 (item 3 and consequences) and D-016 (items 4 and 5, §8 row).

**Decision:**

1. **D-007's test is applied to each requirement, not only to each stakeholder group.** "In-scope decisions" is read as the decision the project studies: how a conflict between two aircraft in en-route cruise is resolved, and what the party that decides is told. A requirement stays only if it states what that decision must achieve or not break, what the deciding party knows, or something the experiment takes as given and uses in its numbers. Each kept requirement's `rationale` says which.
2. **The draft is cut from 27 stakeholder and 53 system requirements to 12 and 28.** 18 stakeholder requirements struck and 3 added (SN-CRW-06, -07, -08, written by the owner); 25 system requirements struck. Airport operator, passengers and military airspace users have no requirements. No requirement is derived any longer. The list of what was struck, with the owner's mark on each, is section 6 of `knowledge/models/requirements-and-traceability.md`.
3. **Two statements are goals, not requirements:** SLR-CLR-12 (fewest instructions) and SLR-CLR-13 (lowest combined cost). They are written with "should" and carry a new attribute, `obligation = goal` (`enum def Obligation { mandatory; goal; }` in `requirements_definitions.sysml`). The experiment measures them; it does not pass or fail them.
4. **Confidentiality of shared airline data is an assumption and no longer a requirement.** SN-AIR-06 and SLR-INF-05 are struck (owner: "Important & real, but not pertinent to my project per D-007"; "Maybe not needed if exposed as API"). D-019 item 3 stands as an assumption with nothing in the requirements model behind it.
5. **The three information requirements become one.** SLR-INF-02 now reads "the information needed to preserve safety and pursue optimality"; the first draft's SLR-INF-03 (cost index) and SLR-INF-04 (connection priority) are struck as implied. **The `improved` set of D-018 is therefore three, not five:** SLR-CLR-10, SLR-CLR-13, SLR-INF-02. Weight, cost index and connection priority remain as the attributes of `AirlinePerformanceShare` and as three verification cases on SLR-INF-02.
6. **The thread of D-016 item 4 now reads:** airline objective rows → SN-AIR-05 → SLR-INF-02 and the goal SLR-CLR-13 → the airline-to-ATC interface (D-019) → the conflict-resolution sequence → verification cases → the outcome table.
7. **The three objective rows proposed for the ontology (airline data protection, passenger safety, Governance) are not added** (owner: "Not relevant to D-007", "Not important").

**Rationale:** the first draft followed the detail in the model packages and so described the NAS in general. The owner judged about nine in ten of its statements to be partial captures of real requirements that distract from the project. A requirement set that a reader can check against one studied decision is defensible in a one-term capstone; a general one is neither complete nor relevant.

**Alternatives considered:** keep the struck requirements in the model with `status = withdrawn` (rejected: they would still print in every table and diagram drawn from the model; the marked-up PDF is the record); keep SLR-CLR-13 as a "shall" tagged `improved` (rejected by the owner: no source makes least cost a duty; `kirwan2001coraStrategies` p. 4 gives the controller's aim as separation "first safely, and then expeditiously").

**Evidence / source:** the marked-up PDF named above; D-007; `evidence/literature-notes/summaries/5 - faa2025jo72103ee.md` (paragraph 18-10-12 is a ground delay program option, which settles the owner's fact check on SN-AIR-04); `evidence/literature-notes/summaries/4 - kirwan2001coraStrategies.md`.

**Consequences:** `requirements_stakeholders.sysml`, `requirements_nas_system.sysml`, `requirements_definitions.sysml` and `nas_verification.sysml` rewritten or edited; `knowledge/models/requirements-and-traceability.md` regenerated from the model; comments citing the struck IDs corrected in `nas_sysml_package_definitions.sysml`, `nas_context_diagram.sysml` and the report's scaffolding notes. The first draft was never committed, so its text survives only in the PDF. Open points for the owner are section 7 of the traceability file; the one with the most weight is that striking SN-ATC-04 leaves controller workload, one of the experiment's two scored columns, without a stakeholder requirement of its own.

---

## D-019 — The proposed airline-to-ATC data share is modeled as an improved-architecture interface; security is an assumption, not a mechanism

**Date:** 2026-10-10
**Status:** active. Owner direction from the review of the 2026-10-10 improvement plan (`projects/nas-sos-capstone/project-plan-proposal-2026-10-10.md` and the plan file reviewed in session). Applies D-007's "absorbed information services" rule to one specific exchange.

**Decision:**

1. **One new item definition, `AirlinePerformanceShare`,** carries what the airline (or the FMS on its behalf) would share with the party deciding a trajectory change: gross weight, cost index, connection priority, and identifiers for the thrust, drag and fuel-flow models the airline would expose. Only weight, cost index and connection priority are exercised by the experiment; the three model identifiers are present so the digital-thread vision is in the model, and are marked unexercised.
2. **One `interface def` with typed ports** joins the airline operations center (or FMS) to ATC decision support. It is tagged as part of the improved architecture (D-018). The existing context-diagram connection it refines is retyped; the other connections are untouched.
3. **Security and confidentiality are stated as an assumption,** satisfied by SLR-INF-05 (disclosure only to the deciding party) and by reference to existing practice (SWIM, commercial software-as-a-service data exchange). No encryption, authentication or key-management mechanism is modeled.
4. **The three thread exchanges get typed interfaces; nothing else does.** FMS → AOC (`FmsPerformancePrediction`), AOC → ATC decision support (`AirlinePerformanceShare`), ATC → crew (clearance).

**Rationale:** the project's thesis names a digital thread in which airlines expose performance data through APIs, but until this decision nothing in the model, requirements or report named that interface. A thesis about standardized interfaces needs at least one typed interface in the model. Three is the number the experiment's thread needs; typing all 103 connections would not be finished by 2026-12-13 and would not change the argument. Security is out of reach for a one-term capstone and is the kind of thing a reviewer accepts as an assumption when it is stated as one.

**Alternatives considered:** type every connection (rejected: schedule); keep the share as a doc comment on the existing connection (rejected: the report could not point at a model element); model a security layer (rejected: cannot be verified here, and the course does not ask for it).

**Evidence / source:** owner's statement of intent (2026-10-10 review); `schultz2012adaptiveClimb` p. 2 (weight and speed intent treated as competitive); `coppenbarger1999climbPrediction` Table 2 (candidate exchange items: take-off weight, thrust and drag factors, speed profile); D-007; D-012 item 3 (decision support owned per actor).

**Consequences:** new `port def`, `interface def` and `item def` elements in `cameo_models/nas_sysml_package_definitions.sysml` (turn 2 of the plan); SN-AIR-06 and SLR-INF-05 become the stated security requirement; the report's Section 3 gets a "Proposed interface" subsection; future work names the full model-sharing API.

---

## D-018 — Requirements carry an architecture state: `baseline` (today's NAS) or `improved` (the proposed change)

**Date:** 2026-10-10
**Status:** active. Owner direction from the 2026-10-10 plan review. The owner chose the names `baseline` and `improved` over `asIs` and `toBe`.

**Decision:**

1. `requirements_definitions.sysml` gains `enum def ArchitectureState { baseline; improved; }` and every requirement carries `architectureState`, defaulting to `baseline`.
2. The five requirements the current system does not meet are set to `improved`: SLR-CLR-10, SLR-CLR-13, SLR-INF-02, SLR-INF-03, SLR-INF-04. They describe the proposed architecture, not today's.
3. **Case A of the experiment is the measurement of the `baseline` requirements; cases C and D are the measurement of the `improved` ones.** Case A's row of the outcome table is the course's required current-state metric; the improved rows are the required improvement claim.

**Rationale:** the course's minimum requirements ask for a current-state metric and an improvement claim; INCOSE practice keeps an as-built baseline distinct from a proposed change under configuration control. One attribute does both without a second requirements file. It also answers the open item in `knowledge/models/requirements-and-traceability.md` section 9 (item 3: are the five unmet requirements requirements or proposals?). They are requirements on the improved architecture.

**Alternatives considered:** a separate "proposed" package (rejected: duplicates the schema and the trace); `status = withdrawn` for the five (rejected: they are not withdrawn, they are the point).

**Evidence / source:** `prework/course-info-canvas.md` (course minimum requirements); `knowledge/models/requirements-and-traceability.md` section 9; INCOSE SE Handbook on baselines.

**Consequences:** the course's "current-state metric" open question in `knowledge/questions/open-questions.md` is answered and removed; `tools/check_model.py` (turn 5) asserts every `improved` requirement has a verification case.

---

## D-017 — OpenAP is the experiment's scoring model, at three selectable fidelities

**Date:** 2026-10-10
**Status:** active. Owner direction: "Perfect. Implement it!" (2026-10-10 plan review).

**Decision:**

1. **OpenAP** (TU Delft open aircraft performance model, LGPL-3.0, `pip install openap`, version 2.6.2 installed in `.venv` on Python 3.14.2 on 2026-10-10) supplies fuel flow, thrust and drag for the experiment. Calls: `FuelFlow(ac).enroute(mass_kg, tas_kt, alt_ft, vs)` in kg/s; `Thrust(ac).cruise(tas, alt)` and `.climb(tas, alt, roc)` in N; `Drag(ac).clean(mass, tas, alt)` in N; `prop.aircraft(ac)` for limits.
2. **The aircraft type code is `B39M`** (737 MAX 9, D-015). OpenAP holds the type's properties (MTOW 88,000 kg, OEW 45,000 kg, MFC 26,000 kg, MMO 0.82, ceiling 12,500 m, LEAP-1B) but no drag polar for it, so it is constructed with `use_synonym=True` and **borrows the 737 MAX 8 polar**. This is stated as a limitation wherever a number from it is reported.
3. **Three fidelity levels, selected at run time** (`--fidelity`), modeled as `FidelityLevel` in the analysis package: `conceptual` (option feasibility and instruction counts only, no fuel numbers), `nominalMass` (OpenAP at the type's nominal mass), `actualMass` (OpenAP at each aircraft's actual mass). The decider's case (A to D) and the truth model's fidelity are independent settings.
4. **The experiment needs no trajectory integration.** Each option is scored as steady cruise at the option's altitude for the time until the conflict clears, plus a climb or descent increment. `simulation/vehicle_dynamics.py` is kept but not used by the experiment.
5. **Fallback, decided on 2026-11-08 at the latest:** if OpenAP gives implausible numbers, a lookup table built from `mori2022massCruise` replaces it, stated as a limitation.

**Smoke test, 2026-10-10 (Mach 0.80, ISA):** at 66,000 kg fuel flow falls from 2,283 kg/h at FL320 to 2,049 kg/h at FL400 and the thrust margin holds at every level; at 78,000 kg the fuel flow bottoms out at FL380 (2,402 kg/h) and OpenAP's maximum cruise thrust is below drag at FL380 and FL400. So the light aircraft can take the climb to FL400 and the heavy one cannot, which is the asymmetry the experiment is built on (D-013 item 4).

**Rationale:** the plan's largest schedule risk was a scoring model with no chosen source. OpenAP is open, documented, supports the type, and gives the three quantities (thrust, drag, fuel flow) the digital-thread vision names, so the same library stands in for what an airline would expose. BADA needs a licence. A hand-built Breguet model would have to be validated from nothing.

**Alternatives considered:** EUROCONTROL BADA (licence); extend `vehicle_dynamics.py` with a drag polar (more work, no validation); lookup table from the Mori paper (kept as the fallback).

**Evidence / source:** OpenAP documentation (`openap.dev`), API checked 2026-10-10; Sun, Hoekstra and Ellerbroek 2020 (to be registered); smoke test output in `projects/nas-sos-capstone/journal/2026-10-10.md`.

**Consequences:** `simulation/openap_smoke.py`, `b739_envelope.py`, `experiment_scoring.py`, `scenario_base.yaml`; `cameo_models/nas_analysis.sysml`; the scenario's heavy and light weights are chosen so that the asymmetry above holds (about 74,000 kg and 66,000 kg; see `knowledge/models/experiment-scenario-numbers.md`).

---

## D-016 — Plan adopted: four tracks, nine weekly turns, artifact states, documented tailoring of the August plan

**Date:** 2026-10-10
**Status:** active in principle. The owner approved the 2026-10-10 improvement plan after a line-by-line review; each tailoring row below was spelled out at the owner's request. **Owner to confirm any row they want changed** before the corresponding "Future work" move is treated as final.

**Decision:**

1. **The working loop is the plan of record:** draft, print, hand-review, transcribe to `handwritten/`, apply, log the decision, re-render with a revision suffix, carry into the report, note the lesson.
2. **Each diagram and experiment table has one of five states** in place of a checkbox: 0 not started, 1 drafted (renders or reads clean), 2 hand-reviewed (transcription exists, directions applied), 3 evidence-graded (every link or number has a source, an `[SME]` mark or a stated assumption), 4 in the report (owner-written body text refers to it).
3. **Four tracks** run in parallel: A model, B experiment, C report, D evidence on demand. **Nine one-week turns** end on Sundays from 2026-10-18 to 2026-12-13, built around the graded dates (Interim Report #2 Oct 25, presentation upload Nov 20, Review #3 Nov 22, Final Report Dec 13), at 10 to 20 owner-hours a week.
4. **One traced thread carries the project:** airline cost objective → SN-AIR-05 → SLR-INF-02/03/04 and SLR-CLR-13 → the airline-to-ATC interface (D-019) → the conflict-resolution sequence → verification cases → the experiment's outcome table. Work off the thread is appendix or future work.
5. **Tailoring of `to-do-list.md`** (ISO/IEC/IEEE 15288 allows documented tailoring; the reason is recorded per row and dropped items move to a "Future work" section, not deleted):
   - §1 closed; its four open report fixes move to Track C.
   - §2 and §3 (per-paper literature checklists, about 160 boxes) replaced by Track D; the sources stay registered.
   - §4 keeps only the en-route ARTCC control and handoff transitions and the crew-to-FMS source lead; the rest to Future work.
   - §5 ConOps reduced to the activity diagram at phase level, with `FlyEnroute` decomposed one level, plus the experiment scenario as the one worked scenario.
   - §6 alternative decompositions reduced to one report paragraph on why D-002/D-007 was kept.
   - §7 reduced to one RACCI table for the six decisions on the thread.
   - §8 done; add rows for airline data protection, passenger safety and Governance so every stakeholder requirement traces.
   - §9 reduced to the one conflict the experiment measures; the other eight named as future work.
   - §10 becomes Track A; the five trace lines become the one thread.
   - §11 and §12 become Track B; weighted sums, normalization, weighting schemes, weight sweeps, Pareto fronts, sensitivity and tipping points dropped (D-013 item 2); the optional Pareto-front yes/no column stays if the owner wants it.
   - §13 becomes the analysis package, verification cases and results file.
   - §14 becomes the presentation and Section 4; re-weighting dropped.
   - §15 reduced to the final-turn checklist (every body diagram at state 3; every thread requirement verified or marked qualitative; limitations from the lessons file).
   - §16 becomes Track C.
6. **Two dated guards:** scoring-model fallback decision on 2026-11-08 (D-017 item 5); model freeze on 2026-11-29, corrections only after.
7. **A lessons-learned file** (`projects/nas-sos-capstone/lessons-learned.md`) is kept, with one question added to the sign-off workflow.
8. **"Slipped" is redefined** in `personas/project-manager.md`: an artifact is slipped only when its state has not advanced since its date, not when its checkbox is open while it is being revised.

**Rationale:** the August plan was a one-pass list in a fixed order with one date per item. The work since late September runs in review turns across model, experiment and report at once, and the list reported improving artifacts as slipped. About 250 of its boxes feed nothing on the thread. The adviser endorsed a scope that varies with schedule (reported 2026-10-10). The thread is what can be finished and defended by 2026-12-13.

**Alternatives considered:** keep the 16 sections and re-date them (rejected: the ordering and the weighted-sum content are wrong, not only the dates); drop the dropped items outright (rejected: the report's limitations and future work need them named).

**Evidence / source:** `projects/nas-sos-capstone/project-plan-proposal-2026-10-10.md`; the 2026-10-10 plan review (owner comments recorded in `journal/2026-10-10.md`); `prework/course-info-canvas.md`.

**Consequences:** `to-do-list.md` restructured (turns at the top, four tracks, Future work at the bottom); `task-board.md`, `index.md` and the report's timing subsection follow; the report's Section 3 gets a "Systems engineering approach" table and a tailoring paragraph citing this decision.

---

## D-015 — Experiment starts from one aircraft type; ICAO calculator accepted for the CO2 factor; arrival-time effect of speed acknowledged

**Date:** 2026-10-09
**Status:** active. Owner direction, same day as D-014. **Supersedes item 1 of D-014** (a B777 and a 737 as the crossing pair); the rest of D-014 stands.

**Decision:**

1. **Both crossing aircraft are the B737-900 MAX** (Boeing's name: 737 MAX 9). The two-type pair of D-014 is kept as a later variation. The heavy and light weights are not yet set.
2. **The report acknowledges that the outcome is sensitive to the types and weights in the scenario.** The owner's reading: that sensitivity indicates how prevalent the issue is, and shows the benefit of MBSE's support for interchangeable models of different fidelity.
3. **ICAO's Carbon Emissions Calculator is the accepted source for the CO2 produced per kg of fuel** (3.16; `icao2024icecMethodology`, p. 6). Known criticisms of the calculator are noted and acknowledged in the report where appropriate.
4. **The effect of a speed change on arrival time is acknowledged in the report, even if it is not definitively included in the costs.** A change of 0.04 Mach held over 1,000 NM at 38,000 ft moves arrival by about 6 to 7 minutes, which can push a flight that is already early or late out of a 10 to 15 minute slot.

**Why:**

- With one type, the nominal-model case cannot tell the two aircraft apart, so the value of shared weight and cost index is isolated. Claude raised that two types narrow that value; the owner agreed it matters and chose to start from one type.
- The owner judged ICAO's calculator good enough as a source and asked for its criticisms to be noted.
- The arrival-time arithmetic is the owner's and was checked (458.9 kt at Mach 0.80; 99 s per 0.01 Mach).

**Consequences and open items:**

- The 105,000 lb weight in D-014 is close to the empty weight of this type, so both weights need setting.
- An earlier statement that one resolution costs a flight only seconds to a couple of minutes was too narrow and is corrected in `knowledge/models/experiment-options-and-scoring.md` §4.2.
- Mach 0.84 may be above the type's maximum operating Mach number (0.82, not sourced), which would limit the fast side to +0.02.
- The criticism of the ICAO calculator that bears on this experiment is that it counts CO2 only, while the options here are altitude changes and non-CO2 effects depend on altitude. That link needs a source.

---

## D-014 — Experiment scenario and scoring, second review: aircraft types, speed lever, fourth case, emissions routes, all aircraft listed

**Date:** 2026-10-09
**Status:** active. Owner direction from the hand review of `knowledge/models/experiment-options-and-scoring.md`, transcribed in `projects/nas-sos-capstone/handwritten/2026-10-09_experiment-options-and-scoring_round_2.md`. Adds to D-013; nothing in D-013 is reversed. The experiment's central claim is still open in `knowledge/models/experiment-definition.md` §1.

**Decision:**

1. **The crossing pair is a B777 at 600,000 lb with 200 or more passengers (AC1) and a 737 at 105,000 lb (AC2).** Owner's figures, graded [SME].
2. **The speed lever is built to fail.** Distances and speeds are chosen so that a change within ±0.04 Mach cannot separate the pair. ±0.04 Mach is graded [SME].
3. **Levels are 2,000 ft apart for one direction of flight (eastbound odd, westbound even), taken as fact** [SME]. The check against JO 7110.65BB is dropped unless needed later. Candidate levels for the crossing pair are FL370 (climb to FL390) and FL380 (climb to FL400); not chosen.
4. **A fourth case, D, is added: the shared-weight case plus the airline's connection information.** The owner's reason: ATC and airports can exchange it through SWIM, and including or omitting it is the kind of parameter the study varies. Making it a separate case, not part of case C, is Claude's reading of the note.
5. **Emissions routes.** A CORSIA credit price is used for the airline column, applied to a U.S. domestic flight as a stated assumption. Passenger value goes in the discussion. A social cost of carbon is quoted in the system column.
6. **"Automated decision" means the automation proposes, and the controller checks and issues the clearance.**
7. **Every aircraft's cost is listed in the outcome tables,** not only the worst-off one.
8. **The system column is a measure of the airspace as a whole system of systems,** defined by its own cost statement.

**Why:**

- Items 1 to 3 are the owner's operational judgment of a realistic and usable scenario.
- Item 4 follows the owner's finding that dispatchers rate schedule integrity and connections above fuel (Sheth et al., credits-concept paper, Figure 7), which weight and cost index do not carry.
- Item 5: a credit price is a cost an airline can face; society's cost is not, so it sits at the system level.
- Item 7: listing all four shows who pays without a summary statistic.

**Consequences and open items:**

- With two different aircraft types, the nominal-model case already tells the pair apart by type. What sharing weight adds narrows to the distance from each type's nominal weight and the cost index. Raised with the owner; not yet answered.
- A statement in the first draft, that a heavy aircraft is nearer its optimum at the lower level, was struck by the owner and removed. The direction is left to the truth model.
- One conflict resolution costs a flight seconds to minutes, so crossing a 10 to 15 minute slot boundary depends on how late the flight already is. The scenario has to state that.
- Still unsourced: the missed-connection cost, a CORSIA price, the CO2 per kg of fuel, a passenger-choice study and a social cost of carbon. The Sheth et al. paper is held but not registered.

---

## D-013 — Experiment scoring: TASAR altitude set and climb rule, impacts stated separately, CO2 in dollars for the airline only

**Date:** 2026-10-09
**Status:** active. Owner direction, 2026-10-09, on the draft `knowledge/models/experiment-options-and-scoring.md`. It settles three items that draft had marked for the owner. It does not settle the experiment's central claim, which is still open in `knowledge/models/experiment-definition.md` §1.

**Decision:**

1. **Altitude options and climb rule are taken from the TASAR benefits study.** Each aircraft may be moved 2,000 ft above, 2,000 ft below or 4,000 ft below its assigned altitude. A climb is offered only if the aircraft is at or below FL350 (`engility2014tasarAlaska`, p. 8). This is the starting point and may be refined.
2. **The system level states impacts independently.** Total fuel, total CO2, total airline cost, the sector's workload items and the largest cost to any one aircraft are reported side by side. No weighted sum at first.
3. **Emissions are reported as CO2 and converted to dollars at the airline level only.** At the airline level the report puts CO2 into concrete terms for the airline, possibly through carbon credits or passenger value. At the system-of-systems level it stays as CO2, with discussion of what it means for society and for how passengers perceive a flight.
4. **The FL350 climb rule binds only the cases that lack the aircraft's weight** (the rule-based baseline and the nominal-model case). The case with shared weight and models judges climbs from the actual weight. The first scenario puts the crossing pair high enough that the rule closes climbs to the first two cases. (Added the same day, after the owner confirmed: "that is exactly the point.")

**Why:**

- The TASAR rule has a stated reason, "to be conservative since aircraft weight was not modeled", which is the same gap the experiment measures. The owner judged it a reasonable assumption. It also replaces an unsourced "usable level" with a published set.
- A weighted sum needs weights that no stakeholder in the model owns, and it hides the trade between levels that the table is meant to show.
- An airline can face a price on carbon; society's cost is not a line in the airline's accounts. The owner also noted choosing flights listed with lower emissions, as a traveller.

**Consequences and open items:**

- The level of the crossing pair decides whether climbs are available, so it has to be chosen deliberately. A variation at or below FL350, where every case can climb, is left for later.
- The published rule permits a climb at exactly FL350, so the crossing pair must be above FL350 for the rule to close climbs. The exact level is not chosen.
- The TASAR set is that study's modeling assumption for cockpit requests, not an FAA rule and not measured controller behaviour. Cite it as an adopted assumption.
- No source is held yet for the CO2 produced per kg of fuel, for a carbon price that applies to a U.S. domestic flight, or for how emissions labels affect passenger choice.

---

## D-012 — Owner's hand review of the diagrams: crew acts through controls, outside inputs drawn as ports, decision support owned per actor, airport and aircraft trimmed

**Date:** 2026-10-08
**Status:** active. Owner direction, 2026-10-08, from hand-marked prints of the aircraft IBDs, the context diagram and the definitions tree. Transcription and the owner's responses: `inbox/2026-10-08-handwritten-notes-aircraft-and-context-diagrams.md`. Amends D-007 (item 3), D-009 (item 2) and D-011 (items 1, 4, 5).

**Decision:**

1. **The crew acts through the flight deck controls and the FMS.** New `Aircraft.flightDeckControls` (`yokes`, `rudderPedals`, `thrustLevers`, `configurationLevers`, `modeControlPanel`). On the aircraft IBD the crew's direct links to autoflight, the flight control system, propulsion and the landing gear are replaced by one crew-to-controls link plus a link from each control to the system it commands. Other panels are not modeled.
2. **What comes from outside the system of interest is drawn as an input port, and the environment is not drawn.** `rulesIn` and `weatherIn` on the airline operations center, `rulesIn` on `atc`, `weatherIn` and `specialUseAirspaceIn` on `atcscc`. The `environment` part and its five links stay in the model, untagged, and now end on those ports. This replaces D-009's rendering of the environment links. Reason (owner): "environment" misleads when the outside thing is a passenger or a per-flight variable rather than law or weather. Passengers stay stored under `Environment`.
3. **Decision support is owned by each system that decides.** `DecisionSupport::DecisionSupportDomain` and `Environment.decisionSupport` are removed. New `DecisionSupportSystem`, with instances on `AirlineOperationsCenter`, `AirTrafficControlSystem`, `AvionicsSystem` and `FlightDeckCrew` (`electronicFlightBag`). D-007 classed decision support as absorbed and "allocated to operator or ATM contexts"; this carries the allocation out in the model. `VehicleDynamicsModel` is the propulsion and aerodynamics model; the `StepDynamics` calc def is removed because the time step is not a component of it.
4. **Aircraft changes.** Pitot-static moves from avionics to `UtilitySystems`. EICAS is removed and its function folded into the displays (engines connect to the displays). `CabinSystem` and its seven sub-parts are removed; cabin crew and passengers connect to `airframe.fuselage`. New surveillance-to-displays link, which is how traffic reaches the crew. Boundary ports `adsbOut`, `adsbIn`, `emissions`, `ambientAir`. Wake is left out as unimportant to the study.
5. **Airport parts removed:** `weatherStation`, `cargoTerminal`, `gateAgents`, `securityServices`, `parkingAndTransportationServices`, `fuelDistributionSystem.tanks`, `fuelDistributionSystem.intoPlaneFueler`, `groundHandling.marshaller`. The exchanges that ended on them are kept and end on the part that absorbed the role: gate agents on `gates`, marshaller on `pushbackCrew`, fueler on `fuelDistributionSystem`, cargo on `groundHandling`.
6. **Rendered connections carry their description as `comment about <name>`, not a `doc` in a body**, so that the connection's name prints on the diagram.

**Rationale:** the owner could not defend several elements on the prints, and the lines were unreadable without names. Items 1 and 4 are the owner's professional knowledge of how the flight deck and the aircraft systems are arranged. Item 5 removes parts with no evidence and no role in the study.

**Alternatives considered:**

- Keep the environment box and only rename it. Rejected by the owner: ports say what a system receives without implying one outside "system".
- One shared decision support system. Rejected by the owner: each actor has its own version, working from what that actor knows.
- Hide the removed airport and cabin parts with tags, as D-011 does for detail. Rejected by the owner for these parts: they hold no value, as opposed to detail that is useful later.

**Evidence / source:** owner direction and professional knowledge (`[SME]`), 2026-10-08. The label and port behavior was tested with syside viz 0.10.3 the same day (`knowledge/models/sysml-diagram-rendering.md` §6, §8).

**Consequences:**

- Gate agents had `[B]` evidence (Munro 2018, friction with dispatch over late passengers). The role is still described in the `Gate` doc and in the `aocAirport` and `caGateAgentCoordination` text; only the separate part is gone.
- The airport parts that remain still need evidence for their internal structure (open question, 2026-10-08).
- Open: why weather and special-use airspace end on the ATCSCC; where the aircraft's decision support sits relative to the FMS; whether communication media (VHF, CPDLC, Satcom) are drawn as ports or sub-parts. The direction of `navSurveillance` was confirmed by the owner the same day: navigation feeds surveillance.
- The Python trace (D-005) now points at the `VehicleDynamicsModel` doc, which records the old calc signature.
- New renders are in `cameo_models/print/` with the suffix `-rev2`; the earlier renders are kept because the hand-marked scans refer to them.

---

## D-011 — Aircraft decomposed in levels; detail kept in the model and hidden on diagrams by default

**Date:** 2026-10-08
**Status:** active. Owner direction, 2026-10-08, after reviewing a first draft of the aircraft IBD against the existing definitions (journal 2026-10-08).

**Decision:**

1. **`Aircraft` is decomposed in levels.** Its direct parts are now `avionics`, `flightControlSystem`, `fuelSystem`, `propulsion`, `airframe`, `landingGear`, `utilities`, `cabin`. The FMS, navigation, pitot-static, communication, surveillance, guidance and radar parts move one level down into a new `AvionicsSystem`, with displays, EICAS and standby instruments added.
2. **Autoflight is avionics, flight control is physical.** `AutoFlightControlSystem` (autopilot, autothrottle) is avionics-hosted software logic and moves from `FlightControlSystem` to `AvionicsSystem`. `FlightControlSystem` is the controllers, servos, hydraulic actuators and surfaces: `primaryFCS`, new `secondaryFCS`, and the existing `reversionaryFCS`.
3. **`FuelSystem` stays a direct part of `Aircraft`.** Each engine has its own fuel-supply system as well.
4. **Propulsion is one to many engines, the APU included.** `PropulsionSystem.engines: Engine[1..*]`, with `mainEngines: TurbofanEngine[1..*]` and `apu: AuxiliaryPowerUnit[0..1]` as subsets. No left / right engine parts, so the definition is not limited to twins. Every engine has a FADEC, fuel supply, one-to-many compressor stages, a combustor and one-to-many turbine stages; a turbofan adds a fan and a nozzle.
5. **Propulsion, airframe and in-flight entertainment are modeled.** This reverses the earlier note in `AircraftSystems` that left them out. Aerodynamic properties are an attribute of `Airframe`, not a part.
6. **Detail is kept but not shown unless asked for.** In `cameo_models/nas_ibd_aircraft.sysml`, `#IBDVisible` marks what the default view (`MyViews::aircraftIbd`) draws: crew, avionics, flight control system, fuel system, and the information and command links. `#IBDDetail` marks what only `MyViews::aircraftIbdDetail` adds: propulsion, airframe, landing gear, utilities, cabin, cabin crew, passengers, and the fuel, power and physical-response links. Untagged parts (engine internals, cabin internals, airframe sub-parts) stay in the definitions and are drawn by neither.
7. **Crew and passengers are referenced, not owned, by the aircraft** (`ref part`), consistent with D-007 and D-009.

**Rationale:** the owner needs an airliner to be a usage of `Aircraft`, and the outline's grouping did not match the flat definition. Levels let a diagram stop where the intent chain needs it to (comms / FMS / crew → autoflight → flight controls) while the physical detail stays available for later work, such as activity diagrams, without cluttering them.

**Alternatives considered:**

- Leave `Aircraft` flat and build the IBD from untyped parts (the first draft). Rejected: the airliner would not be an `Aircraft`.
- `engineLeft` / `engineRight` parts. Rejected by the owner: limits the model to twin-engine aircraft.
- Leave propulsion, airframe and IFE out, as before. Rejected by the owner: the detail matters; it is hidden, not dropped.

**Evidence / source:** owner direction and professional knowledge (`[SME]`), 2026-10-08. Individual IBD links are not yet graded.

**Consequences:**

- Paths change: `aircraft.navigationSystem` is now `aircraft.avionics.navigationSystem` (and likewise for the other moved parts). The one existing use, `apNavaidSignals` in `nas_context_diagram.sysml`, is updated. `aircraft.fuelSystem` is unchanged.
- Open: whether `GuidanceSystem` stays a separate part (recommendation: no, it is a function shared by the FMS and autoflight) and whether `Radar` is renamed `weatherRadar`. Whether the APU belongs under propulsion is the owner's call and is modeled that way; ATA numbering treats it separately (chapter 49).
- The airspace IBD view had the same empty-render problem as the first aircraft view and now uses the `expose …::*::**` plus `filter` form.

---

## D-010 — Context diagram rendering rule, datalink split, role naming, and supporting definitions

**Date:** 2026-09-27
**Status:** active. Refines D-009 after the owner's line-by-line review of `cameo_models/nas_context_diagram.sysml` (journal 2026-09-27, "Context diagram review").

**Decision:**

1. **Rendering rule.** A sub-part is rendered on the context view only if it has an exchange that crosses a domain boundary. Links inside one domain go on that domain's IBD. Applied: `atcsccTmu` and the drafted `tmuAtc` move to a new placeholder IBD (`cameo_models/nas_ibd_airspace_management.sysml`, view `MyViews::airspaceManagementIbd`), with the open "`atc` umbrella vs tower/TRACON/ARTCC" question. `tmu` is no longer rendered on the context view.
2. **Exchanges that carry a decision without making one are kept but not rendered.** This extends the D-009 aircraft ↔ airport rule. Applied: `aocFlightPlanFiling` stays in the model (the filed plan is the intent object ATC clears against) but is no longer rendered. The route decision is made at the AOC, traded on `aocTfm`, and accepted or amended in the clearance. The same rule gives the new unrendered crew ↔ airport set (`ca*`: lighting, docking guidance, marshalling, pushback coordination, de-icing, fuel slip, gate agent) under the rendered `airportToCrew` summary.
3. **"Datalink" is split by counterpart and function.** `aocAircraftDatalink` = AOC ↔ aircraft over ACARS (AOC messages). New `atcAircraftDatalink` = ATC ↔ aircraft (PDC, D-ATIS, CPDLC / Data Comm), rendered. `atcSurveillance` = aircraft → ATC (transponder, ADS-B Out). ADS-B is surveillance, not a datalink to the AOC. The aircraft-side equipment is broken out in the definitions (`CommunicationSystem`, `SurveillanceSystem.transponder`, `tcas`).
4. **Navaids stay in Infrastructure; lighting stays at the airport.** Most navaids are FAA-owned and FAA-maintained (NAS roadmaps; some non-federal). Airfield lighting is airport-owned and airport-maintained (14 CFR 139.311) and operated from the tower (BB 3-4-x). So navaids are *not* handled like lights (owner's question, answered).
5. **Role naming: Captain / First Officer.** `PilotInCommand` is renamed `Captain`. "PIC" is used only where the text is about legal authority (14 CFR 91.3). PF/PM and PNF are not used in the model. This matches the existing Seamster crosswalk abstraction ("PF/PM dropped; only Captain/FO kept").
6. **Supporting definitions added to `nas_sysml_package_definitions.sysml`:** AOC roles (dispatcher, flight follower, ATC coordinator, load planner, maintenance controller, crew scheduler, aircraft router, duty manager); TFM tools as absorbed media (`AirTrafficFlowManagementSystem`: TFMS, FSM, NTML, TBFM, DRT); TFM exchange items (EDCT, TMI advisory, FEA/FCA, TOS, CTOP assignment, schedule change, slot substitution, diversion recovery request); the dispatch release, fuel slip, FMS prediction, and the `PreflightCrossCheck` action performed by `FlightDeckCrew`; ground-handling roles, into-plane fueler, airfield lighting, and gate agents.
7. **Evidence grade `[SME]` added** for the owner's professional FMS knowledge (16 years in industry). It is stated as such in the write-up unless a citable source is found.

**Rationale:** the context view is a domain-to-domain picture of the NAS, so intra-domain links sit one level too deep for it (item 1). Rendering only decision-bearing exchanges keeps the view about where the intent chain can be changed (item 2). The ambiguous "datalink" term hid three different counterparts and authorities (item 3). Items 4–5 answer the owner's questions directly. Item 6 moves draft code into the definitions file per methods §10.1.

**Alternatives considered:**

- Keep ATCSCC ↔ TMU on the context view as the "enterprise → tactical" step. Rejected: that step now shows on the IBD, and the context view still shows where TFM meets the airline (`aocTfm`) and where the clearance meets the crew (`atcToCrew`).
- Drop flight plan filing from the model entirely (the owner's first instinct). Rejected: the filed plan is the data ATC correlates the track to (BB 5-3-3d) and the "cleared as filed" baseline. It is kept for traceability, just not rendered.
- One ATC ↔ aircraft connection for surveillance and datalink. Rejected: they differ in direction, medium, and whether the crew is in the loop.
- PIC/PNF or PF/PM naming. Rejected: those mix axes (legal authority vs task). Captain/FO is the only symmetric pair, and PNF was replaced by PM (FAA AC 120-71B).

**Evidence / source:** JO 7110.65BB 2-1-6, 2-6-2, 2-6-4, 2-7-1, 4-6-1/4, 5-1-2, 5-2-x, 5-3-3, 8-1-6 (extracted 2026-09-27); JO 7210.3EE 6-5, 18-4-5, 18-10-12, 18-12-3/4; Berry & Pace 2011; Munro 2018; Seamster 2011; `knowledge/models/context-diagram-exchange-evidence.md`.

**Consequences:**

- The context view renders 11 operational connections (was 12: minus `aocFlightPlanFiling` and `atcsccTmu`, plus `atcAircraftDatalink`) plus the 5 environment links that are live in the file.
- The §10 "Create operational IBDs" work has a first placeholder file.
- `FlightCrew::PilotInCommand` no longer exists; anything that referenced it uses `FlightCrew::Captain`.
- Open: the `atc` umbrella question (IBD file); a US source for gate authority; CTOP and SMART sources (to-do-list §4 additions); the GDP-substitution / diversion-recovery scenario (§9 addition).

---

## D-009 — Context diagram baseline: every system assessed against D-007; AOC link split to TFM; flight deck merged

**Date:** 2026-09-27
**Status:** active. Applies D-007 to the context diagram (`cameo_models/nas_context_diagram.sysml`), as D-008 applied it to the BDD. The candidate "retarget AOC → `atcscc`" from the 2026-09-26 journal is adopted here in modified form (a split).

**Decision:**

1. **Every system on the context diagram gets an explicit D-007 disposition**, recorded as a comment on its part in the `.sysml` file and in the table below. D-007's test: an entity is *modeled* when it has distinct decision authority or execution behavior, dynamically coupled to in-scope decisions, that materially affects cost, safety, workload, schedule reliability, or passenger value. Otherwise it is a boundary actor (supplies objectives, demand, feedback, or rules), a context constraint (exogenous), or absorbed (kept only as exchange content or a capability). Only modeled systems are rendered on the context view (`#ContextVisible`).
2. **The AOC ↔ Airspace Management link is split by counterpart.** Traffic-flow content (EDCTs, TMI and reroute advisories, TOS, Early Intent, FSM schedule changes, GDP substitutions) goes on a new `aocTfm` connection to `atcscc`. Flight-plan filing and amendment stays on `atc` as `aocFlightPlanFiling`.
3. **Pilot in command and first officer are merged into one `FlightDeckCrew` part** (new in `nas_sysml_package_definitions.sysml`, inside `FlightCrewDomain`). All crew connections attach to it. The two roles remain as its sub-parts for IBD and behavior work.
4. **The aircraft ↔ airport exchanges are kept as a complete set of 20 unrendered connections**, with one rendered summary link (`aircraftAirport`). The Airport sub-parts they attach to are absorbed.
5. **The mapping of the FAA's "system users / customers / flight operators" to `airlineOperationsCenter` (via its ATC coordinator) is recorded as an abstraction.**
6. **Takeoff performance (V-speeds, thrust / assumed-temperature settings) is modeled as provided by the AOC in the release package.** This is an abstraction: in practice it depends on the aircraft type, and some types (e.g. the 737) compute it in the FMS (owner, 2026-09-27). It keeps the crew's plan-vs-FMS cross-check limited to fuel, weight, ETA, and altitude predictions. Fuel is uplifted by the airport fuel carrier, whose fuel slip reaches the crew on `airportToCrew`.

**D-007 assessment of each system:**

| System (part) | Authority or execution behavior coupled to in-scope decisions | Material effect | Disposition | On context view |
|---|---|---|---|---|
| Airline Operations Center (`flightOps.airlineOperationsCenter`) | Operational control; dispatcher and PIC jointly responsible for the release (14 CFR 121.533); sets route and fuel plan | cost, schedule reliability | Modeled | rendered |
| ATCSCC (`airspaceMgmt.atcscc`) | "Final approving authority" for interfacility TMIs (JO 7210.3EE ¶18-2-3i); EDCT/CTOP/reroutes act directly on airline decisions | delay cost, schedule reliability | Modeled | rendered |
| TMU (`airspaceMgmt.tmu`) | Local TM latitude (MIT, fix balancing; ¶18-2-3 NOTE); turns national TMIs into sector constraints | schedule, controller workload | Modeled (one part for terminal and ARTCC TMUs) | rendered |
| Tactical ATC (`airspaceMgmt.atc`) | Clearance and separation authority (JO 7110.65BB) shapes the flown trajectory | safety, schedule | Modeled | rendered |
| TRACON, ARTCC (`tracon`, `artcc`) | Same as tactical ATC | same | Modeled in the BDD; covered by the `atc` umbrella at context level | not rendered |
| Flight deck crew (`flightCrew.flightDeckCrew`) | PIC final authority (14 CFR 91.3); turns plan + clearances into FMS intent | safety, workload, fuel | Modeled, as one element | rendered |
| Cabin crew (`flightCrew.cabinCrew`) | No authority over in-scope decisions; "cabin secure" couples to departure time only weakly, through the PIC | safety (outside the selected scenarios) | Inside the modeled Flight Crew domain, absorbed at context level | not rendered |
| Aircraft (`aircraftSys.aircraft`) | No decision authority, but its execution behavior (FMS intent → guidance → motion) is the end of the intent chain | fuel burn, safety | Modeled | rendered |
| Airport operator (`airportOps.airport`) | Gates, non-movement area, closures, slots at coordinated airports; departure readiness couples to EDCT compliance | schedule reliability | Modeled (weakest evidence of the set: C/B) | rendered |
| Airport sub-parts (fuel distribution, ground handling, gates, terminals, baggage, cargo, maintenance hangar) | Carry out decisions made by other actors (AOC fuel and load orders, passengers, weather, maintenance status, ATC/ramp clearance) | turnaround time, but not as a decision lever | Absorbed | only as ends of unrendered connections |
| Ticketing system (`flightOps.ticketingSystem`) | Revenue/booking side; enters only as passenger demand | — | Absorbed (a boundary-actor effect) | not rendered |
| Governance (`environment.governance`) | Supplies rules | — | Boundary actor | not rendered (draft link) |
| Passengers (`environment.passengers`) | Supply demand; mediated by airline decisions | — | Boundary actor | not rendered |
| Military (`environment.military`) | Special-use airspace as a scenario condition | — | Boundary actor | not rendered (draft link) |
| Infrastructure incl. navaids, weather service (`environment.infrastructure`) | Exogenous signals and constraints | — | Context constraint | not rendered; `apNavaidSignals` unrendered, weather link drafted |
| Maintenance Suppliers | Exogenous parts/cost/availability | — | Context constraint | no part yet |
| Information Services (`environment.informationServices`) | Channels (NTML, TFMS, ACARS) matter only when they change a decision or KPI | — | Absorbed (carried as the media in connection docs) | not rendered |
| Decision Support (`environment.decisionSupport`) | Tools (FSM, TBFM, CTOP) operated by modeled systems | — | Absorbed (a capability of ATCSCC/TMU/AOC) | not rendered |

**Rationale:**

- *Split:* JO 7210.3EE Ch. 18 (grade A) shows the operator exchanging EDCTs, TOS, schedule changes, and GDP options directly with the ATCSCC/TFMS, not with tactical controllers. §6-5 of the same order shows flight plans going computer-to-computer to the ARTCC host. The old single link mixed two counterparts with different authority. Separating them puts the airline-vs-NAS flow conflict (§9) on its own link.
- *Merge:* under D-007's test, the Captain and FO do not hold separate decision authority at context level. Final authority attaches to the PIC, and pilot-flying/pilot-monitoring duties swap between them (Seamster 2011, p.44). Every crew link had been drawn twice with identical content. GreAT D2.2's operational IBD also has no separate crew node.
- *Aircraft ↔ airport set:* none of these exchanges changes an optimization outcome. Each one carries out a decision made on another actor's link, so rendering them would add clutter without showing a decision lever (owner, 2026-09-27).

**Alternatives considered:**

- Pure retarget of AOC → `atcscc` (the 09-26 proposal). Rejected: it would drop the grade-A flight-plan filing path to the ARTCC host.
- Keep one AOC → `atc` link. Rejected: the TFM counterpart is evidenced as the ATCSCC, not tactical ATC.
- Keep PIC and FO as separate endpoints. Rejected: duplicate connectors, no authority difference at context level.
- Connect crew links to the whole `flightCrew` domain. Rejected: that would fold cabin crew into the flight-deck interface.
- Drop the aircraft ↔ airport exchanges from the model. Rejected: the owner wants the set kept for completeness and later IBD reuse.

**Evidence / source:** `knowledge/models/context-diagram-exchange-evidence.md`; `evidence/literature-notes/summaries/5 - faa2025jo72103ee.md` (¶18-2-3i, 18-4-1d, 18-8-2c/3d, 18-10-3/6e/12, 18-12-3b, §6-5); `5 - faa2025jo711065bb.md`; `knowledge/models/interaction-catalog-flight-execution.md` (PF/PM → Captain/FO crosswalk); GreAT D2.2 Figure 3; journal 2026-09-26 (14:06 recommendations) and 2026-09-27.

**Consequences:**

- The context view renders 12 connections among 7 systems. The per-connection doc comments give the evidence grade and sources.
- Anything that referenced `flightCrew.pilotInCommand` or `.firstOfficer` directly must now go through `flightCrew.flightDeckCrew`. Only the context diagram did.
- The PIC/FO distinction, including the FO working the radio, returns only at IBD or behavior level.
- Open items carried forward in the `.sysml` TODOs: whether `atc` should hold `tracon`/`artcc` as sub-parts; the environment links (drafted, not rendered); the AOC ↔ Airport link, which has the weakest US evidence.

---

## D-008 — BDD reconciled to D-007: modeled systems vs. Environment, split by ratified disposition

**Date:** 2026-09-22
**Status:** active. Applies D-007's ratified boundary to the SysML v2 BDD
(`cameo_models/nas_sysml_package_definitions.sysml`); does not touch D-002's domain-
decomposition question, which stays provisional pending §6.

**Decision:** Restructured the BDD's top-level composition to mirror D-007's disposition
column instead of treating all nine pre-ratification D-002 packages uniformly:

1. `part def NationalAirspaceSystem` now composes only the five ratified Modeled System
   domains: Airspace Management, Flight Operations, Airport Operations, Aircraft Systems,
   and a new `FlightCrew` package (Captain/First Officer roles) that was entirely absent
   from the pre-ratification first pass.
2. A new `part def Environment` composes everything else — Governance, Passengers,
   Military, Infrastructure, Information Services, Decision Support — so the still-unbuilt
   NAS context diagram has boundary-crossing actors/constraints to reference, without
   decomposing any of them into constituent systems.
3. Governance's `FederalAviationAdministration` constituent part was removed (Governance
   is now a single opaque actor); the empty `AirspaceResources` package was merged into
   `Infrastructure` (D-007 treats "Infrastructure / Airspace Resources" as one row);
   `Passengers` and `Military` packages were added as opaque boundary actors (previously
   unmodeled).

**Rationale:** `system_of_interest_definition.md`'s "Included and excluded scope" is
explicit that the project does not decompose passengers, regulators, military, suppliers,
information services, infrastructure, or decision support into independent internal
systems — but the pre-ratification BDD did exactly that (nested FAA under Governance,
SatelliteSystem/WeatherService under Infrastructure, SWIM under InformationServices) and
was entirely missing Flight Crew, a ratified Modeled System. Splitting the composition by
D-007 disposition (modeled vs. environment) makes the model match the ratified boundary
and gives the context diagram a real SOI-boundary/environment split to draw ports and item
flows across, per MagicGrid step 0 (`sysmlv2_exploration.md` §3a).

**Alternatives considered:** Keep all nine domains flat inside `NationalAirspaceSystem`
and just strip internal decomposition from the non-modeled ones in place (rejected by the
project owner — a separate `Environment` part def was preferred so the context diagram,
which the project owner is authoring directly rather than delegating, has an explicit
boundary to draw against).

**Open question carried forward:** Information Services and Decision Support are rated
"Absorbed / Abstracted" in D-007, not "Boundary Actor" or "Context Constraint" — arguably
their effects should stay attached to the modeled systems they inform (e.g. Decision
Support's `VehicleDynamicsModel` feeds §12-§13 traceability) rather than sit in
`Environment` alongside true external actors. Placed in `Environment` here as a
simplification; flagged in `knowledge/questions/open-questions.md` for confirmation before
the context diagram treats them as boundary-crossing actors.

**Evidence / source:** `knowledge/models/system_of_interest_definition.md`,
`decisions-log.md` D-007, `cameo_models/sysmlv2_exploration.md` §3a (MagicGrid step 0).

---

## D-007 — Ratified SOI boundary and analytical scope

**Date:** 2026-09-21
**Status:** active. Supersedes the provisional SOI boundary documented before this
decision; it refines, but does not supersede, D-002's candidate domain decomposition.

**Decision:** Ratify the NAS-as-SoS System of Interest around the trajectory-intent
lifecycle from enterprise objectives through aircraft motion. Model Airspace
Management/ATC, Airport Operations, Flight Operations for Part 121 scheduled passenger
operators, Aircraft Systems, and Flight Crew as modeled systems. Include Governance /
Regulatory and Legal, Passengers, and Military as boundary actors. Treat Infrastructure
/ Airspace Resources and Maintenance Suppliers as context constraints. Absorb or
abstract Information Systems and Decision Support, while retaining their effects as
information exchanges or capabilities when relevant.

**Rationale:** An entity is modeled when it has distinct decision authority or execution
behavior dynamically coupled to in-scope decisions and materially affects cost, safety,
workload, schedule reliability, or passenger value. Boundary actors supply objectives,
demand, feedback, or rules without being decomposed as decision mechanisms. Exogenous
influences enter as constraints or scenario parameters. This criterion preserves the
authority and responsibility relationships needed for a systems-of-systems architecture
without expanding the project into a model of every NAS participant.

Passengers remain boundary actors because demand, willingness to pay, passenger mix, and
time sensitivity influence airline choices about fares, frequency, aircraft assignment,
connections, and delay/rerouting tradeoffs. Revenue passenger miles provide an
aggregate measure of passenger traffic and airline output; affordability, schedule
reliability, and satisfaction remain value measures. Passengers do not directly set
fares or aircraft speed, which are mediated by airline revenue-management and
operations decisions.

Part 121 scheduled passenger operations define the modeled operator population. General
aviation, scheduled cargo, international airspace, and military operations remain
outside that modeled population, but may be represented as background traffic or
constraints when their omission would materially distort a selected KPI. This is an
analytical scope choice, not a claim that those activities are unimportant to the real
NAS.

**Alternatives considered:** A broad model of all NAS organizations was rejected as
unbounded. A purely physical decomposition was rejected because it hides authority,
information ownership, and stakeholder tradeoffs. Treating passengers, regulators, or
military operations as fully decomposed systems was rejected because their internal
decision mechanisms are not the focus of the selected scenarios. Treating all
information services and decision support as external was rejected because their
information and recommendations still affect modeled decisions; they are therefore
abstracted rather than ignored.

**Evidence / source:** `knowledge/models/system_of_interest_definition.md`, the
2026-09-21 SOI-boundary review conversation, `knowledge/models/stakeholder-register.md`,
and D-002's authority/responsibility/information-ownership framing.

**Consequences:** The SOI definition and project index become the scope baseline for
architecture work. Future changes to the modeled population require a new decision or
an explicit scenario-level justification. The baseline holds regulation and external
constraints fixed; sensitivity analysis may vary them later.

---

## D-006 — SysML v2 text (authored in Syside Modeler / VS Code) is the source of truth; Cameo is optional and downstream

**Date:** 2026-09-19
**Status:** active. Amends the tool half of D-003 ("SysML in Cameo"); the language,
method, and everything else in D-003 stand.

**Decision:**

1. The `.sysml` files under `projects/nas-sos-capstone/cameo_models/`, authored in
   Syside Modeler in VS Code, are the single source of truth for the architecture model.
2. Cameo/MagicDraw is **not** the source of truth. Anything brought into Cameo (by
   import, script, or hand rebuild) is a derived copy; if it and the `.sysml` text
   disagree, the text wins and the Cameo copy is regenerated or fixed.
3. Getting the model into Cameo is deferred and optional — see the hand-off options in
   `workflows/update-architecture.md`.
4. `prework/nas_system_of_systems_architecture.xml` is a pre-modeling draft. It was
   described as generated from Cameo, but no Cameo export ever existed; it is not kept in
   sync with the `.sysml` files. If it disagrees with them, the `.sysml` files win.

**Rationale:** The university's Cameo/MagicDraw install (2024x Refresh 1, checked
2026-09-19) does not support SysML v2 out of the box, and no known tool converts v2 text
into a form it can open. The model was already being authored in SysML v2 text, so making
Cameo the source of truth would have meant rebuilding it by hand in SysML v1 just to
satisfy the workflow doc. Keeping the text as the source avoids a two-model sync problem
until a reliable import path exists.

**Alternatives considered:** Cameo (SysML v1) as the source of truth with the `.sysml`
text as a scratch draft (rejected — duplicates the model in a different metamodel, and
the v1 copy would drift); requesting a newer Cameo release that supports v2 (the university may be able to
provide one, but the user chose not to pursue it; if it were obtained, direct textual
import would become the hand-off path and this decision's source-of-truth call would be
unchanged).

**Adviser:** Mark Petrotta recommended Syside/SysML v2 and will accept it as the model
deliverable (per the user, 2026-09-19).

**Open consequences:** The `cameo_models/` folder name is now historical (it holds the
SysML v2 model); renaming it would touch many references and hasn't been done.

**Evidence / source:** 2026-09-19 session — user's report of Cameo 2024x Refresh 1
lacking SysML v2 support, and the direction that Syside/VS Code is the source of truth.

---

## D-005 — Instance/scenario content and simulation code kept separate from the structural model, with a documented (not language-level) trace between SysML and Python

**Date:** 2026-09-19
**Status:** active

**Decision:** Three file-organization/pattern choices for extending the SysML v2 model
going forward:

1. Structural definitions (domains, system types — D-002's decomposition) stay in
   `cameo_models/tutorial.sysml`; concrete scenario instances (a specific flight, its
   airports/procedures) go in new files under `cameo_models/scenarios/`, one per
   scenario.
2. The vehicle-dynamics simulation capability is split: SysML declares only the
   interface (a `calc def` in the `DecisionSupport` package — reflecting the project's
   existing "decision-support is a capability, not a physical system" framing), and the
   real physics is a plain Python module under
   `projects/nas-sos-capstone/simulation/` (a sibling of `cameo_models/`, not inside it,
   since it's code/deliverable content for §12, not model content for §10).
3. The link between the `calc def` and the Python implementation is a documented,
   hand-maintained trace (doc comments naming the module/function, and field names kept
   identical on both sides) — not a language-level binding.

**Rationale:** SysML v2 does support an opaque external-language `calc def` body
(`language "..." /* code */`), but the only broadly-implemented execution path for that
runs through Jython (JVM Python 2), tool-specific to commercial modelers like
NoMagic/Cameo — not CPython, and not a fit for real physics (numpy/scipy) or for a tool
this project can't confirm supports it. Keeping the model and the code as separate
artifacts with an explicit, human-readable trace is the same shape the project already
uses for decision-support/optimization generally (README.md/index.md working
assumptions: a capability layered on the architecture, not embedded in it) — extending
that pattern to simulation keeps the project's tooling assumptions consistent instead of
introducing a second, incompatible integration style.

**Alternatives considered:** Embedding Python via `calc def`'s `language` opaque body
(rejected — Jython-only in practice, not verified against this project's tool, wrong
Python semantics for numeric work); a `part def` for the vehicle dynamics model under
`AircraftSystems` instead of `DecisionSupport` (rejected — it's a simulation/analysis
capability that reads and predicts Aircraft state, not a constituent onboard system,
same reasoning the project already applies to decision-support/optimization).

**Evidence / source:** `workflows/sysml-instance-modeling.md`,
`workflows/vehicle-simulation-model.md`, and 2026-09-19 web research on SysML v2 calc-def
external-language support (Jython-based in current tools) — see
`projects/nas-sos-capstone/journal/2026-09-19.md` for the session's search trail.

---

## D-002 — Layered domain decomposition over a flat object list

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active, but explicitly provisional — see [[open-questions]]

**Decision:** Organize the architecture around connected domains (Governance, Airspace
Management, Airspace Resources, Flight Operations, Airport Operations, Aircraft Systems,
Information Services, Infrastructure, Decision Support) built around authority,
responsibility, and information ownership — rather than a flat catalog of aviation
objects (aircraft, radars, airports, etc.).

**Rationale:** A flat list of "things in aviation" doesn't expose who owns what
responsibility or how information moves between owners, which are the questions an ISD
architecture needs to answer. The domain decomposition makes airspace sectors, controller
responsibilities, flight intent, clearances, weather products, surveillance tracks, and
trajectory intent into first-class architecture elements instead of background noise.

**Alternatives considered:** Physical/object-based decomposition (rejected — hides
authority/information ownership); a single all-encompassing NAS diagram (rejected — not
bounded enough to finish).

**Revisit when:** `projects/nas-sos-capstone/to-do-list.md` §6 ("Explore Alternative
System Decompositions") is worked — that section explicitly plans to build organization-based,
lifecycle-based, physical, information-flow, and decision-authority decompositions and
compare them. This decision may be confirmed, refined, or replaced by a decision to keep
multiple parallel viewpoints instead of one canonical decomposition.

---

## D-001 — Pivot from trajectory/rendezvous optimization to NAS-as-SoS architecture

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active

**Decision:** Reframe the capstone from a rendezvous/trajectory optimization problem to
a broader systems-of-systems architecture of the National Airspace System, with
optimization/decision-support demoted to one capability inside that architecture rather
than the whole subject.

**Rationale:** The original optimization framing didn't showcase the strengths an ISD
capstone is meant to demonstrate — architecture, interfaces, responsibility,
traceability. The NAS-as-SoS framing does, while still leaving room for an optimization
case study (see `projects/nas-sos-capstone/to-do-list.md` §11–§13) to demonstrate how
architecture exposes cross-stakeholder impacts that a standalone optimizer would miss.

**Alternatives considered:** Keep the narrow trajectory-optimization scope (rejected —
too mathematical, not architecture-centric enough); go fully broad and survey all of
aviation (rejected — not bounded enough to finish, see index.md working
assumptions).

**Evidence:** `projects/nas-sos-capstone/prework/gpt_convos.md` (both conversations),
`README.md` "Capstone Direction" and "Working Assumptions" sections.

---

_Template for new entries:_

```
## D-00N — <short decision title>

**Date:** <date>
**Status:** active | superseded by D-00X | reverted

**Decision:** <what was decided>
**Rationale:** <why, including the specific constraint/tradeoff that drove it>
**Alternatives considered:** <what else was on the table and why it lost>
**Evidence / source:** <file or conversation that documents this>
```
