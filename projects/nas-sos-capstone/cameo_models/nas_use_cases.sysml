package NasUseCases {
    doc /* The NAS's use cases (D-035, 2026-10-28). The subject of each is the
     * NationalAirspaceSystem; actors are outside it (D-007). The airline, ATC, the flight
     * crew, the aircraft and airport operations are inside the NAS, so they are not actors;
     * they appear in the activities that carry the use cases out and in the "Case C
     * Conflict Resolve" sequence. The regulator constrains the NAS through requirements
     * (SN-GOV-01, background) and does not use it, so it is not an actor either.
     *
     * Picture: projects/nas-sos-capstone/report/figures/use-case-operate-scheduled-flight.drawio
     * (exported as use-case-operate-scheduled-flight.drawio.png). Syside has no use case
     * view and draws these only as compartment boxes (sysml-diagram-rendering.md section 9),
     * so the draw.io figure is the report's picture of this file. It is drawn by hand: keep
     * it in step with this file, which is the source (D-006).
     *
     * Each use case refines the stakeholder requirement it answers (#refinement below) and
     * names the activity that carries it out, so the use case links the stakeholder
     * requirements to the behavior. */

    private import ModelingMetadata::*;

    use case def ResolveEnRouteConflict {
        doc /* Restore separation between aircraft predicted to conflict en route, in cruise:
         * the decision the study is about (D-020). ATC decides (JO 7110.65BB 2-1-1); the
         * crew flies the clearance, refuses one it cannot fly or requests another. Carried
         * out by the ResolveConflict activity, which branches on what the controller knows
         * (cases A to D); the "Case C Conflict Resolve" sequence shows the exchanges for
         * case C. Has no actor of its own: it is included in OperateScheduledFlight. */
        subject nas : NationalAirspaceSystem::NationalAirspaceSystem;
        objective {
            doc /* Separation restored with a clearance each aircraft can fly, at the lowest
             * impact on the aircraft involved (SLR-CLR-13, a goal). */
        }
        action resolution : NominalOpsActivity::ResolveConflict;
    }

    use case def OperateScheduledFlight {
        doc /* Carry passengers between two airports on a scheduled Part 121 flight. The
         * passenger is the primary actor. Carried out by the NominalFlightOperations
         * activity (prework to close-out); en-route conflict resolution is included because
         * every flight in cruise may need it. */
        subject nas : NationalAirspaceSystem::NationalAirspaceSystem;
        actor passenger : NationalAirspaceSystem::Passengers::PassengersDomain;
        objective {
            doc /* Passengers arrive at their destination, including connections, at the
             * time they were sold (SN-PAX-02). */
        }
        include use case resolveConflict : ResolveEnRouteConflict;
        action operation : NominalOpsActivity::NominalFlightOperations;
    }

    use case def UseSpecialUseAirspace {
        doc /* Out of study (SN-MIL-01, D-031). The military uses the airspace for its own
         * goal, so it is an actor, but of this use case, not of OperateScheduledFlight.
         * Kept to show where the military sits; nothing carries it out in the model. */
        subject nas : NationalAirspaceSystem::NationalAirspaceSystem;
        actor military : NationalAirspaceSystem::Military::MilitaryDomain;
        objective {
            doc /* Military operations have sole use of special use airspace while it is
             * scheduled active (SN-MIL-01). */
        }
    }

    use case operateScheduledFlight : OperateScheduledFlight;
    use case useSpecialUseAirspace : UseSpecialUseAirspace;

    // Each use case refines the stakeholder requirement it answers.
    #refinement dependency operateRefinesPaxNeed
        from OperateScheduledFlight to StakeholderRequirements::Passengers::passengersArriveAsSold;
    #refinement dependency resolveRefinesAirlineNeed
        from ResolveEnRouteConflict to StakeholderRequirements::Operators::airlinePrioritiesInTrajectoryChanges;
    #refinement dependency suaRefinesMilitaryNeed
        from UseSpecialUseAirspace to StakeholderRequirements::MilitaryAirspaceUsers::specialUseAirspaceForMilitary;
}
