package NominalOpsActivity {
    doc /* Activity model of nominal (no disruption) operations for one flight through
     * the NAS, gate to gate. Each phase action def below is decomposed into the
     * sub-actions the owner described (2026-10-18, [SME]); sub-action names start with
     * the performer (crew, tower, atc, aoc, airport, aircraft) because SysML v2 has no
     * partitions and the NominalOpsContext swimlanes only allocate whole phases.
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
    // Decision branches are named successions (name = condition), not guarded
    // "if ... then" successions: syside viz 0.10.x does not draw guarded edges
    // (tested 2026-10-18). Restore guards if a later Syside draws them.
    // =========================================================================

    action def BroadcastAircraftState {
        doc /* The aircraft continuously broadcasts its state (position, altitude, velocity;
         * transponder / ADS-B Out) while it moves. Runs concurrently with the crew's actions
         * in each phase where the owner noted it. [SME] */
        out aircraftState : AircraftState;   // was `out state`: `state` is a keyword, so it declared an unnamed state usage
    }

    action def ResolveConflict {
        doc /* The studied decision (D-007, D-020): the sector controller resolves one
         * predicted conflict. The branch is the experiment's information level: case A
         * applies the controller's rule, case B scores options with a nominal weight per
         * type, cases C and D score them with the airline's shared data. */
        // AI-DRAFTED 2026-10-19 at the owner's request ("Need ATCresolveConflict activity
        // diagram!", 2026-10-19 print); owner to review. Steps from the experiment
        // (report Section 4.2) and its sources: options as controller heuristics
        // (fothergill2013resolutionHeuristics [B]); "predetermined rules", descend rather
        // than climb (kirwan2001coraStrategies [B]); no climb above FL350
        // (engility2014tasarAlaska [B]); clearance and read-back (JO 7110.65BB 2-4-3,
        // 4-2-x [A]).
        // Inputs are what the decider can know (owner's 2026-10-19 print, Fly Enroute):
        in surveillance : AircraftState[*];                   // ADS-B position reports, radar: type, level, speed (today)
        in flightPlans : FlightPlan[*];                       // filed route and requested level (today)
        in performanceShare : AirlinePerformanceShare[0..*];  // MISSING today: weight, cost index, delay margin. IMPROVED (D-019), cases C and D
        out clearance : Clearance;                            // to the crew of the aircraft that moves

        first start;
        then action atcAssessConflict {
            doc /* Identify the pair, the geometry and the time to loss of separation. */
        }
        then action atcGenerateOptions {
            doc /* List the candidate maneuvers: level changes, speed changes, vectors.
             * No climb is offered above FL350. */
        }
        then decide informationCheck;
            succession ruleOnly first informationCheck then atcApplyRule;
            succession nominalWeight first informationCheck then atcScoreWithNominalWeight;
            succession sharedData first informationCheck then atcScoreWithSharedData;

        action atcApplyRule {
            doc /* Case A: apply the rule (descend; never climb above FL350). */
        }
        action atcScoreWithNominalWeight {
            doc /* Case B: decision support scores each option with one nominal weight per type. */
        }
        action atcScoreWithSharedData {
            doc /* Cases C and D: decision support scores each option with the airline's
             * weight and cost index, and in D its delay margin. */
        }
        first atcApplyRule then chooseMerge;
        first atcScoreWithNominalWeight then chooseMerge;
        first atcScoreWithSharedData then chooseMerge;
        merge chooseMerge;

        then action atcSelectAircraftAndManeuver {
            doc /* Choose which aircraft moves and how. */
        }
        then action atcIssueResolutionClearance {
            doc /* Issue the instruction by voice or datalink. */
            out clearance : Clearance;
        }
        then action crewReadBackAndAccept {
            doc /* The crew reads back and accepts, or says "unable". */
        }
        then action crewExecuteManeuver {
            doc /* The crew sets the new level or speed on the MCP or in the FMS. */
        }
        then action atcConfirmSeparation {
            doc /* The controller confirms separation from the radar picture. */
        }
        then done;

        bind clearance = atcIssueResolutionClearance.clearance;
    }

    action def Prework {
        doc /* The top-level airline business plan and design of the service model. */
        // Owner's wording, 2026-10-19 print. Kept from the earlier doc: steps in the
        // owner's listed order (the planning literature, to-do-list.md §2, may reorder or
        // iterate them); exogenous to the study (conops-hub-to-hub-trajectory-cost.md:
        // schedule, fleet assignment and crew pairing are given). [SME]

        first start;
        then action defineMarketSegmentation;
        then action selectServiceModel;
        then action designNetwork;
        then action publishSchedule;
        then action assignFleet { doc /* Fleet assignment strategy. */ }
        then action assignCrew;
        then done;
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

        action prepareAircraft {
            doc /* Fueling, FMS initialization and aircraft configuration, in parallel. */
            first start;
            then fork aircraftPrepFork;
                then airportDeliverFuel;
                then crewEnterFmsData;
                then crewConfigureAircraft;

            action airportDeliverFuel : SupplyFuel;   // airport fuel delivery
            action crewEnterFmsData;                  // crew -> aircraft FMS entries
            action crewConfigureAircraft;             // crew -> aircraft configuration

            first airportDeliverFuel then aircraftPrepJoin;
            first crewEnterFmsData then aircraftPrepJoin;
            first crewConfigureAircraft then aircraftPrepJoin;
            join aircraftPrepJoin;
            then done;
        }
        action turnAroundGate;    // boarding, baggage, ground handling

        flow release to prepareAircraft.airportDeliverFuel.release;

        first prepareAircraft then prepJoin;
        first turnAroundGate then prepJoin;

        join prepJoin;
        then done;
    }

    action def Depart {
        doc /* Pushback, taxi-out, takeoff, and departure procedure (SID). Ends when the
         * aircraft reaches cruise altitude. Sequence per owner, 2026-10-18 [SME]. */
        in flightPlan : FlightPlan;
        // TODO: in edct : ExpectDepartureClearanceTime; (from traffic flow management)
        inout flight : Flight;

        first start;
        then fork departFork;
            then taxiOut;
            then aircraftBroadcastState;

        action aircraftBroadcastState : BroadcastAircraftState;

        action taxiOut {
            doc /* Clearance, pushback and taxi. Ends with the aircraft safely at the runway
             * entrance. */
            first start;
            then action crewRequestDepartureClearance;
            then action towerIssueDepartureClearance {
                doc /* Clearance delivery position (voice, PDC or CPDLC DCL). */
            }
            then action crewAndAocConfirmClearance;
            then action crewCheckTrajectoryAndCoordinate {
                doc /* Crew checks trajectory and status, and coordinates updates and
                 * changes with the tower and the AOC. */
            }
            then action towerIssuePushbackClearance {
                doc /* The tower issues gate pushback clearance. */
                // Owner's choice, 2026-10-19 print ("choose Tower"). In practice it varies by
                // airport (airline or airport ramp tower vs. ATC ground control); the model
                // takes the tower as the abstraction. Was rampControlIssuePushbackClearance.
            }
            then action crewPushBackWithGroundControl {
                doc /* Crew confirms and coordinates with ground control for pushback. */
            }
            then action crewRequestTaxiClearance;
            then action towerIssueTaxiInstructions;
            then fork taxiFork;
                then crewTaxiToRunway;
                then towerMonitorTaxi;

            action crewTaxiToRunway;
            action towerMonitorTaxi {
                doc /* Tower monitors the aircraft along the taxi instructions. */
            }
            first towerMonitorTaxi then surfaceConflictCheck;

            decide surfaceConflictCheck;
                succession surfaceConflict first surfaceConflictCheck then towerResolveSurfaceConflict;
                succession noSurfaceConflict first surfaceConflictCheck then surfaceMonitorMerge;

            action towerResolveSurfaceConflict {
                doc /* Tower resolves a conflict with another aircraft by issuing
                 * instructions to the crew. */
            }
            first towerResolveSurfaceConflict then surfaceMonitorMerge;
            merge surfaceMonitorMerge;

            first crewTaxiToRunway then taxiJoin;
            first surfaceMonitorMerge then taxiJoin;
            join taxiJoin;
            then done;
        }

        action takeoffAndClimb {
            doc /* Runway entry through climb. Ends at cruise altitude. */
            first start;
            then action crewRequestRunwayEntry;
            then action towerIssueTakeoffClearance;
            then action crewPerformTakeoff {
                doc /* Crew controls the aircraft onto the runway and takes off through V1,
                 * VR and V2 for initial climb-out (speeds from DispatchRelease). */
            }
            then action towerTransferToDepartureControl;
            then action crewJoinDepartureFlow {
                doc /* Crew confirms the transfer and continues, joining the departure flow
                 * controlled by the departure/approach controller. */
            }
            then action crewClimbToCruise {
                doc /* Climb, maintaining minimum rate of climb and coordinating as needed
                 * for weather, sector crossings, conflict detections, etc. */
            }
            then done;
        }

        first taxiOut then takeoffAndClimb;
        first takeoffAndClimb then departJoin;
        first aircraftBroadcastState then departJoin;
        join departJoin;
        then done;
    }

    action def FlyEnroute {
        doc /* Cruise along the cleared trajectory under ARTCC control. Three concurrent
         * threads: the crew's cruise loop, ATC's sector monitoring, and the AOC, which
         * acts only when needed. Per owner, 2026-10-18 [SME]. */
        inout flight : Flight;

        first start;
        then fork enrouteFork;
            then crewCruise;
            then aircraftBroadcastState;
            then atcMonitorSector;
            then aocMonitorFlight;

        action aircraftBroadcastState : BroadcastAircraftState; // aircraft flies level, transmitting data
        // The broadcast state is what ATC's conflict resolution sees (owner's 2026-10-19
        // print: "why no other I/O, but showing this one?" and "connect across diagrams").
        flow aircraftBroadcastState.aircraftState to atcMonitorSector.atcResolveConflict.surveillance;

        action crewCruise {
            doc /* The crew's repeating cruise loop, until near top of descent. */
            first start;
            then merge cruiseLoop;
            then action crewSurveilTrafficAndWeather {
                doc /* Crew surveils for traffic and weather and reacts to each as needed. */
            }
            then action crewMonitorWeight {
                doc /* Crew monitors aircraft weight against the dispatch paperwork and FMS
                 * data. */
            }
            then decide stepClimbCheck;
                succession stepClimbDue first stepClimbCheck then crewRequestStepClimb;
                succession noStepClimb first stepClimbCheck then stepClimbMerge;

            action crewRequestStepClimb {
                doc /* When the next step weight is nearly reached, crew requests clearance
                 * to the new optimum altitude. */
            }
            then action atcCheckStepClimbTraffic {
                doc /* Controller checks traffic and that the new clearance gives a
                 * conflict-free trajectory. */
            }
            then action crewClimbToOptimumAltitude {
                doc /* Crew confirms clear of traffic and climbs via MCP altitude dial,
                 * FLCH and possibly FMS entries. */
            }
            then stepClimbMerge;
            merge stepClimbMerge;

            then action crewPerformEnrouteSops {
                doc /* Airline SOPs while sequencing waypoints: recording fuel/state data,
                 * programming alternate airports into the FMS, equal-time points, and
                 * maintaining visual separation from other aircraft. */
            }
            then decide sectorBoundaryCheck;
                succession atSectorBoundary first sectorBoundaryCheck then atcHandOffToNextSector;
                succession sameSector first sectorBoundaryCheck then handoffMerge;

            action atcHandOffToNextSector;
            then action crewContactNextController {
                doc /* Crew confirms the handoff and contacts the next controller. */
            }
            then handoffMerge;
            merge handoffMerge;

            then decide cruiseEndCheck;
                succession cruiseAtTopOfDescent first cruiseEndCheck then done;
                succession continueCruise first cruiseEndCheck then cruiseLoop;
        }

        action atcMonitorSector {
            doc /* ATC continually monitors the flight and all traffic in the sector. */
            first start;
            then merge atcLoop;
            then action atcMonitorSectorTraffic;
            then decide conflictCheck;
                succession conflictFound first conflictCheck then atcResolveConflict;
                succession noConflict first conflictCheck then atcMerge;

            // The decision the capstone studies (D-007, D-020); decomposed in
            // ResolveConflict (view resolveConflictActivity), 2026-10-19.
            action atcResolveConflict : ResolveConflict;
            then atcMerge;
            merge atcMerge;

            then decide atcLoopEnd;
                succession atcAtTopOfDescent first atcLoopEnd then done;
                succession continueMonitoring first atcLoopEnd then atcLoop;
        }

        action aocMonitorFlight {
            doc /* The AOC is involved only when weather forces a reroute or external
             * conditions warrant a change (e.g. another flight is behind schedule, so slow
             * down). */
            first start;
            then decide aocCheck;
                succession changeWarranted first aocCheck then aocAmendFlight;
                succession noChange first aocCheck then aocMerge;

            action aocAmendFlight;
            then aocMerge;
            merge aocMerge;
            then done;
        }

        first crewCruise then enrouteJoin;
        first aircraftBroadcastState then enrouteJoin;
        first atcMonitorSector then enrouteJoin;
        first aocMonitorFlight then enrouteJoin;
        join enrouteJoin;
        then done;
    }

    action def Arrive {
        doc /* Descent, arrival procedure (STAR), approach, landing, and taxi-in. Before top
         * of descent the flight must get its descent clearances: STAR, approach and runway,
         * runway exit, gate and taxi instructions. Per owner, 2026-10-18 [SME]. */
        inout flight : Flight;

        first start;
        then action airportProvideArrivalData {
            doc /* Airports populate the information the arrival manager (AMAN) needs. */
        }
        then action approachPlanArrivalTraffic {
            doc /* Approach control uses its systems (e.g. AMAN) to plan arrival traffic
             * to the airport's capacity. */
        }
        then action determinePlannedArrivalTime {
            doc /* Approach, tower and ATFM together set the flight's planned time of
             * arrival, typically tied to its landing slot. */
        }
        then fork arrivalPlanFork;
            then airportAssignGate;
            then towerPlanTaxiIn;

        action airportAssignGate;  // from the landing time
        action towerPlanTaxiIn;    // taxi info from the landing time

        first airportAssignGate then arrivalPlanJoin;
        first towerPlanTaxiIn then arrivalPlanJoin;
        join arrivalPlanJoin;

        then action atcSendArrivalPlanToAoc {
            doc /* ATC sends the arrival plan (STAR, approach, runway, exit, taxi) to dispatch. */
        }
        then action aocRelayArrivalPlanToCrew {
            doc /* Dispatch adds the gate and relays the arrival plan to the crew. */
            // Owner's path, 2026-10-19 print: "ATC -> Dispatch -> Crew". Medium not yet
            // modeled (ACARS is the likely one). Was deliverArrivalPlanToCrew. [SME]
        }
        then action crewProgramArrivalIntoFms {
            doc /* Crew enters the arrival into the FMS, checks the top-of-descent point and
             * anticipates problems meeting constraints. */
        }
        then action crewRequestDescentClearance;   // near T/D
        then action atcIssueDescentClearance;      // enroute ATC, usually
        then action atcHandOffToApproach {
            doc /* Enroute ATC hands the flight off to approach at the planned 4D point. */
        }
        then action crewDescendAndConfigure {
            doc /* Descend, decelerate and configure for landing, monitoring weather and
             * coordinating with controllers. */
        }
        then action crewFlyFinalApproach {
            doc /* Fully configured for landing, coordinating with the tower. */
        }
        then action crewLand;
        then action crewExitRunway;
        then action crewTaxiToGate;
        then action crewParkWithGroundControl;
        then done;
    }

    action def CloseOutFlight {
        doc /* Block-in, deplaning, and handoff to the next leg / turnaround. Per owner,
         * 2026-10-18 [SME]. */
        in flight : Flight;

        first start;
        then action crewBlockIn {
            doc /* Once parked, the aircraft is blocked (chocks and brakes) as a safety
             * measure. */
        }
        then fork closeOutFork;
            then passengersDeplane;
            then crewRecordFinalInfo;
            then crewReviewNextLeg;

        action passengersDeplane;
        action crewRecordFinalInfo;
        action crewReviewNextLeg;   // as needed

        first passengersDeplane then closeOutJoin;
        first crewRecordFinalInfo then closeOutJoin;
        first crewReviewNextLeg then closeOutJoin;
        join closeOutJoin;

        then action turnAroundCrewAndAircraft;   // as scheduled
        then done;
    }

    // =========================================================================
    // 2. TOP-LEVEL ACTIVITY
    // =========================================================================

    action def NominalFlightOperations {
        doc /* Gate-to-gate sequence for one flight under nominal conditions. */
        // Scope (owner's 2026-10-19 print): this is nominal FLIGHT operations, one flight's
        // view. NAS operations would add what runs across all flights: traffic flow
        // management initiatives being created, flight monitoring and conflict resolution
        // for all traffic. Only the conflict resolution that touches this flight is here
        // (FlyEnroute::atcMonitorSector::atcResolveConflict).

        // --- Control flow (the ordering of phases) ---
        first start;
        then action prework : Prework;
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
        flow prepareForDeparture.flight to depart.flight;
        flow depart.flight to flyEnroute.flight;
        flow flyEnroute.flight to arrive.flight;
        flow arrive.flight to closeOutFlight.flight;
    }

    // =========================================================================
    // 3. SWIMLANES (allocation of actions to performers)
    // SysML v2 has no partitions; a lane is a part that performs actions.
    // =========================================================================

    action nominalFlight : NominalFlightOperations;

    part def NominalOpsContext {
        part flightOps : FlightOperationsDomain {
            perform nominalFlight.prework;
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
