package CaseCConflictResolve {
    doc /* DRAFT (Claude, 2026-10-28; owner to review). The "Case C Conflict Resolve" sequence
     * (D-035): the exchanges that carry out the included use case ResolveEnRouteConflict
     * (nas_use_cases.sysml) in the experiment's case C, where ATC decision support scores
     * the options with the airline's shared weight and cost index (D-019), and the steps of
     * the ResolveConflict activity.
     *
     * Start and end in the aircraft's state machine (nas_state_aircraft.sysml): both
     * aircraft start onPlannedTrajectory. The FMS entries of the amended clearances move
     * them to onAmendedClearance, the entries of the resume clearances to
     * returningToPlannedTrajectory, and the closing surveillance message ("plan
     * rejoined") is the PlannedTrajectoryRejoined event that returns the heavy aircraft
     * to onPlannedTrajectory.
     *
     * Scenario: the base scenario's result (knowledge/models/experiment-options-and-scoring.md
     * section 8): the heavy aircraft of the crossing pair descends 2,000 ft and the in-trail
     * aircraft is slowed. Numbers are not shown; they are Decide items.
     *
     * Other cases. A message whose name carries a case tag differs by case: the
     * performance share exists only in C and D (case B decides with one nominal weight per
     * type, case A with the rule); options are scored in B, C and D (case A applies the
     * rule); case A moves only the heavy aircraft, 4,000 ft, so the in-trail messages are
     * B, C and D only. Untagged messages occur in every case. The tags rest on the base
     * scenario's first run and are to be checked when the scenario is confirmed and re-run.
     *
     * Abstraction: the lifeline atc is the sector controller, or the controller team (JO
     * 7110.65BB 2-10 makes the team responsible). Its decision support has a lifeline of
     * its own, so atc here is ATC without it. No separate controller part is needed.
     *
     * Rule (lessons-learned 2026-10-28): every lifeline is a part from the context diagram
     * or an IBD, and every message rides an existing connection or interface. Each message
     * names its connection in a comment; GAP marks one with none.
     *
     * GAPS this draft shows (for the model map and open-questions.md):
     *  G1  No connection between ATC and its decision support (atc.decisionSupport): the
     *      alert and the scored options have nothing to ride. nas_ibd_airspace_management.sysml
     *      draws atc as one box.
     *  G2  The performance share's interface ends at atc.performanceShareIn
     *      (nas_context_diagram.sysml, airlinePerformanceShare); nothing carries it on to
     *      atc.decisionSupport, which is what uses it.
     *  G3  Withdrawn 2026-10-28 (owner): the controller is a stated abstraction, above.
     *  G4  Four item defs are new in this file (ConflictAlert, ClearanceReadback, FmsEntry,
     *      TrajectoryChangeNotice): the exchanges existed only as activity steps.
     *  Not gaps: atcToCrew carries clearances and read-backs; aocToCrew the crew's notice to
     *  the dispatcher (HLR-CRW-04); crewFms (nas_ibd_aircraft.sysml) the FMS entry;
     *  atcSurveillance the aircraft's state (ADS-B, radar). */

    private import NationalAirspaceSystem::*;
    private import AircraftStates::AmendedClearance;
    private import AircraftStates::ResumeClearance;

    // ---- Exchanges that had no item def (G4). Draft.
    item def ConflictAlert {
        doc /* A predicted loss of separation between two aircraft, from the conflict probe
         * (EDST, JO 7110.65BB 13-1-1). Goes to the controller; the crews never see it. */
    }
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
         * flies (the two crews and their aircraft). A name with a case tag differs by case. */

        part aoc : FlightOperations::AirlineOperationsCenter;
        part atcDecisionSupport : DecisionSupport::DecisionSupportSystem;
        part atc : AirspaceManagement::AirTrafficControlSystem;
        part heavyCrew : FlightCrew::FlightDeckCrew;
        part heavyAircraft : AircraftSystems::Aircraft;
        part inTrailCrew : FlightCrew::FlightDeckCrew;
        part inTrailAircraft : AircraftSystems::Aircraft;

        // Monitoring: both aircraft onPlannedTrajectory.
        message 'performance share (C, D)' of FlightOperations::AirlinePerformanceShare
            from aoc to atcDecisionSupport;                                                          // airlinePerformanceShare (IMPROVED, D-019); G2
        message surveillance of AircraftSystems::AircraftState from heavyAircraft to atc;           // atcSurveillance

        // Detection and decision (ResolveConflict: assess, generate options, score).
        message 'conflict alert' of ConflictAlert from atcDecisionSupport to atc;                    // GAP G1
        message 'scored options (B, C, D; A applies the rule)' of NasAnalysis::ResolutionOption
            from atcDecisionSupport to atc;                                                          // GAP G1

        // Resolution: the heavy aircraft descends; the in-trail aircraft is slowed.
        message 'descend clearance (A: 4,000 ft; B to D: 2,000 ft)' of AmendedClearance
            from atc to heavyCrew;                                                                   // atcToCrew
        message 'descend read-back' of ClearanceReadback from heavyCrew to atc;                     // atcToCrew
        message 'descend entry' of FmsEntry from heavyCrew to heavyAircraft;                        // crewFms -> onAmendedClearance
        message 'slow clearance (B, C, D)' of AmendedClearance from atc to inTrailCrew;             // atcToCrew
        message 'slow read-back (B, C, D)' of ClearanceReadback from inTrailCrew to atc;            // atcToCrew
        message 'slow entry (B, C, D)' of FmsEntry from inTrailCrew to inTrailAircraft;             // crewFms -> onAmendedClearance
        message 'change notice' of TrajectoryChangeNotice from heavyCrew to aoc;                    // aocToCrew

        // Separation confirmed, then both aircraft back to the plan.
        message 'separation confirmed' of AircraftSystems::AircraftState from heavyAircraft to atc; // atcSurveillance
        message 'resume clearance' of ResumeClearance from atc to heavyCrew;                         // atcToCrew
        message 'resume read-back' of ClearanceReadback from heavyCrew to atc;                      // atcToCrew
        message 'resume entry' of FmsEntry from heavyCrew to heavyAircraft;                         // crewFms -> returningToPlannedTrajectory
        message 'resume speed clearance (B, C, D)' of ResumeClearance from atc to inTrailCrew;      // atcToCrew
        message 'resume speed read-back (B, C, D)' of ClearanceReadback from inTrailCrew to atc;   // atcToCrew
        message 'resume speed entry (B, C, D)' of FmsEntry from inTrailCrew to inTrailAircraft;    // crewFms -> returningToPlannedTrajectory
        message 'plan rejoined' of AircraftSystems::AircraftState from heavyAircraft to atc;        // atcSurveillance; PlannedTrajectoryRejoined -> onPlannedTrajectory

        // Order. Without it Syside draws the messages (and so the lifelines) in its own order.
        first 'performance share (C, D)' then surveillance;
        first surveillance then 'conflict alert';
        first 'conflict alert' then 'scored options (B, C, D; A applies the rule)';
        first 'scored options (B, C, D; A applies the rule)' then 'descend clearance (A: 4,000 ft; B to D: 2,000 ft)';
        first 'descend clearance (A: 4,000 ft; B to D: 2,000 ft)' then 'descend read-back';
        first 'descend read-back' then 'descend entry';
        first 'descend entry' then 'slow clearance (B, C, D)';
        first 'slow clearance (B, C, D)' then 'slow read-back (B, C, D)';
        first 'slow read-back (B, C, D)' then 'slow entry (B, C, D)';
        first 'slow entry (B, C, D)' then 'change notice';
        first 'change notice' then 'separation confirmed';
        first 'separation confirmed' then 'resume clearance';
        first 'resume clearance' then 'resume read-back';
        first 'resume read-back' then 'resume entry';
        first 'resume entry' then 'resume speed clearance (B, C, D)';
        first 'resume speed clearance (B, C, D)' then 'resume speed read-back (B, C, D)';
        first 'resume speed read-back (B, C, D)' then 'resume speed entry (B, C, D)';
        first 'resume speed entry (B, C, D)' then 'plan rejoined';
    }
}
