package AircraftStates {
    doc /* The aircraft's state machine (D-035, 2026-10-28). Its states are defined by the
     * clearance the aircraft is flying, because that is what an aircraft can observe: it
     * does not know it is in conflict; ATC's conflict probe does (JO 7110.65BB 13-1-1).
     * "In conflict" is ATC's view of an encounter between two aircraft and lives in the
     * ResolveConflict activity and the "Case C Conflict Resolve" sequence, not here.
     *
     * Owner of the states: the aircraft (AircraftSystems::Aircraft exhibits this machine),
     * the controlled object whose cleared path the FMS and autoflight hold (HLR-ACF-02).
     * Agent of the transitions: the flight deck crew, who reads back, accepts, enters and
     * flies each clearance, says "unable" (HLR-CRW-02) or requests another (HLR-CRW-03).
     * Separation is ATC's responsibility under IFR (JO 7110.65BB 2-1-1). Each machine runs
     * per aircraft; two aircraft in one encounter each run their own, and an aircraft
     * slowed in trail passes through onAmendedClearance without being in conflict.
     *
     * Where the experiment's cost accrues: in onAmendedClearance and
     * returningToPlannedTrajectory. NasAnalysis::ConflictResolutionScoring scores fuel and
     * time over those two states against staying onPlannedTrajectory.
     *
     * Start and end on the ground (owner, 2026-10-28), tied to the Depart and Arrive
     * activities in nas_activity_diagram-nominal_ops.sysml. Fleet states such as "out of
     * service" belong to an aircraft-lifecycle machine, not this one. */

    private import NationalAirspaceSystem::AirspaceManagement::Clearance;

    // ---- Events. Clearances come from ATC by voice or datalink (atcToCrew); the others
    // are the aircraft's own milestones.
    item def AmendedClearance :> Clearance {
        doc /* A clearance that takes the aircraft off its planned trajectory: a level
         * change, vector or speed change, including a conflict-resolution instruction. */
    }
    item def ResumeClearance :> Clearance {
        doc /* A clearance to return to the planned trajectory: "resume own navigation",
         * "climb back to FL380", "resume normal speed". */
    }
    attribute def Airborne { doc /* Wheels off at departure. */ }
    attribute def PlannedTrajectoryRejoined { doc /* Back on the filed route, level and speed. */ }
    attribute def OnBlocks { doc /* Arrived at the gate (block-in). */ }

    state def AircraftClearanceStates {
        entry; then onGroundBeforeDeparture;

        state onGroundBeforeDeparture {
            doc /* From prework to takeoff: the Prework, PrepareForDeparture and Depart
             * activities. */
        }
        state onPlannedTrajectory {
            doc /* Flying the filed route, level and speed (as cleared at departure). The
             * crew monitors traffic and aircraft state (the FlyEnroute activity). */
        }
        state onAmendedClearance {
            doc /* Flying a clearance that departs from the plan. Cost accrues here. */
        }
        state returningToPlannedTrajectory {
            doc /* Cleared back toward the plan, not yet on it (climbing back, rejoining the
             * route, accelerating). Cost still accrues. */
        }
        state onGroundAfterArrival {
            doc /* From landing to block-in: the end of the Arrive activity. */
        }

        transition departs
            first onGroundBeforeDeparture
            accept Airborne
            then onPlannedTrajectory;
        transition amended
            first onPlannedTrajectory
            accept AmendedClearance
            then onAmendedClearance;
        transition resumes
            first onAmendedClearance
            accept ResumeClearance
            then returningToPlannedTrajectory;
        transition rejoins
            first returningToPlannedTrajectory
            accept PlannedTrajectoryRejoined
            then onPlannedTrajectory;
        transition amendedAgain
            first returningToPlannedTrajectory
            accept AmendedClearance
            then onAmendedClearance;
        transition arrivesOnPlan
            first onPlannedTrajectory
            accept OnBlocks
            then onGroundAfterArrival;
        // Arrival vectors are common, so an aircraft can land while still on an amended
        // clearance.
        transition arrivesOnAmended
            first onAmendedClearance
            accept OnBlocks
            then onGroundAfterArrival;
    }
}
