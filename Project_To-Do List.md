# NAS System-of-Systems Capstone — Project To-Do List

## 1. Establish Research Framework

- [ ] Finalize project research questions
  - [ ] How should the NAS be decomposed into constituent systems and Systems-of-Systems?
  - [ ] Where do authority, responsibility, ownership, and lifecycle boundaries occur?
  - [ ] How does operational intent propagate from enterprise objectives to physical aircraft behavior?
  - [ ] How do stakeholder definitions of "optimal" differ?
  - [ ] When does subsystem optimization produce undesirable System-of-Systems outcomes?
  - [ ] How can an MBSE architecture support analysis of those tradeoffs?

- [ ] Define initial System of Interest (SOI)
  - [ ] Define what is explicitly included.
  - [ ] Define what is explicitly excluded.
  - [ ] Define level(s) of abstraction.
  - [ ] Establish criteria for creating a system boundary.
  - [ ] Establish criteria for creating a stakeholder/actor boundary.
  - [ ] Document assumptions and unresolved boundary questions.

- [ ] Create research evidence/source register
  - [ ] Source
  - [ ] Publication type
  - [ ] NAS lifecycle phase addressed
  - [ ] Systems addressed
  - [ ] Stakeholders addressed
  - [ ] Architectural evidence extracted
  - [ ] Optimization/objective evidence extracted
  - [ ] Relevant SysML artifact(s)
  - [ ] Confidence / limitations


# 2. Literature Review — Airline Planning and Operations

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

- [ ] Complete PESTLE stakeholder discovery.
- [ ] Create stakeholder register.
- [ ] Identify each stakeholder's:
  - [ ] Needs.
  - [ ] Goals.
  - [ ] Responsibilities.
  - [ ] Authorities.
  - [ ] Resources.
  - [ ] Constraints.
  - [ ] Information needs.
  - [ ] Measures of value.

- [ ] Develop RACCI matrix around operational decisions.
- [ ] Identify responsibility transitions.
- [ ] Identify authority transitions.
- [ ] Identify ambiguous/shared authority.
- [ ] Identify where decision authority differs from computational responsibility.
- [ ] Identify where execution responsibility differs from decision authority.


# 8. Develop Objective / Cost / Value Ontology

- [ ] Define what "optimal" means for each major stakeholder.

### Airline
- [ ] Fuel cost.
- [ ] Crew cost.
- [ ] Aircraft utilization.
- [ ] Maintenance.
- [ ] Schedule integrity.
- [ ] Passenger connections.
- [ ] Delay cost.
- [ ] Revenue.
- [ ] Dispatch reliability.

### Passenger
- [ ] Ticket price.
- [ ] Travel time.
- [ ] Connection reliability.
- [ ] Schedule convenience.
- [ ] Comfort.
- [ ] Disruption risk.

### ATC / ANSP
- [ ] Safety/separation.
- [ ] Sector workload.
- [ ] Capacity.
- [ ] Predictability.
- [ ] Delay.
- [ ] Traffic complexity.

### Airport
- [ ] Gate utilization.
- [ ] Runway utilization.
- [ ] Surface congestion.
- [ ] Turnaround performance.
- [ ] Passenger throughput.

### Flight Crew
- [ ] Safety.
- [ ] Workload.
- [ ] Procedural compliance.
- [ ] Schedule/duty constraints.
- [ ] Operational flexibility.

### Environmental / Societal
- [ ] CO2.
- [ ] NOx.
- [ ] Contrail/climate effects.
- [ ] Noise.
- [ ] Local air quality.
- [ ] Community impacts.

### Military
- [ ] Mission effectiveness.
- [ ] Mission timing.
- [ ] Fuel availability.
- [ ] Airspace access.
- [ ] Operational security.
- [ ] Resilience.

- [ ] Classify objectives as:
  - [ ] Hard constraint.
  - [ ] Optimization objective.
  - [ ] Cost/penalty.
  - [ ] Measure of effectiveness.
  - [ ] Measure of performance.

- [ ] Identify conflicting objectives.
- [ ] Identify aligned objectives.
- [ ] Identify objectives whose costs are externalized onto another stakeholder.
- [ ] Identify objectives operating on different timescales.


# 9. Analyze Myopic Optimization

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

- [ ] Create NAS context diagram.
- [ ] Create package/model organization.
- [ ] Create stakeholder model.
- [ ] Create system BDDs.
- [ ] Create operational IBDs.
- [ ] Create information-object model.
- [ ] Create interface/item-flow model.
- [ ] Create nominal-flight activity diagram.
- [ ] Create responsibility swimlanes.
- [ ] Create critical sequence diagrams.
- [ ] Create requirements model.
- [ ] Trace stakeholder needs → objectives.
- [ ] Trace objectives → requirements.
- [ ] Trace requirements → systems.
- [ ] Trace systems → activities.
- [ ] Trace activities → information exchanges.
- [ ] Trace decisions → resulting aircraft behavior.


# 11. Define Optimization Study

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

- [ ] Develop minimum viable simulation.
- [ ] Validate constituent models independently.
- [ ] Establish baseline scenario.
- [ ] Execute single-stakeholder optimizations.
- [ ] Execute balanced/SoS optimization.
- [ ] Sweep objective weights.
- [ ] Generate Pareto fronts where appropriate.
- [ ] Perform sensitivity analysis.
- [ ] Identify tipping points where preferred solutions change.
- [ ] Quantify externalities imposed on other stakeholders.
- [ ] Compare local-optimum and SoS-optimum solutions.


# 13. Connect Simulation Back to MBSE

- [ ] Trace simulation entities to SysML blocks.
- [ ] Trace decision variables to system properties/actions.
- [ ] Trace optimization objectives to stakeholder goals.
- [ ] Trace constraints to requirements.
- [ ] Trace simulation inputs to information objects/interfaces.
- [ ] Trace optimized decisions through intent-to-trajectory chain.
- [ ] Show resulting effects on affected stakeholders.
- [ ] Demonstrate how architecture exposes impacts that a standalone optimizer would omit.


# 14. Capstone Demonstration

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

- [ ] Introduction and motivation.
- [ ] Literature review.
- [ ] Research gap.
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
- [ ] Limitations.
- [ ] Conclusions and future work.