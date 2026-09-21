# Interaction Catalog — Flight Execution (flight deck · ATC · airline OCC/FOC · ramp)

_Project-vocabulary synthesis of the flight-execution interactions extracted from Seamster et al. (2011)
([[seamster2011collabSystems]]; rows in [seamster2011collabSystems-interactions.md](../../evidence/literature-notes/annotations/seamster2011collabSystems-interactions.md)),
tied to FAA JO 7110.65BB ([[faa2025jo711065bb]]). It answers three questions: **who in the source is who in this
project (and what abstraction that involves, and why)**, **which source rows implement each to-do §4 control
transition**, and **which interactions are candidate §9 friction points.** It does not repeat the ~700 extracted
rows — it cites them by ID (`E-5#20` = Table E-5, row 20). Feeds `to-do-list.md` §4 (Nominal ATC Flight
Execution), §7 (RACCI), §10 (information objects / interfaces) and the ConOps ([[conops-nominal-domestic_flight]],
[[conops-scenarios]])._

## Read this first — what this evidence is and is not

- The matrix (Tables E-1..E-13) is **one constructed flight (KSFO→KJFK)**, built from FlightAware logs, LiveATC audio and manuals,
  not observed practice across the NAS. ATC content comes from 3 retired-controller SMEs. Ratings: **pilots n=11 (one operator)**,
  **dispatchers n=4 (one domestic operator)**, and rated tables list only items above threshold. The report is a **2011 draft**.
- The report cites **JO 7110.65T (2010)**; this project's reference is **7110.65BB (effective 2025-02-20, Basic)**. BB paragraph
  references below were found by text search of the BB PDF (page = PDF page). They are *governing-paragraph pointers*; **this pass did
  not extract BB's decision-authority content**, so authority cells say where to look, not what it says.
- 7110.65 governs ATC only. Flight-deck and FOC interactions (14 CFR 91/121, AIM, FOMs, AC 121-32A) have no BB paragraph; that is expected.
- Where a row's source wording is odd it is quoted as printed (e.g., E-5#13 has ATC "reading back" a pilot's report; Table 3.1 prints
  "Relephone"). The nominal Final Approach table has no explicit **"Clear to land"** row — the only one is `E-12#35` (after the go-around); the
  nominal E-11 stops at requesting clearance (`E-11#18`) and wind (`E-11#19`). Extraction covered 100% of the page's tokens, so this is the source's content, not a loss.

## 1. Actor crosswalk — source roles → project personas/systems

Personas are in [[stakeholder-personas]]. **Relation** = identical · renamed · many→one (several source roles → one persona) ·
one→many · no counterpart. **Abstraction** says what detail the project drops; **Why** gives the evidence-based reason. "Owner to confirm" marks
mappings that rest on judgment — the abstraction rationale in the last column is drawn from the sources, not from your notes, so overwrite it
with your own reasoning where it differs.

| Source role (position as printed) | Project persona / system | Relation | Abstraction made | Why (evidence) | Confidence · owner to confirm |
|---|---|---|---|---|---|
| FD **Captain** (81 mentions as subject or counterpart) | Line Pilot (Captain) | identical (persona is the Part 121 Captain) | none | Same role; both PIC. | High |
| FD **First Officer** (38) | First Officer *(stub)* | identical | none | Same role. | High |
| FD **Pilot Flying / Pilot Monitoring** (PM: 80) | Captain or First Officer | many→one (a *task state*, not a person) | PF/PM dropped; only Captain/FO kept | PF/PM swap between the two pilots (report p.44); final authority attaches to the Captain, not to PF/PM, so it fails the personas file's "materially different" test. Airborne rows print "Pilot Monitoring" as the crew contact. | Medium · confirm |
| FD **Crew** (4), FD **ACARS/FMS/Computer** | Captain/FO; aircraft systems (FMS listed in [[candidate-systems-inventory]]) | many→one; automation ≠ persona | automation treated as system | Report allocates automation to a group in the *current* matrix (p.45) but treats it as a fourth collaborator only for NextGen. | Medium |
| ATC **Tower - CD** (incl. "Flight Data" = CD/FD in App. C) | Clearance Delivery Controller *(stub)* | identical; FD merged in | Flight Data folded into CD | Tower "Flight Data, often combined with Clearance Delivery" (report p.19); BB 2-10-3 Tower Team defines Tower/Associate/Coordinator positions. | Medium · confirm |
| ATC **Tower - GC** (22) | Ground Controller *(stub)* | identical | none | — | High |
| ATC **Tower - LC** (32) | Local (Tower) Controller *(stub)* | identical | none | — | High |
| ATC **Tower - TMU** (3) | ATCT Traffic Management *(stub)* | identical | none | — | Medium |
| ATC **Departure - R** (23) | Departure Controller (TRACON) *(stub)* | identical | none | — | High |
| ATC **Approach - R** (9), **Final Approach - R** (30) | Arrival Controller (TRACON) *(stub)* | many→one | Approach vs. Final Approach *sector* split dropped | Final approach is a sector of the same TRACON (report p.42 phases; p.45 position list); personas split only when authority/information differ. | Medium · confirm |
| ATC **Approach - TMU** (1) | TRACON Traffic Management *(stub)* | identical | none | — | Medium |
| ATC **Departure/Approach - RA** (11 / 10) | *no TRACON counterpart* (nearest: Departure / Arrival Controller) | no counterpart → **gap** | undecided | BB 2-10-2 defines the Radar Associate at terminal facilities; the project only has an ARTCC "Data / Assistant Controller" stub. | **Owner decision:** fold into R persona, or add a stub |
| ATC **En Route sector R** ("1st Center 1st sector", …, "Last Center last Sector"; ~59 rows) | Air Traffic Controller (Enroute, ARTCC sector) *(drafted)* | many→one | center/sector identity and route position dropped | Same radar-position role at different points along the route; BB 2-10-1 treats the sector team as one team ("no absolute divisions of responsibilities… the team as a whole"). Sector geometry belongs in the instance model. | High |
| ATC **En Route sector RA** (~21); App. C **Flight Data** | Data / Assistant Controller (ARTCC) *(stub)* | identical for RA; persona name also spans BB's Radar Flight Data | none for RA | BB 2-10-1 defines *both* "Radar Associate (RA)… 'D-side' or 'Manual Controller'" *and* "Radar Flight Data (FD)… 'Assistant Controller' or 'A-side'". The stub's name straddles the two; the matrix uses RA, App. C lists Flight Data. | Medium · **owner to confirm** which BB position(s) the persona means |
| ATC **En Route RC** (1: `E-6`, "2nd to last Center – RC") | *no counterpart* | no counterpart → **gap** | undecided | BB 2-10-1 defines a Radar Coordinator ("Coordinator/Tracker/Handoff Controller"). | Owner decision |
| ATC **Last/3rd-to-last Center – TMU** (2) | ARTCC Traffic Management: TMO / STMC / TMC *(stubs)* | one→many, **ambiguous** | report's "TMU" = a *unit*; project splits it into three roles | The report never distinguishes roles inside a TMU; BB 11-1-2 gives duties by role (e.g., STMC-in-Charge). Treat "ARTCC Traffic Management" (the parent group) as the counterpart and split only if a scenario needs different authority. | Low · **owner to confirm** |
| ATC **Command Center - TMU / Command Center** (8) | National Traffic Management (ATCSCC): NOM / NTMO / NTMS *(stubs)* | one→many, **ambiguous** | same as above | Same reason; "CC" = the Air Traffic Control System Command Center ([[glossary]] ATCSCC). | Low · owner to confirm |
| ATC **Supervisor (Sup)** (App. C only) | *no counterpart* | no counterpart → **gap** | undecided | Sector/facility supervisor ≠ "Supervisory Traffic Management Coordinator" (a TM role). | Owner decision |
| FOC **Flight Dispatcher** (40) | Airline Dispatcher *(drafted)* | identical | none | — | High |
| FOC **ATC coordinator** (9) | *no persona stub* (named as an actor role in [[candidate-systems-inventory]]; also in `berry2011aocActors`) | no counterpart → **gap** (or one→many split of "Dispatcher") | — | The report treats ATC Coordinators as dispatchers assigned to coordinate the company's interests with ATC facilities (p.34, p.45); `berry2011aocActors` describes them as the AOC's usual point of contact with ATC, with the dispatcher not normally interacting with ATC directly. Different authority and information ⇒ plausibly passes the split test. | Owner decision |
| FOC **Computer / flight planner** | flight-planning system (OCC systems) | automation ≠ persona | — | — | Medium |
| RAMP **Load Planner** (5) | Load Controller *(stub, OCC group)* | renamed; **org placement differs** | source puts it in RAMP, project tree puts it in the OCC | Report added RAMP because load planners and pushback crews fit neither ATC nor FOC (p.44); airlines differ on where load control sits. | Medium · owner to confirm |
| RAMP **Pushback/Ground** (9), **Ground** (5) | Pushback / Towing Operator; Ramp Agent *(stubs)* | one→many | "Ground" crew split by task (E-3 pushback; E-13 marshalling to jetway) | Two different tasks/handoffs in the matrix; the source lumps them. | Low · owner to confirm |
| Automation entities: ACARS, HOST, PVD, URET, ATIS, FMS, flight strips | systems — see [[candidate-systems-inventory]] | not personas | — | Only FMS was already listed; the rest are added there as candidates. | — |

**Recurring reason behind the ATC rows.** JO 7110.65 itself says the sector/facility "team, as a whole, has responsibility"
(BB 2-10-1/2/3, PDF pp.115–120) and lets one controller fill several positions. A per-position persona is therefore only justified where authority,
information or handoff behavior differs — the same "materially different from parent" rule already in [[stakeholder-personas]].
That is why sector identity (1st/2nd/last center), Final vs. Approach, and PF/PM collapse, while ATC Coordinator vs. Dispatcher and Radar Associate
(information/authority differences) are flagged as real candidates.

## 2. Phase crosswalk

| Source table (report phase) | Rows | ConOps phase ([[conops-nominal-domestic_flight]]) | §4 transition(s) |
|---|---|---|---|
| E-1 Flight planning, before release | 18 | Phase 2 (dispatch release; dispatcher ↔ crew) | — (FOC/FD, no ATC control) |
| E-2 Flight planning, after release (crew prep; "gate closed") | 26 | Phases 2–5 (release accepted, preflight/FMS, boarding/loading closes, clearance) | clearance delivery; ground control (departure release) |
| E-3 Pushback | 15 | Phase 5 | pushback/ramp coordination; ground control |
| E-4 Taxi-out | 21 | Phase 5 | taxi clearance; ground → local |
| E-5 Takeoff | 26 | Phases 6–7 | local/takeoff clearance; departure control; first handoff to En Route |
| E-6 Cruise | 23 | Phase 8 | en route control; sector handoffs; FOC contact |
| E-7 Off-nominal: Command Center reroutes for weather | 19 | Phase 8 (off-nominal) | TMU/CC → FOC/crew → ATC re-clearance |
| E-8 Cruise continuation | 19 | Phases 8–9 | sector handoffs; handoff to TRACON |
| E-9 Off-nominal: holding | 18 | Phases 9–10 (off-nominal) | holding, hold release |
| E-10 Descent (incl. approach sub-phase) | 23 | Phases 9–11 | arrival control; handoff to approach |
| E-11 Final approach | 19 | Phase 11 | approach clearance; TRACON → tower |
| E-12 Off-nominal: missed approach | 37 | Phases 11–12 (off-nominal) | go-around coordination; re-sequencing; landing clearance |
| E-13 Landing / taxi-in / at the gate | 13 | Phases 12–14 | ground control (taxi-in); ramp/gate transition |

## 3. Control-transition catalog (to-do §4 field form)

Fields per `to-do-list.md` §4 "For each control transition identify…". "Actor" is source role → persona (see §1). **Decision authority and required
information are not extracted from BB in this pass** — the BB cell names the governing paragraph. Row IDs point to the interactions file.

| # | Transition | Responsible actor(s) | Information exchanged (rows) | Comms mechanism | Trigger for transfer | Resulting aircraft action | BB ¶ (PDF p.) | Not evidenced |
|---|---|---|---|---|---|---|---|---|
| 1 | Clearance delivery | Tower CD → Clearance Delivery; crew (FO) | request/receive/acknowledge **PDC** (`E-2#07–11`); IFR clearance w/ squawk, hold-for-release if EDCT (`E-2#10`); voice fallback + read-back (`E-2#13–14`); strips printed 30 min prior (`E-2#03`) | ACARS; radio if not delivered by ACARS | crew "establish contact" (`E-2#07`) | crew prints IFR clearance (`E-2#12`); CD gives strips to GC (`E-2#15`) | 4-3-2 (223), 4-2-1 (217), 4-3-4 (231); *BB has no "PDC" paragraph* | authority text; ATC→FOC feedback |
| 2 | Pushback / ramp coordination | Captain ↔ Pushback/Ground → Pushback/Towing Operator; GC → Ground Controller | request permission to push (`E-3#01`), "clear for pushback" (`E-3#04`); request/read-back pushback, parking-brake release, engine-start cues (`E-3#05–13`); "Off the Gate" report to dispatcher (`E-3#10`) | radio (GC); interphone/gesture (ramp) | GC clearance; ramp ↔ crew cue | pushback, engine start, "released from guidance" (`E-3#14–15`) | 3-7-1 / 3-7-2 (151–152) for GC; **none for ramp** (no pushback text in BB) | who has authority to push back onto the active surface ("depends whether ramp has authority", report p.42) |
| 3 | Ground control (departure) | Tower GC → Ground Controller | taxi intentions, ATIS identifier (`E-3#02–03`); runway change and new taxi sequence (`E-4#06–08`) | radio | crew "request pushback" → clearance | taxi movements; hold | 3-7-2 (152), 3-1-4 (122) | — |
| 4 | Taxi clearance | GC → Ground Controller; FO | "advise ready to taxi", taxi clearance, read-back (`E-4#02–04`) | radio | ready-to-taxi call | taxi to runway | 3-7-2 (152) | taxi route content |
| 5 | Local/tower (departure) | GC → LC hand-over of strips (`E-4#11`), LC contact (`E-4#12`), hold-short + read-back (`E-4#13–14`), flight-plan amendment (`E-4#15–16`) | face-to-face (strips) + radio | GC "contact LC on new frequency" (`E-4#09`) | LC now controls; hold short | 3-1-4 (122), 3-7-2 (152), 4-2-5 (218) | LC authority to release without TRACON permission is only noted (`E-4#20`) |
| 6 | Takeoff clearance | Tower LC → Local Controller; Captain | "ready", "clear for takeoff", read-back (`E-5#01–03`); "instruct position and hold" (`E-4#21`) | radio | LC clearance | takeoff roll, V-calls (`E-5#04–07`), "Off the Ground" report (`E-5#06`) | 3-9-4 (166), 3-9-10 (180), 3-9-11 (183) | — |
| 7 | Departure control | Departure R (+RA) → Departure Controller; PM | contact on departure frequency (`E-5#08–10`); altitude check via URET (`E-5#11–12`); climb clearances (`E-5#14–17`) | radio; URET (automation) | LC "contact departure" (`E-5#08`) | climb, heading | Ch. 5 §8 Radar Departures (331); 4-3-1..-8 (223–233) | departure release with Center/TMU (`E-4#20`) |
| 8 | En route ARTCC control | En Route R/RA → ATC Enroute; Data/Assistant Controller; PM | ID/altitude/heading check-in, read-backs, altitude/heading clearances (`E-5#23–26`, `E-6#05–08`, `E-8#10–13`) | radio; interphone between sectors; PVD/URET | accepted handoff | altitude/heading changes, direct-to | Ch. 5 (279), 5-13 En Route automation (371) | — |
| 9 | Sector-to-sector handoff | R (feeder) ↔ R (receiver), RA | "initiate/request handoff" ↔ "accept handoff" (`E-5#20–21`, `E-6#01–02, 09–10`, `E-8#03–04`, `E-10#10–11`); receiver-requested instruction relay before entry (`E-6#11–13`); pilot told to change frequency and read-back (`E-6#03–04`) | PVD (datablock), interphone; radio for frequency change | receiving sector accepts on keyboard (report App. B p.6) | frequency change → initial contact with next sector | 5-4-5, 5-4-6 (303–304), 5-4-7 point out (305), 5-4-8 AIT (305), 2-1-15 (46) | conditions for "complex" handoff (only narrated in App. B) |
| 10 | Arrival control (En Route → TRACON) | Last Center R/RA → ATC Enroute/Data-Asst.; Approach R/RA → Arrival Controller | STAR check (`E-8#05`, `E-10#12`); datablock to Approach (`E-8#07`); speed reduction request/agree (`E-10#01–05`); in-range call and gate uplink (`E-10#13–14`) | PVD/URET, phone; ACARS for ramp | last-center handoff accepted (`E-10#10–11`) | descent, speed reduction | Ch. 5 §9 Radar Arrivals (339), 5-4-x | — |
| 11 | Approach clearance | Approach R / Final Approach R → Arrival Controller; Captain | ATIS/runway advisory + read-back (`E-10#15–18`, `E-11#03–04`); "clear approach and runway" (`E-11#05`); visual approach request/clearance (`E-11#10–11`, `E-12#27–28`); traffic advisory/in sight (`E-11#12–14`) | radio | contact final-approach sector (`E-11#01`) | descend on approach | 4-8-1 (265), 2-1-21 (50), 2-9-2/3 (111–112) | — |
| 12 | Tower/local (arrival) | Final Approach R → LC; Captain | contact LC, request clearance for runway, wind (`E-11#17–19`) | radio | "contact tower" (`E-11#15–16`) | land | 3-10-x arrival procedures (185–) | — |
| 13 | Landing clearance | Tower LC → Local Controller | request (`E-11#18`); **"clear to land" appears only in `E-12#35`** | radio | LC clearance | landing | 3-10-5 (193), 3-10-8 (195) | nominal "clear to land" row absent in E-11/E-13 |
| 14 | Ground control (taxi-in) | Tower LC → GC; Captain | exit runway (`E-13#02–03`); contact GC, taxi route (`E-13#06–09`) | radio | LC "contact ground" (`E-13#04`) | taxi to gate | 3-7-2 (152) | — |
| 15 | Ramp/gate transition | Captain ↔ RAMP Ground → Ramp Agent | visual contact, guidance to jetway, gear-secured sign (`E-13#10–13`); "Into the Gate" report (`E-13#12`) | face-to-face/gesture; ACARS | aircraft at gate | shutdown | not in BB | jetway/gate assignment authority (uplinked `E-10#14`) |

## 4. Off-nominal catalog (§9 / scenario seeds)

- **E-7 Command Center reroutes for weather (19 rows).** Chain: Tower-TMU reports runway change to CC, Last-Center and Approach TMUs (`E-7#01–03`) → CC-TMU recommends
  rerouting via "Center Y" to the 3rd-to-last Center TMU (`E-7#04`) and advises the FOC **ATC coordinator** (`E-7#05`), who relays to the dispatcher (`E-7#07`) → dispatcher
  gets fuel on board from the crew (`E-7#08–09`), recomputes the reroute and ETA (`E-7#10`), tells the crew (`E-7#11–13`), **releases an amended flight plan to HOST** (`E-7#14`) → crew
  requests the amendment from the sector (`E-7#16`), which clears it (`E-7#17`). Fits the "Domestic Commercial Flight w/Wx Re-Route" scenario stub in [[conops-scenarios]].
- **E-9 Holding (18 rows):** Approach-RA ↔ Last-Center R agree to hold (`E-9#01–02`); holding instruction with Expected Further Clearance (`E-9#03–12`); crew reports holding and fuel remaining
  to dispatch, dispatch downloads fuel levels (`E-9#06–09`); hold release (`E-9#15–18`). BB 4-6-1 requires holding items to be issued at least 5 minutes before the estimated clearance-limit arrival when delay is expected.
- **E-12 Missed approach (37 rows):** LC instructs go-around (`E-12#02–03`), notifies Departure-RA, who approves and relays to Final Approach and Approach (`E-12#04–11`), speed/heading clearances from Departure (`E-12#12–16`),
  re-handoff to Final Approach (`E-12#17–18`), visual approach and landing clearance (`E-12#27–35`).
- **Tables 2.1 / 2.2** (21 flight-deck↔ATC and 10 flight-deck↔FOC off-nominal items from AFMs/FOM), **2.8** (holding, missed approach, emergency from the ATC side) and **3.1** (possible collaborative interactions) supply the conditions; the report notes very few are rated frequent or highly critical (p.29).

## 5. Candidate §9 friction points (small-sample seeds — do not quantify)

1. **FOC ATC Coordinator vs. Command Center/ATC flow decisions** — coordinators "push the company's agenda with ATC" in critical situations such as bad weather near a hub (report p.34); in CDM/ICR "responsibilities are not shared and the decision is ultimately made by Traffic Management" (p.46–48). Local (airline network) vs. system (NAS flow) objective.
2. **Flight release vs. ATC clearance** — route clearance that differs from the release routing forces a dispatcher/captain conference (Table 2.2 #3; Table 2.9 rows for route clearance differences). The plan the airline optimized meets the clearance ATC will actually issue.
3. **Pilot/dispatcher/ATC fuel and deviation decisions** — the FOC↔flight-deck items rated most critical in Table 2.10 are fuel, performance limits, diversion and unauthorized-airport landings; ATC is the second party for diversion and holding (`E-9`).
4. **Tactical control stays with ATC** — clearances are "procedural interactions where just one of the participants has ultimate responsibility… little room for negotiations" (p.46); flight-deck-preferred trajectories are accommodated "to the extent possible" (p.46).
Cross-check with `munro2018managingVariability` (dispatch vs. load planning vs. stations) and the airline-internal tension already named in [[stakeholder-personas]] (dispatcher / executive).

## 6. Systems and media (§10 seed)

Media in the matrix (E-tables, rows): Radio 145 · ACARS 32 · PVD 17 · Face-to-Face 15 · Phone 14 · Interphone 12 · Computer 7 · Host 6 · URET 6 · Interphone/gesture 5 · Telcon 3 · Satcom 3 · FMS 2 · Gesture 2 (plus a few singletons). Systems named: ACARS (incl. automated OOOI reports),
ERAM **HOST**, **PVD**, **URET** (BB now names **EDST**), ATIS, flight strips, FMS, AFTN, Command Center telcons. Information objects exchanged (candidate §10 item flows): flight plan / dispatch release / amended flight plan, PDC/IFR clearance, EDCT,
load & passenger list, final weight & balance, ATIS identifier, datablock/handoff, advisory (runway configuration, delay program, weather), fuel on board, OOOI reports, gate assignment/ground power uplink.

## 7. Open items → [[open-questions]]

Radar Associate at terminal facilities; ATC Coordinator as its own persona; how to read "TMU" (unit vs. role) and "Command Center"; load planner in RAMP vs. OCC; whether the project models ATC at position or team level; whether automation is a collaborator or a system.
BB follow-ups: extract decision-authority content for ¶2-10, 3-7-2, 3-9-10, 4-3-2/4-3-4, 5-4-5..-9, 10-1; check whether change notices to the Basic edition affect cited paragraphs.
