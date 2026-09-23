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

        connect flightOps.airlineOperationsCenter to flightCrew.pilotInCommand;
        connect flightOps.airlineOperationsCenter to flightCrew.firstOfficer;  

        connect airportOps.airport to aircraftSys.aircraft;




    }
}