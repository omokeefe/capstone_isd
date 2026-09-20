package Scenarios {
    doc /* Illustrative scenario exercising the instance-level modeling pattern from
     * workflows/sysml-instance-modeling.md end to end: two airports, a departure/
     * approach procedure, an aircraft, and a flight referencing all of them.
     *
     * NOT tied to a decided ConOps scenario. The Hub-to-Hub CONOPS's real city pair is
     * still open per knowledge/models/conops-hub-to-hub-trajectory-cost.md — ORD/JFK
     * here are placeholders chosen only to demonstrate the pattern, not to prejudge
     * that decision.
     */

    public import ScalarValues::*;
    public import NationalAirspaceSystem::AirportOperations::*;
    public import NationalAirspaceSystem::AirspaceManagement::*;
    public import NationalAirspaceSystem::AircraftSystems::*;
    public import NationalAirspaceSystem::FlightOperations::*;
    public import NationalAirspaceSystem::Common::*;

    part ord: Airport {
        name = "Chicago O'Hare International Airport";
        icaoCode = "KORD";
    }

    part jfk: Airport {
        name = "John F. Kennedy International Airport";
        icaoCode = "KJFK";
    }

    part benky4: StandardInstrumentDeparture {
        doc /* Placeholder name — not verified against a real published SID. */
        airport = ord;
        name = "BENKY4";
    }

    part ilsRwy22L: InstrumentApproachProcedure {
        doc /* Placeholder name — not verified against a real published approach. */
        airport = jfk;
        name = "ILS RWY 22L";
    }

    part exampleAircraft: Aircraft {
        doc /* flightState is this aircraft's initial condition for a simulation run —
         * see projects/nas-sos-capstone/simulation/vehicle_dynamics.step_dynamics, which
         * takes a dict shaped exactly like this attribute, per
         * workflows/vehicle-simulation-model.md. */
        registrationNumber = "N12345";
        type = "Commercial";
        manufacturer = "Boeing";
        model = "737-800";

        :>> flightState: AircraftState {
            altitude = 0.0;
            speed = 0.0;
            heading = 270.0; // runway heading at KORD, illustrative
            pitch = 0.0;
            roll = 0.0;
            yaw = 270.0;
            fuelOnBoard = 18000.0;
            zeroFuelWeight = 60000.0;
            grossWeight = 78000.0;
            isEngineOn = true;
            isLandingGearDeployed = true;
            isFlapsExtended = true;
            isAutopilotEngaged = false;
            isNavigationLightsOn = true;
            isStrobeLightsOn = true;
            isBeaconLightOn = true;
            isFuelPumpOn = true;
            isHydraulicSystemActive = true;

            position {
                latitude = 41.9786;
                longitude = -87.9048;
                altitude = 0.0;
            }
        }
    }

    part exampleFlight: Flight {
        flightNumber = "EX100";
        aircraft = exampleAircraft;
        departureAirport = ord;
        arrivalAirport = jfk;
        status = "Scheduled";
        phase = "Preflight";
    }

}
