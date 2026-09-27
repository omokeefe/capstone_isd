# Context Diagram — Exchange Evidence, by Connection

_Collates the evidence already in the workspace about **what information moves between the
systems chosen for the NAS context diagram**
([nas_context_diagram.sysml](../../projects/nas-sos-capstone/cameo_models/nas_context_diagram.sysml),
D-007 modeled systems). Organized by the `connect` statements in that file so each link can be
justified in one line and traced to a source. Nothing here is new research: every row points back
to a note that already exists. It feeds `to-do-list.md` §10 (operational IBDs, information-object
model, item-flow model; ECD 2026-10-25 / 10-29) and the "justify each connection" pick from the
2026-09-24 welcome._

## How to read this — evidence grades

| Grade | Meaning |
|---|---|
| **A** | Primary/normative source states the exchange (JO 7110.65BB, A-CDM spec, FAA/EUROCONTROL data standards). |
| **B** | Empirical/observational literature shows the exchange (Seamster 2011, Berry & Pace 2011, Munro 2018, Clarke 1998, Wilke 2014). Small samples; see caveats. |
| **C** | Your own notes, lecture captures, or prework diagram — real leads, not citable evidence. |
| **gap** | Connection drawn in the model, no exchange evidence found in the workspace. |

Global caveats (from [[interaction-catalog-flight-execution]]): the Seamster matrix is **one
constructed KSFO→KJFK flight**, a **2011 draft**, ATC content from 3 retired-controller SMEs,
pilot ratings n=11 (one operator), dispatcher ratings n=4 (one operator); it cites JO 7110.65**T**,
not BB. Row IDs like `E-5#20` = Appendix E Table 5, row 20, and are cited as the catalog cites them
(I did not re-verify each row against the PDF).

## The diagram as written

Parts declared: `environment`, `airportOps`, `airspaceMgmt`, `aircraftSys`, `flightOps`,
`flightCrew`. Connections are made at the **leaf part**, not the domain:
`flightOps.airlineOperationsCenter`, `flightCrew.pilotInCommand` / `.firstOfficer`,
`airspaceMgmt.atc`, `airportOps.airport`, `aircraftSys.aircraft`.

Two housekeeping observations before the evidence:

- Lines 34–35 and 79–80 are the same two `connect` statements twice (AOC→PIC, AOC→FO). One block is
  the "testing" copy; delete one.
- `environment` is declared but has **no connections** — Governance, Passengers, Military,
  Information Systems, Decision Support, Infrastructure, Maintenance Suppliers are all unlinked
  (see the last section).

## Connection-by-connection evidence

### 1. AOC ↔ Pilot in Command / First Officer (`connect` ×2, both duplicated)

**Direction and content**

| AOC → crew | Crew → AOC |
|---|---|
| Dispatch/flight release (route, fuel, payload, alternates, weather, NOTAMs, MEL items) — `E-1` (18 rows), [[conops-nominal-domestic_flight]] Phase 2 | Acceptance of release / requests to change it (commonly **more fuel**; Munro 2018) |
| Pre-flight briefings; amended release (`E-2`, Table A.2#15) | Weight-and-balance confirmation is normally by ACARS; a face-to-face print from the load planner only "if not by ACARS" (`E-2#20`) |
| Reroute, new flight plan, ETA (`E-7#11–13`); alternate/min-fuel advisories (Table 3.1#14) | Fuel on board (`E-7#08–09`, `E-9#06–09`); ETA change >5 min, unplanned holding, reclearance, route change (A.1#41–46) |
| Load/passenger list, final weight & balance (`E-2`) | Diversion / emergency / unauthorized-airport notifications (Table 2.10#03, #11, #12) |

**Correction, 2026-09-24:** an earlier version of this note listed the OOOI reports (`E-3#10`, `E-5#06`,
`E-13#12`) as crew → AOC. They are **"Send Off The Gate / Off The Ground / Into The Gate report
(automated)"**, sent from the avionics (`FD · ACARS`) to the dispatcher, marked "If equipped". They belong on
an **aircraft → AOC** link (see "Exchanges the sources evidence that the diagram does not draw"), not this one. The door/brake/weight-on-wheels sensors
that trigger them are general knowledge, not from the workspace sources.

**Media:** telephone (pre-departure), ACARS, Satcom/ACARS when airborne (Table 3.1#09, #12, #14).
**Authority:** dispatcher and captain both sign the release; captain has ultimate responsibility in
emergencies (Seamster p.33; Table 2.2#05).
**Evidence:** B — Seamster 2011 (Tables 2.2, 2.9, 2.10, A.1, A.2, E-1/E-2/E-7/E-9), Munro & Mogford 2018,
[[conops-nominal-domestic_flight]] Phase 2/8. Most critical items (High): fuel, performance limits, diversion (Table 2.10).
**Note on the leaf part:** `airlineOperationsCenter` is a single node. Berry & Pace 2011 split the AOC
into dispatcher, flight follower, ATC coordinator, etc.; this link is the dispatcher's, and only the
dispatcher talks to the cockpit.

### 2. AOC ↔ ATC (`flightOps.airlineOperationsCenter` → `airspaceMgmt.atc`)

**Direction and content**

| AOC → ATC | ATC / TFM → AOC |
|---|---|
| Flight plan / flight data released into the En Route host (`E-7#14`; Table 2.7#35); AFTN filing | EDCT, ground-delay program, ground stop, reroute advisories (Table 2.9#17–18; Table 3.1#01, #11) |
| Requests to change flight plan before release (Table 2.9#19); alternate destination (Table 3.1#16, optional) | Runway configuration / weather / delay-program advisories relayed by the Command Center (`E-7#05`) |
| Company preferences in bad weather near a hub (Seamster p.34) | Route/delay strategy conferences — Command Center telcons every 2 h, 06:00–20:00 EST (p.22) |
| **CTOP: ranked Trajectory Options Set** filed with TFM (your 09-23 notes; FAA CDM) | CTOP route/delay assignment against FCAs; TMIs (miles-in-trail, GDP, AFP, reroutes) (09-20 notes) |

**Media:** telcon and telephone (Table 3.1#01, #11, #16); ARINC/SITA teletype from the AOC side
(Clarke 1998).
**Structure to reflect in the model:** the dispatcher does **not** talk to ATC directly — the **ATC
coordinator** is the AOC's single point of contact (Berry & Pace 2011, p.4 highlight; Seamster p.34,
p.45). ATC coordinators "push the company's agenda"; in CDM/ICR "the decision is ultimately made by
Traffic Management" (p.46–48). The NASA/lecture slide you captured
([ATC-TFM-aoc-atc-flow.png](../../attachments/ATC-TFM-aoc-atc-flow.png)) draws it as four boxes: controller ↔ traffic manager, controller ↔ pilot,
pilot ↔ dispatcher, dispatcher ↔ traffic manager (FAA vs. AOC ellipses).
**Evidence:** B (Seamster, Berry & Pace); C for CTOP (FAA page, not yet a registered source). **2026-09-26 BB pass:** JO 7110.65BB ¶4-3-4/¶4-4-6 give A-grade evidence for the tower → TMU → ATCSCC conduit, the operator's responsibility to meet the EDCT, and carriers revising EDCTs — but the BB (controller's order) does not describe the AOC ↔ ATCSCC exchange itself, and Ch. 11 doesn't mention the ATCSCC. That exchange stays B/C until JO 7210.3 or FAA CDM/CTOP material is registered. See the BB summary's takeaways ([5 - faa2025jo711065bb.md](../../evidence/literature-notes/summaries/5%20-%20faa2025jo711065bb.md)). **2026-09-27 JO 7210.3EE (CHG 3) pass: the AOC ↔ ATCSCC exchange is now grade A.** The ATCSCC transmits EDCTs "to ARTCCs and linked system users" (¶18-10-6e). Users submit schedule changes to FSM (¶18-10-3) and "must coordinate [GDP] options directly with the ATCSCC" (¶18-10-12). Flight operators send TOS (¶18-12-3b) and Early Intent (¶18-8-2c) to TFMS. They coordinate with the ATCSCC Tactical Customer Advocate (¶18-8-3d) and take part in hotlines (¶18-4-1d) and the Operations Plan webinar (¶18-21-4a). The order says "system users/customers/flight operators," never "AOC," so mapping that role to `airlineOperationsCenter` (via the ATC coordinator) stays a B-grade abstraction (Seamster, Berry & Pace). The table of flows is in [5 - faa2025jo72103ee.md](../../evidence/literature-notes/summaries/5%20-%20faa2025jo72103ee.md).
**Model gap:** the ATC-side counterpart in this link is really **TFM (ATCSCC / TMUs)**, not the tactical
`atc` part. `airspaceMgmt` already contains `atfms`, `trafficFlowMonitoringCenter`, `atcscc`
in [nas_sysml_package_definitions.sysml](../../projects/nas-sos-capstone/cameo_models/nas_sysml_package_definitions.sysml)
(lines ~110–145); consider whether this connect should target the TFM node.

**2026-09-24 evidence that the counterpart is TFM (grade A, European spec):** TFM is the hours-scale layer
above ATC and is "tactical" only relative to schedule planning — EUROCONTROL's system is literally the
"Enhanced Tactical Flow Management System" (A-CDM p.9). In A-CDM the horizon runs from the flight plan at
EOBT−3 h and CTOT issue at EOBT−2 h (pp.17–19) down to per-flight updates. Your 09-20 notes tier it the same
way (national/strategic → regional flow → sector/tower tactical). So the AOC ↔ ATC link should point at TFM
(`atfms` / `atcscc`) via the ATC coordinator, not the tactical `atc` part.
**Modeling idiom (SysML v2 knowledge of the assistant, not a workspace source):** put ports on the
`AirspaceManagement` domain boundary and bind them inward, so the internals can be refined without rewiring the
context diagram.

### 3. AOC ↔ Airport (`airlineOperationsCenter` → `airportOps.airport`)

**Direction and content:** Airline → airport/AMS: flight schedules, boarding info; airport → airline:
gate assignments, boarding status (hub table, [[interface-exchange-draft]] "Airlines" row — **grade C**,
directions unverified). Station Operations Control Centers control gates, refuelers, catering, ramp and
passenger handling for the AOCC (Clarke 1998). Dispatch's known frictions with stations: late
passengers/gate agents (Munro 2018). A-CDM defines the **milestone approach** (target/estimated/actual
times) for airline ↔ airport ↔ ANSP ↔ network sharing (EUROCONTROL spec, grade A; the 2026-09-24
read is summarized below).
Gate/ground-power uplink to the crew is itself an AOC/airport→cockpit message (`E-10#14`).
**Evidence:** one prework diagram (C), Clarke (B, 1998), A-CDM (A, partial read, European), GreAT D2.2
Table 3 (below). Improved from the thinnest link, but the US-specific sources are still missing.
**Gap:** [[interface-exchange-draft]] directions still need checking against the source PDF; A-CDM alerts,
requirements and annexes are unread.

**Owner input, 2026-09-24 (grade C — your domain knowledge, not yet sourced):** AOC and airport
**negotiate takeoff/landing times** (slots) and communicate **expected passenger counts, food
(catering) needs, fuel needs, baggage needs, and weight & balance**, "maybe others." Split of what
that adds to the table above:

| AOC → airport | Airport → AOC |
|---|---|
| Expected passenger count; catering, fuel, baggage/cargo requirements; W&B / load data | Gate assignment; fuel/catering/baggage service availability and readiness |
| Requested takeoff/landing times (schedule) | Accepted/adjusted slot times (negotiated, so bidirectional) |

Where the existing sources touch these: fuel, catering, ramp handling and gates sit under the airline's
Station Operations Control Centers (Clarke 1998); load planning and W&B are AOC-side and consumed by
dispatch (Munro 2018; `E-2` final W&B, load & passenger list). Slot negotiation at the airport is the part
with **no source yet** in the workspace beyond the hub draft's "submit flight schedules."
Candidate information objects added: `ExpectedPassengerCount`, `CateringRequirement`, `FuelRequirement`,
`BaggageRequirement`, `LoadAndBalance`, `SlotRequest`/`SlotAssignment`.

**A-CDM read, 2026-09-24 (grade A, but a European spec — a pattern, not a US standard; §§1–5.1.15 and
roles only, alerts/requirements/annexes not read):**

- **Partners** (pp.11–13): Airport Operator, ATC, Aircraft Operator, Ground Handling, Network Manager;
  Met, Stand and Gate Planning as supporting roles.
- **Ownership:** the Aircraft Operator owns the flight plan and the **TOBT** (target off-block time), and can
  delegate the TOBT to the ground handler.
- **Times are computed, not negotiated.** Landing time comes from Network Manager estimates. Chain: TOBT →
  pre-departure sequencer (with ATC) issues **TSAT** (target start-up approval time) → **TTOT** (target
  take-off time), where TTOT = TOBT + estimated taxi-out time (p.20). The one real negotiation is the airport
  slot at fully coordinated airports — a long-horizon, scheduling-level exchange. This narrows your
  "negotiate takeoff/landing times" input: day-of-operation times are derived; only slots are negotiated.
- **Milestone events**, each with a defined trigger, owner and alert rules: ATC flight plan activated,
  boarding started, aircraft ready, start-up requested and approved, off-block, take-off.
  Off-block can be detected by A-SMGCS or docking guidance, or keyed in by airport ops (p.36); take-off comes
  from tower systems, radar or ACARS (p.37); "Aircraft Ready" is reported by the crew and recorded by the
  controller (p.32). So the source of each milestone depends on equipage and local setup.
- **Not A-CDM exchange objects:** passenger counts, catering, fuel and baggage. These are handling
  requirements between airline and ground handlers/suppliers and need a different source.

Net for the model: candidate information objects `TOBT`, `TSAT`, `TTOT` and the milestone events replace
`SlotRequest`/`SlotAssignment` for day-of-operation exchanges; the slot objects stay for the scheduling
layer only.

### 4. ATC ↔ Pilot in Command (`airspaceMgmt.atc` → `flightCrew.pilotInCommand`)

The best-evidenced link in the model. Catalog transitions 1–15 ([[interaction-catalog-flight-execution]] §3) cover it end to end.

| ATC → crew | Crew → ATC |
|---|---|
| IFR clearance/PDC with squawk, hold-for-release if EDCT (`E-2#10`) | PDC request via ACARS (`E-2#07–09`; Tables 2.3#01, 2.5#01 — rated critical) |
| Pushback, taxi clearance and hold-short (`E-3#04`, `E-4#02–14`) | Read-backs (`E-4#14`, `E-5#03`); intentions (pushback, taxi, de-icing, takeoff) (Table 2.7#21) |
| Takeoff / approach / landing clearance (`E-5#02`, `E-11#05`, `E-12#35`) | "Ready", ATIS identifier on initial contact (Table 2.3#02) |
| Altitude/heading/speed/route clearances, direct-to (`E-5#14–17`, `E-6#05–08`) | Position, altitude-vacating and reporting-point reports (Table 2.5#08; A.1#32–35) |
| Handoff frequency changes (`E-6#03–04`) | Traffic-in-sight, unable-visual-separation (A.1#25, #28) |
| ATIS, traffic advisories, wind/braking action (Table 2.7#06, #10, #34) | Deviation requests for weather (Table 2.4#06); emergency declaration (Table 2.6) |

**Media:** radio dominates (145 of ~277 matrix rows); ACARS 32; PVD 17; interphone/phone between ATC positions. CPDLC only oceanic in the 2011 report.
**Authority:** clearances are "procedural interactions where just one of the participants has ultimate responsibility… little room for negotiations" (p.46).
**Evidence:** A (JO 7110.65BB paragraph pointers per transition, e.g., 3-7-2, 3-9-10, 4-3-2, 4-8-1) + B (Seamster).
**Limit:** BB paragraph numbers are pointers; **decision-authority text is not yet extracted** (catalog header). The nominal Final Approach table has no explicit "clear to land" row (`E-12#35` only).
**Model note:** `flightCrew.firstOfficer` has no ATC connect in the file — but the FO does the radio work in several rows (`E-2#07`, `E-4#02–04`). Decide whether that is intended (PIC as the authority endpoint, per the PF/PM → Captain/FO abstraction) or an omission.

### 5. ATC ↔ Aircraft (`airspaceMgmt.atc` → `aircraftSys.aircraft`)

**Content (machine-to-machine, not voice):** surveillance returns — ASR/ARSR primary and secondary radar
feeding ATCT, TRACON and ARTCC displays; ATCRBS, ASDE-X, ARTS, ERAM (your 09-20 lecture notes,
[ATC Surveillance Flow.png](../../attachments/ATC Surveillance Flow.png)); TCAS/transponder failure reporting (Table 2.1#04, #11). Controller
"team" sees a datablock and handoff status via PVD/HOST (`E-5#20–21`, `E-6#01–02`).
The only **normative** path for instructions to the aircraft is via the crew (link 4); ATC→aircraft is
sensing, and aircraft→ATC is a transponder/ADS-B broadcast.
**Evidence:** C (lecture capture) for the surveillance chain; B for the datablock/handoff use (Seamster
App. B p.6). Mordecai 2018 (**cyber-physical gap** between an aircraft's actual state and ATC's tracked
representation of it) is the conceptual source for why this link matters to the trajectory-intent chain, though it is one case study (MH370) in OPM, not SysML.
**Judgement call to defend:** either label this as *surveillance* (data ATC↔aircraft) and keep instructions on the crew link, or remove it — leaving it unlabeled reads as ATC commanding the aircraft directly.

### 6. Crew ↔ Aircraft (`pilotInCommand`/`firstOfficer` → `aircraftSys.aircraft`)

**Content:** control inputs, FMS/MCP entries, configuration changes; aircraft → crew: PFD/ND/engine
displays, alerts, TCAS/TAWS ([[conops-nominal-domestic_flight]] Phases 3, 6, 11–12; "Pilot ↔ EFB ↔ FMS ↔ Aircraft systems").
FMS initialization inputs: route, SID/STAR, weights, fuel, cost index, performance (Phase 3). Automation is
"a fourth collaborator only for NextGen" (Seamster p.45) — in the 2011 matrix it is allocated to a group, not a party.
**Evidence:** C/B — physical flight-deck interaction is mostly outside the interaction-matrix sources; the
ConOps is your own thread and needs FCOM/FAA AC citations (Phase-3 "source priority: FAA regulations → FCOM → standards → academic").
Also Hossain 2022, Mhenni 2016, Great 2021 D5.1 (avionics architecture) are candidate B-grade avionics-interface
sources but I did not pull their interface content this pass.

### 7. Crew ↔ Airport (`pilotInCommand`/`firstOfficer` → `airportOps.airport`)

**Content:** gate/ramp interactions — pushback authorization and parking-brake/engine-start cues with the
pushback crew (`E-3#05–13`), guidance to jetway, gear-secured sign (`E-13#10–13`), ground handling status
(`E-2`, `E-13`). Wilke 2014: the pilot obtains pushback clearance from ATC and **relays** it to the tug driver;
ground handling is only *indirectly* linked to ATC; "location" is an unplanned second interface.
**Evidence:** B — Seamster (RAMP group added because load planners and pushback/ground crews fit neither ATC nor FOC); Wilke 2014 (Safety Science, rigorous, safety-scoped).
**Open:** who has authority to push back onto the active surface ("depends whether ramp has authority", p.42) — not resolved by the sources. `airport` is one node standing in for ramp, apron control, ground handling.

### 8. Aircraft ↔ Airport (`aircraftSys.aircraft` → `airportOps.airport`)

**Content that the sources actually describe:** aircraft turnaround support — fueling, ground power, servicing, baggage/cargo loading, boarding/deplaning; airport → aircraft: fuel, GPU/preconditioned air, jetway/gate position; aircraft → airport: OOOI events (via ACARS, which arrive at the AOC not the airport), MEL/maintenance discrepancies at the gate. Schultz 2017 turnaround activities (catering, fuel, boarding, W&B, ready) map to swimlanes. Lu 2025 (digital-twin turnaround) and Kontodimou 2026 (turnaround buffers, upstream/downstream schedule interface) are supporting.
**Owner input, 2026-09-24 (grade C):** airports **broadcast radio beacons used for relative position
finding (ILS, etc.)**. That is an information flow airport → aircraft, so this link is not only material.
In the model it is only an attribute today (`Runway.equipment: "ILS", "PAPI"`, package definitions line 275).
Also on the source list: your 09-20 captures of glide-slope and localizer/DME antennas
([GlideSlopeAntennae.png](../../attachments/GlideSlopeAntennae.png), [LocalizerDME.png](../../attachments/LocalizerDME.png)).
**Ownership, checked 2026-09-24 against the FAA NAS infrastructure roadmaps (grade B):** ILS is an FAA NAS
asset (project N03.01-00, ILS CAT I and CAT II/III), but the roadmaps also say non-federal navaids exist at
some airports. So neither "airport-owned" nor "FAA-owned" is right everywhere.
**Proposed modeling (not adopted):** use association, not ownership. In SysML v2 `part` means contained and
owned; `ref part` means associated. `Airport` would hold `ref part navaids` pointing to navigation-aid parts
that live in Infrastructure, each with a `maintainer` attribute (FAA, airport, other), and the signal flow runs
navaid → aircraft. D-007 still puts navaids in *Infrastructure* (context constraint). The same pattern fits
`controlTower`: a physical facility at the airport, with controllers who are ATC.
**Evidence:** B-grade for the turnaround *activities*; the material exchange (fuel, bags, pax) dominates the sources, plus the C-grade navaid signal above. Consider item flows here as both material (fuel, cargo, passengers) and data (nav signal, ground-power/gate uplink).
**Gap:** draft only. This is also `connect airportOps.airport to aircraftSys.aircraft` in lines 37 **and** 97 — the same link is stated in both directions in two places (`airport`→`aircraft` at 37, `aircraft`→`airport` at 97). SysML `connect` is undirected, so this is a duplicate too.

### 9. Airport ↔ ATC (`airportOps.airport` → `airspaceMgmt.atc`)

**Content (AMS table, [[interface-exchange-draft]], grade C, directions "most confidently reconstructed"):**
ATC → AMS: takeoff/landing clearance; AMS → ATC: departure and arrival times, clearance requests.
Beyond the hub draft: runway configuration changes and Tower TMU reports to the Command Center and adjacent TMUs (`E-7#01–03`);
Tower/GC/LC coordination on runway crossings (Table 3.1#05); airport capacity (arrival/departure rates) into flow programs (Roman I. de Oliveira 2026: predicted airport arrival/departure capacity, hours-scale, feeds CTOP/dynamic re-sectorization); ATCT departure release times from TBM (your 09-20 notes quoting JO 7110.65; TMI paragraphs 11-1-1..3 per Seamster Table 2.7#26–27).
**Evidence:** B/C. The hub draft conflates the airport *operator* with the **tower** (ATCT is an FAA facility at the airport). The model's `atc` part sits in `airspaceMgmt` and `airport` in `airportOps`, which follows D-007 but means most tower coordination is *intra-ATC*, not ATC↔airport.
**Gap:** A-CDM information objects; the Airport Operations data model.

## Open ownership question: who do apron, tower, and departure/arrival controllers belong to?

Your read (2026-09-24): unsure whether apron control towers work for the airport or for the ANSP/ATC;
departure/arrival controllers are probably ATC/ANSP.

| Facility / role | Where the model puts it today | What the workspace evidence says | Read |
|---|---|---|---|
| **TRACON departure/arrival controllers** | `AirspaceManagement::tracon` (line 114) | 09-20 notes: FAA ATO → Terminal Airspace → TRACON (traffic mgmt, arrival, departure controllers). Seamster/BB treat them as ATC positions (Departure R/RA, Approach R/RA). | **ATC/ANSP — consistent with your guess and the model.** |
| **ATCT tower: clearance delivery, ground, local** | `AirportOperations::controlTower` (line 251), inside the airport | 09-20 notes list "Airport ATC → ATCT → local, ground, clearance delivery" **under the ANSP/FAA ATO**, and separately list "ANSP/ATC → Tower, Ground control" inside the *airport ecosystem*. Catalog crosswalk maps Tower CD/GC/LC to ATC personas. BB (2-10-3) defines Tower team positions. | **Functionally ATC/ANSP, physically at the airport.** The model's `controlTower` inside `Airport` contradicts the `atc`/`tracon` placement. |
| **Apron / ramp control** | `Apron` (line 285) — a surface, described as "gates, taxi, takeoff & landing movement surface"; no controller | **JO 7110.65BB (grade A, read 2026-09-24):** the glossary defines nonmovement areas as "taxiways and apron (ramp) areas not under the control of air traffic"; ¶3-7-2 says their movement is the responsibility of the pilot, the operator or airport management; at towered airports, entry onto the movement area needs ATC approval, and ATC ground control issues taxi routes on the movement area. **A-CDM §4.3 (p.11):** clearance delivery, ground movement control and runway control are ATC; apron control is ATC "in some cases" and the Airport Operator in others. **GreAT D2.2:** Tower Control Center issues pushback, taxi-out and takeoff clearances, Airport is a separate node. Also Seamster p.42 ("depends whether ramp has authority"), Wilke 2014, ConOps Phase 5. | **The boundary is movement area vs. nonmovement area, not taxi vs. takeoff.** Apron/ramp is airport-driven (pilot/operator/airport management); movement area (taxiways, runways, airborne) is ATC. "Taxi is airport-driven" holds only on the ramp and non-movement taxiways. Still varies by airport for apron control (A-CDM). Pushback authority (BB has no pushback text) remains a local-arrangement question. |

Consequences for the diagram: (a) `airportOps.airport` currently stands for both the airport operator
and the tower; (b) the ATC ↔ airport link (9) shrinks or changes meaning once the tower is treated as
ATC — the ground/local/clearance-delivery exchanges become ATC ↔ Pilot (link 4) and intra-ATC;
(c) the airport-side counterpart for the pilot at the ramp is the apron/ramp service, not ATC. Proposed
decisions for you to make (**none logged yet** — draft entries for accept/reject are one of the pending
actions): tower controllers = ATC by *function* even though co-located, `controlTower` in `Airport` = the
physical facility only, and the ATC/airport boundary = movement area vs. nonmovement area.

## Exchanges the sources evidence that the diagram does not draw

| Exchange | Evidence | Why it might matter |
|---|---|---|
| **AOC ↔ Aircraft** (ACARS/OOOI, load/weight uplink, gate/ground-power uplink, dispatch messages) | Seamster (ACARS = 32 rows; OOOI rows `E-3#10`, `E-5#06`, `E-13#12` are automated avionics → dispatcher reports, "If equipped"); weight & balance normally by ACARS (`E-2#20`); FAA roadmap lists ACARS "Weight & Balance" and "PDC & D-ATIS" services; A-CDM p.36–37 shows ground-side alternatives for off-block/take-off detection; Clarke 1998 (ARINC/SITA); ConOps Phase 8 | The diagram's own "Theorize" comment (lines 56–61) says Flight Ops **receives data from Aircraft Systems**, but no `connect` implements it. This is direct evidence for an aircraft → AOC link that **does not go through the crew**. Depends on equipage and local setup. |
| **AOC ↔ Airspace Mgmt beyond `atc`** (TFM/ATCSCC/TMU, CTOP, TMIs, EDCT) | see link 2; `atfms`, `atcscc` already in the package | The strategic/network layer is where §9 local-vs-system conflict lives (ATC coordinator vs. Command Center). |
| **ATC ↔ ATC** (sector handoff, point-out, tower↔TRACON release, TMU ↔ Command Center) | Catalog transitions 5, 7, 9, 10; Table 3.1#06, #10, #13, #18–19 | Largest share of the matrix; intra-domain, so outside a context diagram, but it belongs in the operational IBD. |
| **ATC ↔ First Officer** | see link 4 | Diagram has PIC only. |
| **Crew ↔ AOC ↔ Airport (turnaround synchronization)** | ConOps Phase 4 ("synchronization problem") | Boarding/fuel/loading/dispatch must converge before pushback — a multi-party exchange rather than a pairwise one. |

## Environment / boundary actors (declared, not connected)

Disposition per D-007 in [[system_of_interest_definition]]; evidence that the boundary exchanges exist:

| Boundary element | Exchange with modeled systems | Evidence |
|---|---|---|
| **Governance / Regulatory** | Rules, certification, standards flow down (14 CFR 91/121, AC 121-32A, JO 7110.65BB, FAA 8900.1; FAA data standards via CCB/NIAC); feedback via incident reports, hearings | A — Seamster constraints list; MITRE/FAA data-standards paper (2001; FAA NIAC/CCB as authority over NAS data standards); Yao 2026 (**authority fragmentation as a named risk**) |
| **Information Systems (SWIM etc.)** | Publish/subscribe of flight plans, positions, trajectories, flow-control messages, METAR/TAF, TFMData; FIXM as the schema for flight data | A/B — FIXM US Extension v4.4.0 (schema), Roman I. de Oliveira 2026 (concrete SWIM interfaces), MITRE 2001. D-007: modeled as *exchanges*, channels only when they change a decision/KPI. |
| **Decision Support** | Recommendations and information dependencies to operators/ATM (e.g., sector-count and capacity prediction → CTOP/re-sectorization; ARP output → crew/passenger recovery) | B — Roman I. de Oliveira 2026; Santana 2023 (ARP→CRP→PRP handoffs); Castro 2013 / Bouarfa 2018 (MASDIMA agent negotiation) |
| **Passengers** | Demand and willingness to pay → airline schedule/fare/frequency choices; check-in, boarding, baggage, flight status ↔ AMS | C for the exchange table ([[interface-exchange-draft]]); B for the demand→schedule link ([[stakeholder-objective-ontology]]); mediated by airline decisions per D-007 |
| **Military** | Special-use-airspace status, traffic priority as scenario conditions | Excluded from operator population; exchange enters as a constraint. Sources: none specifically for exchange — only the D-007 rationale. |
| **Infrastructure / Airspace Resources** | Navigation, comm, surveillance, weather infrastructure (satellite, VOR, ILS, radar) provides signals/data | C/B — 09-20 notes (equipment lists), FAA NAS infrastructure roadmaps 2025, FAA services hierarchy 2025 (ATM infrastructure management). |
| **Maintenance Suppliers** | Parts/cost/availability as parameters into airline maintenance decisions; maintenance discrepancies ↔ AOC maintenance control | B (Berry & Pace: maintenance controller role); exogenous per D-007. |

### How to link the environment (2026-09-24 assessment; proposed, not adopted)

Environment influences are a different kind of flow from the operational `connect`s: one-way, exogenous, and
often dynamic. Draw them as a separate kind of directed flow so the two are distinguishable on the diagram.
Three kinds worth separating:

| Kind | Examples | Character |
|---|---|---|
| **Rules** | Governance: regulations, standards, certification | static |
| **Disturbances** | weather, demand, military / special-use airspace | dynamic; scenario inputs |
| **Feedback** | incident reports, delay and passenger response | flows back toward decision-makers |

Link only where an influence changes a decision; wiring the environment to every part clutters the diagram.
**Catch:** `Environment` is one undecomposed part (D-008), so saying *which* influence goes *where* needs
either sub-parts (governance, weather, demand, …) or typed flows. Precedent: GreAT models Weather and Aviation
Information Management as nodes with needlines to ATFM, airline and aircraft; treating weather as environment
is a defensible difference from it. This interacts with the open Information Services / Decision Support
placement question in `open-questions.md`.

## Precedent architecture read 2026-09-24: GreAT D2.2 (rated 5/5)

Figure 3 (p.29) is an IBD of 10 nodes with numbered ports and needlines: **Airport, Airline Operations Center,
ATFM Center, Aviation Information Management, Weather Service, ARTCC, Area Control, Approach Control, Tower
Control, Aircraft.** Observations relevant to the context diagram:

- **No separate flight-crew node** — supports merging PIC / FO into one crew element (see abstractions below).
- **Airport is separate from Tower Control**, matching A-CDM's separation of airport operator from ATC.
- **Pre-departure loop (Table 3, pp.43–44):** AOC submits an initial trajectory to ATFM; ATFM returns airspace
  status and constraints; AOC submits a TOBT to the Airport, which allocates the departure slot and taxi route;
  Tower, ATFM, Airport, Area and Approach then negotiate the departure trajectory.
- **Airline system interfaces (§5.4.17–19):** receives airspace status, TFM strategies and weather; sends the
  flight plan and route application; receives the confirmed new track.

Caveats: a 2021 EU–China future-concept (TBO) architecture, not the current NAS. The Table 3 column layout is
garbled in text extraction, so the assignment of rows to nodes is **inferred**. The Tower state machine is
unreadable at this resolution. §5.2 and the cruise-to-taxi-in event traces were **not read**.

## Abstractions to defend (not yet in `decisions/decisions-log.md`)

| Abstraction | Reason | What it loses |
|---|---|---|
| **Merge PIC, Captain and FO into one crew element** | GreAT D2.2's IBD has no separate flight-crew node; the PF/PM → Captain/FO abstraction was already used for the Seamster crosswalk | The pilot-flying / pilot-monitoring authority distinction (e.g. FO does much of the radio work, `E-2#07`, `E-4#02–04`) |
| **AOC leaf as one node** | Context-diagram level; only the dispatcher talks to the cockpit | ATC coordinator vs. dispatcher authority split (Berry & Pace 2011) — relevant to §9 |
| **Environment as one part with typed flows** (proposed) | D-008 keeps it undecomposed | Which influence reaches which part, unless sub-parts or flow types are added |

## Cross-cutting patterns worth carrying into the IBD

- **Media inventory** (Seamster, rows in the E-tables): Radio 145 · ACARS 32 · PVD 17 · Face-to-Face 15 · Phone 14 · Interphone 12 · Computer 7 · Host 6 · URET 6 · Interphone/gesture 5 · Telcon 3 · Satcom 3 · FMS 2 · Gesture 2. Radio dominates ATC↔crew; ACARS/phone dominate crew↔AOC; telcon/phone dominate AOC↔ATC and intra-ATC. Suggests the interface types are **by medium** (Radio, ACARS, Phone/Telcon, PVD/HOST, Face-to-face), not one per pair.
- **Candidate information objects:** flight plan, dispatch release (distinct from the flight plan — Munro), amended release, PDC/IFR clearance, EDCT, load & passenger list, final weight & balance, ATIS identifier, datablock/handoff, advisory (runway configuration, delay program, weather), fuel on board, OOOI reports, gate assignment/ground-power uplink; from other sources: TOS (CTOP), surveillance track, sector count/capacity prediction, boarding status, baggage status.
- **Three trajectory states recur:** desired → cleared → flown (ConOps Phase 7); anticipated → planned → cleared → flown arrival (Phase 9). Each label is a distinct information object, not a status flag.
- **Timescales attached to exchanges:** strips printed 30 min before the fix/airport; Command Center telcons every 2 h; dispatcher contact with each monitored flight at least every 2 h; holding instruction ≥5 min before the fix; release 60–90 min before domestic departure (Munro); tactical/network/strategic TFM tiers (09-20 notes).
- **Friction points already flagged** (candidate §9 seeds): ATC coordinator vs. Command Center flow decisions; flight release vs. ATC clearance; pilot/dispatcher/ATC fuel and deviation decisions; ATC retains tactical control ([[interaction-catalog-flight-execution]] §5). Plus dispatch ↔ load planning ↔ pilots ↔ stations negotiating fuel/weight (Munro; the double 1,000 lb ZFW buffer).

## Coverage summary — is each drawn connection defensible?

| # | Connection | Best evidence | Grade | Weakness |
|---|---|---|---|---|
| 1 | AOC ↔ PIC / FO | Seamster T2.2/2.9/2.10, E-1/E-7/E-9; Munro | B | duplicated `connect`; AOC leaf is generic; OOOI is not on this link |
| 2 | AOC ↔ ATC | Seamster T3.1, Berry & Pace; A-CDM pp.9, 17–19; CTOP notes | B; A for the tower/TMU/ATCSCC conduit (BB ¶4-3-4, ¶4-4-6); **A for operator ↔ ATCSCC/TFMS flows (JO 7210.3EE Ch. 18, 2026-09-27)**; AOC-as-"system user" mapping B | real counterpart is TFM / ATC coordinator, not tactical `atc` (now evidenced) |
| 3 | AOC ↔ Airport | hub draft; Clarke; A-CDM (partial); GreAT D2.2 Table 3 | C/B | improved, but European sources; day-of times are computed, only slots negotiated |
| 4 | ATC ↔ PIC | JO 7110.65BB + Seamster E-1..E-13 | **A/B** | FO has no ATC link |
| 5 | ATC ↔ Aircraft | Lecture surveillance chain; Mordecai 2018 | C | needs a label: surveillance, not command |
| 6 | Crew ↔ Aircraft | ConOps thread | C | needs FCOM/AC sources |
| 7 | Crew ↔ Airport | Seamster RAMP, Wilke 2014 | B | authority to push back unresolved |
| 8 | Aircraft ↔ Airport | Schultz 2017, Lu 2025 (activities); FAA roadmaps (ILS) | B (activities) / gap (information) | mostly material flows; also stated twice (lines 37, 97); navaid ownership varies (use `ref part`) |
| — | *Aircraft → AOC (not drawn)* | Seamster OOOI rows, `E-2#20`; A-CDM pp.36–37 | B/A | missing link; equipage-dependent |
| 9 | Airport ↔ ATC | hub draft; Seamster E-7; Roman I. de Oliveira | B/C | hub draft conflates airport operator with tower |

## Sources not yet mined for this (would raise the weak grades)

- **EUROCONTROL A-CDM spec** — §§1–5.1.15 and roles read 2026-09-24; alerts, requirements and annexes still unread.
- **JO 7110.65BB** — ¶3-7-2 and the glossary read 2026-09-24. You are now reviewing BB yourself to extract
  interfaces (¶11-1 TMIs, ¶2-10, 3-9-10, 4-3-2/-4, 5-4-5..-9); nothing from that review is folded in here yet.
- **FIXM v4.4.0** — no per-class extraction yet; would give real field names for the information objects above.
- **GreAT D2.2 operational architecture** (rated 5/5) — Figure 3 and the pre-departure loop read 2026-09-24; §5.2 and the cruise-to-taxi-in event traces unread.
- **Castro 2013 / Bouarfa 2018** — AOC-internal message structures (aircraft/crew/passenger manager agents).
- **FAA CTOP page** (cdm.fly.faa.gov) — not registered as a source yet; cite only after `process-references`.
- **`prework/gpt_convos.md`** — 23 hits on "interface/exchange"; not consulted (AI conversation, grade C at best).

## Status

Compiled 2026-09-24 from existing notes. Updated 2026-09-26 to fold in the 2026-09-24 reads (A-CDM
§§1–5.1.15, GreAT D2.2 Figure 3 / Table 3, JO 7110.65BB ¶3-7-2 and glossary, Seamster OOOI rows, FAA NAS
infrastructure roadmaps); page and row references for those reads come from that session's report and were
**not re-verified against the PDFs** on 09-26. No `.sysml` edits made.

**2026-09-27 — `.sysml` updated.** The anonymous `connect`s are now named `connection`s, each carrying a doc comment with its exchanges, evidence grade and sources, and the owner's exchange notes in the file are marked up with [A]/[B]/[C] verdicts and TODOs. New connections: `aocTfm` (AOC ↔ `atcscc`, A, 7210.3EE Ch. 18), `aocAircraftDatalink` (the aircraft → AOC link in the table above, B), `atcToFo` (B) and `atcsccTmu` (A, internal to Airspace Management). The old AOC ↔ `atc` link is kept as `aocFlightPlanFiling` (A, 7210.3EE §6-5). This implements the D-009 candidate as a split, not a pure retarget, and it has **not** been logged; it still needs the owner's acceptance. `tmu` ↔ `atc`, the environment links and a port/item-flow example exist only as commented drafts. Line numbers cited above refer to earlier versions of the file. Row IDs are as cited in
[[interaction-catalog-flight-execution]]. Directions in the airport hub table remain unverified
against the PDF ([[interface-exchange-draft]] caveat). Not reconciled with `to-do-list.md` §10 —
that checkbox state is unchanged.

**2026-09-27 — aircraft ↔ airport (link 8) settled by the owner.** The exchanges exist and are mostly material. The model keeps the complete set as 20 per-exchange `connection`s, none rendered, with `aircraftAirport` as the one rendered summary line. The reason the owner gave: none of them affect optimality, because each one carries out a decision made on another actor's link (AOC fuel/load orders, passengers, weather, maintenance status, ATC/ramp clearance). Navaid signals are in the set as `apNavaidSignals`, with the far end at `environment.infrastructure` per D-007.

**2026-09-27 — D-009 logged.** Three decisions are now logged, not just proposed: the AOC ↔ TFM split; the PIC/FO merge into `flightCrew.flightDeckCrew` (the "Merge PIC, Captain and FO" row in "Abstractions to defend" above); and the mapping of "system users / flight operators" to `airlineOperationsCenter`. Every system on the diagram now has a D-007 disposition, both in `decisions/decisions-log.md` D-009 and as a comment on its part. Connection names changed with the merge: `aocToCrew`, `atcToCrew`, `airportToCrew`, `crewAircraft`.
