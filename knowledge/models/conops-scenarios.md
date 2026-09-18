# ConOps Scenario Exploration

_Working document for `to-do-list.md` §5 ("Construct the Nominal-Flight ConOps"),
used deliberately as a vehicle for §1 ("Establish Research Framework") too — each
scenario should double as a probe of the System of Interest boundary and the research
questions, not just an operational walkthrough. See
[[project-brief]] for the trajectory-intent throughline this should trace to, and
[[open-questions]] ("System boundary" section) for the boundary questions each scenario
should try to answer._

## Why scenarios drive SOI/research-question work

A boundary question like "is general aviation in scope?" is hard to answer in the
abstract. It's easier to answer against a concrete scenario: walk the scenario, and where
it forces a call (include this actor/system or not; this level of abstraction or not),
that's evidence for the boundary, not just an assertion. Each scenario entry below has a
field for exactly that — "SOI questions this exercises" — so the exploration accumulates
into an answer to `open-questions.md` rather than living only as a narrative.

Similarly, "research questions this probes" ties each scenario back to §1's six research
questions (decomposition, authority/responsibility/ownership boundaries, intent
propagation, differing definitions of optimal, myopic-optimization failure modes, MBSE
support for tradeoff analysis) so scenario selection stays purposeful rather than
open-ended world-building.

## Candidate scenarios to consider

Seeded from the open SOI boundary questions and the to-do §5 phase list — not yet
written up, just starting candidates. Add/remove freely; the goal is 1-3 *representative*
scenarios for the formal ConOps deliverable (to-do §5's stated metric), so this list
should get cut down, not all built out in full.

- **Nominal domestic commercial flight** — the baseline case; walks all six phases in
  to-do §5 (strategic/commercial planning through postflight/continuation) with no
  disruptions. Almost certainly one of the final 1-3.
- **International flight crossing NAS boundary** — probes "is international airspace
  outside the US NAS in scope?" and where authority transfers at the boundary (FAA to a
  foreign ANSP or vice versa).
- **General aviation flight (non-scheduled, non-airline)** — probes "is GA in scope?" —
  much of the strategic/commercial planning phase doesn't apply; tests whether the
  decomposition still holds without an airline OCC/dispatch layer.
- **Military airspace interaction (e.g. TFR or restricted-area transit)** — probes the
  "military as stakeholder vs. military as constituent system" boundary question and a
  candidate §9 conflict ("military mission effectiveness vs. civil-airspace capacity").
- **Off-nominal / disruption case (e.g. weather diversion or mechanical delay)** — probes
  intent *re*-propagation (research question 3) and surfaces a concrete local-vs-system
  optimization conflict for §9, rather than only the nominal happy path.

## Scenario entry template

Copy this block per scenario below the seed list once you start writing one up.

```
### <Scenario name>

**Status:** candidate | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>
```

## Scenarios

### Domestic Commercial Flight w/Wx Re-Route

**Status:** candidate |**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>## Status

Not yet started. Once 1-3 scenarios are drafted here and stable, synthesize the summary
into `report/sections/04_results_discussion.tex` (plantodo tagged `S5`) and the full
activity breakdown into `report/sections/08_appendices.tex` (`app:conops`), per the
mapping comment at the top of `report/main.tex`.

--- 

### Nominal International Flight 

* concept | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** 

### Business Flight 

* concept | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>

---

### Hub-to-Hub Trajectory Cost vs. Sector Workload Tradeoff

**Status:** candidate — drafted 2026-09-17 from journal brainstorm
([[journal/2026-09-17]]), key parameters still open. Elaborated into a full
phase-by-phase operational thread in
[[conops-hub-to-hub-trajectory-cost]] (companion to
[[conops-nominal-domestic_flight]]).

**Summary:** A single focal flight between two airline hub airports (city pair TBD —
see open issues) chooses a cruise trajectory (speed/altitude/route, including any
delay-recovery speed-up) to minimize its own generalized cost — fuel, emissions
(monetized via a carbon-price proxy on fuel burn, tracked separately from fuel $ cost
per [[stakeholder-objective-ontology]]'s CO2-vs-contrail note), maintenance/wear
($/flight-hour proxy), crew time ($/duty-hour), and passenger time/missed-connection
cost (value-of-time + rebooking proxy) — all monetized into one commensurable number.
That request is absorbed by a shared en-route sector also carrying a small background
bank of other traffic, so the airline's locally-optimal trajectory choice has a
measurable effect on ATC sector workload/complexity, not just on the focal flight's own
cost. This is the ontology's synthesis-section front-runner conflict ("Airline
fuel-cost minimization vs. ATC/ANSP sector workload & predictability") built out into a
concrete, boundedly-sized scenario rather than left as an abstract pairing. Critically,
the trajectory choice isn't one up-front decision — dispatch paperwork typically
publishes an advisory step-climb/speed-schedule guideline, and whether the crew
actually pursues each step (vs. forgoing it to avoid adding workload for themselves or
a busy-seeming controller) is a recurring in-flight decision with its own workload cost
to both sides, independent of whether ATC ever needs to actively intervene. See
[[conops-hub-to-hub-trajectory-cost]] Phase C for the full loop.

**Phases exercised (to-do §5):** Day-of-operations (dispatcher trajectory
request/flight-planning), flight execution (the trajectory actually flown, ATC
tactical response) are the core of it. Strategic/commercial planning and turnaround are
boundary inputs (schedule/aircraft assignment already fixed) rather than modeled in
detail; postflight/continuation is out of scope for this scenario specifically.

**Actors/systems involved:** Airline Dispatcher and Line Pilot/Captain
([[stakeholder-personas]]) on the request/execution side; Air Traffic Controller
(en-route, ARTCC sector) ([[stakeholder-personas]]) on the workload/capacity side;
Passengers as the endpoint bearing the time/missed-connection cost term. Background
traffic in the shared sector can stay unpersona'd (just a workload-generating input)
unless a specific one needs its own trajectory-choice logic.

**SOI questions this exercises:** Directly forces an answer on the still-open
"abstraction level" question in [[open-questions]] — this scenario only needs
trajectory-level fidelity for the focal flight and coarse sector-occupancy counts for
the background bank, not full trajectory fidelity for every aircraft. Also a concrete
test case for the [[open-questions]] "Decomposition choice (§6)" question: the
authority split here (dispatcher/crew requests, ATC accepts/modifies/denies) is exactly
the decision-authority boundary [[decisions-log]] D-002 left unresolved.

**Research questions this probes (to-do §1):** Intent propagation (a fuel/cost-driven
trajectory request propagating from dispatch through crew to ATC); differing
definitions of "optimal" (airline generalized cost vs. ATC workload/predictability);
myopic-optimization failure modes (this *is* the project's leading candidate instance —
see [[stakeholder-objective-ontology]] synthesis section).

**Notes / open issues:**

- **City pair not yet chosen** — the 2026-09-17 brainstorm's hub map (ATL/LAX/DFW-style)
  narrowed the *scope* (single hub-to-hub pair, not a 3-hub network) but not the
  specific pair. Pick one with enough real-world en-route sector congestion to make the
  workload side meaningful, or treat the sector as illustrative/generic if a specific
  real pair adds more literature-sourcing burden than value.
- **Background bank size not yet set** — a single focal flight can't generate
  meaningful "sector workload"; needs a small number of concurrent aircraft (a first
  guess: 3-6) sharing the sector. Not yet checked against any literature-sourced sector
  capacity figure.
- **Emissions/wear/passenger-time monetization factors are placeholders** — carbon
  price, value-of-time, and rebooking-cost figures all need either a literature source
  or an explicitly-flagged assumption before this goes into the report; don't let
  invented numbers pass as sourced ones.
- **Relationship to the existing "Domestic Commercial Flight w/Wx Re-Route" stub
  above:** that scenario is about *off-nominal* rerouting (weather); this one is about a
  *nominal* trajectory-request choice under a cost/workload tradeoff. Likely both worth
  keeping as distinct scenarios rather than merging, but worth a second look once both
  are fleshed out — they may turn out to be the same scenario at two different fidelity
  levels.