package NationalAirspaceSystem {
    doc /*
     * System of Interest: the National Airspace System (NAS), modeled as a System
     * of Systems. Boundary ratified 2026-09-21 per decisions/decisions-log.md D-007
     * (rationale: knowledge/models/system_of_interest_definition.md). Reconciled
     * 2026-09-22 from the pre-ratification first pass: only the five ratified
     * Modeled System domains (Airspace Management, Flight Operations, Airport
     * Operations, Aircraft Systems, Flight Crew) are decomposed inside the
     * `NationalAirspaceSystem` part def below. Governance, Passengers, Military,
     * Infrastructure, Information Services, and Decision Support are D-007
     * boundary actors / context constraints / absorbed capabilities — present in
     * the `Environment` part def for context-diagram authoring (ports, item flows
     * crossing the SOI boundary — see nas_context_diagram.sysml), but deliberately
     * NOT decomposed into constituent systems, per system_of_interest_definition.md's
     * "Included and excluded scope."
     *
     * D-002's domain-decomposition question (how the *modeled* systems themselves
     * are organized) is separate from D-007's boundary question and remains
     * provisional pending to-do-list.md §6 — this reconciliation does not resolve
     * it, only re-sorts the pre-ratification package list by D-007 disposition.
     *
     * Constituent systems below are drawn from
     * knowledge/models/candidate-systems-inventory.md. General aviation and
     * international/foreign-authority systems remain out of scope per D-007.
     *
     * DRAFT: authored directly in SysML v2 textual notation (Syside Modeler), the
     * source of truth per D-006 — not reconciled into Cameo, which is optional and
     * downstream.
     */

    package Common {
        doc /* Shared value types used across multiple domains — not systems in their own right. */

        public import ScalarValues::*;

        attribute def Position {
            attribute latitude: Real; // in decimal degrees
            attribute longitude: Real; // in decimal degrees
            attribute altitude: Real; // in meters above sea level
            attribute timestamp: DateTime; // optional timestamp for the position
        }

        attribute def DateTime {
            attribute year: Integer;
            attribute month: Integer; // 1-12
            attribute day: Integer; // 1-31
            attribute hour: Integer; // 0-23
            attribute minute: Integer; // 0-59
            attribute second: Integer; // 0-59
        }

        attribute def Operator {
            attribute name: String;
            attribute type: String; // e.g., "Airline", "Ground Service"
            attribute contactInfo: String; // e.g., phone number or email
            attribute isActive: Boolean; // true if operator is currently active
        }

        attribute def Passenger {
            attribute name: String;
            attribute seatNumber: String;
        }

        attribute def Cargo {
            attribute weight: Real; // in kilograms
            attribute type: String; // e.g., "Mail", "Freight"
        }
    }

    // The System of Interest itself: the five ratified Modeled System domains
    // (D-007). Boundary actors, context constraints, and absorbed capabilities
    // live in Environment below, not here.
    part def NationalAirspaceSystem {
        part airspaceManagement: AirspaceManagement::AirspaceManagementDomain;
        part flightOperations: FlightOperations::FlightOperationsDomain;
        part airportOperations: AirportOperations::AirportOperationsDomain;
        part aircraftSystems: AircraftSystems::AircraftSystemsDomain;
        part flightCrew: FlightCrew::FlightCrewDomain;
    }

    // Everything outside the ratified SOI boundary (D-007): boundary actors,
    // context constraints, and absorbed/abstracted capabilities. Exists so the
    // context diagram can show actors and item flows crossing the SOI boundary,
    // without decomposing any of them into constituent systems.
    part def Environment {
        doc /* Everything outside the ratified SOI boundary (D-007): boundary actors,
        * context constraints, and absorbed/abstracted capabilities. Exists so the
        * context diagram can show actors and item flows crossing the SOI boundary,
        * without decomposing any of them into constituent systems.
         */
        
        part def EnvironmentDomain {
            part governance: Governance::GovernanceDomain;
            part passengers: Passengers::PassengersDomain;
            part military: Military::MilitaryDomain;
            part infrastructure: Infrastructure::InfrastructureDomain;
            part informationServices: InformationServices::InformationServicesDomain;
            part decisionSupport: DecisionSupport::DecisionSupportDomain;
        }

        part governance: Governance::GovernanceDomain;
        part passengers: Passengers::PassengersDomain;
        part military: Military::MilitaryDomain;
        part infrastructure: Infrastructure::InfrastructureDomain;
        part informationServices: InformationServices::InformationServicesDomain;
        part decisionSupport: DecisionSupport::DecisionSupportDomain;
    }

    package AirspaceManagement {
        doc /* Air traffic control, flow management, and traffic-flow authority over NAS airspace. */

        part def AirspaceManagementDomain {
            part atc: AirTrafficControlSystem;
            part tracon: TRACON;
            part artcc: ARTCC;
            part atcscc: ATCSCC;
            part tmu: TMU;
            // D-007 ABSORBED (Decision Support allocated to the ATM context): the TFM tools
            // the ATCSCC and TMUs work through. They are media/capabilities, not parties to an
            // exchange (owner, 2026-09-27: "FSM is a tool", "TBFM is a tool").
            part tfmAutomation: AirTrafficFlowManagementSystem;
        }

        part def AirTrafficControlSystem {
            doc /* Top-level ATC system node per candidate-systems-inventory.md. */
        }

        part def TRACON {
            doc /* Terminal Radar Approach Control — departure & arrival airspace. */
        }

        part def ARTCC {
            doc /* Air Route Traffic Control Center — regional en-route airspace. */
        }

        part def ATCSCC {
            doc /* Air Traffic Control System Command Center — national traffic-flow authority. */
        }

        part def TMU {
            doc /* Traffic Management Unit — local traffic-flow authority. */
        }

        part def AirTrafficFlowManagementSystem {
            doc /* The TFM automation the ATCSCC and TMUs (and, for FSM and TOS, flight operators)
             * work through. Tools, not parties: they are the channel an exchange travels on,
             * so connections name the items (slots, rates, TMIs, TBM status) and cite the tool
             * as the medium. Tools named in JO 7210.3EE Ch. 18: TFMS (monitor/alert, TSD, RAD),
             * FSM, NTML, TBFM, TFDM, DRT. Only the ones the model's exchanges use are parts here.
             * Candidate addition: FAA SMART (Strategic Management of Airspace, Routes and
             * Trajectories), an AI-supported TFM planning tool in limited use around Washington
             * D.C. since 2026-09-21. Not yet a registered source; see inbox note 2026-09-27. */
            part trafficFlowManagementSystem: TrafficFlowManagementSystem;
            part flightScheduleMonitor: FlightScheduleMonitor;
            part nationalTrafficManagementLog: NationalTrafficManagementLog;
            part timeBasedFlowManagement: TimeBasedFlowManagement;
            part diversionRecoveryTool: DiversionRecoveryTool;
        }

        part def TrafficFlowManagementSystem {
            doc /* TFMS: the national TFM automation. Receives TOS and Early Intent from flight
             * operators (JO 7210.3EE 18-7-4h6, 18-8-2c, 18-12-3b); hosts monitor/alert (MAP,
             * 18-9) and the Route Amendment Dialog that sends airborne reroutes to ERAM (18-7-4h5). */
        }

        part def FlightScheduleMonitor {
            doc /* FSM: the tool used to model, issue and manage GDPs, AFPs and GSs. Carries slot
             * assignments / EDCTs, arrival rates (AAR) and schedule changes. Used by the ATCSCC,
             * TMUs AND flight operators, who submit schedule changes and cancellations to it
             * (JO 7210.3EE 18-10-3, 18-11-1). Medium, not an exchange. */
        }

        part def NationalTrafficManagementLog {
            doc /* NTML: the FAA log and coordination tool in which facilities record and
             * coordinate TM events, TMIs, TBM operations, delays, restrictions, runway
             * configurations/AAR/ADR, and reroute requests. Facilities must use it "in preference
             * to other methods" (JO 7210.3EE 18-5-3, 18-5-8b, 18-5-11, 18-5-12, 18-7-9d).
             * FAA-internal: it is the medium on ATCSCC <-> TMU <-> facility links (Airspace
             * Management IBD), not on the operator-facing links, where operators see ATCSCC
             * advisories and TFMS/FSM data instead. */
        }

        part def TimeBasedFlowManagement {
            doc /* TBFM: FAA time-based metering automation (arrival/departure scheduling,
             * metering times to sectors and towers). Medium, not an exchange: what crosses the
             * links is TBM status (TMU -> ATCSCC, 18-5-4c1, 18-6-9b, 18-6-11) and metering times /
             * departure release times (TMU -> controllers, BB 4-3-4). TBFM metering is the TBO
             * link closest to trajectory intent (18-6-1). */
        }

        part def DiversionRecoveryTool {
            doc /* DRT: where operators flag diverted flights for priority re-entry ("High" =
             * the user's preference within its own company; "Yes" = special handling). The
             * ATCSCC activates it and may modify user priorities "to maintain the efficiency of
             * the system" (JO 7210.3EE 18-4-5b, c). Alternative: "DVRSN" in flight plan remarks. */
        }

        // TFM exchange items (grade A, JO 7210.3EE Ch. 18). Used on the AOC <-> ATCSCC link.
        item def ExpectDepartureClearanceTime {
            doc /* EDCT. Issued by the ATCSCC "to ARTCCs and linked system users" (18-10-6e);
             * the ARTCC TMU relays, assigns from the DAS table in some modes, and requests
             * revisions (18-10-7). Tower enforces the -5/+5 min window (BB 4-3-4). */
            attribute flightNumber: String;
        }
        item def TMIAdvisory {
            doc /* ATCSCC advisory for a TMI: GDP, GS, AFP, CTOP, reroute, diversion recovery
             * (18-10-6c, 18-12-4, 18-15-2a7, 18-4-5c). NOT a "traffic advisory", which is the
             * BB 2-1-21 controller -> pilot proximity call. */
            attribute tmiType: String; // e.g., "GDP", "GS", "AFP", "CTOP", "Reroute"
        }
        item def FlowConstrainedArea {
            doc /* FEA / FCA publication: airspace, filters and time window identifying affected
             * flights. Customers MAY act on an FEA and MUST act on an FCA (18-8-2, 18-8-3). */
        }
        item def TrajectoryOptionsSet {
            doc /* TOS: "A message sent by the NAS user to TFMS" defining preferred routes /
             * altitudes / speeds, each weighted by operator-submitted preferences (18-12-3b).
             * The one place an airline's cost preference enters a FAA allocation directly. */
        }
        item def CtopAssignment {
            doc /* CTOP result per flight: a route that avoids the FCA, or a route plus EDCT for
             * an allocated slot in the FCA (18-12-3a). */
        }
        item def ScheduleChange {
            doc /* Operator schedule changes and cancellations submitted to FSM (18-10-3). */
        }
        item def SlotSubstitutionRequest {
            doc /* GDP user option: exchange/substitute CTAs under CDM agreements; the ATCSCC
             * may deny it (rapidly varying AARs, workload, NOM/NTMO judgment) and keeps the
             * delay factor equal after the trade (18-10-12b). Also intermediate landing (18-10-12a). */
        }
        item def DiversionRecoveryRequest {
            doc /* Operator's priority request for a diverted flight, via the DRT or "DVRSN" in
             * remarks; may be modified by the ATCSCC (18-4-5b). */
            attribute priority: String; // "High" (intra-company preference) or "Yes" (special handling)
        }


        public import ScalarValues::*;

        part def StandardInstrumentDeparture {
            doc /* SID — a published departure procedure, specific to one airport.
             * Concrete SIDs (e.g. "BENKY4 at KORD") are usages of this def, per
             * workflows/sysml-instance-modeling.md. */
            ref part airport: AirportOperations::Airport;
            attribute name: String; // e.g., "BENKY4"
        }

        part def StandardTerminalArrival {
            doc /* STAR — a published arrival procedure, specific to one airport. */
            ref part airport: AirportOperations::Airport;
            attribute name: String;
        }

        part def InstrumentApproachProcedure {
            doc /* A published approach procedure, specific to one airport/runway. */
            ref part airport: AirportOperations::Airport;
            attribute name: String; // e.g., "ILS RWY 22L"
        }

        part def EnrouteSegment {
            doc /* A waypoint-to-waypoint leg of the en-route portion of a route, as
             * distinct from the published SID/STAR/approach procedures at either end.
             * A route is an ordered sequence of these legs (see FlightPlan::route). */
            attribute fromWaypoint: Common::Position;
            attribute toWaypoint: Common::Position;
            attribute airway: String; // e.g., "J80", "V16"; empty for direct legs
        }
    }

    package FlightOperations {
        doc /* Airline-side planning and operational control of flights. */

        public import ScalarValues::*;

        part def FlightOperationsDomain {
            part airlineOperationsCenter: AirlineOperationsCenter;
            part ticketingSystem: TicketingSystem;
        }

        part def AirlineOperationsCenter {
            doc /* The AOC (FOC in Seamster 2011; AOCC in Clarke 1998): 50-100 operators in
             * various roles (Berry & Pace 2011). The context diagram treats it as ONE node; the
             * roles below exist for the AOC IBD and for §7-§9 responsibility/conflict work.
             * Role boundaries are not always distinct in practice. Munro 2018 finds a dispatcher's
             * workflow "cannot always be neatly divided" into flight planning and flight
             * following, and the same person may cover several of these roles at a smaller
             * carrier. Model them as roles (functions), not as separate people.
             * Which role owns each external link (for the IBD):
             *   crew link (aocToCrew)            -> dispatcher, flightFollower
             *   TFM link (aocTfm)                -> atcCoordinator (single point of contact)
             *   flight plan filing               -> dispatcher (via the flight planning system)
             *   airport/station link (aocAirport)-> loadPlanner, maintenanceController, dispatcher
             *   aircraft datalink                -> flightFollower, maintenanceController */
            part dispatcher: Dispatcher;
            part flightFollower: FlightFollower;
            part atcCoordinator: ATCCoordinator;
            part loadPlanner: LoadPlanner;
            part maintenanceController: MaintenanceController;
            part crewScheduler: CrewScheduler;
            part aircraftRouter: AircraftRouter;
            part dutyManager: AOCDutyManager;
        }

        part def Dispatcher {
            doc /* Aircraft dispatcher (licensed, 14 CFR 65). Plans the flight, builds and signs
             * the dispatch release with the captain (joint operational control, 14 CFR 121.533),
             * and is the AOC's voice to the cockpit (Berry & Pace 2011; Seamster E-1/E-2; Munro 2018). */
        }

        part def FlightFollower {
            doc /* Monitoring-focused role: tracks flights in progress on the situation display
             * (ASD / ADS-B-derived positions, OOOI, ACARS), and flags deviations from plan
             * (Berry & Pace 2011: "monitor/track flight"; widely used but "not nearly as
             * prevalent in the scientific literature as the dispatch role"). The owner's
             * sources call this the radar-focused dispatcher. At many carriers the line
             * dispatcher does it for their own flights (Munro 2018). */
        }

        part def ATCCoordinator {
            doc /* ATC-coordination-focused role: "the singular point-of-contact with ATC"; the
             * dispatcher does not interact directly with ATC except in emergencies (Berry & Pace
             * 2011, p.4). Takes part in ATCSCC hotlines/telcons, TOS/Early Intent, GDP
             * substitutions, diversion recovery; "pushes the company's agenda" (Seamster p.34,
             * pp.45-48). Includes the Manager Tactical ATC role (Berry & Pace Table 1). */
        }

        part def LoadPlanner {
            doc /* Load control: passenger/bag/cargo load, weight and balance, final load
             * closeout sent to the crew (Seamster E-2#20; Munro 2018 "ongoing negotiation" with
             * dispatch over weight). */
        }

        part def MaintenanceController {
            doc /* Maintenance control (MOCC in Clarke 1998): receives aircraft fault reports,
             * manages MEL deferrals, orders line maintenance at the station (Berry & Pace 2011). */
        }

        part def CrewScheduler {
            doc /* Crew scheduling / tracking; legality and reassignment in disruptions (Berry & Pace 2011). */
        }

        part def AircraftRouter {
            doc /* Aircraft routing / tail assignment; swaps and cancellations in disruptions (Berry & Pace 2011). */
        }

        part def AOCDutyManager {
            doc /* Operations manager / AOC duty director: final airline-side call in irregular
             * operations (which flights to cancel, delay, or prioritize; Berry & Pace 2011; Clarke 1998). */
        }

        item def DispatchRelease {
            doc /* The dispatch paperwork ("release package"), signed by dispatcher and captain
             * (14 CFR 121.533 joint operational control). Delivered on paper, EFB or ACARS,
             * typically 60-90 min before domestic departure (Munro 2018). Contents:
             *   1. Dispatch release proper (14 CFR 121.687, domestic/flag): aircraft ID, trip
             *      number, departure / intermediate / destination / alternate airports, type
             *      of operation (IFR/VFR), minimum fuel supply, latest weather reports and
             *      forecasts for destination, intermediate stops and alternates.
             *   2. Operational flight plan (OFP / nav log): route incl. SID/STAR, cruise
             *      altitudes, waypoint-by-waypoint planned times and burn, winds/temps aloft,
             *      cost index, planned ZFW / takeoff / landing weight, fuel breakdown (trip,
             *      reserve, alternate, contingency, taxi, extra/tankered).
             *   3. Weather package: METAR/TAF, SIGMETs/AIRMETs, PIREPs, significant weather charts.
             *   4. NOTAMs for departure, destination, alternates and en route.
             *   5. MEL/CDL items deferred on the aircraft and their operational restrictions.
             *   6. Takeoff/landing performance data (V-speeds, thrust / assumed temperature):
             *      AOC-provided by abstraction (D-009 item 6; some types compute it in the FMS).
             *   7. Load closeout / final W&B (load manifest, 14 CFR 121.693), often a separate,
             *      later ACARS message from load control (Seamster E-2#20).
             *   8. Amendments: an amended release for reroutes, fuel or alternate changes.
             * Evidence: [B] Seamster E-1 (18 rows), E-2; Munro 2018. The 14 CFR 121.687 / 121.693
             * content lists are regulatory pointers, not yet registered sources [C]. */
            attribute plannedFuel: Real;             // lb, release fuel
            attribute minimumFuel: Real;             // lb, 121.687 minimum fuel supply
            attribute plannedBurn: Real;             // lb
            attribute plannedZFW: Real;              // lb
            attribute plannedTakeoffWeight: Real;    // lb
            attribute costIndex: Real;
            attribute alternates: String[*];
            attribute melItems: String[*];
            attribute v1: Real;                      // kt; takeoff performance modeled as AOC-provided
            attribute vR: Real;                      // kt   (abstraction, D-009 item 6)
            attribute v2: Real;                      // kt
            attribute takeoffThrustSetting: String;  // e.g. derate / assumed temperature
        }

        part def TicketingSystem;

        part def FlightPlan {
            attribute flightNumber: String;
            ref part departureAirport: AirportOperations::Airport;
            ref part arrivalAirport: AirportOperations::Airport;
            ref part sid: AirspaceManagement::StandardInstrumentDeparture;
            ref part star: AirspaceManagement::StandardTerminalArrival;
            ref part approach: AirspaceManagement::InstrumentApproachProcedure;
            attribute departureTime: Common::DateTime;
            attribute arrivalTime: Common::DateTime;
            ref part route: AirspaceManagement::EnrouteSegment[*] ordered; // en-route legs, in flown order
        }

        part def Trajectory {
            doc /* A planned or actual trajectory for a flight, as a 4D path through space and time. */
            attribute waypoints: Common::Position[*] ordered; // 4D points (lat/lon/alt + timestamp), in time order
        }

        part def Flight {
            attribute flightNumber: String;
            ref part aircraft: AircraftSystems::Aircraft;
            ref part departureAirport: AirportOperations::Airport;
            ref part arrivalAirport: AirportOperations::Airport;
            ref part trajectory: Trajectory; // Reference to the trajectory for the flight
            attribute departureTime: Common::DateTime;
            attribute arrivalTime: Common::DateTime;
            attribute status: String; // e.g., "Scheduled", "Delayed", "Cancelled"
            ref part route: AirspaceManagement::EnrouteSegment[*] ordered; // En-route legs, in flown order
            attribute phase: String; // e.g., "Preflight", "Takeoff", "Climb", "Cruise", "Descent", "Approach", "Landing", "Taxi", "Parked", "Completed"
            attribute crew: Common::Operator[*]; // Crew members operating the flight
            attribute passengers: Common::Passenger[*]; // Passengers on the flight
            attribute cargo: Common::Cargo[*]; // Cargo items on the flight
            attribute maxTakeoffWeight: Real; // in kilograms
            attribute maxLandingWeight: Real; // in kilograms
        }
    }

    package AirportOperations {
        doc /* Ground-side systems that support aircraft turnaround and passenger/cargo flow at an airport. */

        public import ScalarValues::*;

        part def AirportOperationsDomain {
            part airport: Airport;
        }

        part def Airport {
            attribute name: String;
            attribute icaoCode: String;
            attribute location: Common::Position;
            attribute capacity: Integer; // Maximum number of aircraft the airport can handle at once
            attribute noiseAbatementProcedures: String; // Description of noise abatement procedures

            part runways: Runway[*];
            part gates: Gate[*];
            part apron: Apron;
            part controlTower: ControlTower;
            part weatherStation: WeatherStation;
            part fuelDistributionSystem: FuelDistributionSystem;
            part maintenanceHangar: MaintenanceHangar;
            part passengerTerminal: PassengerTerminal;
            part cargoTerminal: CargoTerminal;
            part airportManagementSystem: AirportManagementSystem;
            part groundHandling: GroundHandling;
            part airfieldLighting: AirfieldLighting;
            part gateAgents: GateAgents;
            part customsAndImmigration: CustomsAndImmigration;
            part securityServices: SecurityServices;
            part parkingAndTransportationServices: ParkingAndTransportationServices;
            part baggageHandlingSystem: BaggageHandlingSystem;
            attribute operators: Common::Operator[*];
        }

        part def Runway {
            attribute length: Real; // in meters
            attribute width: Real; // in meters
            attribute surfaceType: String; // e.g., Asphalt, Concrete
            attribute slope: Real; // in degrees
            attribute lighting: Boolean; // true if runway has lighting
            attribute markings: String; // e.g., "Centerline", "Threshold"
            attribute orientation: Real; // in degrees from North
            attribute isActive: Boolean; // true if runway is currently active
            attribute equipment: String[*]; // e.g., "ILS", "PAPI"
        }

        part def Gate {
            attribute position: Common::Position;
            attribute gateNumber: String;
            attribute type: String; // e.g., "Commercial", "Cargo"
            attribute isActive: Boolean; // true if gate is currently active
        }

        part def Apron {
            doc /* Ramp area — gates, taxi, takeoff & landing movement surface per
             * candidate-systems-inventory.md's "APRON / Control Tower" node (split here
             * since ControlTower is already modeled separately). */
        }

        part def ControlTower {
            attribute position: Common::Position;
            attribute height: Real; // in meters
            attribute communicationEquipment: String[*]; // e.g., "VHF Radio", "Radar"
            attribute isOperational: Boolean; // true if control tower is operational
        }

        part def WeatherStation {
            attribute position: Common::Position;
            attribute sensors: String[*]; // e.g., "Anemometer", "Barometer"
            attribute isOperational: Boolean; // true if weather station is operational
        }

        part def FuelDistributionSystem {
            attribute position: Common::Position;
            attribute fuelTypes: String[*]; // e.g., "Jet A", "Avgas"
            attribute capacity: Real; // in liters
            attribute isOperational: Boolean; // true if fuel distribution system is operational

            part fuelTransferSystem: FuelTransferSystem;
            part tanks: Tank[*];
            part intoPlaneFueler: IntoPlaneFueler;
        }

        part def IntoPlaneFueler {
            doc /* The airport fuel carrier's fueling agent (owner, 2026-09-27). Receives the fuel
             * order, presets and uplifts at the refuel panel, and hands the fuel slip to the crew. */
        }

        item def FuelSlip {
            doc /* The fuel carrier's uplift record: gallons delivered and density, converted to
             * pounds. Goes fueler -> flight deck crew (unrendered caFuelSlip connection); the crew
             * reconciles it against the gauges and the release in PreflightCrossCheck. [C] standard
             * practice, not yet in a registered source. */
            attribute gallonsUplifted: Real;
            attribute density: Real;           // lb/gal
            attribute fuelOnBoardBefore: Real; // lb, as read at the refuel panel
        }

        part def FuelTransferSystem;

        part def Tank;

        part def MaintenanceHangar {
            attribute position: Common::Position;
            attribute capacity: Integer; // Number of aircraft that can be serviced
            attribute equipment: String[*]; // e.g., "Hydraulic Lift", "Tool Set"
            attribute isOperational: Boolean; // true if maintenance hangar is operational
        }

        part def PassengerTerminal {
            attribute position: Common::Position;
            attribute capacity: Integer; // Number of passengers that can be handled
            attribute facilities: String[*]; // e.g., "Check-in Counters", "Security Screening"
            attribute isOperational: Boolean; // true if passenger terminal is operational
        }

        part def CargoTerminal {
            attribute position: Common::Position;
            attribute capacity: Integer; // Number of cargo units that can be handled
            attribute facilities: String[*]; // e.g., "Loading Docks", "Storage Area"
            attribute isOperational: Boolean; // true if cargo terminal is operational
        }

        part def AirportManagementSystem {
            doc /* AMS — candidate-systems-inventory.md's hub node for airport-side
             * information exchange with Ground Handling, Customs and Immigration,
             * Security Services, Parking and Transportation Services, and Baggage
             * Handling System. See knowledge/models/interface-exchange-draft.md for the
             * draft exchange map once interface modeling starts (to-do-list.md §10). */
        }

        part def GroundHandling {
            doc /* Ramp services at the gate. Performed by the airline's station staff or a
             * contracted handler, depending on the airport; modeled under Airport as an
             * abstraction (D-009: these sub-parts carry out decisions made on other links). */
            part pushbackCrew: PushbackCrew;
            part marshaller: Marshaller;
            part catering: CateringService;
            part deicing: DeicingService;
            part lavAndWaterService: LavAndWaterService;
        }

        part def PushbackCrew {
            doc /* Tug driver (on headset) and wing walkers. Coordinates push, brake set/release
             * and engine start with the flight deck over the ground interphone, and relays
             * nothing to ATC: the captain obtains the push/movement approval and relays it
             * (Wilke 2014; Seamster E-3#05-13). */
        }

        part def Marshaller {
            doc /* Ramp agent who marshals the aircraft onto the stand with hand/wand signals
             * where no docking guidance is used (Seamster E-13#10-13). [B/C] */
        }

        part def CateringService;
        part def DeicingService {
            doc /* De-/anti-icing crew (at the gate or a de-icing pad). The crew requests it and
             * receives fluid type / holdover start time. [C] */
        }
        part def LavAndWaterService;

        part def AirfieldLighting {
            doc /* Runway/taxiway edge and centerline lights, stop bars, signs, and markings.
             * Owned and maintained by the airport operator at certificated airports
             * (14 CFR 139.311, not registered [C]); OPERATED from the tower, which runs the
             * remote lighting controls (BB 3-4-2..3-4-15, [A]). Approach lighting systems are often
             * FAA-owned; the model does not split them out. Navaids (ILS, VOR, DME) are NOT
             * here: they are Infrastructure (D-007), mostly FAA-owned (NAS roadmaps). */
        }

        part def GateAgents {
            doc /* Gate / customer-service agents. In US practice usually the airline's station
             * employees (or a contracted handler), not airport staff; modeled at the airport
             * because they work the airport's gate and the airline station is not a separate
             * part (abstraction, 2026-09-27). Boarding, final passenger count, door closure,
             * standby/rebooking; the main passenger-facing role on the ground. Friction with
             * dispatch over late passengers (Munro 2018). */
        }

        part def CustomsAndImmigration;

        part def SecurityServices;

        part def ParkingAndTransportationServices;

        part def BaggageHandlingSystem;
    }

    package AircraftSystems {
        doc /* Onboard systems that turn intent/clearances into executable aircraft behavior. */

        public import ScalarValues::*;

        part def AircraftSystemsDomain {
            part aircraft: Aircraft;
        }

        part def Aircraft {
            attribute registrationNumber: String;
            attribute type: String; // e.g., "Commercial", "Private", "Cargo"
            attribute manufacturer: String;
            attribute model: String;
            attribute yearOfManufacture: Integer;
            attribute engineType: String; // e.g., "Turbofan", "Piston"
            attribute numberOfEngines: Integer;
            attribute engineModel: String;
            attribute capacity: Integer; // Number of passengers or cargo units
            attribute range: Real; // in kilometers
            attribute fuelCapacity: Real; // in liters
            attribute currentPosition: Common::Position;
            attribute status: String; // e.g., "On Ground", "In Flight", "Maintenance"
            attribute flightState: AircraftState; // "state" is a reserved SysML keyword

            part flightManagementSystem: FlightManagementSystem;
            part flightControlSystem: FlightControlSystem;
            part pitotStaticSystem: PitotStaticSystem;
            part fuelSystem: FuelSystem;
            part navigationSystem: NavigationSystem;
            part guidanceSystem: GuidanceSystem;
            part surveillanceSystem: SurveillanceSystem;
            part communicationSystem: CommunicationSystem;
            part radar: Radar;
        }

        attribute def AircraftState {
            doc /* Dynamic flight-state snapshot — separated from Aircraft's static
             * attributes so instantaneous state (position, energy, configuration) can be
             * sampled/updated independently. */
            attribute altitude: Real; // in meters
            attribute speed: Real; // in meters per second
            attribute heading: Real; // in degrees from North
            attribute pitch: Real; // in degrees
            attribute roll: Real; // in degrees
            attribute yaw: Real; // in degrees
            attribute position: Common::Position; // Current position of the aircraft
            attribute fuelOnBoard: Real; // in liters
            attribute zeroFuelWeight: Real; // in kilograms
            attribute grossWeight: Real; // in kilograms
            attribute isEngineOn: Boolean;
            attribute isLandingGearDeployed: Boolean;
            attribute isFlapsExtended: Boolean;
            attribute isAutopilotEngaged: Boolean;
            attribute isNavigationLightsOn: Boolean;
            attribute isStrobeLightsOn: Boolean;
            attribute isBeaconLightOn: Boolean;
            attribute isFuelPumpOn: Boolean;
            attribute isHydraulicSystemActive: Boolean;
        }

        part def FlightManagementSystem {
            doc /* Turns the crew-entered plan into lateral/vertical guidance and performance
             * predictions. Pilot <-> FMS interdependency (owner, 2026-09-27; [SME], see the
             * crewAircraft connection): on most modern transport aircraft the FMS cannot fly
             * the aircraft without pilot action. The crew must initialize it (route, perf data:
             * ZFW, fuel, cost index, cruise altitude, winds), arm and engage the automation
             * (LNAV/VNAV, autopilot, autothrottle), set MCP/FCU targets (speed, altitude,
             * heading) that bound what the FMS may do (e.g. it will not climb/descend past the
             * MCP altitude), manage thrust where the autothrottle is not engaged, and
             * configure the aircraft (flaps, gear, speedbrakes). The FMS proposes; the crew
             * authorizes and executes. Recorded, not modeled in detail (not a project focus). */
        }

        item def FmsPerformancePrediction {
            doc /* FMS-computed values from the crew-entered ZFW, fuel, cost index and winds;
             * checked by the crew against the release in PreflightCrossCheck. */
            attribute predictedFuelAtDestination: Real; // lb
            attribute predictedGrossWeight: Real;       // lb
            attribute optimumAltitude: Real;            // ft
            attribute predictedArrivalTime: Common::DateTime;
        }

        part def CommunicationSystem {
            doc /* Air-ground communication equipment, split by the kind of exchange it carries.
             * "Datalink" alone is ambiguous (owner, 2026-09-27), so the connections name the
             * counterpart and the function, and this def names the equipment:
             *   VHF/HF voice                 -> ATC and AOC voice (via the crew)
             *   CMU / ACARS (VHF, Satcom)    -> AOC messages (OOOI, maintenance, W&B, free text)
             *                                   AND ATS datalink: PDC, D-ATIS, FANS 1/A CPDLC (Data Comm DCL / en route)
             *   Surveillance (not comms)     -> transponder Mode S / ADS-B Out, in SurveillanceSystem
             * [C/SME]; BB confirms ADS-B carries the ATC-assigned beacon code (5-2-1 NOTE) and
             * that CPDLC/ADS-C are datalink services (8-1-6). */
            part vhfRadio: VHFRadio;
            part communicationsManagementUnit: CommunicationsManagementUnit;
            part satcom: Satcom;
        }

        part def VHFRadio;
        part def CommunicationsManagementUnit {
            doc /* Routes ACARS messages over VHF (VDL) or Satcom. Hosts or links the AOC
             * applications and the ATS datalink applications (PDC, D-ATIS, CPDLC). CPDLC route
             * clearances can be loaded into the FMS, but only after the crew accepts them. */
        }
        part def Satcom;

        part def FlightControlSystem {
            part autoFlightControlSystem: AutoFlightControlSystem;
            part primaryFCS: PrimaryFCS;
            part reversionaryFCS: ReversionaryFCS;
        }

        part def AutoFlightControlSystem;
        part def PrimaryFCS;
        part def ReversionaryFCS;

        part def PitotStaticSystem;

        part def FuelSystem {
            doc /* Tanks, fuel transfer system, fuel quantity processing, fire retardant
             * system, etc. per candidate-systems-inventory.md — not yet broken into
             * sub-parts pending verification of that grouping. */
        }

        part def NavigationSystem {
            doc /* Grouping under Aircraft (rather than nested in FlightManagementSystem)
             * is candidate-systems-inventory.md's own "(inferred grouping)" call —
             * unverified against the source diagram. */
        }

        part def GuidanceSystem;

        part def SurveillanceSystem {
            doc /* What makes the aircraft visible to ATC and to other aircraft. */
            part transponder: Transponder;
            part tcas: TCAS;
        }

        part def Transponder {
            doc /* Mode S transponder with ADS-B Out. Replies to secondary-radar interrogation
             * with the ATC-assigned beacon code (Mode 3/A) and pressure altitude (Mode C), and
             * broadcasts ADS-B Out; "Aircraft equipped with ADS-B are also still required to
             * have an operable transponder. The ATC-assigned beacon code is one of the required
             * message elements of ADS-B Out" (BB 5-2-1a NOTE). Crew sets code, IDENT,
             * standby/normal, altitude reporting on ATC instruction (BB 5-2-10, 5-2-18, 5-3-3). */
            attribute beaconCode: String;
            attribute altitudeReporting: Boolean;
        }

        part def TCAS {
            doc /* Generates resolution advisories on board; the controller must not issue
             * instructions contrary to an RA (BB 2-1-28). */
        }

        part def Radar {
            doc /* Airborne weather radar (not ATC surveillance). */
        }

        // NOTE: candidate-systems-inventory.md's "generic Functional Decomposition
        // example" (Mission System, Weapons System, Propulsion System, Airframe,
        // Vehicle Network, Entertainment System) is intentionally NOT modeled here —
        // the source itself frames it as a generic vehicle-decomposition teaching
        // example, not NAS-specific content, and Weapons/Mission System are
        // military-aircraft-specific and outside the ratified SOI boundary (D-007
        // treats Military as a boundary actor). See knowledge/questions/open-questions.md.
    }

    package FlightCrew {
        doc /* Modeled System per D-007: "Crew have independent execution authority
         * and handle information between operational intent, clearances, guidance,
         * and aircraft behavior." Absent from the pre-ratification first pass;
         * added here 2026-09-22 to close that gap. Role split (Captain/First
         * Officer authority, Remote Pilot, whether Cabin Crew belongs here as the
         * flight-crew/passenger interface) is not yet resolved against the
         * Seamster crosswalk open question — modeled minimally (pilot roles only)
         * pending that decision; see knowledge/questions/open-questions.md.
         * 2026-09-27 (D-009): Captain/FO grouped as FlightDeckCrew, the single element
         * external systems connect to; Cabin Crew stays in this domain but is absorbed
         * at context level (no authority over in-scope decisions).
         */

        public import ScalarValues::*;

        part def FlightCrewDomain {
            part flightDeckCrew: FlightDeckCrew;
            part cabinCrew: CabinCrew;
        }

        part def FlightDeckCrew {
            doc /* The two-pilot flight deck as ONE element (D-009, 2026-09-27). Under D-007's
             * test, the captain and first officer do not hold separate decision authority:
             * final authority attaches to the captain as pilot in command (14 CFR 91.3), and
             * flying/monitoring duties swap between the two. So external systems (AOC, ATC,
             * airport, aircraft) connect here, not to either pilot. The roles stay as sub-parts
             * for IBD/behavior work where the split matters (e.g. the FO working the radio,
             * Seamster E-2#07, E-4#02-04).
             * Naming (D-010): Captain / First Officer throughout. "PIC" only where the text is
             * about legal authority (14 CFR 91.3); PF/PM and PNF are not used in the model. */
            part captain: Captain;
            part firstOfficer: FirstOfficer;
            perform action preflightCrossCheck: PreflightCrossCheck;
        }

        part def Captain {
            doc /* Normally the pilot in command: final authority over the aircraft (14 CFR 91.3);
             * signs the dispatch release with the dispatcher (14 CFR 121.533). */
            attribute name: String;
        }

        part def FirstOfficer {
            attribute name: String;
        }

        part def CabinCrew {
            doc /* Flight attendants. The primary interface to the passengers and the
             * intermediary between passengers and the flight deck (owner, 2026-09-27): cabin
             * secure / ready for departure, passenger medical, security and disruptive-passenger
             * events (which can trigger a diversion), and turbulence / phase-of-flight
             * information passed back to passengers. They handle passenger satisfaction more
             * directly than anyone except the gate agents. D-009 keeps them absorbed at context
             * level (no authority over in-scope decisions), but they are the natural place for
             * the "passenger value" measure in §7-§9 (D-007 test criterion). [C] */
            attribute names: String[*]; // List of cabin crew members
        }

        item def PreflightCrossCheckResult {
            doc /* What goes crew -> AOC: accepted, or a discrepancy needing an amended release. */
            attribute fuelOnBoard: Real;       // lb, from gauges, reconciled against the fuel slip
            attribute accepted: Boolean;
            attribute discrepancy: String;     // e.g. "fuel", "weight", "performance limit"
        }

        action def PreflightCrossCheck {
            doc /* Owner intent 2026-09-27; [B] for the release and fuel-on-board report
             * (Seamster E-7#08-09, E-9#06-09; Munro 2018), [C] for the cross-check itself. The
             * crew compares the release with what the FMS predicts and with the fuel actually
             * loaded (slip + gauges); only the outcome goes back to the AOC. Happens inside the
             * crew, so it is an action, not a link. Tolerances deferred until a model needs them
             * (owner, 2026-09-27). */
            in release: FlightOperations::DispatchRelease;                 // via aocToCrew
            in fuelSlip: AirportOperations::FuelSlip;                      // via caFuelSlip (unrendered)
            in fmsPrediction: AircraftSystems::FmsPerformancePrediction;   // via crewAircraft
            in gaugeFuel: Real;                                            // lb, FQIS, via crewAircraft
            out result: PreflightCrossCheckResult;                         // to AOC via aocToCrew
        }
    }

    package Governance {
        doc /* Boundary Actor per D-007: "Sets the rules and societal/environmental
         * policy context. Held fixed in the baseline; regulatory sensitivity
         * sweeps are optional." The pre-ratification first pass nested a
         * FederalAviationAdministration constituent system here; removed 2026-09-22
         * per system_of_interest_definition.md's exclusion of regulators from
         * internal decomposition — Governance is now a single opaque actor. */

        public import ScalarValues::*;

        part def GovernanceDomain {
            attribute name: String; // e.g., "FAA" — the SOI's regulatory context
        }
    }

    package Passengers {
        doc /* Boundary Actor per D-007: demand, willingness to pay, passenger mix,
         * and time sensitivity influence airline decisions about fares, frequency,
         * aircraft assignment, connections, and delay/rerouting tradeoffs;
         * passengers do not directly set fares or aircraft speed. Not decomposed
         * further — distinct from Common::Passenger, which is a per-flight
         * manifest attribute (a seat assignment on a specific Flight), not this
         * actor role. New 2026-09-22; absent from the pre-ratification first
         * pass. */

        part def PassengersDomain;
    }

    package Military {
        doc /* Boundary Actor per D-007: outside the modeled operator population;
         * military traffic and special-use airspace enter as external scenario
         * conditions only when civil KPIs require them. New 2026-09-22; absent
         * from the pre-ratification first pass. */

        part def MilitaryDomain;
    }

    package Infrastructure {
        doc /* Context Constraint per D-007 ("Infrastructure / Airspace
         * Resources"): airspace structure, navigation infrastructure, and shared
         * resources are external baseline constraints, with optional
         * parameterized sensitivity analysis. Consolidates the pre-ratification
         * Infrastructure and AirspaceResources packages 2026-09-22 — D-007 treats
         * them as a single row — and drops the internal decomposition;
         * SatelliteSystem/WeatherService are kept as named constraints, not
         * modeled as decision-lever systems. Maintenance Suppliers (also a
         * Context Constraint row per D-007) is not represented here — no
         * candidate-systems-inventory entry to anchor it to yet; flagged in
         * knowledge/questions/open-questions.md. */

        part def InfrastructureDomain {
            part satelliteSystem: SatelliteSystem;
            part weatherService: WeatherService;
        }

        part def SatelliteSystem {
            doc /* Comm/nav/weather satellite infrastructure — external constraint,
             * not a decision lever, per D-007. */
        }

        part def WeatherService;

        item def WeatherConditions {
            doc /* The actual state of the atmosphere (wind, visibility, ceiling, precipitation,
             * convection), as opposed to the reports and forecasts WeatherService produces
             * about it. Exogenous: the SoI has to operate within it and cannot change it, so
             * it enters behaviors as an input, not as a decision lever (D-007). */
        }
    }

    package InformationServices {
        doc /* Absorbed / Abstracted per D-007: "Information is modeled as
         * exchanges; specific channels are included only when reliability,
         * latency, or capability changes a decision or KPI." Kept as a single
         * opaque SWIM placeholder pending that trigger — see the Environment
         * part def's doc comment for the open question on whether this package
         * belongs in Environment at all. */

        part def InformationServicesDomain {
            part swim: SWIM;
        }

        part def SWIM {
            doc /* System Wide Information Management — candidate-systems-inventory.md's
             * "Information Exchange Systems" top-level node, instantiated as SWIM. */
        }
    }

    package DecisionSupport {
        doc /* Absorbed / Abstracted per D-007: "Decision-support capability is
         * allocated to operator or ATM contexts; recommendations and information
         * dependencies remain modelable." Per this project's own framing (index.md
         * working assumptions) and candidate-systems-inventory.md's explicit gap
         * note, decision-support/optimization is a capability layered on top of
         * the architecture, not a physical NAS system — which is why the vehicle
         * dynamics model below is not under AircraftSystems: it's a simulation/
         * analysis capability that reads and predicts Aircraft state, not a
         * constituent onboard system. See the Environment part def's doc comment
         * for the open question on whether this package belongs in Environment at
         * all, given it feeds §12-§13 traceability rather than acting as an
         * external actor. */

        public import ScalarValues::*;

        part def DecisionSupportDomain {
            part vehicleDynamicsModel: VehicleDynamicsModel;
        }

        part def VehicleDynamicsModel {
            doc /* Interface only — see workflows/vehicle-simulation-model.md. The real
             * physics is implemented in Python at
             * projects/nas-sos-capstone/simulation/vehicle_dynamics.py
             * (function step_dynamics), not embedded here: SysML v2's opaque
             * `calc def` external-language bodies run through Jython in specific
             * commercial tools, not CPython/numpy, so this project keeps the model and
             * the interface separate and traces between them by hand. Field names on
             * both sides are kept identical to AircraftSystems::AircraftState's
             * attributes so the correspondence needs no translation. */

            calc def StepDynamics {
                in state: AircraftSystems::AircraftState;
                in controlHeading: Real; // commanded heading, degrees from North
                in controlSpeed: Real; // commanded airspeed, meters per second
                in controlClimbRate: Real; // commanded climb rate, meters per second
                in dt: Real; // timestep, seconds
                return nextState: AircraftSystems::AircraftState;
            }
        }
    }
}
