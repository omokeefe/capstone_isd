# Stakeholder Objective / Cost / Value Ontology

_Works `to-do-list.md` §8 (Develop Objective / Cost / Value Ontology), using the seven
§8 stakeholder categories (Airline, Passenger, ATC/ANSP, Airport, Flight Crew,
Environmental/Societal, Military) and their candidate-objective lists as the starting
point, cross-checked against [[stakeholder-register]]'s PESTLE reconciliation note and
[[stakeholder-personas]] where a persona already exists. See
[workflows/objective-ontology-pass.md](../../workflows/objective-ontology-pass.md) for
the process this follows._

## How to read this table

- **Classification** — one of: *Hard constraint*, *Optimization objective*,
  *Cost/penalty*, *MOE* (measure of effectiveness — outcome/mission-level), *MOP*
  (measure of performance — system/local-level). An objective can carry more than one
  tag (e.g. safety is a hard constraint whose margin is also tracked as an MOE).
- **MOP** — a directly measurable, local/system-level metric.
- **MOE** — a higher-level, outcome/mission metric the MOP is a proxy for.
- **Trajectory-decision impact** — does a change in aircraft trajectory (route,
  altitude, speed, timing — the intent-to-trajectory chain in
  [[project-brief]]) measurably move this objective? **Yes** (direct/primary),
  **Indirect** (mediated through another decision), or **No**.
- **Abstraction comment** — how much internal detail this objective needs in the
  architecture/optimization model vs. treating it as a coarse boundary input.

Objectives are grouped by the §8 category they were seeded from; PESTLE
[[stakeholder-register]] rows and [[stakeholder-personas]] entries are cited inline
where they add authority/information detail beyond the objective itself.

## Airline

Persona detail: [[stakeholder-personas]] "Airline Dispatcher" (flight-level) and
"Airline Operations Executive" (network-level) — note the two personas already document
a *within-stakeholder* optimization tension (policy set for the aggregate vs. tactical
absorption by dispatch/Captain), relevant to every objective below.

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Fuel cost | Cost/penalty (minimize) | Fuel burned per flight (kg); fuel cost per ASM | Network fuel cost as % of operating cost / CASM impact | **Yes** — direct | Model at trajectory level (altitude/speed/route choice) — this is the primary lever connecting airline objectives to the intent-to-trajectory chain; a strong §11 optimization-study candidate. |
| Crew cost | Cost/penalty | Duty hours used vs. scheduled; overtime/reserve cost per pairing | Crew cost per block hour / % of operating cost | Indirect | Keep at schedule/pairing level; only pull trajectory detail in if a specific scenario needs duty-time-limit exhaustion from an unusually long flight. |
| Aircraft utilization | Optimization objective | Block hours flown per aircraft/day; turnaround time | Fleet-wide utilization rate (hrs/day) | Indirect | Decision variable is fleet assignment/routing, not the trajectory itself; trajectory only feeds in via realized block time. |
| Maintenance | Hard constraint (airworthiness) + Cost/penalty | Hours/cycles to next check; dispatch reliability rate | Maintenance cost per flight hour; fleet airworthiness rate | Indirect | Second-order (thrust/derate settings affect wear); not a primary trajectory-intent coupling — model as a constraint input, not a trajectory function. |
| Schedule integrity | Optimization objective / MOE | On-time performance (% within 15 min); block-time adherence | Network OTP; connection-bank integrity | **Yes** — direct | Realized trajectory (cruise speed choice, holding, rerouting) is what actually determines arrival-vs-schedule; keep coupled to trajectory in the model. |
| Passenger connections | Cost/penalty / Optimization objective | Minimum-connection-time achieved; missed-connection rate | Network connectivity reliability; rebooking cost | **Yes** | Downstream of schedule integrity — late trajectory execution breaks connections; same causal chain, different stakeholder view (see Passenger row below). |
| Delay cost | Cost/penalty | Delay minutes per flight; compensation exposure (DOT/EU261-style) | Total network delay cost | **Yes** | Direct downstream of trajectory execution (taxi, holding, reroute) — model explicitly. |
| Revenue | Optimization objective (maximize) | Load factor; yield per seat-mile | Network revenue; RASM | Indirect | Set upstream at scheduling/pricing; trajectory execution reliability only affects revenue long-run via customer choice — treat as out-of-model boundary input. |
| Dispatch reliability | MOE | % flights departed without mechanical/ops delay | Network dispatch reliability rate (industry-standard) | Indirect | A pre-departure metric; trajectory execution happens after this is set — coarse boundary input. |

## Passenger

Persona detail: none yet — [[stakeholder-personas]] flags Passenger as a likely
non-generic persona (business vs. leisure, connecting vs. origin-destination hide real
conflicts); the objectives below are written generically until/unless a scenario forces
that split.

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Ticket price | Hard constraint / Cost (to the passenger) | Fare paid | Perceived affordability | **No** | Set at booking/pricing time; unrelated to how the trajectory is later flown — leave out of the trajectory-optimization model entirely. |
| Travel time | Optimization objective (minimize) / MOE | Gate-to-gate time; actual vs. scheduled block time | Total trip time incl. connections | **Yes** — direct | Same underlying trajectory variable as the airline's schedule-integrity objective, viewed from the passenger's side — good candidate to show one trajectory decision affecting two stakeholders' MOEs differently. |
| Connection reliability | MOE | Missed-connection rate experienced | Successful-itinerary completion rate | **Yes** | Mirrors "Passenger connections" above; keep as one modeled quantity referenced by both stakeholder views rather than duplicating. |
| Schedule convenience | Cost/penalty if violated | Deviation from preferred departure/arrival window | Passenger-perceived schedule satisfaction | Indirect | Mostly set at network/timetable design; trajectory only intrudes when delay pushes arrival outside the convenient window. |
| Comfort | Cost/penalty | Ride-quality incidents (turbulence encounters); cabin conditions | Passenger satisfaction score | **Yes** (secondary) | Altitude/route selection for turbulence avoidance is a direct, modelable trajectory lever — smaller-magnitude than fuel/time but mechanistically clean. |
| Disruption risk | Cost/penalty / hard-constraint avoidance | Missed-connection/cancellation exposure probability | Trip-completion reliability | Indirect | Mostly a function of network/schedule buffer design; trajectory execution feeds delay cascades that raise this risk but isn't the primary lever. |

## ATC / ANSP

Persona detail: [[stakeholder-personas]] "Air Traffic Controller (Enroute, ARTCC
sector)" — already documents the core §9 tension ("individually optimal aircraft
trajectories that increase sector complexity").

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Safety/separation | Hard constraint | Number of separation-standard violations / losses of separation | System-wide accident/incident rate | **Yes** — direct, primary | This *is* the controller's trajectory-shaping lever (vectoring, altitude assignment) — model at full trajectory fidelity; never treat as a coarse input. |
| Sector workload | Hard constraint (capacity ceiling) / Cost | Instructions issued per sector per unit time; controller task-load index | Sustained throughput without workload-driven error | **Yes** | Aggregate trajectory complexity (how many aircraft need tactical intervention) drives this directly — the §9 "individual optimal trajectory vs. network congestion" conflict lives here; a strong §11 candidate. |
| Capacity | Hard constraint / Optimization objective | Aircraft handled per sector-hour vs. declared capacity | System-wide throughput (aircraft/day) vs. declared capacity | **Yes** | Trajectory conformance/predictability determines how close to declared capacity a sector can safely run. |
| Predictability | Optimization objective / MOE | Trajectory conformance (actual vs. filed/cleared-path deviation) | System-wide flow predictability | **Yes** — defined in terms of trajectory | Keep at full trajectory fidelity — this objective is literally a trajectory-conformance measure. |
| Delay (ATC-attributed) | Cost/penalty | Minutes of ATC-attributed delay/ground stop per flight | National airspace delay minutes (OPSNET-style) | **Yes** | Holding, rerouting, ground stops are themselves trajectory-level ATC actions. |
| Traffic complexity | Hard-constraint proxy / Cost | Complexity metric (conflict count, convergence-angle density) per sector-hour | System-wide complexity trend vs. controller staffing | **Yes** | Direct function of the aggregate trajectory set in a sector — pairs with sector workload above. |

## Airport

No persona drafted yet (Airport Management System is captured as a system hub in
[[candidate-systems-inventory]] / [[interface-exchange-draft]], not a human persona).

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Gate utilization | Optimization objective | Gate occupancy rate; turns per gate/day | Revenue per gate; terminal capacity utilization | Indirect | Gate assignment depends on ETA accuracy (trajectory-dependent) but the assignment decision itself isn't a trajectory decision — treat trajectory as an input signal only. |
| Runway utilization | Hard constraint (capacity) / Optimization objective | Runway ops/hour vs. declared capacity | Airport throughput (ops/day) | **Yes** | Arrival/departure sequencing (spacing, approach speed) directly determines achievable runway throughput — model explicitly, it's an airport/ATC shared lever. |
| Surface congestion | Cost/penalty | Taxi-out/taxi-in time; queue length | System-wide taxi-delay fuel burn; surface throughput | **Yes** (ground segment) | Taxi routing/sequencing is itself a (ground) trajectory decision with direct fuel/emissions and schedule consequences — don't drop it just because it's not airborne. |
| Turnaround performance | MOE / Optimization objective | Actual vs. scheduled turnaround time; on-time gate-departure rate | Network-wide turnaround reliability | Indirect | Depends on arrival punctuality (trajectory-driven) but the turnaround activities themselves (fueling, catering, cleaning) are not trajectory decisions. |
| Passenger throughput | Optimization objective | Passengers processed/hour (security, gate, curb) | Terminal-level capacity utilization / experience | **No** | Landside/terminal process, essentially decoupled from aircraft trajectory — coarse boundary input at most. |

## Flight Crew

Persona detail: [[stakeholder-personas]] "Line Pilot (Captain, Part 121)".

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Safety | Hard constraint | Safety-margin exceedances (terrain, weather, fuel-reserve violations) | Accident/incident rate | **Yes** — direct, primary | The Captain's core authority is precisely the right to deviate from a planned/assigned trajectory to preserve this margin — full fidelity. |
| Workload | Cost/penalty | Manual interventions/reconfigurations per flight phase | Fatigue/error rate correlated with workload | **Yes** | Reroutes, holding, and last-minute clearance changes directly add workload — model as a trajectory-change cost. |
| Procedural compliance | Hard constraint | Deviations from SOP/clearance recorded | Regulatory compliance rate; FOQA event rate | **Yes** | Compliance is defined *relative to* the cleared/assigned trajectory — inherently trajectory-coupled. |
| Schedule/duty constraints | Hard constraint (FAR duty-time limits) | Duty hours remaining vs. regulatory limit | Network-wide crew-legality rate | Indirect | Set by pairing/rostering; a long reroute/hold can consume duty-time margin but the constraint itself isn't a trajectory function. |
| Operational flexibility | Optimization objective (for the crew) | Rate of deviation requests granted vs. denied | Ability to absorb off-nominal events without cascading disruption | **Yes** | This objective *is* latitude to alter the trajectory — model directly. |

## Environmental / Societal

No persona drafted yet — flag per [[stakeholder-personas]] "Not yet drafted" list,
which doesn't currently even name this category; worth adding once a scenario needs a
concrete environmental-advocacy or community-impact voice rather than a background
objective set.

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| CO2 | Cost/penalty (externality) / emerging regulatory constraint (e.g. CORSIA) | CO2 per flight (kg); fuel burn as proxy | System-wide CO2 intensity (g/RPK); progress vs. decarbonization targets | **Yes** — direct | Direct function of fuel burn, i.e. of trajectory — same underlying variable as the airline's fuel-cost objective (see "Aligned objectives" below). |
| NOx | Cost/penalty / regulatory constraint | NOx per flight (altitude/thrust-dependent) | Airport-vicinity air-quality compliance | **Yes** | Altitude profile and thrust setting (climb/descent trajectory) directly affect NOx formation. |
| Contrail/climate effects | Emerging optimization objective / Cost (non-CO2 climate forcing) | Contrail-forming flight distance/time (ISSR transit) | Estimated non-CO2 radiative forcing avoided | **Yes** | Directly addressable via altitude/route changes avoiding ice-supersaturated regions — this is the §9 "CO2 optimization vs non-CO2 climate impacts" conflict, and it can conflict with the CO2 objective directly above. |
| Noise | Hard constraint (Part 150/noise-abatement procedures) / Cost | Noise level (dB) at monitored points; complaint volume | Population within noise-contour thresholds | **Yes** | Approach/departure trajectory (noise-abatement procedures, track/altitude) is the direct lever. |
| Local air quality | Regulatory constraint | Pollutant concentration near airport | Community health/compliance metrics | Indirect | Mainly a ground-ops/taxi and landing-takeoff-cycle effect; secondarily linked to trajectory via low-altitude segments. |
| Community impacts | Cost/penalty (externality, often unpriced) | Complaint volume; property-value studies | Community acceptance / social license to operate | **Yes** (via noise/emissions pathway) | Rolls up the noise and air-quality trajectory levers above rather than adding a new one — model as a composite, not a fresh variable. |

## Military

No persona drafted yet. [[candidate-systems-inventory]] already flags a related SOI
question: whether military-aircraft internals ("Weapons System," "Mission System") are
in scope, or only the civil-military airspace-access interface. The treatment below
assumes the latter — see [[open-questions]] "System boundary" — until that's formally
decided.

| Objective | Classification | MOP | MOE | Trajectory impact | Abstraction comment |
|---|---|---|---|---|---|
| Mission effectiveness | Hard constraint (mission success) | Mission-specific objectives achieved | Mission success rate | Yes, *within* military airspace | Likely out of SOI detail — model as an opaque boundary condition (the mission happens, or doesn't) rather than as an internal trajectory-optimization problem. |
| Mission timing | Hard constraint | Time-on-target accuracy | Coordination success with joint/civil operations | Yes, internally | Interfaces with the civil NAS mainly at the airspace-access boundary (below) — don't model military trajectory detail beyond that interface. |
| Fuel availability | Constraint | Fuel reserve at mission completion | Sortie-generation sustainability | Indirect | Relevant as a resource constraint on military operations, not a civil trajectory-intent coupling — leave internal. |
| Airspace access | Hard constraint / Cost (opportunity cost to civil traffic) | Special-use-airspace (SUA) activation time/volume | Civil capacity lost to SUA reservations | **Yes** — the actual coupling point | This is the one military objective worth modeling in real trajectory detail: SUA activation forces civil aircraft to reroute around it — direct instance of the §9 "military mission effectiveness vs civil-airspace capacity" conflict, and the natural place to draw the civil/military SOI line. |
| Operational security | Hard constraint | Not meaningfully quantifiable at this project's scope | Not meaningfully quantifiable at this project's scope | **No** direct civil-trajectory link | Flag as out-of-SOI-detail; don't force a metric onto it. |
| Resilience | Constraint / MOE | Alternate-mission-capable rate | Continuity of operations under disruption | Indirect | Only relevant if a contested/degraded scenario forces civil rerouting; otherwise out of scope. |

## Synthesis — conflicts, alignments, externalities, timescales

*(§8's closing bullets: "Identify conflicting objectives," "aligned objectives,"
"objectives whose costs are externalized," "objectives operating on different
timescales." These cut across the per-category tables above rather than living inside
any one of them.)*

### Conflicting objectives

- **Airline fuel-cost minimization vs. ATC/ANSP sector workload & predictability** —
  individually fuel-optimal trajectory requests increase controller tactical
  intervention. Ties directly to the §9 starter conflicts "individual-aircraft fuel
  efficiency vs. sector capacity" and "individual optimal trajectory vs. network
  congestion." **Strongest §11 optimization-study candidate** — clean decision variable
  (requested cruise trajectory), clean opposing MOPs (fuel burn vs. sector
  complexity/workload) on both sides.
- **Airline schedule-integrity/delay-cost minimization vs. Environmental/Societal CO2 &
  noise** — schedule recovery via increased cruise speed burns more fuel/emits more
  CO2; recovery via shortcut/low-altitude tracks can increase noise. Ties to §9
  "minimum flight time vs. fuel/emissions."
- **Passenger travel-time/connection-reliability vs. ATC/ANSP capacity &
  predictability** — trajectory choices that are locally optimal for one flight's
  passengers can reduce system-wide throughput/predictability if generalized.
- **Military airspace access vs. ATC/ANSP capacity & Airline schedule integrity** — SUA
  activation forces civil rerouting; directly the §9 "military mission effectiveness
  vs. civil-airspace capacity" conflict.
- **CO2 minimization vs. Contrail/non-CO2 climate effects** — a conflict *within* the
  Environmental/Societal category, not just across categories: the fuel-optimal cruise
  altitude/route is not always the contrail-avoiding one. Structurally the same pattern
  [[stakeholder-personas]] already flagged *within* the Airline category (exec policy
  vs. dispatcher/Captain tactical absorption) — worth noting as a recurring pattern
  (intra-stakeholder myopia, not just inter-stakeholder) when §9 is written up formally.

### Aligned objectives

- ATC/ANSP predictability and Airline schedule integrity — both want trajectory
  conformance to plan.
- Airline fuel-cost minimization and Environmental CO2 minimization — aligned in the
  nominal case (less fuel burned means less CO2), but this alignment breaks under the
  contrail conflict above — flag as "usually aligned, occasionally conflicting" rather
  than a clean alignment.
- Airport runway utilization and ATC/ANSP capacity — both want maximum safe throughput.

### Objectives with externalized costs

- Airline delay-recovery decisions (speeding up) externalize CO2/noise cost onto
  Environmental/Societal stakeholders without those costs entering the airline's own
  objective function.
- Individually fuel-optimal airline trajectory requests externalize workload/complexity
  cost onto ATC/ANSP controllers.
- Military airspace reservations externalize capacity loss onto Airlines/Passengers/
  ATC without compensating those stakeholders.

### Objectives on different timescales

- **Airline**: revenue/schedule-integrity policy is set at a strategic (months)
  timescale; fuel cost is realized per-flight (hours); delay cost is realized in
  real-time (minutes) — three timescales inside one stakeholder category.
- **ATC/ANSP**: capacity/predictability are managed at both a strategic (sector design,
  years) and tactical (real-time, seconds-to-minutes) timescale simultaneously — a
  likely source of the myopic-optimization problem this project targets.
- **Environmental**: CO2/contrail effects operate on climate-relevant timescales
  (decades) that are essentially invisible to any single per-flight tactical decision —
  the clearest example of a temporal-scale mismatch feeding §9, and a reason those
  objectives may need to be modeled as a slowly-accumulating penalty rather than a
  per-flight one.

## Status

Drafted 2026-09-06, covering all seven §8 categories against the candidate-objective
lists in `to-do-list.md` §8. Classification/MOP/MOE/trajectory-impact assignments above
are this session's judgment calls, not sourced from annotated literature yet — revisit
against evidence as §2-§4 annotation reaches airline-objective, ATC-workload, and
environmental-impact sources specifically. The Military and Environmental/Societal
categories are the least grounded (no persona, no dedicated literature source
identified yet) — treat those two tables as more provisional than the other five.
