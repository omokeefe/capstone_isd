package AirspaceManagementIBD {
    doc /* PLACEHOLDER internal block diagram for the Airspace Management domain
     * (to-do-list.md §10, operational IBDs). Created 2026-09-27 (D-010) to hold what
     * was moved off the context diagram: links internal to one domain, and the
     * question of how `atc` relates to tower / TRACON / ARTCC.
     * Rendered by MyViews::airspaceManagementIbd. Definitions stay in
     * nas_sysml_package_definitions.sysml (methods §10.1); this file holds usages and
     * wiring only.
     */

    metadata def IBDVisible {
        doc /* Tag for elements the Airspace Management IBD view should render. */
    }

    part def AirspaceManagementInternals {
        private import NationalAirspaceSystem::AirspaceManagement::*;

        // TODO(review), carried over from the context diagram: `atc` sits beside `tracon`,
        // `artcc`, `atcscc`, `tmu` in AirspaceManagementDomain as if it were one more peer,
        // but it is really the umbrella for tower + TRACON + ARTCC controllers. Options:
        //   (a) replace `atc` with `tower`, `tracon`, `artcc` (the tower is ATC by function,
        //       although the model's ControlTower facility is a part of Airport);
        //   (b) keep `atc` and give AirTrafficControlSystem the three as sub-parts;
        //   (c) keep all flat and accept the overlap at context level only.
        // (b) keeps the context diagram's rendered `atc` endpoint unchanged while the IBD
        // opens it up; it needs `tracon` / `artcc` to move under AirTrafficControlSystem in the
        // definitions. Not decided.
        #IBDVisible part airspaceMgmt: AirspaceManagementDomain {
            #IBDVisible part :>> atc;
            #IBDVisible part :>> tracon;
            #IBDVisible part :>> artcc;
            #IBDVisible part :>> atcscc;
            #IBDVisible part :>> tmu;
            #IBDVisible part :>> tfmAutomation;
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

        #IBDVisible connection atcsccTmu connect airspaceMgmt.atcscc to airspaceMgmt.tmu;
        comment about atcsccTmu /* [A] National <-> local traffic flow management.
             * ATCSCC -> TMU: FEA/FCA, TMIs (GDP, GS, AFP, CTOP, reroutes), EDCTs, slot/rate data.
             * TMU -> ATCSCC: component outages and disruptions, weather conditions, MIT >= 25
             *   (FEA) / >= 40 (conference), TBM status, delay reports, reroute requests, runway
             *   configuration and AAR/ADR, MAP value changes.
             * Medium: NTML (preferred), TFMS, FSM, hotlines/telcons (tools in tfmAutomation).
             * Authority: ATCSCC is the final approving authority for interfacility TMIs (18-2-3i);
             * TMUs keep local order (sector MIT, fix balancing; 18-2-3 NOTE).
             * Hierarchy the single tmu part stands for: tower -> TRACON TMU -> ARTCC TMU -> ATCSCC.
             * Intent chain: enterprise/NAS flow objectives -> ATC constraints.
             * Sources: JO 7210.3EE CHG 3 Ch. 18. */

        #IBDVisible connection tmuAtc connect airspaceMgmt.tmu to airspaceMgmt.atc;
        comment about tmuAtc /* [A] TMU <-> tactical controllers: how a TMI becomes the clearance the crew
             * receives.
             * TMU -> controllers: MIT/MINIT, metering times (TBFM), EDCT verification, departure
             *   release times, airborne reroutes (Route Amendment Dialog -> ERAM for the sector
             *   to issue; 18-7-4h5).
             * Controllers -> TMU: sector load, EDCT checks for departures, departure readiness
             *   outside the EDCT window.
             * Sources: JO 7110.65BB 4-3-4 (tower <-> TMU on EDCT and release times, ATCSCC via
             * the TMU); JO 7210.3EE 18-2-4 (TMUs direct flows in conjunction with the ATCSCC),
             * 18-7-4h5. */

        // TODO(missing), IBD level: controller <-> controller links (handoff, point-out, tower <-> TRACON
        // departure release; BB 5-4-x, catalog transitions 5, 7, 9, 10) once the atc umbrella
        // question above is decided.
    }
}
