package SystemLevelRequirements {
    doc /*
     * System requirements for the National Airspace System (NAS), cut down to the study:
     * what the NAS as a whole shall do where it bears on how an en-route conflict between
     * two aircraft in cruise is resolved and on what the party deciding it is told. Each
     * one is checkable, traced up to a stakeholder requirement and allocated down to the
     * constituent systems that carry it out.
     *
     * DRAFT, revised from the owner's two hand reviews: of the first draft on 2026-10-10
     * (projects/nas-sos-capstone/handwritten/2026-10-10_requirements-and-traceability.pdf;
     * decision D-020) and of the second on 2026-10-11
     * (handwritten/2026-10-11_requirements-and-traceability_v2.pdf; decision D-021).
     * Every requirement has status = draft. Nothing here is baselined.
     *
     * WHAT THE REVIEW CHANGED
     * The first draft held 53 requirements. The owner struck those that do not bear on
     * the study, re-worded others, merged the three information requirements into one
     * (SLR-INF-02) and judged two statements goals and not requirements. The second
     * review struck six more (all of traffic flow management among them), re-worded the
     * remaining goal and brought back the workload requirement. 23 remain. The
     * struck text is in the PDF above and is listed, with the owner's reason, in
     * knowledge/models/requirements-and-traceability.md section 6. IDs were not
     * renumbered, so gaps are struck ones.
     *
     * TRACE RULES
     *  - parentNeeds names the stakeholder requirement(s) in
     *    requirements_stakeholders.sysml that this requirement answers. Every
     *    requirement has at least one; none is derived any longer.
     *  - rationale says why the requirement belongs in the study, and records the
     *    owner's mark where there was one.
     *  - The Allocation package at the end says which constituent systems satisfy each
     *    requirement, using the parts of NationalAirspaceSystem in
     *    nas_sysml_package_definitions.sysml.
     *  - thresholdValue is set only where a source held in this repository gives the
     *    number. Where a common figure is known but not yet confirmed, rationale says so.
     *
     * GOALS (D-020)
     * SLR-CLR-13 carries obligation = goal and is written with "should": the owner
     * judged it not required. It is measured by the experiment, not passed or failed.
     *
     * IMPROVED ARCHITECTURE (D-018)
     * SLR-CLR-10, SLR-CLR-13, SLR-INF-02 describe what today's system does not do and
     * carry architectureState = improved. They are what the experiment in
     * knowledge/models/experiment-definition.md is about.
     *
     * 23 system requirements answer 13 stakeholder requirements.
     * If knowledge/models/requirements-and-traceability.md and this file disagree, this
     * one wins (D-006).
     *
     * Attribute schema: requirements_definitions.sysml.
     */

    package FlightPlanningAndRelease {
        doc /* Flight planning and release. Place on the trajectory-intent chain: mission plan -> flight plan. */

        public import RequirementDefinitions::*;

        requirement <'SLR-PLN-01'> flightPlanContent : SystemLevelRequirement {
            doc /* The NAS shall produce for each scheduled flight a flight plan that states its route,
             * cruise altitude, cruise speed and fuel load.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::Operators::lowestCostTrajectory;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "berry2011aocActors";
            :>> rationale = "In the study: the flight plan sets the cruise altitude, speed and fuel load each aircraft has when the conflict occurs.";
        }

        requirement <'SLR-PLN-02'> flightPlanUsesAssignedAircraft : SystemLevelRequirement {
            doc /* The NAS shall compute each flight plan from the performance of the aircraft assigned
             * to the flight.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::Operators::lowestCostTrajectory;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "mori2022massCruise";
            :>> rationale = "The owner struck 'the planned take-off weight' (hand review 2026-10-10). In the study: the cost-optimal altitude depends on mass (mori2022massCruise, Figure 1), which is why two aircraft of one type can want different levels. Owner (hand review 2026-10-11): the next tier can hold several requirements under this one, one per customer or way of computing it: low fidelity, high fidelity, and rules of thumb per aircraft type.";
        }

        requirement <'SLR-PLN-04'> fuelReserve : SystemLevelRequirement {
            doc /* The NAS shall load each flight with fuel to reach its destination, then its most
             * distant alternate, then fly 45 minutes at normal cruise.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::designConstraint;
            :>> parentNeeds = StakeholderRequirements::GovernmentsAndStandardsOrganizations::operatingRulesFollowed;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> measureOfPerformance = "fuel remaining after destination and alternate";
            :>> unitOfMeasure = "minutes at normal cruise";
            :>> thresholdValue = 45.0;
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> evidenceRefs = "14 CFR 121.639";
            :>> rationale = "The owner asked whether this is relevant for the weight assumptions. It is: the fuel load is part of the take-off weight, and the reserve sets the least fuel, and so the least weight, an aircraft can have in cruise. Owner (hand review 2026-10-11): it goes into the low-fidelity model's assumptions. Number and paragraph are from general knowledge; confirm against 14 CFR 121.639 before baselining.";
        }

        requirement <'SLR-PLN-05'> jointRelease : SystemLevelRequirement {
            doc /* The NAS shall release a flight only when the dispatcher and the captain both agree
             * that it can be flown safely as planned.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::GovernmentsAndStandardsOrganizations::operatingRulesFollowed;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "14 CFR 121.533";
            :>> rationale = "Kept by the owner (hand review 2026-10-11). In the study: it is why a controller will issue a descent as a tactical change without negotiation and will not issue a climb. There is no question that a descent can be achieved. A climb is different: the released plan vouches for the planned level and nothing above it. That is the reasoning behind the rule of thumb (owner, 2026-10-11; 'DES' in the hand note is descent).";
        }

        requirement <'SLR-PLN-06'> flightPlanFiledWithAtc : SystemLevelRequirement {
            doc /* The NAS shall file each flight plan with air traffic control before the flight
             * departs.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> parentNeeds = (StakeholderRequirements::AirTrafficControl::separationAssured, StakeholderRequirements::AirTrafficControl::demandWithinCapacity);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("faa2025aim", "faa2025jo72103ee");
            :>> rationale = "In the study: the filed plan is the only statement of the airline's intent the controller has today, so it is the baseline that the proposed data share adds to. No lead time is set; the summary of faa2025aim records a 45 to 46 minute point before departure after which a filed plan is locked.";
        }

        requirement <'SLR-PLN-07'> preDepartureInformationToCrew : SystemLevelRequirement {
            doc /* The NAS shall deliver the dispatch release, flight plan, weather, notices to airmen
             * (NOTAMs) and load sheet to the flight crew before departure.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> parentNeeds = StakeholderRequirements::FlightCrews::crewInformedOfWeatherTrafficAndInitiatives;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "In the study: the load sheet is how the actual weight reaches the crew and the flight management system.";
        }
    }

    package ClearanceAndSeparation {
        doc /* Clearance, separation and tactical trajectory change. Place on the trajectory-intent chain: ATC constraints -> trajectory negotiation. */

        public import RequirementDefinitions::*;

        requirement <'SLR-CLR-01'> separationMinimaMaintained : SystemLevelRequirement {
            doc /* The NAS shall keep each pair of controlled aircraft separated by at least the
             * minimum that JO 7110.65BB sets for the airspace they are in.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> parentNeeds = (StakeholderRequirements::AirTrafficControl::separationAssured, StakeholderRequirements::FlightCrews::clearancesAccountForTraffic);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "lateral and vertical distance between each pair of aircraft";
            :>> unitOfMeasure = "NM and ft";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "In the study: the hard constraint every resolution option must meet; it is not traded (knowledge/models/experiment-definition.md section 6). For en-route radar the minimum is commonly 5 NM or 1,000 ft; those numbers are from general knowledge and are left out of the threshold until the paragraph is confirmed.";
        }

        requirement <'SLR-CLR-02'> conflictsPredicted : SystemLevelRequirement {
            doc /* The NAS shall predict a loss of separation between controlled aircraft before it
             * occurs.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = (StakeholderRequirements::AirTrafficControl::separationAssured, StakeholderRequirements::FlightCrews::clearancesAccountForTraffic);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "engility2014tasarAlaska";
            :>> rationale = "In the study: the conflict has to be predicted before any option can be chosen. No look-ahead time is set; engility2014tasarAlaska page 9 uses an eight-minute probe in its own model, which is a candidate.";
        }

        requirement <'SLR-CLR-04'> controllerCrewCommunicationPath : SystemLevelRequirement {
            doc /* The NAS shall provide a two-way communication path from the flight crew to the
             * controlling facility and to the dispatcher for the whole flight.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> parentNeeds = (StakeholderRequirements::FlightCrews::controlAcrossSectors, StakeholderRequirements::Operators::advanceNoticeOfConstraints);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "'Dispatcher too' was added by the owner (hand review 2026-10-10). In the study: the clearance, the crew's 'unable' and any crew request cross this path. It was a derived requirement in the first draft; it now answers SN-CRW-08. 'Of controlled' was struck by the owner (hand review 2026-10-11). It also answers SN-AIR-03: the crew and the dispatchers are the ones who coordinate so that the airline is informed (owner, 2026-10-11).";
        }

        requirement <'SLR-CLR-08'> captainMayDeviateForSafety : SystemLevelRequirement {
            doc /* The NAS shall allow the captain to deviate from a clearance when safety requires it,
             * with air traffic control told as soon as practical.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::GovernmentsAndStandardsOrganizations::operatingRulesFollowed;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "14 CFR 91.3";
            :>> rationale = "14 CFR 91.3. In the study: the owner asks whether leaving the choice to the crew, with a response delay, should be one of the experiment's options. Open.";
        }

        requirement <'SLR-CLR-09'> crewRequestAnswered : SystemLevelRequirement {
            doc /* The NAS shall answer each flight crew request for a route, altitude or speed change
             * with an approval, an amended clearance or a refusal.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::Operators::lowestCostTrajectory;
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "engility2014tasarAlaska";
            :>> rationale = "The owner asked what its relevance is. In the study: a crew request is the only way today that what the aircraft knows about its own weight and best altitude reaches the controller, so it is the baseline counterpart of the proposed data share. Left standing in the second review.";
        }

        requirement <'SLR-CLR-10'> clearanceWithinAircraftCapability : SystemLevelRequirement {
            doc /* The NAS shall issue only clearances that the aircraft can fly. */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::designConstraint;
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> parentNeeds = StakeholderRequirements::FlightCrews::flyableAndTimelyInstructions;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("coppenbarger1999climbPrediction", "engility2014tasarAlaska");
            :>> rationale = "The owner struck 'at its current weight': weight is not required, but it helps when it is included in the model behind a decision aid. Not fully met today: the ground system assumes one nominal weight per aircraft type (coppenbarger1999climbPrediction), and the crew answers 'unable' when a clearance cannot be flown. The rule in D-013 (offer a climb only at or below FL350) stands in for the missing knowledge. Kept as improved (D-018); left standing in the second review.";
        }

        requirement <'SLR-CLR-13'> lowestImpactResolution : SystemLevelRequirement {
            doc /* The NAS should choose, among the maneuvers that restore separation, the one with the
             * lowest impact on the aircraft involved.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> obligation = Obligation::goal; // D-020
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> parentNeeds = (StakeholderRequirements::Operators::airlinePrioritiesInTrajectoryChanges, StakeholderRequirements::EnvironmentalAndSocietalOrganizations::lowCo2PerFlight);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "the experiment's measure of impact: sum over the aircraft involved of fuel cost plus cost index x time";
            :>> unitOfMeasure = "USD per conflict";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "mori2022massCruise", "kirwan2001coraStrategies");
            :>> rationale = "A goal, not a requirement (owner, hand review 2026-10-10). Re-worded by the owner on 2026-10-11: 'impact' replaces 'combined cost' because it is generic and leaves what counts to each controller, and 'with the same number of control instructions' is struck. The held sources agree it is not a duty: the controller's aim is to separate aircraft 'first safely, and then expeditiously' (kirwan2001coraStrategies, p. 4). Not pursued today, because the deciding party lacks the information in SLR-INF-02. In the study: the experiment has to pick one measure of impact to score with; it uses fuel cost plus cost index times time (mori2022massCruise), which is the experiment's choice and not part of this goal.";
        }

        requirement <'SLR-CLR-15'> instructionsWithinSustainableWorkload : SystemLevelRequirement {
            doc /* The NAS shall keep the control instructions needed to resolve a conflict within what
             * the sector team can sustain.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> parentNeeds = StakeholderRequirements::AirTrafficControl::sustainableControllerWorkload;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "instructions issued plus follow-up instructions, per conflict";
            :>> unitOfMeasure = "count";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("rantanen2012conflictManeuvers", "kirwan2001coraStrategies");
            :>> rationale = "New, proposed by Claude on 2026-10-11 so that the restored SN-ATC-04 has an answer; not written by the owner. It replaces the struck goal SLR-CLR-12 (fewest instructions), which the owner rejected: instruction count is not a safety objective, and a controller who is not overworked can give as many as wanted. So the count is a ceiling. No ceiling is set, because no held source gives one. In the study: the experiment's workload column (instructions issued plus follow-ups).";
        }
    }

    package InformationForTrajectoryDecisions {
        doc /* Information for trajectory decisions. Place on the trajectory-intent chain: what the party making each decision must be given. */

        public import RequirementDefinitions::*;

        requirement <'SLR-INF-01'> filedIntentToSectorController : SystemLevelRequirement {
            doc /* The NAS shall give the sector controller the filed route, requested altitude and
             * requested speed of each aircraft before it enters the sector.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> parentNeeds = StakeholderRequirements::AirTrafficControl::separationAssured;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "In the study: this is what the controller knows about each aircraft today (case A of the experiment).";
        }

        requirement <'SLR-INF-02'> decisionInformationToDecidingParty : SystemLevelRequirement {
            doc /* The NAS shall give the party that decides a change to an aircraft's trajectory the
             * information needed to preserve safety and pursue optimality.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> parentNeeds = (StakeholderRequirements::Operators::airlinePrioritiesInTrajectoryChanges, StakeholderRequirements::FlightCrews::flyableAndTimelyInstructions);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "coppenbarger1999climbPrediction", "sheth2010creditsConcept");
            :>> rationale = "Owner's wording (hand review 2026-10-10). It replaces three statements that named gross weight, cost index and connection priority one at a time (the first draft's SLR-INF-02, SLR-INF-03 and SLR-INF-04); the owner judged them implied. Those three items are the attributes of AirlinePerformanceShare in nas_sysml_package_definitions.sysml (D-019) and are where the next tier of requirements starts. Not met today: the controller does not receive weight or cost index (schultz2012adaptiveClimb, page 2). Cases C and D of the experiment.";
        }

        requirement <'SLR-INF-07'> arrivalEstimateUpdates : SystemLevelRequirement {
            doc /* The NAS shall send the airline and the destination airport an updated arrival
             * estimate whenever a flight's estimate changes by more than 5 minutes.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> parentNeeds = (StakeholderRequirements::Operators::onScheduleArrival, StakeholderRequirements::Operators::advanceNoticeOfConstraints);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> measureOfPerformance = "change in estimated arrival time that triggers an update";
            :>> unitOfMeasure = "minutes";
            :>> thresholdValue = 5.0;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "In the study: how the airline learns what a trajectory change did to the arrival time. It answers SN-AIR-03 together with SLR-CLR-04: the crew and the dispatcher coordinate over that path, and this is what they pass. The 5 minutes is the crew-to-dispatch practice in seamster2011collabSystems (survey item: notify dispatch of ETA changes greater than 5 minutes). Extending the same trigger to the airport is this draft's proposal, not the source's.";
        }
    }

    package OnboardExecution {
        doc /* Onboard execution. Place on the trajectory-intent chain: FMS intent -> guidance commands -> aircraft motion. */

        public import RequirementDefinitions::*;

        requirement <'SLR-EXE-02'> conformanceToClearedPath : SystemLevelRequirement {
            doc /* The NAS shall fly each aircraft along its cleared route and at its cleared altitude
             * and speed within the navigation and altitude tolerances of the airspace.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> parentNeeds = StakeholderRequirements::AirTrafficControl::separationAssured;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "cross-track distance from the cleared route; difference from the cleared altitude";
            :>> unitOfMeasure = "NM and ft";
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Owner (hand review 2026-10-10): this has to be accounted for in the separation requirements. In the study: how far an aircraft may stray from its clearance is part of the margin a resolution must leave. 'And speed' was added by the owner (hand review 2026-10-11); no speed tolerance is named yet. No tolerance is set; it depends on the navigation specification of the route, which the scenario has not chosen.";
        }

        requirement <'SLR-EXE-03'> onboardPerformancePredictions : SystemLevelRequirement {
            doc /* The NAS shall predict each flight's arrival time, fuel at destination, optimum
             * altitude and maximum altitude from the aircraft's estimated performance.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = (StakeholderRequirements::Operators::lowestCostTrajectory, StakeholderRequirements::FlightCrews::flyableAndTimelyInstructions);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> evidenceRefs = "mori2022massCruise";
            :>> rationale = "'Estimated performance' is the owner's wording. 'On board' was struck by the owner (hand review 2026-10-11: 'Why on-board? This info is what factors into the FL350 number'): the prediction matters wherever it is made, and it is what sits behind the rule in D-013 that a climb is offered only at or below FL350. On board it is the item FmsPerformancePrediction in nas_sysml_package_definitions.sysml. The airline's flight planning system was added to the allocation by Claude for the same reason.";
        }

        requirement <'SLR-EXE-06'> lowFuelPredictionAlert : SystemLevelRequirement {
            doc /* The NAS shall alert the flight crew, dispatchers and controllers when the fuel
             * predicted at the destination falls below the required reserve.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = (StakeholderRequirements::GovernmentsAndStandardsOrganizations::operatingRulesFollowed, StakeholderRequirements::FlightCrews::flyableAndTimelyInstructions);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "'Dispatchers and controllers' was added by the owner (hand review 2026-10-11). In the study: fuel at the destination is a limit on which resolution an aircraft can accept. The dispatcher and air traffic control were added to the allocation by Claude to match. Whether a controller is alerted this way today was not checked against a source, so the baseline tag is unconfirmed.";
        }
    }

    package AirportAndSurface {
        doc /* Airport and surface. Place on the trajectory-intent chain: start and end of the chain on the ground. */

        public import RequirementDefinitions::*;

        requirement <'SLR-APT-04'> aircraftReadyAtOffBlockTime : SystemLevelRequirement {
            doc /* The NAS shall have each aircraft fuelled, loaded and sealed by its scheduled off-
             * block time.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> parentNeeds = StakeholderRequirements::Operators::onScheduleArrival;
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> measureOfPerformance = "actual off-block time minus scheduled off-block time";
            :>> unitOfMeasure = "minutes";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "schultz2017turnaround";
            :>> rationale = "Owner (hand review 2026-10-10): this speaks to the unknowns in weights and to when the information is available. The final weight is known only when loading ends. 'Sealed' replaces 'closed up' (owner).";
        }
    }

    package MeasurementAndRecords {
        doc /* Measurement and records. Place on the trajectory-intent chain: back up the chain: what is reported to the authorities and stakeholders. */

        public import RequirementDefinitions::*;

        requirement <'SLR-MEA-01'> trajectoryDecisionsRecorded : SystemLevelRequirement {
            doc /* The NAS shall record each change to an aircraft's trajectory, to its clearance, or
             * to the constraints imposed on it, with the authority that issued it and the time.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> parentNeeds = StakeholderRequirements::GovernmentsAndStandardsOrganizations::operatingRulesFollowed;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "Re-worded from the owner's note (hand review 2026-10-10) and left standing in the second review. In the study: the record is what lets a resolution be scored after the fact.";
        }

        requirement <'SLR-MEA-02'> fuelAndCo2ReportedPerFlight : SystemLevelRequirement {
            doc /* The NAS shall report the fuel burned and the CO2 emitted by each flight, at 3.16 kg
             * of CO2 per kg of fuel.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> parentNeeds = (StakeholderRequirements::EnvironmentalAndSocietalOrganizations::lowCo2PerFlight, StakeholderRequirements::Operators::lowestCostTrajectory);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "CO2 emitted per kg of fuel burned";
            :>> unitOfMeasure = "kg CO2 per kg fuel";
            :>> thresholdValue = 3.16;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "icao2024icecMethodology";
            :>> rationale = "In the study: the experiment's fuel column, and the CO2 figure derived from it. icao2024icecMethodology page 6, accepted in D-015. The number is a conversion factor, not a limit.";
        }
    }

    package Allocation {
        doc /* Which constituent systems satisfy each system requirement. One satisfy line
         * per system. The first system listed for a requirement is the one proposed as
         * accountable; the others take part. A first proposal, for the owner to correct.
         * Decision support is allocated to the actor that owns it (D-012). Information
         * Services and Infrastructure are outside NationalAirspaceSystem (D-007), so no
         * requirement is allocated to them. */

        part nasAllocation : NationalAirspaceSystem::NationalAirspaceSystem {

            // Flight planning and release
            satisfy requirement flightPlanContent_dispatcher :> SystemLevelRequirements::FlightPlanningAndRelease::flightPlanContent by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement flightPlanUsesAssignedAircraft_aocDs :> SystemLevelRequirements::FlightPlanningAndRelease::flightPlanUsesAssignedAircraft by flightOperations.airlineOperationsCenter.decisionSupport;
            satisfy requirement flightPlanUsesAssignedAircraft_loadPlanner :> SystemLevelRequirements::FlightPlanningAndRelease::flightPlanUsesAssignedAircraft by flightOperations.airlineOperationsCenter.loadPlanner;
            satisfy requirement fuelReserve_dispatcher :> SystemLevelRequirements::FlightPlanningAndRelease::fuelReserve by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement jointRelease_dispatcher :> SystemLevelRequirements::FlightPlanningAndRelease::jointRelease by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement jointRelease_crew :> SystemLevelRequirements::FlightPlanningAndRelease::jointRelease by flightCrew.flightDeckCrew;
            satisfy requirement flightPlanFiledWithAtc_dispatcher :> SystemLevelRequirements::FlightPlanningAndRelease::flightPlanFiledWithAtc by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement flightPlanFiledWithAtc_atc :> SystemLevelRequirements::FlightPlanningAndRelease::flightPlanFiledWithAtc by airspaceManagement.atc;
            satisfy requirement preDepartureInformationToCrew_dispatcher :> SystemLevelRequirements::FlightPlanningAndRelease::preDepartureInformationToCrew by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement preDepartureInformationToCrew_loadPlanner :> SystemLevelRequirements::FlightPlanningAndRelease::preDepartureInformationToCrew by flightOperations.airlineOperationsCenter.loadPlanner;

            // Clearance, separation and tactical trajectory change
            satisfy requirement separationMinimaMaintained_atc :> SystemLevelRequirements::ClearanceAndSeparation::separationMinimaMaintained by airspaceManagement.atc;
            satisfy requirement separationMinimaMaintained_artcc :> SystemLevelRequirements::ClearanceAndSeparation::separationMinimaMaintained by airspaceManagement.artcc;
            satisfy requirement separationMinimaMaintained_tracon :> SystemLevelRequirements::ClearanceAndSeparation::separationMinimaMaintained by airspaceManagement.tracon;
            satisfy requirement conflictsPredicted_atcDs :> SystemLevelRequirements::ClearanceAndSeparation::conflictsPredicted by airspaceManagement.atc.decisionSupport;
            satisfy requirement controllerCrewCommunicationPath_comms :> SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath by aircraftSystems.aircraft.avionics.communicationSystem;
            satisfy requirement controllerCrewCommunicationPath_atc :> SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath by airspaceManagement.atc;
            satisfy requirement controllerCrewCommunicationPath_dispatcher :> SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement captainMayDeviateForSafety_crew :> SystemLevelRequirements::ClearanceAndSeparation::captainMayDeviateForSafety by flightCrew.flightDeckCrew;
            satisfy requirement crewRequestAnswered_atc :> SystemLevelRequirements::ClearanceAndSeparation::crewRequestAnswered by airspaceManagement.atc;
            satisfy requirement crewRequestAnswered_crew :> SystemLevelRequirements::ClearanceAndSeparation::crewRequestAnswered by flightCrew.flightDeckCrew;
            satisfy requirement clearanceWithinAircraftCapability_atc :> SystemLevelRequirements::ClearanceAndSeparation::clearanceWithinAircraftCapability by airspaceManagement.atc;
            satisfy requirement lowestImpactResolution_atcDs :> SystemLevelRequirements::ClearanceAndSeparation::lowestImpactResolution by airspaceManagement.atc.decisionSupport;
            satisfy requirement lowestImpactResolution_atc :> SystemLevelRequirements::ClearanceAndSeparation::lowestImpactResolution by airspaceManagement.atc;
            satisfy requirement instructionsWithinSustainableWorkload_atc :> SystemLevelRequirements::ClearanceAndSeparation::instructionsWithinSustainableWorkload by airspaceManagement.atc;

            // Information for trajectory decisions
            satisfy requirement filedIntentToSectorController_atc :> SystemLevelRequirements::InformationForTrajectoryDecisions::filedIntentToSectorController by airspaceManagement.atc;
            satisfy requirement filedIntentToSectorController_artcc :> SystemLevelRequirements::InformationForTrajectoryDecisions::filedIntentToSectorController by airspaceManagement.artcc;
            satisfy requirement decisionInformationToDecidingParty_fms :> SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement decisionInformationToDecidingParty_aoc :> SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty by flightOperations.airlineOperationsCenter;
            satisfy requirement decisionInformationToDecidingParty_atcDs :> SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty by airspaceManagement.atc.decisionSupport;
            satisfy requirement decisionInformationToDecidingParty_atc :> SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty by airspaceManagement.atc;
            satisfy requirement arrivalEstimateUpdates_fms :> SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement arrivalEstimateUpdates_crew :> SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates by flightCrew.flightDeckCrew;
            satisfy requirement arrivalEstimateUpdates_aoc :> SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates by flightOperations.airlineOperationsCenter;
            satisfy requirement arrivalEstimateUpdates_airportMgmt :> SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates by airportOperations.airport.airportManagementSystem;

            // Onboard execution
            satisfy requirement conformanceToClearedPath_autoflight :> SystemLevelRequirements::OnboardExecution::conformanceToClearedPath by aircraftSystems.aircraft.avionics.autoFlightControlSystem;
            satisfy requirement conformanceToClearedPath_fms :> SystemLevelRequirements::OnboardExecution::conformanceToClearedPath by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement onboardPerformancePredictions_fms :> SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement onboardPerformancePredictions_aocDs :> SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions by flightOperations.airlineOperationsCenter.decisionSupport;
            satisfy requirement lowFuelPredictionAlert_fms :> SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement lowFuelPredictionAlert_dispatcher :> SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement lowFuelPredictionAlert_atc :> SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert by airspaceManagement.atc;

            // Airport and surface
            satisfy requirement aircraftReadyAtOffBlockTime_groundHandling :> SystemLevelRequirements::AirportAndSurface::aircraftReadyAtOffBlockTime by airportOperations.airport.groundHandling;
            satisfy requirement aircraftReadyAtOffBlockTime_fuelling :> SystemLevelRequirements::AirportAndSurface::aircraftReadyAtOffBlockTime by airportOperations.airport.fuelDistributionSystem;
            satisfy requirement aircraftReadyAtOffBlockTime_crew :> SystemLevelRequirements::AirportAndSurface::aircraftReadyAtOffBlockTime by flightCrew.flightDeckCrew;

            // Measurement and records
            satisfy requirement trajectoryDecisionsRecorded_dispatcher :> SystemLevelRequirements::MeasurementAndRecords::trajectoryDecisionsRecorded by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement trajectoryDecisionsRecorded_atc :> SystemLevelRequirements::MeasurementAndRecords::trajectoryDecisionsRecorded by airspaceManagement.atc;
            satisfy requirement trajectoryDecisionsRecorded_atcscc :> SystemLevelRequirements::MeasurementAndRecords::trajectoryDecisionsRecorded by airspaceManagement.atcscc;
            satisfy requirement fuelAndCo2ReportedPerFlight_fms :> SystemLevelRequirements::MeasurementAndRecords::fuelAndCo2ReportedPerFlight by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement fuelAndCo2ReportedPerFlight_aoc :> SystemLevelRequirements::MeasurementAndRecords::fuelAndCo2ReportedPerFlight by flightOperations.airlineOperationsCenter;
        }
    }
}
