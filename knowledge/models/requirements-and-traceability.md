# Requirements and Traceability

**Status: draft.** 13 stakeholder requirements and 23 system requirements, reviewed by the owner by hand twice (D-020, D-021), and 28 constituent system requirements written by Claude and not yet reviewed (D-022). Every requirement has status `draft` in the model. Nothing is baselined. Not report text.

## Who wrote what

| Part of this file | Whose it is |
|---|---|
| Sections 3 and 4: stakeholder and system requirements | **The owner's, after two hand reviews.** Claude wrote the first draft; the owner marked up two prints of it and the marks are applied. The Wording column says, for each sentence, whether the owner wrote it, edited it, or read it twice and kept it. One system requirement (SLR-CLR-15) is the exception. |
| Section 2: the test each requirement had to pass | The owner's criterion, in Claude's words. The owner read it on the second print and did not mark it. |
| Notes under the tables in sections 3 and 4 | Claude's words, saying why each requirement is in the study. A point marked "(owner)" is the owner's, taken from the handwriting. |
| Section 7 | Four things Claude added after the second print. **The owner has not reviewed them.** |
| Section 11: constituent system requirements (HLRs) | **Claude's draft. Not reviewed by the owner.** HLR-CRW-01 is the owner's sentence. |
| Trace, allocation, check, measure and basis columns; sections 8 to 10 | Claude's. Printed with the requirements and read by the owner, except where section 7 says otherwise. |

The Wording column in sections 3 and 4 uses four values:

- **Owner**: the owner wrote the sentence.
- **Owner edit**: Claude's sentence, changed by the owner by hand.
- **Claude, kept**: Claude's sentence, read by the owner on both prints and left as it was.
- **Claude, unreviewed**: written by Claude after the second print.

The two marked-up prints are `projects/nas-sos-capstone/handwritten/2026-10-10_requirements-and-traceability.pdf` and `projects/nas-sos-capstone/handwritten/2026-10-11_requirements-and-traceability_v2.pdf`.

## #TODO (owner)

- [ ] **Review section 11**, the constituent system requirements. Start with "Things to check in this draft" at its end. The owner's note that the objective rows in section 8 are "derived reqts @ the HLR level" was not acted on: no requirement in section 11 was written from those rows.
- [ ] **Review the four items in section 7.** Re-word or strike SLR-CLR-15 first.
- [ ] **For each system requirement on the thread, name the verification case** (`projects/nas-sos-capstone/cameo_models/nas_verification.sysml`) and give a measure and unit, or write "qualitative". On the thread: SLR-CLR-01, SLR-CLR-02, SLR-CLR-10, SLR-CLR-13, SLR-CLR-15, SLR-INF-01, SLR-INF-02, SLR-EXE-03, SLR-MEA-02.
- [ ] **Confirm the three numbers and tags marked "Unconfirmed"** in section 4: the 45-minute reserve (SLR-PLN-04), the separation minimum (SLR-CLR-01), and whether a controller is alerted to low predicted fuel today (SLR-EXE-06).

**The model is the source of truth (D-006).** This file is a readable copy of four model files in `projects/nas-sos-capstone/cameo_models/`:

- `requirements_stakeholders.sysml` holds the 13 stakeholder requirements.
- `requirements_nas_system.sysml` holds the 23 system requirements and their allocation to systems.
- `requirements_constituent_systems.sysml` holds the 28 constituent system requirements of section 11.
- `requirements_definitions.sysml` holds the attributes all three use.

If this file and those disagree, the `.sysml` files win. Mark changes here by hand, then apply them to the `.sysml` files.

## 1. What is here

- **13 stakeholder requirements** in 5 stakeholder groups. Each says what that group wants from the NAS and names the objective rows it comes from in `knowledge/models/stakeholder-objective-ontology.md`.
- **23 system requirements** in 6 areas that follow the lifecycle of trajectory intent. Each is allocated to parts of `NationalAirspaceSystem` in `projects/nas-sos-capstone/cameo_models/nas_sysml_package_definitions.sysml`.
- **28 constituent system requirements** (section 11), one tier down, on the five systems D-007 models.
- **Every stakeholder requirement is answered by at least one system requirement, and every system requirement traces to a stakeholder requirement.** None is derived.
- **One of the 23 is a goal, not a requirement** (SLR-CLR-13). It is written with "should". Section 5.
- **Three describe what today's NAS does not do** (SLR-CLR-10, SLR-CLR-13, SLR-INF-02) and are tagged `improved` (D-018). They are what the experiment in `knowledge/models/experiment-definition.md` is about.

The trace runs: objective row, then stakeholder requirement, then system requirement, then constituent system requirement, then the part of the model that carries it out.

**The thread the project rests on:** airline objective rows (fuel cost, schedule integrity, passenger connections) → SN-AIR-05 → SLR-INF-02 (the information) and SLR-CLR-13 (the goal it serves) → HLR-OPS-05 (the airline provides it) and HLR-ATC-08, HLR-ATC-04, HLR-ATC-05 (air traffic control uses it) → the `AirlinePerformanceShare` interface (D-019) → one verification case per means → the experiment's outcome table.

## 2. The test each requirement had to pass

D-007 (`decisions/decisions-log.md`) says an entity is modeled when it has "distinct decision authority or execution behavior dynamically coupled to in-scope decisions" and materially affects cost, safety, workload, schedule reliability or passenger value. The hand reviews apply that test to each requirement, with "in-scope decisions" read as the decision the project studies:

> **How is a conflict between two aircraft in en-route cruise resolved, and what is the party that decides told about each aircraft?**

A requirement stays if it does one of three things:

1. It states what that decision must achieve or must not break (separation, a clearance the aircraft can fly, the airline's priorities).
2. It states what the party deciding knows, today or under the proposed change.
3. It fixes something the experiment takes as given and uses in its numbers (the flight plan, the fuel load, the CO2 factor).

Requirements that are true of the NAS but do none of these were struck (section 6).

**The study is about tactical interventions.** In the owner's words on the second print: "While relevant to the NAS, the TMIs aren't relevant to tactical interventions. The same look @ MBSE applies to TMIs, but they're not my focus." No traffic flow management requirement remains.

## 3. Stakeholder requirements (on the NAS)

The Wording column is explained under "Who wrote what". The note under each table says why each requirement is in the study. It is shortened from the `rationale` attribute in the model, which also records what each hand review changed.

### Airline (Part 121 scheduled passenger operator)

D-007 treatment: Modeled system (Flight Operations).

| ID | The stakeholder wants | Wording | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|---|
| SN-AIR-01 | The NAS shall provide a means for the airline to plan and fly each flight on the route, altitude and speed it chooses, so that the flight is flown within safety and capacity limits. | Owner edit | Airline: Fuel cost; Airline: Delay cost | SLR-PLN-01, SLR-PLN-02, SLR-CLR-09, SLR-EXE-03, SLR-MEA-02 | [B] `mori2022massCruise`, `munro2018managingVariability` |
| SN-AIR-02 | The NAS shall provide a means for each flight to achieve arrival at its destination gate at its scheduled arrival time. | Owner | Airline: Schedule integrity; Airline: Aircraft utilization; Airline: Passenger connections | SLR-INF-07, SLR-APT-04 | [C] |
| SN-AIR-03 | The NAS shall inform the airline of airspace and airport constraints that will delay or reroute its flights early enough for the airline to re-plan. | Claude, kept | Airline: Delay cost; Airline: Schedule integrity | SLR-CLR-04, SLR-INF-07 | [A] `faa2025jo72103ee` |
| SN-AIR-05 | The NAS shall take the airline's priorities for a flight (fuel against time, and protected connections) into account when a change to that flight's trajectory is required. | Owner | Airline: Fuel cost; Airline: Schedule integrity; Airline: Passenger connections | SLR-CLR-13, SLR-INF-02 | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction` |

- **SN-AIR-01**: The planned cruise altitude and speed are what a conflict resolution takes the aircraft away from, so this is what the experiment scores a resolution against. The owner struck "at its lowest operating cost": what the airline optimizes for is the airline's own business.
- **SN-AIR-02**: The time side of the fuel-against-time trade, and the reason one flight's connections can outweigh its fuel (case D of the experiment).
- **SN-AIR-03**: Flights are separated as filed; as uncertainty is realized, aircraft deviate and interventions are needed. The intervention is the constraint the airline needs to hear about, and the crew and the dispatchers are the ones who coordinate to make that happen (both points are the owner's). Traffic management initiatives are outside the study (D-021).
- **SN-AIR-05**: The requirement the experiment is about (`knowledge/models/experiment-definition.md` section 2). Not met today: the controller does not receive weight or cost index.

### Air traffic control and traffic flow management (FAA Air Traffic Organization)

D-007 treatment: Modeled system (Airspace Management).

| ID | The stakeholder wants | Wording | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|---|
| SN-ATC-01 | The NAS shall keep every controlled aircraft separated from every other aircraft by at least the applicable separation minimum. | Claude, kept | ATC / ANSP: Safety/separation | SLR-PLN-06, SLR-CLR-01, SLR-CLR-02, SLR-INF-01, SLR-EXE-02 | [A] `faa2025jo711065bb` |
| SN-ATC-02 | The NAS shall keep the number of aircraft in each sector and at each airport within its declared capacity. | Claude, kept | ATC / ANSP: Capacity | SLR-PLN-06 | [A] `faa2025jo72103ee` |
| SN-ATC-04 | The NAS shall keep the number of control actions a sector controller must take within what one sector team can sustain. | Claude, kept | ATC / ANSP: Sector workload; ATC / ANSP: Traffic complexity | SLR-CLR-15 | [B] `rantanen2012conflictManeuvers`, `kirwan2001coraStrategies` |

- **SN-ATC-01**: The hard constraint every resolution option must meet. It is never traded against cost (`knowledge/models/experiment-definition.md` section 6).
- **SN-ATC-02**: Context: it is the capacity limit named in SN-AIR-01.
- **SN-ATC-04**: Instruction count is one of the experiment's two scored columns. Workload is a ceiling, not something to minimize: a controller who is not overworked can give as many instructions as wanted (owner). Struck in the first review and restored by the owner in the second.

### Flight crew (captain and first officer)

D-007 treatment: Modeled system (Flight Crew).

| ID | The stakeholder wants | Wording | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|---|
| SN-CRW-03 | The NAS shall give the flight crew only trajectory instructions that the aircraft can fly, with enough time to set them up. | Claude, kept | Flight Crew: Workload; Flight Crew: Safety | SLR-CLR-10, SLR-INF-02, SLR-EXE-03, SLR-EXE-06 | [SME] |
| SN-CRW-06 | The NAS shall provide the flight crew clearances that account for air traffic. | Owner | Flight Crew: Safety | SLR-CLR-01, SLR-CLR-02 | [SME] |
| SN-CRW-07 | The NAS shall inform the flight crew of weather, traffic and other safety considerations. | Owner | Flight Crew: Safety; Flight Crew: Procedural compliance | SLR-PLN-07 | [SME] |
| SN-CRW-08 | The NAS shall facilitate control of the aircraft across regional sectors, coordinating controls, clearances and handoffs. | Owner | Flight Crew: Workload; Flight Crew: Procedural compliance | SLR-CLR-04 | [SME] |

- **SN-CRW-03**: A climb the aircraft is too heavy to make is the clearance the baseline can issue and the improved architecture avoids.
- **SN-CRW-06**: The clearance that resolves the conflict is the thing the crew receives.
- **SN-CRW-07**: What the crew knows when it accepts, refuses or asks to change a clearance. "Other safety considerations" is the owner's catch-all.
- **SN-CRW-08**: The conflict is resolved by one sector controller, whose authority ends at the sector boundary.

### Regulator (FAA as rule maker; Department of Transportation)

D-007 treatment: Boundary actor.

| ID | The stakeholder wants | Wording | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|---|
| SN-GOV-01 | The NAS shall conduct every flight within the operating rules of 14 CFR and the FAA's air traffic orders. | Claude, kept | none (see note) | SLR-PLN-04, SLR-PLN-05, SLR-CLR-08, SLR-EXE-06, SLR-MEA-01 | [A] `faa2025jo711065bb`, `faa2025jo72103ee`, 14 CFR 91, 14 CFR 121 |

- **SN-GOV-01**: The rules are held fixed (D-007), so both the baseline and the improved architecture must stay inside them. Governance has no table in `knowledge/models/stakeholder-objective-ontology.md`; the objective is "Regulatory Compliance" in the enterprise objective hierarchy in `knowledge/models/stakeholder-register.md`. The owner judged adding a Governance table not important.

### Communities and environmental organizations

D-007 treatment: Boundary actor (acts through Governance per D-007).

| ID | The stakeholder wants | Wording | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|---|
| SN-ENV-01 | The NAS shall keep the CO2 emitted by each flight as low as safety, economics and capacity allow. | Owner edit | Environmental / Societal: CO2 | SLR-CLR-13, SLR-MEA-02 | [C] `icao2024icecMethodology` |

- **SN-ENV-01**: CO2 is fuel burned times 3.16 (D-015), so the experiment's fuel column is also this stakeholder's column. "Economics" is the owner's addition.

**Groups with no requirement:** Airport operator, Passengers, Military airspace users. Section 8 lists the objective rows left without a requirement.

## 4. System requirements

Columns: **Wording** is explained under "Who wrote what". **Traces to** is the stakeholder requirement it answers. **Allocated to** names the constituent systems, the accountable one first. **Check** is how it would be verified: inspection of the model, analysis (calculation or simulation), or demonstration (a scenario walked through on the activity diagram). **Measure** is filled only where there is something to measure; a number appears only where a source gives it. **State** is `improved` where today's NAS does not do it (D-018), otherwise `baseline`. A statement written with "should" is a goal (section 5). The note under each table says why each one is in the study; it is shortened from the `rationale` attribute in the model.

### Flight planning and release

Place on the trajectory-intent chain: mission plan -> flight plan.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-PLN-01 | The NAS shall produce for each scheduled flight a flight plan that states its route, cruise altitude, cruise speed and fuel load. | Claude, kept | Functional | baseline | SN-AIR-01 | Dispatcher | Inspection |  | [B] `berry2011aocActors` |
| SLR-PLN-02 | The NAS shall compute each flight plan from the performance of the aircraft assigned to the flight. | Owner edit | Functional | baseline | SN-AIR-01 | AOC decision support (flight planning system); Load planner | Analysis |  | [B] `mori2022massCruise` |
| SLR-PLN-04 | The NAS shall load each flight with fuel to reach its destination, then its most distant alternate, then fly 45 minutes at normal cruise. | Claude, kept | Constraint | baseline | SN-GOV-01 | Dispatcher | Inspection | fuel remaining after destination and alternate (minutes at normal cruise). Value: 45 | [C] 14 CFR 121.639 |
| SLR-PLN-05 | The NAS shall release a flight only when the dispatcher and the captain both agree that it can be flown safely as planned. | Claude, kept | Functional | baseline | SN-GOV-01 | Dispatcher; Flight deck crew | Inspection |  | [A] 14 CFR 121.533 |
| SLR-PLN-06 | The NAS shall file each flight plan with air traffic control before the flight departs. | Claude, kept | Interface | baseline | SN-ATC-01, SN-ATC-02 | Dispatcher; Air traffic control | Inspection |  | [A] `faa2025aim`, `faa2025jo72103ee` |
| SLR-PLN-07 | The NAS shall deliver the dispatch release, flight plan, weather, notices to airmen (NOTAMs) and load sheet to the flight crew before departure. | Claude, kept | Interface | baseline | SN-CRW-07 | Dispatcher; Load planner | Inspection |  | [B] `seamster2011collabSystems` |

- **SLR-PLN-01**: The flight plan sets the cruise altitude, speed and fuel load each aircraft has when the conflict occurs.
- **SLR-PLN-02**: The cost-optimal altitude depends on mass (`mori2022massCruise`, Figure 1), which is why two aircraft of one type can want different levels. The owner struck "the planned take-off weight". Owner: the next tier can hold several requirements under this one, one per way of computing it (low fidelity, high fidelity, rules of thumb per aircraft type).
- **SLR-PLN-04**: The fuel load is part of the take-off weight, and the reserve sets the least fuel, and so the least weight, an aircraft can have in cruise. Owner: it goes into the low-fidelity model's assumptions. **Unconfirmed:** the 45 minutes and the paragraph number are from general knowledge; check against 14 CFR 121.639 before baselining.
- **SLR-PLN-05**: It is why a controller will issue a descent as a tactical change without negotiation and will not issue a climb. There is no question that a descent can be achieved. A climb is different: the released plan vouches for the planned level and nothing above it. That is the reasoning behind the rule of thumb (owner).
- **SLR-PLN-06**: The filed plan is the only statement of the airline's intent the controller has today, so it is the baseline that the proposed data share adds to. No lead time is set.
- **SLR-PLN-07**: The load sheet is how the actual weight reaches the crew and the flight management system.

### Clearance, separation and tactical trajectory change

Place on the trajectory-intent chain: ATC constraints -> trajectory negotiation.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-CLR-01 | The NAS shall keep each pair of controlled aircraft separated by at least the minimum that JO 7110.65BB sets for the airspace they are in. | Claude, kept | Performance | baseline | SN-ATC-01, SN-CRW-06 | Air traffic control; En-route center (ARTCC); Terminal approach control (TRACON) | Analysis | lateral and vertical distance between each pair of aircraft (NM and ft) | [A] `faa2025jo711065bb` |
| SLR-CLR-02 | The NAS shall predict a loss of separation between controlled aircraft before it occurs. | Claude, kept | Functional | baseline | SN-ATC-01, SN-CRW-06 | ATC decision support | Analysis |  | [B] `engility2014tasarAlaska` |
| SLR-CLR-04 | The NAS shall provide a two-way communication path from the flight crew to the controlling facility and to the dispatcher for the whole flight. | Owner edit | Interface | baseline | SN-CRW-08, SN-AIR-03 | Aircraft communication system; Air traffic control; Dispatcher | Inspection |  | [SME] |
| SLR-CLR-08 | The NAS shall allow the captain to deviate from a clearance when safety requires it, with air traffic control told as soon as practical. | Claude, kept | Functional | baseline | SN-GOV-01 | Flight deck crew | Inspection |  | [A] 14 CFR 91.3 |
| SLR-CLR-09 | The NAS shall answer each flight crew request for a route, altitude or speed change with an approval, an amended clearance or a refusal. | Claude, kept | Functional | baseline | SN-AIR-01 | Air traffic control; Flight deck crew | Demonstration |  | [B] `engility2014tasarAlaska` |
| SLR-CLR-10 | The NAS shall issue only clearances that the aircraft can fly. | Owner edit | Constraint | improved | SN-CRW-03 | Air traffic control | Analysis |  | [B] `coppenbarger1999climbPrediction`, `engility2014tasarAlaska` |
| SLR-CLR-13 | The NAS should choose, among the maneuvers that restore separation, the one with the lowest impact on the aircraft involved. | Owner edit | Performance (goal) | improved | SN-AIR-05, SN-ENV-01 | ATC decision support; Air traffic control | Analysis | the experiment's measure of impact: sum over the aircraft involved of fuel cost plus cost index x time (USD per conflict) | [B] `schultz2012adaptiveClimb`, `mori2022massCruise`, `kirwan2001coraStrategies` |
| SLR-CLR-15 | The NAS shall keep the control instructions needed to resolve a conflict within what the sector team can sustain. | Claude, kept | Performance | baseline | SN-ATC-04 | Air traffic control | Analysis | instructions issued plus follow-up instructions, per conflict (count) | [B] `rantanen2012conflictManeuvers`, `kirwan2001coraStrategies` |

- **SLR-CLR-01**: The hard constraint every resolution option must meet; it is not traded (`knowledge/models/experiment-definition.md` section 6). **Unconfirmed:** for en-route radar the minimum is commonly 5 NM or 1,000 ft; those numbers are from general knowledge and are left out of the measure until the paragraph of JO 7110.65BB is confirmed.
- **SLR-CLR-02**: The conflict has to be predicted before any option can be chosen. No look-ahead time is set; `engility2014tasarAlaska` page 9 uses an eight-minute probe in its own model, which is a candidate.
- **SLR-CLR-04**: The clearance, the crew's "unable" and any crew request cross this path. The owner added the dispatcher and struck "of controlled". It also answers SN-AIR-03, because the crew and the dispatchers are the ones who coordinate so that the airline is informed (owner).
- **SLR-CLR-08**: 14 CFR 91.3. **Open (owner's question):** should leaving the choice to the crew, with a response delay, be one of the experiment's options?
- **SLR-CLR-09**: A crew request is the only way today that what the aircraft knows about its own weight and best altitude reaches the controller, so it is the baseline counterpart of the proposed data share.
- **SLR-CLR-10**: Not fully met today: the ground system assumes one nominal weight per aircraft type (`coppenbarger1999climbPrediction`), and the crew answers "unable" when a clearance cannot be flown. The rule in D-013 (offer a climb only at or below FL350) stands in for the missing knowledge. The owner struck "at its current weight": weight is not required, but it helps when it is in the model behind a decision aid.
- **SLR-CLR-13**: A goal, not a requirement (section 5). Not pursued today, because the deciding party lacks the information in SLR-INF-02. "Impact" is the owner's word: it is generic and leaves what counts to each controller. The measure is not the owner's (section 7, item 2).
- **SLR-CLR-15**: **Claude's wording, not yet reviewed (section 7, item 1).** It gives the restored SN-ATC-04 an answer and the experiment's workload column (instructions issued plus follow-ups) a requirement to trace to. The count is a ceiling, following the owner's note on SN-ATC-04. No ceiling is set, because no held source gives one.

### Information for trajectory decisions

Place on the trajectory-intent chain: what the party making each decision must be given.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-INF-01 | The NAS shall give the sector controller the filed route, requested altitude and requested speed of each aircraft before it enters the sector. | Claude, kept | Interface | baseline | SN-ATC-01 | Air traffic control; En-route center (ARTCC) | Inspection |  | [A] `faa2025jo711065bb` |
| SLR-INF-02 | The NAS shall give the party that decides a change to an aircraft's trajectory the information needed to preserve safety and pursue optimality. | Owner | Interface | improved | SN-AIR-05, SN-CRW-03 | Flight management system; Airline operations center; ATC decision support; Air traffic control | Analysis |  | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction`, `sheth2010creditsConcept` |
| SLR-INF-07 | The NAS shall send the airline and the destination airport an updated arrival estimate whenever a flight's estimate changes by more than 5 minutes. | Claude, kept | Interface | baseline | SN-AIR-02, SN-AIR-03 | Flight management system; Flight deck crew; Airline operations center; Airport management system | Inspection | change in estimated arrival time that triggers an update (minutes). Value: 5 | [B] `seamster2011collabSystems` |

- **SLR-INF-01**: This is what the controller knows about each aircraft today (case A of the experiment).
- **SLR-INF-02**: Not met today: the controller does not receive weight or cost index (`schultz2012adaptiveClimb`, page 2). Cases C and D of the experiment. The owner wrote it to replace three statements that named gross weight, cost index and connection priority one at a time, which the owner judged implied. Those three items are the attributes of `AirlinePerformanceShare` in `nas_sysml_package_definitions.sysml` (D-019), and they reappear one tier down in HLR-OPS-05 and HLR-ATC-08.
- **SLR-INF-07**: How the airline learns what a trajectory change did to the arrival time. It answers SN-AIR-03 together with SLR-CLR-04: the crew and the dispatcher coordinate over that path, and this is what they pass. The 5 minutes is the crew-to-dispatch practice in `seamster2011collabSystems`. **Claude's proposal, not the source's:** extending the same trigger to the airport.

### Onboard execution

Place on the trajectory-intent chain: FMS intent -> guidance commands -> aircraft motion.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-EXE-02 | The NAS shall fly each aircraft along its cleared route and at its cleared altitude and speed within the navigation and altitude tolerances of the airspace. | Owner edit | Performance | baseline | SN-ATC-01 | Auto flight control system; Flight management system | Analysis | cross-track distance from the cleared route; difference from the cleared altitude (NM and ft) | [SME] |
| SLR-EXE-03 | The NAS shall predict each flight's arrival time, fuel at destination, optimum altitude and maximum altitude from the aircraft's estimated performance. | Owner edit | Functional | baseline | SN-AIR-01, SN-CRW-03 | Flight management system; AOC decision support (flight planning system) | Inspection |  | [SME] `mori2022massCruise` |
| SLR-EXE-06 | The NAS shall alert the flight crew, dispatchers and controllers when the fuel predicted at the destination falls below the required reserve. | Owner edit | Functional | baseline | SN-GOV-01, SN-CRW-03 | Flight management system; Dispatcher; Air traffic control | Inspection |  | [SME] |

- **SLR-EXE-02**: How far an aircraft may stray from its clearance is part of the margin a resolution must leave, so it has to be accounted for in the separation requirements (owner). The owner added "and speed". No tolerance is set: it depends on the navigation specification of the route, which the scenario has not chosen, and no speed tolerance is named.
- **SLR-EXE-03**: The prediction matters wherever it is made, and it is what sits behind the rule in D-013 that a climb is offered only at or below FL350; that is why the owner struck "on board". "Estimated performance" is the owner's wording. On board it is the item `FmsPerformancePrediction` in `nas_sysml_package_definitions.sysml`. The allocation to the airline's flight planning system is Claude's (section 7, item 3).
- **SLR-EXE-06**: Fuel at the destination is a limit on which resolution an aircraft can accept. The owner added "dispatchers and controllers". The allocation to the dispatcher and air traffic control is Claude's, and the `baseline` tag is **unconfirmed** (section 7, item 3).

### Airport and surface

Place on the trajectory-intent chain: start and end of the chain on the ground.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-APT-04 | The NAS shall have each aircraft fuelled, loaded and sealed by its scheduled off-block time. | Owner edit | Performance | baseline | SN-AIR-02 | Ground handling; Fuel distribution system; Flight deck crew | Demonstration | actual off-block time minus scheduled off-block time (minutes) | [B] `schultz2017turnaround` |

- **SLR-APT-04**: It speaks to the unknowns in weights and to when the information is available (owner): the final weight is known only when loading ends. "Sealed" is the owner's word.

### Measurement and records

Place on the trajectory-intent chain: back up the chain: what is reported to the authorities and stakeholders.

| ID | Requirement | Wording | Kind | State | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|
| SLR-MEA-01 | The NAS shall record each change to an aircraft's trajectory, to its clearance, or to the constraints imposed on it, with the authority that issued it and the time. | Claude, kept | Functional | baseline | SN-GOV-01 | Dispatcher; Air traffic control; Command Center (ATCSCC) | Inspection |  | [A] `faa2025jo72103ee` |
| SLR-MEA-02 | The NAS shall report the fuel burned and the CO2 emitted by each flight, at 3.16 kg of CO2 per kg of fuel. | Claude, kept | Performance | baseline | SN-ENV-01, SN-AIR-01 | Flight management system; Airline operations center | Analysis | CO2 emitted per kg of fuel burned (kg CO2 per kg fuel). Value: 3.16 | [A] `icao2024icecMethodology` |

- **SLR-MEA-01**: The record is what lets a resolution be scored after the fact. Claude's sentence, written from the owner's note on the first print and left standing on the second.
- **SLR-MEA-02**: The experiment's fuel column, and the CO2 figure derived from it. `icao2024icecMethodology` page 6, accepted in D-015. The number is a conversion factor, not a limit.

## 5. Goals

A goal is a statement the owner judged "not required". It stays in the model because the experiment measures it, but it is written with "should" and carries `obligation = goal` (attribute in `requirements_definitions.sysml`, D-020). A goal is measured; it is not passed or failed.

- **SLR-CLR-13** (the maneuver with the lowest impact on the aircraft involved). The owner's note on the first print: "Not required, but a goal. What do sources say?" The held sources agree. Kirwan and Flynn record the controller's aim as to separate aircraft "first safely, and then expeditiously" (`kirwan2001coraStrategies`, p. 4, as quoted in `evidence/literature-notes/summaries/4 - kirwan2001coraStrategies.md`). The summaries of JO 7110.65BB and JO 7210.3EE held here record no duty to pick the cheapest maneuver for the aircraft. The summaries were searched for this; the orders themselves were not re-read.

## 6. What was struck

The owner struck 17 of the first draft's 27 stakeholder requirements and 31 of its 53 system requirements, and wrote three new stakeholder requirements. Claude added one system requirement afterwards (SLR-CLR-15, section 7). IDs were not renumbered, so a gap in the numbering is a struck requirement.

What went, by the owner's reason:

- **Traffic management initiatives** (the whole SLR-FLW area, SLR-PLN-08, SN-ATC-05, SLR-MEA-04): not tactical interventions (section 2).
- **True of the NAS, but not the studied decision** ("Not D-007", "Not relevant to project"): the airport, passenger and military requirements; surveillance, readback, handoff and holding; onboard navigation and controls; crew duty time; noise.
- **The airline's own business:** SLR-PLN-03 (minimize the airline's stated cost). "This is an airline's prerogative."
- **Not a safety objective:** SLR-CLR-12 (fewest control instructions). Workload is a ceiling (SN-ATC-04).
- **Implied by another requirement:** SLR-INF-03 and SLR-INF-04, merged into SLR-INF-02.

Two cuts leave something behind. Keeping the airline's shared data private (SN-AIR-06, SLR-INF-05) is "important & real, but not pertinent"; it is carried as an assumption (D-020 item 4). SN-AIR-04 (the airline chooses which of its flights takes a delay) was fact-checked before it was struck: `evidence/literature-notes/summaries/5 - faa2025jo72103ee.md` records it as an option inside a ground delay program, settled before departure.

The full list, with the text of each struck requirement and the owner's handwriting quoted against it, is in the two marked-up prints and in section 6 of this file as committed on 2026-10-11 (`git show 43a454d:knowledge/models/requirements-and-traceability.md`).

## 7. Added by Claude after the second print: not yet reviewed by the owner

These four are not on either print. Everything else in sections 3 and 4 is.

1. **SLR-CLR-15 is Claude's wording.** The owner brought SN-ATC-04 (workload) back and struck SLR-CLR-12 (fewest instructions) on the same print. That left the restored requirement with nothing answering it, and the experiment's workload column with no requirement to trace to. SLR-CLR-15 turns the owner's note ("If not overworked, controllers can give as many as they want!") into a ceiling: instructions per conflict stay within what the sector team can sustain. It carries no number, because no held source gives one. Re-word it or strike it.
2. **The measure on SLR-CLR-13.** The goal says "lowest impact", which the owner left for each controller to judge. The experiment still has to score with something, so the Measure column names fuel cost plus cost index times time. That is the experiment's choice, not part of the goal. Its source is `mori2022massCruise`, and it is set out in `knowledge/models/experiment-definition.md` section 6.
3. **Two allocations and one tag.** SLR-EXE-03 lost "on board", so the airline's flight planning system was added beside the flight management system. SLR-EXE-06 now alerts dispatchers and controllers, so the dispatcher and air traffic control were added. SLR-EXE-06 is still tagged `baseline`; whether a controller is alerted to low predicted fuel today was not checked against a source.
4. **SLR-CLR-04 now also answers SN-AIR-03.** This applies the owner's answer of 2026-10-11, that the crew and the dispatchers are the ones who coordinate so the airline is informed. The trace link itself has not been seen on a print. Two requirements in section 11 carry it: HLR-CRW-04 and HLR-OPS-06.

## 8. Objectives with no requirement

Rows of `knowledge/models/stakeholder-objective-ontology.md` that no stakeholder requirement picks up, and the reason. The rows are not judged unimportant to the NAS; they are outside the study (section 2). The owner's note on the second print: "These are derived reqts @ the HLR level". That is, where one of these matters to the thread, it enters as a derived requirement one tier down, not as a stakeholder requirement on the NAS. This has not been done yet (#TODO, first item).

| Category | Objective rows | Why not carried |
|---|---|---|
| Airline | Crew cost; Maintenance; Revenue; Dispatch reliability; Flight Safety | The first four are marked Indirect in the ontology's 'Trajectory impact' column. Flight Safety was carried only by the struck SN-PAX-01; separation is carried by SN-ATC-01. |
| Passenger | all rows | The owner struck all three passenger requirements ("Not D-007"). Connections reach the study through the Airline row 'Passenger connections' (SN-AIR-02, SN-AIR-05). |
| ATC / ANSP | Predictability; Delay (ATC-attributed) | SN-ATC-03 and SN-ATC-05 struck. |
| Airport | all rows | "All of these are not D-007" (owner). |
| Flight Crew | Operational flexibility; Schedule/duty constraints | SN-CRW-01, SN-CRW-04 and SN-CRW-05 struck. |
| Environmental / Societal | NOx; Contrail/climate effects; Noise; Local air quality; Community impacts | Noise: "Not important for cruise" (owner). The others: no source is held, and D-015 notes the altitude link to non-CO2 effects still needs one. |
| Military | all rows | SN-MIL-01 struck. D-007 makes military operations a boundary actor. |

## 9. How the two example workbooks were used

The owner's earlier workbooks (`projects/nas-sos-capstone/prework/Stakeholder Requirements.xlsx` and `projects/nas-sos-capstone/prework/1 System Requirements_10-26_v1.xlsx`) were written for an airline operations center (AOC) as the system. They were used for their form: requirements grouped by stakeholder, one "shall" per sentence, compound statements split, vague words replaced by something that can be checked. Their content and their numbers were not reused, because most rows say what the AOC owes another party, and here that party is usually inside the system.

**How the workbook's stakeholders map onto this project's.** Each row states the abstraction and the reason, so it can be defended or changed.

| Workbook stakeholder | This project's group | Abstraction | Why |
|---|---|---|---|
| Air Traffic Control (ATC) | Air traffic control and traffic flow management (FAA Air Traffic Organization) | identical | Same stakeholder. The direction reverses: the workbook asked what the AOC owes ATC; here ATC is inside the system, so the rows say what ATC wants from the whole. |
| Customers | Passengers | renamed | D-007 uses Passengers and treats them as a boundary actor. |
| Pilots & Flight Crew | Flight crew (captain and first officer) | identical | Cabin crew are left out: no authority over in-scope decisions (nas_context_diagram.sysml, cabinCrew comment). |
| FAA, EASA & all Aviation Authorities | Regulator (FAA as rule maker; Department of Transportation) | many to one | D-007 scopes to U.S. domestic Part 121, so only the FAA and DOT rules apply. |
| Airports | Airport operator | identical |  |
| Airline Fleet Planning; Airline Management; Airline & 3rd Party Maintenance & Engineering; Airline Safety & Security Department; Airline IT | Airline (Part 121 scheduled passenger operator) | many to one | In the workbook the AOC was the system, so the rest of the airline stood outside it as separate stakeholders. Here the whole airline is one constituent system (Flight Operations), so its departments are one stakeholder. Their objectives survive as rows in the Airline table of knowledge/models/stakeholder-objective-ontology.md. |
| Pilot Unions | Flight crew (captain and first officer) | many to one | The union's interest in the workbook was duty and rest limits. The requirement that carried it (SN-CRW-05) was struck in the hand review as outside the study. |
| (none) | Communities and environmental organizations | gap in the workbook | Added from knowledge/models/stakeholder-objective-ontology.md and knowledge/models/stakeholder-register.md. |
| (none) | Military airspace users | gap in the workbook | Added from D-007 (boundary actor) and the suaToTfm link in nas_context_diagram.sysml. Its one requirement was struck in the hand review. |

Evidence grades used in this file follow the review key in `projects/nas-sos-capstone/cameo_models/nas_context_diagram.sysml`:

- [A] rule or FAA order held in the source register
- [B] published study held in the source register
- [SME] owner's industry knowledge, to be confirmed by the owner
- [C] general domain knowledge, not yet tied to a source in this repository

Names in `code font` in the Basis column are keys in `evidence/sources/references.bib`. A grade says where the idea comes from. It does not mean the cited paragraph was re-read in the session that wrote this.

## 10. Coverage check

Run on 2026-10-11, after the second hand review and the addition of section 11:

- Stakeholder requirements with no system requirement: 0 of 13.
- System requirements with no stakeholder parent: 0 of 23.
- System requirements with no allocation: 0 of 23.
- System requirements with no constituent system requirement under them: 0 of 23.
- Constituent system requirements with no system requirement above them: 0 of 28.
- The five constituent systems with no requirement: 0.
- `syside check` over the whole `projects/nas-sos-capstone/cameo_models/` folder: "All checks passed!"

## 11. Constituent system requirements (HLRs)

**Draft written by Claude on 2026-10-11 at the owner's request (D-022). Not reviewed by the owner.** HLR-CRW-01 is the owner's own sentence. The model file is `projects/nas-sos-capstone/cameo_models/requirements_constituent_systems.sysml`.

This is the tier below section 4. In section 4 the subject of every sentence is "The NAS". Here the subject is one of the five systems D-007 models: the flight crew, flight operations, air traffic control, the aircraft, and airport operations. There are 28 requirements. Each one comes from at least one system requirement, and every system requirement in section 4 has at least one requirement here (table at the end of this section).

**Each requirement states its objective.** The Objective column says in one sentence what the requirement is for. The requirement says what the system does; the objective is what that is meant to achieve.

**Where there is more than one way to achieve the objective, the ways are listed as means.** Four means are used, and they are the experiment's four cases:

| Means | What the deciding party works from | Experiment case |
|---|---|---|
| Rule of thumb | Today's information (type, level, speed, filed route) and a rule: one descent, and a climb only at or below FL350 | A |
| Low-fidelity model | A performance model with one nominal weight per aircraft type | B |
| High-fidelity model | A performance model with each aircraft's own weight and cost index, shared by the airline | C |
| High-fidelity model plus connections | The same, with the airline's connection priority for each flight | D |

Three requirements have means that the experiment scores side by side: HLR-ATC-04 (is the clearance flyable), HLR-ATC-05 (how large is the impact on the aircraft) and HLR-ATC-06 (how many instructions). For those three, `cameo_models/nas_verification.sysml` holds one verification case per means, twelve in all. One truth model scores what each means chose (D-017). HLR-OPS-01 (flight planning) lists three means because you noted them on the second print, but the experiment takes each flight's plan as given and does not score them.

The experiment code (`projects/nas-sos-capstone/simulation/experiment_scoring.py`) was not changed. Its cases A to D already are these four means; this section gives them names in the model.

### Flight crew

Flight Crew (D-007 modeled system; part flightCrew.flightDeckCrew).

| ID | Requirement | Objective | Kind | State | Comes from | Allocated to | Means | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|---|
| HLR-CRW-01 | The flight crew shall safely control the flight from origin to destination, as cleared by air traffic control with or without negotiation, and in collaboration with flight operations. | The aircraft flies the trajectory that was cleared, and only that one, unless safety requires otherwise. | Functional | baseline | SLR-EXE-02, SLR-CLR-08, SLR-PLN-05 | Flight deck crew |  | Demonstration |  | [SME] 14 CFR 91.3 |
| HLR-CRW-02 | The flight crew shall accept a clearance only if the aircraft can fly it, and shall answer 'unable' when it cannot. | No clearance the aircraft cannot fly is flown. | Functional | baseline | SLR-CLR-10 | Flight deck crew |  | Demonstration |  | [B] `coppenbarger1999climbPrediction` |
| HLR-CRW-03 | The flight crew shall ask air traffic control for a change of route, altitude or speed when the flight management system's predictions show the flight would be better off with it. | What the aircraft knows about its own best altitude and speed reaches the controller. | Functional | baseline | SLR-CLR-09, SLR-EXE-03 | Flight deck crew |  | Demonstration |  | [B] `engility2014tasarAlaska` |
| HLR-CRW-04 | The flight crew shall tell the dispatcher of each change to the cleared trajectory that moves the estimated arrival time by more than 5 minutes or takes the fuel predicted at the destination below the required reserve. | The airline learns of a tactical intervention in time to re-plan. | Interface | baseline | SLR-INF-07, SLR-EXE-06, SLR-CLR-04 | Flight deck crew |  | Inspection | change in estimated arrival time that triggers a report (minutes). Value: 5 | [B] `seamster2011collabSystems` |
| HLR-CRW-05 | The flight crew shall enter the load sheet weights and the released cost index into the flight management system before departure. | The flight management system predicts from the weight the aircraft actually has. | Functional | baseline | SLR-PLN-07, SLR-EXE-03 | Flight deck crew |  | Inspection |  | [SME] |

- **HLR-CRW-01**: The owner's sentence (2026-10-11), with 'cleared by' for 'cleared with'. In the study: whatever resolution is chosen, it takes effect only when the crew flies it.
- **HLR-CRW-02**: In the study: this is how today's NAS catches a climb the aircraft is too heavy for. It costs a refused clearance and a second one, which the experiment counts as extra instructions.
- **HLR-CRW-03**: In the study: a crew request is the only channel for this knowledge today, so it is what the proposed data share is compared with.
- **HLR-CRW-04**: Owner (2026-10-11): the crew and the dispatchers are the ones who have to coordinate for the airline to be informed (SN-AIR-03). The 5 minutes is the crew-to-dispatch practice in seamster2011collabSystems. In the study: this is how the cost of a resolution becomes known to the airline that bears it.
- **HLR-CRW-05**: Graded [SME] for the owner to confirm from industry experience. In the study: the actual weight exists on board because the crew puts it there; it is the figure the high-fidelity means would share.

### Flight operations

Flight Operations (D-007 modeled system; part flightOperations.airlineOperationsCenter and its dispatcher, load planner and decision support).

| ID | Requirement | Objective | Kind | State | Comes from | Allocated to | Means | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|---|
| HLR-OPS-01 | Flight operations shall plan each flight's route, cruise altitude, cruise speed and fuel load from a model of the performance of the aircraft assigned to it, with the fuel reserve the operating rules require. | Each aircraft enters cruise at an altitude, speed and weight chosen for that aircraft. | Functional | baseline | SLR-PLN-01, SLR-PLN-02, SLR-PLN-04 | AOC decision support (flight planning system); Dispatcher; Load planner | rule of thumb (A); low-fidelity model (B); high-fidelity model (C). Not scored. | Analysis |  | [B] `mori2022massCruise`, `berry2011aocActors` |
| HLR-OPS-02 | The dispatcher shall file each flight's plan with air traffic control before departure. | The controller has the airline's intended route, altitude and speed. | Interface | baseline | SLR-PLN-06 | Dispatcher |  | Inspection |  | [A] `faa2025aim`, `faa2025jo72103ee` |
| HLR-OPS-03 | Flight operations shall give the flight crew the dispatch release, flight plan, weather, notices to airmen (NOTAMs) and load sheet before departure. | The crew and the flight management system start from the plan and the actual weights. | Interface | baseline | SLR-PLN-07 | Dispatcher; Load planner |  | Inspection |  | [B] `seamster2011collabSystems` |
| HLR-OPS-04 | The dispatcher shall release a flight only with the captain's agreement that it can be flown safely as planned. | The planned cruise level is one the dispatcher and the captain have both agreed the aircraft can fly. | Functional | baseline | SLR-PLN-05 | Dispatcher |  | Inspection |  | [A] 14 CFR 121.533 |
| HLR-OPS-05 | Flight operations shall make each flight's current gross weight, cost index and connection priority available to the party that decides a change to that flight's trajectory. | The party deciding can tell what each aircraft can fly and what a change costs its airline. | Interface | improved | SLR-INF-02 | Airline operations center |  | Analysis |  | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction`, `sheth2010creditsConcept` |
| HLR-OPS-06 | The dispatcher shall re-plan the flight with its crew when a trajectory change puts the arrival time or the fuel at the destination at risk. | A tactical intervention is absorbed by the airline's plan and not only by the one flight. | Functional | baseline | SLR-CLR-04, SLR-INF-07, SLR-EXE-06 | Dispatcher |  | Demonstration |  | [B] `seamster2011collabSystems` |
| HLR-OPS-07 | Flight operations shall report each flight's fuel burned and its CO2 emitted at 3.16 kg of CO2 per kg of fuel. | The fuel and CO2 effect of a trajectory change can be counted. | Performance | baseline | SLR-MEA-02 | Airline operations center |  | Analysis | CO2 emitted per kg of fuel burned (kg CO2 per kg fuel). Value: 3.16 | [A] `icao2024icecMethodology` |

- **HLR-OPS-01**: Owner (hand review 2026-10-11): the performance model can be a rule of thumb per aircraft type, a low-fidelity model or a high-fidelity model, and the fuel reserve goes into the low-fidelity model's assumptions. The three are listed as means. The experiment does not score them here: it takes each aircraft's plan as given. In the study: the plan sets the level, speed and weight each aircraft has when the conflict occurs.
- **HLR-OPS-02**: In the study: the filed plan is all the controller knows of the airline's intent today. It is what the rule of thumb and the low-fidelity means decide with.
- **HLR-OPS-03**: In the study: the load sheet is where the actual weight enters the aircraft.
- **HLR-OPS-04**: Owner (2026-10-11): there is no question that a descent can be achieved; a climb is different, and the joint release is what leads to that conclusion in the rule-of-thumb case. The released plan vouches for the planned level and below, and for nothing above it. In the study: this is the reason the rule of thumb descends and does not climb.
- **HLR-OPS-05**: The three items the first draft listed one at a time and SLR-INF-02 absorbed. They are the attributes of AirlinePerformanceShare in nas_sysml_package_definitions.sysml (D-019). Not done today (schultz2012adaptiveClimb, page 2). In the study: this is what separates the high-fidelity means (weight and cost index, case C; plus connection priority, case D) from the other two. Confidentiality is an assumption (D-020).
- **HLR-OPS-06**: The dispatcher's half of the coordination the owner named for SN-AIR-03 (2026-10-11); HLR-CRW-04 is the crew's half. In the study: context for case D, where a late flight with connections is the reason one aircraft's time is worth more than its fuel.
- **HLR-OPS-07**: In the study: the experiment's fuel column and the CO2 figure derived from it (D-015).

### Air traffic control

Airspace Management (D-007 modeled system; parts airspaceManagement.atc, its decision support, and the en-route center).

| ID | Requirement | Objective | Kind | State | Comes from | Allocated to | Means | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|---|
| HLR-ATC-01 | Air traffic control shall keep each pair of aircraft it controls separated by at least the applicable minimum, allowing for each aircraft's permitted deviation from its cleared route, altitude and speed. | No loss of separation. | Performance | baseline | SLR-CLR-01, SLR-EXE-02 | Air traffic control; En-route center (ARTCC) |  | Analysis | lateral and vertical distance between each pair of aircraft (NM and ft) | [A] `faa2025jo711065bb` |
| HLR-ATC-02 | ATC decision support shall alert the sector controller to each predicted loss of separation before it occurs. | The controller has time to choose a resolution and not only to react. | Functional | baseline | SLR-CLR-02 | ATC decision support |  | Analysis |  | [B] `engility2014tasarAlaska` |
| HLR-ATC-03 | The en-route center shall show the sector controller each aircraft's filed route, requested altitude and requested speed before the aircraft enters the sector. | The controller knows where each aircraft intends to go. | Interface | baseline | SLR-INF-01 | En-route center (ARTCC) |  | Inspection |  | [A] `faa2025jo711065bb` |
| HLR-ATC-04 | Air traffic control shall resolve each predicted conflict with a clearance that every aircraft it moves can fly. | The conflict is resolved by the first clearance issued, with no 'unable' and no second attempt. | Constraint | improved | SLR-CLR-10, SLR-CLR-01 | Air traffic control; ATC decision support | rule of thumb (A); low-fidelity model (B); high-fidelity model (C); high-fidelity model plus connections (D). **Scored.** | Analysis | whether the chosen option is flyable under the truth model (yes or no) | [B] `coppenbarger1999climbPrediction`, `engility2014tasarAlaska` |
| HLR-ATC-05 | Air traffic control should choose, among the clearances that resolve a conflict and can be flown, the one with the lowest impact on the aircraft involved. | Lowest impact on the aircraft involved. The experiment scores impact as fuel burned and as airline cost (fuel cost plus cost index times time), per aircraft and summed. | Performance (goal) | improved | SLR-CLR-13 | ATC decision support; Air traffic control | rule of thumb (A); low-fidelity model (B); high-fidelity model (C); high-fidelity model plus connections (D). **Scored.** | Analysis | fuel burned and airline cost, per aircraft and summed over the aircraft involved (kg and USD per conflict) | [B] `schultz2012adaptiveClimb`, `mori2022massCruise`, `kirwan2001coraStrategies` |
| HLR-ATC-06 | Air traffic control shall resolve each predicted conflict within the number of instructions the sector team can sustain. | Controller workload stays under its ceiling whichever means chooses the resolution. | Performance | baseline | SLR-CLR-15 | Air traffic control | rule of thumb (A); low-fidelity model (B); high-fidelity model (C); high-fidelity model plus connections (D). **Scored.** | Analysis | instructions issued plus follow-up instructions, per conflict (count) | [B] `rantanen2012conflictManeuvers`, `kirwan2001coraStrategies` |
| HLR-ATC-07 | Air traffic control shall answer each flight crew request for a route, altitude or speed change with an approval, an amended clearance or 'unable'. | A crew request is never left open. | Functional | baseline | SLR-CLR-09 | Air traffic control |  | Demonstration |  | [A] `faa2025jo711065bb`, `engility2014tasarAlaska` |
| HLR-ATC-08 | ATC decision support shall use each flight's shared gross weight, cost index and connection priority, when the airline has shared them, to judge which clearances the aircraft can fly and what each costs. | The shared information changes the decision and does not only arrive. | Functional | improved | SLR-INF-02 | ATC decision support |  | Analysis |  | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction` |
| HLR-ATC-09 | Air traffic control shall record each clearance it issues with the issuing facility and the time. | A resolution can be examined after the fact. | Functional | baseline | SLR-MEA-01 | Air traffic control |  | Inspection |  | [A] `faa2025jo72103ee` |

- **HLR-ATC-01**: Owner (hand review 2026-10-10): conformance has to be accounted for in the separation requirements. In the study: the hard constraint on every resolution option, whichever means chooses it.
- **HLR-ATC-02**: In the study: the starting event of the experiment. No look-ahead time is set; engility2014tasarAlaska page 9 uses eight minutes in its own model.
- **HLR-ATC-03**: In the study: together with type, level and speed, this is the whole of 'today's information' that the rule of thumb decides with (case A).
- **HLR-ATC-04**: Four means of knowing what an aircraft can fly, scored in the experiment. Rule of thumb: descend, and offer a climb only at or below FL350 (D-013, from engility2014tasarAlaska page 8; the joint release in HLR-OPS-04 is why a descent is safe to assume). Low-fidelity model: one nominal weight per aircraft type (coppenbarger1999climbPrediction). High-fidelity model: each aircraft's own weight, shared under HLR-OPS-05. The fourth adds connection priority, which does not change what can be flown. The truth model's thrust check (NasAnalysis::CanHoldLevel) says whether the option each means chose was flyable.
- **HLR-ATC-05**: A goal, like its parent SLR-CLR-13. Four means of judging impact, scored in the experiment. Rule of thumb: one descent, by the controller's rule (rantanen2012conflictManeuvers: 23 of 36 observed cases). Low-fidelity model: lowest estimated cost with one nominal weight per type, which cannot tell two aircraft of one type apart. High-fidelity model: lowest estimated cost with each aircraft's own weight and cost index. High-fidelity model plus connections: the same, with the airline's connection priority. One truth model scores what each means chose.
- **HLR-ATC-06**: No ceiling is set, as on the parent SLR-CLR-15, so the experiment reports the count for each means and does not pass or fail it. In the study: the experiment's workload column, which is how a cheaper resolution that takes more instructions is shown for what it is.
- **HLR-ATC-07**: JO 7110.65BB paragraph 2-1-18, as recorded in evidence/literature-notes/summaries/5 - faa2025jo711065bb.md (which also allows 'stand by'). In the study: the controller's half of the request channel in HLR-CRW-03.
- **HLR-ATC-08**: The receiving end of HLR-OPS-05 (D-019: decision support is owned by the system that decides, D-012). Not done today. In the study: the difference between case B and cases C and D.
- **HLR-ATC-09**: In the study: the record is what a real-world version of the experiment's instruction count would be taken from.

### Aircraft

Aircraft Systems (D-007 modeled system; part aircraftSystems.aircraft and its avionics).

| ID | Requirement | Objective | Kind | State | Comes from | Allocated to | Means | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|---|
| HLR-ACF-01 | The flight management system shall predict the flight's arrival time, fuel at the destination, optimum altitude and maximum altitude from the entered weights, the cost index and the forecast winds. | The aircraft knows what it can fly and what is best for it. | Functional | baseline | SLR-EXE-03 | Flight management system |  | Inspection |  | [SME] `mori2022massCruise` |
| HLR-ACF-02 | The auto flight control system shall hold the aircraft on its cleared route, altitude and speed within the tolerances of the airspace. | The aircraft is where its clearance says it is. | Performance | baseline | SLR-EXE-02 | Auto flight control system; Flight management system |  | Analysis | cross-track distance from the cleared route; difference from the cleared altitude and speed (NM, ft and Mach) | [SME] |
| HLR-ACF-03 | The flight management system shall alert the flight crew when the fuel it predicts at the destination falls below the required reserve. | The crew knows when a trajectory change has used up the fuel margin. | Functional | baseline | SLR-EXE-06 | Flight management system |  | Inspection |  | [SME] |
| HLR-ACF-04 | The aircraft communication system shall carry voice and data between the flight crew and both air traffic control and the dispatcher for the whole flight. | Clearances, refusals, requests and reports to the airline can all be exchanged from the flight deck. | Interface | baseline | SLR-CLR-04 | Aircraft communication system |  | Inspection |  | [SME] |
| HLR-ACF-05 | The flight management system shall send its current gross weight and its predicted optimum and maximum altitudes to the airline operations center. | The airline holds the aircraft's own figures, so that it can share them (HLR-OPS-05). | Interface | baseline | SLR-INF-02, SLR-EXE-03 | Flight management system; Aircraft communication system |  | Inspection |  | [SME] |

- **HLR-ACF-01**: Graded [SME]. The item FmsPerformancePrediction in nas_sysml_package_definitions.sysml. In the study: the on-board high-fidelity model. Its maximum altitude is the answer the rule of thumb replaces with 'at or below FL350'.
- **HLR-ACF-02**: Graded [SME]. No tolerance is set. In the study: the deviation HLR-ATC-01 has to allow for.
- **HLR-ACF-03**: Graded [SME]. The parent SLR-EXE-06 also names dispatchers and controllers; they hear through the crew (HLR-CRW-04). In the study: fuel at the destination is a limit on which resolution an aircraft can accept.
- **HLR-ACF-04**: Graded [SME]. In the study: every exchange the experiment counts as an instruction crosses this link.
- **HLR-ACF-05**: The FMS-to-airline exchange named as one of the three on the thread in D-019 item 4. Whether aircraft do this today is for the owner to say [SME]; it is left as baseline because D-019 tags only the airline-to-ATC exchange as improved. In the study: the first link of the high-fidelity means.

### Airport operations

Airport Operations (D-007 modeled system; part airportOperations.airport and its ground handling and fuelling).

| ID | Requirement | Objective | Kind | State | Comes from | Allocated to | Means | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|---|---|---|
| HLR-APT-01 | Airport operations shall have each aircraft fuelled, loaded and sealed by its scheduled off-block time. | The flight leaves on schedule with its load complete. | Performance | baseline | SLR-APT-04 | Ground handling; Fuel distribution system |  | Demonstration | actual off-block time minus scheduled off-block time (minutes) | [B] `schultz2017turnaround` |
| HLR-APT-02 | Airport operations shall report the fuel uplifted and the load put on board to the flight crew and the load planner before off-block. | The weight used on board and by the airline is the weight the aircraft has. | Interface | baseline | SLR-APT-04, SLR-PLN-07 | Fuel distribution system; Ground handling |  | Inspection |  | [C] |

- **HLR-APT-01**: In the study: the weakest link of the five systems. It matters only because the weight is not final until loading ends.
- **HLR-APT-02**: D-009 records the fuel slip reaching the crew from the airport fuel carrier; the load report is from general knowledge. In the study: the owner's note on SLR-APT-04, that it speaks to the unknowns in weights and to when the information is available.

### Which system requirement each one comes from

| System requirement | Constituent system requirements under it |
|---|---|
| SLR-PLN-01 | HLR-OPS-01 |
| SLR-PLN-02 | HLR-OPS-01 |
| SLR-PLN-04 | HLR-OPS-01 |
| SLR-PLN-05 | HLR-CRW-01, HLR-OPS-04 |
| SLR-PLN-06 | HLR-OPS-02 |
| SLR-PLN-07 | HLR-CRW-05, HLR-OPS-03, HLR-APT-02 |
| SLR-CLR-01 | HLR-ATC-01, HLR-ATC-04 |
| SLR-CLR-02 | HLR-ATC-02 |
| SLR-CLR-04 | HLR-CRW-04, HLR-OPS-06, HLR-ACF-04 |
| SLR-CLR-08 | HLR-CRW-01 |
| SLR-CLR-09 | HLR-CRW-03, HLR-ATC-07 |
| SLR-CLR-10 | HLR-CRW-02, HLR-ATC-04 |
| SLR-CLR-13 | HLR-ATC-05 |
| SLR-CLR-15 | HLR-ATC-06 |
| SLR-INF-01 | HLR-ATC-03 |
| SLR-INF-02 | HLR-OPS-05, HLR-ATC-08, HLR-ACF-05 |
| SLR-INF-07 | HLR-CRW-04, HLR-OPS-06 |
| SLR-EXE-02 | HLR-CRW-01, HLR-ATC-01, HLR-ACF-02 |
| SLR-EXE-03 | HLR-CRW-03, HLR-CRW-05, HLR-ACF-01, HLR-ACF-05 |
| SLR-EXE-06 | HLR-CRW-04, HLR-OPS-06, HLR-ACF-03 |
| SLR-APT-04 | HLR-APT-01, HLR-APT-02 |
| SLR-MEA-01 | HLR-ATC-09 |
| SLR-MEA-02 | HLR-OPS-07 |

### Parts of the five systems with no requirement here

"Every constituent system" was read as the five systems D-007 models. Inside them, these parts have no requirement, because nothing in the study depends on them:

- **Air traffic control:** the Command Center, the traffic management unit and the traffic flow automation (traffic management initiatives are outside the study, D-021); terminal approach control (the conflict is en route).
- **Flight operations:** the AOC's ATC coordinator, flight follower, maintenance controller, crew scheduler, aircraft router and duty manager; the ticketing system.
- **Airport operations:** the control tower, runways, gates, apron, terminal, airport management system and the rest. Only fuelling and ground handling carry a requirement.
- **Aircraft:** the navigation, surveillance, display and guidance systems, the flight deck controls, propulsion, airframe and the other physical systems. Only the flight management system, auto flight control system and communication system carry a requirement.
- **Flight crew:** cabin crew.

### Things to check in this draft

1. **Airport operations is a thin fit.** You asked for every constituent system to have requirements. The two written for the airport (HLR-APT-01, HLR-APT-02) are in the study only through the aircraft's weight. Under the test in section 2 they are the first to go if you want this tier as tight as the one above.
2. **The fourth means.** You named three (low fidelity, high fidelity, rules of thumb). Case D of the experiment gives a fourth. It is listed as its own means; it could instead be treated as a variant of the high-fidelity model.
3. **HLR-ACF-05 (the flight management system sends its weight and altitude predictions to the airline).** Tagged as done today. That is your call to make from experience.
4. **Requirements graded [SME]** rest on your experience and need your confirmation: HLR-CRW-05, HLR-ACF-01, HLR-ACF-02, HLR-ACF-03, HLR-ACF-04, HLR-ACF-05.
5. **The flight planning means (HLR-OPS-01) are not scored.** If you want the experiment to vary how the plan was computed, that is new experiment scope.
