# Hub-to-Hub Trajectory Cost vs. Sector Workload CONOPS

### Dispatcher/ATC-centered operational thread — companion to [[conops-nominal-domestic_flight]]

## 1. Purpose and Scope

### 1.1 Purpose

Elaborates the scenario entry drafted in
[conops-scenarios.md](conops-scenarios.md) ("Hub-to-Hub Trajectory Cost vs. Sector
Workload Tradeoff") into a phase-by-phase operational thread, in the same style as
[[conops-nominal-domestic_flight]]. Where that file is pilot-centered and walks the
full gate-to-gate nominal flight, this one is **dispatcher/ATC-centered** and narrows
to the decision point the capstone actually wants to study: a trajectory request driven
by a multi-attribute generalized cost, absorbed (and possibly modified) by a shared
en-route sector also carrying background traffic.

This CONOPS should make concrete:

- how a **generalized cost function** (fuel + emissions + wear + crew time + passenger
  time/missed-connections, all monetized into one number) drives a dispatcher/crew
  trajectory request;
- how that request interacts with **ATC sector workload/capacity**, which the
  requesting flight does not itself account for;
- the **desired → cleared → flown trajectory** distinction already named in
  [[conops-nominal-domestic_flight]] Phase 7/8, now with an explicit cost attached to
  each gap;
- how **cruise altitude/speed profile management is itself a recurring, discretionary
  source of workload** — dispatch paperwork typically publishes a step-climb/speed
  schedule as *guidance*, not a binding clearance, and each opportunity the crew acts on
  it costs both crew and controller workload in exchange for a fuel/cost saving. This is
  a distinct mechanism from ATC-initiated intervention (Phase C below): the workload
  cost exists even when nothing goes wrong and no one is overloaded — it's the ordinary
  cost of chasing efficiency, not a failure mode;
- where the **background traffic bank** needs to be modeled at all, versus treated as a
  coarse occupancy count;
- where **passenger-borne cost** (missed connections, trip time) actually gets
  realized, several phases downstream of the decision that caused it.

### 1.2 System boundary

Inherits [[conops-nominal-domestic_flight]] §1.2's boundary: airline network/schedule
design, fleet assignment, and crew pairing are exogenous/given. This CONOPS narrows
further:

**In scope, modeled at trajectory fidelity:**

- One **focal flight**, gate-to-gate, on a single hub-to-hub city pair (**not yet
  chosen** — see §5).
- The **en-route sector(s)** the focal flight's cruise segment crosses.
- The dispatcher's/crew's generalized-cost trajectory request and any ATC
  modification of it.

**In scope, modeled coarsely (occupancy/workload input only, not full trajectory
detail):**

- A **background traffic bank** (placeholder: 3-6 aircraft — see §5) sharing the same
  sector/time window as the focal flight, sized only to make sector workload
  non-trivial.

**Out of scope for this CONOPS specifically (though in scope for
[[conops-nominal-domestic_flight]]):**

- Ground-operations phases (boarding, fueling, taxi, gate turnaround) except where they
  set the focal flight's initial state (scheduled departure time, initial fuel load) —
  see [[conops-nominal-domestic_flight]] Phases 0-5 and 11-14 for that detail; this
  document does not repeat it.
- Full trajectory modeling of the background bank — their internal dispatch/crew
  decisions are not this scenario's subject, only their contribution to sector
  occupancy.

**Rationale:** the capstone's myopic-optimization argument doesn't need every aircraft
in the sector modeled at full fidelity — it needs one flight's locally-optimal decision
and enough surrounding traffic that "locally optimal" and "system-optimal" can actually
diverge. Modeling the background bank in full would add cost without adding evidence
for that argument.

---

## 2. Actors and Objective Functions

| Actor | Objective (this scenario) | Decision variable | Authority |
|---|---|---|---|
| **Airline Dispatcher + Flight Crew** (focal flight) | Minimize generalized cost: fuel $ + monetized emissions + maintenance/wear proxy + crew time $ + passenger time/missed-connection cost, all in one commensurable unit — **net of the crew's own workload cost of pursuing it** (see below) | Requested cruise trajectory (speed, altitude, route) at dispatch release; any in-flight delay-recovery speed-up or reroute request; **whether to request each paperwork-indicated step-climb/speed-change opportunity as it arises, or forgo it** | Files/requests the trajectory; cannot unilaterally fly it if ATC modifies the clearance (PIC retains safety-deviation authority per [[conops-nominal-domestic_flight]] Flight Crew persona, but that's a safety escape hatch, not a cost-optimization one) |
| **En-Route ATC** (ARTCC sector controller) | Keep sector workload/complexity within sustainable bounds; maintain separation (hard constraint, not traded off) | Accept, modify (vector/altitude/speed restriction/reroute/hold), or deny the requested trajectory, **including each individual step-climb/speed-change request as it comes in** | Full authority to issue the cleared trajectory; the focal flight's dispatcher has no visibility into or leverage over this decision at request time |
| **Background traffic bank** | Not modeled individually — treated as an exogenous occupancy/workload input | None (out of scope) | N/A |
| **Passengers** (focal flight) | Bears the time/missed-connection term inside the dispatcher's objective function, but has no decision authority in this scenario | None | None — a boundary actor whose cost is decided *for* it, per [[stakeholder-objective-ontology]] Passenger table |

**Note on the generalized-cost function:** cost index already encodes a real-world
version of exactly this tradeoff (time cost vs. fuel cost) inside FMS trajectory
optimization — see [[conops-nominal-domestic_flight]] Phases 3, 7, 8. This scenario's
contribution is **extending that existing mechanism** to include emissions, wear, and
passenger-connection cost as additional monetized terms, not inventing a new kind of
decision from scratch. Emissions must stay a separate line item rather than folding
into the fuel term — see [[stakeholder-objective-ontology]]'s CO2-vs-contrail note for
why the two can diverge.

**Note on workload as its own cost dimension:** the generalized-cost function above
monetizes crew *time* (duty-hour cost) but that's not the same thing as crew or
controller *workload* (task load — monitoring, comparing against paperwork,
requesting, reprogramming the FMS, reading back a clearance). Workload doesn't have an
obvious dollar value the way duty hours do, so it's tracked here as its own MOP for
both actors (see §4) rather than folded into the monetized generalized cost — consistent
with [[stakeholder-objective-ontology]]'s existing Flight Crew "Workload" row and
ATC/ANSP "Sector workload" row, which already treat workload as a cost/penalty
distinct from any dollar term. The mechanism this scenario adds is the **causal link**:
routine efficiency-seeking (step-climb/speed-schedule following) is itself a source of
that workload, not just off-nominal events (reroutes, holds) as those rows originally
implied.

---

## 3. Operational Thread

Phase labels cross-reference [[conops-nominal-domestic_flight]] where a phase maps
directly; Phase B and Phase C's step-request loop have no equivalent there and are new
to this scenario.

### Phase A — Dispatch Release / Trajectory Planning
*(≈ [[conops-nominal-domestic_flight]] Phase 2)*

Dispatcher computes the requested trajectory (route, cruise altitude, cost
index/speed) that minimizes the focal flight's generalized cost, using known/forecast
inputs: winds, weather, gross weight, fuel price, an assumed carbon price, a
maintenance-reserve rate, crew duty cost, and a passenger-connection risk profile for
this flight's downline connections.

The dispatch paperwork issued at this phase typically includes more than a single
filed cruise altitude: it often carries a **step-climb and/or speed-schedule
guideline** (e.g., "step to FL360 once below X lbs gross weight; consider FL380 near
waypoint Y") reflecting how the optimal altitude/speed shifts as fuel burns off. This
guidance is **advisory, not a clearance and not a mandate** — the crew may pursue it,
partially pursue it, or ignore it, and doing so is a live in-flight decision, not
something settled at dispatch. See Phase C for how that decision actually gets made.

At this point the dispatcher has **no visibility** into how many other aircraft will
be requesting trajectories through the same sector at the same time — the background
bank's requests are independent and unseen. This is a deliberate feature of the
scenario, not an oversight: it's the informational gap that makes the eventual sector
overload look "surprising" from the dispatcher's side even though it's structurally
inevitable from the sector's side.

### Phase B — Sector Loading *(new — no equivalent in [[conops-nominal-domestic_flight]])*

The ARTCC sector accumulates the focal flight's initial request alongside the
background bank's. Facility Traffic Management (per
[[system_of_interest_definition]] §7, Air Traffic Control) assesses aggregate demand
against declared sector capacity/workload threshold for the relevant time window. This
sets the **ambient sector busy-ness** that conditions how individual in-flight requests
get treated in Phase C below — it is not a one-time flight-wide verdict, since sector
loading also shifts throughout the cruise segment as the background bank's own flights
proceed.

Exact capacity/workload threshold figures are not yet sourced — see §5.

### Phase C — Cruise: Profile-Following and Tactical ATC Response
*(≈ [[conops-nominal-domestic_flight]] Phase 8)*

**Profile Monitoring and Step-Request Loop.** This recurs some number of times over
the cruise segment (zero or more, depending on flight length and how much the
paperwork profile actually calls for):

1. **Monitor** — crew tracks current gross weight/fuel state against the Phase A
   paperwork step-climb/speed-schedule guidance.
2. **Compare** — is a more efficient altitude or speed now indicated?
3. **Anticipate** — crew estimates whether pursuing it now is worthwhile: proximity to
   top of descent, current cockpit workload, and (critically) the crew's own read on
   how busy/receptive the sector seems.
4. **Decide: request or forgo.** Forgoing is a real, legitimate outcome, not a
   failure — a crew that reads the sector as busy may deliberately skip an available
   efficiency gain rather than add a request to their own or the controller's
   workload. This decision is **invisible to the Phase A generalized-cost
   calculation**, which has no way to know whether the paperwork's assumed step-climb
   schedule will actually be flown.
5. **If requested — clearance and control.** ATC weighs the request against its own
   current (not just Phase B's initial) workload/traffic picture:
   - **Granted as requested.** Efficiency gain captured. Cost: one
     request/clearance/read-back exchange plus FMS reprogramming and monitoring
     through the maneuver — workload for *both* crew and controller, incurred even
     though nothing went wrong.
   - **Modified or denied.** The aircraft holds its current (less efficient)
     altitude/speed longer; the anticipated efficiency gain is partly or fully lost.
     ATC avoids adding to its own workload/complexity at that moment. This reproduces
     the desired → cleared → flown distinction from
     [[conops-nominal-domestic_flight]] Phase 7 exactly, but now recurring per-request
     rather than settled once at dispatch, and with an explicit cost attached to the
     gap.

**This loop, aggregated over however many step-request opportunities the flight
presents, is the scenario's core myopic-optimization instance** — the same conflict
named as the front-runner in [[stakeholder-objective-ontology]]'s synthesis section,
now happening as a sequence of small, traceable, individually-costed decisions on one
specific flight rather than as one abstract pairing or one monolithic dispatch
decision. The two extremes are useful reference points rather than the only outcomes:
**every offered step granted** (system behaving as if every locally-optimal request
were also globally sustainable) vs. **every offered step forgone or denied** (full
erosion of the paperwork's assumed fuel savings) — real flights land somewhere between.

### Phase D — Delay Propagation / Arrival Effects
*(≈ [[conops-nominal-domestic_flight]] Phases 9-10, plus passenger connections)*

Any net cost added across Phase C's step-request loop (forgone/denied efficiency gains,
accumulated request workload) propagates forward. Two sub-cases:

- **Absorbed silently:** the added fuel/time cost is small enough to have no
  downstream schedule effect — it only shows up in the realized generalized cost at
  Phase E.
- **Triggers delay recovery:** the crew/dispatcher decides to recover lost time via a
  cruise speed-up (burning more fuel/emitting more CO2 to protect the schedule and
  passenger connections). This is a **second, nested generalized-cost tradeoff inside
  the same decision chain** — the schedule/delay-recovery-vs-emissions conflict
  [[stakeholder-objective-ontology]] names as a separate §9 conflict is not actually
  separate from the fuel-vs-workload one in this scenario; it's the same generalized
  cost function responding to a second perturbation.

Downline effects realized here: passenger missed-connection risk, crew duty-time
consumption, and (if severe enough) knock-on turnaround impact at the destination hub
— out of this document's modeled fidelity, but worth flagging as the point where this
scenario's cost terms would connect to a future turnaround/gate-assignment scenario if
one gets built.

### Phase E — Postflight / Cost Realization
*(≈ [[conops-nominal-domestic_flight]] Phase 14)*

All generalized-cost terms are tallied against what was actually incurred: fuel $
actually burned, CO2 monetized at the assumed carbon price, wear/maintenance accrued,
crew duty time used, and passenger connections made or missed. The gap between this
realized cost and the Phase A planned cost — and *why* that gap exists (how many
offered step-climb/speed-change opportunities were actually granted-and-flown vs.
forgone-or-denied, absorbed silently vs. recovered) — is the quantity this capstone's
myopic-optimization argument is actually about. This is also the natural point to
compute the "ATC-side" half of the ledger: sector workload actually experienced vs.
declared capacity, and the number of step-requests processed, so both sides of the
tradeoff are measured, not just the airline's.

---

## 4. Cross-Cutting Architecture

Same table structure as [[conops-nominal-domestic_flight]] §3, filled for this
scenario's two decision points.

| Element | Dispatcher/Crew @ Phase A | ATC Sector Controller @ Phase C |
|---|---|---|
| **Actor** | Airline Dispatcher + Flight Crew | En-Route ATC (ARTCC sector) |
| **Objective** | Minimize generalized cost (fuel + emissions + wear + crew time + passenger time/connections) | Keep sector workload/complexity within bounds; maintain separation (hard constraint) |
| **Decision** | Requested cruise trajectory (speed/altitude/route) at dispatch; per-opportunity choice to request or forgo each paperwork-indicated step-climb/speed change; in-flight speed-up/reroute request | Accept, modify, or deny the requested trajectory, including each individual step-request as it arrives |
| **Authority** | Files the request; no leverage over ATC's response | Full authority over the cleared trajectory |
| **Information** | Winds, weather, gross weight, fuel price, assumed carbon price, maintenance rate, crew cost, connection risk, own read on sector busy-ness (informal, not a data feed) — no visibility into other aircraft's requests or ATC's actual workload state | Aggregate sector demand (focal flight + background bank) at dispatch; current real-time workload/traffic picture at each step-request; does not see individual aircraft's cost functions or how much fuel a denial costs them |
| **Interface** | Dispatcher ↔ Crew ↔ ACARS/datalink ↔ ATC | ATC ↔ Crew (clearance/read-back) ↔ Facility Traffic Management (workload assessment) |
| **Constraint** | Aircraft performance envelope, cost index bounds, SOP | Separation standards (hard), declared sector capacity, staffing |
| **MOP** | Realized generalized cost vs. Phase A planned cost; step-climb/speed-change **profile-compliance rate** (opportunities requested-and-flown vs. offered) | Instructions issued per unit time; workload/complexity index; step-requests granted vs. modified/denied |
| **MOE** | Network-wide realized cost vs. planned cost, aggregated across flights like this one | System-wide throughput vs. declared capacity; incident/error rate |
| **Optimization** | Single-flight generalized cost, net of the crew's own workload aversion | Sector-wide workload/complexity |
| **Externality** | Workload cost imposed on ATC (both from requests granted and from processing requests it denies) is not in the dispatcher's objective function | Delay/fuel/emissions cost imposed on the focal flight (and its passengers/crew) by a denial is not in the controller's objective function |
| **Research gap** | Real-world carbon-price/value-of-time/rebooking-cost figures to monetize with (see §5); actual profile-compliance rates and what drives crew request/forgo decisions | Sourced sector workload/capacity threshold and intervention decision rule (see §5) |

---

## 5. Open Parameters / Research Questions

Carried over from [conops-scenarios.md](conops-scenarios.md)'s open issues, plus new
ones specific to this operational thread:

- **City pair not yet chosen** — needed before the en-route sector(s) and background
  bank can be made concrete rather than generic.
- **Background bank size not yet set** — placeholder of 3-6 aircraft; not checked
  against any sourced sector-capacity figure.
- **Monetization factors are placeholders** — carbon price, value-of-time, and
  rebooking-cost figures need a literature source or an explicitly-flagged assumption
  before use in the report.
- **Sector workload/capacity threshold and ATC intervention rule not yet sourced** — new
  to this document: Phase B's "aggregate demand exceeds capacity" test and Phase C's
  choice of intervention type (vector vs. altitude change vs. speed restriction vs.
  hold) both need either a literature-sourced rule (e.g. MITRE/FAA sector-complexity
  metrics) or an explicit modeling assumption.
- **Does the "every step granted" extreme need to be separately modeled at all**, or is
  it purely an analytic baseline computed from the general step-request-loop logic
  rather than a separately-simulated path? Affects how much simulation effort this
  scenario actually needs.
- **Whether "hold" is an in-scope intervention type** or an edge case better left out —
  holds have disproportionate cost/complexity relative to vectoring or a modest speed
  restriction and may not be needed to make the tradeoff visible.
- **How to model the crew's request-or-forgo decision** (new): as a deterministic
  decision rule (e.g., a threshold on perceived sector busy-ness or proximity to top of
  descent), a stochastic compliance rate calibrated to some real-world figure, or
  something else? No literature source identified yet for actual step-climb
  request/compliance behavior — may need to be an explicitly-flagged assumption rather
  than a sourced figure.
- **How many step-climb/speed-change opportunities does a representative flight on the
  chosen city pair actually present** — this depends on stage length and cruise
  altitude/weight profile, which in turn depends on the still-unchosen city pair.

---

## Status

Drafted 2026-09-17, elaborating the candidate scenario entry in
[conops-scenarios.md](conops-scenarios.md) (itself from
[[journal/2026-09-17]]) into a phase-by-phase thread in the style of
[[conops-nominal-domestic_flight]]. Not yet reconciled against literature — the open
parameters in §5 are the specific things blocking that reconciliation. Treat this as a
candidate/working document, not a finalized CONOPS, until the city pair, background
bank size, and monetization/threshold figures are resolved.
