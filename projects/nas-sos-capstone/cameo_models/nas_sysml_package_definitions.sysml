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
            part trafficFlowMonitoringCenter: TrafficFlowMonitoringCenter;
            part atfms: AirTrafficFlowManagementSystem;
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

        part def TrafficFlowMonitoringCenter;

        part def AirTrafficFlowManagementSystem {
            part timeBasedFlowManagement: TimeBasedFlowManagement;
        }

        part def TimeBasedFlowManagement {
            doc /* FAA Time-Based Flow Management. AMAN and ETFMS from the source inventory
             * are left out: AMAN was itself marked uncertain on the source diagram, and
             * ETFMS reads as a EUROCONTROL system rather than a NAS one — both need
             * verification before being added. */
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
             * distinct from the published SID/STAR/approach procedures at either end. */
            attribute waypoints: Common::Position[*];
        }
    }

    package FlightOperations {
        doc /* Airline-side planning and operational control of flights. */

        public import ScalarValues::*;

        part def FlightOperationsDomain {
            part airlineOperationsCenter: AirlineOperationsCenter;
            part ticketingSystem: TicketingSystem;
        }

        part def AirlineOperationsCenter;

        part def TicketingSystem;

        part def Flight {
            attribute flightNumber: String;
            ref part aircraft: AircraftSystems::Aircraft;
            ref part departureAirport: AirportOperations::Airport;
            ref part arrivalAirport: AirportOperations::Airport;
            attribute departureTime: Common::DateTime;
            attribute arrivalTime: Common::DateTime;
            attribute status: String; // e.g., "Scheduled", "Delayed", "Cancelled"
            attribute route: Common::Position[*]; // Waypoints for the flight path
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

        part def GroundHandling;

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

        part def FlightManagementSystem;

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
        part def SurveillanceSystem;
        part def Radar;

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
         */

        public import ScalarValues::*;

        part def FlightCrewDomain {
            part pilotInCommand: PilotInCommand;
            part firstOfficer: FirstOfficer;
        }

        part def PilotInCommand {
            doc /* Final execution authority over the aircraft (14 CFR 91.3). */
            attribute name: String;
        }

        part def FirstOfficer {
            attribute name: String;
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
