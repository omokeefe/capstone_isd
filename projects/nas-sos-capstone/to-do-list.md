# NAS System-of-Systems Capstone — To-Do List (plan of record)

**Restructured 2026-10-10 under D-016** (`decisions/decisions-log.md`). This file is still the single source of truth for task state. What changed: the 16 fixed-order sections of the August plan are replaced by four parallel tracks and nine weekly turns built around the graded course dates; diagrams and experiment tables carry a **state** (0 to 4) instead of a single checkbox; sections tailored out of the plan are kept at the bottom under "Future work" (collapsible blocks hold the moved checklists verbatim). The August section numbers (§1 to §16) are kept in parentheses so older journal entries and `\plantodo` notes still resolve. Every tailoring row is the owner's to change (D-016).

**Artifact states** (D-016): 0 not started · 1 drafted (renders or reads clean) · 2 hand-reviewed (transcription in `handwritten/`, directions applied) · 3 evidence-graded (every link or number has a source, an `[SME]` mark or a stated assumption) · 4 in the report (owner-written body text refers to it).

**Graded dates** (`prework/course-info-canvas.md`, all 11:59 pm ET): Interim Report #2 **Sun 2026-10-25**; peer presentation slot Nov 17 to 19, upload by **Fri 2026-11-20**; Project Review #3 **Sun 2026-11-22**; Final Report #4 and synopsis **Sun 2026-12-13** (optional draft to the adviser about Dec 6). Owner budget: 10 to 20 hours a week, about 12 per turn.

## Turns (each ends on a Sunday)

| Turn | Dates | Model (Track A) | Experiment (Track B) | Report and course (Track C) | Exit test |
|---|---|---|---|---|---|
| 1 | Oct 10 to 18 | ✅ D-016 to D-019 logged. ✅ `architectureState` on requirements, five tagged `improved`. ✅ Swimlane test and Syside Python licence test. ✅ Owner hand-reviewed the requirements; 27 + 53 cut to 12 + 28 (D-020), then to 13 + 23 in a second review 2026-10-11 (D-021). ☐ Owner reads section 7 of `requirements-and-traceability.md` (`#TODO` item (f)). | ✅ Central claim and scenario numbers proposed (D-016; `experiment-scenario-numbers.md`). ✅ OpenAP installed; smoke and envelope scripts run; first scoring run. ☐ Owner confirms the Decide items and re-runs. | ✅ Housekeeping. ✅ `\irtwo` call-outs in place. ☐ Owner drafts Assumptions and Methodology (5 h). | Four decisions logged ✅; OpenAP returns B39M numbers ✅; both figures render ✅; stakeholder requirements reviewed ☐. |
| 2 | Oct 19 to 25 | ☐ Interface defs for the FMS → AOC and ATC → crew exchanges (AOC → ATC done, D-019). ☐ Caption re-wording. | ☐ Both hand checks (`experiment-definition.md` §9). ☐ Preliminary number and baseline row in Section 4. | ☐ **Interim Report #2** to the adviser; Progress Update #2. ☐ Ask which Review #3 option. | Report sent. |
| 3 | Oct 26 to Nov 1 | ☐ Test `SequenceView`; draft the conflict-resolution sequence. ☐ `atc` umbrella decided. | ☐ `experiment_scoring.py` passes its tests at `nominalMass` (done for base) and the first variation. | ☐ Apply adviser comments. | Tests pass; sequence renders. |
| 4 | Nov 2 to 8 | ☐ Hand-review the sequence diagram. ☐ Owner names a verification case and measure for the nine thread system requirements and reviews the 28 next-tier requirements Claude drafted 2026-10-11 (D-022). ☐ Verification cases filled with measured values. | ☐ Run A to D at `actualMass` on the confirmed scenario; fill tables. **Fallback decision Nov 8** (D-017). | ☐ Tables into Section 4. | Tables have confirmed numbers. |
| 5 | Nov 9 to 15 | ☐ Grade the airspace IBD and the thread links. ☐ `tools/check_model.py` passes. | ☐ Similar-weights variation written up. | ☐ Presentation from the diagrams and tables (course template). | Slides complete. |
| 6 | Nov 16 to 22 | Corrections only. | ☐ What the result shows and does not. | ☐ **Presentation** and **Review #3**. | Both submitted. |
| 7 | Nov 23 to 29 | ☐ Final diagram review. **Model freeze Nov 29.** | Closed. | ☐ Results and Discussion in full; architecture evaluation; SE-approach table. | No body diagram below state 3. |
| 8 | Nov 30 to Dec 6 | ☐ Final renders. | Closed. | ☐ Recommendations, Impact, Conclusions, Executive Summary, GenAI citation. ☐ Draft to the adviser. | Whole draft sent. |
| 9 | Dec 7 to 13 | None. | None. | ☐ Adviser comments, synopsis, **Final Report #4**. | Submitted. |

"If time" items (not in any exit test): the Pareto-front yes/no column; the two-type variation (B777 and 737, D-014); the at-or-below-FL350 variation; RACCI beyond the six thread decisions; typing connections beyond the three on the thread.

## Track A — Model (§10, §13)

**One traced thread carries the project:** airline cost objective → SN-AIR-05 → SLR-INF-02 and the goal SLR-CLR-13 (D-020) → `AirlinePerformanceShare` interface (D-019) → conflict-resolution sequence → verification cases (`nas_verification.sysml`) → outcome table. Everything off the thread is appendix or future work.

| Artifact | File or view | State now | Target by Oct 25 | Nov 22 | Dec 13 |
|---|---|---|---|---|---|
| Context diagram | `cameo_models/nas_context_diagram.sysml`, view `systemContext` | 2 (D-009 to D-012; the reason behind each link not yet written) | 4 | 4 | 4 |
| Definitions tree | `cameo_models/nas_sysml_package_definitions.sysml` | 2 | 2 | 3 | 4 |
| Aircraft IBD, default view | `nas_ibd_aircraft.sysml`, view `aircraftIbd` | 2 (links not graded) | 3 | 4 | 4 |
| Aircraft IBD, detail view | same file, view `aircraftIbdDetail` | 2 | 2 | 2 | appendix only |
| Airspace management IBD | `nas_ibd_airspace_management.sysml` | 1 (placeholder; `atc` umbrella question open) | 1 | 3 | 4 |
| Nominal operations activity diagram | `nas_activity_diagram-nominal_ops.sysml`, view `nominalOpsActivity` | 1 (phase level; `Prework` unconnected; swimlanes answered in `sysml-diagram-rendering.md` §9) | 1 | 2 | 4 |
| Sequence diagram, case C conflict resolution | new file | 0 (`SequenceView` untested) | 1 | 3 | 4 |
| Typed interfaces on the thread | `AirlinePerformanceShare` (D-019) done; FMS → AOC and ATC → crew | 1 of 3 | 3 of 3 | 3 | 4 |
| Analysis package | `nas_analysis.sysml` (D-017) | 1 | 1 | 3 | 4 |
| Verification cases | `nas_verification.sysml` (D-018) | 1 (no measured values yet) | 1 | 3 | 4 |
| Requirements model | `requirements_*.sysml` | 1 (owner review in progress) | 2 (stakeholder set reviewed) | 3 (thread set reviewed, next tier written) | 4 |
| Trace thread | the chain above, read end to end in one appendix table | 1 | 1 | 3 | 4 |

Kept items from the August §10 list, with their state above:

- [x] Create package/model organization. *(2026-09-19; D-002 domains, `Common` package.)*
- [x] Create stakeholder model. *(stakeholder requirements by group, 2026-10-10 draft.)*
- [x] Create system BDDs. *(2026-09-19; reconciled to D-007 on 2026-09-22, D-008.)*
- [ ] Create NAS context diagram. *(state 2; box closes at state 4.)*
- [ ] Create operational IBDs. *(aircraft state 2, airspace state 1.)*
- [ ] Information-object and item-flow model → the three typed interfaces on the thread (D-019). *(1 of 3.)*
- [ ] Create nominal-flight activity diagram. *(state 1; swimlanes = lanes-as-boxes general view plus an allocation matrix, §9 of the rendering note.)*
- [ ] Create the conflict-resolution sequence diagram. *(state 0.)*
- [ ] Create requirements model. *(AI draft 2026-10-10 of 27 + 53, cut to 13 + 23 by the owner's hand reviews of 2026-10-10 and 2026-10-11 (D-020, D-021); open points in the `#TODO` block in `knowledge/models/requirements-and-traceability.md`; "The NAS shall" stays the subject at the SoS tier, owner 2026-10-10.)*
- [ ] Trace the one thread end to end: objective row → stakeholder requirement → system requirement → interface → sequence step → verification case → outcome-table cell. *(Replaces the five separate trace lines of the August plan.)*
- [ ] `tools/check_model.py`: every `improved` requirement has a `verify`; every thread requirement has a `satisfy`; every thread interface has two typed ports (turn 5, Syside Python API; licence confirmed 2026-10-10).
- [ ] Model freeze 2026-11-29; corrections only after.

## Track B — Experiment (§11, §12, §13)

Design files: `knowledge/models/experiment-definition.md`, `experiment-options-and-scoring.md`, `experiment-scenario-numbers.md`; code: `simulation/experiment_scoring.py`, `scenario_base.yaml`, `b739_envelope.py`, `openap_smoke.py`; runner: `tools/run_experiment.py`.

- [x] Select a tractable representative scenario. *(Crossing conflict, four aircraft, one sector; D-013 to D-015.)*
- [x] Define participating systems and stakeholders, decision variables (the nine options), constraints (separation, blocked levels, climb rule, thrust limit). *(`experiment-options-and-scoring.md` §2.)*
- [x] Define stakeholder objective functions, one statement per level, no weighted sum. *(§4; D-013 item 2.)*
- [x] Define the baseline (case A) and the experiment matrix (cases A to D × base scenario and the similar-weights variation).
- [x] Choose the truth model. *(OpenAP, D-017, 2026-10-10.)*
- [x] Develop the minimum viable simulation. *(`experiment_scoring.py`, first run 2026-10-10; 14 tests pass.)*
- [ ] Central claim: the owner's sentence. *(Proposed wording in D-016 / the 2026-10-10 plan; log it when confirmed.)*
- [ ] Confirm every Decide item in `experiment-scenario-numbers.md` (city pairs, masses, cost indexes, schedule deltas, hold length, vector miles, tie-breaker, prices).
- [ ] Do the two checks before trusting any number (`experiment-definition.md` §9): effect size by hand; the information check by hand on three or four context-diagram decisions.
- [ ] Establish the baseline scenario as confirmed and re-run cases A to D at `actualMass`.
- [ ] Run the similar-weights variation (the not-rigged check).
- [ ] Quantify externalities: who pays, read across the rows (largest cost to any one aircraft; AC3 and airline X carry O9's second instruction).
- [ ] Compare the local and system-level readings of the table (the sub-system against system discussion).
- [ ] Write what the result shows and does not show, including the limits in `experiment-definition.md` §10 and the OpenAP polar limitation.
- [ ] Fallback decision by 2026-11-08: keep OpenAP or switch to a `mori2022massCruise` lookup (D-017).
- [ ] Fill the verification cases' measured values from `cameo_models/results/experiment_results.sysml`.

## Track C — Report and course (§1 report fixes, §16)

Interim Report #2 checklist: `report/README.md`. Red `\irtwo` notes in the compiled PDF mark every required part.

- [ ] **Interim Report #2 (Oct 25):** Introduction updated; Assumptions and Methodology; Results and Discussion (preliminary); References; GenAI disclosure; review meeting; Word copy to the adviser; Progress Update #2 in Canvas; ask which Review #3 option.
- [ ] **Peer presentation** (upload by Nov 20; sign up for a Nov 17 to 19 slot; `prework/503 Project Presentation Template-v26.pptx`).
- [ ] **Project Review #3** (Nov 22): option per the adviser.
- [ ] **Final Report #4 and synopsis** (Dec 13): adviser first, then Canvas.
- [ ] Report fixes carried from §1: the literature-review annotation-coverage claim (check the real count in `evidence/source-register.md`); spot-check citations sourced to skimmed-only references (`castro2013aoccMasThesis`, `great2020d21tboConcept`, `great2021d22operationalArch`, `hu2024disruptionOptReview`); replace or caveat the 1998-dollar `clarke1998irregular` figures.
- [ ] Section 2 Assumptions and Methodology (section numbers as printed in the report since D-026): working assumptions (including the security assumption, D-019, and the experiment's limits); systems-engineering-approach table and tailoring paragraph (D-016); decomposition kept, alternatives named (§6 as one paragraph); MBSE methodology and the working loop; the proposed interface (positioning drafted by Claude 2026-10-11, owner to rewrite).
- [ ] Section 3 Experiment (new, D-026): scenario and why one; cases and options; scoring; aircraft model and its simplifications; worked example. Owner to read the OpenAP paper and Bartel and Young, or cite a source that has been read.
- [ ] Section 1 Introduction: the two claims (also in the Executive Summary); research-gap paragraph (what this project adds beyond Coppenbarger, ADS-C EPP, TASAR); current-state paragraphs (October version drafted by Claude 2026-10-11, owner to rewrite); scope: answer the throughput/capacity question and confirm the de-scoping reasons; timing subsection shows the turns.
- [ ] Section 4 Results and Discussion: operational concept, stakeholder objectives and trace back to the model (each drafted by Claude 2026-10-11, owner to rewrite); architecture, detailed and abstracted (the three improved requirements as the measured gap); the one worked conflict (§9); the experiment results and discussion; emissions and who pays.
- [ ] Section 5 Impact; Section 6 Conclusions and Recommendations (limitations from `lessons-learned.md` and the Future work section below); Executive Summary last.
- [ ] Appendices: full options table and four-level scoring; the thread trace table; stakeholder requirements (reviewed) and system requirements (reviewed on the thread, unreviewed marked); the one RACCI table (§7, six thread decisions); diagrams not in the body; source register; GenAI disclosure.
- [ ] GenAI-use citation and disclosure (course policy; owner drafts; check with the adviser).
- [ ] Course minimum requirements check: current-state metric = case A (D-018); improvement claim = cases C and D by simulation; value to the sponsor stated in operational terms with a caveated dollar figure (`report/sections/06_impact_financial_benefits.tex` scope flag).
- [ ] Owner re-words the five view captions in `cameo_models/nas_package_my_views.sysml` and the appendix lead-in; restates or strikes the eight candidate entries in `lessons-learned.md`.

## Track D — Evidence on demand (§2 to §4 replaced)

A source is read when a diagram link, an experiment number or a requirement needs it, and registered when it is used (`workflows/process-references.md`, `annotate-source.md`). The August literature milestone's metric, "10 to 20 papers categorized," is met: 84 ledger rows.

- [x] Register the three PDFs held since 2026-10-05 (two Sheth papers, SESAR Solutions Catalogue 2019). *(2026-10-10.)*
- [x] Register OpenAP, the INCOSE Guide to Writing Requirements and ISO/IEC/IEEE 15288 as web-only entries. *(2026-10-10; confirm the GtWR document number before citing.)*
- [ ] Kept from §4: the en-route ARTCC control and sector-to-sector handoff transitions (responsible actor, decision authority, required information, communications mechanism, trigger, resulting aircraft action) from JO 7110.65BB, for the sequence diagram and SN-CRW-08 (SLR-CLR-07 was struck in the 2026-10-10 hand review, D-020).
- [ ] Kept from §4: a citable crew ↔ FMS source (ARINC 702A, an FCOM, or FAA AC 120-71B), or state the owner's `[SME]` experience in the write-up.
- [ ] Fill the source register's four unchecked columns (lifecycle phase, architectural evidence, optimization evidence, SysML artifact) for sources cited on the thread only.
- [ ] Sources still needed for the experiment: a dated jet fuel price; a dated CORSIA credit price; a social cost of carbon with its year and discount rate; a passenger-choice study on emissions labels; the altitude dependence of non-CO2 effects; the Sheth response count (Section VI).
- [ ] Read OpenAP's validation section (`sun2020openap`) and note its stated accuracy before the final report.

## Verification checklist (§15 reduced; run in turn 7)

- [ ] Every diagram in the report body is at state 3 or above.
- [ ] Every thread requirement has a `measureOfPerformance` or an explicit "qualitative" mark; every `improved` requirement has a `verify` and a measured value.
- [ ] The thread reads end to end in one appendix table.
- [ ] Limitations in Section 7 are drawn from `lessons-learned.md`, the Future work section below, and the experiment's own limits.
- [ ] `tools/run_experiment.py --fidelity actualMass` reproduces the report's tables and figures from one command.

## Done and closed

- [x] §1 Establish Research Framework: research questions, SOI definition (D-007), source register, milestone timeline, Interim Report #1 (submitted 2026-09-17; all content reviewed and finalized by the owner). The four report fixes it left open are in Track C.
- [x] §8 Objective / Cost / Value Ontology (`knowledge/models/stakeholder-objective-ontology.md`). The three proposed rows (airline data protection, passenger safety, Governance) are not added: the owner judged them not relevant in the 2026-10-10 hand review (D-020). Remaining: name the outcome-table columns as measures of effectiveness.

## Future work (tailored out under D-016; named in the report's limitations and future work)

Each block below holds what the August plan asked for, moved here verbatim so nothing is lost. None of it is scheduled.

<details>
<summary>§2 Literature Review — Airline Planning and Operations (six per-paper checklists, about 90 boxes)</summary>

Papers: Eltoukhy, Chan and Chung (airline schedule planning review); Deng and Santos (airline scheduling optimization review); Integrated Airline Scheduling; Airline Timetable Development and Fleet Assignment Incorporating Passenger Choice; Airline Crew Scheduling: Models, Algorithms, and Data Sets; aircraft maintenance routing literature. For each: read and annotate, identifying actors/stakeholders, systems/organizations, objectives, costs/penalties, decisions, decision authority, activities/processes, resources, information inputs and outputs, constraints, interfaces/handoffs, timescales of decisions, upstream dependencies, downstream consequences, optimization variables, objective functions / measures of effectiveness, evidence of conflicts between local and system-level objectives, and a map of findings to candidate SysML elements. Paper-specific items: sequential versus integrated optimization and the coupling among schedule, fleet, routing and crew decisions (Deng and Santos); which planning functions are traditionally decomposed and the consequences (Integrated Airline Scheduling); the passenger-choice model and the conflict between airline and passenger optimality (timetable paper); crew pairing versus rostering, regulatory and contractual constraints, interfaces with flight scheduling and aircraft routing (crew paper); maintenance requirements, aircraft states and the impact of routing on future flights (maintenance routing). The sources stay registered in `evidence/source-register.md`.

</details>

<details>
<summary>§3 Literature Review — Day-of-Operations and Turnaround (five sources, about 70 boxes)</summary>

Sources: Schultz, A Review of Aircraft Turnaround Operations and Simulations (actors, systems, physical resources, activities and their precedence and concurrency, objectives, costs, constraints, information exchanges, milestones, decision authority, turnaround performance metrics, dependencies with inbound and outbound flights, map to activity diagrams and IBDs); Managing Turnaround Performance through Collaborative Decision Making (participating stakeholders, individual, shared and conflicting objectives, information shared and its ownership, decision authority, collaboration mechanisms, KPIs/MOEs, consequences of information delay or error, map to RACCI and the information model); EUROCONTROL A-CDM Specification (actors, systems, operational milestones, information objects with producer and consumers, decision authority, target/estimated/actual times, milestone dependencies, network ATM, airport and airline interfaces, map of milestones to SysML events/states/activities and exchanges to IBD item flows); EUROCONTROL A-CDM Implementation Manual (implementation versus specification, responsibilities, interfaces, assumptions, measures of success, ConOps examples); weight and balance / load control literature (actors, responsible authority, systems, passenger/baggage/cargo, fuel and configuration inputs, weight and CG constraints, loadsheet outputs and recipients, last-minute-change process, implications for aircraft performance and the FMS, map to architecture). `schultz2017turnaround` and `eurocontrolACDMSpec` remain cited for airport links on the context diagram.

</details>

<details>
<summary>§4 Literature Review — OCC, Dispatch and Flight Execution (the parts not kept in Track D)</summary>

Airline operations control / disruption management (Clarke and later): OCC actors, responsibilities, authority, aircraft/crew/passenger/flight decisions, objectives, costs, information required, optimization timescale, interaction with dispatch and with ATC/ATM, local versus network-level conflicts. Flight dispatcher research: responsibilities, pilot/dispatcher shared responsibilities, planning, weather, aircraft-performance inputs, route constraints, fuel decisions, outputs, flight-monitoring responsibilities, interactions with ATC and the AOC, map to RACCI. Nominal ATC flight execution, the transitions not on the thread: clearance delivery, pushback/ramp coordination, ground control, taxi clearance, local/tower control, takeoff clearance, departure control, arrival control, approach clearance, landing clearance, ground control, ramp/gate transition (JO 7110.65BB paragraph pointers are in `knowledge/models/interaction-catalog-flight-execution.md` §3). Traffic-flow source leads from 2026-09-27 (`inbox/2026-09-27-tfm-research-leads.md`): CTOP concept and user material; FAA SMART; US gate-assignment authority for the AOC ↔ Airport link.

</details>

<details>
<summary>§5 Construct the Nominal-Flight ConOps (gate-to-gate checklist)</summary>

Strategic / commercial planning: customer demand, market identification, network design, frequency planning, timetable and connection design. Resource planning: fleet assignment, aircraft routing, maintenance planning, crew pairing, crew rostering. Day-of-operations: tail assignment, crew confirmation, weather/NOTAM assessment, dispatch flight planning, route selection, fuel planning, ATC flight-plan submission, flight release. Turnaround: gate assignment, deplaning, baggage/cargo unloading, maintenance, cleaning, catering, fueling, loading, boarding, weight and balance, final loadsheet, aircraft ready. Flight execution: pushback, engine start, taxi-out, takeoff, departure, climb, cruise, descent, arrival, approach, landing, taxi-in, gate arrival, shutdown. Postflight / continuation: passenger transfer, crew continuation, aircraft continuation, maintenance-state update, next turnaround. What is kept: the activity diagram at phase level with `FlyEnroute` decomposed one level, and the experiment scenario as the one worked scenario. Drafts not reviewed: `knowledge/models/conops-nominal-domestic_flight.md`, `conops-hub-to-hub-trajectory-cost.md`, `conops-scenarios.md`.

</details>

<details>
<summary>§6 Explore Alternative System Decompositions</summary>

Develop organization/authority-based, lifecycle/process-based, physical-system, information-flow, decision-authority and intent-to-trajectory decompositions; compare them (what question each answers well, what stakeholder concerns it exposes, what interactions it obscures, where boundaries are unambiguous or gray, where authority crosses a physical boundary, where information crosses an organizational boundary, where lifecycle ownership changes, which best supports optimization impact analysis); document the rationale for retaining multiple viewpoints rather than one decomposition. What is kept: one paragraph in Section 3 on why D-002/D-007 was kept, naming the alternatives.

</details>

<details>
<summary>§7 Stakeholder and Responsibility Analysis (beyond the six thread decisions)</summary>

For each stakeholder: needs, goals, responsibilities, authorities, resources, constraints, information needs, measures of value (answered in part by the 27 stakeholder requirements). RACCI matrix around all operational decisions; responsibility transitions; authority transitions; ambiguous or shared authority; where decision authority differs from computational responsibility; where execution responsibility differs from decision authority. What is kept: one RACCI table for the six decisions on the thread (file the plan, set the cost index, detect the conflict, choose the resolution, issue the clearance, execute it).

</details>

<details>
<summary>§9 Analyze Myopic Optimization (the eight conflicts not worked)</summary>

Define "local optimum" in the SoS context and candidate SoS measures of value. Candidate conflicts: airline fuel burn vs passenger delay; minimum flight time vs fuel/emissions; airline schedule integrity vs ATC workload; airport throughput vs aircraft taxi fuel; military mission effectiveness vs civil-airspace capacity; individual optimal trajectory vs network congestion; CO2 optimization vs non-CO2 climate impacts; airline slot/priority ranking vs ATCSCC system efficiency (GDP slot substitution, JO 7210.3EE ¶18-10-12, and diversion recovery priorities, ¶18-4-5, explored as a disruption scenario). For each: decision maker, decision variable, local objective, local constraints, affected stakeholders, externalized costs, SoS consequence, information needed to recognize the consequence. What is kept: the one conflict the experiment measures, individual-aircraft fuel efficiency vs sector capacity and workload.

</details>

<details>
<summary>§11 and §12 items dropped by D-013 and D-016</summary>

The multi-objective formulation J = w₁J₁ + w₂J₂ + ... + wₙJₙ; normalization for objectives with different units; stakeholder weighting schemes; single-stakeholder and balanced/SoS optimizations as separate runs; objective-weight sweeps; Pareto fronts across the experiment matrix; sensitivity analysis; tipping points where the preferred solution changes. The optional Pareto-front yes/no column (no weights needed) is an "if time" item.

</details>

<details>
<summary>§13 and §14 items not carried</summary>

Trace decision variables to system properties/actions, optimization objectives to stakeholder goals and constraints to requirements as separate trace lines (folded into the one thread). The twelve-step live demonstration (select a result, show the initial state, the initiating stakeholder, the required information through the architecture, the local result, the consequences to others, change weights, re-optimize, show changed behaviour, compare MOEs, show the tradeoff, trace to the trajectory) becomes the presentation and Section 4; re-weighting and re-optimizing are dropped.

</details>

<details>
<summary>§15 items beyond the reduced checklist</summary>

Verify the architecture against the full nominal-flight ConOps and additional off-nominal scenarios; verify stakeholder coverage and interface coverage across the whole model; verify objective-function traceability for every objective row; document limitations of the selected decomposition and opportunities for expansion in full.

</details>
