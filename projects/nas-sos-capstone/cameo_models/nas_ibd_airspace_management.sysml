package AirspaceManagementIBD {
    doc /* Internal block diagram for the Airspace Management domain (to-do-list.md §10,
     * operational IBDs). Created 2026-09-27 (D-010) to hold the links internal to one
     * domain; given two levels of detail on 2026-11-24 (D-051), like the aircraft IBD.
     * Definitions stay in nas_sysml_package_definitions.sysml (methods §10.1); this file
     * holds usages, tags and wiring only.
     *
     * Levels of abstraction. Two tags decide what is drawn:
     *   #IBDVisible  drawn by MyViews::airspaceManagementIbd (the default picture) and by
     *                the detailed view: atc, its decision support (EDST) with the inputs it
     *                predicts conflicts from, its sector team (D-052), the path of the
     *                alerts and scored options to the team, and the domain's boundary ports.
     *   #IBDDetail   drawn only by MyViews::airspaceManagementIbdDetail, together with
     *                everything tagged #IBDVisible: traffic flow management (the ATCSCC, the
     *                TMU and the TFM tools) and its links. Not in the experiment: no traffic
     *                management initiative is active in the scenario (owner, 2026-11-24).
     *   untagged     in the definitions, drawn by neither view: tracon and artcc. A
     *                facility is where a sector sits, a fact about the scenario (the
     *                experiment's sector is in Fort Worth Center), not a separate party to
     *                the exchange; `atc` stands for the controllers of every facility
     *                (D-038, D-051).
     * Rule for the default level (D-040): a box is drawn, or shows its internals, only
     * where the studied decision's information or commands run through it.
     * A part is drawn only if its container is drawn, and a connection only if both ends
     * are.
     *
     * Not modeled: controller-to-controller links (handoff, point-out, departure
     * release). Each maneuver is assumed to stay inside one sector (owner, 2026-11-24;
     * report Section 3, working assumptions: sector boundaries are ignored).
     *
     * Labels. Each connection's description is a `comment about <name>`, kept outside the
     * drawn part so that it is not printed on the diagram (see nas_ibd_aircraft.sysml).
     */

    metadata def IBDVisible {
        doc /* Tag for elements both Airspace Management IBD views render. */
    }

    metadata def IBDDetail {
        doc /* Tag for elements only the detailed Airspace Management IBD view renders. */
    }

    part def AirspaceManagementInternals {
        private import NationalAirspaceSystem::AirspaceManagement::*;

        // `atc` is the umbrella for the controllers at towers, TRACONs and ARTCCs (D-038). It is
        // opened up only for its decision support (D-040, D-050) and its sector team (D-052).
        // `tracon` and `artcc` are inherited from AirspaceManagementDomain but not redefined
        // here, so neither view draws them (D-051).
        #IBDVisible part airspaceMgmt: AirspaceManagementDomain {
            #IBDVisible part :>> atc {
                // IMPROVED ARCHITECTURE (D-019). Drawn here so the report can point at the
                // port the aircraft performance data would arrive on (owner's 2026-10-19
                // print, Section 3.6: "be able to point to the port that would have the I/O").
                #IBDVisible port :>> performanceShareIn;
                // D-050: the inputs EDST predicts conflicts from (JO 7110.65BB 13-1-1).
                in #IBDVisible port :>> surveillanceIn;
                in #IBDVisible port :>> flightPlansIn;
                // D-040: the decision support inside atc, and the two links the "Case C
                // Conflict Resolve" sequence needs (its gaps G1 and G2). D-050: it is EDST,
                // ERAM's conflict probe at the en route centers, not an ATCSCC tool.
                #IBDVisible part :>> decisionSupport {
                    in #IBDVisible port :>> trackDataIn;
                    in #IBDVisible port :>> currentPlanIn;
                    #IBDVisible port :>> performanceShareIn;
                    #IBDVisible port :>> advisoriesOut;
                }
                // D-052: the controllers who decide, one box; their position is where the
                // decision support's output arrives.
                #IBDVisible part :>> sectorTeam {
                    #IBDVisible port :>> controllerPosition;
                }
                #IBDVisible connection trackDataToDecisionSupport connect surveillanceIn to decisionSupport.trackDataIn;
                #IBDVisible connection currentPlanToDecisionSupport connect flightPlansIn to decisionSupport.currentPlanIn;
                #IBDVisible connection shareToDecisionSupport connect performanceShareIn to decisionSupport.performanceShareIn;
                #IBDVisible connection advisoriesToController connect decisionSupport.advisoriesOut to sectorTeam.controllerPosition;
            }
            // Detail level only (D-051): traffic flow management.
            #IBDDetail part :>> atcscc;
            #IBDDetail part :>> tmu;
            #IBDDetail part :>> tfmAutomation;

            // Domain boundary (owner's 2026-10-19 print): inputs left, outputs right.
            in #IBDVisible port :>> surveillanceIn;
            in #IBDVisible port :>> flightPlansIn;
            in #IBDVisible port :>> requestsIn;
            out #IBDVisible port :>> clearancesOut;

            #IBDVisible connection surveillanceToAtc connect surveillanceIn to atc.surveillanceIn;
            #IBDVisible connection flightPlansToAtc connect flightPlansIn to atc.flightPlansIn;
            #IBDVisible connection requestsToAtc connect requestsIn to atc.sectorTeam;
            #IBDVisible connection clearancesFromAtc connect atc.sectorTeam to clearancesOut;
            #IBDDetail connection tfmTools connect atcscc to tfmAutomation;
        }

        // Inter-ATC connections (from the context diagram's notes, 2026-09-27)
        //   - ATCSCC to TMU:
        //      - Flow Evaluation Areas (FEAs) and Flow Constrained Areas (FCAs): which flights in
        //        the TMU's sectors are hit by a national constraint.   -> [A] 7210.3EE 18-8-4a3, 18-7-13
        //      - TMIs: GDPs and GSs. The ATCSCC issues the EDCTs (18-10-6e); the ARTCC TMU
        //        coordinates them: relays them, assigns from the DAS table in some modes, and
        //        requests revised EDCTs from the ATCSCC (18-10-7).   -> [A]
        //      - Slot assignments, capacity limits (arrival rates), modeling data. FSM is the
        //        TOOL they travel on, not the exchange (18-10-3).     -> [A]
        //   - TMU to ATCSCC:
        //      - Disruption events: convective weather, low visibility, wind shifts, runway
        //        closures, airport equipment failures, computer/software outages.
        //                                                    -> [A] 18-2-4a6, 18-5-4c. SWAP is
        //                                                       ATCSCC-led (18-16): the TMU reports
        //                                                       conditions, the ATCSCC decides.
        //      - Miles/minutes-in-trail: up to 10 MIT facility to facility; 25+ MIT needs a
        //        shared FEA; 40+ MIT needs a conference.     -> [A] 18-7-12, 18-7-13
        //      - Time-based management STATUS. TBFM is the TOOL. -> [A] 18-5-4c1, 18-6-9b, 18-6-11
        //      - Delay reports (15-min verbal, NTML updates, 45-min TMO, 90-min verbal)
        //                                                    -> [A] 18-5-12
        //      - Reroute requests via the NTML                -> [A] 18-5-11, 18-8-4a3
        //      - Runway configuration with AAR/ADR; MAP value changes (not MAP alerts)
        //                                                    -> [A] 18-5-4e1, 18-9-2b
        //   Medium for almost all of it: NTML, "in preference to other methods" (18-5-3), plus
        //   hotlines. NTML is FAA-internal, which is why it appears here and not on the
        //   context diagram's operator-facing links.

        // Boundary links (2026-10-19, owner's print). Each port stands for a context-diagram
        // link that crosses the domain boundary; the comment names it.
        comment about airspaceMgmt::surveillanceToAtc /* [A] ADS-B Out and secondary radar replies reach the controllers (atcSurveillance; JO 7110.65BB 5-1-2, 5-2-1). The broadcast is aircraftBroadcastState on the activity model. */
        comment about airspaceMgmt::flightPlansToAtc /* [A] Filed flight plans and amendments to the ARTCC host (aocFlightPlanFiling; JO 7210.3EE 6-5). */
        comment about airspaceMgmt::requestsToAtc /* [A] Crew requests, read-backs and reports by voice or datalink, to the sector team (atcToCrew, atcAircraftDatalink; D-052). */
        comment about airspaceMgmt::clearancesFromAtc /* [A] Clearances and instructions from the sector team, including the conflict-resolution instruction (item AirspaceManagement::Clearance; atcToCrew; D-052). */
        comment about airspaceMgmt::tfmTools /* [A] The ATCSCC works through the TFM tools (TFMS, FSM, NTML, TBFM, DRT): media, not a party (D-007 absorbed; JO 7210.3EE 18-5-3, 18-10-3). The TMUs use the same tools; that link is not drawn. Owner's "?" on the 2026-10-19 print. */

        comment about airspaceMgmt::atc::trackDataToDecisionSupport /* [A] Track data (ADS-B Out and radar, from atcSurveillance) into EDST, one of the four inputs it predicts trajectories and conflicts from (JO 7110.65BB 13-1-1; D-050). */
        comment about airspaceMgmt::atc::currentPlanToDecisionSupport /* [A] The current plan: "what the en route automation predicts the aircraft will fly, possibly including clearances not yet issued" (13-1-1). ERAM builds it from the filed plan and the amendments controllers enter; ERAM is not a separate part, since EDST is "an integrated function of ERAM" (D-050). */
        comment about airspaceMgmt::atc::shareToDecisionSupport /* [B] IMPROVED (D-019, D-040). The airline's performance share, passed from atc's boundary port to the decision support that uses it (HLR-ATC-08). */
        comment about airspaceMgmt::atc::advisoriesToController /* [A] Conflict alerts and scored resolution options from the decision support to the controller (EDST, JO 7110.65BB 13-1-1; HLR-ATC-02, HLR-ATC-10, HLR-ATC-11). Also EDST's aircraft list (ACL), "the sector team's primary source of flight data" (13-1-5): each flight's current plan, which is how the controller learns its filed route and requested altitude and speed (HLR-ATC-03, allocated here since D-051). */

        #IBDDetail connection trafficManagementInitiatives connect airspaceMgmt.atcscc to airspaceMgmt.tmu;
        comment about trafficManagementInitiatives /* [A] National <-> local traffic flow management.
             * ATCSCC -> TMU: FEA/FCA, TMIs (GDP, GS, AFP, CTOP, reroutes), EDCTs, slot/rate data.
             * TMU -> ATCSCC: component outages and disruptions, weather conditions, MIT >= 25
             *   (FEA) / >= 40 (conference), TBM status, delay reports, reroute requests, runway
             *   configuration and AAR/ADR, MAP value changes.
             * Medium: NTML (preferred), TFMS, FSM, hotlines/telcons (tools in tfmAutomation).
             * Authority: ATCSCC is the final approving authority for interfacility TMIs (18-2-3i);
             * TMUs keep local order (sector MIT, fix balancing; 18-2-3 NOTE).
             * The single tmu part stands for the TMUs at ARTCCs, TRACONs and some towers; the
             * ATCSCC is its own part.
             * Intent chain: enterprise/NAS flow objectives -> ATC constraints.
             * Sources: JO 7210.3EE CHG 3 Ch. 18. */

        #IBDDetail connection sectorFlowRestrictions connect airspaceMgmt.tmu to airspaceMgmt.atc;
        comment about sectorFlowRestrictions /* [A] TMU <-> tactical controllers: how a TMI becomes the clearance the crew
             * receives.
             * TMU -> controllers: MIT/MINIT, metering times (TBFM), EDCT verification, departure
             *   release times, airborne reroutes (Route Amendment Dialog -> ERAM for the sector
             *   to issue; 18-7-4h5).
             * Controllers -> TMU: sector load, EDCT checks for departures, departure readiness
             *   outside the EDCT window.
             * Sources: JO 7110.65BB 4-3-4 (tower <-> TMU on EDCT and release times, ATCSCC via
             * the TMU); JO 7210.3EE 18-2-4 (TMUs direct flows in conjunction with the ATCSCC),
             * 18-7-4h5. */
    }
}
