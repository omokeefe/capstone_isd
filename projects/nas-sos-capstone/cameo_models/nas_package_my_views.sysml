package MyViews {
    doc /* This package contains the views for the NAS SOS Capstone project, 
    * including the context diagram, system architecture, and other relevant 
    * diagrams that illustrate the system of interest (SoI) and its interactions 
    * with external entities.
    */
    private import Views::asTreeDiagram;

    package MyDiagrams {
    }

    part def NASMyViews {    
        public import ContextDiagram::*;

        // Define the views that will be included in this package.
        // Each view will provide a different perspective on the SoI and its interactions.
        // The views will be used to communicate the design and functionality of the system
        // to stakeholders and team members.

        private import StandardViewDefinitions::*;

        // A `// caption:` line directly above a view is the figure caption used in the
        // report (tools/render_sysml_diagrams.py reads it). Keep it on one line.
        // A `// placement: body` line directly above the caption line means a body section
        // of the report inputs the figure; without it the figure goes in the appendix.

        // placement: body
        // caption: NAS context diagram
        view systemContext : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Render only what NASContextDiagram tags #ContextVisible (parts and
            // connections). What to show is decided there, not here.
            // `*::**` exposes everything under NASContextDiagram but not NASContextDiagram
            // itself; the view `filter` (not an inline [@...] on the expose) is what also
            // hides untagged nested parts such as airport.maintenanceHangar. Tested with
            // syside viz 0.10.3, 2026-09-27.
            expose ContextDiagram::NASContextDiagram::*::**;
            filter @ContextDiagram::ContextVisible;
            // Expose mode (CLI only: `syside viz view`; the Ctrl+Alt+V preview ignores it).
            // Decides what happens to elements the filter drops. Keep exactly one line active.
            //   subtree  (default) a dropped element takes its whole subtree with it.
            //   promoted dropped elements vanish; their tagged descendants move up to the
            //            view frame, prefixed with their origin path.
            //   flat     every exposed element is its own sibling; no containment boxes
            //            (on this view it draws the connections as loose boxes, no parts).
            attribute exposeMode = "subtree";
            // attribute exposeMode = "promoted";
            // attribute exposeMode = "flat";
        }

        // placement: body
        // caption: Airspace management internal block diagram
        view airspaceManagementIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Placeholder IBD (D-010): links internal to Airspace Management.
            // Same expose + filter form as systemContext: the inline
            // `::**[@...IBDVisible]` form rendered an empty frame (syside viz, 2026-10-08).
            expose AirspaceManagementIBD::AirspaceManagementInternals::*::**;
            filter @AirspaceManagementIBD::IBDVisible;
        }

        // placement: body
        // caption: Aircraft internal block diagram, default level of detail
        view aircraftIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Default aircraft IBD (D-011, D-012): crew, flight deck controls, avionics, flight
            // controls, fuel system, boundary ports and the information / command links.
            // Draws only #IBDVisible elements.
            expose AircraftIBD::CommercialTransportAirlinerInternals::*::**;
            filter @AircraftIBD::IBDVisible;
        }

        // placement: body
        // caption: Aircraft internal block diagram, detailed level: adds propulsion, airframe, landing gear, utilities, and the fuel and power links
        view aircraftIbdDetail : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Detailed aircraft IBD (D-011): adds everything tagged #IBDDetail (propulsion,
            // airframe, landing gear, utilities incl. pitot-static, fuel and power links).
            expose AircraftIBD::CommercialTransportAirlinerInternals::*::**;
            filter @AircraftIBD::IBDVisible or @AircraftIBD::IBDDetail;
        }

        // placement: body
        // caption: Nominal flight operations activity diagram, phase level (each phase is decomposed in its own figure)
        view nominalOpsActivity : ActionFlowView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            attribute depth = 2;                   // phases only; the full depth is ~16k px wide
            expose NominalOpsActivity::NominalFlightOperations::**;
        }

        // One action-flow view per decomposed phase (owner's nominal-ops sequence, 2026-10-18).
        // placement: body
        // caption: Nominal operations, Prework: airline planning before flight planning
        view preworkActivity : ActionFlowView {
            expose NominalOpsActivity::Prework::**;
        }

        // placement: body
        // caption: Nominal operations, Prepare for Departure: parallel fueling, FMS entry, configuration and gate turnaround
        view prepareForDepartureActivity : ActionFlowView {
            expose NominalOpsActivity::PrepareForDeparture::**;
        }

        // placement: body
        // caption: Nominal operations, Depart: clearance, pushback, taxi-out, takeoff and climb
        view departActivity : ActionFlowView {
            expose NominalOpsActivity::Depart::**;
        }

        // placement: body
        // caption: Nominal operations, Fly Enroute: crew cruise loop, ATC sector monitoring and AOC intervention in parallel
        view flyEnrouteActivity : ActionFlowView {
            expose NominalOpsActivity::FlyEnroute::**;
        }

        // placement: body
        // caption: ATC resolves a conflict: the studied decision, branching on what the controller knows (cases A to D)
        view resolveConflictActivity : ActionFlowView {
            expose NominalOpsActivity::ResolveConflict::**;
        }

        // placement: body
        // caption: Nominal operations, Arrive: arrival planning, descent, approach, landing and taxi-in
        view arriveActivity : ActionFlowView {
            expose NominalOpsActivity::Arrive::**;
        }

        // placement: body
        // caption: Nominal operations, Close Out Flight: block-in, deplaning and turnaround
        view closeOutFlightActivity : ActionFlowView {
            expose NominalOpsActivity::CloseOutFlight::**;
        }

        // ---- Structure: BDD and the domain IBDs in nas_block_diagrams.sysml (D-029) ----

        // caption: NAS block definition diagram: the modeled domains and the context-diagram systems, composition only
        view nasBdd : GeneralView {
            attribute showInheritedRows = false;   // CLI only
            attribute maxCompartmentEntries = 0;   // CLI only: hide attribute/action compartments; composition lines only
            expose NASBlockDiagrams::NASStructure::*::**;
            filter @NASBlockDiagrams::BDDVisible;
            render asTreeDiagram;
        }

        // caption: Flight operations internal block diagram: the airline operations center's roles
        view flightOperationsIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only
            expose NASBlockDiagrams::FlightOperationsInternals::*::**;
            filter @NASBlockDiagrams::IBDVisible;
        }

        // caption: Airport operations internal block diagram
        view airportOperationsIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only
            expose NASBlockDiagrams::AirportOperationsInternals::*::**;
            filter @NASBlockDiagrams::IBDVisible;
        }

        // caption: Flight crew internal block diagram
        view flightCrewIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only
            expose NASBlockDiagrams::FlightCrewInternals::*::**;
            filter @NASBlockDiagrams::IBDVisible;
        }

        // ---- Behavior: the aircraft's state machine in nas_state_aircraft.sysml (D-035) ----

        // caption: Aircraft state machine: the clearance the aircraft is flying, from the ground before departure to the ground after arrival
        view aircraftClearanceStates : StateTransitionView {
            expose AircraftStates::AircraftClearanceStates::**;
        }

        // ---- Behavior: the Case C Conflict Resolve sequence in nas_sequence_case_c.sysml (D-035; draft) ----

        // caption: Case C Conflict Resolve: the exchanges when ATC decision support scores the options with the airline's shared data
        view caseCConflictResolve : SequenceView {
            expose CaseCConflictResolve::CaseCConflictResolveSequence::**;
        }

        // ---- Parametrics: the analysis package in nas_analysis.sysml (D-017, D-035) ----

        // caption: Analysis definitions: the performance calculations, the two fidelity usages and the conflict-resolution scoring analysis
        view analysisParametrics : GeneralView {
            attribute showInheritedRows = false;   // CLI only
            expose NasAnalysis::*;
        }

        // Additional views can be added as needed to support the development and
        // understanding of the system of interest.
    }
}