# Defining the SOI

**Status: ratified 2026-09-21; see D-007 in `decisions/decisions-log.md`.**

This document is the scope baseline for the NAS-as-SoS capstone. The System of
Interest is bounded around the lifecycle of trajectory intent:

```
Enterprise objective -> mission/flight plan -> ATC constraints -> negotiated trajectory
-> FMS intent -> guidance commands -> aircraft motion
```

## Ratified boundary

Include an entity as a **modeled system** when it has distinct decision authority or
execution behavior that is dynamically coupled to in-scope decisions and materially
affects cost, safety, workload, schedule reliability, or passenger value. Treat an
entity as a **boundary actor** when it supplies objectives, demand, feedback, or rules
without being decomposed as a decision mechanism. Treat an influence as a **context
constraint** when it is externally determined and enters the analysis as a parameter or
scenario condition. **Absorb or abstract** a capability when its internal structure is
not itself a decision variable, while preserving its effects as information, cost, or
performance attributes.

| Candidate | Project Action | Ratified disposition |
|---|---|---|
| Governance / Regulatory and Legal | Boundary Actor | Sets the rules and societal/environmental policy context. Held fixed in the baseline; regulatory sensitivity sweeps are optional. |
| Airspace Management / ATC | Modeled System | Directs traffic through clearances and flow-management actions; coupled to trajectory intent, safety, and workload. |
| Airport Operations | Modeled System | Airport-side turnaround, gate, ground-handling, and control activities affect capacity, schedule reliability, safety, and passenger value. |
| Flight Operations | Modeled System | Part 121 scheduled passenger operators are modeled because dispatch, scheduling, routing, and recovery decisions are coupled to the selected KPIs. Other traffic is background input when KPI-relevant. |
| Aircraft Systems | Modeled System | Aircraft state and onboard systems are the execution endpoint of the trajectory-intent chain. |
| Flight Crew | Modeled System | Crew have independent execution authority and handle information between operational intent, clearances, guidance, and aircraft behavior. |
| Passengers | Boundary Actor | Demand, willingness to pay, passenger mix, and time sensitivity influence airline choices about fares, frequency, aircraft assignment, connections, and delay/rerouting tradeoffs. RPM measures passenger traffic and airline output; affordability, schedule reliability, and satisfaction are value measures. Passengers do not directly set fares or aircraft speed; airline decisions mediate those effects. |
| Military | Boundary Actor | Military operations are outside the modeled operator population; military traffic and special-use airspace enter as external scenario conditions when civil KPIs require them. |
| Information Systems | Absorbed / Abstracted | Information is modeled as exchanges; specific channels are included only when reliability, latency, or capability changes a decision or KPI. |
| Infrastructure / Airspace Resources | Context Constraint | Airspace structure, navigation infrastructure, and shared resources are external baseline constraints, with optional parameterized sensitivity analysis. |
| Maintenance Suppliers | Context Constraint | Supplier-side cost, availability, and turnaround effects are exogenous parameters; airline maintenance decisions remain within Flight Operations. |
| Decision Support | Absorbed / Abstracted | Decision-support capability is allocated to operator or ATM contexts; recommendations and information dependencies remain modelable. |

## Included and excluded scope

The seven modeled-system or boundary-actor rows above are included at an abstraction
sufficient to trace authority, information, decisions, and KPI effects. The project
does not decompose passengers, regulators, military operations, suppliers, information
services, infrastructure, or decision support into independent internal systems.
General aviation, scheduled cargo, international airspace, and military operations are
outside the modeled operator population, but may appear as background traffic or
constraints when omitting them would materially distort a selected KPI. This is an
analytical boundary, not a claim that those activities are unimportant to the real NAS.

## Levels of abstraction

The architecture links three levels without attempting equal detail at each: (1)
enterprise and stakeholder objectives, policies, demand, and value measures; (2)
operational decisions by airline/dispatch, airport, ATC/ANSP, and crew; and (3)
aircraft state, FMS intent, guidance, and resulting motion. Subsystem detail is added
only when it changes authority, information flow, a decision, or a selected KPI.

The system boundary and stakeholder boundary are related but not identical: passengers
and regulators are boundary actors, while flight crew and aircraft systems are modeled
because their decisions and execution behavior are central to the trajectory-intent
chain.

This file documents the definition of and rationale for the System of Interest (SOI).
Constructed from several brainstorming sessions, themselves informed by the literature
reviewed, and formulated from the perspective of including systems of the NAS that have
the potential to influence the value perceived or attained by the stakeholders defined in
[stakeholder-register.md](stakeholder-register.md).

## Method

The working spreadsheet
([system_of_interest_exploration.xlsx](system_of_interest_exploration.xlsx)) lists
candidate systems and sub-systems bottom-up, each with a short inclusion/exclusion
rationale, then groups them under eight top-level headings. Sub-elements were kept when
their rationale ties them to *decisions inside this project's scope* (trajectory-intent
propagation, turnaround/dispatch tradeoffs, airspace flow) or to *safety/value effects*
those decisions could not otherwise account for.

The [candidate-systems-inventory.md](candidate-systems-inventory.md) collects a list of possible systems into nine functional domains
(Governance · Airspace Management · Airspace Resources · Flight Operations · Airport
Operations · Aircraft Systems · Information Services · Infrastructure · Decision
Support). Those domains  organizes systems basd on *what the NAS does*, functionally; this one organizes
*who/what holds authority or incurs value/cost*, as a check against the stakeholder
register. 
## Historical draft (superseded)

The material below is retained as provenance from the pre-ratification exploration. It
is not the current SOI definition; the ratified boundary and project actions above take
precedence.

### 1. Aircraft

Included because aircraft state and behavior is the terminus of the trajectory-intent
chain this project traces. Not every aircraft sub-system carries equal weight:

- **Included, active in decisions:** avionics and comms that carry Dispatcher/ATC ↔
  crew/aircraft information exchange (ADS-B, radios, datalink, radar, TCAS), and the
  Flight Management System (drives trajectory optimization, must stay aligned with
  aircraft performance).
- **Included, but as a cost/safety constraint rather than a decision lever:**
  propulsion (usage incurs fuel/maintenance cost; FADEC must keep thrust reliable),
  airframe and flight control system (maintenance state and control-surface integrity
  affect safety and fuel performance, but aren't themselves manipulated by the
  operational decisions in scope — e.g. fleet-level airframe choices happen upstream).
- **Excluded:** Weapon System (not relevant to civil NAS operations); Pitot-Static
  System (safety- and maintenance-relevant but "set & forget" — not involved in the
  value tradeoffs this project models); Cabin Entertainment System and Cockpit Data
  System (not relevant themselves, though their *separation* from the cockpit network
  is a safety-relevant interface worth keeping in mind); Fuel System internals (Fuel
  Quantity Processing System safety criticality and CG effects noted, but not impacted
  by decisions in this project's focus).

### 2. Flight Crews

Included because flight crews take the actions that actually control the aircraft
toward (or away from) the objective — the direct execution layer between
intent/guidance and aircraft motion. Covers Captain, First Officer, and Remote Pilot;
Cabin Crew is included as the intermediate interface between flight crew and passengers,
not as an aircraft-control role.

### 3. Passengers

Included, minimally, as the endpoint whose choices are shaped by the other systems in
this SOI and which in turn feed back into MOPs/MOEs (e.g. schedule reliability,
affordability). Not modeled with the same internal structure as the other seven systems
— passengers are a boundary actor, not a system this project decomposes further.

### 4. Regulatory / Legal

Included as the authority layer that sets the rules the rest of the SOI operates under.
Covers governments (hold hearings after safety events, fund and empower regulatory
bodies), industry groups (set policy/SOP, influence regulation, fund initiatives), and
named regulators/standards bodies (FAA, EASA, CAAC, ICAO). Environmental/climate
advocacy is included under this heading because its influence on the SOI is exerted
*through* the regulatory environment (carbon offsets, net-zero pressure) rather than as
a direct operational actor. Customs & Immigration is called out but excluded — not
relevant to the trajectory-intent chain this project traces.

### 5. Airports

Included because airport-side management and turnaround services directly affect both
safety and the timeliness that feeds operational decisions upstream (e.g. dispatch
tradeoffs, schedule recovery). Covers ground handlers, fuel distribution, baggage
handling, and food suppliers (turnaround-time and passenger-experience effects), plus
the APRON/Control Tower function (gates, taxi, takeoff & landing) as the piece that
interfaces directly with crews on the ground.

### 6. Operators

Included as the primary economic actor — airline profitability is treated as the
dominant driver of airspace-use considerations in this project's framing. Within
"Operators":

- **Included:** the Airline itself (business/commercial side, operations centers,
  pilots as an employment relationship, dispatchers), and IT & cybersecurity (the
  comms mechanism choice — radio vs. ACARS vs. other — determines the crew/aircraft
  interface, so it's in scope as an enabler of that interface).
- **Excluded:** General Aviation (airspace-use influence noted but not modeled);
  Militaries (real special-handling needs exist, but they aren't worth modeling
  because properly-equipped military traffic tends to receive priority handling
  regardless); Ticketing (possible link to fares/passenger choice, but judged not
  worth including).

### 7. Air Traffic Control

Included as the system that directly enacts safe and optimal airspace/vehicle control —
the other half of the crew/ATC information-exchange loop that Aircraft's avionics
carry. Covers ANSPs/IATOs (policy-setting and upgrade funding for airspace governance),
TRACON (departure/arrival) and ARTCC (en-route) as the facilities that interface with
crews, ATCSCC and Facility Traffic Management Units, Ground Delay Programs, the Air
Traffic Flow Management systems (ETMS, TBFM, AMAN, XMAN — each justified by its effect
on arrival-rate assumptions, traffic flow, or capacity/optimality), individual Air
Traffic Controllers, and National Managers of Tactical Operations (set daily
initiatives like en-route metering and coordinate across centers on weather/etc.).


## Excluded as content, not channel: SWIM and Weather

[candidate-systems-inventory.md](candidate-systems-inventory.md) names SWIM (System Wide
Information Management) and Weather Service as systems in their own right. Both are
excluded here, on a test distinct from the exclusions above: they supply *information
content* that reaches actors through comms/avionics systems already in the SOI (VHF/UHF,
SATCOM, ACARS, datalink), rather than being a lever any modeled decision manipulates.
Modeling which specific source a given actor's weather or SWIM data came from (e.g.
dispatcher internet-sourced radar vs. crew text reports vs. an aircraft's ND weather
overlay) would add channel-level detail without changing any MOP/MOE this project
tracks — the information's *effect* on a decision shows up the same way regardless of
delivery path.

Note the asymmetry underneath that shared conclusion: Weather is an exogenous
environmental input nobody owns, while SWIM is an actual NAS-owned system with its own
governance and failure modes. They exclude for the same reason only at this project's
abstraction level (information exists and reaches an actor; the pipe doesn't matter). If
a ConOps scenario ever turns SWIM reliability/latency itself into a decision variable,
that would pull it into scope the same way FMS is in scope — same escape hatch as the
Militaries exclusion above. For instance, trans-oceanic flight results in portions of
the flight where radio communication and contact with ground-based navigation systems
is no longer available. A dispatcher may choose to route the aircraft to fly along coastal 
land masses to maintain a specific set of interfaces w/a threshold of reliability. However, 
doing so would sacrifice huge amounts of time, fuel, and logistics. 


## Provenance

The historical draft was developed 2026-09-13 from
[system_of_interest_exploration.xlsx](system_of_interest_exploration.xlsx). The
ratification reconciles that exploration with the candidate-systems inventory, the
stakeholder register, and the boundary review recorded in D-007.
