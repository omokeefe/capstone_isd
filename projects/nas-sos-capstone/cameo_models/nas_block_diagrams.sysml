package NASBlockDiagrams {
    doc /* Block definition diagram (BDD) of the NAS and internal block diagrams (IBDs) of
     * the domains that had none. Created 2026-10-19 (D-029) at the owner's request:
     *   1. One top-level BDD: the NAS block and, by composition only, the five modeled
     *      domains (D-007, D-008) and the systems drawn on the context diagram (D-009).
     *      No ports, attributes or exchange links: those are on the context diagram.
     *      Rendered by MyViews::nasBdd.
     *   2. One IBD per modeled domain. Two already exist and stay in their own files:
     *        Aircraft Systems    nas_ibd_aircraft.sysml               (views aircraftIbd, aircraftIbdDetail)
     *        Airspace Management nas_ibd_airspace_management.sysml    (view airspaceManagementIbd)
     *      The other three are here:
     *        Flight Operations   FlightOperationsInternals            (view flightOperationsIbd)
     *        Airport Operations  AirportOperationsInternals           (view airportOperationsIbd)
     *        Flight Crew         FlightCrewInternals                  (view flightCrewIbd)
     *
     * Same rules as the other diagram files. Definitions stay in
     * nas_sysml_package_definitions.sysml (methods §10.1); this file holds usages, tags and
     * wiring only. A tag decides what each view draws; untagged parts stay in the model but
     * off the picture. Per D-010 an IBD holds the links inside one domain; the links that
     * cross a domain boundary stay on the context diagram.
     * Labels: each connection's description is a `comment about <name>` placed after the
     * part that owns the connection, so the name prints on the line
     * (sysml-diagram-rendering.md §6, §8).
     *
     * Review key (as in nas_context_diagram.sysml):
     *   [A]   primary/normative source   [B] empirical literature   [SME] owner's FMS experience
     *   [C]   general domain knowledge; defensible, not yet citable
     *   TODO(review)  weak evidence or tie to the intent chain; the owner's call
     * Every link below was drafted by Claude on 2026-10-19 from the definitions' docs and the
     * context diagram's notes. Not yet hand-reviewed.
     */

    metadata def BDDVisible {
        doc /* Tag for elements the NAS BDD view (MyViews::nasBdd) draws. */
    }

    metadata def IBDVisible {
        doc /* Tag for elements the three domain IBD views in this file draw. */
    }

    // ==================================================================
    // 1. BDD: the NAS and its systems, composition only
    // ==================================================================
    // Same systems as the context diagram (NASContextDiagram's #ContextVisible parts):
    // the five modeled domains, and inside them atc/atcscc, airlineOperationsCenter,
    // airport, aircraft and flightDeckCrew. Systems the context diagram does not draw
    // (tracon, artcc, tmu, tfmAutomation, ticketingSystem, cabinCrew) are left untagged,
    // so they stay in the model and off this view. The Environment block is not drawn
    // either (D-012: what comes from outside is an input port, not a box).
    part def NASStructure {
        private import NationalAirspaceSystem::AirspaceManagement::*;
        private import NationalAirspaceSystem::FlightOperations::*;
        private import NationalAirspaceSystem::AirportOperations::*;
        private import NationalAirspaceSystem::AircraftSystems::*;
        private import NationalAirspaceSystem::FlightCrew::*;
        // nas is typed fully qualified: the package and its top part def share the name,
        // so importing NationalAirspaceSystem::* makes the name ambiguous.
        // Each redefinition restates the type it already has, only so the box shows the
        // block name (a bare `part :>> atc;` is drawn as "atc :>> atc").
        #BDDVisible part nas: NationalAirspaceSystem::NationalAirspaceSystem {
            #BDDVisible part :>> airspaceManagement: AirspaceManagementDomain {
                #BDDVisible part :>> atc: AirTrafficControlSystem;
                #BDDVisible part :>> atcscc: ATCSCC;
            }
            #BDDVisible part :>> flightOperations: FlightOperationsDomain {
                #BDDVisible part :>> airlineOperationsCenter: AirlineOperationsCenter;
            }
            #BDDVisible part :>> airportOperations: AirportOperationsDomain {
                #BDDVisible part :>> airport: Airport;
            }
            #BDDVisible part :>> aircraftSystems: AircraftSystemsDomain {
                #BDDVisible part :>> aircraft: Aircraft;
            }
            #BDDVisible part :>> flightCrew: FlightCrewDomain {
                #BDDVisible part :>> flightDeckCrew: FlightDeckCrew;
            }
        }
    }

    // ==================================================================
    // 2a. IBD: Flight Operations (the airline operations center)
    // ==================================================================
    // The AOC is one node on the context diagram. Here its roles are opened up (roles,
    // not people: Munro 2018). Which role owns each external link is in the doc of
    // FlightOperations::AirlineOperationsCenter. ticketingSystem is ABSORBED (D-009) and
    // not drawn. performanceShareOut is IMPROVED ARCHITECTURE (D-019). It is drawn
    // (owner's 2026-10-19 print, Section 3.6: the report must be able to point to the
    // port the performance data leaves on); which role feeds it is still open.
    part def FlightOperationsInternals {
        private import NationalAirspaceSystem::FlightOperations::*;

        #IBDVisible part flightOps: FlightOperationsDomain {
            #IBDVisible part :>> airlineOperationsCenter {
                #IBDVisible part :>> dispatcher;
                #IBDVisible part :>> flightFollower;
                #IBDVisible part :>> atcCoordinator;
                #IBDVisible part :>> loadPlanner;
                #IBDVisible part :>> maintenanceController;
                #IBDVisible part :>> crewScheduler;
                #IBDVisible part :>> aircraftRouter;
                #IBDVisible part :>> dutyManager;
                #IBDVisible part :>> decisionSupport;
                in #IBDVisible port :>> rulesIn;
                in #IBDVisible port :>> weatherIn;
                #IBDVisible port :>> performanceShareOut;   // typed port: its `out item` sets the side

                #IBDVisible connection weatherToDispatch connect weatherIn to dispatcher;
                #IBDVisible connection planningSystem connect dispatcher to decisionSupport;
                #IBDVisible connection releaseHandover connect dispatcher to flightFollower;
                #IBDVisible connection tfmRelay connect atcCoordinator to dispatcher;
                #IBDVisible connection weightNegotiation connect loadPlanner to dispatcher;
                #IBDVisible connection melDeferrals connect maintenanceController to dispatcher;
                #IBDVisible connection iropsDispatch connect dutyManager to dispatcher;
                #IBDVisible connection iropsCrew connect dutyManager to crewScheduler;
                #IBDVisible connection iropsAircraft connect dutyManager to aircraftRouter;
                #IBDVisible connection tailCrewSwap connect aircraftRouter to crewScheduler;
            }
        }
        comment about flightOps::airlineOperationsCenter::weatherToDispatch /* [A/C] Weather from outside the SoI (weatherIn) reaches the dispatcher, who must put the latest reports and forecasts for each airport in the release (14 CFR 121.687, not registered: [C]). */
        comment about flightOps::airlineOperationsCenter::planningSystem /* [SME/C] Dispatcher <-> flight planning system (the AOC's own decision support, D-012): route, altitudes, cost index and weights in; OFP with planned burn and times out. The source of the release's numbers. */
        comment about flightOps::airlineOperationsCenter::releaseHandover /* [B] Dispatcher -> flight follower: the released flight is handed over for monitoring; deviations from plan come back for an amended release. At many carriers one person does both (Munro 2018: the workflow "cannot always be neatly divided"); Berry & Pace 2011. */
        comment about flightOps::airlineOperationsCenter::tfmRelay /* [B] ATC coordinator <-> dispatcher: EDCTs, TMIs and reroutes from the ATCSCC (aocTfm) reach the dispatcher here; the dispatcher's route needs go back out as TOS / Early Intent. The dispatcher does not deal with ATC directly except in emergencies (Berry & Pace 2011, p. 4; Seamster 2011 p. 34). Intent chain: ATC constraints -> flight plan. */
        comment about flightOps::airlineOperationsCenter::weightNegotiation /* [B] Load planner <-> dispatcher: planned and final weights (ZFW, takeoff weight), load closeout; an "ongoing negotiation" over weight (Munro 2018; Seamster E-2#20). The weight that sets the trajectory's cost. */
        comment about flightOps::airlineOperationsCenter::melDeferrals /* [B] Maintenance controller -> dispatcher: MEL/CDL deferrals and their operational restrictions, which go into the release (Berry & Pace 2011). */
        comment about flightOps::airlineOperationsCenter::iropsDispatch /* [B] Duty manager -> dispatcher: the airline-side call in irregular operations (which flights to cancel, delay or prioritize); Berry & Pace 2011; Clarke 1998. */
        comment about flightOps::airlineOperationsCenter::iropsCrew /* [B] Duty manager <-> crew scheduler: crew legality and reassignment in a disruption (Berry & Pace 2011; Clarke 1998). */
        comment about flightOps::airlineOperationsCenter::iropsAircraft /* [B] Duty manager <-> aircraft router: tail swaps and cancellations in a disruption (Berry & Pace 2011; Clarke 1998). */
        comment about flightOps::airlineOperationsCenter::tailCrewSwap /* [C] TODO(review) Aircraft router <-> crew scheduler: a tail swap moves the crew too, so the two coordinate. Recovery literature treats aircraft and crew recovery as linked; no registered source checked yet. Off the studied thread. */

    }

    // ==================================================================
    // 2b. IBD: Airport Operations
    // ==================================================================
    // The context diagram draws the airport as one node; D-009 absorbs its sub-parts
    // (they carry out decisions made elsewhere). Here they are opened up. The hub layout
    // (everything talks through the airport management system) comes from the prework
    // draft, knowledge/models/interface-exchange-draft.md, whose directions are
    // unverified: most links below are [C]. None is on the studied thread.
    part def AirportOperationsInternals {
        private import NationalAirspaceSystem::AirportOperations::*;

        #IBDVisible part airportOps: AirportOperationsDomain {
            #IBDVisible part :>> airport {
                #IBDVisible part :>> airportManagementSystem;
                #IBDVisible part :>> controlTower;
                #IBDVisible part :>> airfieldLighting;
                #IBDVisible part :>> runways;
                #IBDVisible part :>> apron;
                #IBDVisible part :>> gates;
                #IBDVisible part :>> passengerTerminal;
                #IBDVisible part :>> baggageHandlingSystem;
                #IBDVisible part :>> groundHandling {
                    #IBDVisible part :>> pushbackCrew;
                    #IBDVisible part :>> catering;
                    #IBDVisible part :>> deicing;
                    #IBDVisible part :>> lavAndWaterService;
                }
                #IBDVisible part :>> fuelDistributionSystem;
                #IBDVisible part :>> maintenanceHangar;
                #IBDVisible part :>> customsAndImmigration;

                #IBDVisible connection amsGroundHandling connect airportManagementSystem to groundHandling;
                #IBDVisible connection amsBaggage connect airportManagementSystem to baggageHandlingSystem;
                #IBDVisible connection amsCustoms connect airportManagementSystem to customsAndImmigration;
                #IBDVisible connection amsGates connect airportManagementSystem to gates;
                #IBDVisible connection towerLighting connect controlTower to airfieldLighting;
                #IBDVisible connection runwayLighting connect airfieldLighting to runways;
                #IBDVisible connection passengerFlow connect passengerTerminal to gates;
                #IBDVisible connection bagFlow connect baggageHandlingSystem to groundHandling;
                #IBDVisible connection rampAccess connect gates to apron;
            }
        }
        comment about airportOps::airport::amsGroundHandling /* [C] AMS <-> ground handling: requests for baggage, refueling and maintenance services out; status of ground services back (interface-exchange-draft.md, directions unverified). The orders themselves start at the AOC (aocAirport). */
        comment about airportOps::airport::amsBaggage /* [C] AMS <-> baggage handling system: baggage information and bag-tag assignment out; location, status and delivery confirmation back (interface-exchange-draft.md). */
        comment about airportOps::airport::amsCustoms /* [C] AMS <-> customs and immigration: passenger information for international flights out; clearance and alerts back (interface-exchange-draft.md). Off the domestic thread. */
        comment about airportOps::airport::amsGates /* [C] TODO(review) AMS <-> gates: gate assignment and stand status. Who assigns depends on the lease (FAA Order 5190.6C Ch. 9 for the sponsor side; owner abstraction 2026-09-28: the signatory airline assigns its leased gates). The draft does not name this spoke. */
        comment about airportOps::airport::towerLighting /* [A] Control tower -> airfield lighting: the tower runs the remote lighting controls (JO 7110.65BB 3-4-2..3-4-15). The airport owns and maintains the lights (14 CFR 139.311, not registered). The tower here is the facility; the controllers in it are ATC (atcAirport on the context diagram). */
        comment about airportOps::airport::runwayLighting /* [C] Physical: edge and centerline lights, stop bars and signs on the runways and taxiways. */
        comment about airportOps::airport::passengerFlow /* [B] Material: passengers from the terminal to the gate for boarding and back on arrival (Schultz 2017 boarding/deplaning). */
        comment about airportOps::airport::bagFlow /* [B/C] Material: checked bags from the sorting system to the ramp loaders and back (bags: Lu 2025). */
        comment about airportOps::airport::rampAccess /* [C] Physical: the stand on the apron, where ramp vehicles and the aircraft move. */

    }

    // ==================================================================
    // 2c. IBD: Flight Crew
    // ==================================================================
    // The context diagram draws the flight deck crew as one node (D-009). Here the captain,
    // first officer, their EFB and the cabin crew are opened up. preflightCrossCheck is an
    // action, not a part, so it is not on this view.
    part def FlightCrewInternals {
        private import NationalAirspaceSystem::FlightCrew::*;

        #IBDVisible part flightCrew: FlightCrewDomain {
            #IBDVisible part :>> flightDeckCrew {
                #IBDVisible part :>> captain;
                #IBDVisible part :>> firstOfficer;
                #IBDVisible part :>> electronicFlightBag;

                #IBDVisible connection crewCoordination connect captain to firstOfficer;
                #IBDVisible connection captainEfb connect captain to electronicFlightBag;
                #IBDVisible connection firstOfficerEfb connect firstOfficer to electronicFlightBag;
            }
            #IBDVisible part :>> cabinCrew;

            #IBDVisible connection cabinToFlightDeck connect cabinCrew to flightDeckCrew;
        }
        comment about flightCrew::flightDeckCrew::crewCoordination /* [B/SME] Captain <-> first officer: briefings, call-outs and cross-checks; flying and monitoring duties swap; either may work the radio (Seamster E-2#07, E-4#02-04). Final authority stays with the captain as pilot in command (14 CFR 91.3, not registered). */
        comment about flightCrew::flightDeckCrew::captainEfb /* [B/SME] Captain <-> EFB: release, charts and performance calculations (the release may arrive on the EFB: Munro 2018). The crew's own decision support (D-012). */
        comment about flightCrew::flightDeckCrew::firstOfficerEfb /* [B/SME] First officer <-> EFB: as captainEfb. */
        comment about flightCrew::cabinToFlightDeck /* [C] Cabin crew <-> flight deck crew: cabin secure / ready for departure; passenger medical, security or disruptive-passenger events, which can trigger a diversion (Seamster T2.10 covers the diversion on the crew <-> AOC side); phase-of-flight and turbulence advisories back to the cabin. Was a commented-out draft on the context diagram, moved here per D-010. Ends on flightDeckCrew, not a pilot (D-009). */

    }
}
