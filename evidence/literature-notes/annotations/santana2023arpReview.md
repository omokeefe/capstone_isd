# Annotation: The Aircraft Recovery Problem: A Systematic Literature Review

- **File:** `references/The Aircraft Recovery Problem A Systematic Literature Review.pdf`
- **Bib key:** `santana2023arpReview`
- **Type:** journal review (systematic literature review)
- **To-do section:** `to-do-list.md` §4 (Literature Review — OCC, Dispatch and
  Flight Execution) — also feeds §7-9 (stakeholder/objective/myopic-optimization) and
  §11-13 (optimization study)

## Extraction

- **Actors / stakeholders:** The Airline Operations Control Center (AOCC)/dispatch
  function as the decision-making body; indirectly, passengers and crew (whose
  connections/duty are affected by aircraft rerouting decisions, though this paper
  explicitly excludes crew/passenger recovery from its scope — see below); airports
  (affected by changed arrival/departure times); ATC/ANSP (must accommodate rerouted
  flights). Maps to existing PESTLE rows "Airlines," "Dispatchers," "Air traffic
  controllers," "Airports" — no new stakeholder class.
- **Systems / organizations:** The AOCC's aircraft-recovery decision-support/optimization
  system; the airline's fleet and route network as the object being rescheduled.
- **Objectives:** Minimize disruption cost following an irregular operation —
  specifically decomposed into three competing sub-objectives the literature addresses
  separately or jointly: minimize total delay, minimize number of cancellations, minimize
  aircraft swaps (which can trigger downstream crew/maintenance/passenger complications
  even though this review excludes those from direct scope).
- **Costs / penalties:** Delay cost (per-minute or schedule-block cost), cancellation
  cost (lost revenue, rebooking, goodwill), aircraft-swap cost (crew/maintenance/gate
  reassignment friction) — the review notes most studies optimize only a subset of these
  simultaneously, rarely all three.
- **Decisions:** New departure times for disrupted aircraft; flight cancellations;
  aircraft swaps/reroutes; use of ferry flights to reposition aircraft.
- **Decision authority:** The AOCC/dispatch function, operating under airline-internal
  authority but constrained by ATC/ANSP slot and airport-capacity approval for any
  rerouted/rescheduled flight.
- **Activities / processes:** Disruption detection → aircraft-recovery-problem
  formulation (network representation choice) → solution generation (exact, heuristic, or
  metaheuristic) → implementation/communication of the new schedule to affected
  downstream functions (crew, passengers, ATC, airports) — this last handoff is outside
  the ARP literature's own scope but is a direct downstream consequence.
- **Resources:** Available aircraft (by fleet type/tail), open ferry-flight capacity,
  schedule slack/buffer time, airport slot availability.
- **Information inputs:** Original flight schedule, disruption event data (e.g.,
  weather, mechanical failure, crew unavailability), aircraft location/status, network
  topology (which airports an aircraft type can serve).
- **Information outputs:** A revised aircraft routing/schedule (assignment of tail
  numbers to flight legs, updated departure times, cancellation list) passed downstream
  to crew recovery, passenger recovery, and ATC/airport coordination systems.
- **Constraints:** Aircraft type/capability matching to routes; maintenance-due
  constraints; crew legality (even though crew recovery is a separate sub-problem, ARP
  solutions must remain crew-feasible or accept later re-optimization); airport slot and
  curfew constraints; minimum ground/turnaround time.
- **Interfaces / handoffs:** ARP sits upstream of, and hands off to, the Crew Recovery
  Problem (CRP) and Passenger Recovery Problem (PRP) — the review explicitly notes most
  real airlines and much of the literature treat these sequentially (aircraft first, then
  crew, then passengers) rather than jointly, which is itself a structural
  local-optimization pattern worth citing.
- **Timescales of decisions:** Tactical/near-real-time — ARP decisions are made in the
  hours following a disruption event, much faster than strategic schedule-planning (§2
  literature) but slower than the real-time flight-execution timescale (§4's ATC/IFR
  sub-topic).
- **Upstream dependencies:** The original strategic schedule (fleet assignment, route
  network) from airline schedule planning (§2 literature, e.g. `eltoukhy2017airline`,
  `lohatepanont2004airline`); the disruption event itself (weather, mechanical, crew, ATC
  flow constraints) as an exogenous trigger.
- **Downstream consequences:** The revised aircraft schedule constrains what crew
  pairings remain legal (feeding CRP) and what passenger itineraries remain valid
  (feeding PRP); ultimately it determines the actual trajectory/routing each aircraft
  flies for the remainder of the disruption-recovery window — a direct, concrete link in
  the capstone's enterprise-objective-to-aircraft-trajectory intent chain, entered at the
  "day-of-disruption" layer.
- **Optimization variables:** Aircraft-to-flight-leg assignment (tail-number routing),
  flight departure-time shifts, cancellation decisions (binary per flight), ferry-flight
  insertion decisions.
- **Objective functions / measures of effectiveness:** Weighted combination of total
  delay minutes, number of cancellations, and number of aircraft swaps (weights vary by
  study; the review notes this weighting choice is itself a modeling decision that
  encodes an implicit stakeholder-priority tradeoff).
- **Evidence of local-vs-system-level conflicts:** Direct and citable — the review's
  central finding that "studies rarely optimize delay, cancellation, and aircraft-swap
  objectives simultaneously" is itself evidence of a local (single-objective,
  single-sub-problem) optimization pattern in the literature that a real airline's
  system-level recovery (which must jointly satisfy aircraft, crew, and passenger
  constraints) cannot fully capture. The sequential ARP → CRP → PRP treatment common in
  practice and literature is a structural example of decomposing a system-level problem
  into locally-optimized stages, each of which can produce solutions that are locally
  optimal but globally suboptimal or infeasible once the next stage's constraints are
  applied.

## Mapping to architecture

- **Candidate SysML elements:** An "Aircraft Recovery" activity/capability block within
  the OCC/Dispatch domain of the D-002 decomposition, with explicit output interfaces to
  Crew Recovery and Passenger Recovery capability blocks (making the sequential
  ARP→CRP→PRP handoff, and its associated local-optimization risk, visible as an
  architecture-level interface rather than an implicit assumption). The three competing
  objectives (delay/cancellation/swap) are a ready-made example for an Objective/Cost
  ontology entry under §8's Airline stakeholder category.
- **New glossary terms surfaced:** ARP (Aircraft Recovery Problem), CRP (Crew Recovery
  Problem), PRP (Passenger Recovery Problem), connection/time-line/time-band network,
  ferry flight — added to `glossary.md`.
- **New stakeholders/objectives not yet in `stakeholder-register.md`:** No new
  stakeholder class. Confirms and sharpens the existing "Dispatchers — Operational
  optimization" (Technical PESTLE row) and "Airlines — Profitability" (Economic PESTLE
  row) entries by giving them a concrete, literature-grounded objective function
  (delay/cancellation/swap minimization) usable in the §8 objective-cost-value ontology
  pass.

## Confidence / limitations

High confidence — substantially read (front matter, abstract, intro, SLR methodology,
§3 intro, and the full §4 discussion/insights/perspectives section), with all
bibliographic fields confirmed directly from the PDF. This is a review paper without
primary data of its own — its findings synthesize 50 other studies (1984-2022), so
specific numeric objective-function weights or solution-time performance figures should
be sourced from the underlying primary studies it cites, not from this review directly.
The paper explicitly excludes joint ARP+CRP/PRP studies from its scope during selection,
so it may understate how often integrated (system-level) approaches actually appear in
the broader disruption-management literature — cross-check against `hassanDisruptionReview`
and `hu2024disruptionOptReview`, which do cover integrated approaches, before treating the
"studies rarely integrate" finding as fully general.
