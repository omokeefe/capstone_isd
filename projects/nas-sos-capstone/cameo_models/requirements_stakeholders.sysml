package StakeholderRequirements {
    doc /*
     * Stakeholder requirements on the National Airspace System (NAS), cut down to the
     * study: what each stakeholder wants from the NAS where that want bears on the
     * decision the project studies, which is how an en-route conflict between two
     * aircraft in cruise is resolved and what the party deciding it is told.
     *
     * DRAFT, revised from the owner's two hand reviews: of the first draft on 2026-10-10
     * (projects/nas-sos-capstone/handwritten/2026-10-10_requirements-and-traceability.pdf;
     * decision D-020) and of the second on 2026-10-11
     * (handwritten/2026-10-11_requirements-and-traceability_v2.pdf; decision D-021).
     * Every requirement has status = draft. Nothing here is baselined.
     *
     * WHAT THE REVIEW CHANGED
     * The first draft held 27 requirements in 8 groups. The owner struck those that do
     * not bear on the study's decision (D-007's test, applied to the study and not to the
     * NAS in general), re-worded several, and wrote three new flight crew requirements.
     * The second review restored SN-ATC-04 (controller workload). 13 remain, in 5 groups. Airport operator, passengers and military airspace users
     * have none. The struck text is in the PDF above and is listed, with the owner's
     * reason, in knowledge/models/requirements-and-traceability.md section 6.
     *
     * HOW TO READ ONE
     * The doc comment is the requirement. objectiveRefs names the rows it comes from in
     * knowledge/models/stakeholder-objective-ontology.md. rationale says why the
     * requirement belongs in the study. IDs were not renumbered, so gaps are struck ones.
     *
     * TRACE
     * Every requirement here is the parent of at least one system requirement in
     * requirements_nas_system.sysml (attribute parentNeeds there). 13 stakeholder
     * requirements, 23 system requirements. Below those, the constituent system
     * requirements are in requirements_constituent_systems.sysml (D-022).
     * If knowledge/models/requirements-and-traceability.md and this file disagree, this
     * one wins (D-006).
     *
     * Attribute schema: requirements_definitions.sysml.
     */

    package Operators {
        doc /* Airline (Part 121 scheduled passenger operator). D-007: Modeled system (Flight Operations). */

        public import RequirementDefinitions::*;

        requirement <'SN-AIR-01'> lowestCostTrajectory : StakeholderNeed {
            doc /* The NAS shall provide a means for the airline to plan and fly each flight on
             * the route, altitude and speed it chooses, so that the flight is flown within
             * safety and capacity limits.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Fuel cost", "Airline: Delay cost");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("mori2022massCruise", "munro2018managingVariability");
            :>> rationale = "In the study: the planned cruise altitude and speed are what a conflict resolution takes the aircraft away from, so this is what the experiment scores a resolution against. The owner struck 'at its lowest operating cost' (hand review 2026-10-11): what the airline optimizes for is the airline's own business.";
        }

        requirement <'SN-AIR-02'> onScheduleArrival : StakeholderNeed {
            doc /* The NAS shall provide a means for each flight to achieve arrival at its
             * destination gate at its scheduled arrival time.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Schedule integrity", "Airline: Aircraft utilization", "Airline: Passenger connections");
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "In the study: the time side of the fuel-against-time trade, and the reason one flight's connections can outweigh its fuel (case D of the experiment). Owner's wording, hand review 2026-10-10.";
        }

        requirement <'SN-AIR-03'> advanceNoticeOfConstraints : StakeholderNeed {
            doc /* The NAS shall inform the airline of airspace and airport constraints that will
             * delay or reroute its flights early enough for the airline to re-plan.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Delay cost", "Airline: Schedule integrity");
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "In the study: flights are separated as filed; as uncertainty is realized, aircraft deviate and interventions are needed (owner, hand review 2026-10-11). The intervention is the constraint the airline needs to hear about, and the crew and the dispatchers are the ones who coordinate to make that happen (owner, 2026-10-11). Traffic management initiatives are outside the study (D-021).";
        }

        requirement <'SN-AIR-05'> airlinePrioritiesInTrajectoryChanges : StakeholderNeed {
            doc /* The NAS shall take the airline's priorities for a flight (fuel against time, and
             * protected connections) into account when a change to that flight's trajectory is
             * required.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::operators;
            :>> objectiveRefs = ("Airline: Fuel cost", "Airline: Schedule integrity", "Airline: Passenger connections");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "coppenbarger1999climbPrediction");
            :>> rationale = "In the study: this is the requirement the experiment is about (knowledge/models/experiment-definition.md section 2). It is not met today: the controller does not receive weight or cost index. Owner's wording, hand review 2026-10-10.";
        }
    }

    package AirTrafficControl {
        doc /* Air traffic control and traffic flow management (FAA Air Traffic Organization). D-007: Modeled system (Airspace Management). */

        public import RequirementDefinitions::*;

        requirement <'SN-ATC-01'> separationAssured : StakeholderNeed {
            doc /* The NAS shall keep every controlled aircraft separated from every other aircraft
             * by at least the applicable separation minimum.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = "ATC / ANSP: Safety/separation";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "In the study: the hard constraint every resolution option must meet. It is never traded against cost (knowledge/models/experiment-definition.md section 6).";
        }

        requirement <'SN-ATC-02'> demandWithinCapacity : StakeholderNeed {
            doc /* The NAS shall keep the number of aircraft in each sector and at each airport
             * within its declared capacity.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = "ATC / ANSP: Capacity";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "In the study: context. It is the capacity limit named in SN-AIR-01. Not marked in either hand review. The workload rows moved back to SN-ATC-04 (D-021).";
        }

        requirement <'SN-ATC-04'> sustainableControllerWorkload : StakeholderNeed {
            doc /* The NAS shall keep the number of control actions a sector controller must take
             * within what one sector team can sustain.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::airTrafficControl;
            :>> objectiveRefs = ("ATC / ANSP: Sector workload", "ATC / ANSP: Traffic complexity");
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("rantanen2012conflictManeuvers", "kirwan2001coraStrategies");
            :>> rationale = "Struck in the first hand review and brought back in the second (owner, 2026-10-11: 'Let's bring back SN-ATC-04'). In the study: instruction count is one of the experiment's two scored columns. Workload is a ceiling, not something to minimize: a controller who is not overworked can give as many instructions as wanted (owner, same review).";
        }
    }

    package FlightCrews {
        doc /* Flight crew (captain and first officer). D-007: Modeled system (Flight Crew). */

        public import RequirementDefinitions::*;

        requirement <'SN-CRW-03'> flyableAndTimelyInstructions : StakeholderNeed {
            doc /* The NAS shall give the flight crew only trajectory instructions that the
             * aircraft can fly, with enough time to set them up.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Workload", "Flight Crew: Safety");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "In the study: a climb the aircraft is too heavy to make is the clearance the baseline can issue and the improved architecture avoids. The only flight crew requirement of the first draft the owner kept.";
        }

        requirement <'SN-CRW-06'> clearancesAccountForTraffic : StakeholderNeed {
            doc /* The NAS shall provide the flight crew clearances that account for air traffic. */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = "Flight Crew: Safety";
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 1). In the study: the clearance that resolves the conflict is the thing the crew receives. Objective row confirmed by the owner (hand review 2026-10-11).";
        }

        requirement <'SN-CRW-07'> crewInformedOfWeatherTrafficAndInitiatives : StakeholderNeed {
            doc /* The NAS shall inform the flight crew of weather, traffic and other safety
             * considerations.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Safety", "Flight Crew: Procedural compliance");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 2). In the study: what the crew knows when it accepts, refuses or asks to change a clearance. On 2026-10-11 the owner replaced 'traffic management initiatives' with 'other safety considerations', as a catch-all. Objective rows confirmed by the owner (hand review 2026-10-11).";
        }

        requirement <'SN-CRW-08'> controlAcrossSectors : StakeholderNeed {
            doc /* The NAS shall facilitate control of the aircraft across regional sectors,
             * coordinating controls, clearances and handoffs.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::flightCrews;
            :>> objectiveRefs = ("Flight Crew: Workload", "Flight Crew: Procedural compliance");
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Written by the owner in the hand review of 2026-10-10 (flight crew note 3). In the study: the conflict is resolved by one sector controller, whose authority ends at the sector boundary. Objective rows confirmed by the owner (hand review 2026-10-11).";
        }
    }

    package GovernmentsAndStandardsOrganizations {
        doc /* Regulator (FAA as rule maker; Department of Transportation). D-007: Boundary actor. */

        public import RequirementDefinitions::*;

        requirement <'SN-GOV-01'> operatingRulesFollowed : StakeholderNeed {
            doc /* The NAS shall conduct every flight within the operating rules of 14 CFR and the
             * FAA's air traffic orders.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::governmentsAndStandardsOrganizations;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("faa2025jo711065bb", "faa2025jo72103ee", "14 CFR 91", "14 CFR 121");
            :>> rationale = "In the study: the rules are held fixed (D-007), so both the baseline and the improved architecture must stay inside them. Governance has no table in knowledge/models/stakeholder-objective-ontology.md; the objective is 'Regulatory Compliance' in the enterprise objective hierarchy in knowledge/models/stakeholder-register.md. The owner judged adding a Governance table not important (hand review 2026-10-10).";
        }
    }

    package EnvironmentalAndSocietalOrganizations {
        doc /* Communities and environmental organizations. D-007: Boundary actor (acts through Governance per D-007). */

        public import RequirementDefinitions::*;

        requirement <'SN-ENV-01'> lowCo2PerFlight : StakeholderNeed {
            doc /* The NAS shall keep the CO2 emitted by each flight as low as safety, economics
             * and capacity allow.
             */
            :>> status = RequirementStatus::draft;
            :>> stakeholderGroup = StakeholderGroup::environmentalAndSocietalOrganizations;
            :>> objectiveRefs = "Environmental / Societal: CO2";
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> evidenceRefs = "icao2024icecMethodology";
            :>> rationale = "In the study: CO2 is fuel burned times 3.16 (D-015), so the experiment's fuel column is also this stakeholder's column. 'Economics' was added by the owner (hand review 2026-10-10) and left standing in the second review.";
        }
    }
}
