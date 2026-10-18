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
    private import NationalAirspaceSystem::Common::*;
    private import NationalAirspaceSystem::Infrastructure::*;

    // =========================================================================
    // 1. PHASE ACTION DEFS
    // Parameters (in/out) are the items that flow between phases. 
    // =========================================================================

    action def Prework {
        doc /* All of the airline work that occur before the flight planning can 
        occur, including Market segmentation, service model, network design, 
        published schedule, fleet assignment strategy, and crew assignment.
         */
         // Connec this either as the start node, or as an input to the 
         // start node.
    }


    action def PlanFlight {
        doc /* AOC/dispatch builds the flight plan and issues the dispatch release. */
        out flightPlan : FlightPlan;
        out release : DispatchRelease;
    }

    action def SupplyFuel {
        doc /* Fuel supplier delivers fuel to the airport for the flight. */
        in release : DispatchRelease;
        out  fuelLoad : Real; // lb, same unit as DispatchRelease.plannedFuel
        out fuelSlip : FuelSlip;
    }

    action def PrepareForDeparture {
        doc /* Parallel ground preparation, ending when the aircraft is ready to push.
        */
        in release : DispatchRelease;
        in aircraft : Aircraft;
        in crew : Operator[*];
        in passengers : Passenger[*];
        in cargo : Cargo[*];
        in fuelLoad : Real; // lb, same unit as DispatchRelease.plannedFuel
        in weather : WeatherConditions; // actual weather, exogenous (not the release's weather package)

        out flight : Flight;
        out aircraftState : AircraftState;

        first start;
        then fork prepFork;
            then prepareAircraft;
            then turnAroundGate;

        action prepareAircraft;   // fueling, loading, FMS initialization
        action turnAroundGate;    // boarding, baggage, ground handling

        first prepareAircraft then prepJoin;
        first turnAroundGate then prepJoin;

        // prepareAircraft has airport fuel delivery, 
        // crew to aircraft FMS entries
        // crew to aircraft configuration, etc.

        join prepJoin;
        then done;
    }

    action def Depart {
        doc /* Pushback, taxi-out, takeoff, and departure procedure (SID). */
        in flightPlan : FlightPlan;
        // TODO: in edct : ExpectDepartureClearanceTime; (from traffic flow management)
        out Flight
        
        // Taxi
        // Crew request departure clearance
        // Tower publish clearance
        // Crew & AOC confirm clearance
        // Crew checks trajectory & status and coordinate updates & changes with tower and AOC
        // Apron (Tower?) control issues gate pushback clearance
        // Crew confirms and coordinates w/ground control for push back. 
        // Crew requests taxi-out clearance
        // Tower issues and monitors aircraft along the taxi instructions
        // If the tower identifies a conflict of the flight with another aircraft, it will resolve it via issuing instructions to the crew.
        // The aircraft will be broadcasting its state.
        // At the end, the aircraft has reached the runway entrance safely

        // Departure
        // Crew requets clearance to enter runway
        // Tower confirsm and gives takeoff clearance
        // Crew controls aircraft onto runway and performs takeoff, progressing through V1, VR, and V2 for initial climb out
        // Tower transfers crew to communicate with Departure/Approach controller
        // Crew confirms and continues to fly, joining the departur flow being controlled by the departure/approach controller.
        // Crew flies in climb, maintaining min ROC and coordinating as needed for weather, sector crossing, conflict detections, etc.
        // Aircraft will be broadcasting its state throughout.
        // At the end, the aircraft has reached the cruise altitude

    }

    action def FlyEnroute {
        doc /* Cruise along the cleared trajectory under ARTCC control. */
        in Flight

        // Aircraft flys level, transmitting data
        // In a loop:
        // Crew surveil for traffic and weather, and reacts to each as needed
        // Crew monitor aircraft weight and compare vs. dispatch paperwork and FMS data
        // When the next-step weight is nearly reached, the crew requests clearance from the controller for clearance to the newly optimum altitude
        // The controller checks traffic and that the new control will produce a trajectory clear of conficts
        // Then the crew confirms clear of traffic and proceeds to the newly optimum altitude via MCP altitude dial, FLCHG, and possibly FMS entries.
        // As the crew flies the aircraft and sequences waypoints, they are performing airline standard operating procedures like recording fuel/state data, working through safety considerations like programming alternative airports into the FMS, looking for equal-time points, etc., as well as always maintaining visual separtion from other aircraft
        // As an aircraft nears a airspace sector boundary, the controller issues the handoff and the crew confirms/coordinates the contact with the next controller.

        // ATC is continually monitoring the flight and all traffic in their sector.
        // If a conflict is identified, they seek to resolve it, which is the subject of my project. 
        
        // AOC is only involved in the case where weather causes re-route or external conditions warrant a change to the flight (other flight behind schedule, so slow or something like that.)
    }

    action def Arrive {
        doc /* Descent, arrival procedure (STAR), approach, landing, and taxi-in. */

        // Prior to T/D, the aircraft must coordinate with the necessary systems to attain descent clearances, including Standard Terminal Arrival procedure (STAR), approach (APP) & runway, off ramp, gate, and taxi instructions.

        // The approach control uses their systems (e.g. AMAN) to plan arrival traffic necessary to achieve airport capacities. The airports populate information needed for AMAN. Collectively, the approach, tower, and ATFM airspace management systems determine the planned time of arrival for the flight, which is typically associated with the planned landing time slot. The airport is made aware of this and determines the appropriate gate for the flight. Based on the landing time, the tower determines the taxi info. All of this information is then sent back to the aircraft & crew for them to plan their descent and arrival.

        // Crews plug all this info into the FMS to look at the Top-Of-Descent location and anticipate issues achieving constraints. The crew continues to fly until near T/D at which point they request clearance to begin their descent/arrival.

        // Enroute ATC likely issues the initial descent clearance and hands off the flight to the approach controllers at the appropriate 4D location.

        // The aircraft descends, decelerates, and configures for landing, monitoring weather and coordinating with controllers. 

        // Upon final approach, the aircraft is prepared for landing, fully configured, and is coordinating with the tower control.

        // The aircraft lands on the runway, exits the runway, taxis to the assigned gate, and coordiantes with ground control to park.
    }

    action def CloseOutFlight {
        doc /* Block-in, deplaning, and handoff to the next leg / turnaround. */
        // Once parked, the flight is blocked as a brake safety measure. The passengers deplane, the crew records final info and reveiws the next leg as needed. The crew and plane "turnaround" as scheduled.
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

        // Swimlanes (tested 2026-10-10, syside viz 0.10.3): a general or interconnection
        // render of this part def draws each domain as a box that lists its performed
        // actions, which is the allocation picture. No view draws the flows between the
        // performed actions across those boxes (restating the flows here did not help), so
        // the ordering stays on the nominalOpsActivity action-flow view. See
        // knowledge/models/sysml-diagram-rendering.md section 9.
    }
}
