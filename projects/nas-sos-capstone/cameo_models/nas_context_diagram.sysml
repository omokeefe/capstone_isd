package ContextDiagram {
    doc /* Context diagram for the NAS SOS Capstone project, 
    * showing the system of interest (SoI), its actors, the
    * external entities, and the exchanges between them.

    * The SoI is composed of the modeled system (Flight Ops) 
    * and the context constraints (Maintenance Suppliers, 
    * Infra / Airspace Resources). The SoI is influenced 
    * by the boundary actors (Governance, Passengers, Military) 
    * and the absorbed/abstracted systems (Info Systems, Decision 
    * Support).

  
     */

    part def NASContextDiagram {    
        public import ScalarValues::*;
        public import NationalAirspaceSystem::AirportOperations::*;
        public import NationalAirspaceSystem::AirspaceManagement::*;
        public import NationalAirspaceSystem::AircraftSystems::*;
        public import NationalAirspaceSystem::FlightOperations::*;
        public import NationalAirspaceSystem::FlightCrew::*;
        public import NationalAirspaceSystem::Common::*;
        public import NationalAirspaceSystem::Environment::*;

        part environment: EnvironmentDomain;
        part airportOps: AirportOperationsDomain;
        part airspaceMgmt: AirspaceManagementDomain;    
        part aircraftSys: AircraftSystemsDomain;
        part flightOps: FlightOperationsDomain;
        part flightCrew: FlightCrewDomain;

        // Testing different connections
        connect flightOps.airlineOperationsCenter to flightCrew.pilotInCommand;
        connect flightOps.airlineOperationsCenter to flightCrew.firstOfficer;  

        connect airportOps.airport to aircraftSys.aircraft;


        // Theorize what we want to connect up here.
        // The ATM consists of:
        //  - The aircraft:
        //     - flying from airport to airport, 
        //     - controlled by the flight crew, 
        //     - observed by the airline operations center,
        //     - observed by the airspace management domain
        //     - interacting with the environment domain (weather, terrain, etc.)
        //     - operated by the Flight Operations domain,
        //     - certified according to the rules established by the environment domain.
        //  - The flight crew: 
        //     - supported by the flight operations (e.g. airline operations center), 
        //     - interacting with the aircraft systems domain,
        //     - interacting with the airspace management domain,
        //     - interacting with the airport operations domain,
        //     - working according to the rules established by the environment domain.
        //  - The flight operations domain:
        //     - supporting one to many flight crews,
        //     - receiving data from the aircraft systems domain,
        //     - communicating with the airspace management domain,
        //     - communicating with the airport operations domain.
        //     - working according to the rules established by the environment domain.
        //  - The airport operations domain:
        //     - communicating with the flight operations domain,
        //     - communicating with the airspace management domain,
        //     - sending data to the aircraft systems domain,
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.
        //  - The airspace management domain:
        //     - communicating with the flight operations domain,
        //     - communicating with the airport operations domain,
        //     - sending data to the aircraft systems domain,
        //     - communicating with the flight crew,
        //     - working according to the rules established by the environment domain.

        // I need to connect only the relationships that actually matter operationally, 
        // not every domain to every other domain.

        // Core operational coordination        
        connect flightOps.airlineOperationsCenter to flightCrew.pilotInCommand;
        connect flightOps.airlineOperationsCenter to flightCrew.firstOfficer;

        // Flight Ops to operational environment
        connect flightOps.airlineOperationsCenter to airspaceMgmt.atc;
        connect flightOps.airlineOperationsCenter to airportOps.airport;

        // Airspace control / clearance interactions
        connect airspaceMgmt.atc to flightCrew.pilotInCommand;
        connect airspaceMgmt.atc to aircraftSys.aircraft;

        // Crew-to-aircraft execution
        connect flightCrew.pilotInCommand to aircraftSys.aircraft;
        connect flightCrew.firstOfficer to aircraftSys.aircraft;

        // Airport interactions
        connect flightCrew.pilotInCommand to airportOps.airport;
        connect flightCrew.firstOfficer to airportOps.airport;
        connect aircraftSys.aircraft to airportOps.airport;

        // Mutual airport/airspace coordination
        connect airportOps.airport to airspaceMgmt.atc;


    }
}