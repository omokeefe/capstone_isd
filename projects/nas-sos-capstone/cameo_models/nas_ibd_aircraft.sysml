package AircraftIBD {
    doc /* Internal block diagram for one commercial transport airliner (to-do-list.md §10,
     * operational IBDs). Created 2026-10-08 from an owner-provided outline, then reconciled
     * with the definitions the same day (D-011): `airliner` is a usage of
     * AircraftSystems::Aircraft, and every part below redefines a part that Aircraft already
     * has. Definitions stay in nas_sysml_package_definitions.sysml (methods §10.1); this
     * file holds usages, tags and wiring only.
     * Revised the same day from the owner's hand-marked print (D-012): the crew acts
     * through the flight deck controls and the FMS, pitot-static is a utility, EICAS is
     * folded into the displays, the cabin is gone, and the aircraft has boundary ports.
     *
     * Levels of abstraction. Two tags decide what is drawn:
     *   #IBDVisible  drawn by MyViews::aircraftIbd (the default picture): the crew, the
     *                flight deck controls, the avionics, the flight control system and the
     *                fuel system, with the information and command links between them,
     *                and the boundary ports.
     *   #IBDDetail   drawn only by MyViews::aircraftIbdDetail, together with everything
     *                tagged #IBDVisible: propulsion, airframe, landing gear, utilities
     *                (pitot-static included, with every air data link), cabin crew,
     *                passengers, and the fuel, power and physical-response links.
     *   untagged     in the definitions for reference, drawn by neither view (engine
     *                internals, landing gear sub-parts, wings, empennage). To show one,
     *                redefine it here with a tag.
     * To move something between levels, change its tag. A part is drawn only if its
     * container is drawn, and a connection only if both ends are.
     *
     * Labels. Each connection's description is a `comment about <name>`, not a `doc`
     * inside a body: syside viz drops the name of a connection whose body holds a doc.
     * The comments for the connections inside `airliner` sit after that part, because a
     * comment owned by a drawn part is printed on the diagram (tested 2026-10-08,
     * sysml-diagram-rendering.md §6).
     *
     * Evidence grades are not yet assigned. The links come from the owner's outline and
     * 2026-10-08 direction; the owner confirms which are [SME].
     */

    metadata def IBDVisible {
        doc /* Tag for elements the default aircraft IBD view renders. */
    }

    metadata def IBDDetail {
        doc /* Tag for elements only the detailed aircraft IBD view renders. */
    }

    part def CommercialTransportAirlinerInternals {
        private import NationalAirspaceSystem::AircraftSystems::*;
        private import NationalAirspaceSystem::FlightCrew::*;

        // People on board are independent of the aircraft (D-007: Flight Crew is its own
        // domain, Passengers a boundary actor), so they are referenced, not owned.
        ref #IBDVisible part flightDeckCrew: FlightDeckCrew {
            #IBDVisible part :>> captain;
            #IBDVisible part :>> firstOfficer;
        }
        ref #IBDDetail part cabinCrew: CabinCrew;
        ref #IBDDetail part passengers[*];   // no part def: Common::Passenger is an attribute def

        #IBDVisible part airliner: Aircraft {
            // Boundary ports (D-012): what enters and leaves the aircraft on this diagram.
            #IBDVisible port :>> adsbOut;
            #IBDVisible port :>> adsbIn;
            #IBDVisible port :>> emissions;
            #IBDDetail port :>> ambientAir;

            #IBDVisible part :>> flightDeckControls {
                #IBDVisible part :>> modeControlPanel;
                #IBDVisible part :>> yokes;
                #IBDVisible part :>> rudderPedals;
                #IBDVisible part :>> configurationLevers;
                #IBDVisible part :>> thrustLevers;
            }

            #IBDVisible part :>> avionics {
                #IBDVisible part :>> flightManagementSystem;
                #IBDVisible part :>> autoFlightControlSystem {
                    #IBDDetail part :>> autopilot;
                    #IBDDetail part :>> autothrottle;
                }
                #IBDVisible part :>> navigationSystem;
                #IBDVisible part :>> communicationSystem;
                #IBDVisible part :>> surveillanceSystem;
                #IBDVisible part :>> displaySystem;
                #IBDDetail part :>> standbyInstruments;
                #IBDDetail part :>> radar;
                // guidanceSystem: untagged. See the note on AircraftSystems::GuidanceSystem.
                // decisionSupport: untagged until its links are worked out (D-012).
            }

            #IBDVisible part :>> flightControlSystem {
                #IBDDetail part :>> primaryFCS;
                #IBDDetail part :>> secondaryFCS;
            }

            #IBDVisible part :>> fuelSystem;

            #IBDDetail part :>> propulsion {
                #IBDDetail part :>> mainEngines {
                    #IBDDetail part :>> fadec;
                }
                #IBDDetail part :>> apu;
            }

            #IBDDetail part :>> airframe {
                #IBDDetail part :>> fuselage;
            }
            #IBDDetail part :>> landingGear;

            #IBDDetail part :>> utilities {
                #IBDDetail part :>> electrical;
                #IBDDetail part :>> hydraulic;
                #IBDDetail part :>> pneumatic;
                #IBDDetail part :>> environmentalControl;
                #IBDDetail part :>> iceProtection;
                #IBDDetail part :>> pitotStaticSystem;
            }

            // ---- Default level: flight deck controls -> the systems they command ----
            // The crew's only paths to autoflight and the flight control system (D-012).

            #IBDVisible connection mcpSelections connect flightDeckControls.modeControlPanel to avionics.autoFlightControlSystem;
            #IBDVisible connection pitchRollInput connect flightDeckControls.yokes to flightControlSystem;
            #IBDVisible connection yawInput connect flightDeckControls.rudderPedals to flightControlSystem;
            #IBDVisible connection configurationInput connect flightDeckControls.configurationLevers to flightControlSystem;

            // ---- Default level: information and command inside the aircraft ----

            // Sensing -> FMS -> autoflight -> flight controls.
            #IBDVisible connection navData connect avionics.navigationSystem to avionics.flightManagementSystem;
            #IBDVisible connection fuelQuantity connect fuelSystem to avionics.flightManagementSystem;
            #IBDVisible connection guidance connect avionics.flightManagementSystem to avionics.autoFlightControlSystem;
            #IBDVisible connection controlCommands connect avionics.autoFlightControlSystem to flightControlSystem;
            #IBDVisible connection fmsDisplays connect avionics.flightManagementSystem to avionics.displaySystem;
            #IBDVisible connection afcsDisplays connect avionics.autoFlightControlSystem to avionics.displaySystem;

            // Communication: the systems ATC, the AOC and the crew talk through. The far
            // ends are on the context diagram (atcToCrew voice, atcAircraftDatalink,
            // aocAircraftDatalink).
            #IBDVisible connection commsFms connect avionics.communicationSystem to avionics.flightManagementSystem;

            // Surveillance: what the aircraft transmits so outside systems can follow its
            // state (context diagram: atcSurveillance), and what it receives about other
            // aircraft.
            // Direction confirmed by the owner, 2026-10-08 ([SME]): navigation determines
            // the aircraft's position, which goes to surveillance to be broadcast.
            // Surveillance receives the same kind of transmission from other aircraft.
            #IBDVisible connection navSurveillance connect avionics.navigationSystem to avionics.surveillanceSystem;
            #IBDVisible connection adsbBroadcast connect avionics.surveillanceSystem to adsbOut;
            #IBDVisible connection adsbReception connect adsbIn to avionics.surveillanceSystem;
            #IBDVisible connection trafficDisplays connect avionics.surveillanceSystem to avionics.displaySystem;

            // ---- Detail level: air data (pitot-static is a utility, D-012) ----

            #IBDDetail connection ambientAirSensing connect ambientAir to utilities.pitotStaticSystem;
            #IBDDetail connection airDataFms connect utilities.pitotStaticSystem to avionics.flightManagementSystem;
            #IBDDetail connection airDataAfcs connect utilities.pitotStaticSystem to avionics.autoFlightControlSystem;
            #IBDDetail connection airDataDisplays connect utilities.pitotStaticSystem to avionics.displaySystem;
            #IBDDetail connection airDataSurveillance connect utilities.pitotStaticSystem to avionics.surveillanceSystem;
            #IBDDetail connection airDataStandby connect utilities.pitotStaticSystem to avionics.standbyInstruments;

            // ---- Detail level: thrust, physical response, fuel and power ----

            #IBDDetail connection radarDisplays connect avionics.radar to avionics.displaySystem;
            #IBDDetail connection engineIndication connect propulsion.mainEngines to avionics.displaySystem;
            #IBDDetail connection exhaust connect propulsion.mainEngines to emissions;
            #IBDDetail connection thrustLeverCommand connect flightDeckControls.thrustLevers to propulsion.mainEngines.fadec;
            #IBDDetail connection thrustCommand connect avionics.autoFlightControlSystem.autothrottle to propulsion.mainEngines.fadec;
            #IBDDetail connection gearInput connect flightDeckControls.configurationLevers to landingGear;
            #IBDDetail connection brakeInput connect flightDeckControls.rudderPedals to landingGear;
            #IBDDetail connection thrust connect propulsion.mainEngines to airframe;
            #IBDDetail connection aeroForces connect flightControlSystem to airframe;
            #IBDDetail connection responseNav connect airframe to avionics.navigationSystem;
            #IBDDetail connection responseAirData connect airframe to utilities.pitotStaticSystem;

            // Fuel.
            #IBDDetail connection fuelFeedEngines connect fuelSystem to propulsion.mainEngines;
            #IBDDetail connection fuelFeedApu connect fuelSystem to propulsion.apu;

            // Power sources.
            #IBDDetail connection engineElectrical connect propulsion.mainEngines to utilities.electrical;
            #IBDDetail connection engineHydraulic connect propulsion.mainEngines to utilities.hydraulic;
            #IBDDetail connection enginePneumatic connect propulsion.mainEngines to utilities.pneumatic;
            #IBDDetail connection apuElectrical connect propulsion.apu to utilities.electrical;
            #IBDDetail connection apuPneumatic connect propulsion.apu to utilities.pneumatic;

            // Power users, at subsystem level.
            #IBDDetail connection elecAvionics connect utilities.electrical to avionics;
            #IBDDetail connection elecFlightControls connect utilities.electrical to flightControlSystem;
            #IBDDetail connection elecFuel connect utilities.electrical to fuelSystem;
            #IBDDetail connection elecLandingGear connect utilities.electrical to landingGear;
            #IBDDetail connection hydFlightControls connect utilities.hydraulic to flightControlSystem;
            #IBDDetail connection hydLandingGear connect utilities.hydraulic to landingGear;
            #IBDDetail connection bleedEcs connect utilities.pneumatic to utilities.environmentalControl;
            #IBDDetail connection bleedIce connect utilities.pneumatic to utilities.iceProtection;
            #IBDDetail connection fuselageAir connect utilities.environmentalControl to airframe.fuselage;
        }

        // Descriptions of the connections inside `airliner`. Kept out here, not inside the
        // part: a comment owned by a drawn part is printed in a compartment on the diagram.
        comment about airliner::mcpSelections /* MCP -> autoflight: autopilot / autothrottle engage and
             * disengage, mode selection, speed / altitude / heading / vertical speed targets. */
        comment about airliner::pitchRollInput /* yokes -> flight control system: manual pitch and roll. */
        comment about airliner::yawInput /* rudder pedals -> flight control system: manual yaw. */
        comment about airliner::configurationInput /* configuration levers -> flight control system:
             * flaps / slats, speedbrake, trim. */
        comment about airliner::navData /* navigation -> FMS: position, velocity, attitude. */
        comment about airliner::fuelQuantity /* fuel system -> FMS: fuel quantity (FQIS). The input to the
             * FMS fuel prediction the crew checks in FlightCrew::PreflightCrossCheck. Kept at
             * the default level because it is information; fuel feed is at the detail level. */
        comment about airliner::guidance /* FMS -> autoflight: lateral and vertical guidance commands,
             * speed targets. */
        comment about airliner::controlCommands /* autoflight -> flight control system: surface commands.
             * The software logic in the avionics drives the servos, actuators and surfaces. */
        comment about airliner::fmsDisplays /* FMS -> displays: route, predictions, guidance cues. */
        comment about airliner::afcsDisplays /* autoflight -> displays: engaged modes, flight director. */
        comment about airliner::commsFms /* comms -> FMS: uplinked routes, winds and clearances, loaded
             * only after the crew accepts them. FMS -> comms: position, ETA and fuel reports
             * for downlink. */
        comment about airliner::navSurveillance /* navigation -> surveillance: position and velocity
             * for ADS-B Out. */
        comment about airliner::adsbBroadcast /* surveillance -> outside: ADS-B Out broadcast and
             * transponder replies. */
        comment about airliner::adsbReception /* other aircraft -> surveillance: ADS-B reports (and TCAS
             * interrogation replies). */
        comment about airliner::trafficDisplays /* surveillance -> displays: other aircraft's position
             * and TCAS advisories. With displaysCrew this is how the crew sees traffic
             * (owner, 2026-10-08). */
        comment about airliner::ambientAirSensing /* outside air -> pitot-static: total and static
             * pressure, temperature. True, but not important to the study (owner). */
        comment about airliner::airDataFms /* pitot-static -> FMS: air data (airspeed, pressure altitude,
             * temperature). */
        comment about airliner::airDataAfcs /* pitot-static -> autoflight: air data. */
        comment about airliner::airDataDisplays /* pitot-static -> displays: air data. */
        comment about airliner::airDataSurveillance /* pitot-static -> surveillance: pressure altitude
             * (Mode C, ADS-B Out). */
        comment about airliner::airDataStandby /* pitot-static -> standby instruments: air data. */
        comment about airliner::radarDisplays /* weather radar -> displays: weather returns. */
        comment about airliner::engineIndication /* engines -> displays: engine indication and alerts
             * (the EICAS function, D-012). */
        comment about airliner::exhaust /* engines -> outside: exhaust emissions. */
        comment about airliner::thrustLeverCommand /* thrust levers -> each engine's FADEC: manual thrust
             * command. */
        comment about airliner::thrustCommand /* autothrottle -> each engine's FADEC: thrust command. The
             * FADEC turns it into fuel flow inside the engine. */
        comment about airliner::gearInput /* configuration levers -> landing gear: gear lever. */
        comment about airliner::brakeInput /* rudder pedals -> landing gear: wheel brakes, steering. */
        comment about airliner::thrust /* engines -> airframe: thrust. */
        comment about airliner::aeroForces /* flight control system -> airframe: surface deflections, so
             * aerodynamic forces and moments. */
        comment about airliner::responseNav /* airframe -> navigation: vehicle response (position,
             * attitude, rates). */
        comment about airliner::responseAirData /* airframe -> pitot-static: vehicle response (airspeed,
             * pressure altitude). */
        comment about airliner::fuelFeedEngines /* fuel system -> each engine's fuel-supply system: fuel. */
        comment about airliner::fuelFeedApu /* fuel system -> APU: fuel. */
        comment about airliner::engineElectrical /* engines -> electrical: engine-driven generators. */
        comment about airliner::engineHydraulic /* engines -> hydraulic: engine-driven pumps. */
        comment about airliner::enginePneumatic /* engines -> pneumatic: bleed air. */
        comment about airliner::apuElectrical /* APU -> electrical: APU generator. */
        comment about airliner::apuPneumatic /* APU -> pneumatic: bleed air (engine start, air
             * conditioning on the ground). */
        comment about airliner::elecAvionics /* electrical -> avionics: power. */
        comment about airliner::elecFlightControls /* electrical -> flight control system: power
             * (controllers, electric actuators). */
        comment about airliner::elecFuel /* electrical -> fuel system: power (pumps, valves, quantity
             * indication). */
        comment about airliner::elecLandingGear /* electrical -> landing gear: power. */
        comment about airliner::hydFlightControls /* hydraulic -> flight control system: actuator power. */
        comment about airliner::hydLandingGear /* hydraulic -> landing gear: extension / retraction,
             * brakes, steering. */
        comment about airliner::bleedEcs /* pneumatic -> environmental control: air. */
        comment about airliner::bleedIce /* pneumatic -> ice protection: air. */
        comment about airliner::fuselageAir /* environmental control -> fuselage: conditioned air,
             * pressurization. */

        // ---- Default level: flight deck crew <-> aircraft ----
        // The inside of the context diagram's crewAircraft connection. The crew acts on
        // the flight deck controls and the FMS (D-012), never straight on autoflight or
        // the flight control system. Radio and transponder panels are not modeled, so
        // crewComms and crewSurveillance still end on the system itself.
        #IBDVisible connection crewControls connect flightDeckCrew to airliner.flightDeckControls;
        comment about crewControls /* crew -> flight deck controls: yokes, rudder pedals, thrust
             * levers, configuration levers, mode control panel. */
        #IBDVisible connection crewFms connect flightDeckCrew to airliner.avionics.flightManagementSystem;
        comment about crewFms /* crew -> FMS: route, performance data (ZFW, fuel, cost index,
             * cruise altitude, winds), plan changes. */
        #IBDVisible connection displaysCrew connect airliner.avionics.displaySystem to flightDeckCrew;
        comment about displaysCrew /* displays -> crew: flight path, modes, route, predictions,
             * traffic, engine indication and alerts. */
        #IBDVisible connection crewComms connect flightDeckCrew to airliner.avionics.communicationSystem;
        comment about crewComms /* crew <-> comms: voice with ATC and the AOC; datalink messages
             * read, accepted or rejected, and sent (CPDLC, ACARS). */
        #IBDVisible connection crewSurveillance connect flightDeckCrew to airliner.avionics.surveillanceSystem;
        comment about crewSurveillance /* crew -> surveillance: beacon code, IDENT, mode. */

        // ---- Detail level ----
        #IBDDetail connection standbyCrew connect airliner.avionics.standbyInstruments to flightDeckCrew;
        comment about standbyCrew /* standby instruments -> crew: backup attitude, airspeed,
             * altitude. */
        #IBDDetail connection responseCrew connect airliner.airframe to flightDeckCrew;
        comment about responseCrew /* airframe -> crew: motion and outside-view cues. */
        #IBDDetail connection cabinCrewOnBoard connect cabinCrew to airliner.airframe.fuselage;
        comment about cabinCrewOnBoard /* cabin crew work in the fuselage. */
        #IBDDetail connection passengersOnBoard connect passengers to airliner.airframe.fuselage;
        comment about passengersOnBoard /* passengers ride in the fuselage. */
    }
}
