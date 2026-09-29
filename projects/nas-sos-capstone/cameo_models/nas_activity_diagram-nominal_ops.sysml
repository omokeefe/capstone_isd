package NominalOpsActivity {
    doc /* Activity model of nominal (no disruption) operations for one flight through
     * the NAS, gate to gate. SCAFFOLD: phase-level actions only; decompose each phase
     * in its action def below.
     *
     * Layout of this file:
     *   1. Phase action defs (the reusable behavior "types").
     *   2. NominalFlightOperations: the top-level activity (control flow + item flows).
     *   3. NominalOpsContext: swimlanes, i.e. which domain performs which action.
     */

    private import ScalarValues::*;
    private import NationalAirspaceSystem::AirportOperations::*;
    private import NationalAirspaceSystem::AirspaceManagement::*;
    private import NationalAirspaceSystem::AircraftSystems::*;
    private import NationalAirspaceSystem::FlightOperations::*;
    private import NationalAirspaceSystem::FlightCrew::*;

    // =========================================================================
    // 1. PHASE ACTION DEFS
    // Parameters (in/out) are the items that flow between phases. Add, rename,
    // or retype them as the exchanges firm up.
    // =========================================================================

    action def PlanFlight {
        doc /* AOC/dispatch builds the flight plan and issues the dispatch release. */
        out flightPlan : FlightPlan;
        out release : DispatchRelease;
    }

    action def PrepareForDeparture {
        doc /* Parallel ground preparation, ending when the aircraft is ready to push.
         * Example fork/join pattern; replace the sub-actions with real ones. */
        in release : DispatchRelease;

        first start;
        then fork prepFork;
            then prepareAircraft;
            then prepareCrew;
            then turnAroundGate;

        action prepareAircraft;   // fueling, loading, FMS initialization
        action prepareCrew;       // briefing, preflight checks
        action turnAroundGate;    // boarding, baggage, ground handling

        first prepareAircraft then prepJoin;
        first prepareCrew then prepJoin;
        first turnAroundGate then prepJoin;

        join prepJoin;
        then done;
    }

    action def Depart {
        doc /* Pushback, taxi-out, takeoff, and departure procedure (SID). */
        in flightPlan : FlightPlan;
        // TODO: in edct : ExpectDepartureClearanceTime; (from traffic flow management)
    }

    action def FlyEnroute {
        doc /* Cruise along the cleared trajectory under ARTCC control. */
    }

    action def Arrive {
        doc /* Descent, arrival procedure (STAR), approach, landing, and taxi-in. */
    }

    action def CloseOutFlight {
        doc /* Block-in, deplaning, and handoff to the next leg / turnaround. */
    }

    // =========================================================================
    // 2. TOP-LEVEL ACTIVITY
    // =========================================================================

    action def NominalFlightOperations {
        doc /* Gate-to-gate sequence for one flight under nominal conditions. */

        // --- Control flow (the ordering of phases) ---
        first start;
        then action planFlight : PlanFlight;
        then action prepareForDeparture : PrepareForDeparture;
        then action depart : Depart;
        then action flyEnroute : FlyEnroute;
        then action arrive : Arrive;
        then action closeOutFlight : CloseOutFlight;
        then done;

        // --- Item flows (what moves between phases) ---
        flow planFlight.release to prepareForDeparture.release;
        flow planFlight.flightPlan to depart.flightPlan;

        // --- Decision/merge template (uncomment and adapt when needed) ---
        // then decide holdingCheck;
        //     if holdingRequired then action hold;
        //     else continueArrival;
        // action hold;
        // first hold then arrivalMerge;
        // first continueArrival then arrivalMerge;
        // merge arrivalMerge;
    }

    // =========================================================================
    // 3. SWIMLANES (allocation of actions to performers)
    // SysML v2 has no partitions; a lane is a part that performs actions.
    // =========================================================================

    action nominalFlight : NominalFlightOperations;

    part def NominalOpsContext {
        part flightOps : FlightOperationsDomain {
            perform nominalFlight.planFlight;
        }
        part airportOps : AirportOperationsDomain {
            perform nominalFlight.prepareForDeparture;
        }
        part airspaceMgmt : AirspaceManagementDomain {
            // TODO: traffic flow management actions (EDCT, TMIs) run concurrently
            // with the flight; add them to NominalFlightOperations first.
        }
        part flightCrew : FlightCrewDomain {
            perform nominalFlight.depart;
            perform nominalFlight.flyEnroute;
            perform nominalFlight.arrive;
            perform nominalFlight.closeOutFlight;
        }
        part aircraft : AircraftSystemsDomain;
    }
}
