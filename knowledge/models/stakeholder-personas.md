# Stakeholder Personas

_Human-level personas for the actors who actually appear in ConOps scenarios
([[conops-scenarios]]) and drive decisions in the trajectory-intent chain
([[project-brief]]). This sits between [[stakeholder-register]] (the PESTLE inventory —
who exists and their general interest) and the ConOps ([[conops-scenarios]]) — a persona
gives a PESTLE row enough concrete detail (goals, authority, information, constraints) to
actually write a scenario step or a RACCI row against it._

## Discipline rule — why this file exists

The point of this file is to stop stakeholder analysis from turning into a list of
generic roles with no analytical work behind them. **Every persona below must satisfy
both:**

1. **Traces to a [[stakeholder-register]] row.** If a persona doesn't map to an existing
   PESTLE entry, either it belongs in the register first, or it's not actually in scope —
   don't invent a persona and backfill the register to match.
2. **Appears in an actual [[conops-scenarios]] scenario/phase**, or is clearly slated to.
   A persona with no scenario use is a flag, not a finished entry — mark it "not yet used"
   rather than deleting it (it may get used once more scenarios are drafted), but don't
   let the roster grow faster than the scenarios that need it.

This is also where the "stakeholder/actor boundary" open question
([[open-questions]], "System boundary" section) gets worked in practice: e.g., is
"Captain" a different persona from "First Officer"? Is "Enroute controller" different
from "Tower controller"? Split a persona only when the scenario or RACCI work actually
needs the distinction (different authority, different information, different decision) —
not by default.

## Persona template

```
### <Persona name — role title>

**Parent / group:** <organization or unit this role sits in, per the 2026-09-20 role trees>
**Traces to (PESTLE, [[stakeholder-register]]):** <row(s) this persona instantiates>
**Traces to (§8 objective category):** <Airline | Passenger | ATC/ANSP | Airport |
Flight Crew | Environmental/Societal | Military — per to-do §8>
**Appears in ([[conops-scenarios]]):** <scenario name(s)/phase(s), or "not yet used">

**Who they are:** <1-2 sentences>
**Goals:** <what they're trying to accomplish>
**Responsibilities:** <what they're on the hook for>
**Decision authority:** <what they can decide alone vs. must escalate/coordinate — feeds
RACCI, to-do §7>
**Information needs (inputs):** <what they need to know, from whom>
**Information produced (outputs):** <what they generate, for whom>
**Constraints:** <regulatory, procedural, workload, equipment>
**What "optimal" looks like to them (draft §8 input):** <their local objective(s)>
**Typical friction / pain point:** <where their goals conflict with another persona's —
raw material for §9 myopic-optimization analysis>
**Materially different from parent?** <the objective, constraint, decision authority,
information requirement, or MOP/MOE that differs from the parent group's — if none,
fold this role into the parent persona instead of filling this out>
**Notes:** <open issues, literature to check once §2-4 annotation reaches this role>
```

## Personas

### Line Pilot (Captain, Part 121 scheduled operations)

**Traces to (PESTLE):** "Flight crews" (Social)
**Traces to (§8):** Flight Crew
**Appears in:** not yet used — candidate for the nominal domestic flight scenario
(flight-execution and turnaround phases)

**Who they are:** Pilot-in-command of a scheduled airline flight; final authority for the
safety of the flight once the aircraft is under their command.
**Goals:** Complete the flight safely, on schedule, within fuel/weight/regulatory limits, as optimal
as possible so as to maintain parity with colleagues w/in airline, with minimal passenger/crew disruption.
**Responsibilities:** Accept or reject the dispatch release and flight plan; brief the
crew; manage the aircraft through all flight-execution phases (preparation and pushback through gate
arrival); make in-flight safety and routing decisions; comply with ATC clearances, handle
passenger disturbances.
**Decision authority:** Final authority over the conduct of the flight (14 CFR 91.3-style
authority) — can deviate from clearance/plan for safety; shares authority with dispatch
under Part 121 "joint responsibility" for release/en route decisions; must accept ATC
instructions unless safety requires deviation.
**Information needs (inputs):** Dispatch release, flight plan, weather/NOTAMs, weight and
balance/loadsheet, ATC clearances, aircraft system status.
**Information produced (outputs):** Acceptance of release, position/status reports,
deviation requests, PIREPs, post-flight aircraft/maintenance writeups.
**Constraints:** FARs, company operating procedures, duty-time/rest rules, aircraft
performance limits, ATC clearance compliance.
**What "optimal" looks like to them (draft):** Safety first; secondarily, schedule
adherence and passenger/crew workload — not fuel cost or network-level efficiency, which
are dispatch's/airline's concern more than the Captain's.
**Typical friction / pain point:** Dispatch/company pressure toward fuel- or
schedule-optimal routing vs. the Captain's more conservative safety margin; ATC-assigned
routing/altitude that doesn't match the flight-planned "optimal" trajectory.
**Notes:** Draft/illustrative — refine against flight-dispatch and disruption-management
literature once to-do §4 annotation reaches pilot/dispatcher shared-responsibility
sources.

**Source mapping (Seamster et al. 2011 → this persona):** source role FD *Captain* — identical (renamed). Abstraction: the source's Pilot Flying / Pilot Monitoring are task states that swap between Captain and First Officer, so they are folded into Captain/First Officer rather than kept as separate personas; why: final authority attaches to the Captain, not to PF/PM (fails the "materially different" test). Confidence high on the identity, medium on the PF/PM fold. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Air Traffic Controller (Enroute, ARTCC sector)

**Traces to (PESTLE):** "Air traffic controllers" (Technical)
**Traces to (§8):** ATC/ANSP
**Appears in:** not yet used — candidate for the nominal domestic flight scenario
(enroute portion of flight execution) and the international-boundary scenario
(sector-to-sector/ANSP handoff)

**Who they are:** FAA controller responsible for separation and traffic flow within one
enroute sector.
**Goals:** Maintain safe separation, keep traffic flowing predictably, manage sector
workload/complexity within acceptable bounds.
**Responsibilities:** Issue clearances (altitude, route, speed) within the sector;
coordinate handoffs to adjacent sectors/facilities; manage weather deviations and traffic
conflicts.
**Decision authority:** Full tactical authority over aircraft within the sector (routing,
altitude, speed instructions); authority ends at the sector boundary, where it's
handed off via coordination, not unilaterally extended.
**Information needs (inputs):** Flight plan/intent, surveillance track data, weather,
adjacent-sector coordination, other traffic in sector.
**Information produced (outputs):** Clearances/instructions to aircraft, handoff
coordination to next sector/facility, traffic-flow reports.
**Constraints:** FAA 7110.65 (Air Traffic Control order) procedures, sector
capacity/workload limits, separation minima, equipment (radar/ADS-B coverage).
**What "optimal" looks like to them (draft):** Safety and manageable workload/complexity
first; predictability of traffic flow — not any individual aircraft's fuel/schedule
optimum, which can conflict with sector-level flow management (e.g., vectoring off an
airline's fuel-optimal path to preserve separation).
**Typical friction / pain point:** Individually fuel-/time-optimal aircraft trajectories
that increase sector complexity or reduce predictability — a direct §9 candidate
("individual optimal trajectory vs. network congestion").
**Notes:** Draft/illustrative — refine against nominal ATC flight-execution research
(to-do §4, FAA source TBD — see [[open-questions]] "Literature gaps").

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *En Route sector – R* ("1st Center 1st sector" … "Last Center last Sector") — many→one. Abstraction: center/sector identity and position along the route are dropped (they belong in the instance model); why: JO 7110.65BB ¶2-10-1 treats the sector team as one team ("no absolute divisions of responsibilities… the team, as a whole, has responsibility"). Confidence high. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Airline Dispatcher (OCC / flight-following)

**Traces to (PESTLE):** "Dispatchers" (Technical)
**Traces to (§8):** Airline
**Appears in:** not yet used — candidate for the nominal domestic flight scenario
(day-of-operations phase) and the off-nominal/disruption scenario

**Who they are:** Certificated airline dispatcher in the Operations Control Center,
jointly responsible with the Captain for flight release under Part 121.
**Goals:** Release flights that are safe, legal, and efficient (fuel, routing, timing)
across the whole network the dispatcher is following, not just one flight in isolation.
**Responsibilities:** Build/approve the flight plan and release; monitor weather,
NOTAMs, and aircraft status throughout the flight; coordinate diversions/delays; maintain
flight-following authority through the flight's duration.
**Decision authority:** Joint authority with the Captain over the release and en route
routing/fuel decisions; can direct a diversion or hold in coordination with the Captain;
authority is shared, not solely the dispatcher's or solely the Captain's — a documented
ambiguous-authority case for §7.
**Information needs (inputs):** Weather/NOTAMs, aircraft performance and status, crew
legality, ATC flow-control advisories, network-wide schedule/connection status.
**Information produced (outputs):** Flight release and flight plan, in-flight
amendments, diversion/delay decisions, coordination with OCC/AOC on network impacts.
**Constraints:** FARs (Part 121 dispatch requirements), company operating specs, fuel
policy, duty-time rules for dispatchers themselves.
**What "optimal" looks like to them (draft):** Network-level efficiency — fuel cost,
schedule integrity, downstream connection/aircraft-rotation impact — a broader scope than
the Captain's single-flight view.
**Typical friction / pain point:** A dispatch decision optimal for the network (e.g.
delaying one flight to protect downstream connections/aircraft rotation) can be
suboptimal or unwelcome for that flight's own passengers/crew — a §9 candidate
("airline schedule integrity vs. ATC workload" is adjacent; also a passenger-vs-airline
conflict not currently listed in §9's starter set, worth adding).
**Notes:** Draft/illustrative — refine against flight-dispatcher research once to-do §4
annotation reaches this role; also connects to the OCC/disruption-management literature
in §4.

**Source mapping (Seamster et al. 2011 → this persona):** source role FOC *Flight Dispatcher* — identical. Not folded in: the source's FOC *ATC coordinator*, which the source treats as a separate desk and which Berry & Pace (2011) describe as the AOC's usual point of contact with ATC (the dispatcher does not normally interact with ATC directly) — no persona exists for it yet (gap; owner decision). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Airline Operations Executive (OCC director / VP Operations level)

**Traces to (PESTLE):** "Airlines (e.g. Delta)" (Economic)
**Traces to (§8):** Airline
**Appears in:** not yet used — candidate for the off-nominal/disruption scenario
(network-level irregular-operations decisions)

**Who they are:** Senior airline operations leader accountable for network-wide
operational and financial performance, typically overseeing the OCC during
irregular operations.
**Goals:** Protect airline profitability, on-time performance, and brand/customer
experience across the entire network — the most aggregated, longest-horizon view of any
persona here.
**Responsibilities:** Set operational policy (fuel policy, delay/cancellation thresholds,
irregular-ops priorities); approve network-level decisions during major disruptions
(e.g., mass cancellations, hub recovery); balance cost against schedule integrity and
regulatory exposure.
**Decision authority:** Strategic/policy authority, not tactical — sets the rules and
thresholds dispatchers and OCC staff operate within, and makes the call on
exceptional/costly network-level decisions (e.g., holding a bank of flights for a
disrupted hub).
**Information needs (inputs):** Aggregated network performance metrics, cost data,
regulatory/compliance exposure, competitive/customer-experience data, OCC situational
reports during disruption.
**Information produced (outputs):** Operating policy, delegated authority/thresholds for
dispatch and OCC staff, escalation decisions during major disruption events.
**Constraints:** Regulatory exposure (DOT consumer-protection rules, FAR compliance),
financial performance pressure, labor agreements, public/brand reputation.
**What "optimal" looks like to them (draft):** Aggregate network cost and on-time
performance, revenue protection, and customer-experience/regulatory-exposure
management — the broadest and most explicitly financial "optimal" of the airline-side
personas.
**Typical friction / pain point:** Policy set for the average/aggregate case can produce
poor outcomes in specific instances the more tactical personas (dispatcher, Captain) have
to absorb — the clearest local-vs-system tension is actually *within* the airline
stakeholder category, not just airline-vs-other-stakeholder, which to-do §9's starter
list doesn't currently capture.
**Notes:** Draft/illustrative — this persona is more speculative than the other three
(no dedicated to-do §2-4 literature source targets "airline exec" specifically); revisit
scope once OCC/disruption-management literature (§4) is annotated — may turn out this
persona is better represented as a policy/constraint-setter referenced by the dispatcher
persona rather than an independent actor in scenario walkthroughs.

---

## Blank templates — roles identified in the 2026-09-20 notes

_Structural stubs, not drafted personas: each carries only its heading and parent group (transcribed from the role trees in `journal/2026-09-20.md`'s Manual Notes) with every analytical field left for the user to fill. The discipline rule above applies once a blank is filled — a PESTLE trace, a scenario appearance (or "not yet used"), and a "materially different from parent" answer before it counts as a persona. A role that fails the last test folds into its parent persona; delete the stub rather than fill it._

**Roles from the notes that resolve to an already-drafted persona (no blank created):**

- Flight dispatch / Dispatch -> Airline Dispatcher
- Captain -> Line Pilot
- Area / sector controllers, Radar Controller -> Air Traffic Controller (Enroute)
- Executive leadership -> Airline Operations Executive _(judgment call — that persona is scoped to the OCC director / VP Operations level; split out a corporate-level executive only if a scenario needs it)_

**Roles listed more than once in the notes, consolidated to one blank:** Station operations (three trees), TSA / DHS, Concessions, Passenger Services "gate" (-> Gate / Customer-Service Agent), "Passenger / baggage services" (-> Check-in Agent, Passenger Assistance, Baggage Handler).

---

### Group: Airline — Corporate / Strategic Management

#### Network Planner

**Parent / group:** Aircraft Operator / Airline > Corporate / Strategic Management
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Schedule Planner

**Parent / group:** Aircraft Operator / Airline > Corporate / Strategic Management
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Fleet Planner (fleet planning / assignment)

**Parent / group:** Aircraft Operator / Airline > Corporate / Strategic Management
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Finance / Revenue Manager

**Parent / group:** Aircraft Operator / Airline > Corporate / Strategic Management
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Sustainability / Environmental Strategist

**Parent / group:** Aircraft Operator / Airline > Corporate / Strategic Management
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airline — Operations Control Center (AOC/OCC)

#### Operations Control Duty Manager

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Aircraft / Fleet Controller

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Crew Controller

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Maintenance Controller

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list: aircraft airworthiness / dispatch-release input; ties to the aircraft-maintenance-routing literature (to-do §2).

#### OCC Meteorologist

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Load Controller

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role RAMP *Load Planner* — renamed, and **organizational placement differs**: the source puts load planning in a RAMP group (it fit neither ATC nor FOC), while this project's tree places Load Controller in the OCC. Function is the same in the matrix (load/passenger list and final weight & balance to the flight deck). Owner to confirm the placement. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Irregular-Operations / Recovery Manager

**Parent / group:** Aircraft Operator / Airline > Airline Operations Control Center (AOC/OCC)
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airline — Flight Operations

#### First Officer

**Parent / group:** Aircraft Operator / Airline > Flight Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role FD *First Officer* — identical. Abstraction: Pilot Flying/Pilot Monitoring states are folded into Captain/First Officer (see Line Pilot). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Cabin Crew

**Parent / group:** Aircraft Operator / Airline > Flight Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airline — Station / Airport Operations

#### Station Manager

**Parent / group:** Aircraft Operator / Airline > Station / Airport Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Gate / Customer-Service Agent

**Parent / group:** Aircraft Operator / Airline > Station / Airport Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list (Gate agent / airport operations): gate assignment and turnaround coordination; ties to the Airport §8 category. The Passenger Services "gate" role in the airport tree is folded in here.

#### Ramp Coordinator

**Parent / group:** Aircraft Operator / Airline > Station / Airport Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Airline–Ground-Handler Coordinator

**Parent / group:** Aircraft Operator / Airline > Station / Airport Operations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: ANSP / FAA ATO — National Traffic Management (ATCSCC)

#### National Operations Manager

**Parent / group:** Air Navigation Service Provider / FAA ATO > National / Network Traffic Management > ATCSCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source *Command Center – TMU / Command Center* — one→many, **ambiguous**: the source does not distinguish NOM / NTMO / NTMS; the Command Center is the Air Traffic Control System Command Center (ATCSCC). Owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### National Traffic Management Officer

**Parent / group:** Air Navigation Service Provider / FAA ATO > National / Network Traffic Management > ATCSCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source *Command Center – TMU* — one→many, **ambiguous** (see National Operations Manager). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### National Traffic Management Specialist

**Parent / group:** Air Navigation Service Provider / FAA ATO > National / Network Traffic Management > ATCSCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source *Command Center – TMU* — one→many, **ambiguous** (see National Operations Manager). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Group: ANSP / FAA ATO — En-route Traffic Management (ARTCC)

#### ARTCC Traffic Management Officer

**Parent / group:** Air Navigation Service Provider / FAA ATO > En-route Traffic Management > ARTCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source "TMU" at an En Route center ("Last Center – TMU", "3rd to last Center – TMU") — one→many, **ambiguous**: the source names a unit, not a role, and does not distinguish TMO / STMC / TMC. Abstraction candidate: treat the ARTCC TM group as the counterpart and split only if a scenario needs different authority. Owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Supervisory Traffic Management Coordinator

**Parent / group:** Air Navigation Service Provider / FAA ATO > En-route Traffic Management > ARTCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source "TMU" at an En Route center — one→many, **ambiguous** (see ARTCC Traffic Management Officer). JO 7110.65BB ¶11-1-2 assigns duties to the STMC-in-Charge. The source's *Supervisor (Sup)* is a sector/facility supervisor, not this role. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Traffic Management Coordinator

**Parent / group:** Air Navigation Service Provider / FAA ATO > En-route Traffic Management > ARTCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source "TMU" at an En Route center — one→many, **ambiguous** (see ARTCC Traffic Management Officer). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Data / Assistant Controller (ARTCC)

**Parent / group:** Air Navigation Service Provider / FAA ATO > En-route Traffic Management > ARTCC
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** From the NASA presentation notes (2026-09-20): maintains flight-progress information/strips and supports separation, including in non-radar environments. The Radar Controller role from the same notes is the drafted Air Traffic Controller (Enroute) persona above.

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *En Route sector – RA* (and Appendix C's *Flight Data*) — identical for RA. JO 7110.65BB ¶2-10-1 defines the Radar Associate ("D-side"/"Manual Controller") and, separately, Radar Flight Data ("Assistant Controller"/"A-side"); this persona's name spans both, so confirm which the persona means. The terminal Radar Associates (Departure-RA, Approach-RA) have no persona here (gap). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Group: ANSP / FAA ATO — Terminal Airspace (TRACON)

#### TRACON Traffic Management

**Parent / group:** Air Navigation Service Provider / FAA ATO > Terminal Airspace > TRACON
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Approach – TMU* — identical (1 mention in the matrix). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Arrival Controller (TRACON)

**Parent / group:** Air Navigation Service Provider / FAA ATO > Terminal Airspace > TRACON
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source roles ATC *Approach – R* and *Final Approach – R* — many→one. Abstraction: Approach vs. Final Approach is a sector split within one TRACON arrival function and is dropped; why: personas split only when authority/information differ. The source's Approach-RA has no persona (gap). Owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Departure Controller (TRACON)

**Parent / group:** Air Navigation Service Provider / FAA ATO > Terminal Airspace > TRACON
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Departure – R* — identical. The source's Departure-RA has no persona (gap: fold into this persona or add a stub — owner decision). Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Group: ANSP / FAA ATO — Airport ATC (ATCT)

#### Local (Tower) Controller

**Parent / group:** Air Navigation Service Provider / FAA ATO > Airport ATC > ATCT
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list (Tower/ground controller): different phase and authority scope from the enroute controller — taxi/takeoff/landing clearance vs. enroute separation. Split out once a scenario needs ground-phase detail.

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Tower – LC* — identical. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Ground Controller

**Parent / group:** Air Navigation Service Provider / FAA ATO > Airport ATC > ATCT
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** See the Local (Tower) Controller note — same carried-over reasoning for the tower/ground vs. enroute distinction.

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Tower – GC* — identical. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Clearance Delivery Controller

**Parent / group:** Air Navigation Service Provider / FAA ATO > Airport ATC > ATCT
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Tower – CD* (Appendix C position "CD/FD") — identical, with the source's Flight Data position folded in ("often combined with Clearance Delivery"). Owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### ATCT Traffic Management

**Parent / group:** Air Navigation Service Provider / FAA ATO > Airport ATC > ATCT
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role ATC *Tower – TMU* — identical. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

---

### Group: Airport — Airport Operator

#### Airport Operations Center Staff

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Airfield Operations

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Terminal Operations

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Facilities / Infrastructure

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Gate / Stand Allocation

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list (Gate agent / airport operations): gate assignment and turnaround coordination; ties to the Airport §8 category.

#### Safety / Emergency Management

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Airport Strategic Management

**Parent / group:** Airport Ecosystem > Airport Operator
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airport — Ground Handling Organizations

#### Ramp Agent

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list (Ramp/ground crew): turnaround-phase authority and coordination; Social/Technical PESTLE rows not yet split out for this role specifically. Possible overlap with the airline-side Ramp Coordinator — apply the materially-different test.

**Source mapping (Seamster et al. 2011 → this persona):** source role RAMP *Ground* (marshals aircraft to the jetway; `E-13`) — one→many from the source's lumped "Pushback/Ground" personnel. Low confidence; owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Baggage Handler

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Cargo / Mail Handler

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Pushback / Towing Operator

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

**Source mapping (Seamster et al. 2011 → this persona):** source role RAMP *Pushback/Ground* (pushback, brake release, engine-start cues; `E-3`) — one→many from the source's lumped ground personnel. Low confidence; owner to confirm. Full crosswalk and gaps: [[interaction-catalog-flight-execution]].

#### Cleaning Crew

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Potable Water / Lavatory Service

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Deicing Crew

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Load / Turnaround Services

**Parent / group:** Airport Ecosystem > Ground Handling Organizations
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airport — Other Service Providers

#### Fuel Provider

**Parent / group:** Airport Ecosystem
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Catering Provider

**Parent / group:** Airport Ecosystem
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Aircraft Maintenance / MRO

**Parent / group:** Airport Ecosystem
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airport — Passenger Services

#### Check-in Agent

**Parent / group:** Airport Ecosystem > Passenger Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Passenger Assistance

**Parent / group:** Airport Ecosystem > Passenger Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airport — Government Services

#### TSA / DHS

**Parent / group:** Airport Ecosystem > Government Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Listed under both Government Services and Governance / External in the notes; one entry covers both.

#### CBP

**Parent / group:** Airport Ecosystem > Government Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Police

**Parent / group:** Airport Ecosystem > Government Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Fire / ARFF

**Parent / group:** Airport Ecosystem > Government Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Airport — Commercial / Landside Services

#### Concessions

**Parent / group:** Airport Ecosystem > Commercial / Landside Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Parking

**Parent / group:** Airport Ecosystem > Commercial / Landside Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Rental Cars

**Parent / group:** Airport Ecosystem > Commercial / Landside Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Ground Transportation

**Parent / group:** Airport Ecosystem > Commercial / Landside Services
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Aircraft Operators / Airspace Users — Other Operator Types

#### Business Aviation

**Parent / group:** NAS > Aircraft Operators / Airspace Users
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### General Aviation

**Parent / group:** NAS > Aircraft Operators / Airspace Users
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** General aviation is provisionally excluded from the SOI boundary ([[open-questions]]); this blank exists because the 2026-09-20 notes list it — decide in/out when the boundary is ratified.

#### Military

**Parent / group:** NAS > Aircraft Operators / Airspace Users
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Military airspace use is provisionally excluded beyond its PESTLE/§8 stakeholder role ([[open-questions]]); Military is also the least-grounded §8 category (no persona, no literature yet). Decide scope when the boundary is ratified.

#### UAS

**Parent / group:** NAS > Aircraft Operators / Airspace Users
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

---

### Group: Governance / External Stakeholders

#### FAA (Regulator)

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### DOT

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### EPA

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### State / Local Government

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Communities

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

#### Passenger

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:** Carried over from the earlier "not yet drafted" list: central to the trajectory-intent chain's "why," but check to-do-list §8 before assuming this is one persona — needs and behavior likely vary (business vs. leisure, connecting vs. origin-dest) enough that one generic "Passenger" may hide real conflicts. Flag when a scenario needs the distinction.

#### Environment / Public Interest

**Parent / group:** NAS > Governance / External Stakeholders
**Traces to (PESTLE):**
**Traces to (§8):**
**Appears in:**

**Who they are:**
**Goals:**
**Responsibilities:**
**Decision authority:**
**Information needs (inputs):**
**Information produced (outputs):**
**Constraints:**
**What "optimal" looks like to them (draft):**
**Typical friction / pain point:**
**Materially different from parent?**
**Notes:**

## Status

Four personas drafted (Captain, enroute ATC, dispatcher, airline exec) as illustrative starting material — all currently "not yet used" in a drafted scenario. 71 blank templates added 2026-09-20 for the remaining roles identified in the day's notes (section above); none filled in yet. Next step: draft the nominal domestic flight scenario in [[conops-scenarios]] and pull these personas into it directly (fill in their "Appears in" fields), which will surface whether the personas as drafted actually have enough to say, or need revision — and which blanks survive the "materially different from parent" test.
