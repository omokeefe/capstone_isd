# Requirements and Traceability

**Status: draft, not reviewed by the owner.** Written by Claude on 2026-10-10 at the owner's request. Every requirement below has status `draft` in the model. Nothing is baselined, and no box in `projects/nas-sos-capstone/to-do-list.md` section 10 has been checked on the strength of it. Not report text.

**The model is the source of truth (D-006).** This file is a readable copy of two model files, written for review on paper:

- `projects/nas-sos-capstone/cameo_models/requirements_stakeholders.sysml` holds the 27 stakeholder requirements.
- `projects/nas-sos-capstone/cameo_models/requirements_nas_system.sysml` holds the 53 system requirements and their allocation to systems.
- `projects/nas-sos-capstone/cameo_models/requirements_definitions.sysml` holds the attributes both use.

If this file and those disagree, the `.sysml` files win. Mark changes here by hand, then apply them to the `.sysml` files.

## 1. What is here

- **27 stakeholder requirements** in 8 stakeholder groups. Each says what that group wants from the NAS as a whole, and names the objective rows it comes from in `knowledge/models/stakeholder-objective-ontology.md`.
- **53 system requirements** in 7 areas that follow the lifecycle of trajectory intent (`projects/nas-sos-capstone/index.md`, "Center of gravity").
- **Every stakeholder requirement is answered by at least one system requirement.** Section 3 shows which.
- **48 system requirements trace to a stakeholder requirement. 5 are derived** and carry a rationale. Section 5 lists them.
- **5 system requirements are not met by the system as it operates today** (SLR-CLR-10, SLR-CLR-13, SLR-INF-02, SLR-INF-03, SLR-INF-04). They are the ones the experiment in `knowledge/models/experiment-definition.md` is about.
- Every system requirement is allocated to parts of `NationalAirspaceSystem` in `projects/nas-sos-capstone/cameo_models/nas_sysml_package_definitions.sysml`.

The trace runs: objective row, then stakeholder requirement, then system requirement, then constituent system.

## 2. How the two example workbooks were used

The owner's earlier workbooks were written for an airline operations center (AOC) as the system. They were used for their form, not their content.

**Carried over from `projects/nas-sos-capstone/prework/Stakeholder Requirements.xlsx`, worksheet "Stakeholder Requirements Groupi":**

- Requirements are grouped by the stakeholder who wants them.
- Each is one sentence with the system as the subject and one "shall".
- Broad wishes are allowed at this level ("maximize profits", "minimize delays"); the number comes later.
- Rows that repeat another row are merged, as the workbook did with its "already captured" comments.

**Carried over from `projects/nas-sos-capstone/prework/1 System Requirements_10-26_v1.xlsx`, worksheet "Report":**

- A compound stakeholder requirement is split into single statements (the workbook split "accurate and up-to-date flight plans" into two).
- A vague word is replaced by something that can be checked (the workbook turned "significant changes in fuel status" into "in excess of 5% of expected fuel burned").
- A rule is named by its paragraph where one is known (the workbook named the CFR part for crew fatigue).
- There are more system requirements than stakeholder requirements.

**Not carried over:**

- The content. Most workbook rows say what the AOC owes another party. Here that other party is usually inside the system, so the row becomes an exchange between two constituent systems.
- Rows about how an airline runs itself (budget, corporate values, IT approval, cybersecurity training, record keeping). They do not touch the trajectory-intent chain.
- Numbers. The workbook's 60 minutes for filing a flight plan and 5 percent fuel deviation are not reused, because no source held in this repository gives them.

**How the workbook's stakeholders map onto this project's.** Each row states the abstraction and the reason, so it can be defended or changed.

| Workbook stakeholder | This project's group | Abstraction | Why |
|---|---|---|---|
| Air Traffic Control (ATC) | Air traffic control and traffic flow management (FAA Air Traffic Organization) | identical | Same stakeholder. The direction reverses: the workbook asked what the AOC owes ATC; here ATC is inside the system, so the rows say what ATC wants from the whole. |
| Customers | Passengers | renamed | D-007 uses Passengers and treats them as a boundary actor. |
| Pilots & Flight Crew | Flight crew (captain and first officer) | identical | Cabin crew are left out: no authority over in-scope decisions (nas_context_diagram.sysml, cabinCrew comment). |
| FAA, EASA & all Aviation Authorities | Regulator (FAA as rule maker; Department of Transportation) | many to one | D-007 scopes to U.S. domestic Part 121, so only the FAA and DOT rules apply. |
| Airports | Airport operator | identical |  |
| Airline Fleet Planning; Airline Management; Airline & 3rd Party Maintenance & Engineering; Airline Safety & Security Department; Airline IT | Airline (Part 121 scheduled passenger operator) | many to one | In the workbook the AOC was the system, so the rest of the airline stood outside it as separate stakeholders. Here the whole airline is one constituent system (Flight Operations), so its departments are one stakeholder. Their objectives survive as rows in the Airline table of knowledge/models/stakeholder-objective-ontology.md. |
| Pilot Unions | Flight crew (captain and first officer) | many to one | The union's interest in the workbook was duty and rest limits, which is SN-CRW-05. |
| (none) | Communities and environmental organizations | gap in the workbook | Added from knowledge/models/stakeholder-objective-ontology.md and knowledge/models/stakeholder-register.md. |
| (none) | Military airspace users | gap in the workbook | Added from D-007 (boundary actor) and the suaToTfm link in nas_context_diagram.sysml. |

Evidence grades used below follow the review key in `projects/nas-sos-capstone/cameo_models/nas_context_diagram.sysml`:

- [A] rule or FAA order held in the source register
- [B] published study held in the source register
- [SME] owner's industry knowledge, to be confirmed by the owner
- [C] general domain knowledge, not yet tied to a source in this repository

Names in `code font` in the Basis column are keys in `evidence/sources/references.bib`. A grade says where the idea comes from. It does not mean the cited paragraph was re-read in the session that wrote this.

## 3. Stakeholder requirements

### Airline (Part 121 scheduled passenger operator)

D-007 treatment: Modeled system (Flight Operations).

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-AIR-01 | The NAS shall let the airline plan and fly each flight on the route, altitude and speed that give that flight its lowest operating cost, within safety and capacity limits. | Airline: Fuel cost; Airline: Delay cost | SLR-PLN-01, SLR-PLN-02, SLR-PLN-03, SLR-CLR-09, SLR-EXE-03, SLR-MEA-02 | [B] `mori2022massCruise`, `munro2018managingVariability` |
| SN-AIR-02 | The NAS shall bring each flight to its destination gate at its scheduled arrival time. | Airline: Schedule integrity; Airline: Aircraft utilization; Airline: Passenger connections | SLR-INF-07, SLR-APT-01, SLR-APT-04, SLR-MEA-03 | [C] |
| SN-AIR-03 | The NAS shall tell the airline about airspace and airport constraints that will delay or reroute its flights early enough for the airline to re-plan. | Airline: Delay cost; Airline: Schedule integrity | SLR-FLW-03, SLR-FLW-07 | [A] `faa2025jo72103ee` |
| SN-AIR-04 | The NAS shall let the airline choose which of its own flights takes a delay that the airline has been assigned. *Note: JO 7210.3EE paragraph 18-10-12 (slot substitution) and paragraph 18-4-5 (diversion recovery priorities).* | Airline: Delay cost; Airline: Passenger connections | SLR-FLW-04 | [A] `faa2025jo72103ee` |
| SN-AIR-05 | The NAS shall take the airline's priorities for a flight (fuel against time, and protected connections) into account when another party changes that flight's trajectory. *Note: This is the need behind the experiment in knowledge/models/experiment-definition.md section 2. It is not met today: the controller does not receive weight or cost index.* | Airline: Fuel cost; Airline: Schedule integrity; Airline: Passenger connections | SLR-CLR-13, SLR-INF-02, SLR-INF-03, SLR-INF-04 | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction` |
| SN-AIR-06 | The NAS shall keep the airline's commercially sensitive flight data (aircraft weight, cost index, connection priorities) from other airlines. *Note: No objective row matches this in knowledge/models/stakeholder-objective-ontology.md. Competitive sensitivity is the published reason airlines do not share weight and speed intent. It pulls against SN-AIR-05. Proposed as a new row under Airline.* | none (see note) | SLR-INF-05 | [B] `schultz2012adaptiveClimb` |

### Air traffic control and traffic flow management (FAA Air Traffic Organization)

D-007 treatment: Modeled system (Airspace Management).

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-ATC-01 | The NAS shall keep every controlled aircraft separated from every other aircraft by at least the applicable separation minimum. | ATC / ANSP: Safety/separation | SLR-CLR-01, SLR-CLR-02, SLR-CLR-03, SLR-CLR-05 | [A] `faa2025jo711065bb` |
| SN-ATC-02 | The NAS shall keep the number of aircraft in each sector and at each airport within its declared capacity. | ATC / ANSP: Capacity; ATC / ANSP: Sector workload; ATC / ANSP: Traffic complexity | SLR-PLN-08, SLR-FLW-01, SLR-FLW-02, SLR-FLW-06, SLR-APT-02 | [A] `faa2025jo72103ee` |
| SN-ATC-03 | The NAS shall make the path each controlled aircraft will fly known to its controller in advance. | ATC / ANSP: Predictability | SLR-PLN-06, SLR-FLW-06, SLR-CLR-03, SLR-INF-01, SLR-EXE-01, SLR-EXE-02 | [B] `coppenbarger1999climbPrediction` |
| SN-ATC-04 | The NAS shall keep the number of control actions a sector controller must take within what one sector team can sustain. | ATC / ANSP: Sector workload; ATC / ANSP: Traffic complexity | SLR-FLW-02, SLR-CLR-12 | [B] `rantanen2012conflictManeuvers`, `kirwan2001coraStrategies` |
| SN-ATC-05 | The NAS shall share unavoidable delay equitably among airspace users. *Note: JO 7210.3EE paragraph 18-10-2: equitable assignment of delays to all system users.* | ATC / ANSP: Delay (ATC-attributed) | SLR-FLW-05, SLR-MEA-04 | [A] `faa2025jo72103ee` |

### Airport operator

D-007 treatment: Modeled system (Airport Operations).

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-APT-01 | The NAS shall give the airport operator arrival and departure times reliable enough to assign gates and ground crews. | Airport: Gate utilization; Airport: Turnaround performance | SLR-INF-07, SLR-APT-01 | [C] |
| SN-APT-02 | The NAS shall use the runway capacity the airport has declared available. | Airport: Runway utilization | SLR-APT-02 | [C] |
| SN-APT-03 | The NAS shall keep the time aircraft wait on taxiways with engines running as short as practical. | Airport: Surface congestion | SLR-APT-03 | [C] |

### Flight crew (captain and first officer)

D-007 treatment: Modeled system (Flight Crew).

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-CRW-01 | The NAS shall preserve the captain's final authority over the safe conduct of the flight. | Flight Crew: Safety; Flight Crew: Operational flexibility | SLR-PLN-05, SLR-CLR-08, SLR-EXE-04 | [A] 14 CFR 91.3 |
| SN-CRW-02 | The NAS shall give the flight crew the information needed for each phase of flight before that phase begins. | Flight Crew: Safety; Flight Crew: Procedural compliance | SLR-PLN-01, SLR-PLN-07, SLR-INF-06, SLR-EXE-06 | [B] `seamster2011collabSystems` |
| SN-CRW-03 | The NAS shall give the flight crew only trajectory instructions that the aircraft can fly, with enough time to set them up. | Flight Crew: Workload; Flight Crew: Safety | SLR-CLR-10, SLR-CLR-11, SLR-INF-02, SLR-EXE-03 | [SME] |
| SN-CRW-04 | The NAS shall let the flight crew ask for a trajectory change and get an answer. | Flight Crew: Operational flexibility | SLR-CLR-09 | [B] `engility2014tasarAlaska` |
| SN-CRW-05 | The NAS shall keep each flight crew member within flight and duty time limits. | Flight Crew: Schedule/duty constraints | SLR-PLN-09 | [C] 14 CFR Part 117 |

### Passengers

D-007 treatment: Boundary actor.

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-PAX-01 | The NAS shall carry passengers without injury. *Note: The Passenger table in knowledge/models/stakeholder-objective-ontology.md has no safety row. The interest comes from knowledge/models/stakeholder-register.md (Social: Passengers, safety and convenience). Proposed as a new Passenger row.* | Airline: Flight Safety | SLR-PLN-04, SLR-CLR-01, SLR-CLR-08, SLR-EXE-06 | [C] |
| SN-PAX-02 | The NAS shall get passengers to their destination, including connections, at the time they were sold. | Passenger: Travel time; Passenger: Connection reliability; Passenger: Disruption risk | SLR-INF-04, SLR-MEA-03 | [C] |
| SN-PAX-03 | The NAS shall avoid known turbulence where a route or altitude change allows it. | Passenger: Comfort | SLR-CLR-09, SLR-INF-06 | [C] |

### Regulator (FAA as rule maker; Department of Transportation)

D-007 treatment: Boundary actor.

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-GOV-01 | The NAS shall conduct every flight within the operating rules of 14 CFR and the FAA's air traffic orders. *Note: Governance has no table in knowledge/models/stakeholder-objective-ontology.md. The objective is 'Regulatory Compliance' in the enterprise objective hierarchy in knowledge/models/stakeholder-register.md.* | none (see note) | SLR-PLN-04, SLR-PLN-05, SLR-PLN-09 | [A] `faa2025jo711065bb`, `faa2025jo72103ee`, 14 CFR 91, 14 CFR 121 |
| SN-GOV-02 | The NAS shall make one identified authority accountable for each decision that changes a flight's trajectory. *Note: From 'Regulatory Compliance' and 'Safety' in the enterprise objective hierarchy in knowledge/models/stakeholder-register.md. The joint dispatcher and captain release is the one place the rules deliberately share authority.* | none (see note) | SLR-PLN-05, SLR-CLR-05, SLR-EXE-04, SLR-MEA-01 | [A] 14 CFR 91.3, 14 CFR 121.533, `faa2025jo711065bb` |

### Communities and environmental organizations

D-007 treatment: Boundary actor (acts through Governance per D-007).

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-ENV-01 | The NAS shall keep the CO2 emitted by each flight as low as safety and capacity allow. | Environmental / Societal: CO2 | SLR-PLN-03, SLR-CLR-13, SLR-APT-03, SLR-MEA-02 | [C] `icao2024icecMethodology` |
| SN-ENV-02 | The NAS shall keep aircraft noise over communities near airports within the published noise abatement procedures. | Environmental / Societal: Noise; Environmental / Societal: Community impacts | SLR-APT-05 | [C] |

### Military airspace users

D-007 treatment: Boundary actor.

| ID | The stakeholder wants | Objective rows it comes from | Answered by | Basis |
|---|---|---|---|---|
| SN-MIL-01 | The NAS shall give military operations sole use of special use airspace while it is scheduled active. | Military: Airspace access | SLR-PLN-08, SLR-FLW-07, SLR-CLR-14 | [C] |

## 4. System requirements

Columns: **Traces to** is the stakeholder requirement it answers, or DERIVED. **Allocated to** names the constituent systems, the accountable one first. **Check** is how it would be verified: inspection of the model, analysis (calculation or simulation), or demonstration (a scenario walked through on the activity diagram). **Measure** is filled only where there is something to measure; a number appears only where a source gives it.

### Flight planning and release

Place on the trajectory-intent chain: mission plan -> flight plan.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-PLN-01 | The NAS shall produce for each scheduled flight a flight plan that states its route, cruise altitude, cruise speed and fuel load. | Functional | SN-AIR-01, SN-CRW-02 | Dispatcher | Inspection |  | [B] `berry2011aocActors` |
| SLR-PLN-02 | The NAS shall compute each flight plan from the planned take-off weight and the performance of the aircraft assigned to the flight. | Functional | SN-AIR-01 | AOC decision support (flight planning system); Load planner | Analysis |  | [B] `mori2022massCruise` |
| SLR-PLN-03 | The NAS shall select each flight plan's route, altitude and speed to minimize the airline's stated cost of fuel and flight time. | Performance | SN-AIR-01, SN-ENV-01 | AOC decision support (flight planning system) | Analysis | flight cost = fuel cost + cost index x flight time (USD per flight) | [B] `mori2022massCruise` |
| SLR-PLN-04 | The NAS shall load each flight with fuel to reach its destination, then its most distant alternate, then fly 45 minutes at normal cruise. | Constraint | SN-GOV-01, SN-PAX-01 | Dispatcher | Inspection | fuel remaining after destination and alternate (minutes at normal cruise). Value: 45 | [C] 14 CFR 121.639 |
| SLR-PLN-05 | The NAS shall release a flight only when the dispatcher and the captain both agree that it can be flown safely as planned. | Functional | SN-CRW-01, SN-GOV-01, SN-GOV-02 | Dispatcher; Flight deck crew | Inspection |  | [A] 14 CFR 121.533 |
| SLR-PLN-06 | The NAS shall file each flight plan with air traffic control before the flight departs. | Interface | SN-ATC-03 | Dispatcher; Air traffic control | Inspection |  | [A] `faa2025aim`, `faa2025jo72103ee` |
| SLR-PLN-07 | The NAS shall deliver the dispatch release, flight plan, weather, notices to airmen (NOTAMs) and load sheet to the flight crew before departure. | Interface | SN-CRW-02 | Dispatcher; Load planner | Inspection |  | [B] `seamster2011collabSystems` |
| SLR-PLN-08 | The NAS shall plan each flight to comply with the traffic management initiatives and special use airspace activations published for its time of flight. | Constraint | SN-ATC-02, SN-MIL-01 | Dispatcher; AOC ATC coordinator | Inspection |  | [A] `faa2025jo72103ee` |
| SLR-PLN-09 | The NAS shall assign to each flight a crew whose duty period, including forecast delay, stays within the limits of 14 CFR Part 117. | Constraint | SN-CRW-05, SN-GOV-01 | Crew scheduler | Inspection |  | [C] 14 CFR Part 117 |

### Traffic flow management

Place on the trajectory-intent chain: flight plan -> ATC constraints (before departure and strategic).

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-FLW-01 | The NAS shall forecast traffic demand against declared capacity for each airport and each constrained volume of airspace. | Functional | SN-ATC-02 | Command Center (ATCSCC); Traffic management unit | Inspection |  | [A] `faa2025jo72103ee` |
| SLR-FLW-02 | The NAS shall issue a traffic management initiative when forecast demand exceeds declared capacity. | Functional | SN-ATC-02, SN-ATC-04 | Command Center (ATCSCC) | Demonstration |  | [A] `faa2025jo72103ee` |
| SLR-FLW-03 | The NAS shall notify each affected airline of a traffic management initiative before its affected flights depart. | Interface | SN-AIR-03 | Command Center (ATCSCC); AOC ATC coordinator | Inspection |  | [A] `faa2025jo72103ee`, `berry2011aocActors` |
| SLR-FLW-04 | The NAS shall let an airline exchange its own flights among the departure slots it has been assigned. | Functional | SN-AIR-04 | Command Center (ATCSCC); AOC ATC coordinator | Demonstration |  | [A] `faa2025jo72103ee` |
| SLR-FLW-05 | The NAS shall assign the delay created by a traffic management initiative equitably among all airspace users. | Performance | SN-ATC-05 | Command Center (ATCSCC) | Analysis | assigned delay per flight, compared across airlines (minutes) | [A] `faa2025jo72103ee` |
| SLR-FLW-06 | The NAS shall release each flight that has an expect departure clearance time (EDCT) within the permitted window around that time. | Performance | SN-ATC-02, SN-ATC-03 | Control tower; Flight deck crew | Analysis | actual departure time minus EDCT (minutes) | [C] `faa2025jo72103ee` |
| SLR-FLW-07 | The NAS shall give traffic flow managers and airlines the activation schedule of special use airspace before the affected flight plans are filed. | Interface | SN-MIL-01, SN-AIR-03 | Command Center (ATCSCC) | Inspection |  | [C] |

### Clearance, separation and tactical trajectory change

Place on the trajectory-intent chain: ATC constraints -> trajectory negotiation.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-CLR-01 | The NAS shall keep each pair of controlled aircraft separated by at least the minimum that JO 7110.65BB sets for the airspace they are in. | Performance | SN-ATC-01, SN-PAX-01 | Air traffic control; En-route center (ARTCC); Terminal approach control (TRACON) | Analysis | lateral and vertical distance between each pair of aircraft (NM and ft) | [A] `faa2025jo711065bb` |
| SLR-CLR-02 | The NAS shall predict a loss of separation between controlled aircraft before it occurs. | Functional | SN-ATC-01 | ATC decision support | Analysis |  | [B] `engility2014tasarAlaska` |
| SLR-CLR-03 | The NAS shall give the controlling facility the position, altitude and identity of each controlled aircraft. | Interface | SN-ATC-01, SN-ATC-03 | Aircraft surveillance system; Air traffic control | Inspection |  | [SME] |
| SLR-CLR-04 | The NAS shall provide a two-way communication path between the controlling facility and the flight crew for the whole of controlled flight. | Interface | **DERIVED** from SLR-CLR-05, SLR-CLR-08, SLR-CLR-09 | Aircraft communication system; Air traffic control | Inspection |  | [SME] |
| SLR-CLR-05 | The NAS shall change a controlled aircraft's cleared route, altitude or speed only by a clearance from the facility that has control of that aircraft. | Functional | SN-GOV-02, SN-ATC-01 | Air traffic control | Inspection |  | [A] `faa2025jo711065bb` |
| SLR-CLR-06 | The NAS shall have the flight crew read back or acknowledge each clearance before acting on it. | Functional | **DERIVED** from SLR-CLR-01, SLR-CLR-05 | Flight deck crew; Air traffic control | Demonstration |  | [C] `seamster2011collabSystems` |
| SLR-CLR-07 | The NAS shall transfer control of an aircraft from one sector or facility to the next only after the receiving controller has accepted it. | Functional | **DERIVED** from SLR-CLR-01, SLR-CLR-05 | En-route center (ARTCC); Terminal approach control (TRACON); Control tower | Demonstration |  | [A] `faa2025jo711065bb` |
| SLR-CLR-08 | The NAS shall allow the captain to deviate from a clearance when safety requires it, with air traffic control told as soon as practical. | Functional | SN-CRW-01, SN-PAX-01 | Flight deck crew | Inspection |  | [A] 14 CFR 91.3 |
| SLR-CLR-09 | The NAS shall answer each flight crew request for a route, altitude or speed change with an approval, an amended clearance or a refusal. | Functional | SN-CRW-04, SN-AIR-01, SN-PAX-03 | Air traffic control; Flight deck crew | Demonstration |  | [B] `engility2014tasarAlaska` |
| SLR-CLR-10 | The NAS shall issue only clearances that the aircraft can fly at its current weight. **Not met today.** | Constraint | SN-CRW-03 | Air traffic control | Analysis |  | [B] `coppenbarger1999climbPrediction`, `engility2014tasarAlaska` |
| SLR-CLR-11 | The NAS shall issue holding instructions at least 5 minutes before the aircraft reaches its clearance limit when a delay is expected. | Performance | SN-CRW-03 | Air traffic control | Inspection | time between the holding instruction and arrival at the clearance limit (minutes). Value: 5 | [A] `faa2025jo711065bb`, `seamster2011collabSystems` |
| SLR-CLR-12 | The NAS shall resolve each predicted conflict with the fewest control instructions that restore separation. | Performance | SN-ATC-04 | Air traffic control | Analysis | instructions issued plus follow-up instructions, per conflict (count) | [B] `rantanen2012conflictManeuvers`, `kirwan2001coraStrategies` |
| SLR-CLR-13 | The NAS shall choose, among the maneuvers that restore separation with the same number of control instructions, the one with the lowest combined cost to the aircraft involved. **Not met today.** | Performance | SN-AIR-05, SN-ENV-01 | ATC decision support; Air traffic control | Analysis | sum over the aircraft involved of fuel cost plus cost index x time (USD per conflict) | [B] `schultz2012adaptiveClimb`, `mori2022massCruise` |
| SLR-CLR-14 | The NAS shall keep civil aircraft out of special use airspace while it is active, unless the using agency releases it. | Functional | SN-MIL-01 | Air traffic control | Inspection |  | [C] `faa2025jo711065bb` |

### Information for trajectory decisions

Place on the trajectory-intent chain: what the party making each decision must be given.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-INF-01 | The NAS shall give the sector controller the filed route, requested altitude and requested speed of each aircraft before it enters the sector. | Interface | SN-ATC-03 | Air traffic control; En-route center (ARTCC) | Inspection |  | [A] `faa2025jo711065bb` |
| SLR-INF-02 | The NAS shall give the party that decides a change to an aircraft's cruise altitude that aircraft's current gross weight. **Not met today.** | Interface | SN-AIR-05, SN-CRW-03 | Flight management system; Airline operations center; Air traffic control | Analysis |  | [B] `schultz2012adaptiveClimb`, `coppenbarger1999climbPrediction` |
| SLR-INF-03 | The NAS shall give the party that decides a change to an aircraft's cruise altitude or speed that flight's cost index. **Not met today.** | Interface | SN-AIR-05 | Flight management system; Airline operations center; Air traffic control | Analysis |  | [B] `schultz2012adaptiveClimb` |
| SLR-INF-04 | The NAS shall give the party that decides a delay or trajectory change for a flight the airline's connection priority for that flight. **Not met today.** | Interface | SN-AIR-05, SN-PAX-02 | Airline operations center; Command Center (ATCSCC); Air traffic control | Analysis |  | [SME] |
| SLR-INF-05 | The NAS shall disclose an airline's shared weight, cost index and connection priority only to the parties deciding that flight's trajectory. | Constraint | SN-AIR-06 | Air traffic control; Command Center (ATCSCC) | Inspection |  | [B] `schultz2012adaptiveClimb` |
| SLR-INF-06 | The NAS shall give the dispatcher and the flight crew the reported and forecast turbulence along the planned route. | Interface | SN-PAX-03, SN-CRW-02 | Airline operations center; Flight deck crew | Inspection |  | [C] `seamster2011collabSystems` |
| SLR-INF-07 | The NAS shall send the airline and the destination airport an updated arrival estimate whenever a flight's estimate changes by more than 5 minutes. | Interface | SN-AIR-02, SN-APT-01 | Flight management system; Flight deck crew; Airline operations center; Airport management system | Inspection | change in estimated arrival time that triggers an update (minutes). Value: 5 | [B] `seamster2011collabSystems` |
| SLR-INF-08 | The NAS shall label every exchanged flight plan, clearance, surveillance report and arrival estimate with one flight identifier and one time reference shared by all parties. | Interface | **DERIVED** from SLR-PLN-06, SLR-CLR-03, SLR-INF-01, SLR-INF-07 | Airline operations center; Air traffic control; Aircraft surveillance system | Inspection |  | [C] `faaFixmUsExtension2024` |

### Onboard execution

Place on the trajectory-intent chain: FMS intent -> guidance commands -> aircraft motion.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-EXE-01 | The NAS shall hold each flight's cleared route and altitudes in the flight management system as the path the aircraft's guidance follows. | Functional | SN-ATC-03 | Flight management system | Inspection |  | [SME] |
| SLR-EXE-02 | The NAS shall fly each aircraft along its cleared route and at its cleared altitude within the navigation and altitude tolerances of the airspace. | Performance | SN-ATC-03 | Auto flight control system; Flight management system | Analysis | cross-track distance from the cleared route; difference from the cleared altitude (NM and ft) | [SME] |
| SLR-EXE-03 | The NAS shall predict on board each flight's arrival time, fuel at destination, optimum altitude and maximum altitude from the aircraft's actual weight, the forecast wind and the cost index. | Functional | SN-AIR-01, SN-CRW-03 | Flight management system | Inspection |  | [SME] `mori2022massCruise` |
| SLR-EXE-04 | The NAS shall change an aircraft's flown trajectory only through flight deck controls operated by the flight crew. | Constraint | SN-CRW-01, SN-GOV-02 | Flight deck controls; Flight deck crew | Inspection |  | [SME] 14 CFR 91.3 |
| SLR-EXE-05 | The NAS shall determine each aircraft's position on board with the accuracy its cleared route requires. | Performance | **DERIVED** from SLR-EXE-02, SLR-CLR-03 | Navigation system | Inspection |  | [SME] |
| SLR-EXE-06 | The NAS shall alert the flight crew when the fuel predicted at the destination falls below the required reserve. | Functional | SN-PAX-01, SN-CRW-02 | Flight management system | Inspection |  | [SME] |

### Airport and surface

Place on the trajectory-intent chain: start and end of the chain on the ground.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-APT-01 | The NAS shall assign each arriving flight a gate before it lands. | Functional | SN-APT-01, SN-AIR-02 | Airport management system | Demonstration |  | [C] |
| SLR-APT-02 | The NAS shall sequence arrivals and departures so that each runway is used at its declared rate whenever demand is at or above that rate. | Performance | SN-APT-02, SN-ATC-02 | Terminal approach control (TRACON); Control tower | Analysis | runway operations per hour against the declared rate (operations per hour) | [A] `faa2025jo72103ee` |
| SLR-APT-03 | The NAS shall hold a flight that has a known departure delay at its gate with engines off, not in a taxiway queue. | Functional | SN-APT-03, SN-ENV-01 | Control tower; Airline operations center | Demonstration |  | [C] |
| SLR-APT-04 | The NAS shall have each aircraft fuelled, loaded and closed up by its scheduled off-block time. | Performance | SN-AIR-02 | Ground handling; Fuel distribution system; Flight deck crew | Demonstration | actual off-block time minus scheduled off-block time (minutes) | [B] `schultz2017turnaround` |
| SLR-APT-05 | The NAS shall assign departure and arrival procedures that follow the airport's published noise abatement procedures. | Constraint | SN-ENV-02 | Control tower; Terminal approach control (TRACON); Dispatcher | Inspection |  | [B] `seamster2011collabSystems` |

### Measurement and records

Place on the trajectory-intent chain: back up the chain: what is reported to the authorities and stakeholders.

| ID | Requirement | Kind | Traces to | Allocated to | Check | Measure | Basis |
|---|---|---|---|---|---|---|---|
| SLR-MEA-01 | The NAS shall record each dispatch release, clearance and traffic management initiative with the authority that issued it and the time. | Functional | SN-GOV-02 | Dispatcher; Air traffic control; Command Center (ATCSCC) | Inspection |  | [A] `faa2025jo72103ee` |
| SLR-MEA-02 | The NAS shall report the fuel burned and the CO2 emitted by each flight, at 3.16 kg of CO2 per kg of fuel. | Performance | SN-ENV-01, SN-AIR-01 | Flight management system; Airline operations center | Analysis | CO2 emitted per kg of fuel burned (kg CO2 per kg fuel). Value: 3.16 | [A] `icao2024icecMethodology` |
| SLR-MEA-03 | The NAS shall report each flight's gate arrival time against its scheduled arrival time. | Functional | SN-AIR-02, SN-PAX-02 | Airline operations center | Analysis | gate arrival time minus scheduled arrival time (minutes) | [C] |
| SLR-MEA-04 | The NAS shall report the delay each flight received from traffic management initiatives, by airline. | Functional | SN-ATC-05 | Command Center (ATCSCC) | Analysis | assigned delay per flight (minutes) | [C] |

## 5. Derived system requirements and why each exists

A derived requirement has no stakeholder behind it. It is there because of a design choice, or because other system requirements cannot be met without it. Each one names those other requirements.

**SLR-CLR-04.** The NAS shall provide a two-way communication path between the controlling facility and the flight crew for the whole of controlled flight.

- Needed by: SLR-CLR-05, SLR-CLR-08, SLR-CLR-09.
- Why it exists: No stakeholder asks for a radio or a datalink. It exists because a clearance (SLR-CLR-05), a notice of an emergency deviation (SLR-CLR-08) and a crew request (SLR-CLR-09) all have to cross between the ground and the flight deck. Without it none of the three can be met.

**SLR-CLR-06.** The NAS shall have the flight crew read back or acknowledge each clearance before acting on it.

- Needed by: SLR-CLR-01, SLR-CLR-05.
- Why it exists: A clearance that is misheard is flown as a different trajectory from the one the controller separated. The read-back is the check that the clearance issued and the clearance received are the same. Without it SLR-CLR-01 rests on an unchecked message. No stakeholder states this as a need; it follows from choosing voice and datalink messages as the way SLR-CLR-05 is carried out.

**SLR-CLR-07.** The NAS shall transfer control of an aircraft from one sector or facility to the next only after the receiving controller has accepted it.

- Needed by: SLR-CLR-01, SLR-CLR-05.
- Why it exists: A controller's authority ends at the sector boundary (knowledge/models/stakeholder-personas.md, Air Traffic Controller, Decision authority). A flight crosses many sectors, so without an accepted handoff there would be a stretch where no facility is accountable for its separation, which breaks SLR-CLR-05. It follows from dividing the airspace into sectors, which is a design choice and not a stakeholder need.

**SLR-INF-08.** The NAS shall label every exchanged flight plan, clearance, surveillance report and arrival estimate with one flight identifier and one time reference shared by all parties.

- Needed by: SLR-PLN-06, SLR-CLR-03, SLR-INF-01, SLR-INF-07.
- Why it exists: The plan, the clearance, the surveillance track and the arrival estimate are produced by different systems. Unless they name the flight and the time in the same way, the receiving party cannot tell that they describe the same aircraft. No stakeholder asks for this; it is a property the exchanges need once four systems are involved. faaFixmUsExtension2024 is a candidate source and has not been checked for this point.

**SLR-EXE-05.** The NAS shall determine each aircraft's position on board with the accuracy its cleared route requires.

- Needed by: SLR-EXE-02, SLR-CLR-03.
- Why it exists: An aircraft cannot stay on a cleared path (SLR-EXE-02) or report where it is (SLR-CLR-03) unless it knows its own position. No stakeholder asks for navigation as such; both of those requirements fail without it. The ground navigation aids it may use are Infrastructure, a context constraint under D-007, so only the onboard function is required here.

## 6. Notes on individual system requirements

Requirements that trace to a stakeholder but carry a caution: a number not yet confirmed, a threshold left open, or a statement that today's system does not meet.

- **SLR-PLN-02**: The cost-optimal altitude depends on mass (mori2022massCruise, Figure 1), so a plan built on a nominal weight is not the lowest-cost plan for the aircraft that flies it.
- **SLR-PLN-04**: Number and paragraph are from general knowledge of the domestic fuel supply rule. Confirm against 14 CFR 121.639 before baselining.
- **SLR-PLN-06**: No lead time is set. The summary of faa2025aim records a 45 to 46 minute point before departure after which a filed plan is locked; whether that is the right threshold here is the owner's call.
- **SLR-FLW-04**: JO 7210.3EE paragraph 18-10-12.
- **SLR-FLW-05**: JO 7210.3EE paragraph 18-10-2. What counts as equitable is not quantified in this draft.
- **SLR-FLW-06**: The window is commonly given as 5 minutes before to 5 minutes after the EDCT. That figure is from general knowledge and is left out of the threshold until it is confirmed against JO 7210.3EE or JO 7110.65BB.
- **SLR-CLR-01**: A hard constraint, not something to trade (knowledge/models/experiment-definition.md section 6). For en-route radar the minimum is commonly 5 NM or 1,000 ft; those numbers are from general knowledge and are left out of the threshold until the paragraph is confirmed.
- **SLR-CLR-02**: No look-ahead time is set. engility2014tasarAlaska page 9 uses an eight-minute probe in its own model, which is a candidate.
- **SLR-CLR-10**: Not fully met today. The ground system assumes one nominal weight per aircraft type (coppenbarger1999climbPrediction), and the crew answers 'unable' when a clearance cannot be flown. The rule in D-013 (offer a climb only at or below FL350) stands in for the missing weight. Depends on SLR-INF-02.
- **SLR-CLR-11**: JO 7110.65BB paragraph 4-6-1, as recorded in evidence/literature-notes/annotations/seamster2011collabSystems-bb-rules.csv.
- **SLR-CLR-13**: Not met today, because the party choosing the maneuver lacks the inputs in SLR-INF-02 and SLR-INF-03. The experiment in knowledge/models/experiment-definition.md measures what meeting it is worth. Whether this belongs in the baseline or is a proposed improvement is the owner's call.
- **SLR-INF-02**: Not met today: the controller does not receive weight (schultz2012adaptiveClimb, page 2). This is case C of the experiment (knowledge/models/experiment-definition.md section 4). Which party should hold the decision, and so receive the weight, is still open in knowledge/questions/open-questions.md.
- **SLR-INF-03**: Not met today (schultz2012adaptiveClimb, page 2). Case C of the experiment.
- **SLR-INF-04**: Case D of the experiment (D-014 item 4). Cost index understates a connection-critical flight. The supporting dispatcher-ratings paper (Sheth et al.) is held in evidence/sources/ but is not yet registered, so no key is cited.
- **SLR-INF-07**: The 5 minutes is the crew-to-dispatch practice in seamster2011collabSystems (survey item: notify dispatch of ETA changes greater than 5 minutes). Extending the same trigger to the airport is this draft's proposal, not the source's.
- **SLR-EXE-02**: No tolerance is set. It depends on the navigation specification of the route, which the scenario has not chosen.
- **SLR-EXE-03**: This is the item FmsPerformancePrediction in nas_sysml_package_definitions.sysml. It is the source of what SLR-INF-02 would share.
- **SLR-EXE-04**: D-012: the crew acts through the flight deck controls. No ground party commands the aircraft directly, which is what keeps the captain's authority real.
- **SLR-MEA-02**: icao2024icecMethodology page 6, accepted in D-015. The number is a conversion factor, not a limit.
- **SLR-MEA-03**: A flight is commonly counted on time within 15 minutes of schedule. That figure is from general knowledge and is left out of the threshold until it is sourced.
- **SLR-MEA-04**: SLR-FLW-05 cannot be checked without it.

## 7. Objectives with no requirement

Rows of `knowledge/models/stakeholder-objective-ontology.md` that no stakeholder requirement picks up, and the reason.

| Category | Objective rows | Why not carried |
|---|---|---|
| Airline | Crew cost; Maintenance; Revenue; Dispatch reliability | The ontology's own 'Trajectory impact' column marks these Indirect, and its abstraction comment keeps them at schedule level or as boundary inputs. Crew duty limits are picked up through SN-CRW-05. |
| Passenger | Ticket price; Schedule convenience | Ticket price is marked 'No' trajectory impact; schedule convenience is set when the timetable is designed. |
| Airport | Passenger throughput | Marked 'No' trajectory impact: a terminal process. |
| Environmental / Societal | NOx; Contrail/climate effects; Local air quality | The ontology calls this table the least grounded, and no source is held. D-015 notes the altitude link to non-CO2 effects still needs a source. Left out, not judged unimportant. |
| Military | Mission effectiveness; Mission timing; Fuel availability; Operational security; Resilience | D-007 makes military operations a boundary actor. Only 'Airspace access' crosses into the civil system. |

## 8. What became of the earlier placeholders

The two requirement files held ten needs and six system requirements written on 2026-09-19 as placeholders. They are replaced. The old text is in git history.

| Earlier placeholder | Now | Reason |
|---|---|---|
| SN-001 regulatory compliance | SN-GOV-01 | Kept, narrowed to operating rules and air traffic orders. |
| SN-002 support new regulations | not carried | D-007 holds regulation fixed in the baseline. |
| SN-003 efficient and reliable air traffic management | SN-AIR-01 to SN-AIR-05 | Split: one sentence held five separate things an airline wants. |
| SN-004 controller situational awareness and decision support tools | SN-ATC-03, SN-ATC-04 | Restated as the need. Decision support tools are a solution, owned per actor under D-012. |
| SN-005 coordination between ATC centers | SLR-CLR-07 (derived) | Coordination between centers follows from dividing the airspace into sectors; it is a derived system requirement, not a stakeholder need. |
| SN-006 platform for new aircraft and engine technology | not carried | Manufacturers are not in the seven categories of knowledge/models/stakeholder-objective-ontology.md and have no row in D-007. The group stays in the schema, empty, in case the owner wants it back. |
| SN-007 airport operations support | SN-APT-01 | Kept, restated as reliable times. |
| SN-008 flight crew decision support | SN-CRW-02, SN-CRW-03 | Restated as the need. |
| SN-009 passenger safety and comfort | SN-PAX-01, SN-PAX-03 | Split into safety and ride comfort. |
| SN-010 environmental data and insight | SN-ENV-01, SN-ENV-02, SLR-MEA-02 | The need is low CO2 and noise; reporting data is the system requirement. |
| SLR-001 real-time monitoring and control | SLR-CLR-01, SLR-CLR-03 |  |
| SLR-002 controller-pilot communication | SLR-CLR-04 (derived) |  |
| SLR-003 navigation aids | SLR-EXE-05 (derived) | Ground navigation aids are Infrastructure, a context constraint under D-007. |
| SLR-004 surveillance | SLR-CLR-03 |  |
| SLR-005 coordination between ATC centers | SLR-CLR-07 (derived) |  |
| SLR-006 conflict detection and resolution | SLR-CLR-02, SLR-CLR-12, SLR-CLR-13 |  |

## 9. Open items for the owner

1. **Read every requirement and change the wording.** The statements are Claude's. The judgment about what each stakeholder actually wants is the owner's, and so is the defence of it.
2. **Subject of the system requirements.** Each one says "The NAS shall", with the constituent systems named in the allocation. The alternative is to make the constituent system the subject ("Air traffic control shall"). That reads more directly but turns these into requirements on the domains, which `projects/nas-sos-capstone/cameo_models/sysmlv2_exploration.md` section 4 treats as the next level down.
3. **Are the 5 requirements that are not met today requirements, or proposals?** SLR-CLR-10, SLR-CLR-13, SLR-INF-02, SLR-INF-03, SLR-INF-04 describe an improved system, not the current one. If the requirements model is meant to describe the current NAS, they belong in a separate "proposed" set. This ties to the central claim still open in `knowledge/models/experiment-definition.md` section 1.
4. **Two stakeholder requirements pull against each other on purpose.** SN-AIR-05 asks that the airline's priorities be used; SN-AIR-06 asks that the data carrying them be kept from competitors. SLR-INF-05 is the proposed reconciliation.
5. **Two objective rows are proposed for `knowledge/models/stakeholder-objective-ontology.md`:** protection of shared airline data (Airline), and safety (Passenger). SN-AIR-06 has no matching row at all. SN-PAX-01 borrows the Airline row "Flight Safety" because the Passenger table has no safety row. Both stay that way until the rows are added or the requirements are dropped. The ontology file was not edited.
6. **Governance has no objective table** in `knowledge/models/stakeholder-objective-ontology.md`. SN-GOV-01 and SN-GOV-02 trace to the enterprise objective hierarchy in `knowledge/models/stakeholder-register.md` instead.
7. **Numbers to confirm before baselining.** 45 minutes of reserve fuel (SLR-PLN-04, 14 CFR 121.639) is set as a threshold from general knowledge. Left out of the thresholds on purpose and mentioned only in the notes: the EDCT window (SLR-FLW-06), en-route separation of 5 NM or 1,000 ft (SLR-CLR-01), on time within 15 minutes (SLR-MEA-03), a filing lead time (SLR-PLN-06), a conflict look-ahead time (SLR-CLR-02), path conformance tolerances (SLR-EXE-02).
8. **Requirements graded [C]** rest on general knowledge and need a source or the owner's [SME] statement. System: SLR-PLN-04, SLR-PLN-09, SLR-FLW-06, SLR-FLW-07, SLR-CLR-06, SLR-CLR-14, SLR-INF-06, SLR-INF-08, SLR-APT-01, SLR-APT-03, SLR-MEA-03, SLR-MEA-04. Stakeholder, graded [C] or [SME]: SN-AIR-02, SN-APT-01, SN-APT-02, SN-APT-03, SN-CRW-03, SN-CRW-05, SN-PAX-01, SN-PAX-02, SN-PAX-03, SN-ENV-01, SN-ENV-02, SN-MIL-01.
9. **Requirements graded [SME]** were written on the assumption that the owner can vouch for them from industry experience. Confirm or strike: SLR-CLR-03, SLR-CLR-04, SLR-INF-04, SLR-EXE-01, SLR-EXE-02, SLR-EXE-03, SLR-EXE-04, SLR-EXE-05, SLR-EXE-06.
10. **Allocation is a first proposal.** In particular SLR-INF-02 to SLR-INF-04 are allocated to the sender (flight management system or AOC) and to air traffic control as the receiver, which assumes the controller stays the party that decides. `knowledge/questions/open-questions.md` still asks which block should own that.
11. **Manufacturers** have no requirements. The earlier placeholder SN-006 was not carried over.
12. **Cabin crew, general aviation, cargo and international operations** have no requirements, following D-007.

## 10. Coverage check

Run when these files were generated on 2026-10-10:

- Stakeholder requirements with no system requirement: 0 of 27.
- System requirements with neither a stakeholder parent nor a rationale: 0 of 53.
- System requirements with no allocation: 0 of 53.
- Objective rows named that do not exist in `knowledge/models/stakeholder-objective-ontology.md`: 0.
- Source keys named that do not exist in `evidence/sources/references.bib`: 0.
- `syside check` over the whole `projects/nas-sos-capstone/cameo_models/` folder: no errors.
