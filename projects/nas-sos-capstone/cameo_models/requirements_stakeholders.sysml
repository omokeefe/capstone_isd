package StakeholderRequirements {
    doc /*
     * Stakeholder Requirements for the National Airspace (NAS) System.
     *
     * DESCRIPTION
     * This package outlines the requirements and expectations of the various
     * stakeholders involved in the National Airspace System (NAS). It identifies the key
     * stakeholders, their roles, and their specific needs that must be addressed to
     * ensure the successful operation and management of the NAS.
     *
     * It serves as a reference for the development of the Systems Level Requirements
     * (SLR, see requirements_nas_system.sysml) and provides a basis for understanding the
     * operational context and constraints that influence the design and implementation
     * of the NAS System. It is broken down into sub-packages that detail the
     * requirements of each stakeholder group:
     *  - Governments / Standards Organizations
     *  - Operators (Airlines, Charter Operators, Cargo Operators)
     *  - Air Traffic Control (ATC)
     *  - Aircraft and Engine Manufacturers
     *  - Airport Authority
     *  - Flight Crew
     *  - Passengers
     *  - Environmental/Societal Organizations
     *
     * SCOPE
     * The Stakeholder Requirements Document (SRD) focuses on capturing the needs and
     * expectations of stakeholders involved in the NAS System. It provides a
     * comprehensive overview of the operational environment, regulatory requirements,
     * and performance expectations that must be considered during the design,
     * implementation, and operation of the system.
     *
     * DRAFT: each group currently holds one or two real needs; the remaining
     * "The NAS System shall..." stubs from the original prose draft are recorded as
     * TODO comments in each sub-package rather than modeled as empty requirements.
     * Attribute schema is in requirements_definitions.sysml. Every need is typed
     * StakeholderNeed with status and stakeholderGroup set; rationale and evidenceRefs
     * are left unset until written and sourced.
     */

    package GovernmentsAndStandardsOrganizations {
        doc /* Governments / Standards Organizations. */

        public import RequirementDefinitions::*;

        requirement <'SN-001'> regulatoryCompliance : StakeholderNeed {
            doc /* The NAS System shall comply with all applicable regulations and standards set forth by the FAA. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::governmentsAndStandardsOrganizations;
        }

        requirement <'SN-002'> newRegulationSupport : StakeholderNeed {
            doc /* The NAS System shall support the implementation of new regulations and standards as they are developed. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::governmentsAndStandardsOrganizations;
        }
    }

    package Operators {
        doc /* Operators (Airlines, Charter Operators, Cargo Operators). */

        public import RequirementDefinitions::*;

        requirement <'SN-003'> efficientReliableAirTrafficManagement : StakeholderNeed {
            doc /* The NAS System shall provide efficient and reliable air traffic management to minimize delays and optimize flight operations. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::operators;
        }

        // TODO: 4 more "The NAS System shall..." needs to be written.
    }

    package AirTrafficControl {
        doc /* Air Traffic Control (ATC). */

        public import RequirementDefinitions::*;

        requirement <'SN-004'> controllerSituationalAwareness : StakeholderNeed {
            doc /* The NAS System shall provide real-time situational awareness and decision support tools to air traffic controllers. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::airTrafficControl;
        }

        requirement <'SN-005'> interCenterCoordination : StakeholderNeed {
            doc /* The NAS System shall facilitate effective communication and coordination between different ATC centers to ensure safe and efficient air traffic management. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::airTrafficControl;
        }

        // TODO: 3 more "The NAS System shall..." needs to be written.
    }

    package AircraftAndEngineManufacturers {
        doc /* Aircraft and Engine Manufacturers. */

        public import RequirementDefinitions::*;

        requirement <'SN-006'> newTechnologyIntegration : StakeholderNeed {
            doc /* The NAS System shall provide a platform for the integration of new aircraft and engine technologies to enhance operational capabilities and efficiency. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::aircraftAndEngineManufacturers;
        }
    }

    package AirportAuthority {
        doc /* Airport Authority. */

        public import RequirementDefinitions::*;

        requirement <'SN-007'> airportOperationsSupport : StakeholderNeed {
            doc /* The NAS System shall support airport operations by providing accurate and timely information on air traffic movements and airport capacity. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::airportAuthority;
        }

        // TODO: 3 more "The NAS System shall..." needs to be written.
    }

    package FlightCrews {
        doc /* Flight Crews. */

        public import RequirementDefinitions::*;

        requirement <'SN-008'> flightCrewDecisionSupport : StakeholderNeed {
            doc /* The NAS System shall provide flight crews with real-time information and decision support tools to enhance safety and operational efficiency. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::flightCrews;
        }

        // TODO: 3 more "The NAS System shall..." needs to be written.
    }

    package Passengers {
        doc /* Passengers. */

        public import RequirementDefinitions::*;

        requirement <'SN-009'> passengerSafetyAndComfort : StakeholderNeed {
            doc /* The NAS System shall ensure the safety and comfort of passengers by providing reliable and efficient air travel services. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::passengers;
        }

        // TODO: 3 more "The NAS System shall..." needs to be written.
    }

    package EnvironmentalAndSocietalOrganizations {
        doc /* Environmental/Societal Organizations. */

        public import RequirementDefinitions::*;

        requirement <'SN-010'> environmentalAndSocietalInsight : StakeholderNeed {
            doc /* The NAS System shall support environmental and societal objectives by providing data and insights to inform policy decisions and mitigate potential impacts. */
            status = RequirementStatus::draft;
            stakeholderGroup = StakeholderGroup::environmentalAndSocietalOrganizations;
        }

        // TODO: 3 more "The NAS System shall..." needs to be written.
    }
}
