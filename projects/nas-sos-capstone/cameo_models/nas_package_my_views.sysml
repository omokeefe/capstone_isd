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

        view airspaceManagementIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Placeholder IBD (D-010): links internal to Airspace Management.
            // Same expose + filter form as systemContext: the inline
            // `::**[@...IBDVisible]` form rendered an empty frame (syside viz, 2026-10-08).
            expose AirspaceManagementIBD::AirspaceManagementInternals::*::**;
            filter @AirspaceManagementIBD::IBDVisible;
        }

        view aircraftIbd : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Default aircraft IBD (D-011, D-012): crew, flight deck controls, avionics, flight
            // controls, fuel system, boundary ports and the information / command links.
            // Draws only #IBDVisible elements.
            expose AircraftIBD::CommercialTransportAirlinerInternals::*::**;
            filter @AircraftIBD::IBDVisible;
        }

        view aircraftIbdDetail : InterconnectionView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            // Detailed aircraft IBD (D-011): adds everything tagged #IBDDetail (propulsion,
            // airframe, landing gear, utilities incl. pitot-static, fuel and power links).
            expose AircraftIBD::CommercialTransportAirlinerInternals::*::**;
            filter @AircraftIBD::IBDVisible or @AircraftIBD::IBDDetail;
        }

        view nominalOpsActivity : ActionFlowView {
            attribute showInheritedRows = false;   // CLI only: hide inherited (^) rows such as performedActions
            expose NominalOpsActivity::NominalFlightOperations::**;
        }

        // Additional views can be added as needed to support the development and
        // understanding of the system of interest.
    }
}