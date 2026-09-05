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
**Goals:** Complete the flight safely, on schedule, within fuel/weight/regulatory limits,
with minimal passenger/crew disruption.
**Responsibilities:** Accept or reject the dispatch release and flight plan; brief the
crew; manage the aircraft through all flight-execution phases (pushback through gate
arrival); make in-flight safety and routing decisions; comply with ATC clearances.
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

## Not yet drafted (obvious candidates, add as scenarios need them)

- **Passenger** — central to the trajectory-intent chain's "why" but check
  `Project_To-Do List.md` §8 before assuming this is one persona; passenger
  needs/behavior likely vary enough (business vs. leisure, connecting vs. origin-dest)
  that one generic "Passenger" persona may hide real conflicts — flag when a scenario
  needs the distinction.
- **Ramp/ground crew** — turnaround-phase authority and coordination (Social/Technical
  PESTLE rows not yet split out for this role specifically).
- **Gate agent / airport operations** — gate assignment and turnaround coordination,
  ties to "Airport" §8 category.
- **Maintenance controller** — aircraft airworthiness/dispatch-release input, ties to
  aircraft-maintenance-routing literature (to-do §2).
- **Tower/ground controller** — distinct from the enroute controller above (different
  phase, different authority scope: taxi/takeoff/landing clearance vs. enroute
  separation); split out once a scenario needs ground-phase detail specifically.

## Status

Four personas drafted (Captain, enroute ATC, dispatcher, airline exec) as illustrative
starting material — all currently "not yet used" in a drafted scenario. Next step: draft
the nominal domestic flight scenario in [[conops-scenarios]] and pull these personas into
it directly (fill in their "Appears in" fields), which will surface whether the personas
as drafted actually have enough to say, or need revision.
