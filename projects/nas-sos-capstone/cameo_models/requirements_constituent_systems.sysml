package ConstituentSystemRequirements {
    doc /*
     * The tier below the system requirements: what each of the five constituent systems
     * of the NAS (D-007's modeled systems) shall do, with that system as the subject of
     * the sentence. The owner calls these HLRs. IDs are HLR-<system>-nn.
     *
     * DRAFT, 2026-10-11. Written by Claude at the owner's request (decision D-022), from
     * the owner's example sentence for the flight crew and the owner's notes on the two
     * marked-up prints. HLR-CRW-01 is the owner's sentence. Every requirement has
     * status = draft. Not reviewed by the owner.
     *
     * HOW TO READ ONE
     *  - The doc comment is the requirement.
     *  - objectiveStatement says, in one sentence, what the requirement is for.
     *  - parentRequirements names the system requirement(s) in
     *    requirements_nas_system.sysml that it comes from. Every system requirement has
     *    at least one requirement here, and every requirement here has a parent.
     *  - candidateMeans lists the different ways the objective can be achieved, where
     *    there is more than one: a rule of thumb, a low-fidelity model, a high-fidelity
     *    model, and a high-fidelity model that also has the airline's connection
     *    priority. These are the experiment's cases A, B, C and D.
     *  - meansScoredInExperiment is true for the 3 requirements whose means the
     *    experiment scores side by side (HLR-ATC-04, HLR-ATC-05, HLR-ATC-06). Their
     *    verification cases, one per means, are in nas_verification.sysml.
     *  - rationale says why the requirement is in the study (D-020).
     *
     * 28 requirements: 5 on flight crew, 7 on flight operations, 9 on air traffic control, 5 on aircraft, 2 on airport operations.
     * Parts of the five systems with no requirement here are listed in
     * knowledge/models/requirements-and-traceability.md section 11, with the reason.
     * If that file and this one disagree, this one wins (D-006).
     *
     * Attribute schema: requirements_definitions.sysml.
     */

    package FlightCrewRequirements {
        doc /* Flight Crew (D-007 modeled system; part flightCrew.flightDeckCrew). */

        public import RequirementDefinitions::*;

        requirement <'HLR-CRW-01'> flightControlledAsCleared : ConstituentSystemRequirement {
            doc /* The flight crew shall safely control the flight from origin to destination, as
             * cleared by air traffic control with or without negotiation, and in collaboration
             * with flight operations.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight crew";
            :>> objectiveStatement = "The aircraft flies the trajectory that was cleared, and only that one, unless safety requires otherwise.";
            :>> parentRequirements = (SystemLevelRequirements::OnboardExecution::conformanceToClearedPath, SystemLevelRequirements::ClearanceAndSeparation::captainMayDeviateForSafety, SystemLevelRequirements::FlightPlanningAndRelease::jointRelease);
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> evidenceRefs = "14 CFR 91.3";
            :>> rationale = "The owner's sentence (2026-10-11), with 'cleared by' for 'cleared with'. In the study: whatever resolution is chosen, it takes effect only when the crew flies it.";
        }

        requirement <'HLR-CRW-02'> unflyableClearanceRefused : ConstituentSystemRequirement {
            doc /* The flight crew shall accept a clearance only if the aircraft can fly it, and shall
             * answer 'unable' when it cannot.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight crew";
            :>> objectiveStatement = "No clearance the aircraft cannot fly is flown.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::clearanceWithinAircraftCapability;
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "coppenbarger1999climbPrediction";
            :>> rationale = "In the study: this is how today's NAS catches a climb the aircraft is too heavy for. It costs a refused clearance and a second one, which the experiment counts as extra instructions.";
        }

        requirement <'HLR-CRW-03'> betterTrajectoryRequested : ConstituentSystemRequirement {
            doc /* The flight crew shall ask air traffic control for a change of route, altitude or
             * speed when the flight management system's predictions show the flight would be
             * better off with it.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight crew";
            :>> objectiveStatement = "What the aircraft knows about its own best altitude and speed reaches the controller.";
            :>> parentRequirements = (SystemLevelRequirements::ClearanceAndSeparation::crewRequestAnswered, SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions);
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "engility2014tasarAlaska";
            :>> rationale = "In the study: a crew request is the only channel for this knowledge today, so it is what the proposed data share is compared with.";
        }

        requirement <'HLR-CRW-04'> dispatcherToldOfTrajectoryChanges : ConstituentSystemRequirement {
            doc /* The flight crew shall tell the dispatcher of each change to the cleared trajectory
             * that moves the estimated arrival time by more than 5 minutes or takes the fuel
             * predicted at the destination below the required reserve.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Flight crew";
            :>> objectiveStatement = "The airline learns of a tactical intervention in time to re-plan.";
            :>> parentRequirements = (SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates, SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert, SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> measureOfPerformance = "change in estimated arrival time that triggers a report";
            :>> unitOfMeasure = "minutes";
            :>> thresholdValue = 5.0;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "Owner (2026-10-11): the crew and the dispatchers are the ones who have to coordinate for the airline to be informed (SN-AIR-03). The 5 minutes is the crew-to-dispatch practice in seamster2011collabSystems. In the study: this is how the cost of a resolution becomes known to the airline that bears it.";
        }

        requirement <'HLR-CRW-05'> weightsAndCostIndexEnteredInFms : ConstituentSystemRequirement {
            doc /* The flight crew shall enter the load sheet weights and the released cost index into
             * the flight management system before departure.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight crew";
            :>> objectiveStatement = "The flight management system predicts from the weight the aircraft actually has.";
            :>> parentRequirements = (SystemLevelRequirements::FlightPlanningAndRelease::preDepartureInformationToCrew, SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Graded [SME] for the owner to confirm from industry experience. In the study: the actual weight exists on board because the crew puts it there; it is the figure the high-fidelity means would share.";
        }
    }

    package FlightOperationsRequirements {
        doc /* Flight Operations (D-007 modeled system; part flightOperations.airlineOperationsCenter and its dispatcher, load planner and decision support). */

        public import RequirementDefinitions::*;

        requirement <'HLR-OPS-01'> flightPlannedFromAircraftPerformance : ConstituentSystemRequirement {
            doc /* Flight operations shall plan each flight's route, cruise altitude, cruise speed and
             * fuel load from a model of the performance of the aircraft assigned to it, with the
             * fuel reserve the operating rules require.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "Each aircraft enters cruise at an altitude, speed and weight chosen for that aircraft.";
            :>> parentRequirements = (SystemLevelRequirements::FlightPlanningAndRelease::flightPlanContent, SystemLevelRequirements::FlightPlanningAndRelease::flightPlanUsesAssignedAircraft, SystemLevelRequirements::FlightPlanningAndRelease::fuelReserve);
            :>> candidateMeans = (MeansOfAchievement::ruleOfThumb, MeansOfAchievement::lowFidelityModel, MeansOfAchievement::highFidelityModel);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("mori2022massCruise", "berry2011aocActors");
            :>> rationale = "Owner (hand review 2026-10-11): the performance model can be a rule of thumb per aircraft type, a low-fidelity model or a high-fidelity model, and the fuel reserve goes into the low-fidelity model's assumptions. The three are listed as means. The experiment does not score them here: it takes each aircraft's plan as given. In the study: the plan sets the level, speed and weight each aircraft has when the conflict occurs.";
        }

        requirement <'HLR-OPS-02'> flightPlanFiledByDispatcher : ConstituentSystemRequirement {
            doc /* The dispatcher shall file each flight's plan with air traffic control before
             * departure.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "The controller has the airline's intended route, altitude and speed.";
            :>> parentRequirements = SystemLevelRequirements::FlightPlanningAndRelease::flightPlanFiledWithAtc;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("faa2025aim", "faa2025jo72103ee");
            :>> rationale = "In the study: the filed plan is all the controller knows of the airline's intent today. It is what the rule of thumb and the low-fidelity means decide with.";
        }

        requirement <'HLR-OPS-03'> releasePackageGivenToCrew : ConstituentSystemRequirement {
            doc /* Flight operations shall give the flight crew the dispatch release, flight plan,
             * weather, notices to airmen (NOTAMs) and load sheet before departure.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "The crew and the flight management system start from the plan and the actual weights.";
            :>> parentRequirements = SystemLevelRequirements::FlightPlanningAndRelease::preDepartureInformationToCrew;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "In the study: the load sheet is where the actual weight enters the aircraft.";
        }

        requirement <'HLR-OPS-04'> dispatcherReleasesWithCaptain : ConstituentSystemRequirement {
            doc /* The dispatcher shall release a flight only with the captain's agreement that it can
             * be flown safely as planned.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "The planned cruise level is one the dispatcher and the captain have both agreed the aircraft can fly.";
            :>> parentRequirements = SystemLevelRequirements::FlightPlanningAndRelease::jointRelease;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "14 CFR 121.533";
            :>> rationale = "Owner (2026-10-11): there is no question that a descent can be achieved; a climb is different, and the joint release is what leads to that conclusion in the rule-of-thumb case. The released plan vouches for the planned level and below, and for nothing above it. In the study: this is the reason the rule of thumb descends and does not climb.";
        }

        requirement <'HLR-OPS-05'> performanceShareProvided : ConstituentSystemRequirement {
            doc /* Flight operations shall make each flight's current gross weight, cost index and
             * connection priority available to the party that decides a change to that flight's
             * trajectory.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "The party deciding can tell what each aircraft can fly and what a change costs its airline.";
            :>> parentRequirements = SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "coppenbarger1999climbPrediction", "sheth2010creditsConcept");
            :>> rationale = "The three items the first draft listed one at a time and SLR-INF-02 absorbed. They are the attributes of AirlinePerformanceShare in nas_sysml_package_definitions.sysml (D-019). Not done today (schultz2012adaptiveClimb, page 2). In the study: this is what separates the high-fidelity means (weight and cost index, case C; plus connection priority, case D) from the other two. Confidentiality is an assumption (D-020).";
        }

        requirement <'HLR-OPS-06'> flightRePlannedWithCrew : ConstituentSystemRequirement {
            doc /* The dispatcher shall re-plan the flight with its crew when a trajectory change puts
             * the arrival time or the fuel at the destination at risk.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "A tactical intervention is absorbed by the airline's plan and not only by the one flight.";
            :>> parentRequirements = (SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath, SystemLevelRequirements::InformationForTrajectoryDecisions::arrivalEstimateUpdates, SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert);
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "seamster2011collabSystems";
            :>> rationale = "The dispatcher's half of the coordination the owner named for SN-AIR-03 (2026-10-11); HLR-CRW-04 is the crew's half. In the study: context for case D, where a late flight with connections is the reason one aircraft's time is worth more than its fuel.";
        }

        requirement <'HLR-OPS-07'> fuelAndCo2ReportedByAirline : ConstituentSystemRequirement {
            doc /* Flight operations shall report each flight's fuel burned and its CO2 emitted at 3.16
             * kg of CO2 per kg of fuel.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> constituentSystem = "Flight operations";
            :>> objectiveStatement = "The fuel and CO2 effect of a trajectory change can be counted.";
            :>> parentRequirements = SystemLevelRequirements::MeasurementAndRecords::fuelAndCo2ReportedPerFlight;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "CO2 emitted per kg of fuel burned";
            :>> unitOfMeasure = "kg CO2 per kg fuel";
            :>> thresholdValue = 3.16;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "icao2024icecMethodology";
            :>> rationale = "In the study: the experiment's fuel column and the CO2 figure derived from it (D-015).";
        }
    }

    package AirspaceManagementRequirements {
        doc /* Airspace Management (D-007 modeled system; parts airspaceManagement.atc, its decision support, and the en-route center). */

        public import RequirementDefinitions::*;

        requirement <'HLR-ATC-01'> separationKeptWithConformanceMargin : ConstituentSystemRequirement {
            doc /* Air traffic control shall keep each pair of aircraft it controls separated by at
             * least the applicable minimum, allowing for each aircraft's permitted deviation from
             * its cleared route, altitude and speed.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "No loss of separation.";
            :>> parentRequirements = (SystemLevelRequirements::ClearanceAndSeparation::separationMinimaMaintained, SystemLevelRequirements::OnboardExecution::conformanceToClearedPath);
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "lateral and vertical distance between each pair of aircraft";
            :>> unitOfMeasure = "NM and ft";
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "Owner (hand review 2026-10-10): conformance has to be accounted for in the separation requirements. In the study: the hard constraint on every resolution option, whichever means chooses it.";
        }

        requirement <'HLR-ATC-02'> controllerAlertedToPredictedConflict : ConstituentSystemRequirement {
            doc /* ATC decision support shall alert the sector controller to each predicted loss of
             * separation before it occurs.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "The controller has time to choose a resolution and not only to react.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::conflictsPredicted;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "engility2014tasarAlaska";
            :>> rationale = "In the study: the starting event of the experiment. No look-ahead time is set; engility2014tasarAlaska page 9 uses eight minutes in its own model.";
        }

        requirement <'HLR-ATC-03'> filedIntentShownToController : ConstituentSystemRequirement {
            doc /* The en-route center shall show the sector controller each aircraft's filed route,
             * requested altitude and requested speed before the aircraft enters the sector.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "The controller knows where each aircraft intends to go.";
            :>> parentRequirements = SystemLevelRequirements::InformationForTrajectoryDecisions::filedIntentToSectorController;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo711065bb";
            :>> rationale = "In the study: together with type, level and speed, this is the whole of 'today's information' that the rule of thumb decides with (case A).";
        }

        requirement <'HLR-ATC-04'> conflictResolvedWithFlyableClearance : ConstituentSystemRequirement {
            doc /* Air traffic control shall resolve each predicted conflict with a clearance that
             * every aircraft it moves can fly.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::designConstraint;
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "The conflict is resolved by the first clearance issued, with no 'unable' and no second attempt.";
            :>> parentRequirements = (SystemLevelRequirements::ClearanceAndSeparation::clearanceWithinAircraftCapability, SystemLevelRequirements::ClearanceAndSeparation::separationMinimaMaintained);
            :>> candidateMeans = (MeansOfAchievement::ruleOfThumb, MeansOfAchievement::lowFidelityModel, MeansOfAchievement::highFidelityModel, MeansOfAchievement::highFidelityModelWithConnections);
            :>> meansScoredInExperiment = true;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "whether the chosen option is flyable under the truth model";
            :>> unitOfMeasure = "yes or no";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("coppenbarger1999climbPrediction", "engility2014tasarAlaska");
            :>> rationale = "Four means of knowing what an aircraft can fly, scored in the experiment. Rule of thumb: descend, and offer a climb only at or below FL350 (D-013, from engility2014tasarAlaska page 8; the joint release in HLR-OPS-04 is why a descent is safe to assume). Low-fidelity model: one nominal weight per aircraft type (coppenbarger1999climbPrediction). High-fidelity model: each aircraft's own weight, shared under HLR-OPS-05. The fourth adds connection priority, which does not change what can be flown. The truth model's thrust check (NasAnalysis::CanHoldLevel) says whether the option each means chose was flyable.";
        }

        requirement <'HLR-ATC-05'> lowestImpactResolutionChosen : ConstituentSystemRequirement {
            doc /* Air traffic control should choose, among the clearances that resolve a conflict and
             * can be flown, the one with the lowest impact on the aircraft involved.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> obligation = Obligation::goal; // as its parent, D-020
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "Lowest impact on the aircraft involved. The experiment scores impact as fuel burned and as airline cost (fuel cost plus cost index times time), per aircraft and summed.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::lowestImpactResolution;
            :>> candidateMeans = (MeansOfAchievement::ruleOfThumb, MeansOfAchievement::lowFidelityModel, MeansOfAchievement::highFidelityModel, MeansOfAchievement::highFidelityModelWithConnections);
            :>> meansScoredInExperiment = true;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "fuel burned and airline cost, per aircraft and summed over the aircraft involved";
            :>> unitOfMeasure = "kg and USD per conflict";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "mori2022massCruise", "kirwan2001coraStrategies");
            :>> rationale = "A goal, like its parent SLR-CLR-13. Four means of judging impact, scored in the experiment. Rule of thumb: one descent, by the controller's rule (rantanen2012conflictManeuvers: 23 of 36 observed cases). Low-fidelity model: lowest estimated cost with one nominal weight per type, which cannot tell two aircraft of one type apart. High-fidelity model: lowest estimated cost with each aircraft's own weight and cost index. High-fidelity model plus connections: the same, with the airline's connection priority. One truth model scores what each means chose.";
        }

        requirement <'HLR-ATC-06'> conflictResolvedWithinWorkload : ConstituentSystemRequirement {
            doc /* Air traffic control shall resolve each predicted conflict within the number of
             * instructions the sector team can sustain.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "Controller workload stays under its ceiling whichever means chooses the resolution.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::instructionsWithinSustainableWorkload;
            :>> candidateMeans = (MeansOfAchievement::ruleOfThumb, MeansOfAchievement::lowFidelityModel, MeansOfAchievement::highFidelityModel, MeansOfAchievement::highFidelityModelWithConnections);
            :>> meansScoredInExperiment = true;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "instructions issued plus follow-up instructions, per conflict";
            :>> unitOfMeasure = "count";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("rantanen2012conflictManeuvers", "kirwan2001coraStrategies");
            :>> rationale = "No ceiling is set, as on the parent SLR-CLR-15, so the experiment reports the count for each means and does not pass or fail it. In the study: the experiment's workload column, which is how a cheaper resolution that takes more instructions is shown for what it is.";
        }

        requirement <'HLR-ATC-07'> crewRequestAnsweredByController : ConstituentSystemRequirement {
            doc /* Air traffic control shall answer each flight crew request for a route, altitude or
             * speed change with an approval, an amended clearance or 'unable'.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "A crew request is never left open.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::crewRequestAnswered;
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = ("faa2025jo711065bb", "engility2014tasarAlaska");
            :>> rationale = "JO 7110.65BB paragraph 2-1-18, as recorded in evidence/literature-notes/summaries/5 - faa2025jo711065bb.md (which also allows 'stand by'). In the study: the controller's half of the request channel in HLR-CRW-03.";
        }

        requirement <'HLR-ATC-08'> performanceShareUsedInResolution : ConstituentSystemRequirement {
            doc /* ATC decision support shall use each flight's shared gross weight, cost index and
             * connection priority, when the airline has shared them, to judge which clearances the
             * aircraft can fly and what each costs.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> architectureState = ArchitectureState::improved; // D-018
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "The shared information changes the decision and does not only arrive.";
            :>> parentRequirements = SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = ("schultz2012adaptiveClimb", "coppenbarger1999climbPrediction");
            :>> rationale = "The receiving end of HLR-OPS-05 (D-019: decision support is owned by the system that decides, D-012). Not done today. In the study: the difference between case B and cases C and D.";
        }

        requirement <'HLR-ATC-09'> clearancesRecorded : ConstituentSystemRequirement {
            doc /* Air traffic control shall record each clearance it issues with the issuing facility
             * and the time.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Air traffic control";
            :>> objectiveStatement = "A resolution can be examined after the fact.";
            :>> parentRequirements = SystemLevelRequirements::MeasurementAndRecords::trajectoryDecisionsRecorded;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::normativeSource;
            :>> evidenceRefs = "faa2025jo72103ee";
            :>> rationale = "In the study: the record is what a real-world version of the experiment's instruction count would be taken from.";
        }
    }

    package AircraftSystemsRequirements {
        doc /* Aircraft Systems (D-007 modeled system; part aircraftSystems.aircraft and its avionics). */

        public import RequirementDefinitions::*;

        requirement <'HLR-ACF-01'> fmsPredictsPerformance : ConstituentSystemRequirement {
            doc /* The flight management system shall predict the flight's arrival time, fuel at the
             * destination, optimum altitude and maximum altitude from the entered weights, the
             * cost index and the forecast winds.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Aircraft";
            :>> objectiveStatement = "The aircraft knows what it can fly and what is best for it.";
            :>> parentRequirements = SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> evidenceRefs = "mori2022massCruise";
            :>> rationale = "Graded [SME]. The item FmsPerformancePrediction in nas_sysml_package_definitions.sysml. In the study: the on-board high-fidelity model. Its maximum altitude is the answer the rule of thumb replaces with 'at or below FL350'.";
        }

        requirement <'HLR-ACF-02'> clearedPathHeldByAutoflight : ConstituentSystemRequirement {
            doc /* The auto flight control system shall hold the aircraft on its cleared route,
             * altitude and speed within the tolerances of the airspace.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> constituentSystem = "Aircraft";
            :>> objectiveStatement = "The aircraft is where its clearance says it is.";
            :>> parentRequirements = SystemLevelRequirements::OnboardExecution::conformanceToClearedPath;
            :>> verificationMethod = VerificationMethod::byAnalysis;
            :>> measureOfPerformance = "cross-track distance from the cleared route; difference from the cleared altitude and speed";
            :>> unitOfMeasure = "NM, ft and Mach";
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Graded [SME]. No tolerance is set. In the study: the deviation HLR-ATC-01 has to allow for.";
        }

        requirement <'HLR-ACF-03'> crewAlertedToLowPredictedFuel : ConstituentSystemRequirement {
            doc /* The flight management system shall alert the flight crew when the fuel it predicts
             * at the destination falls below the required reserve.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::functional;
            :>> constituentSystem = "Aircraft";
            :>> objectiveStatement = "The crew knows when a trajectory change has used up the fuel margin.";
            :>> parentRequirements = SystemLevelRequirements::OnboardExecution::lowFuelPredictionAlert;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Graded [SME]. The parent SLR-EXE-06 also names dispatchers and controllers; they hear through the crew (HLR-CRW-04). In the study: fuel at the destination is a limit on which resolution an aircraft can accept.";
        }

        requirement <'HLR-ACF-04'> crewLinkedToAtcAndDispatcher : ConstituentSystemRequirement {
            doc /* The aircraft communication system shall carry voice and data between the flight crew
             * and both air traffic control and the dispatcher for the whole flight.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Aircraft";
            :>> objectiveStatement = "Clearances, refusals, requests and reports to the airline can all be exchanged from the flight deck.";
            :>> parentRequirements = SystemLevelRequirements::ClearanceAndSeparation::controllerCrewCommunicationPath;
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "Graded [SME]. In the study: every exchange the experiment counts as an instruction crosses this link.";
        }

        requirement <'HLR-ACF-05'> fmsFiguresSentToAirline : ConstituentSystemRequirement {
            doc /* The flight management system shall send its current gross weight and its predicted
             * optimum and maximum altitudes to the airline operations center.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Aircraft";
            :>> objectiveStatement = "The airline holds the aircraft's own figures, so that it can share them (HLR-OPS-05).";
            :>> parentRequirements = (SystemLevelRequirements::InformationForTrajectoryDecisions::decisionInformationToDecidingParty, SystemLevelRequirements::OnboardExecution::onboardPerformancePredictions);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::ownerExpertise;
            :>> rationale = "The FMS-to-airline exchange named as one of the three on the thread in D-019 item 4. Whether aircraft do this today is for the owner to say [SME]; it is left as baseline because D-019 tags only the airline-to-ATC exchange as improved. In the study: the first link of the high-fidelity means.";
        }
    }

    package AirportOperationsRequirements {
        doc /* Airport Operations (D-007 modeled system; part airportOperations.airport and its ground handling and fuelling). */

        public import RequirementDefinitions::*;

        requirement <'HLR-APT-01'> aircraftReadyByOffBlockTime : ConstituentSystemRequirement {
            doc /* Airport operations shall have each aircraft fuelled, loaded and sealed by its
             * scheduled off-block time.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::performance;
            :>> constituentSystem = "Airport operations";
            :>> objectiveStatement = "The flight leaves on schedule with its load complete.";
            :>> parentRequirements = SystemLevelRequirements::AirportAndSurface::aircraftReadyAtOffBlockTime;
            :>> verificationMethod = VerificationMethod::byDemonstration;
            :>> measureOfPerformance = "actual off-block time minus scheduled off-block time";
            :>> unitOfMeasure = "minutes";
            :>> basis = EvidenceGrade::literature;
            :>> evidenceRefs = "schultz2017turnaround";
            :>> rationale = "In the study: the weakest link of the five systems. It matters only because the weight is not final until loading ends.";
        }

        requirement <'HLR-APT-02'> actualFuelAndLoadReported : ConstituentSystemRequirement {
            doc /* Airport operations shall report the fuel uplifted and the load put on board to the
             * flight crew and the load planner before off-block.
             */
            :>> status = RequirementStatus::draft;
            :>> kind = RequirementKind::interfaceRequirement;
            :>> constituentSystem = "Airport operations";
            :>> objectiveStatement = "The weight used on board and by the airline is the weight the aircraft has.";
            :>> parentRequirements = (SystemLevelRequirements::AirportAndSurface::aircraftReadyAtOffBlockTime, SystemLevelRequirements::FlightPlanningAndRelease::preDepartureInformationToCrew);
            :>> verificationMethod = VerificationMethod::byInspection;
            :>> basis = EvidenceGrade::generalKnowledge;
            :>> rationale = "D-009 records the fuel slip reaching the crew from the airport fuel carrier; the load report is from general knowledge. In the study: the owner's note on SLR-APT-04, that it speaks to the unknowns in weights and to when the information is available.";
        }
    }

    package Allocation {
        doc /* Which part of NationalAirspaceSystem satisfies each requirement in this file.
         * The first part listed is the one accountable. */

        part hlrAllocation : NationalAirspaceSystem::NationalAirspaceSystem {

            // Flight crew
            satisfy requirement flightControlledAsCleared_crew :> ConstituentSystemRequirements::FlightCrewRequirements::flightControlledAsCleared by flightCrew.flightDeckCrew;
            satisfy requirement unflyableClearanceRefused_crew :> ConstituentSystemRequirements::FlightCrewRequirements::unflyableClearanceRefused by flightCrew.flightDeckCrew;
            satisfy requirement betterTrajectoryRequested_crew :> ConstituentSystemRequirements::FlightCrewRequirements::betterTrajectoryRequested by flightCrew.flightDeckCrew;
            satisfy requirement dispatcherToldOfTrajectoryChanges_crew :> ConstituentSystemRequirements::FlightCrewRequirements::dispatcherToldOfTrajectoryChanges by flightCrew.flightDeckCrew;
            satisfy requirement weightsAndCostIndexEnteredInFms_crew :> ConstituentSystemRequirements::FlightCrewRequirements::weightsAndCostIndexEnteredInFms by flightCrew.flightDeckCrew;

            // Flight operations
            satisfy requirement flightPlannedFromAircraftPerformance_aocDs :> ConstituentSystemRequirements::FlightOperationsRequirements::flightPlannedFromAircraftPerformance by flightOperations.airlineOperationsCenter.decisionSupport;
            satisfy requirement flightPlannedFromAircraftPerformance_dispatcher :> ConstituentSystemRequirements::FlightOperationsRequirements::flightPlannedFromAircraftPerformance by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement flightPlannedFromAircraftPerformance_loadPlanner :> ConstituentSystemRequirements::FlightOperationsRequirements::flightPlannedFromAircraftPerformance by flightOperations.airlineOperationsCenter.loadPlanner;
            satisfy requirement flightPlanFiledByDispatcher_dispatcher :> ConstituentSystemRequirements::FlightOperationsRequirements::flightPlanFiledByDispatcher by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement releasePackageGivenToCrew_dispatcher :> ConstituentSystemRequirements::FlightOperationsRequirements::releasePackageGivenToCrew by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement releasePackageGivenToCrew_loadPlanner :> ConstituentSystemRequirements::FlightOperationsRequirements::releasePackageGivenToCrew by flightOperations.airlineOperationsCenter.loadPlanner;
            satisfy requirement dispatcherReleasesWithCaptain_dispatcher :> ConstituentSystemRequirements::FlightOperationsRequirements::dispatcherReleasesWithCaptain by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement performanceShareProvided_aoc :> ConstituentSystemRequirements::FlightOperationsRequirements::performanceShareProvided by flightOperations.airlineOperationsCenter;
            satisfy requirement flightRePlannedWithCrew_dispatcher :> ConstituentSystemRequirements::FlightOperationsRequirements::flightRePlannedWithCrew by flightOperations.airlineOperationsCenter.dispatcher;
            satisfy requirement fuelAndCo2ReportedByAirline_aoc :> ConstituentSystemRequirements::FlightOperationsRequirements::fuelAndCo2ReportedByAirline by flightOperations.airlineOperationsCenter;

            // Air traffic control
            satisfy requirement separationKeptWithConformanceMargin_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::separationKeptWithConformanceMargin by airspaceManagement.atc;
            satisfy requirement separationKeptWithConformanceMargin_artcc :> ConstituentSystemRequirements::AirspaceManagementRequirements::separationKeptWithConformanceMargin by airspaceManagement.artcc;
            satisfy requirement controllerAlertedToPredictedConflict_atcDs :> ConstituentSystemRequirements::AirspaceManagementRequirements::controllerAlertedToPredictedConflict by airspaceManagement.atc.decisionSupport;
            satisfy requirement filedIntentShownToController_artcc :> ConstituentSystemRequirements::AirspaceManagementRequirements::filedIntentShownToController by airspaceManagement.artcc;
            satisfy requirement conflictResolvedWithFlyableClearance_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::conflictResolvedWithFlyableClearance by airspaceManagement.atc;
            satisfy requirement conflictResolvedWithFlyableClearance_atcDs :> ConstituentSystemRequirements::AirspaceManagementRequirements::conflictResolvedWithFlyableClearance by airspaceManagement.atc.decisionSupport;
            satisfy requirement lowestImpactResolutionChosen_atcDs :> ConstituentSystemRequirements::AirspaceManagementRequirements::lowestImpactResolutionChosen by airspaceManagement.atc.decisionSupport;
            satisfy requirement lowestImpactResolutionChosen_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::lowestImpactResolutionChosen by airspaceManagement.atc;
            satisfy requirement conflictResolvedWithinWorkload_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::conflictResolvedWithinWorkload by airspaceManagement.atc;
            satisfy requirement crewRequestAnsweredByController_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::crewRequestAnsweredByController by airspaceManagement.atc;
            satisfy requirement performanceShareUsedInResolution_atcDs :> ConstituentSystemRequirements::AirspaceManagementRequirements::performanceShareUsedInResolution by airspaceManagement.atc.decisionSupport;
            satisfy requirement clearancesRecorded_atc :> ConstituentSystemRequirements::AirspaceManagementRequirements::clearancesRecorded by airspaceManagement.atc;

            // Aircraft
            satisfy requirement fmsPredictsPerformance_fms :> ConstituentSystemRequirements::AircraftSystemsRequirements::fmsPredictsPerformance by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement clearedPathHeldByAutoflight_autoflight :> ConstituentSystemRequirements::AircraftSystemsRequirements::clearedPathHeldByAutoflight by aircraftSystems.aircraft.avionics.autoFlightControlSystem;
            satisfy requirement clearedPathHeldByAutoflight_fms :> ConstituentSystemRequirements::AircraftSystemsRequirements::clearedPathHeldByAutoflight by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement crewAlertedToLowPredictedFuel_fms :> ConstituentSystemRequirements::AircraftSystemsRequirements::crewAlertedToLowPredictedFuel by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement crewLinkedToAtcAndDispatcher_comms :> ConstituentSystemRequirements::AircraftSystemsRequirements::crewLinkedToAtcAndDispatcher by aircraftSystems.aircraft.avionics.communicationSystem;
            satisfy requirement fmsFiguresSentToAirline_fms :> ConstituentSystemRequirements::AircraftSystemsRequirements::fmsFiguresSentToAirline by aircraftSystems.aircraft.avionics.flightManagementSystem;
            satisfy requirement fmsFiguresSentToAirline_comms :> ConstituentSystemRequirements::AircraftSystemsRequirements::fmsFiguresSentToAirline by aircraftSystems.aircraft.avionics.communicationSystem;

            // Airport operations
            satisfy requirement aircraftReadyByOffBlockTime_groundHandling :> ConstituentSystemRequirements::AirportOperationsRequirements::aircraftReadyByOffBlockTime by airportOperations.airport.groundHandling;
            satisfy requirement aircraftReadyByOffBlockTime_fuelling :> ConstituentSystemRequirements::AirportOperationsRequirements::aircraftReadyByOffBlockTime by airportOperations.airport.fuelDistributionSystem;
            satisfy requirement actualFuelAndLoadReported_fuelling :> ConstituentSystemRequirements::AirportOperationsRequirements::actualFuelAndLoadReported by airportOperations.airport.fuelDistributionSystem;
            satisfy requirement actualFuelAndLoadReported_groundHandling :> ConstituentSystemRequirements::AirportOperationsRequirements::actualFuelAndLoadReported by airportOperations.airport.groundHandling;
        }
    }
}
