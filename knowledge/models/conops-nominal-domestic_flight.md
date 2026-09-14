# Nominal Commercial Flight CONOPS

### Pilot-centered operational thread

## 1. Purpose and Scope

### 1.1 Purpose

Describe the end-to-end execution of a nominal scheduled commercial flight from the **pilot/flight-crew perspective**, emphasizing:

- decisions made during each operational phase;
- information available to the flight crew;
- interactions with other NAS stakeholders;
- authority over trajectory decisions;
- operational constraints;
- aircraft/FMS automation;
- local optimization objectives;
- information exchanged between systems.

The CONOPS should ultimately support analysis of how **locally rational or myopic decisions propagate through the NAS system-of-systems** and affect other stakeholders' MOPs and MOEs.

### 1.2 System boundary

The nominal flight begins **after airline market/network planning**.

Treat as **exogenous/given**:

> Market segmentation → service model → network design → published schedule → fleet assignment strategy

Examples explicitly outside the initial scope include:

- city-pair/market selection;
- hub-and-spoke vs. point-to-point strategy;
- luxury/full-service vs. low-cost service model;
- fleet acquisition;
- long-term network optimization.

**Rationale:** These strategic decisions establish the operating environment within which an individual flight is executed. The capstone is concerned primarily with operational trajectory decisions and their interactions across the NAS, rather than optimizing the airline's underlying business network.

Crew scheduling and individual aircraft assignment sit near the boundary and may be modeled as **upstream interfaces** rather than fully modeled systems.

---

# 2. Nominal Operational Thread

## Phase 0 — Airline Schedule, Fleet, and Crew Assignment

### Initial state

A published flight schedule exists. The airline has:

- aircraft/fleet types;
- individual aircraft;
- qualified flight crews;
- scheduled flight legs;
- airports and city pairs;
- planned departure/arrival times.

Crew scheduling constructs duty sequences/pairings spanning potentially multiple legs, e.g.:

> GRR → DTW → TPA → DCA → PHL → DTW

### Pilot perspective

The pilot receives a duty assignment specifying the flights for which they are responsible.

### Important interfaces

**Airline planning → Crew scheduling → Flight operations → Pilot**

### Research questions

- At what point is a specific **tail number** assigned?
- How stable are aircraft assignments prior to departure?
- What operational information about that aircraft is exposed to pilots?
- What systems do major U.S. airlines use for crew schedule/flight assignment?
- Where should the CONOPS transition from strategic airline planning to operational flight execution?

---

## Phase 1 — Pilot Pre-Duty / Pre-Airport Preparation

The pilot wakes/commutes and checks their assignment through an airline digital system.

Potential information includes:

- duty schedule;
- flight legs;
- aircraft type;
- possibly tail number;
- departure time;
- expected route;
- operational changes.

Potential decision-support information could include:

- historical route performance;
- airport-specific procedures;
- single-engine taxi recommendations;
- takeoff-flap recommendations;
- fuel-efficiency guidance;
- comparison with fleet/peer performance.

### Optimization perspective

This is potentially the first appearance of **local operational optimization**:

> How should this crew operate this aircraft on this flight, given the airline's already-determined schedule?

### Research question

Determine what pilots _actually_ have access to today versus capabilities that would constitute a proposed future decision-support system.

---

## Phase 2 — Reporting for Duty / Dispatch Release

Pilot arrives at the airport and reports for duty.

Flight crew receives/reviews operational flight information, potentially including:

- dispatch/flight release;
- planned route;
- fuel plan;
- payload/passenger information;
- expected gross weight;
- alternate airports;
- weather;
- NOTAMs;
- planned cruise altitude;
- planned cruise speed;
- cost index;
- anticipated SID/STAR;
- anticipated departure/arrival runway;
- operational restrictions.

### Key stakeholder interaction

**Dispatcher ↔ Flight Crew**

This should probably become an important CONOPS interface because operational control is not exclusively a pilot function.

### Research questions

- Exactly what appears in a contemporary U.S. airline dispatch release?
- What remains paper versus EFB/digital?
- When is the release finalized?
- When does the pilot formally accept it?
- What information is subsequently updated?
- What is the regulatory division of authority between dispatcher and PIC?

**Source priority:** FAA regulations/guidance → airline SOP/FCOM documentation → industry standards → academic literature.

---

## Phase 3 — Aircraft Preflight and FMS Initialization

Flight crew enters the aircraft and establishes its initial operational state.

### FMS / avionics initialization

Crew verifies or enters:

- flight plan;
- route/waypoints;
- SID;
- STAR;
- approach, where known;
- alternate/diversion airports;
- aircraft gross weight;
- payload;
- fuel;
- planned fuel at significant waypoints;
- cruise altitude;
- cost index;
- performance parameters;
- expected runway;
- radio/navigation configuration.

Crew reviews:

- weather;
- winds;
- NOTAMs;
- terrain/route considerations;
- diversion options;
- oceanic/special-airspace considerations;
- departure performance.

### Physical aircraft configuration

Configure aircraft and autoflight systems for departure, including appropriate MCP/autopilot/FMS targets and takeoff configuration.

### Key systems

**Pilot ↔ EFB ↔ FMS ↔ Aircraft systems**

with information originating from:

**Dispatcher + Airline systems + Weather + Airport + ATC**

---

## Phase 4 — Boarding, Loading, Fueling, and Departure Readiness

Parallel ground processes converge toward a departure-ready aircraft.

Flight crew coordinates with:

- cabin crew;
- passengers indirectly;
- fueling;
- baggage/cargo/loading;
- gate/ramp personnel;
- dispatch;
- ground operations.

Crew verifies:

- boarding complete;
- doors secured;
- required fuel onboard;
- actual versus planned weight;
- aircraft configuration;
- cabin readiness.

### Important CONOPS characteristic

This is a **synchronization problem**: several independently managed systems must reach compatible states before pushback.

---

## Phase 5 — Clearance, Pushback, and Taxi-Out

Aircraft transitions from airline/gate operations into the active airport movement system.

### Sequence

1. Obtain/confirm ATC clearance.
2. Obtain pushback/ramp authorization as applicable.
3. Coordinate pushback with ground crew.
4. Start/configure aircraft.
5. Obtain taxi clearance.
6. Follow taxi routing.
7. Observe airport signage/markings.
8. Hold short/cross runways as instructed.
9. Maintain separation from aircraft/vehicles.
10. Enter departure queue.

### Stakeholders

**Pilot ↔ Ramp/Apron Control ↔ Ground Control ↔ Tower ↔ Ground Crew**

### Research need

The exact authority chain varies by airport. Distinguish:

- ramp/apron control;
- ATC clearance delivery;
- ground control;
- local/tower control.

---

## Phase 6 — Takeoff and Initial Climb

After runway entry/takeoff clearance:

- align with runway;
- verify takeoff configuration;
- advance/set takeoff thrust;
- accelerate;
- monitor aircraft state;
- retain reject capability before V1;
- rotate at VR;
- establish safe initial climb;
- satisfy departure procedure;
- retract landing gear;
- progressively retract flaps/slats;
- transition from takeoff to climb configuration/thrust.

### Pilot information/control interfaces

- PFD;
- navigation display;
- engine/system displays;
- FMS;
- MCP/autoflight controls;
- thrust controls;
- flight controls;
- radio/data communications.

### Constraints

Aircraft envelope + SOP + SID + ATC clearance + terrain + traffic + weather.

This is an especially useful location for your capstone because the aircraft's "optimal" trajectory is already constrained by objectives belonging to several different systems.

---

## Phase 7 — Climb

Aircraft transitions from terminal-area operations toward cruise.

Pilot/automation manages:

- lateral navigation;
- speed;
- altitude;
- thrust;
- configuration;
- waypoint sequencing;
- ATC clearances.

The desired aircraft trajectory may be derived partly from:

> Aircraft performance + gross weight + weather + cost index

while the **permitted trajectory** is modified by:

> ATC + airspace structure + traffic + SID constraints.

### Important CONOPS distinction

Separate three concepts:

**Desired trajectory → Cleared trajectory → Flown trajectory**

That distinction should probably recur throughout the entire CONOPS.

### Research questions

- How are climb clearances normally issued?
- When do terminal/en-route handoffs occur?
- How commonly are aircraft temporarily leveled?
- How does the 250-knot/10,000-ft restriction interact with individual clearances and procedures?
- Which climb behaviors are SOP versus regulation versus FMS optimization?

---

## Phase 8 — Cruise

Aircraft reaches cruise configuration.

Flight crew monitors:

- aircraft systems;
- lateral trajectory;
- fuel burn;
- planned vs. actual waypoint fuel;
- weather;
- traffic;
- NOTAMs/operational updates;
- dispatch messages;
- destination conditions.

### En-route coordination

Aircraft may undergo multiple ATC sector/facility/FIR handoffs.

### Trajectory modification

Potential changes include:

- direct-to routing;
- rerouting;
- speed changes;
- altitude changes;
- step climbs;
- weather deviations.

Step climbs may become desirable as aircraft gross weight decreases.

### Information/decision loop

**Aircraft state → Pilot/FMS → desired trajectory change → ATC request/clearance → trajectory execution**

with potential external input from:

**Airline dispatch ↔ ACARS/data communications ↔ Flight crew**

This is another particularly strong location for analyzing **who is optimizing what**.

---

## Phase 9 — Arrival Planning and Descent Preparation

Before top of descent, crew develops/updates the arrival plan.

Potentially changing inputs:

- destination weather;
- runway configuration;
- STAR;
- approach;
- traffic;
- NOTAMs;
- aircraft gross weight;
- airport conditions.

Crew updates FMS state and briefs:

- descent;
- arrival;
- approach;
- landing;
- missed approach/diversion contingencies.

Cabin/passengers are prepared for arrival.

### Critical research question

**When do STAR, runway, and approach assignments become sufficiently firm for flight planning?**

The CONOPS should explicitly distinguish:

> anticipated arrival → planned arrival → ATC-cleared arrival → actually flown arrival.

---

## Phase 10 — Descent

Two useful conceptual descent modes emerge from your narrative.

### Unconstrained / energy-optimal descent

Aircraft follows something resembling an optimized idle/airmass descent determined primarily by:

- aircraft performance;
- wind;
- gross weight;
- cost index;
- target arrival state.

### Constrained / geometric descent

Aircraft must satisfy explicit altitude/speed/path constraints, potentially sacrificing locally optimal aircraft performance.

This is an excellent capstone example:

> **Aircraft-optimal descent ≠ ATM-optimal descent ≠ airport-optimal arrival flow**

The pilot/FMS continually reconciles aircraft energy state with:

- STAR constraints;
- ATC instructions;
- speed restrictions;
- traffic;
- runway assignment;
- approach requirements.

---

## Phase 11 — Approach

Flight transitions from arrival/descent to final approach.

Potential approach types include:

- ILS;
- RNAV/RNP;
- GLS;
- visual approach;
- other applicable procedures.

Crew:

- configures aircraft progressively;
- reduces speed;
- extends flaps/slats;
- extends gear;
- intercepts required lateral/vertical guidance;
- monitors traffic and terrain;
- confirms landing minima;
- acquires required visual references;
- evaluates stabilized-approach criteria.

### Systems

**FMS + autoflight + navigation sensors + approach aids + TCAS + TAWS + visual environment + ATC**

---

## Phase 12 — Landing

Crew:

- maintains runway alignment;
- crosses threshold in appropriate state;
- flares;
- touches down;
- lowers nose gear;
- deploys appropriate deceleration systems;
- brakes;
- maintains directional control;
- identifies runway exit;
- exits runway when safe.

A go-around remains an available branch until landing is committed.

---

## Phase 13 — Taxi-In and Gate Arrival

After clearing the runway:

**Tower → Ground → Ramp/Apron → Gate**

Crew:

- obtains taxi instructions;
- follows airport routing;
- monitors ground traffic;
- coordinates gate arrival;
- communicates with ground personnel;
- parks aircraft;
- establishes safe parked configuration.

Ground systems establish required connections/services.

---

## Phase 14 — Flight Termination / Postflight

Crew:

- completes shutdown;
- releases passengers/cabin as appropriate;
- records aircraft discrepancies;
- records required operational information;
- submits flight documentation;
- communicates maintenance issues;
- closes the operational flight;
- prepares for the next leg or ends duty.

This creates a useful boundary question:

> **When does the "flight" end from the perspective of the aircraft, pilot, airline, airport, ATC, and passenger?**

Those answers need not be identical—and that is highly relevant to a system-of-systems CONOPS.

---

# 3. Cross-Cutting Architecture to Capture

For **every phase**, I recommend building the same small analysis block:

|Element|Question|
|---|---|
|**Actor**|Who participates?|
|**Objective**|What is each actor trying to achieve?|
|**Decision**|What decisions are being made?|
|**Authority**|Who has authority to make/approve them?|
|**Information**|What information is available?|
|**Interface**|How is information exchanged?|
|**Constraint**|Regulation, safety, equipment, ATC, SOP, etc.?|
|**MOP**|What local performance is measurable?|
|**MOE**|What higher-level outcome does it support?|
|**Optimization**|What is being minimized/maximized?|
|**Externality**|Who else is affected by that decision?|
|**Research gap**|What claim requires authoritative sourcing?|

That last architecture is potentially more important than getting every procedural detail perfect. Your nominal-flight narrative becomes the **spine** of the CONOPS, while the repeated Actor → Information → Decision → Objective → Constraint → Effect structure gives you a systematic way to expose exactly the phenomenon your capstone is interested in: **different stakeholders optimizing different objectives over different spatial, temporal, and organizational horizons.**