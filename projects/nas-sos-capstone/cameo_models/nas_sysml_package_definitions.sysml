package NationalAirspaceSystem {
    doc /*
     * System of Interest: the National Airspace System (NAS), modeled as a System
     * of Systems. Domain decomposition follows decisions/decisions-log.md D-002
     * (Governance, Airspace Management, Airspace Resources, Flight Operations,
     * Airport Operations, Aircraft Systems, Information Services, Infrastructure,
     * Decision Support) — provisional, revisit at to-do-list.md §6.
     *
     * Constituent systems below are drawn from
     * knowledge/models/candidate-systems-inventory.md and filtered to the
     * provisional SOI boundary in knowledge/questions/open-questions.md: general
     * aviation, military airspace (beyond its PESTLE/objective role), and
     * international/foreign-authority systems are intentionally NOT populated yet.
     * Specifically excluded here pending a boundary decision: ICAO, EASA, CAAC
     * (non-US regulators), Ground/Maritime Transport System (sibling systems, not
     * NAS constituents), the generic military "Weapons/Mission System" decomposition
     * example, and inventory items the source itself couldn't confirm (ETFMS reads
     * as EUROCONTROL-specific rather than NAS; GMTOs/ANSPs as named are generic
     * international terms rather than confirmed NAS entities) — see
     * knowledge/models/candidate-systems-inventory.md for the caveats.
     *
     * DRAFT: authored directly in SysML v2 textual notation, not yet reconciled
     * into a Cameo model. Cameo remains the source of truth per
     * workflows/update-architecture.md; this file is the input to bring in once
     * Cameo modeling starts on this project.
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

    // The System of Interest itself: the NAS as a composition of its constituent domains.
    part def NationalAirspaceSystem {
        part governance: Governance::GovernanceDomain;
        part airspaceManagement: AirspaceManagement::AirspaceManagementDomain;
        part airspaceResources: AirspaceResources::AirspaceResourcesDomain;
        part flightOperations: FlightOperations::FlightOperationsDomain;
        part airportOperations: AirportOperations::AirportOperationsDomain;
        part aircraftSystems: AircraftSystems::AircraftSystemsDomain;
        part informationServices: InformationServices::InformationServicesDomain;
        part infrastructure: Infrastructure::InfrastructureDomain;
        part decisionSupport: DecisionSupport::DecisionSupportDomain;
    }

    package Governance {
        doc /* Rule-making and regulatory authority over the NAS. */

        public import ScalarValues::*;

        part def GovernanceDomain {
            part faa: FederalAviationAdministration;
        }

        part def FederalAviationAdministration {
            doc /* The US regulatory authority for the NAS. Candidate-systems-inventory's
             * generic "Regulatory System" node, instantiated to the FAA since the SOI is
             * the US NAS; EASA/CAAC (other instances of the same generic pattern) are
             * out of scope. */
            attribute name: String;
        }
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

    package AirspaceResources {
        doc /* No constituent systems identified yet. Candidate-systems-inventory.md's
         * "Satellite System" (comm/nav/wx) is infrastructure shared across domains and is
         * modeled under Infrastructure instead; nothing else in the source maps cleanly
         * to airspace-sector/route/altitude resources as a *system*. Flagged, not
         * silently populated — see knowledge/questions/open-questions.md. */

        part def AirspaceResourcesDomain;
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
        // military-aircraft-specific and outside the provisional SOI boundary. See
        // knowledge/questions/open-questions.md.
    }

    package InformationServices {
        doc /* NAS-wide information exchange between domains. */

        part def InformationServicesDomain {
            part swim: SWIM;
        }

        part def SWIM {
            doc /* System Wide Information Management — candidate-systems-inventory.md's
             * "Information Exchange Systems" top-level node, instantiated as SWIM. */
        }
    }

    package Infrastructure {
        doc /* Physical infrastructure shared across domains (comm, nav, weather). */

        part def InfrastructureDomain {
            part satelliteSystem: SatelliteSystem;
            part weatherService: WeatherService;
        }

        part def SatelliteSystem {
            doc /* Comm/nav/weather satellite infrastructure, shared across Airspace
             * Management and Aircraft Systems per candidate-systems-inventory.md. */
        }

        part def WeatherService;
    }

    package DecisionSupport {
        doc /* Per this project's own framing (index.md working assumptions) and
         * candidate-systems-inventory.md's explicit gap note, decision-support/
         * optimization is a capability layered on top of the architecture, not a
         * physical NAS system — which is why the vehicle dynamics model below lives
         * here rather than under AircraftSystems: it's a simulation/analysis
         * capability that reads and predicts Aircraft state, not a constituent onboard
         * system. */

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
