# Defining the SOI

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
## The eight systems

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

### 8. Maintenance Suppliers

Included, narrowly, as the actor that sets the cost of engine maintenance and overhaul
— a cost input to the operator-side tradeoffs this project models, not a system this
project decomposes further.

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
Militaries exclusion above.

## Boundary calls worth flagging

These are exclusions or ambiguous inclusions from the spreadsheet worth surfacing
explicitly, in case a reviewer (or a later session) would draw the line differently:

- **Airframe / Flight Control System** are nominally "included" under Aircraft for
  safety reasons but are explicitly *not* levers this project's decisions act on —
  worth double-checking this doesn't quietly smuggle unmodeled complexity into the
  aircraft-level SOI boundary.
- **Militaries** are excluded from Operators on the assumption that priority handling
  makes their special needs a non-issue for this project's scope — this is an
  assumption, not a verified fact, and should be revisited if military-airspace
  interaction becomes relevant to a ConOps scenario (see [[open-questions]]).
- **IT & Cybersecurity** sits oddly under Operators (it's really a cross-cutting
  concern touching Aircraft, ATC, and Airports too, via the comms channel) — flagged
  here rather than resolved, since forcing it into one of the eight would misrepresent
  it.
- **Ticketing** is excluded but the rationale ("probably not worth including") is the
  weakest-justified exclusion in the set — low risk either way, but noted rather than
  silently dropped.

## Status

Drafted 2026-09-13 from
[system_of_interest_exploration.xlsx](system_of_interest_exploration.xlsx). Not yet
reconciled line-by-line against [[candidate-systems-inventory]]'s nine-domain cut or
against the seven-stakeholder set used in [[stakeholder-objective-ontology]] — next step
is to confirm all three groupings agree on membership before this feeds §10 architecture
work.
