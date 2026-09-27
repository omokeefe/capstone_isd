package ContextDiagram {
    doc /* Context diagram for the NAS SOS Capstone project, showing the system of
     * interest (SoI), the external entities, and the exchanges between them.
     *
     * Per D-007 the SoI is the NAS made of the five modeled domains (Airspace
     * Management, Airport Operations, Flight Operations, Aircraft Systems, Flight
     * Crew). Outside it, in Environment: boundary actors (Governance, Passengers,
     * Military) and context constraints (Infrastructure / Airspace Resources,
     * Maintenance Suppliers). Information Services and Decision Support are absorbed:
     * they appear only as exchange content, media, or capabilities.
     * Per D-009 only modeled systems are rendered (#ContextVisible), plus the drafted
     * environment links. Per D-010 a sub-part is rendered here only if it has an
     * exchange that crosses a domain boundary; links inside one domain go on that
     * domain's IBD (e.g. nas_ibd_airspace_management.sysml).
     * Authoring rules: knowledge/models/sysml-modelling-methods.md §3, §10.
     */

    metadata def ContextVisible {
        doc /* Tag for elements the context view (MyViews::systemContext) should render.
         * Apply as a prefix: #ContextVisible part ... / #ContextVisible connect ... */
    }

    part def NASContextDiagram {
        private import ScalarValues::*;
        private import NationalAirspaceSystem::AirportOperations::*;
        private import NationalAirspaceSystem::AirspaceManagement::*;
        private import NationalAirspaceSystem::AircraftSystems::*;
        private import NationalAirspaceSystem::FlightOperations::*;
        private import NationalAirspaceSystem::FlightCrew::*;
        private import NationalAirspaceSystem::Common::*;
        private import NationalAirspaceSystem::Environment::*;

        // #ContextVisible marks what the context view renders. Nested parts are
        // redefined (:>>) only so they can carry the tag; their types are unchanged.
        //
        // D-007 assessment (D-009, decisions-log.md). Every system here is tested against
        // D-007's rule: MODELED if it has distinct decision authority or execution behavior,
        // dynamically coupled to in-scope decisions, that materially affects cost, safety,
        // workload, schedule reliability, or passenger value. Otherwise it's a BOUNDARY ACTOR
        // (supplies objectives/demand/feedback/rules), a CONTEXT CONSTRAINT (exogenous), or
        // ABSORBED (kept only as exchange content or capability). Rendered = on the context view.

        // D-007: BOUNDARY ACTORS (governance, passengers, military), CONTEXT CONSTRAINT
        // (infrastructure), ABSORBED (informationServices, decisionSupport). The rendered
        // environment links are at the bottom ("ENVIRONMENT"). Maintenance Suppliers
        // (context constraint) has no part yet.
        #ContextVisible part environment: EnvironmentDomain {
            #ContextVisible part :>> governance;
            #ContextVisible part :>> military;
            #ContextVisible part :>> infrastructure {
                #ContextVisible part :>> weatherService;
            }
        }
        #ContextVisible part airportOps: AirportOperationsDomain {
            // D-007: MODELED. Authority over gates, non-movement area, closures, and slots at
            // coordinated airports; departure readiness couples to EDCT compliance and
            // schedule reliability. Weakest evidence of the modeled set (C/B). Rendered.
            // Its sub-parts (fuel, ground handling, gates, lighting, gate agents, terminals,
            // baggage, cargo, maintenance) are ABSORBED: they carry out decisions made
            // elsewhere (owner 2026-09-27), so they appear only as ends of the unrendered
            // aircraft <-> airport and crew <-> airport sets.
            #ContextVisible part :>> airport;
        }
        #ContextVisible part airspaceMgmt: AirspaceManagementDomain {
            // D-007: MODELED. Tactical control authority (clearances, separation; JO 7110.65BB)
            // directly shapes the flown trajectory; safety + schedule. Rendered.
            #ContextVisible part :>> atc;
            // D-007: MODELED. "Final approving authority" for interfacility TMIs (7210.3EE
            // 18-2-3i); EDCT/CTOP/reroutes couple straight to airline decisions; delay cost and
            // schedule reliability. Rendered (cross-domain link: aocTfm).
            #ContextVisible part :>> atcscc;
            // tmu: D-007 MODELED (local TM latitude; 18-2-3 NOTE), but every tmu exchange is
            // inside Airspace Management (ATCSCC <-> TMU <-> controllers), so per D-010 it is
            // not rendered here. It and those links are on the Airspace Management IBD.
            // tracon / artcc: MODELED in the definitions, covered by the atc umbrella here.
            // tfmAutomation (FSM, NTML, TBFM, TFMS, DRT): ABSORBED tools; cited as media.
        }
        #ContextVisible part aircraftSys: AircraftSystemsDomain {
            // D-007: MODELED. No decision authority, but its execution behavior (FMS intent ->
            // guidance -> motion) IS the end of the intent chain; fuel burn, safety. Rendered.
            #ContextVisible part :>> aircraft;
        }
        #ContextVisible part flightOps: FlightOperationsDomain {
            // D-007: MODELED. Operational control; the dispatcher and captain are jointly
            // responsible for the release (14 CFR 121.533); sets the airline's plan and fuel;
            // cost and schedule. Rendered as ONE node. Its roles (dispatcher, flight follower,
            // ATC coordinator, load planner, maintenance controller, crew scheduler, aircraft
            // router, duty manager) are sub-parts in the definitions for the AOC IBD; each
            // connection doc below names the role that owns it.
            #ContextVisible part :>> airlineOperationsCenter;
            // ticketingSystem: ABSORBED. Revenue/booking side; enters only as passenger demand
            // (a boundary-actor effect per D-007). Not rendered.
        }
        #ContextVisible part flightCrew: FlightCrewDomain {
            // D-007: MODELED, as ONE element (D-009 merge). The captain holds final authority as
            // PIC (14 CFR 91.3) and turns the plan + clearances into FMS intent; safety,
            // workload, fuel. The captain / FO split is not a separate authority at context
            // level, so the two roles live inside flightDeckCrew and aren't rendered.
            #ContextVisible part :>> flightDeckCrew;
            // cabinCrew: inside the MODELED Flight Crew domain but ABSORBED at context level.
            // No authority over in-scope decisions. They ARE the primary passenger interface
            // and the go-between for passengers and the flight deck, so they carry most of the
            // passenger-satisfaction effect (with gate agents); that belongs in the §7-§9
            // objective work, not on this view (owner, 2026-09-27). Not rendered.
            part :>> cabinCrew;
        }

        // ------------------------------------------------------------------
        // REVIEW KEY (added 2026-09-27)
        //   [A]    primary/normative source states it (JO 7110.65BB, JO 7210.3EE)
        //   [B]    empirical literature shows it (Seamster 2011, Berry & Pace 2011, Munro 2018)
        //   [SME]  owner's professional knowledge (16 years in industry on FMS technologies).
        //          Stated as such in the write-up unless a citable source is found.
        //   [C]    your notes / general domain knowledge; defensible, not yet citable
        //   TODO(review)  no evidence, a direction/term problem, or weak tie to the
        //                 intent chain (index.md "Center of gravity") - your call
        //   TODO(missing) something the notes leave out
        // Evidence detail per connection: knowledge/models/context-diagram-exchange-evidence.md
        // ------------------------------------------------------------------

        // Theorize what we want to connect up here.
        // The ATM consists of:
        //  - The aircraft:
        //     - flying from airport to airport, creating 4D points that form a trajectory,
        //     - controlled by the flight crew, physical interactions
        //     - observed by the airline operations center,
        //     - observed by the airspace management domain
        //     - interacting with the environment domain (weather, terrain, etc.)
        //     - operated by the Flight Operations domain,
        //     - certified according to the rules established by the environment domain.
        //  - The flight crew:
        //     - supported by the flight operations (e.g. airline operations center),
        //     - interacting with the aircraft systems domain,
        //     - interacting with the airspace management domain,
        //     - interacting with the airport operations domain,
        //     - working according to the rules established by the environment domain.
        //  - The flight operations domain:
        //     - supporting one to many flight crews,
        //     - receiving data from the aircraft systems domain,
        //     - communicating with the airspace management domain,
        //     - communicating with the airport operations domain.
        //     - working according to the rules established by the environment domain.
        //  - The airport operations domain:
        //     - communicating with the flight operations domain,
        //     - communicating with the airspace management domain,
        //     - sending data to the aircraft systems domain,
        //         -> RESOLVED 2026-09-27. Lighting: the tower operates it (ATC -> airport,
        //            BB 3-4-x) and it signals the pilot (airport -> crew); the airport owns and
        //            maintains it (14 CFR 139.311). Navaids (ILS, VOR, DME) are NOT handled like
        //            lights: most are FAA-owned and FAA-maintained (NAS roadmaps; some are
        //            non-federal), so they sit in Infrastructure (D-007) and signal the aircraft
        //            directly (apNavaidSignals). The rest of airport -> aircraft is the material
        //            turnaround set below.
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.
        //  - The airspace management domain:
        //     - communicating with the flight operations domain,
        //     - communicating with the airport operations domain,
        //     - sending data to the aircraft systems domain,
        //         -> RESOLVED 2026-09-27. Two machine paths, both through the aircraft's own
        //            systems: SURVEILLANCE, aircraft -> ATC (transponder / ADS-B;
        //            atcSurveillance), and DATALINK, ATC <-> aircraft (PDC and D-ATIS over
        //            ACARS, CPDLC / Data Comm; atcAircraftDatalink). Neither is a control path:
        //            a datalink clearance reaches the FMS only after the crew accepts it.
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.


        // Core operational coordination  - AOC to Crew   (dispatcher; flight follower airborne)
        //   - Dispatch release package (the "dispatch paperwork"; item def
        //     FlightOperations::DispatchRelease has the full list)
        //       -> [B] Seamster E-1 (18 rows)/E-2; Munro 2018. [C] for the regulatory list
        //          (14 CFR 121.687 release contents, 121.693 load manifest; not registered).
        //       1. Release proper: aircraft ID, trip number, departure / destination /
        //          alternate airports, type of operation, minimum fuel, weather for each.
        //       2. Operational flight plan: route incl. SID/STAR, altitudes, planned times and
        //          burn per waypoint, winds aloft, cost index, planned weights, fuel breakdown.
        //       3. Weather package and NOTAMs.
        //       4. MEL/CDL deferrals and their restrictions.
        //       5. Takeoff/landing performance (AOC-provided by abstraction, D-009 item 6).
        //       6. Load closeout / final W&B (from load control, often a later ACARS message;
        //          Seamster E-2#20).
        //       Fuel: set in the release, signed by dispatcher AND captain; the captain may
        //       ask for more (Munro).
        //   - Amended release / reroute + new ETA          -> [B] E-7#11-13
        //   - Alternate / minimum-fuel advisories           -> [B] Table 3.1#14

        // Core operational coordination  - Crew to AOC
        //   - Release acceptance, or a request to change it (commonly more fuel)  -> [B] Munro
        //   - Fuel on board after the preflight cross-check (release vs FMS vs fuel slip and
        //     gauges; FlightCrew::PreflightCrossCheck). The fuel slip itself stays between the
        //     fueler and the crew (caFuelSlip, unrendered); only the result reaches the AOC.
        //       -> [B] E-7#08-09, E-9#06-09; [C] for the slip / gauge check.
        //   - Aircraft configuration & performance data: tolerances deferred until a model
        //     needs them (owner, 2026-09-27).                                        -> [SME]
        //   - Aircraft status & maintenance needs  -> [B] to maintenance control (Berry & Pace);
        //                                             often automated (aocAircraftDatalink)
        //   - Equipment malfunctions & emergencies -> [B] Seamster T2.10 (diversion, emergency)
        //   - PIREPs / ride reports                -> [C] common practice; sources cover PIREPs to ATC
        //   - Plan-deviation reports: reclearance, route change, unplanned holding with the
        //     EFC time, ETA change > 5 min         -> [B] Seamster A.1#41-46
        //       Owner 2026-09-27: ETA changes and holding fold into route modification. Agreed
        //       for the MECHANISM (same crew -> AOC message path, same amended-release
        //       response), so they are one category here. Kept as a named "plan-deviation
        //       report" rather than "route modification" because holding changes time and
        //       fuel, not the route, and holding vs. fuel is exactly where the dispatcher's
        //       divert decision starts (the §9 fuel/diversion friction).

        #ContextVisible connection aocToCrew connect flightOps.airlineOperationsCenter to flightCrew.flightDeckCrew {
            doc /* [B] Dispatch/operational control link (dispatcher <-> flight deck; the captain
             * signs). AOC roles: dispatcher (release, amendments), flight follower (airborne
             * monitoring), load planner (closeout via ACARS).
             * AOC -> crew: dispatch release package (release, OFP, weather/NOTAMs, MEL items,
             *   performance, load closeout; FlightOperations::DispatchRelease), amended release /
             *   reroute + ETA, alternate and minimum-fuel advisories.
             * Crew -> AOC: release acceptance / fuel requests, fuel on board (result of
             *   PreflightCrossCheck), release-vs-FMS discrepancies, maintenance and malfunction
             *   reports, diversion/emergency, plan-deviation reports (reclearance, route change,
             *   holding + EFC, ETA change > 5 min), ride reports.
             * Media: phone/radio pre-departure; ACARS/Satcom airborne. Both sign the release; the
             * captain has final authority as PIC (14 CFR 91.3).
             * Intent chain: mission plan -> flight plan (the airline's intent reaching the crew).
             * Sources: Seamster 2011; Munro 2018; Berry & Pace 2011. */
        }

        // Core operational coordination  - ATC to Crew
        //   - radio comms hand-offs & transfer info   -> [A] BB 5-4-5..5-4-8, 2-1-15; Seamster E-6#03-04
        //   - traffic advisories                      -> [A] BB 2-1-21 (correct use here: the
        //                                                controller -> pilot proximity call)
        //   - safety alerts (terrain/obstruction, aircraft conflict)
        //                                             -> [A] BB 2-1-6: "first priority"; once
        //                                                issued, "solely the pilot's prerogative"
        //                                                what action to take
        //   - request responses/clearances            -> [A] BB 4-2-x, 4-3-x, 3-7-2, 3-9-x, 4-8-1
        //   - holding instructions + Expect Further Clearance (EFC) time, or "no delay expected"
        //                                             -> [A] BB 4-6-1 (clearance limit, holding,
        //                                                EFC), 4-6-4 (holding elements); Seamster E-9
        //   - weather information and approval of weather deviations
        //                                             -> [A] BB 2-6-4a (weather areas), 2-6-4i
        //                                                (approve deviations; after a deviation
        //                                                off a SID/STAR, issue an altitude, because
        //                                                the FMS may not honor crossing
        //                                                restrictions off the lateral path)
        //   - altimeter settings                      -> [A] BB 2-7-1; in departure / landing /
        //                                                approach information (3-9-1, 3-10-1,
        //                                                4-7-10) and ATIS (2-9-3)
        //   - PIREP solicitation                      -> [A] BB 2-6-2 (controller asks when
        //                                                ceilings, visibility, turbulence, icing,
        //                                                wind shear, braking meet the criteria)
        //   - beacon code / transponder instructions (squawk, ident, standby, altitude
        //     reporting)                              -> [A] BB 5-2-1, 5-2-10, 5-2-18, 5-3-3
        //   - ATIS info                               -> [A] BB 2-9-2/3 (broadcast)
        //   - Expect Departure Clearance Times (EDCTs)
        //       -> [A] BB 4-3-4 (hold-for-release / EDCT in the clearance, E-2#10). The ATCSCC
        //          issues the EDCT; ATC relays and enforces it (-5/+5 min). The crew usually
        //          gets it from dispatch first.
        //   Holding and weather deviations change the trajectory, so they matter for the intent chain.

        // Core operational coordination  - Crew to ATC
        //   - Intent, Requests, & Reports                -> [A] BB; Seamster T2.7#21, T2.4#06
        //   - Weather deviation requests                 -> [A] BB 2-6-4i; Seamster T2.4#06
        //   - Equipment Malfunctions & Emergencies       -> [A] BB 2-1-7, Ch. 10
        //   - TCAS RA / TAWS reports                     -> [A] BB 2-1-28, 2-1-30
        //   - Pilot Reports (PIREPs)                     -> [A] BB 2-6-2
        //   - Comms Establishing at departure and in response to transfer
        //                                                -> [A] BB 2-9-3 (ATIS code on contact); Seamster E-5#08-10

        #ContextVisible connection atcToCrew connect airspaceMgmt.atc to flightCrew.flightDeckCrew {
            doc /* [A/B] Tactical control: the best-evidenced link in the model.
             * ATC -> crew: clearances (IFR, taxi, takeoff, altitude/heading/speed/route,
             *   approach, landing), holding instructions with EFC, weather information and
             *   deviation approvals, safety alerts, traffic advisories, altimeter settings, ATIS,
             *   frequency changes/handoffs, beacon code / transponder instructions, PIREP
             *   solicitation, EDCT/hold-for-release as relayed from TFM.
             * Crew -> ATC: requests and intent (incl. weather deviation requests), read-backs,
             *   check-in with ATIS code, malfunctions/emergencies, TCAS RA / TAWS reports, PIREPs.
             * Media: radio (145 of ~277 Seamster matrix rows). Datalinked clearances (PDC,
             *   CPDLC) travel through the aircraft's systems instead: atcAircraftDatalink.
             * Authority: ATC holds tactical control; clearances leave "little room for
             * negotiations" (Seamster p.46); the captain keeps final authority as PIC (14 CFR
             * 91.3), and after a safety alert the action is "solely the pilot's prerogative"
             * (BB 2-1-6 NOTE 3).
             * Intent chain: ATC constraints -> trajectory negotiation.
             * Either pilot may be the voice on the radio (the FO in E-2#07, E-4#02-04).
             * Sources: JO 7110.65BB (2-1-6, 2-1-21, 2-1-28/30, 2-6-2, 2-6-4, 2-7-1, 2-9-2/3,
             * 4-3-4, 4-6-1/4, 5-2-x, 5-4-5..8); Seamster E-1..E-13. */
        }

        // Core operational coordination  - ATC to AOC (ATCSCC -> Flight Ops; ATC coordinator)
        //   - TMI advisories: GDP, GS, AFP, CTOP, reroute, diversion recovery
        //       -> [A] 7210.3EE 18-10-6c, 18-12-4, 18-15-2a7, 18-4-5c. (Renamed from "traffic
        //          advisories", which is the BB 2-1-21 controller -> pilot call.)
        //   - Expect Departure Clearance Times (EDCTs)
        //       -> [A] 7210.3EE 18-10-6e: EDCTs go "to ARTCCs and linked system users".
        //   - FEA / FCA publication                 -> [A] 18-8-2, 18-8-3 (act on an FCA: required)
        //   - CTOP assignment: route to avoid the FCA, or route + EDCT for a slot in it
        //                                           -> [A] 18-12-3a, 18-12-4
        //   - Adverse flight condition advisories (weather, equipment, capacity)
        //       -> [A] hotlines/telcons cover weather, outages, routes (18-4-1d); severe weather
        //          management and SWAP are ATCSCC-led (18-15, 18-16).
        //   - Operations Plan / planning webinar    -> [A] 18-21-2a, 18-21-4a
        //   These are where TFM constraints first reach the operator's trajectory choice.

        // Core operational coordination  - AOC to ATC (ATC coordinator -> ATCSCC / TFMS)
        //   - Proposed route modifications
        //       -> [A] Trajectory Options Set (TOS) and Early Intent to TFMS (7210.3EE 18-12-3b,
        //          18-8-2c); coordination with the ATCSCC Tactical Customer Advocate (18-8-3d).
        //   - Schedule changes / cancellations to FSM             -> [A] 18-10-3
        //   - GDP user options: slot (CTA) substitution, intermediate landing
        //                                                         -> [A] 18-10-12
        //   - Diversion recovery priorities (DRT or "DVRSN" in remarks)
        //                                                         -> [A] 18-4-5b
        //   - Customer preferences on hotlines/telcons            -> [A] 18-4-1d
        //   Slot substitution and diversion recovery are the airline-vs-system trade the §9
        //   conflict work needs: the operator ranks its own flights, the ATCSCC keeps the
        //   delay factor equal after a trade and "may modify" priorities for system
        //   efficiency (18-10-12b, 18-4-5b4). Explore them as a scenario, not on this view
        //   (journal 2026-09-27 recommendation).
        //   - Flight plan filing: moved off this view, see aocFlightPlanFiling below.

        #ContextVisible connection aocTfm connect flightOps.airlineOperationsCenter to airspaceMgmt.atcscc {
            doc /* [A] Traffic flow management / Collaborative Decision Making link.
             * ATCSCC -> operator: EDCTs, TMI advisories (GDP/GS/AFP/CTOP/reroute/diversion
             *   recovery), FEA/FCA publication, CTOP assignments, hotline/telcon content (weather,
             *   outages, capacity), the Operations Plan.
             * Operator -> ATCSCC/TFMS: schedule changes and cancellations (FSM), TOS, Early
             *   Intent, GDP slot substitutions and intermediate landings, diversion recovery
             *   priorities, customer preferences on hotlines.
             * Party on the AOC side: the ATC coordinator, not the dispatcher (Berry & Pace;
             * Seamster p.34, p.45).
             * Media: FSM, TFMS, DRT, ATCSCC advisories, hotlines/telcons (tools in
             * AirspaceManagement::AirTrafficFlowManagementSystem; not parties).
             * Items: AirspaceManagement::ExpectDepartureClearanceTime, TMIAdvisory,
             * FlowConstrainedArea, TrajectoryOptionsSet, CtopAssignment, ScheduleChange,
             * SlotSubstitutionRequest, DiversionRecoveryRequest.
             * Authority: the ATCSCC is the "final approving authority" for interfacility TMIs
             * (18-2-3i); operators must "operate to meet the EDCT" (BB 4-3-4).
             * Intent chain: flight plan <-> ATC constraints. This is where airline objectives meet
             * NAS flow objectives (the §9 local-vs-system conflict).
             * Sources: JO 7210.3EE CHG 3 18-4-1d, 18-4-5, 18-8-2c/3d, 18-10-3/6e/12, 18-12-3/4, 18-21-4a. */
        }

        // Flight plan filing: NOT rendered (D-010). The exchange stays in the model because
        // the filed plan is the intent object ATC clears against ("cleared as filed", and the
        // datablock is correlated to it, BB 5-3-3d). It is not rendered because no decision
        // is made on this link: the route is chosen on the AOC side (and traded on aocTfm), and
        // accepted or amended in the clearance (atcToCrew / atcAircraftDatalink). Filing
        // transports the decision, the same test that keeps aircraft <-> airport unrendered.
        // [A] 7210.3EE 6-5: computer-to-computer to the ARTCC host via NADIN, no earlier than
        // 3 h before departure; changes after filing and plans inside 45 min by phone.
        connection aocFlightPlanFiling connect flightOps.airlineOperationsCenter to airspaceMgmt.atc {
            doc /* [A] Flight plan filing and amendment. AOC (dispatcher, via the flight planning
             * system) -> ARTCC host (NADIN / computer interface): filed flight plan with route,
             * SID/STAR, altitudes; amendments. Amended plan after a TFM reroute is released to
             * the ARTCC host (Seamster E-7#14). Unrendered: carries a decision, makes none (D-010).
             * Intent chain: flight plan (the filed intent ATC starts from).
             * Sources: JO 7210.3EE 6-5, 18-7-4h2; Seamster E-7#14, T2.7#35. */
        }

        // AOC <-> Airport / station (dispatcher, load planner, maintenance controller)
        //   AOC -> airport / station
        //     - schedule, gate requests                              [C] hub draft; Clarke 1998 [B]
        //     - service orders that DRIVE the turnaround set below: fuel order to the fueler,
        //       catering order sized by passenger count, water/lav, ground power or air start
        //       (APU inoperative per MEL), de-icing plan         [B] Munro (dispatch <-> station
        //                                                          fuel/weight negotiation); rest [C]
        //     - load plan to the ramp (bags, cargo, mail)           [B] Munro; Seamster E-2
        //     - maintenance work orders to line maintenance         [B] Berry & Pace (maintenance control)
        //     - target off-block time (A-CDM TOBT). US equivalent: see TODO(open) below.
        //   Airport / station -> AOC
        //     - gate assignment (authority varies: see TODO(open) below)          [C]
        //     - turnaround / service readiness                                     [B] Clarke
        //     - gate personnel: boarding status, final passenger count, door closed,
        //       late-passenger holds (gate agents)          [B] Munro (dispatch vs gate agents)
        //     - runway / taxiway closures, field conditions, construction (airport-issued
        //       field NOTAMs; the same reports go to ATC on atcAirport)          [A] BB 2-1-9 / [C]
        //     - fuel availability at the station; fuel PRICE reaches the AOC through the
        //       airline's fuel contracts, not from the airport operator. It is a cost input
        //       to the dispatcher's tankering choice (fuel price = context constraint, like
        //       Maintenance Suppliers)                                             [C]
        //     - de-icing capacity, curfews / noise restrictions                    [C]
        //   TODO(open) 1. Gate assignment authority (airline-leased exclusive/preferential gates
        //      vs airport-assigned common-use gates). Needs a US source for credibility. Leads
        //      to check (not registered): FAA AC 150/5360-13 (terminal planning); ACRP reports
        //      on airport-airline use and lease agreements.
        //   2. Turnaround readiness is OUT OF SCOPE as a process (owner, 2026-09-27; see journal).
        //      It enters as ONE exogenous input: the aircraft's ready / actual off-block time
        //      (or a delay distribution) at this link. That keeps the hook for a later delay
        //      equation without modeling the turnaround.
        //   3. TOBT-like exchange: not modeled (MVP). The US analog, the airline-supplied
        //      earliest off-block time in FAA surface CDM / TFDM (JO 7210.637, not registered),
        //      goes to the FAA tower, not the airport operator. Add it as one item on
        //      aocFlightPlanFiling or aocTfm only if a departure-time scenario needs it.

        #ContextVisible connection aocAirport connect flightOps.airlineOperationsCenter to airportOps.airport {
            doc /* [C/B] Airline <-> airport/station coordination.
             * AOC -> airport: schedules and gate requests; service orders (fuel order, catering
             *   by passenger count, water/lav, ground power / air start, de-icing plan); load
             *   plan to the ramp; maintenance work orders; target off-block time (A-CDM TOBT).
             * Airport -> AOC: gate assignment, service/turnaround readiness, boarding status,
             *   final passenger count and door closure (gate agents), runway/taxiway closures and
             *   field conditions (field NOTAMs), fuel availability, de-icing capacity,
             *   curfews/noise restrictions.
             * These orders are the information that drives the unrendered aircraft <-> airport
             * material set: the decision is made at the AOC and carried out at the airport.
             * Sources: interface-exchange-draft.md (prework hub, C, directions unverified);
             * Clarke 1998 (B); Munro 2018 (B); Berry & Pace 2011 (B); EUROCONTROL A-CDM (A, but
             * European). US gate-authority source still missing. */
        }

        #ContextVisible connection aocAircraftDatalink connect flightOps.airlineOperationsCenter to aircraftSys.aircraft {
            doc /* [B] AOC <-> aircraft over ACARS (VHF / Satcom, "if equipped"), without going
             * through the crew. AOC roles: flight follower, maintenance controller, load planner.
             * Aircraft -> AOC: automated OOOI reports (Off-gate, Off-ground, On-ground, In-gate),
             *   maintenance fault messages, position reports.
             * AOC -> aircraft: W&B / load closeout uplink, gate uplink, messages to the ACARS
             *   printer (crew-facing content arrives here but is read and accepted by the crew).
             * NOT on this link: ADS-B (surveillance to ATC: atcSurveillance) and CPDLC/PDC
             *   (ATC datalink: atcAircraftDatalink).
             * Intent chain: flown trajectory -> AOC (the feedback path the AOC plans against).
             * Sources: Seamster E-3#10, E-5#06, E-13#12 (automated OOOI), E-2#20, E-10#14;
             * FAA NAS infrastructure roadmaps (ACARS services). */
        }

        // ATC to Airport Operations
        //   - Runway & taxiway lighting: the tower operates the remote lighting controls
        //       -> [A] BB 3-4-2..3-4-15. Signage is fixed, not ATC-driven.
        // Airport Operations to ATC
        //   - Runway / taxiway closures; field condition and braking reports. The airport
        //     operator issues field NOTAMs (BB 2-1-9 names the airport manager's office as a
        //     NOTAM party). Closures change the runway in use, and with it the SID/STAR/approach,
        //     so they reach the trajectory.                        -> [A] BB 2-1-9 / [C] detail
        //   - Departure / arrival times from the airport management system
        //                                                          -> [C] prework hub draft
        //   - NAS component status at the field                   -> [C]

        #ContextVisible connection atcAirport connect airspaceMgmt.atc to airportOps.airport {
            doc /* [A/C] ATC (tower) <-> airport operator.
             * ATC -> airport: operation of airfield lighting (BB 3-4-x).
             * Airport -> ATC: runway/taxiway closures, field conditions and braking reports (field
             *   NOTAMs; BB 2-1-9), departure/arrival times from the airport management system
             *   ([C] hub draft), NAS component status at the field ([C]).
             * Note: the tower is ATC by function but sits physically at the airport
             * (controlTower is a part of Airport in the definitions). Most tower coordination
             * is therefore ATC-internal, not this link. The ATC/airport boundary here is movement
             * area (ATC) vs non-movement area (airport/operator), per the BB glossary and 3-7-2.
             * Intent chain: closures -> runway in use -> SID/STAR/approach -> trajectory. */
        }

        // Airport Operations <-> Crew. Rendered as one summary link (airportToCrew); the
        // per-exchange set is unrendered, like aircraft <-> airport:
        //   caLightingSignals          lights, signs, markings -> crew (visual)    [A] BB 3-4-x
        //   caDockingGuidance          VDGS stop guidance at the stand -> crew     [C]
        //   caMarshalling              marshaller hand/wand signals -> crew        [B] Seamster E-13#10-13
        //   caPushbackCoordination     pushback crew <-> captain: push approval relay, brake
        //                              set/release, engine-start clearance, tow bar
        //                              disconnect / bypass pin shown, "clear" signal
        //                                                              [B] Seamster E-3#05-13; Wilke 2014
        //   caDeicingRequest           crew <-> de-icing crew: request, fluid type, start time
        //                              for holdover, "de-icing complete"           [C]
        //   caFuelSlip                 fueler -> crew: fuel slip (FuelSlip item)   [C]
        //   caGateAgentCoordination    gate agent <-> captain: final passenger count and
        //                              paperwork, door closure, special passengers, late-
        //                              passenger holds                             [C] / [B] Munro

        #ContextVisible connection airportToCrew connect flightCrew.flightDeckCrew to airportOps.airport {
            doc /* [A/B] Summary link, rendered in place of the per-exchange ca* set below.
             * Airport -> crew: lighting, signs and markings (visual, BB 3-4-x); docking guidance
             *   and marshalling to the stand; fuel slip from the airport fuel carrier; gate agent
             *   paperwork and passenger status.
             * Crew <-> ramp: pushback coordination with the pushback crew (brakes, engine start,
             *   tow bar), de-icing requests.
             * Pushback onto the movement area needs ATC; the captain obtains it and relays it to
             * the tug driver (Wilke 2014). Who authorizes the push itself varies by airport.
             * Sources: JO 7110.65BB 3-4-x; Seamster E-3, E-13; Wilke 2014; Munro 2018. */
        }

        // Per-exchange crew <-> airport set (not rendered; see the table above). Endpoints
        // use the Airport sub-parts, so the set can be reused on an Airport Operations IBD.
        connection caLightingSignals connect airportOps.airport.airfieldLighting to flightCrew.flightDeckCrew {
            doc /* [A] Information, airport -> crew: runway/taxiway lights, stop bars, signs and markings, operated from the tower (BB 3-4-x). */
        }
        connection caDockingGuidance connect airportOps.airport.gates to flightCrew.flightDeckCrew {
            doc /* [C] Information, airport -> crew: stop guidance at the stand (visual docking guidance system). The sensing half is apDockingGuidance. */
        }
        connection caMarshalling connect airportOps.airport.groundHandling.marshaller to flightCrew.flightDeckCrew {
            doc /* [B] Information, ramp -> crew: marshalling signals onto the stand where no docking guidance is used (Seamster E-13#10-13). */
        }
        connection caPushbackCoordination connect airportOps.airport.groundHandling.pushbackCrew to flightCrew.flightDeckCrew {
            doc /* [B] Information, both directions: captain relays the push/movement approval from ATC; brake set/release; engine-start clearance; tow bar disconnected and bypass pin shown; "clear" signal. Over the ground interphone (the aircraft is the medium: apGroundInterphone) plus hand signals. Seamster E-3#05-13; Wilke 2014. */
        }
        connection caDeicingRequest connect airportOps.airport.groundHandling.deicing to flightCrew.flightDeckCrew {
            doc /* [C] Information, both directions: crew requests de-/anti-icing; de-icing crew reports fluid type, start time (the crew's holdover time runs from it) and completion. Drives apDeicing. */
        }
        connection caFuelSlip connect airportOps.airport.fuelDistributionSystem.intoPlaneFueler to flightCrew.flightDeckCrew {
            doc /* [C] Information, fueler -> crew: the fuel slip (AirportOperations::FuelSlip). Input to FlightCrew::PreflightCrossCheck; only the cross-check result goes on to the AOC (aocToCrew). */
        }
        connection caGateAgentCoordination connect airportOps.airport.gateAgents to flightCrew.flightDeckCrew {
            doc /* [C] Information, both directions: final passenger count and paperwork, door closure, special passengers, late-passenger holds (friction with dispatch: Munro 2018). */
        }

        // No exchanges between aircraftsys and airportops, assuming its all visual indicators and not data exchanges.
        //   -> RESOLVED (owner, 2026-09-27): these ARE exchanges, mostly material. They are
        //      kept as a complete set below, but only the summary connection (aircraftAirport)
        //      is rendered. Rationale: none of these exchanges affect optimality. Each one is
        //      driven by another actor (AOC load/fuel orders, passengers, weather, maintenance
        //      status, ATC/ramp clearance), so the decision lever sits on THAT actor's link. The
        //      aircraft <-> airport exchange only carries the decision out.
        //   -> 2026-09-27: "carries out" still needs the information that drives it. The last
        //      column names the exchange that carries each decision to the executor; every
        //      one of those is a modeled link (rendered, or in the ca* set).
        //      Endpoints use the Airport / Aircraft sub-parts from the package definitions, so
        //      the set can be reused on an Airport Operations IBD later.
        //
        //   Complete set: aircraft <-> airport (kind; decision made by; carried to the executor by)
        //     Material, airport -> aircraft
        //       apFuelUplift          fuel                      release fuel (dispatcher + captain)
        //                             -> fuel order (aocAirport); extra fuel request (aocToCrew ->
        //                                aocAirport); preset at the panel (apRefuelPanel)
        //       apGroundPower         electrical                gate assignment; APU policy
        //                             -> gate assignment (aocAirport); hookup request (caPushbackCoordination)
        //       apPreconditionedAir   cabin conditioning air    same as ground power
        //       apAirStart            HP air for engine start   MEL (inoperative APU)
        //                             -> MEL via maintenance control -> service order (aocAirport);
        //                                start coordination (caPushbackCoordination)
        //       apPotableWater        water service             AOC service plan -> service order (aocAirport)
        //       apCatering            galley carts, supplies    passenger count -> catering order (aocAirport)
        //       apDeicing             de-/anti-icing fluid      weather; captain -> caDeicingRequest
        //       apLineMaintenance     oil, hydraulic fluid,     aircraft status / MEL; maintenance control
        //                             O2, N2, tires, parts      -> fault report (aocAircraftDatalink,
        //                                                          aocToCrew) -> work order (aocAirport)
        //     Material, both directions
        //       apPassengers          boarding / deplaning      schedule; gate agents -> boarding status
        //                                                          (aocAirport), door close (caGateAgentCoordination)
        //       apBaggage             load / unload             load planner -> load plan (aocAirport)
        //       apCargoMail           load / unload             load planner -> load plan (aocAirport)
        //       apWasteService        lav waste, trash          AOC service plan -> service order (aocAirport)
        //     Physical / mechanical
        //       apGateDocking         jetway or stairs; chocks  gate assignment -> aocAirport;
        //                                                          caDockingGuidance / caMarshalling
        //       apPushbackTow         tug force; towing         ATC movement approval + captain
        //                                                          -> atcToCrew, then caPushbackCoordination
        //     Information / signals
        //       apDockingGuidance     aircraft position sensed; guidance shown to the crew
        //                             (VDGS; A-CDM p.36 in-block detection)    [C] for US practice
        //       apRefuelPanel         fueler's preset qty -> aircraft; FQIS qty -> fueler
        //                             (feeds the fuel slip, caFuelSlip)          [C]
        //       apGroundInterphone    ground crew <-> flight deck, plugged into the aircraft
        //                             (the aircraft is the medium for caPushbackCoordination)  [B] Seamster E-3
        //       apGatelinkData        nav database / software loads, maintenance downloads  [C]
        //       apNoiseMonitoring     aircraft noise -> airport noise monitors; driven by
        //                             Governance / community (noiseAbatementProcedures)  [C]
        //       apNavaidSignals       ILS / DME / GBAS -> aircraft nav receivers. The far end
        //                             is environment.infrastructure, not the airport: D-007
        //                             puts navaids under Infrastructure, and most ILS are
        //                             FAA-owned and FAA-maintained (NAS roadmaps)     [B/C]
        //   Evidence (tag in each connection's doc): [B] for the turnaround activities the
        //   registered sources name (fuel, catering, cleaning/waste, boarding/deplaning:
        //   Schultz 2017; bags/cargo: Lu 2025; pushback, interphone: Seamster E-3); [B/C]
        //   navaids; rest [C] general knowledge (ground power, PCA, air start, water,
        //   de-icing, line maintenance, docking, refuel panel, gatelink, noise). Not driving any
        //   optimization lever, so not worth citing individually unless the report discusses them.
        //   Intentionally left out: lighting/markings (airport -> CREW, caLightingSignals), surface
        //   surveillance (ASDE-X/multilateration: ATC, on atcSurveillance), OOOI (aircraft -> AOC).

        #ContextVisible connection aircraftAirport connect aircraftSys.aircraft to airportOps.airport {
            doc /* [B] Summary link, rendered in place of the per-exchange set below. Mostly
             * material turnaround servicing (fuel, power, air, water, catering, bags, cargo,
             * passengers), gate docking and pushback, plus a few data exchanges (docking
             * guidance, refuel panel, gatelink). Does not affect optimality: every exchange
             * executes a decision made on another actor's link (owner, 2026-09-27), and the
             * information that carries each decision is on aocAirport or the ca* set. */
        }

        // Per-exchange set (not rendered; see the table above).
        connection apFuelUplift connect aircraftSys.aircraft.fuelSystem to airportOps.airport.fuelDistributionSystem {
            doc /* [B] Material, airport -> aircraft: fuel. Driven by the release fuel order (aocAirport) and the captain's request. */
        }
        connection apGroundPower connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Material, airport -> aircraft: 400 Hz ground power at the gate (or a GPU cart). */
        }
        connection apPreconditionedAir connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Material, airport -> aircraft: preconditioned cabin air at the gate. */
        }
        connection apAirStart connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [C] Material, airport -> aircraft: high-pressure air for engine start. Needed when the APU is inoperative (MEL). */
        }
        connection apPotableWater connect aircraftSys.aircraft to airportOps.airport.groundHandling.lavAndWaterService {
            doc /* [C] Material, airport -> aircraft: potable water service. */
        }
        connection apCatering connect aircraftSys.aircraft to airportOps.airport.groundHandling.catering {
            doc /* [B] Material, airport -> aircraft: galley carts and supplies, sized by the AOC's passenger count (catering order on aocAirport). */
        }
        connection apDeicing connect aircraftSys.aircraft to airportOps.airport.groundHandling.deicing {
            doc /* [C] Material, airport -> aircraft: de-/anti-icing fluid. Driven by weather and the captain's request (caDeicingRequest). */
        }
        connection apLineMaintenance connect aircraftSys.aircraft to airportOps.airport.maintenanceHangar {
            doc /* [C] Material, both directions: servicing fluids and gases, tires and parts in; removed parts out. Driven by aircraft status / MEL via maintenance control (work order on aocAirport). Line maintenance happens at the gate; maintenanceHangar is the only maintenance part in the definitions. */
        }
        connection apPassengers connect aircraftSys.aircraft to airportOps.airport.passengerTerminal {
            doc /* [B] Material, both directions: boarding and deplaning via the gate / jetway. */
        }
        connection apBaggage connect aircraftSys.aircraft to airportOps.airport.baggageHandlingSystem {
            doc /* [B] Material, both directions: checked baggage loaded and unloaded per the load plan (aocAirport). */
        }
        connection apCargoMail connect aircraftSys.aircraft to airportOps.airport.cargoTerminal {
            doc /* [B] Material, both directions: cargo and mail loaded and unloaded per the load plan (aocAirport). */
        }
        connection apWasteService connect aircraftSys.aircraft to airportOps.airport.groundHandling.lavAndWaterService {
            doc /* [B] Material, aircraft -> airport: lavatory waste and cabin trash; cabin cleaning. */
        }
        connection apGateDocking connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Physical: jetway or stairs attachment, chocks, parking position. */
        }
        connection apPushbackTow connect aircraftSys.aircraft to airportOps.airport.groundHandling.pushbackCrew {
            doc /* [B] Physical: tug pushback and towing. Driven by ATC movement approval, relayed by the captain (caPushbackCoordination). */
        }
        connection apDockingGuidance connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Information: the visual docking guidance system senses the aircraft's position (the crew-facing half is caDockingGuidance); can also detect in-block / off-block (A-CDM p.36). */
        }
        connection apRefuelPanel connect aircraftSys.aircraft.fuelSystem to airportOps.airport.fuelDistributionSystem.intoPlaneFueler {
            doc /* [C] Information, both directions: fueler presets quantity at the refuel panel; aircraft fuel quantity read back to the fueler. Source of the fuel slip (caFuelSlip). */
        }
        connection apGroundInterphone connect aircraftSys.aircraft to airportOps.airport.groundHandling.pushbackCrew {
            doc /* [B] Information: ground crew headset plugged into the aircraft interphone. The aircraft is the medium for caPushbackCoordination (Seamster E-3#05-13). */
        }
        connection apGatelinkData connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Information, both directions: navigation database and software loads in; maintenance and flight data downloads out. */
        }
        connection apNoiseMonitoring connect aircraftSys.aircraft to airportOps.airport {
            doc /* [C] Information, aircraft -> airport: noise measured by airport monitors against Airport.noiseAbatementProcedures. Driven by Governance / community. */
        }
        connection apNavaidSignals connect aircraftSys.aircraft.navigationSystem to environment.infrastructure {
            doc /* [B/C] Information, infrastructure -> aircraft: ILS localizer/glideslope, DME, GBAS signals. Physically at the airport, but D-007 places navaids in Infrastructure: most are FAA-owned and maintained (NAS roadmaps), some non-federal. Unlike lighting, which the airport owns (14 CFR 139.311) and the tower operates. */
        }

        // Aircraft Systems to Crew
        //   - Aircraft & engine status, fuel status (FQIS), nav/avionics status  -> [SME]
        //   - Equipment malfunctions & emergencies (crew alerting)              -> [SME]
        //   - Position & trajectory info (via FMS: ND/PFD)                      -> [SME]
        //   - FMS performance predictions (fuel at destination, ETA, gross weight, optimum
        //     altitude), checked against the release in PreflightCrossCheck     -> [SME]
        //   - Recommended aircraft control (flight director / autopilot targets)
        //       -> [SME] This is the "FMS intent -> guidance commands" step of the intent
        //          chain, so it's central, not peripheral.
        //   - TCAS RAs, TAWS alerts                                             -> [A] BB 2-1-28/30 (controller side)
        // Crew to Aircraft Systems: the execution step
        //   - FMS entries: route, SID/STAR/approach, performance data (ZFW, fuel, cost index,
        //     cruise altitude, winds), and loading of crew-accepted CPDLC clearances
        //   - Automation mode selection: arm/engage LNAV/VNAV, autopilot, autothrottle
        //   - MCP/FCU selections: speed, altitude, heading, vertical speed (these bound what
        //     the FMS may do)
        //   - Manual control inputs: yoke/sidestick, rudder, throttles when autothrottle is off
        //   - Configuration: flaps/slats, gear, speedbrakes, lights
        //   - Transponder settings on ATC instruction (code, ident, standby)    -> [A] BB 5-2-x, 5-3-3
        //   - Radio tuning / frequency changes
        // Pilot <-> FMS interdependency (owner, 2026-09-27): on most modern transport aircraft
        // the FMS cannot control the aircraft without pilot action (perf data entry, MCP
        // speed/altitude changes, throttle control, engagement of the automation). Recorded
        // here and in AircraftSystems::FlightManagementSystem's doc; not explored further.
        // Evidence: [SME]. The owner has worked 16 years in industry on FMS technologies; the
        // write-up states that, or cites a source if one is found. Candidates (not
        // registered): ARINC 702A (FMC characteristic), the type's FCOM, FAA AC 120-71B
        // (SOPs and pilot monitoring duties); registered: GreAT D5.1, Mhenni 2016.

        #ContextVisible connection crewAircraft connect flightCrew.flightDeckCrew to aircraftSys.aircraft {
            doc /* [SME] Crew <-> aircraft execution.
             * Aircraft -> crew: status/alerting, fuel quantity (FQIS gauges), nav/avionics status,
             *   position and trajectory, FMS performance predictions (fuel at destination, ETAs,
             *   gross weight, optimum altitude) the crew checks against the release,
             *   FMS guidance (flight director / autopilot targets), TCAS RAs, TAWS alerts.
             * Crew -> aircraft: FMS entries (route, SID/STAR, performance data: ZFW, fuel, cost
             *   index, cruise altitude, winds; loading crew-accepted CPDLC clearances),
             *   automation engagement (LNAV/VNAV, autopilot, autothrottle), MCP/FCU selections
             *   (speed, altitude, heading), manual control inputs and thrust, configuration
             *   (flaps, gear, speedbrakes), transponder and radio settings.
             * Interdependency: the FMS cannot fly the aircraft without these crew actions; it
             *   proposes, the crew authorizes and executes.
             * Either pilot may fly or monitor; the flight deck is one end (D-009).
             * Intent chain: FMS intent -> guidance commands -> aircraft motion.
             * Evidence: owner's professional FMS experience; candidate citations ARINC 702A,
             * FCOM, FAA AC 120-71B (not registered); GreAT D5.1, Mhenni 2016 (registered). */
        }

        #ContextVisible connection atcSurveillance connect airspaceMgmt.atc to aircraftSys.aircraft {
            doc /* [A] Surveillance, not command. Aircraft -> ATC: secondary-radar replies with
             * the ATC-assigned beacon code (Mode 3/A) and pressure altitude (Mode C/S), and
             * ADS-B Out broadcasts. ADS-B still requires an operable transponder, and "the
             * ATC-assigned beacon code is one of the required message elements of ADS-B Out"
             * (BB 5-2-1a NOTE). Approved surveillance sources include secondary radar and, in
             * STARS Fusion/multi-sensor modes, ADS-B and WAM targets (5-1-2). Primary radar
             * returns need nothing from the aircraft.
             * ATC -> aircraft: radar interrogation only. Code changes, IDENT, standby and
             * altitude-reporting changes are INSTRUCTIONS to the crew (atcToCrew; 5-2-10,
             * 5-2-18, 5-3-3).
             * What ATC does with it: identifies the target (5-3-3), correlates the data block to
             * the flight plan (5-3-3d), validates Mode C to within 300 ft of the pilot report
             * (5-2-15), flags malfunctioning transmitters and ADS-B call-sign mismatches against
             * the flight plan ID (5-2-12, 5-2-22, 5-2-23).
             * Intent chain: aircraft motion -> ATC (the feedback that closes the loop). The gap
             * between the aircraft's true state and ATC's tracked picture is the cyber-physical
             * gap (Mordecai 2018); Mode C validation and CSMM alerts are the order's own checks
             * on that gap.
             * Sources: JO 7110.65BB 5-1-2, 5-2-1, 5-2-10..5-2-23, 5-3-3; 09-20 lecture capture;
             * Mordecai 2018. */
        }

        #ContextVisible connection atcAircraftDatalink connect airspaceMgmt.atc to aircraftSys.aircraft {
            doc /* [A/B/C] ATS datalink: ATC <-> aircraft through the aircraft's communication
             * systems (CMU/ACARS, FANS 1/A).
             * ATC -> aircraft: pre-departure clearance (PDC over ACARS; Seamster E-2#07-09, [B]),
             *   D-ATIS (ACARS service in the FAA NAS roadmaps, [B]), CPDLC clearances: FAA Data
             *   Comm departure clearances and en route CPDLC ([C] domestic, not yet sourced),
             *   oceanic CPDLC as the primary means outside VHF coverage (BB 8-1-6, [A]).
             * Aircraft -> ATC: CPDLC requests and responses (WILCO/UNABLE), PDC request, ADS-C
             *   reports oceanic (BB 8-1-6).
             * Authority: the aircraft is the medium, not a decision-maker. A CPDLC route
             * clearance can be loaded into the FMS only after the crew accepts it, so the
             * decision stays on the crew (atcToCrew holds the authority text).
             * Intent chain: ATC constraints -> FMS intent, the machine-to-machine shortcut TBO
             * builds on (7210.3EE 18-6-1: "information exchanged between air and ground systems").
             * Sources: Seamster 2011 E-2; JO 7110.65BB 8-1-6; FAA NAS infrastructure roadmaps. */
        }


        // ==================================================================
        // Inside Airspace Management (ATCSCC <-> TMU, TMU <-> tactical ATC, the atc umbrella
        // question, NTML as the medium): moved to nas_ibd_airspace_management.sysml (D-010).
        // ==================================================================


        // ==================================================================
        // ENVIRONMENT / boundary actors (rendered drafts)
        // ==================================================================
        //     The evidence note proposes three kinds of flow: rules (static), disturbances
        //     (dynamic scenario inputs), and feedback. Link an actor only where it changes a
        //     decision.
        // Rules [A]: 14 CFR 91/121, JO 7110.65BB / 7210.3EE bind the operator and ATC.
        #ContextVisible connection rulesToAoc connect environment.governance to flightOps.airlineOperationsCenter;
        #ContextVisible connection rulesToAtc connect environment.governance to airspaceMgmt.atc;
        // Disturbance [A]: weather drives TMIs and SWAP (7210.3EE 18-15/16), ATIS (BB 2-9) and dispatch planning.
        #ContextVisible connection weatherToTfm connect environment.infrastructure.weatherService to airspaceMgmt.atcscc;
        #ContextVisible connection weatherToAoc connect environment.infrastructure.weatherService to flightOps.airlineOperationsCenter;
        // Disturbance [C]: special-use airspace status as a scenario condition (D-007).
        #ContextVisible connection suaToTfm connect environment.military to airspaceMgmt.atcscc;


        // ==================================================================
        // DRAFTS (commented out)
        // ==================================================================

        // --- Cabin crew <-> flight deck. [C] cabin secure / ready for departure; passenger
        //     medical, security or disruptive-passenger events that trigger a diversion
        //     (Seamster T2.10 covers diversion on the crew <-> AOC side). Internal to the
        //     Flight Crew domain, so per D-010 it belongs on a Flight Crew IBD, not here.
        // connection cabinToFlightDeck connect flightCrew.cabinCrew to flightCrew.flightDeckCrew {
        //     doc /* Cabin -> captain: cabin secure, passenger/medical/security events.
        //      * Captain -> cabin: phase-of-flight and turbulence advisories. */
        // }

        // --- Preflight cross-check: DONE 2026-09-27. The item defs (DispatchRelease, FuelSlip,
        //     FmsPerformancePrediction, PreflightCrossCheckResult) and the action def
        //     PreflightCrossCheck now live in nas_sysml_package_definitions.sysml, and
        //     FlightDeckCrew performs it. Nothing is rendered here.

        // --- Directed, typed exchanges (the next step past undirected `connection`s).
        //     Everything above is an undirected link with its content in a doc comment. For §10
        //     (item-flow model), the content becomes item defs moving through ports. Worked
        //     example on the A-graded AOC <-> ATCSCC link; the same pattern repeats per link.
        //     The item defs now exist in AirspaceManagement (ExpectDepartureClearanceTime,
        //     TMIAdvisory, TrajectoryOptionsSet, ...). To use: move the port def into
        //     nas_sysml_package_definitions.sysml (methods §10.1), add the `port` lines inside
        //     the airlineOperationsCenter / atcscc redefinitions at the top, then uncomment the flows.
        // port def TFMCustomerPort {
        //     in item edct: ExpectDepartureClearanceTime;
        //     in item advisory: TMIAdvisory;
        //     out item tos: TrajectoryOptionsSet;
        // }
        //   inside flightOps { part :>> airlineOperationsCenter { port tfm: TFMCustomerPort; } }
        //   inside airspaceMgmt { part :>> atcscc { port customers: ~TFMCustomerPort; } }
        // #ContextVisible flow of ExpectDepartureClearanceTime from airspaceMgmt.atcscc.customers.edct to flightOps.airlineOperationsCenter.tfm.edct;
        // #ContextVisible flow of TMIAdvisory from airspaceMgmt.atcscc.customers.advisory to flightOps.airlineOperationsCenter.tfm.advisory;
        // #ContextVisible flow of TrajectoryOptionsSet from flightOps.airlineOperationsCenter.tfm.tos to airspaceMgmt.atcscc.customers.tos;

    }
}
