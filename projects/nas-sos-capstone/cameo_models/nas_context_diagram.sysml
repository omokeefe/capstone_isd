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

    metadata def ContextVisible {
        doc /* Tag for elements the context view (MyViews::systemContext) should render.
         * Apply as a prefix: #ContextVisible part ... / #ContextVisible connect ... */
    }

    part def NASContextDiagram {
        public import ScalarValues::*;
        public import NationalAirspaceSystem::AirportOperations::*;
        public import NationalAirspaceSystem::AirspaceManagement::*;
        public import NationalAirspaceSystem::AircraftSystems::*;
        public import NationalAirspaceSystem::FlightOperations::*;
        public import NationalAirspaceSystem::FlightCrew::*;
        public import NationalAirspaceSystem::Common::*;
        public import NationalAirspaceSystem::Environment::*;

        // #ContextVisible marks what the context view renders. Nested parts are
        // redefined (:>>) only so they can carry the tag; their types are unchanged.
        part environment: EnvironmentDomain;
        #ContextVisible part airportOps: AirportOperationsDomain {
            #ContextVisible part :>> airport;
        }
        #ContextVisible part airspaceMgmt: AirspaceManagementDomain {
            #ContextVisible part :>> atc;
        }
        #ContextVisible part aircraftSys: AircraftSystemsDomain {
            #ContextVisible part :>> aircraft;
        }
        #ContextVisible part flightOps: FlightOperationsDomain {
            #ContextVisible part :>> airlineOperationsCenter;
        }
        #ContextVisible part flightCrew: FlightCrewDomain {
            #ContextVisible part :>> pilotInCommand;
            #ContextVisible part :>> firstOfficer;
            #ContextVisible part :>> cabinCrew;
        }

        // Theorize what we want to connect up here.
        // The ATM consists of:
        //  - The aircraft:
        //     - flying from airport to airport, creating 4D points that form a trajectory,
        //     - controlled by the flight crew, physical interactions 
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
        #ContextVisible connect flightOps.airlineOperationsCenter to flightCrew.pilotInCommand;
        #ContextVisible connect flightOps.airlineOperationsCenter to flightCrew.firstOfficer;

        // Flight Ops to operational environment
        #ContextVisible connect flightOps.airlineOperationsCenter to airspaceMgmt.atc;
        #ContextVisible connect flightOps.airlineOperationsCenter to airportOps.airport;

        // Airspace control / clearance interactions
        #ContextVisible connect airspaceMgmt.atc to flightCrew.pilotInCommand;
        #ContextVisible connect airspaceMgmt.atc to aircraftSys.aircraft;

        // Crew-to-aircraft execution
        #ContextVisible connect flightCrew.pilotInCommand to aircraftSys.aircraft;
        #ContextVisible connect flightCrew.firstOfficer to aircraftSys.aircraft;

        // Airport interactions
        #ContextVisible connect flightCrew.pilotInCommand to airportOps.airport;
        #ContextVisible connect flightCrew.firstOfficer to airportOps.airport;
        #ContextVisible connect aircraftSys.aircraft to airportOps.airport;

        // Mutual airport/airspace coordination
        #ContextVisible connect airportOps.airport to airspaceMgmt.atc;

        
        // Core operational coordination  - AOC to Crew
		//   - Recommended fuel loading & anticipated passenger load
        //   - Flight plan & route info (SID/STAR, altitudes, waypoints, etc.)
        //   - Weather & NOTAM info
        //   - 
        
        // Core operational coordination  - Crew to AOC 
        //   - Final Passenger & Fuel Load
        //   - Aircraft Configuration & Performance Data
        //   - Aircraft Status & Maintenance Needs
		//   - Equipment Malfunctions & Emergencies
		//   - Pilot Reports (PIREPs)
		//   - Route Modification Needs
		
        // Core operational coordination  - ATC to Crew
		//   - radio comms hand-offs & transfer info
		//   - traffic advisories
		//   - request responses/clearances
		//   - ATIS info
		//   - Coordinate airport lighting to communicate to pilots statuses & preferrences
		//   - Estimated Departure Clearance Times (EDCTs)
		
        // Core operational coordination  - Crew to ATC
		//   - Intent & Requests
		//   - Equipment Malfunctions & Emergencies
		//   - Pilot Reports (PIREPs)
		//   - Comms Establishing at departure and in response to transfer

        // Core operational coordination  - ATC to AOC (ATSCC -> Flight Ops)
        //   - Traffic Advisories
        //   - Estimated Departure Clearance Times (EDCTs)
        //   - Adverse Flight Condition Advisories (weather, equipment, etc.)

        // Core operational coordination  - AOC to ATC
        //   - Flight Plan & Route Info (SID/STAR, altitudes, waypoints, etc.)
        //   - Proposed route modifications
        //   - 

        // ATC to Airport Operations
        //   - Runway & Taxiway Status to drive Lights & Signage

        // Airport Operations to Crew
        //   - Runway & Taxiway Status via Lights

        // No exchanges between aircraftsys and airportops, assuming its all visual indicators and not data exchanges.

        // Aircraft Systems to Crew
        //   - Aircraft & Engine Status
        //   - Fuel Status
        //   - Navigation & Avionics Status
        //   - Equipment Malfunctions & Emergencies
        //   - Position & Trajectory Info (via FMS)
        //   - Recommended Aircraft Control (via FMS: speed, altitude, heading, etc.)


		
		// Inter-ATC Connections
		//   - ATSCC to TMU: 
        //     - Actuals??? NEED TO DETERMINE WHAT IS ACTUALLY EXCHANGED HERE
		//   - TMU to ATSCC:
        //      - Time-based flow management info (EDCTs, etc.) 

    }
}