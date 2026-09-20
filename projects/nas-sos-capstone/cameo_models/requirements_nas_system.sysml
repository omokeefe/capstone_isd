package SystemLevelRequirements {
    doc /*
     * System Requirements Specification (SRS) for the National Airspace (NAS) System.
     *
     * DESCRIPTION
     * This package describes the requirements for the NAS System. It includes functional
     * and non-functional requirements, as well as constraints and assumptions that must
     * be considered during the design and implementation of the system.
     *
     * The Systems Level Requirements (SLR) for the NAS System are derived from the
     * operational needs of the National Airspace System and the requirements of various
     * stakeholders, as specified in the Stakeholders Requirements Document (SRD, see
     * requirements_stakeholders.sysml). The SLRs define the high-level capabilities and
     * performance characteristics that the NAS System must achieve to ensure safe and
     * efficient air traffic management.
     *
     * SCOPE
     * The NAS System is responsible for managing and controlling air traffic within the
     * national airspace. It encompasses various subsystems, including air traffic
     * control, communication systems, navigation aids, and surveillance systems. The
     * system must ensure the safety, efficiency, and reliability of air traffic
     * operations while accommodating future growth and technological advancements.
     *
     * The NAS exists as a complex system of systems, integrating multiple components and
     * stakeholders. It must support a wide range of aircraft types, including
     * commercial, general aviation, and unmanned aerial vehicles (UAVs). The system must
     * also comply with regulatory requirements and international standards.
     *
     * The NAS integrates into the broader aviation ecosystem, including airports,
     * airlines, and government agencies. It must facilitate seamless communication and
     * coordination among these entities to ensure the smooth flow of air traffic.
     *
     * The NAS exists within the Global Air Traffic Management (ATM) framework, which
     * includes international airspace and cross-border operations. The system must
     * support interoperability with other national and international air traffic
     * management systems to ensure safe and efficient global air travel.
     *
     * DRAFT: attribute schema is in requirements_definitions.sysml. Every SLR is typed
     * SystemLevelRequirement with status and kind set. Still unset, because they are
     * judgment calls rather than reformatting: parentNeeds (no trace to stakeholder needs
     * yet), verificationMethod, rationale, evidenceRefs, and the threshold/objective
     * fields (none of the six current SLRs is quantified).
     */

    package FunctionalRequirements {
        doc /* Functional requirements. */

        public import RequirementDefinitions::*;

        requirement <'SLR-001'> realTimeMonitoringAndControl : SystemLevelRequirement {
            doc /* The NAS System shall provide real-time air traffic monitoring and control capabilities. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }

        requirement <'SLR-002'> controllerPilotCommunication : SystemLevelRequirement {
            doc /* The NAS System shall support communication between air traffic controllers and pilots. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }

        requirement <'SLR-003'> navigationAids : SystemLevelRequirement {
            doc /* The NAS System shall provide navigation aids to assist pilots in safely navigating the airspace. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }

        requirement <'SLR-004'> aircraftSurveillance : SystemLevelRequirement {
            doc /* The NAS System shall support surveillance systems to track aircraft positions and movements. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }

        requirement <'SLR-005'> atcCenterCoordination : SystemLevelRequirement {
            doc /* The NAS System shall facilitate coordination between different air traffic control centers. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }

        requirement <'SLR-006'> conflictDetectionAndResolution : SystemLevelRequirement {
            doc /* The NAS System shall provide tools for conflict detection and resolution to prevent mid-air collisions. */
            status = RequirementStatus::draft;
            kind = RequirementKind::functional;
        }
    }
}
