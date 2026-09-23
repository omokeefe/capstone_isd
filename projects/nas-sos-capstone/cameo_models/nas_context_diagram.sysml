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
        //     - 
        //     - working according to the rules established by the environment domain.


    }
}