# NAS System-of-Systems Capstone — Project To-Do List

**Target ECD (Expected Completion Date) tags** below are sourced from the Project
Milestones & ECD table in `prework/ISD 503 Submittal.pdf`. Where one proposal milestone
covers several checklist bullets, the date is attached to each; where a bullet is more
granular than the proposal's milestone, the milestone's date is used as a shared target
for the whole group. Three sections have **no corresponding milestone** in the submittal
and are marked "(unscheduled)" rather than given a fabricated date: §6 (Alternative
Decompositions), §9 (Myopic Optimization), §14 (Capstone Demonstration). Also note the
submittal schedules the Literature Review milestone (2026-11-17) *after* most of the
architecture milestones (2026-09-07 through 2026-11-03) — later than this list's own
§2-§4-before-§5-§10 ordering assumes; not reconciled here, flagged for the user to decide
whether literature work should in practice run continuously in the background rather than
front-loaded.

## 1. Establish Research Framework

- [ ] Finalize project research questions *(ECD 2026-09-07 — "PESTLE Analysis & System Definition")*
  - [ ] How should the NAS be decomposed into constituent systems and Systems-of-Systems?
  - [ ] Where do authority, responsibility, ownership, and lifecycle boundaries occur?
  - [ ] How does operational intent propagate from enterprise objectives to physical aircraft behavior?
  - [ ] How do stakeholder definitions of "optimal" differ?
  - [ ] When does subsystem optimization produce undesirable System-of-Systems outcomes?
  - [ ] How can an MBSE architecture support analysis of those tradeoffs?

- [ ] Define initial System of Interest (SOI)*
  - [ ] Define what is explicitly included.
  - [ ] Define what is explicitly excluded.
  - [ ] Define level(s) of abstraction.
  - [ ] Establish criteria for creating a system boundary.
  - [ ] Establish criteria for creating a stakeholder/actor boundary.
  - [ ] Document assumptions and unresolved boundary questions.

- [x] Create research evidence/source register *(feeds ECD 2026-11-17 "Literature Review" milestone — see §2 note)*
  - [x] Source
  - [x] Publication type
  - [ ] NAS lifecycle phase addressed
  - [x] Systems addressed
  - [x] Stakeholders addressed
  - [ ] Architectural evidence extracted
  - [ ] Optimization/objective evidence extracted
  - [ ] Relevant SysML artifact(s)
  - [ ] Confidence / limitations

- [ ] Establish project milestone timeline *(done 2026-08-29 — dates below sourced from `prework/ISD 503 Submittal.pdf`)*
  - [x] Revisit the timeline from the 503 Proposal submittal (`prework/ISD 503 Submittal.pdf`).
  - [x] Map major sections (§1-§16 of this list) to target completion dates.
  - [ ] Identify milestone checkpoints for interim review(s).

- [x] Submit Interim Report #1 (Introduction and Current State + References) *(ECD
  2026-09-20 — course syllabus deliverable, not in the 503 Submittal ECD table;
  unscheduled there like §6/§9/§14)*. **Submitted 2026-09-17**, ahead of the ECD — the
  2026-09-14 AI-drafted synthesis in `report/sections/02_introduction.tex` was rewritten
  into the user's own judgment/words before submission (ghostwriting concern from
  `task-board.md`/`sessions/2026-09-14-interim-report-1-scope-correction.md` resolved for
  this deliverable). The syllabus requirement is satisfied; the sub-items below are *not*
  all closed by that — several are ongoing capstone-quality work, not submission
  blockers, and stay open on their own merits:
  - [ ] Ratify the SOI boundary for real (resolves the "Define initial System of
    Interest" bullet above and `knowledge/questions/open-questions.md` §1) — **still
    provisional as of 2026-09-17**; the submitted report's Scope subsection reflects the
    user's rewrite but the boundary itself has not been ratified as a decision. In
    particular, resolve the self-contradiction on cargo carriers (Part 121 covers
    scheduled cargo too — decide affirmatively whether cargo ops are in scope and why)
    before ratifying.
  - [ ] Once the SOI is ratified, close "Finalize project research questions" above and
    log the boundary decision in `decisions/decisions-log.md`.
  - [x] Rewrite all six subsections (Overview, Current State/Literature Review,
    Stakeholders, Scope, Project Deliverables, Project Timing) in own judgment/words —
    done as part of the 2026-09-17 submission.
  - [ ] Fix the literature-review section's annotation-coverage claim — it currently
    overstates deep-annotated sources; check the real count against
    `evidence/source-register.md`'s own annotation-status tables before restating it.
  - [ ] Spot-check every citation sourced to a skimmed-only reference (per that
    source's own "Processing metadata" in `evidence/literature-notes/summaries/`)
    against the actual paper before repeating its claim as settled fact — flagged
    examples: `castro2013aoccMasThesis` (MASDIMA architecture detail),
    `great2020d21tboConcept`/`great2021d22operationalArch`, `hu2024disruptionOptReview`.
  - [ ] Replace or explicitly caveat the 1998-dollar disruption-cost figures
    (`clarke1998irregular`) used to motivate the problem statement.
  - [ ] Decide (don't default to the draft's phrasing) on the §11 optimization-study
    candidate scenario referenced in the Project Deliverables subsection.
  - [x] Resolve a LaTeX-to-Word conversion approach (no pandoc/LibreOffice found
    installed as of 2026-09-14) and produce the Word copy — resolved for this
    submission.
  - [x] Email the Word copy to faculty adviser Mark Petrotta (mpetrott@umich.edu) —
    done 2026-09-17.
  - [x] Complete Progress Status Update #1 (Canvas); upload the report there too
    unless it's deemed confidential — done 2026-09-17.


# 2. Literature Review — Airline Planning and Operations

*(§2-§4 collectively target ECD 2026-11-17 — "Literature Review" milestone, deliverable
"Annotated Bibliography," metric "10-20 papers categorized." See the top-of-file note on
this date's sequencing relative to §5-§10.)*

## Airline Schedule Planning: A Review and Future Directions — Eltoukhy, Chan & Chung

- [ ] Read and annotate paper
  - [ ] Identify actors/stakeholders.
  - [ ] Identify systems/organizations.
  - [ ] Identify objectives.
  - [ ] Identify costs / penalties.
  - [ ] Identify decisions.
  - [ ] Identify decision authority.
  - [ ] Identify activities/processes.
  - [ ] Identify resources.
  - [ ] Identify information inputs.
  - [ ] Identify information outputs.
  - [ ] Identify constraints.
  - [ ] Identify interfaces/handoffs.
  - [ ] Identify timescales of decisions.
  - [ ] Identify upstream dependencies.
  - [ ] Identify downstream consequences.
  - [ ] Identify optimization variables.
  - [ ] Identify objective functions / measures of effectiveness.
  - [ ] Identify evidence of conflicts between local and system-level objectives.
  - [ ] Map findings to candidate SysML elements.


## Airline Scheduling Optimization: Literature Review and Discussion of Modelling Methodologies — Deng & Santos

- [ ] Read and annotate paper
  - [ ] Identify actors/stakeholders.
  - [ ] Identify systems/organizations.
  - [ ] Identify objectives.
  - [ ] Identify costs / penalties.
  - [ ] Identify decisions.
  - [ ] Identify decision authority.
  - [ ] Identify activities/processes.
  - [ ] Identify resources.
  - [ ] Identify information inputs/outputs.
  - [ ] Identify constraints.
  - [ ] Identify interfaces.
  - [ ] Identify decision timescales.
  - [ ] Identify optimization variables.
  - [ ] Identify objective functions.
  - [ ] Compare sequential versus integrated optimization.
  - [ ] Identify examples of locally optimal decisions creating downstream impacts.
  - [ ] Identify coupling among schedule, fleet, aircraft routing, and crew decisions.
  - [ ] Map findings to SysML elements.


## Integrated Airline Scheduling

- [ ] Read and annotate paper
  - [ ] Identify actors/stakeholders.
  - [ ] Identify systems.
  - [ ] Identify objectives and costs.
  - [ ] Identify decisions.
  - [ ] Identify activities.
  - [ ] Identify resources.
  - [ ] Identify information exchanges.
  - [ ] Identify constraints.
  - [ ] Identify optimization variables/objectives.
  - [ ] Identify which planning functions are traditionally decomposed.
  - [ ] Document consequences of decomposition.
  - [ ] Document benefits/costs of integrated optimization.
  - [ ] Map findings to architecture.


## Airline Timetable Development and Fleet Assignment Incorporating Passenger Choice

- [ ] Read and annotate paper
  - [ ] Identify airline objectives.
  - [ ] Identify passenger objectives.
  - [ ] Identify passenger-choice model.
  - [ ] Identify decision variables.
  - [ ] Identify costs/revenues.
  - [ ] Identify constraints.
  - [ ] Identify information requirements.
  - [ ] Identify conflict between airline and passenger definitions of optimality.
  - [ ] Identify network-level consequences.
  - [ ] Map findings to architecture and objective model.


## Airline Crew Scheduling: Models, Algorithms, and Data Sets

- [ ] Read and annotate paper
  - [ ] Identify crew-related stakeholders.
  - [ ] Identify crew-planning systems.
  - [ ] Separate crew pairing from rostering/assignment.
  - [ ] Identify objectives.
  - [ ] Identify costs.
  - [ ] Identify regulatory/contractual constraints.
  - [ ] Identify qualifications and resource constraints.
  - [ ] Identify information inputs/outputs.
  - [ ] Identify interfaces with flight scheduling.
  - [ ] Identify interfaces with aircraft routing.
  - [ ] Identify impacts of upstream schedule decisions on crew optimization.
  - [ ] Identify effects of crew optimization on broader airline objectives.
  - [ ] Map findings to architecture.


## Aircraft Maintenance Routing Literature

- [ ] Read and annotate aircraft-maintenance-routing review
  - [ ] Identify maintenance stakeholders.
  - [ ] Identify aircraft-routing stakeholders.
  - [ ] Identify objectives.
  - [ ] Identify costs.
  - [ ] Identify aircraft/resource states.
  - [ ] Identify maintenance requirements.
  - [ ] Identify decisions.
  - [ ] Identify constraints.
  - [ ] Identify information exchanges.
  - [ ] Identify schedule dependencies.
  - [ ] Identify impacts of aircraft routing on future flights.
  - [ ] Map findings to architecture.


# 3. Literature Review — Day-of-Operations and Turnaround

## A Review of Aircraft Turnaround Operations and Simulations — Schultz

- [ ] Read and annotate paper
  - [ ] Identify actors/stakeholders.
  - [ ] Identify systems.
  - [ ] Identify physical resources.
  - [ ] Identify activities.
  - [ ] Identify activity precedence.
  - [ ] Identify parallel/concurrent activities.
  - [ ] Identify objectives.
  - [ ] Identify costs/penalties.
  - [ ] Identify constraints.
  - [ ] Identify information exchanges.
  - [ ] Identify milestones/events.
  - [ ] Identify decision authority.
  - [ ] Identify turnaround performance metrics.
  - [ ] Identify dependencies with inbound flight.
  - [ ] Identify dependencies with outbound flight.
  - [ ] Map findings to activity diagrams and IBDs.


## Managing Turnaround Performance through Collaborative Decision Making

- [ ] Read and annotate paper
  - [ ] Identify participating stakeholders.
  - [ ] Identify individual stakeholder objectives.
  - [ ] Identify shared objectives.
  - [ ] Identify conflicting objectives.
  - [ ] Identify information shared.
  - [ ] Identify information ownership.
  - [ ] Identify decision authority.
  - [ ] Identify collaboration mechanisms.
  - [ ] Identify KPIs/MOEs.
  - [ ] Identify consequences of information delay/error.
  - [ ] Map findings to RACCI and information model.


## EUROCONTROL Airport Collaborative Decision Making Specification

- [ ] Read and annotate specification
  - [ ] Identify actors.
  - [ ] Identify systems.
  - [ ] Identify operational milestones.
  - [ ] Identify information objects.
  - [ ] Identify producer of each information object.
  - [ ] Identify consumer(s) of each information object.
  - [ ] Identify decision authority.
  - [ ] Identify target/estimated/actual times.
  - [ ] Identify dependencies among milestones.
  - [ ] Identify network ATM interfaces.
  - [ ] Identify airport interfaces.
  - [ ] Identify airline interfaces.
  - [ ] Map milestones to SysML events/states/activities.
  - [ ] Map exchanges to IBD item flows.


## EUROCONTROL A-CDM Implementation Manual

- [ ] Read relevant portions
  - [ ] Compare implementation view with formal specification.
  - [ ] Identify operational responsibilities.
  - [ ] Identify system interfaces.
  - [ ] Identify implementation assumptions.
  - [ ] Identify measures of successful implementation.
  - [ ] Capture useful examples for ConOps.


## Weight & Balance / Load Control Research

- [ ] Review identified load-control/W&B literature
  - [ ] Identify actors.
  - [ ] Identify responsible authority.
  - [ ] Identify systems.
  - [ ] Identify passenger/baggage/cargo inputs.
  - [ ] Identify fuel inputs.
  - [ ] Identify aircraft configuration inputs.
  - [ ] Identify weight constraints.
  - [ ] Identify CG constraints.
  - [ ] Identify outputs/loadsheet.
  - [ ] Identify recipient(s).
  - [ ] Identify last-minute-change process.
  - [ ] Identify implications for aircraft performance/FMS.
  - [ ] Map to architecture.


# 4. Literature Review — OCC, Dispatch and Flight Execution

## Airline Operations Control / Disruption Management Literature

- [ ] Review Clarke and subsequent disruption-management literature
  - [ ] Identify OCC actors.
  - [ ] Identify responsibilities.
  - [ ] Identify authority.
  - [ ] Identify aircraft decisions.
  - [ ] Identify crew decisions.
  - [ ] Identify passenger decisions.
  - [ ] Identify flight decisions.
  - [ ] Identify objectives.
  - [ ] Identify costs.
  - [ ] Identify information required.
  - [ ] Identify optimization timescale.
  - [ ] Identify interaction with dispatch.
  - [ ] Identify interaction with ATC/ATM.
  - [ ] Identify local versus network-level optimization conflicts.


## Flight Dispatcher Research

- [ ] Review flight-dispatch literature
  - [ ] Identify dispatcher responsibilities.
  - [ ] Identify pilot/dispatcher shared responsibilities.
  - [ ] Identify planning inputs.
  - [ ] Identify weather inputs.
  - [ ] Identify aircraft-performance inputs.
  - [ ] Identify route constraints.
  - [ ] Identify fuel decisions.
  - [ ] Identify outputs.
  - [ ] Identify flight-monitoring responsibilities.
  - [ ] Identify interactions with ATC.
  - [ ] Identify interactions with AOC/OCC.
  - [ ] Map to RACCI.


## Nominal ATC Flight Execution

- [ ] Research FAA sources for nominal IFR operation
  - [ ] Clearance delivery.
  - [ ] Pushback/ramp coordination.
  - [ ] Ground control.
  - [ ] Taxi clearance.
  - [ ] Local/tower control.
  - [ ] Takeoff clearance.
  - [ ] Departure control.
  - [ ] Enroute ARTCC control.
  - [ ] Sector-to-sector handoffs.
  - [ ] Arrival control.
  - [ ] Approach clearance.
  - [ ] Tower/local control.
  - [ ] Landing clearance.
  - [ ] Ground control.
  - [ ] Ramp/gate transition.

- [ ] For each control transition identify:
  - [ ] Responsible actor.
  - [ ] Controlling organization/system.
  - [ ] Decision authority.
  - [ ] Required information.
  - [ ] Information exchanged.
  - [ ] Communications mechanism.
  - [ ] Trigger for responsibility transfer.
  - [ ] Resulting aircraft action.


# 5. Construct the Nominal-Flight ConOps

*(ECD 2026-11-08 — "Operational Scenarios" milestone, deliverable "ConOps document,"
metric "1-3 representative scenarios.")*

- [ ] Develop nominal commercial-flight ConOps

### Strategic / Commercial Planning
- [ ] Customer/passenger demand.
- [ ] Market identification.
- [ ] Network design.
- [ ] Frequency planning.
- [ ] Timetable/connection design.

### Resource Planning
- [ ] Fleet assignment.
- [ ] Aircraft routing.
- [ ] Maintenance planning.
- [ ] Crew pairing.
- [ ] Crew rostering/assignment.

### Day-of-Operations
- [ ] Tail assignment/confirmation.
- [ ] Crew confirmation.
- [ ] Weather/NOTAM assessment.
- [ ] Dispatch flight planning.
- [ ] Route selection.
- [ ] Fuel planning.
- [ ] ATC flight-plan submission.
- [ ] Flight release.

### Turnaround
- [ ] Gate assignment.
- [ ] Deplaning.
- [ ] Baggage/cargo unloading.
- [ ] Maintenance.
- [ ] Cleaning.
- [ ] Catering.
- [ ] Fueling.
- [ ] Baggage/cargo loading.
- [ ] Boarding.
- [ ] Weight and balance.
- [ ] Final loadsheet.
- [ ] Aircraft ready.

### Flight Execution
- [ ] Pushback.
- [ ] Engine start.
- [ ] Taxi-out.
- [ ] Takeoff.
- [ ] Departure.
- [ ] Climb.
- [ ] Cruise.
- [ ] Descent.
- [ ] Arrival.
- [ ] Approach.
- [ ] Landing.
- [ ] Taxi-in.
- [ ] Gate arrival.
- [ ] Shutdown.

### Postflight / Continuation
- [ ] Passenger transfer.
- [ ] Crew continuation.
- [ ] Aircraft continuation.
- [ ] Maintenance-state update.
- [ ] Next turnaround.


# 6. Explore Alternative System Decompositions

*(unscheduled — no corresponding milestone in `prework/ISD 503 Submittal.pdf`. Logically
sits between "Draft Architecture" (2026-11-03) and the SOI/system-definition work; pick a
working target in that window if a firmer date is needed.)*

- [ ] Develop organization/authority-based decomposition.
- [ ] Develop lifecycle/process-based decomposition.
- [ ] Develop physical-system decomposition.
- [ ] Develop information-flow decomposition.
- [ ] Develop decision-authority decomposition.
- [ ] Develop intent-to-trajectory decomposition.

- [ ] Compare decompositions
  - [ ] What question does each decomposition answer well?
  - [ ] What stakeholder concerns does it expose?
  - [ ] What interactions does it obscure?
  - [ ] Where are boundaries unambiguous?
  - [ ] Where are boundaries gray?
  - [ ] Where does authority cross a physical system boundary?
  - [ ] Where does information cross an organizational boundary?
  - [ ] Where does lifecycle ownership change?
  - [ ] Which decomposition best supports optimization impact analysis?

- [ ] Document rationale for retaining multiple architectural viewpoints rather than selecting a single "correct" decomposition.


# 7. Stakeholder and Responsibility Analysis

*(RACCI/authority-transition bullets below missed their 2026-09-10 ECD, still
unstarted as of 2026-09-14 — PM check-in recommends deferring them until after
Interim Report #1 ships 2026-09-20 rather than attempting both at once; see
`task-board.md`.)*

- [x] Complete PESTLE stakeholder discovery. *(ECD 2026-09-07 — "PESTLE Analysis & System Definition")*
- [x] Create stakeholder register. *(ECD 2026-09-07)*
- [ ] Identify each stakeholder's:
  - [ ] Needs.
  - [ ] Goals.
  - [ ] Responsibilities.
  - [ ] Authorities.
  - [ ] Resources.
  - [ ] Constraints.
  - [ ] Information needs.
  - [ ] Measures of value.

- [ ] Develop RACCI matrix around operational decisions. *(ECD 2026-09-10 — "Authority & Responsibility Models," metric "All decisions assigned")*
- [ ] Identify responsibility transitions. *(ECD 2026-09-10)*
- [ ] Identify authority transitions. *(ECD 2026-09-10)*
- [ ] Identify ambiguous/shared authority. *(ECD 2026-09-10)*
- [ ] Identify where decision authority differs from computational responsibility. *(ECD 2026-09-10)*
- [ ] Identify where execution responsibility differs from decision authority. *(ECD 2026-09-10)*


# 8. Develop Objective / Cost / Value Ontology

*(ECD 2026-10-17 — "Measures of Effectiveness" milestone, deliverable "MOE/MOP
hierarchy," metric "Quantifiable metrics defined." Applies to the whole section; the
"Classify objectives as..." bullet below is this milestone's most literal match.)*

- [x] Define what "optimal" means for each major stakeholder. *(see [[stakeholder-objective-ontology]])*

### Airline
- [x] Fuel cost.
- [x] Crew cost.
- [x] Aircraft utilization.
- [x] Maintenance.
- [x] Schedule integrity.
- [x] Passenger connections.
- [x] Delay cost.
- [x] Revenue.
- [x] Dispatch reliability.

### Passenger
- [x] Ticket price.
- [x] Travel time.
- [x] Connection reliability.
- [x] Schedule convenience.
- [x] Comfort.
- [x] Disruption risk.

### ATC / ANSP
- [x] Safety/separation.
- [x] Sector workload.
- [x] Capacity.
- [x] Predictability.
- [x] Delay.
- [x] Traffic complexity.

### Airport
- [x] Gate utilization.
- [x] Runway utilization.
- [x] Surface congestion.
- [x] Turnaround performance.
- [x] Passenger throughput.

### Flight Crew
- [x] Safety.
- [x] Workload.
- [x] Procedural compliance.
- [x] Schedule/duty constraints.
- [x] Operational flexibility.

### Environmental / Societal
- [x] CO2.
- [x] NOx.
- [x] Contrail/climate effects.
- [x] Noise.
- [x] Local air quality.
- [x] Community impacts.

### Military
- [x] Mission effectiveness.
- [x] Mission timing.
- [x] Fuel availability.
- [x] Airspace access.
- [x] Operational security.
- [x] Resilience.

- [x] Classify objectives as:
  - [x] Hard constraint.
  - [x] Optimization objective.
  - [x] Cost/penalty.
  - [x] Measure of effectiveness.
  - [x] Measure of performance.

- [x] Identify conflicting objectives.
- [x] Identify aligned objectives.
- [x] Identify objectives whose costs are externalized onto another stakeholder.
- [x] Identify objectives operating on different timescales.


# 9. Analyze Myopic Optimization

*(unscheduled — no corresponding milestone in `prework/ISD 503 Submittal.pdf`. Likely
needs to land between "Measures of Effectiveness" (2026-10-17) and "Optimization
Prototype" (2026-11-21) to feed the optimization work; pick a working target in that
window if a firmer date is needed.)*

- [ ] Define "local optimum" within the SoS context.
- [ ] Define candidate System-of-Systems measures of value.
- [ ] Identify examples where optimizing one subsystem may degrade another.

- [ ] Analyze candidate conflicts:
  - [ ] Airline fuel burn vs passenger delay.
  - [ ] Individual-aircraft fuel efficiency vs sector capacity.
  - [ ] Minimum flight time vs fuel/emissions.
  - [ ] Airline schedule integrity vs ATC workload.
  - [ ] Airport throughput vs aircraft taxi fuel.
  - [ ] Military mission effectiveness vs civil-airspace capacity.
  - [ ] Individual optimal trajectory vs network congestion.
  - [ ] CO2 optimization vs non-CO2 climate impacts.

- [ ] For each conflict document:
  - [ ] Decision maker.
  - [ ] Decision variable.
  - [ ] Local objective.
  - [ ] Local constraints.
  - [ ] Affected stakeholders.
  - [ ] Externalized costs.
  - [ ] SoS consequence.
  - [ ] Information needed to recognize the consequence.


# 10. Build the SysML Architecture

- [ ] Create NAS context diagram. *(ECD 2026-09-07 — "PESTLE Analysis & System Definition," deliverable "Context diagram")*
- [x] Create package/model organization. *(ECD 2026-11-03 — "Draft Architecture," deliverable "BDDs & package structure". First pass 2026-09-19: the model (file map: `cameo_models/sysmlv2_exploration.md`) now has a package per D-002 domain, plus a `Common` package for shared value types. SysML v2 text is the source of truth (D-006); not in Cameo.)*
- [ ] Create stakeholder model. *(ECD 2026-09-07, deliverable "stakeholder map")*
- [x] Create system BDDs. *(ECD 2026-11-03. First pass 2026-09-19: NAS + 9 domains + constituent systems populated in the model (file map: `cameo_models/sysmlv2_exploration.md`), filtered to the provisional SOI boundary — see the definitions file's header comment and `open-questions.md`. Source of truth is the SysML v2 text (D-006), not Cameo; no IBDs/interfaces/requirements traced yet.)*
- [ ] Create operational IBDs. *(ECD 2026-10-25 — "Internal Block Diagrams," metric "Critical interfaces connected")*
- [ ] Create information-object model. *(ECD 2026-10-29 — "Interface Definition," deliverable "ICD")*
- [ ] Create interface/item-flow model. *(ECD 2026-10-29)*
- [ ] Create nominal-flight activity diagram. *(ECD 2026-10-01 — "Activity Diagrams," metric "Scenario walkthrough")*
- [ ] Create responsibility swimlanes. *(ECD 2026-09-10 — "Authority & Responsibility Models")*
- [ ] Create critical sequence diagrams. *(ECD 2026-09-22 — "Sequence Diagrams," metric "Message completeness")*
- [ ] Create requirements model. *(ECD 2026-10-20 — "Requirements Definition," metric "Trace to stakeholders")*
- [ ] Trace stakeholder needs → objectives. *(ECD 2026-10-12 — "Requirement Traceability," metric "Complete allocation")*
- [ ] Trace objectives → requirements. *(ECD 2026-10-12)*
- [ ] Trace requirements → systems. *(ECD 2026-10-12)*
- [ ] Trace systems → activities. *(ECD 2026-10-12)*
- [ ] Trace activities → information exchanges. *(ECD 2026-10-12)*
- [ ] Trace decisions → resulting aircraft behavior. *(ECD 2026-11-24 — "Integration of MBSE Architecture," metric "End-to-end scenario")*


# 11. Define Optimization Study

*(ECD 2026-11-21 — "Optimization Prototype" milestone, deliverable "Working code," metric
"Unit test cases." The submittal bundles study definition and implementation into one
milestone; this section's definition work should be substantially done before that date
so there's a study left to implement — see §12.)*

- [ ] Select a tractable representative operational scenario.
- [ ] Define participating systems/stakeholders.
- [ ] Define system state.
- [ ] Define decision variables.
- [ ] Define constraints.
- [ ] Define stakeholder objective functions.

- [ ] Construct multi-objective formulation:

  J = w₁J₁ + w₂J₂ + ... + wₙJₙ

- [ ] Define normalization for objectives with different units/scales.
- [ ] Define stakeholder weighting schemes.
- [ ] Define baseline/reference case.
- [ ] Define feasibility criteria.
- [ ] Define experiment matrix.


# 12. Implement Simulation / Analysis Capability

*(ECD 2026-11-21 — "Optimization Prototype" milestone. See the §11-§12 scope note in
`knowledge/questions/open-questions.md` — the full experiment-matrix/Pareto/sensitivity
scope below is unlikely to all fit before this date; consider narrowing to one scenario
and one weight sweep for the prototype, per that note.)*

- [x] Develop minimum viable simulation. *(First pass 2026-09-19: point-mass kinematic
  vehicle dynamics model in `simulation/vehicle_dynamics.py` — speed/heading rate-limited
  toward commanded values, altitude from commanded climb rate, position via
  equirectangular projection, placeholder constant fuel burn. Not aerodynamic; extend
  rather than replace if higher fidelity is needed later.)*
- [x] Validate constituent models independently. *(First pass 2026-09-19:
  `simulation/test_vehicle_dynamics.py` smoke tests — holding commanded state holds
  track, climb command changes altitude correctly, speed change is rate-limited, fuel
  burns while engine on. All passing.)*
- [ ] Establish baseline scenario. *(`cameo_models/scenarios/hub-to-hub-example.sysml` is
  an illustrative pattern-demo, explicitly not the decided ConOps baseline — see that
  file's header comment and `open-questions.md`.)*
- [ ] Execute single-stakeholder optimizations.
- [ ] Execute balanced/SoS optimization.
- [ ] Sweep objective weights.
- [ ] Generate Pareto fronts where appropriate.
- [ ] Perform sensitivity analysis.
- [ ] Identify tipping points where preferred solutions change.
- [ ] Quantify externalities imposed on other stakeholders.
- [ ] Compare local-optimum and SoS-optimum solutions.


# 13. Connect Simulation Back to MBSE

*(ECD 2026-11-24 — "Integration of MBSE Architecture" milestone, deliverable
"Traceability links," metric "End-to-end scenario.")*

- [x] Trace simulation entities to SysML blocks. *(First pass 2026-09-19: `DecisionSupport`
  package's `VehicleDynamicsModel::StepDynamics` calc def in `cameo_models/nas_sysml_package_definitions.sysml`
  names the Python module/function that implements it; `simulation/vehicle_dynamics.py`
  uses the same field names as `AircraftSystems::AircraftState`. Doc-comment trace, not a
  language-level binding — see `workflows/vehicle-simulation-model.md` for why.)*
- [ ] Trace decision variables to system properties/actions.
- [ ] Trace optimization objectives to stakeholder goals.
- [ ] Trace constraints to requirements.
- [x] Trace simulation inputs to information objects/interfaces. *(First pass 2026-09-19:
  `cameo_models/scenarios/hub-to-hub-example.sysml`'s `exampleAircraft.flightState` is a
  concrete `AircraftState` usage shaped to seed `vehicle_dynamics.step_dynamics` directly.)*
- [ ] Trace optimized decisions through intent-to-trajectory chain.
- [ ] Show resulting effects on affected stakeholders.
- [ ] Demonstrate how architecture exposes impacts that a standalone optimizer would omit.


# 14. Capstone Demonstration

*(unscheduled — no corresponding milestone in `prework/ISD 503 Submittal.pdf`. Falls
naturally between "Integration of MBSE Architecture" (2026-11-24) and "Final Paper"
(2026-12-18); pick a working target in that window if a firmer date is needed.)*

- [ ] Select representative optimization result.
- [ ] Show initial operational state.
- [ ] Identify initiating stakeholder/objective.
- [ ] Trace required information through architecture.
- [ ] Show local optimization result.
- [ ] Show consequences to other stakeholders.
- [ ] Change stakeholder objective weights.
- [ ] Re-optimize.
- [ ] Show changed system behavior.
- [ ] Compare stakeholder costs/MOEs.
- [ ] Demonstrate tradeoff/Pareto relationship.
- [ ] Trace final decision to aircraft trajectory/behavior.


# 15. Verification and Final Analysis

*(ECD 2026-12-26 — "Final Baseline & Draft Paper" milestone, deliverable "Versioned model
& draft paper," metric "Draft." This is the last milestone in the table, dated after
"Paper Submittal" (2026-12-20) — worth confirming with your advisor whether that ordering
is intentional, e.g. a post-submission archival/versioning step.)*

- [ ] Verify architecture against nominal-flight ConOps.
- [ ] Verify architecture against additional off-nominal scenarios.
- [ ] Verify stakeholder coverage.
- [ ] Verify interface coverage.
- [ ] Verify requirements traceability.
- [ ] Verify objective-function traceability.
- [ ] Identify known model omissions.
- [ ] Identify limitations of selected decomposition.
- [ ] Identify limitations of optimization demonstration.
- [ ] Document opportunities for future expansion.


# 16. Paper / Final Deliverables

Ordered to match the report structure in `report/main.tex` (built from
`prework/503_ReportTemplate_v26.docx`). Items marked "(new)" were added
during the 2026-08-29 report-outline session to close gaps where the 503
template expects content this list didn't previously have an explicit home
for — see `report/README.md` for the full section-to-plan mapping.

*(ECD 2026-12-18 — "Final Paper" milestone, deliverable "Thesis/Paper," metric
"Revisions" — target for a complete draft of everything below. ECD 2026-12-20 —
"Paper Submittal" milestone, metric "Official" — hard deadline for final submission.)*

- [ ] Executive summary. (new)
- [ ] Introduction and motivation.
- [ ] Project scope (in/out of scope, boundaries). (new)
- [ ] Stakeholder overview (summary of PESTLE/stakeholder register for report body). (new)
- [ ] Project deliverables and success metrics. (new)
- [ ] Project timeline / milestone schedule. (new — see §1 "Establish project milestone timeline")
- [ ] Literature review.
- [ ] Research gap.
- [ ] Assumptions and methodology. (new)
- [ ] System-of-Systems definition.
- [ ] ConOps.
- [ ] Alternative decomposition discussion.
- [ ] MBSE methodology.
- [ ] Stakeholder / PESTLE analysis.
- [ ] RACCI analysis.
- [ ] Architecture.
- [ ] Stakeholder objective/cost analysis.
- [ ] Myopic optimization discussion.
- [ ] Simulation methodology.
- [ ] Optimization experiment.
- [ ] Results.
- [ ] Multi-stakeholder tradeoff analysis.
- [ ] Architecture evaluation.
- [ ] Recommendations. (new)
- [ ] Impact / quantified benefits (operational, financial-where-applicable). (new — see scope flag in `report/sections/06_impact_financial_benefits.tex`)
- [ ] Limitations.
- [ ] Conclusions and future work.
- [ ] Appendices (detailed stakeholder register, RACCI matrix, source register, full diagram set). (new)