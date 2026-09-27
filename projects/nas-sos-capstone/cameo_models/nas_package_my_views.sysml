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
            // Render only what NASContextDiagram tags #ContextVisible (parts and
            // connections). What to show is decided there, not here.
            expose ContextDiagram::NASContextDiagram::**[@ContextDiagram::ContextVisible];
        }

        view airspaceManagementIbd : InterconnectionView {
            // Placeholder IBD (D-010): links internal to Airspace Management.
            expose AirspaceManagementIBD::AirspaceManagementInternals::**[@AirspaceManagementIBD::IBDVisible];
        }


        // Additional views can be added as needed to support the development and
        // understanding of the system of interest.
    }
}