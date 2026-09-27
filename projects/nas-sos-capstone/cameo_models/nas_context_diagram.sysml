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
     * Per D-009 only modeled systems are rendered (#ContextVisible) for now.
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
        // (infrastructure), ABSORBED (informationServices, decisionSupport). Not rendered yet;
        // links drafted in "MISSING". Maintenance Suppliers (context constraint) has no part yet.
        part environment: EnvironmentDomain;
        #ContextVisible part airportOps: AirportOperationsDomain {
            // D-007: MODELED. Authority over gates, non-movement area, closures, and slots at
            // coordinated airports; departure readiness couples to EDCT compliance and
            // schedule reliability. Weakest evidence of the modeled set (C/B). Rendered.
            // Its sub-parts (fuel, ground handling, gates, terminals, baggage, cargo,
            // maintenance) are ABSORBED: they carry out decisions made elsewhere (owner
            // 2026-09-27), so they appear only as ends of the unrendered aircraft <-> airport set.
            #ContextVisible part :>> airport;
        }
        #ContextVisible part airspaceMgmt: AirspaceManagementDomain {
            // D-007: MODELED. Tactical control authority (clearances, separation; JO 7110.65BB)
            // directly shapes the flown trajectory; safety + schedule. Rendered.
            #ContextVisible part :>> atc;
            // D-007: MODELED. "Final approving authority" for interfacility TMIs (7210.3EE
            // 18-2-3i); EDCT/CTOP/reroutes couple straight to airline decisions; delay cost and
            // schedule reliability. Rendered.
            #ContextVisible part :>> atcscc;
            // D-007: MODELED. Local TM Unit (MIT, fix balancing; 18-2-3 NOTE); turns
            // national TMIs into constraints on the sectors; schedule + controller workload. Rendered.
            // One part stands for terminal and ARTCC TMUs.
            #ContextVisible part :>> tmu;
            // tracon / artcc: MODELED in the definitions, but at context level they are covered
            // by the atc umbrella. Not rendered.
        }
        #ContextVisible part aircraftSys: AircraftSystemsDomain {
            // D-007: MODELED. No decision authority, but its execution behavior (FMS intent ->
            // guidance -> motion) IS the end of the intent chain; fuel burn, safety. Rendered.
            #ContextVisible part :>> aircraft;
        }
        #ContextVisible part flightOps: FlightOperationsDomain {
            // D-007: MODELED. Operational control; the dispatcher and PIC are jointly
            // responsible for the release (14 CFR 121.533); sets the airline's plan and fuel;
            // cost and schedule. Rendered.
            #ContextVisible part :>> airlineOperationsCenter;
            // ticketingSystem: ABSORBED. Revenue/booking side; enters only as passenger demand
            // (a boundary-actor effect per D-007). Not rendered.
        }
        #ContextVisible part flightCrew: FlightCrewDomain {
            // D-007: MODELED, as ONE element (D-009 merge). The PIC holds final authority
            // (14 CFR 91.3) and turns the plan + clearances into FMS intent; safety,
            // workload, fuel. The PIC / FO split is not a separate authority at context
            // level, so the two roles live inside flightDeckCrew and aren't rendered.
            #ContextVisible part :>> flightDeckCrew;
            // cabinCrew: inside the MODELED Flight Crew domain but ABSORBED at context level.
            // No authority over in-scope decisions; "cabin secure" couples only weakly to
            // departure time, through the PIC. Not rendered (owner, 2026-09-27).
            part :>> cabinCrew;
        }

        // ------------------------------------------------------------------
        // REVIEW KEY (added 2026-09-27)
        //   [A]  primary/normative source states it (JO 7110.65BB, JO 7210.3EE)
        //   [B]  empirical literature shows it (Seamster 2011, Berry & Pace 2011, Munro 2018)
        //   [C]  your notes / general domain knowledge; defensible, not yet citable
        //   TODO(review)  no evidence, a direction/term problem, or weak tie to the
        //                 intent chain (index.md "Center of gravity") - your call
        //   TODO(missing) something the notes leave out; draft code is commented out
        //                 in the "MISSING" section at the bottom
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
        //              - Airport lighting isn't an ATC -> crew exchange. The tower controller
        //                operates the lights (ATC -> airport, BB 3-4-2..3-4-15), and the lights
        //                signal the pilot (airport -> crew). Those halves live on atcAirport
        //                and airportToCrew.
        //            What airport -> aircraft data remains is navaid signals (ILS), and D-007
        //            may put those under Infrastructure instead.
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.
        //  - The airspace management domain:
        //     - communicating with the flight operations domain,
        //     - communicating with the airport operations domain,
        //     - sending data to the aircraft systems domain,
        //         -> TODO(review): direction is mostly backwards. Surveillance data runs
        //            aircraft -> ATC (transponder / ADS-B). ATC's instructions reach the aircraft
        //            only through the crew (clearances), or via datalink (PDC over ACARS,
        //            CPDLC) that the crew accepts and enters. No ATC -> aircraft control path.
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.


        // Core operational coordination  - AOC to Crew
        //   - Released fuel loading, cargo loading & passenger list
        //       -> [B] Dispatch release (Seamster E-1/E-2; Munro 2018). The release sets fuel that 
        //          the dispatcher AND aptain both sign; the captain may ask for more (Munro). The 
        //          passenger load and final W&B come from load control (Seamster E-2#20).
        //   - Flight plan & route info (SID/STAR, altitudes, waypoints, etc.)   -> [B] E-1/E-2
        //   - Weather & NOTAM info                                               -> [B] release package
        //   - Dispath paperwork <ADD MORE DETAIL>

        // Core operational coordination  - Crew to AOC
        //   - Final Passenger & Fuel Load
        //          [B] crew -> AOC fuel on board (E-7#08-09, E-9#06-09); release acceptance /
        //          requests for more fuel (Munro). [C] the fuel slip and gauge cross-check are
        //          standard practice but not yet in a registered source.
        //   - Aircraft Configuration & Performance Data
        //          [C] standard flight-deck practice; FMS initialization inputs in ConOps Phase 3.
        //          TODO(review) evidence: needs an FCOM / operator procedures source for the
        //          cross-check and its tolerances.
        //   - Aircraft Status & Maintenance Needs   -> [B] to maintenance control (Berry & Pace);
        //                                              often automated, i.e. aocAircraftDatalink
        //   - Equipment Malfunctions & Emergencies  -> [B] Seamster T2.10 (diversion, emergency)
        //   - Pilot Reports (PIREPs)                -> [C] common practice (ride reports to
        //                                              dispatch); the sources only cover PIREPs to ATC
        //   - Route Modification Needs              -> [B] Seamster A.1#41-46 (reclearance,
        //                                              route change, ETA change > 5 min)

        #ContextVisible connection aocToCrew connect flightOps.airlineOperationsCenter to flightCrew.flightDeckCrew {
            doc /* [B] Dispatch/operational control link (dispatcher <-> flight deck; the captain signs).
             * AOC -> crew: dispatch release (route, fuel, alternates, weather, NOTAMs, MEL),
             *   amended release / reroute + ETA, load & final W&B (from load control).
             * Crew -> AOC: release acceptance / fuel requests, fuel on board (after the
             *   fuel-slip / gauge check), release-vs-FMS discrepancies, maintenance
             *   and malfunction reports, diversion/emergency, route-change needs, ETA changes.
             * Media: phone/radio pre-departure; ACARS/Satcom airborne. Both sign the release; the
             * captain has final authority (14 CFR 91.3).
             * Intent chain: mission plan -> flight plan (the airline's intent reaching the crew).
             * Sources: Seamster 2011; Munro 2018; Berry & Pace 2011. */
        }
        // Core operational coordination  - ATC to Crew
        //   - radio comms hand-offs & transfer info   -> [A] BB 5-4-5..5-4-8, 2-1-15; Seamster E-6#03-04
        //   - traffic advisories                      -> [A] BB 2-1-21
        //   - request responses/clearances            -> [A] BB 4-2-x, 4-3-x, 3-7-2, 3-9-x, 4-8-1
        //   - ATIS info                               -> [A] BB 2-9-2/3 (broadcast)
        //   - Expected Departure Clearance Times (EDCTs)
        //       -> [A] BB 4-3-4 (hold-for-release / EDCT in the clearance, E-2#10).
        //          TODO(review) term: EDCT = "Expect Departure Clearance Time" (FAA P/CG,
        //          glossary.md). The ATCSCC assigns it; ATC only relays and enforces it
        //          (-5/+5 min). The crew usually gets it from dispatch first.
        //   -> TODO(missing): holding instructions + Expect Further Clearance (BB 4-6-1,
        //      Seamster E-9); safety alerts (terrain/traffic); altimeter settings; approval of
        //      weather deviations; PIREP solicitation (BB 2-6-2). Holding and deviations are
        //      trajectory-changing, so they matter for the intent chain.

        // Core operational coordination  - Crew to ATC
        //   - Intent, Requests, & Reports                -> [A] BB; Seamster T2.7#21, T2.4#06
        //   - Equipment Malfunctions & Emergencies       -> [A] BB 2-1-7, Ch. 10
        //   - Pilot Reports (PIREPs)                     -> [A] BB 2-6-2
        //   - Comms Establishing at departure and in response to transfer
        //                                                -> [A] BB 2-9-3 (ATIS code on contact); Seamster E-5#08-10

        #ContextVisible connection atcToCrew connect airspaceMgmt.atc to flightCrew.flightDeckCrew {
            doc /* [A/B] Tactical control: the best-evidenced link in the model.
             * ATC -> crew: clearances (IFR/PDC, taxi, takeoff, altitude/heading/speed/route,
             *   approach, landing), frequency changes/handoffs, traffic advisories, ATIS,
             *   EDCT/hold-for-release as relayed from TFM.
             * Crew -> ATC: requests and intent, read-backs, check-in with ATIS code,
             *   malfunctions/emergencies, PIREPs.
             * Media: radio (145 of ~277 Seamster matrix rows); PDC via ACARS.
             * Authority: ATC holds tactical control; clearances leave "little room for
             * negotiations" (Seamster p.46); the PIC keeps final authority (14 CFR 91.3).
             * Intent chain: ATC constraints -> trajectory negotiation.
             * Either pilot may be the voice on the radio (the FO in E-2#07, E-4#02-04).
             * Sources: JO 7110.65BB (2-1-21, 2-6-2, 2-9-2/3, 4-3-4, 5-4-5..8); Seamster E-1..E-13. */
        }

        // Core operational coordination  - ATC to AOC (ATSCC -> Flight Ops)
        //   - Traffic Advisories
        //       -> [A] content is right, term is wrong. TODO(review): "traffic advisory" is
        //          the BB 2-1-21 controller -> pilot proximity call. The ATCSCC sends
        //          operators ADVISORIES (GDP, GS, AFP, CTOP, reroute; 7210.3EE 18-10-6c,
        //          18-12-4, 18-15-2a7). Rename to "TMI / reroute advisories".
        //   - Estimated Departure Clearance Times (EDCTs)
        //       -> [A] 7210.3EE 18-10-6e: EDCTs go "to ARTCCs and linked system users".
        //   - Adverse Flight Condition Advisories (weather, equipment, etc.)
        //       -> [A] hotlines/telcons cover weather, outages, routes (7210.3EE 18-4-1d);
        //          severe weather management and SWAP are ATCSCC-led (18-15, 18-16).
        //   -> TODO(missing): CTOP route/delay assignment against the operator's TOS (18-12);
        //      FEA/FCA publication (18-8); Operations Plan / planning webinar (18-21-4a).
        //      These are where TFM constraints first reach the operator's trajectory choice.

        // Core operational coordination  - AOC to ATC
        //   - Flight Plan & Route Info (SID/STAR, altitudes, waypoints, etc.)
        //       -> [A] but to a different party: flight plans are filed computer-to-computer
        //          to the ARTCC host via NADIN (7210.3EE 6-5; no earlier than 3 h, phone inside
        //          45 min). That's aocFlightPlanFiling (to atc), not the ATCSCC link.
        //   - Proposed route modifications
        //       -> [A] Trajectory Options Set (TOS) and Early Intent to TFMS (7210.3EE 18-12-3b,
        //          18-8-2c); coordination with the ATCSCC Tactical Customer Advocate (18-8-3d).
        //   -
        //       -> TODO(missing): schedule changes/cancellations to FSM (18-10-3); GDP slot
        //          substitution (18-10-12); diversion recovery priorities (18-4-5). Slot
        //          substitution is exactly the airline-vs-system trade the §9 conflict work needs.

        #ContextVisible connection aocTfm connect flightOps.airlineOperationsCenter to airspaceMgmt.atcscc {
            doc /* [A] Traffic flow management / Collaborative Decision Making link.
             * ATCSCC -> operator: EDCTs, GDP/GS/AFP/CTOP/reroute advisories, hotline/telcon
             *   content (weather, outages, capacity), CTOP assignments.
             * Operator -> ATCSCC/TFMS: schedule changes (FSM), TOS, Early Intent, GDP substitutions,
             *   diversion recovery priorities, customer preferences on hotlines.
             * Party on the AOC side: the ATC coordinator, not the dispatcher (Berry & Pace;
             * Seamster p.34, p.45).
             * Authority: the ATCSCC is the "final approving authority" for interfacility TMIs
             * (18-2-3i); operators must "operate to meet the EDCT" (BB 4-3-4).
             * Intent chain: flight plan <-> ATC constraints. This is where airline objectives meet
             * NAS flow objectives (the §9 local-vs-system conflict).
             * Sources: JO 7210.3EE CHG 3 18-4-1d, 18-8-2c/3d, 18-10-3/6e/12, 18-12-3b, 18-4-5. */
        }
        #ContextVisible connection aocFlightPlanFiling connect flightOps.airlineOperationsCenter to airspaceMgmt.atc {
            doc /* [A] Flight plan filing and amendment. AOC -> ARTCC host (NADIN / computer
             * interface): filed flight plan with route, SID/STAR, altitudes; amendments. Amended
             * plan after a TFM reroute is released to ARTCC host (Seamster E-7#14).
             * Intent chain: flight plan (the filed intent ATC starts from).
             * Sources: JO 7210.3EE 6-5, 18-7-4h2; Seamster E-7#14, T2.7#35. */
        }
        // TODO(review): `atc` sits beside `tracon`, `artcc`, `atcscc`, `tmu` in
        // AirspaceManagementDomain as if it were one more peer, but it's really the umbrella
        // for tower + TRACON + ARTCC controllers. Fine at context level. When you go to the IBD,
        // decide whether atc is replaced by those three or holds them as its sub-parts.

        #ContextVisible connection aocAirport connect flightOps.airlineOperationsCenter to airportOps.airport {
            doc /* [C/B] Airline <-> airport/station coordination.
             * AOC -> airport: schedules, expected passengers, fuel/catering/baggage needs,
             *   target off-block time (TOBT, A-CDM).
             * Airport -> AOC: gate assignment, service readiness, boarding status.
             * Sources: interface-exchange-draft.md (prework hub, C, directions unverified);
             * Clarke 1998 (B); EUROCONTROL A-CDM (A, but European). */
        }
        // TODO(missing): you have no exchange list for AOC <-> Airport, and it's the weakest
        // link on US evidence. Specifics to fill: (1) gate assignment authority (airline-leased
        // gates vs airport-assigned); (2) turnaround readiness (fuel, catering, bags) feeding the
        // off-block time; (3) whether US practice has an A-CDM-like TOBT exchange (FAA TFDM /
        // JO 7210.637 is the lead; not in the register). Relevance: turnaround readiness sets
        // the actual departure time, which feeds EDCT compliance and trajectory start.

        #ContextVisible connection aocAircraftDatalink connect flightOps.airlineOperationsCenter to aircraftSys.aircraft {
            doc /* [B] Aircraft -> AOC without going through the crew: automated OOOI reports
             * (Off-gate, Off-ground,On-ground, In-gate), maintenance fault messages, position reports.
             * AOC -> aircraft: W&B / load uplink, gate uplink, messages to the ACARS printer.
             * Medium: ACARS / Satcom ("if equipped").
             * Intent chain: flown trajectory -> AOC (the feedback path the AOC plans against).
             * Sources: Seamster E-3#10, E-5#06, E-13#12 (automated OOOI), E-2#20, E-10#14;
             * FAA NAS infrastructure roadmaps (ACARS services). */
        }

        // ATC to Airport Operations
        //   - Runway & Taxiway Status to drive Lights & Signage
        //       -> [A] for lights: BB 3-4-2..3-4-15, the tower controller operates the remote
        //          lighting controls. 

        #ContextVisible connection atcAirport connect airspaceMgmt.atc to airportOps.airport {
            doc /* [A/C] ATC (tower) <-> airport operator.
             * ATC -> airport: operation of airfield lighting (BB 3-4-x).
             * Airport -> ATC: closures, field conditions, NAS component status (BB 2-1-9, C for detail).
             * Note: the tower is ATC by function but sits physically at the airport
             * (controlTower is a part of Airport in the definitions). Most tower coordination
             * is therefore ATC-internal, not this link. The ATC/airport boundary here is movement
             * area (ATC) vs non-movement area (airport/operator), per the BB glossary and 3-7-2. */
        }

        // Airport Operations to Crew
        //   - Runway & Taxiway Status via Lights   -> [A] BB 3-4-x (lights -> pilot, visual)
        //   -> TODO(missing): ramp/pushback crew <-> captain (push clearance relay, brake/engine-start
        //      cues, marshalling to the gate: Seamster E-3#05-13, E-13#10-13; Wilke 2014). This is
        //      the airport link with real sources behind it; lights alone are the thin part.

        #ContextVisible connection airportToCrew connect flightCrew.flightDeckCrew to airportOps.airport {
            doc /* [A/B] Airport lighting and markings -> pilot (visual, BB 3-4-x); ramp/pushback
             * and gate guidance <-> crew (Seamster E-3, E-13; Wilke 2014); fuel slip from
             * the airport fuel carrier (owner, 2026-09-27). Pushback onto the
             * movement area needs ATC; who authorizes the push itself varies by airport. */
        }

        // No exchanges between aircraftsys and airportops, assuming its all visual indicators and not data exchanges.
        //   -> RESOLVED (owner, 2026-09-27): these ARE exchanges, mostly material. They are
        //      kept as a complete set below, but only the summary connection (aircraftAirport)
        //      is rendered. Rationale: none of these exchanges affect optimality. Each one is
        //      driven by another actor (AOC load/fuel orders, passengers, weather, maintenance
        //      status, ATC/ramp clearance), so the decision lever sits on THAT actor's link. The
        //      aircraft <-> airport exchange only carries the decision out.
        //      Endpoints use the Airport / Aircraft sub-parts from the package definitions, so
        //      the set can be reused on an Airport Operations IBD later.
        //
        //   Complete set: aircraft <-> airport (kind; direction; driven by)
        //     Material, airport -> aircraft
        //       apFuelUplift          fuel                      AOC release fuel order; crew
        //       apGroundPower         Electrical                gate assignment; APU policy
        //       apPreconditionedAir   cabin conditioning air    gate assignment; APU policy
        //       apAirStart            HP air for engine start   MEL (inoperative APU)
        //       apPotableWater        water service             AOC service plan
        //       apCatering            galley carts, supplies    AOC passenger count
        //       apDeicing             de-/anti-icing fluid      weather; crew request
        //       apLineMaintenance     oil, hydraulic fluid,     aircraft status / MEL;
        //                             O2, N2, tires, parts      maintenance control
        //     Material, both directions
        //       apPassengers          boarding / deplaning      passengers; AOC schedule
        //       apBaggage             load / unload             passengers; AOC
        //       apCargoMail           load / unload             AOC cargo sales
        //       apWasteService        lav waste, trash          AOC service plan
        //     Physical / mechanical
        //       apGateDocking         jetway or stairs; chocks  gate assignment (AOC / airport)
        //       apPushbackTow         tug force; towing         ATC ramp/movement clearance; crew
        //     Information / signals
        //       apDockingGuidance     aircraft position sensed; guidance shown to the crew
        //                             (VDGS; A-CDM p.36 in-block detection)    [C] for US practice
        //       apRefuelPanel         fueler's preset qty -> aircraft; FQIS qty -> fueler
        //                             (feeds the fuel slip in PreflightCrossCheck)  [C]
        //       apGroundInterphone    ground crew <-> flight deck, plugged into the aircraft
        //                             (the aircraft is the medium for crew <-> ramp)  [B] Seamster E-3
        //       apGatelinkData        nav database / software loads, maintenance downloads  [C]
        //       apNoiseMonitoring     aircraft noise -> airport noise monitors; driven by
        //                             Governance / community (noiseAbatementProcedures)  [C]
        //       apNavaidSignals       ILS / DME / GBAS -> aircraft nav receivers. The far end
        //                             is environment.infrastructure, not the airport: D-007
        //                             puts navaids under Infrastructure, and most ILS are
        //                             FAA assets (NAS roadmaps)                      [B/C]
        //   Evidence (tag in each connection's doc): [B] for the turnaround activities the
        //   registered sources name (fuel, catering, cleaning/waste, boarding/deplaning:
        //   Schultz 2017; bags/cargo: Lu 2025; pushback, interphone: Seamster E-3); [B/C]
        //   navaids; rest [C] general knowledge (ground power, PCA, air start, water,
        //   de-icing, line maintenance, docking, refuel panel, gatelink, noise). Not driving any
        //   optimization lever, so not worth citing individually unless the report discusses them.
        //   Intentionally left out: lighting/markings (airport -> CREW, on airportToCrew), surface
        //   surveillance (ASDE-X/multilateration: ATC, on atcSurveillance), OOOI (aircraft -> AOC).

        #ContextVisible connection aircraftAirport connect aircraftSys.aircraft to airportOps.airport {
            doc /* [B] Summary link, rendered in place of the per-exchange set below. Mostly
             * material turnaround servicing (fuel, power, air, water, catering, bags, cargo,
             * passengers), gate docking and pushback, plus a few data exchanges (docking
             * guidance, refuel panel, gatelink). Does not affect optimality: every exchange
             * executes a decision made on another actor's link (owner, 2026-09-27). */
        }

        // Per-exchange set (not rendered; see the table above).
        connection apFuelUplift connect aircraftSys.aircraft.fuelSystem to airportOps.airport.fuelDistributionSystem {
            doc /* [B] Material, airport -> aircraft: fuel. Driven by the release fuel order and the crew's request. */
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
        connection apPotableWater connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [C] Material, airport -> aircraft: potable water service. */
        }
        connection apCatering connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [B] Material, airport -> aircraft: galley carts and supplies, sized by the AOC's passenger count. Caterer modeled under groundHandling. */
        }
        connection apDeicing connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [C] Material, airport -> aircraft: de-/anti-icing fluid. Driven by weather and the crew's request. */
        }
        connection apLineMaintenance connect aircraftSys.aircraft to airportOps.airport.maintenanceHangar {
            doc /* [C] Material, both directions: servicing fluids and gases, tires and parts in; removed parts out. Driven by aircraft status / MEL via maintenance control. Line maintenance happens at the gate; maintenanceHangar is the only maintenance part in the definitions. */
        }
        connection apPassengers connect aircraftSys.aircraft to airportOps.airport.passengerTerminal {
            doc /* [B] Material, both directions: boarding and deplaning via the gate / jetway. */
        }
        connection apBaggage connect aircraftSys.aircraft to airportOps.airport.baggageHandlingSystem {
            doc /* [B] Material, both directions: checked baggage loaded and unloaded. */
        }
        connection apCargoMail connect aircraftSys.aircraft to airportOps.airport.cargoTerminal {
            doc /* [B] Material, both directions: cargo and mail loaded and unloaded. */
        }
        connection apWasteService connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [B] Material, aircraft -> airport: lavatory waste and cabin trash; cabin cleaning. */
        }
        connection apGateDocking connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Physical: jetway or stairs attachment, chocks, parking position. */
        }
        connection apPushbackTow connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [B] Physical: tug pushback and towing. Driven by ATC / ramp clearance and the crew. */
        }
        connection apDockingGuidance connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Information: the visual docking guidance system senses the aircraft's position and shows stop guidance to the crew; can also detect in-block / off-block (A-CDM p.36). */
        }
        connection apRefuelPanel connect aircraftSys.aircraft.fuelSystem to airportOps.airport.fuelDistributionSystem {
            doc /* [C] Information, both directions: fueler presets quantity at the refuel panel; aircraft fuel quantity read back to the fueler. Source of the fuel slip. */
        }
        connection apGroundInterphone connect aircraftSys.aircraft to airportOps.airport.groundHandling {
            doc /* [B] Information: ground crew headset plugged into the aircraft interphone. The aircraft is the medium for crew <-> pushback crew (Seamster E-3#05-13). */
        }
        connection apGatelinkData connect aircraftSys.aircraft to airportOps.airport.gates {
            doc /* [C] Information, both directions: navigation database and software loads in; maintenance and flight data downloads out. */
        }
        connection apNoiseMonitoring connect aircraftSys.aircraft to airportOps.airport {
            doc /* [C] Information, aircraft -> airport: noise measured by airport monitors against Airport.noiseAbatementProcedures. Driven by Governance / community. */
        }
        connection apNavaidSignals connect aircraftSys.aircraft.navigationSystem to environment.infrastructure {
            doc /* [B/C] Information, infrastructure -> aircraft: ILS localizer/glideslope, DME, GBAS signals. Physically at the airport, but D-007 places navaids in Infrastructure, and most ILS are FAA assets (NAS roadmaps). */
        }

        // Aircraft Systems to Crew
        //   - Aircraft & Engine Status                                         -> [C] flight-deck displays/alerting
        //   - Fuel Status                                                      -> [C]
        //   - Navigation & Avionics Status                                     -> [C]
        //   - Equipment Malfunctions & Emergencies                             -> [C] crew alerting
        //   - Position & Trajectory Info (via FMS)                             -> [C] ND/PFD
        //   - Recommended Aircraft Control (via FMS: speed, altitude, heading, etc.)
        //       -> [C] flight director / autopilot guidance. This is the "FMS intent -> guidance
        //          commands" step of the intent chain, so it's central, not peripheral.
        //   -> TODO(missing) the crew -> aircraft direction, which is the actual execution
        //      step: control inputs, MCP/FCU selections, FMS entries (route, SID/STAR, weights,
        //      fuel, cost index: ConOps Phase 3), configuration (flaps, gear).
        //   -> TODO(review) evidence: all [C]. Needs an FCOM / FAA AC citation, or the avionics
        //      sources already registered (GreAT D5.1, Mhenni 2016) before the report cites it.
        //      Intuitively solid, so the connection stays.

        #ContextVisible connection crewAircraft connect flightCrew.flightDeckCrew to aircraftSys.aircraft {
            doc /* [C] Crew <-> aircraft execution.
             * Aircraft -> crew: status/alerting, fuel quantity (FQIS gauges), nav/avionics status,
             *   position and trajectory, FMS performance predictions (fuel at destination, ETAs,
             *   gross weight, optimum altitude) the crew checks against the release,
             *   FMS guidance (flight director / autopilot targets).
             * Crew -> aircraft: control inputs, MCP/FCU selections, FMS programming, configuration.
             * PF/PM duties swap between the two pilots, so the flight deck is one end.
             * Intent chain: FMS intent -> guidance commands -> aircraft motion. */
        }

        #ContextVisible connection atcSurveillance connect airspaceMgmt.atc to aircraftSys.aircraft {
            doc /* [C] Surveillance, not command. Aircraft -> ATC: transponder (Mode C/S) replies and
             * ADS-B broadcasts; radar returns feed tower/TRACON/ARTCC displays (data block,
             * handoff status). ATC -> aircraft: radar interrogation only. Instructions go through
             * the crew (atcToCrew). The gap between the aircraft's true state and ATC's tracked
             * picture is the cyber-physical gap (Mordecai 2018).
             * Intent chain: aircraft motion -> ATC (the feedback that closes the loop). */
        }
        // TODO(review) evidence: [C] only (your 09-20 lecture capture). BB's beacon code
        // and ADS-B paragraphs would make this [A]; not yet extracted.


        // Inter-ATC Connections
        //   - ATSCC to TMU:
        //      - Flow Evaluation Areas (FEAs) and Flow Constrained Areas (FCAs). This lets the TMU know exactly which flights in their sectors are impacted by macro-level constraints
        //          -> [A] 7210.3EE 18-8-4a3, 18-7-13. TODO(review) term: "ATSCC" -> "ATCSCC"
        //             (and the model part is atcscc).
        //      - Traffic Management Initatives (Ground Delay Programs (GDPs) and Ground Stops (GS): the TMU coordinates Expect Departure Clearance Times (EDCTs))
        //          -> [A] with a correction: the ATCSCC ISSUES EDCTs (18-10-6e). The ARTCC TMU
        //             relays them, assigns from the DAS table in some modes, and requests revised
        //             EDCTs from the ATCSCC (18-10-7). TODO(review): reword "coordinates".
        //      - Flight Schedule Monitor (FSM): Used to transmit slot assignments, capacity limits, and real-time modeling data to TMU terminals
        //          -> TODO(review): FSM is a TOOL (a medium), not an exchange. Operators use it too
        //             (18-10-3). The exchange items are the slot assignments / capacity (arrival
        //             rates). List those here and treat FSM as the channel.
        //   - TMU to ATSCC:
        //      - Disruption Events/Changes (localized convective weather, low visibility, or wind changes that call for pre-coordinated Severe Weather Avoidance Plans (SWAP),  runway closures, airport equipment failures, computer/software glitches, etc.)
        //          -> [A] 18-2-4a6, 18-5-4c. Nuance: SWAP is ATCSCC-led (18-16). The TMU reports
        //             the conditions; the SWAP decision is the ATCSCC's.
        //      - MITs, including submitting or updating Miles-in-Trail (MIT) or Minutes-in-Trail restrictions between adjacent ARTCC sectors
        //          -> [A] with nuance (18-7-12/13): up to 10 MIT is coordinated facility to facility;
        //             25+ MIT needs a shared FEA; 40+ MIT needs a conference. So the ATCSCC sees the
        //             large ones, not all of them.
        //      - TBFM
        //          -> TODO(review): TBFM is a tool, like FSM. What goes to the ATCSCC is time-based
        //             management STATUS (18-5-4c1, 18-6-9b, 18-6-11). TBFM metering is the TBO link
        //             (18-6-1) closest to trajectory intent, so it's worth stating precisely.
        //   -> TODO(missing): delay reports (15-min verbal, NTML updates; 18-5-12); reroute
        //      requests to the ATCSCC via NTML (18-5-11). Medium for almost all of this: NTML
        //      "in preference to other methods" (18-5-3) plus hotlines.
        //   -> TODO(missing): the TMU <-> tactical ATC link (tower/TRACON/ARTCC controllers). That
        //      is how a TMI becomes a clearance (BB 4-3-4: tower checks EDCTs with the TMU, and
        //      TMUs pass MIT/metering to sectors). Without it the diagram doesn't show how TFM
        //      constraints reach the crew. Draft below.
        //   -> TODO(review) scope: ATCSCC <-> TMU is internal to Airspace Management. On a strict
        //      context diagram, links internal to one domain are out of scope; they belong on the
        //      Airspace Management IBD (§10). I kept it visible because it's the enterprise ->
        //      tactical step of the intent chain. Decide whether the context view keeps it.

        #ContextVisible connection atcsccTmu connect airspaceMgmt.atcscc to airspaceMgmt.tmu {
            doc /* [A] National <-> local traffic flow management.
             * ATCSCC -> TMU: FEA/FCA, TMIs (GDP, GS, AFP, CTOP, reroutes), EDCTs, slot/rate data (via FSM).
             * TMU -> ATCSCC: component outages and disruptions, weather conditions, MIT >= 25
             *   (FEA) / >= 40 (conference), TBM status, delay reports, reroute requests.
             * Medium: NTML (preferred), TFMS, FSM, hotlines/telcons.
             * Authority: ATCSCC is the final approving authority for interfacility TMIs (18-2-3i);
             * TMUs keep local order (sector MIT, fix balancing; 18-2-3 NOTE).
             * Hierarchy the single tmu part stands for: tower -> TRACON TMU -> ARTCC TMU -> ATCSCC.
             * Intent chain: enterprise/NAS flow objectives -> ATC constraints.
             * Sources: JO 7210.3EE CHG 3 Ch. 18. */
        }


        // ==================================================================
        // MISSING: draft code for TODO(missing) items. Uncomment to include.
        // ==================================================================

        // --- TMU <-> tactical ATC. [A] BB 4-3-4 (tower <-> TMU on EDCT, ATCSCC via TMU);
        //     7210.3EE 18-2-4 (TMUs direct flows in conjunction with the ATCSCC). This is how a
        //     TMI turns into the clearance the crew receives.
        // #ContextVisible connection tmuAtc connect airspaceMgmt.tmu to airspaceMgmt.atc {
        //     doc /* TMU -> controllers: MIT/MINIT, metering times (TBFM), EDCT verification,
        //      * departure release. Controllers -> TMU: sector load, pilot-reported EDCT checks,
        //      * departure readiness outside the EDCT window. */
        // }

        // --- Cabin crew <-> PIC. [C] cabin secure / ready for departure; passenger medical or
        //     security events that trigger a diversion (Seamster T2.10 covers diversion on the
        //     crew <-> AOC side). Only needed if cabinCrew stays on the diagram.
        // #ContextVisible connection cabinToFlightDeck connect flightCrew.cabinCrew to flightCrew.flightDeckCrew {
        //     doc /* Cabin -> PIC: cabin secure, passenger/medical/security events.
        //      * PIC -> cabin: phase-of-flight and turbulence advisories. */
        // }

        // --- Environment / boundary actors. environment is declared but not visible or connected.
        //     The evidence note proposes three kinds of flow: rules (static), disturbances
        //     (dynamic scenario inputs), and feedback. Link an actor only where it changes a
        //     decision. To use: replace `part environment: EnvironmentDomain;` at the top with
        //     the block below, then uncomment the connections you want.
        #ContextVisible part environment: EnvironmentDomain {
            #ContextVisible part :>> governance;
            #ContextVisible part :>> military;
            #ContextVisible part :>> infrastructure {
                #ContextVisible part :>> weatherService;
            }
        }
        // Rules [A]: 14 CFR 91/121, JO 7110.65BB / 7210.3EE bind the operator and ATC.
        #ContextVisible connection rulesToAoc connect environment.governance to flightOps.airlineOperationsCenter;
        #ContextVisible connection rulesToAtc connect environment.governance to airspaceMgmt.atc;
        // Disturbance [A]: weather drives TMIs and SWAP (7210.3EE 18-15/16), ATIS (BB 2-9) and dispatch planning.
        #ContextVisible connection weatherToTfm connect environment.infrastructure.weatherService to airspaceMgmt.atcscc;
        #ContextVisible connection weatherToAoc connect environment.infrastructure.weatherService to flightOps.airlineOperationsCenter;
        // Disturbance [C]: special-use airspace status as a scenario condition (D-007).
        #ContextVisible connection suaToTfm connect environment.military to airspaceMgmt.atcscc;


        // --- Preflight plan-vs-FMS-vs-fuel cross-check (owner intent 2026-09-27; [B] for the
        //     release and fuel-on-board report, [C] for the cross-check itself). The dispatch
        //     release is the item that carries the plan; the crew compares it with what the FMS
        //     predicts and with the fuel actually loaded, and only the outcome goes back to the
        //     AOC. Written as items + an action def because the comparison happens inside the
        //     crew, not on a link. To use: move the item defs and action def into
        //     nas_sysml_package_definitions.sysml (methods §10.1: defs live there, this file
        //     holds usages and wiring only); then give the action to flightDeckCrew here
        //     (e.g. `perform action preflightCrossCheck: PreflightCrossCheck;`).
        // item def DispatchRelease {
        //     doc /* The dispatch paperwork: route, planned burn and times, alternates,
        //      * minimum/planned fuel, planned ZFW and takeoff weight, cost index, MEL items,
        //      * weather/NOTAMs. Signed by dispatcher and captain. Delivered on paper, EFB or ACARS. */
        //     attribute plannedFuel: Real;       // lb
        //     attribute plannedBurn: Real;       // lb
        //     attribute plannedZFW: Real;        // lb
        //     attribute plannedTakeoffWeight: Real; // lb
        //     attribute costIndex: Real;
        //     attribute v1: Real;                // kt; takeoff performance modeled as AOC-provided
        //     attribute vR: Real;                // kt   (abstraction; some types compute these in
        //     attribute v2: Real;                // kt    the FMS, e.g. 737)
        //     attribute takeoffThrustSetting: String; // e.g. derate / assumed temperature
        // }
        // item def FuelSlip {
        //     doc /* Airport fuel carrier's uplift record: gallons delivered and density, converted to pounds. */
        //     attribute gallonsUplifted: Real;
        //     attribute density: Real;           // lb/gal
        // }
        // item def FmsPerformancePrediction {
        //     doc /* FMS-computed values from the crew-entered ZFW, fuel, cost index, winds. */
        //     attribute predictedFuelAtDestination: Real; // lb
        //     attribute predictedGrossWeight: Real;       // lb
        //     attribute optimumAltitude: Real;            // ft
        // }
        // item def PreflightCrossCheckResult {
        //     doc /* What goes crew -> AOC: accepted, or a discrepancy needing an amended release. */
        //     attribute fuelOnBoard: Real;       // lb, from gauges, reconciled against the slip
        //     attribute accepted: Boolean;
        //     attribute discrepancy: String;     // e.g. "fuel", "weight", "performance limit"
        // }
        // action def PreflightCrossCheck {
        //     in release: DispatchRelease;          // via aocToCrew
        //     in fuelSlip: FuelSlip;                // from the airport fuel carrier, via airportToCrew
        //     in fmsPrediction: FmsPerformancePrediction; // via crewAircraft
        //     in gaugeFuel: Real;                   // FQIS, via crewAircraft
        //     out result: PreflightCrossCheckResult;   // to AOC via aocToCrew
        // }

        // --- Directed, typed exchanges (the next step past undirected `connection`s).
        //     Everything above is an undirected link with its content in a doc comment. For §10
        //     (item-flow model), the content becomes item defs moving through ports. Worked
        //     example on the A-graded AOC <-> ATCSCC link; the same pattern repeats per link.
        //     The evidence note suggests port types by MEDIUM (radio, ACARS, phone/telcon,
        //     NTML) rather than one per pair. The two ports below are conjugates (~) of one def.
        //     To use: move the item defs and port def into nas_sysml_package_definitions.sysml
        //     (methods §10.1), add the `port` lines inside the existing airlineOperationsCenter /
        //     atcscc redefinitions at the top, then uncomment the flows here.
        // item def EDCT {
        //     doc /* Expect Departure Clearance Time (JO 7210.3EE 18-10-6e). */
        //     attribute flightNumber: String;
        // }
        // item def TrajectoryOptionsSet {
        //     doc /* Operator-ranked route options for CTOP (7210.3EE 18-12-3b). */
        // }
        // item def TMIAdvisory {
        //     doc /* GDP / GS / AFP / CTOP / reroute advisory (18-10-6c). */
        // }
        // port def TFMCustomerPort {
        //     in item edct: EDCT;
        //     in item advisory: TMIAdvisory;
        //     out item tos: TrajectoryOptionsSet;
        // }
        //   inside flightOps { part :>> airlineOperationsCenter { port tfm: TFMCustomerPort; } }
        //   inside airspaceMgmt { part :>> atcscc { port customers: ~TFMCustomerPort; } }
        // #ContextVisible flow of EDCT from airspaceMgmt.atcscc.customers.edct to flightOps.airlineOperationsCenter.tfm.edct;
        // #ContextVisible flow of TMIAdvisory from airspaceMgmt.atcscc.customers.advisory to flightOps.airlineOperationsCenter.tfm.advisory;
        // #ContextVisible flow of TrajectoryOptionsSet from flightOps.airlineOperationsCenter.tfm.tos to airspaceMgmt.atcscc.customers.tos;

    }
}
