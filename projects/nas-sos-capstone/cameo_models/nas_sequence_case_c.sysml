package CaseCConflictResolve {
    doc /* DRAFT (Claude, 2026-10-28; updated 2026-11-05 to the fifth run, D-037; owner to
     * review). The "Case C Conflict Resolve" sequence (D-035): the exchanges that carry out
     * the included use case ResolveEnRouteConflict (nas_use_cases.sysml) in the experiment's
     * case C, where ATC decision support scores the options with the aircraft performance
     * the airline shares (D-019, D-038), and the steps of the ResolveConflict activity.
     *
     * Scenario: the fifth run on the confirmed numbers (D-037;
     * knowledge/models/experiment-options-and-scoring.md section 8). Case C (and D) chooses
     * O4: AC2, the light aircraft of the crossing pair, climbs 2,000 ft (FL380 to FL400) and
     * is cleared back to FL380 once separation is confirmed. No other aircraft is moved, so
     * the in-trail aircraft (AC3, AC4) have no lifeline. Numbers are not shown.
     *
     * Start and end in the aircraft's state machine (nas_state_aircraft.sysml): AC2 starts
     * onPlannedTrajectory. The FMS entry of the climb clearance moves it to
     * onAmendedClearance, the entry of the resume clearance to returningToPlannedTrajectory,
     * and the closing surveillance message ("plan rejoined") is the
     * PlannedTrajectoryRejoined event that returns it to onPlannedTrajectory.
     *
     * Other cases. A message whose name carries a case tag differs by case: the
     * performance share exists only in C and D (case B decides with one nominal performance
     * per type, case A with the rule); options are scored in B, C and D (case A applies the
     * rule). The aircraft moved also differs: case A descends AC2 4,000 ft (O10), case B
     * descends AC1 4,000 ft (O8). The shape of the exchange (clearance, read-back, entry,
     * notice, resume) is the same in every case; only the lifeline and the level change.
     *
     * Abstraction: the lifeline atc is the sector controller, or the controller team (JO
     * 7110.65BB 2-10 makes the team responsible); atc stays one box (D-038). Its decision
     * support has a lifeline of its own, so atc here is ATC without it.
     *
     * Rule (lessons-learned 2026-10-28): every lifeline is a part from the context diagram
     * or an IBD, and every message rides an existing connection or interface. Each message
     * names its connection in a comment; GAP marks one with none.
     *
     * GAPS this draft shows (for the model map and open-questions.md):
     *  G1  Closed 2026-11-05 (D-040): the alert and the scored options ride
     *      advisoriesToController (atc.decisionSupport.advisoriesOut to atc.controllerPosition,
     *      nas_ibd_airspace_management.sysml).
     *  G2  Closed 2026-11-05 (D-040): the share arrives at atc.performanceShareIn
     *      (nas_context_diagram.sysml, airlinePerformanceShare) and rides
     *      shareToDecisionSupport on to atc.decisionSupport, which uses it.
     *  G3  Withdrawn 2026-10-28 (owner): the controller is a stated abstraction, above.
     *  G4  Three item defs are new in this file (ClearanceReadback, FmsEntry,
     *      TrajectoryChangeNotice): the exchanges existed only as activity steps. The fourth,
     *      ConflictAlert, moved to the definitions with the advisory port (D-040).
     *  Not gaps: atcToCrew carries clearances and read-backs; aocToCrew the crew's notice to
     *  the dispatcher (HLR-CRW-04); crewFms (nas_ibd_aircraft.sysml) the FMS entry;
     *  atcSurveillance the aircraft's state (ADS-B, radar). */

    private import NationalAirspaceSystem::*;
    private import AircraftStates::AmendedClearance;
    private import AircraftStates::ResumeClearance;

    // ---- Exchanges that had no item def (G4). Draft.
    item def ClearanceReadback {
        doc /* The crew's read-back of a clearance, or "unable" (JO 7110.65BB 2-4-3; HLR-CRW-02). */
    }
    item def FmsEntry {
        doc /* The new level, speed or route set by the crew on the MCP or in the FMS. */
    }
    item def TrajectoryChangeNotice {
        doc /* The crew tells the dispatcher the trajectory has changed (HLR-CRW-04). */
    }

    occurrence def CaseCConflictResolveSequence {
        doc /* Who supplies the data (aoc), who decides (atc with its decision support), who
         * flies (AC2's crew and AC2). A name with a case tag differs by case. */

        part aoc : FlightOperations::AirlineOperationsCenter;
        part atcDecisionSupport : AirspaceManagement::AtcDecisionSupport;   // atc.decisionSupport on the airspace IBD
        part atc : AirspaceManagement::AirTrafficControlSystem;
        part ac2Crew : FlightCrew::FlightDeckCrew;
        part ac2 : AircraftSystems::Aircraft;

        // Monitoring: AC2 onPlannedTrajectory.
        message 'performance share (C, D)' of FlightOperations::AirlinePerformanceShare
            from aoc to atcDecisionSupport;                                                          // airlinePerformanceShare (IMPROVED, D-019), then shareToDecisionSupport
        message surveillance of AircraftSystems::AircraftState from ac2 to atc;                     // atcSurveillance

        // Detection and decision (ResolveConflict: assess, generate options, score).
        message 'conflict alert' of AirspaceManagement::ConflictAlert from atcDecisionSupport to atc; // advisoriesToController
        message 'scored options (B, C, D; A applies the rule)' of NasAnalysis::ResolutionOption
            from atcDecisionSupport to atc;                                                          // advisoriesToController

        // Resolution: AC2 climbs 2,000 ft (O4).
        message 'climb clearance (C, D: +2,000 ft)' of AmendedClearance from atc to ac2Crew;         // atcToCrew
        message 'climb read-back' of ClearanceReadback from ac2Crew to atc;                         // atcToCrew
        message 'climb entry' of FmsEntry from ac2Crew to ac2;                                      // crewFms -> onAmendedClearance
        message 'change notice' of TrajectoryChangeNotice from ac2Crew to aoc;                      // aocToCrew

        // Separation confirmed, then AC2 back to the plan.
        message 'separation confirmed' of AircraftSystems::AircraftState from ac2 to atc;           // atcSurveillance
        message 'resume clearance' of ResumeClearance from atc to ac2Crew;                           // atcToCrew
        message 'resume read-back' of ClearanceReadback from ac2Crew to atc;                        // atcToCrew
        message 'resume entry' of FmsEntry from ac2Crew to ac2;                                     // crewFms -> returningToPlannedTrajectory
        message 'plan rejoined' of AircraftSystems::AircraftState from ac2 to atc;                  // atcSurveillance; PlannedTrajectoryRejoined -> onPlannedTrajectory

        // Order. Without it Syside draws the messages (and so the lifelines) in its own order.
        first 'performance share (C, D)' then surveillance;
        first surveillance then 'conflict alert';
        first 'conflict alert' then 'scored options (B, C, D; A applies the rule)';
        first 'scored options (B, C, D; A applies the rule)' then 'climb clearance (C, D: +2,000 ft)';
        first 'climb clearance (C, D: +2,000 ft)' then 'climb read-back';
        first 'climb read-back' then 'climb entry';
        first 'climb entry' then 'change notice';
        first 'change notice' then 'separation confirmed';
        first 'separation confirmed' then 'resume clearance';
        first 'resume clearance' then 'resume read-back';
        first 'resume read-back' then 'resume entry';
        first 'resume entry' then 'plan rejoined';
    }
}
