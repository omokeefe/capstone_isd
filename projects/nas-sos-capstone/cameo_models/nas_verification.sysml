package NasVerification {
    doc /* Verification cases for the requirements the experiment exercises (D-018, 2026-10-10;
     * revised 2026-11-05, D-040).
     * INCOSE layering, as used here: the verification case is the test procedure; the
     * analysis (NasAnalysis::ConflictResolutionScoring, run by experiment_scoring.py)
     * executes it and produces the measures of performance; the measures of effectiveness
     * are read off the outcome table per stakeholder level. The measured values land in
     * results/experiment_results.sysml, which the script generates.
     *
     * System requirements: three verification defs for SLR-INF-02 (one per kind of
     * information shared: the aircraft's state and performance, the airline's cost of time,
     * its connection priority), one each for SLR-CLR-10 (baseline since D-040) and
     * SLR-CLR-13 (a requirement since D-040, was a goal), plus one for the
     * instruction-count requirement (SLR-CLR-15, D-021).
     * Constituent system requirements: one def for each improved HLR (HLR-OPS-05,
     * HLR-ATC-08, HLR-ATC-10, HLR-ATC-11), and one per means for the three HLRs whose means
     * the experiment scores side by side (HLR-ATC-04, HLR-ATC-05, HLR-ATC-06).
     * Each def names the experiment case that exercises it.
     *
     * VERIFICATION STATEMENTS (D-040; form set by the owner 2026-11-07). Every def that
     * verifies a requirement has two docs, in this order:
     *   1. the def's doc: "<ID>: Verify that <the concept tested>." Generic, with no
     *      experiment detail.
     *   2. the objective's doc: "By <method>, <case or cases>: met if <what counts as met>."
     *      The means of testing it, with the experiment's representation named.
     * Notes on history and rationale follow as // comments, so they stay out of both.
     * tools/export_report_tables.py prints the objective's doc in the report's table of
     * improved HLRs, with the def's name. Drafted by Claude, 2026-11-05 and 2026-11-07, for
     * the owner to review.
     * tools/check_model.py (plan turn 5) asserts every `improved` requirement is verified. */

    public import ScalarValues::*;
    private import SystemLevelRequirements::ClearanceAndSeparation::*;
    private import SystemLevelRequirements::InformationForTrajectoryDecisions::*;
    private import NasAnalysis::*;
    private import RequirementDefinitions::MeansOfAchievement;
    private import ConstituentSystemRequirements::AirspaceManagementRequirements::*;
    private import ConstituentSystemRequirements::FlightOperationsRequirements::*;

    verification def VerifyByExperimentCase {
        doc /* Common shape: which case of the experiment is the procedure, which scenario
         * file it runs on, and what was measured when it ran. The scenario file holds the
         * flights (NasAnalysis::ScenarioFlight) and the options
         * (NasAnalysis::ResolutionOption); its values are cited here by file and are not
         * repeated in the model (D-025).
         * The procedure has two steps in order: confirm the analysis tool matches the model,
         * then run the case (D-036). The first is a setup step on the test equipment, not a
         * verification of any requirement. */
        attribute experimentCase : String; // "A", "B", "C" or "D"
        attribute scenarioFile : String default "projects/nas-sos-capstone/simulation/scenario_base.yaml";
        attribute measuredSystemDeltaFuelKg : Real[0..1];
        attribute measuredInstructions : Integer[0..1];
        // Configuration of the run, recorded with the measured values (D-036).
        attribute modelCommit : String[0..1]; // git commit of the model and code the run used
        attribute toolConformsToModel : Boolean[0..1]; // test_model_conformance.py passed before the run
        subject scoring : ConflictResolutionScoring;

        action confirmToolConformsToModel {
            doc /* Run projects/nas-sos-capstone/simulation/test_model_conformance.py. If it
             * fails, stop: the case is not run. It confirms that the names and enumeration
             * values in nas_types.py, experiment_scoring.py and scenario_base.yaml are
             * defined in the model (D-025). It does not check units, physics or whether the
             * scoring is right; validating the dynamics model is separate (to-do-list §12). */
        }
        then action runExperimentCase {
            doc /* Score the case with tools/run_experiment.py and read the measured values
             * from results/experiment_results.sysml. */
        }
    }

    // Test procedures for the system requirements the experiment exercises. 
    // Verification def "TestProcedure" is a VerifyByExperimentCase TP with the objective to verify the requirement. 
    // The doc in the def is the one-sentence description of what is verified, and the doc in the objective is the one-sentence description of how it is verified and what counts as met (D-040, 2026-11-05).
    verification def VerifyPerformanceToDecidingParty :> VerifyByExperimentCase {
        doc /* SLR-INF-02: Verify that the deciding party has the aircraft state and performance
         * information it needs. */
        objective {
            doc /* By analysis, case C against cases A and B: met if, given each aircraft's
             * weight, the deciding party can offer the light aircraft a climb that cases A and
             * B cannot. */
            verify decisionInformationToDecidingParty;
        }
        // One of three defs on SLR-INF-02, which since the hand review of 2026-10-10 (D-020)
        // covers everything shared in one statement. Was VerifyWeightToDecidingParty (D-040).
        // In Case A, the deciding party has only the type's nominal weight, which is not sufficient to consider viable and possibly more optimal solutions, like climbs; however decisions can still be made, which highlight the ambiguities in "need". If the aircraft can, indeed, fly to a higher altitude and it's a more optimal solution, then the controller/decision aide does not have the information it needs. For this reason, Case A should fail, if Case C chooses a different option. 
        // In Case B, the deciding party has the aircraft's weight, but not its performance. If the aircraft can, indeed, fly to a higher altitude and it's a more optimal solution, then the controller/decision aide does not have the information it needs. For this reason, Case B should fail, if Case C chooses a different option.
        // In Cases C & D, the deciding party has both the aircraft's weight and performance information, allowing it to make informed decisions about optimal solutions. These cases should pass, if the option chosen is different than Cases A & B.
    }

    verification def VerifyCostOfTimeToDecidingParty :> VerifyByExperimentCase {
        doc /* SLR-INF-02: Verify that the deciding party has the airline's cost of time it
         * needs. */
        objective {
            doc /* By analysis, case C: met if the option chosen changes with the pair's cost
             * index, with the similar-weights variation as the control. */
            verify decisionInformationToDecidingParty;
        }
        // Second def on SLR-INF-02. Was VerifyCostIndexToDecidingParty (D-040).
        // It was observed that a CI = 0 chose a different solution than a CI = 30, which is the expected behavior. The CI = 0 solution was a descent, while the CI = 30 solution was a climb. This shows that the deciding party has the information it needs to make decisions based on the airline's cost of time ONLY if it has an accurate estimate of its CI. If the CI is not accurate, then the deciding party does not have the information it needs to make decisions based on the airline's cost of time. For this reason, Case C & D should pass, if the option chosen is different than Cases A & B.
    }

    verification def VerifyConnectionPriorityToDecidingParty :> VerifyByExperimentCase {
        doc /* SLR-INF-02: Verify that the deciding party has the airline's connection priorities
         * it needs. */
        objective {
            doc /* By analysis, case D against case C: met if, where case C's choice delays a
             * flight with connections past its delay margin (ExperimentPerformanceShare.
             * delayMarginMin, the minutes of further delay before connections are lost), case D
             * chooses an option that does not. */
            verify decisionInformationToDecidingParty;
        }
        // Third def on SLR-INF-02. Delay margin per D-025. Pass rule drafted by Claude,
        // 2026-11-07 (none was stated before); owner to review.
        // It is not expected that Case D & C result in different solutions, but if they do, it shows that the Case D deciding party has the information it needs to make decisions based on the airline's connection priorities. If Case D & C choose the same solution, then both cases have the information they need to make decisions based on the airline's connection priorities, at least in the chosen scenario. For this reason, Case C should  only fail if Case D chooses a different solution than Case C.
    }

    verification def VerifyClearanceWithinCapability :> VerifyByExperimentCase {
        doc /* SLR-CLR-10: Verify that the NAS issues only clearances the aircraft can fly. */
        objective {
            doc /* By analysis, case C: met if the option chosen passes the truth model's thrust
             * check for every aircraft it moves. */
            verify clearanceWithinAircraftCapability;
        }
        // Baseline since D-040 (the rule's descent meets it); kept because every case is
        // measured on it.
        // This is a requirement that is expected to be met in all cases. A case will fail if the recommended solution is found to be un-flyable by the aircraft when tested with a higher fidelity model. This is a safety requirement that must be met in all cases. 
    }

    verification def VerifyLowestImpactResolution :> VerifyByExperimentCase {
        doc /* SLR-CLR-13: Verify that the NAS resolves a conflict with the maneuver that has the
         * lowest impact on the aircraft involved. */
        objective {
            doc /* By analysis, cases C and D against case B: met if the option chosen has the
             * lowest impact among the options that restore separation, scored as fuel cost
             * plus cost index times time. */
            verify lowestImpactResolution;
        }
        // A requirement since D-040 (was a goal, D-020, D-021).
        // This is a requirement that requires more information - whether tested at the individual aircraft level, the airspace (aircraft group) level, or a higher level (airline, NAS SoI). I should speak in the report to the level of the requirement, and discussing how the pass/fail decision changes when viewing the requirement at different levels. 
    }

    verification def VerifyInstructionsWithinWorkload :> VerifyByExperimentCase {
        doc /* SLR-CLR-15: Verify that resolving a conflict takes no more instructions than the
         * sector team can sustain. */
        objective {
            doc /* By analysis, case A (baseline) against cases C and D: the instructions issued
             * plus follow-ups are counted and reported; no ceiling is set, so there is no pass
             * or fail. */
            verify instructionsWithinSustainableWorkload;
        }
        // SLR-CLR-15 replaced the struck goal SLR-CLR-12 on 2026-10-11 (D-021).
        // This is a requirement that is expected to be met in all cases. A case will fail if the number of instructions issued exceeds the sustainable workload of the sector team, which will be defined sufficiently high to provide for clearance to a new altitude and re-clearance to the prior altitude. This is a safety requirement that must be met in all cases.
    }

    // One usage per case that runs. Measured values are filled from
    // results/experiment_results.sysml by hand or by tools/check_model.py (turn 5).
    verification performanceShareCaseC : VerifyPerformanceToDecidingParty { :>> experimentCase = "C"; }
    verification costOfTimeCaseC : VerifyCostOfTimeToDecidingParty { :>> experimentCase = "C"; }
    verification connectionsCaseD : VerifyConnectionPriorityToDecidingParty { :>> experimentCase = "D"; }
    verification capabilityCaseC : VerifyClearanceWithinCapability { :>> experimentCase = "C"; }
    verification lowestImpactCaseC : VerifyLowestImpactResolution { :>> experimentCase = "C"; }
    verification instructionCountCaseA : VerifyInstructionsWithinWorkload { :>> experimentCase = "A"; }

    // ---- Improved HLRs (D-040, 2026-11-05) -----------------------------------------------
    // One def per HLR the report's table of improved HLRs lists, each with its statement.
    // HLR-ATC-05's is VerifyLowestImpactByMeans, below.

    verification def VerifyPerformanceShareProvided :> VerifyByExperimentCase {
        doc /* HLR-OPS-05: Verify that the airline shares its performance information. */
        objective {
            doc /* By inspection of the case C run: met if, for every aircraft in the conflict,
             * the airline's share (the aircraft's state and performance, and the airline's
             * priorities) reaches the deciding party before the options are scored. */
            verify performanceShareProvided;
        }
    }
    // Case A will fail, because the airline does not share its performance information. Case B will fail, because the airline shares only the aircraft's weight, not its performance. Cases C and D will pass, because the airline shares both the aircraft's weight and performance information.

    verification def VerifyPerformanceShareUsed :> VerifyByExperimentCase {
        doc /* HLR-ATC-08: Verify that the decision support uses what it is given. */
        objective {
            doc /* By analysis, case C against case B: met if the decision support's estimates
             * use the shared values where case B uses the type's nominal ones, so that the
             * options or the choice change where the two differ. */
            verify performanceShareUsedInResolution;
        }
    }
    // This is a requirement that is expected to be met in all cases. 

    verification def VerifyViableOptionsDetermined :> VerifyByExperimentCase {
        doc /* HLR-ATC-10: Verify that the conflict resolution considers only viable options. */
        objective {
            doc /* By analysis, case C: met if the options the decision support finds viable are
             * exactly those the truth model finds restore separation and can be flown by every
             * aircraft moved. */
            verify viableOptionsDetermined;
        }
    }
    // This is a requirement that is expected to be met in all cases. It is the reason why Case A is limited to a descent only. 

    verification def VerifyOptionImpactDetermined :> VerifyByExperimentCase {
        doc /* HLR-ATC-11: Verify that the impact of each viable option is estimated. */
        objective {
            doc /* By analysis, case C: met if the decision support's estimate of each viable
             * option's impact (fuel burned and airline cost, per aircraft and summed) matches
             * the truth model's within a large tolerance (+/- 50%). */
            verify optionImpactDetermined;
        }
    }
    // This is a requirement that is expected to be met in all cases. 

    verification performanceShareProvidedCaseC : VerifyPerformanceShareProvided { :>> experimentCase = "C"; }
    verification performanceShareUsedCaseC : VerifyPerformanceShareUsed { :>> experimentCase = "C"; }
    verification viableOptionsCaseC : VerifyViableOptionsDetermined { :>> experimentCase = "C"; }
    verification optionImpactCaseC : VerifyOptionImpactDetermined { :>> experimentCase = "C"; }

    // ---- Means of achievement (D-022, 2026-10-11) ----------------------------------------
    // Three constituent system requirements can each be achieved four ways. The experiment
    // runs each way as one case and one truth model scores them all, so each requirement
    // gets one verification case per means. Measured values come from
    // results/experiment_results.sysml.

    verification def VerifyMeansByExperimentCase :> VerifyByExperimentCase {
        doc /* A verification case that exercises one means of achieving a requirement. */
        attribute means : MeansOfAchievement;
        attribute measuredOptionFlyable : Boolean[0..1];
    }

    verification def VerifyFlyableClearanceByMeans :> VerifyMeansByExperimentCase {
        doc /* HLR-ATC-04: Verify that air traffic control resolves the conflict with a clearance
         * every aircraft it moves can fly. */
        objective {
            doc /* By analysis, one case per means (A to D): met if the option chosen passes the
             * truth model's thrust check for every aircraft it moves. */
            verify conflictResolvedWithFlyableClearance;
        }
        // Baseline since D-040 (the rule's descent meets it).
    }
    // This is a requirement that is expected to be met in all cases. It is the reason why Case A is limited to a descent only. 

    verification def VerifyLowestImpactByMeans :> VerifyMeansByExperimentCase {
        doc /* HLR-ATC-05: Verify that air traffic control chooses the viable option with the
         * lowest impact. */
        objective {
            doc /* By analysis, one case per means (A to D): met if the option chosen has the
             * lowest impact (fuel burned and airline cost, per aircraft and summed) among the
             * viable options under the truth model; the four means are compared side by side. */
            verify lowestImpactResolutionChosen;
        }
        // A requirement since D-040 (was a goal).
    }
    // This is a requirement that is expected to be met in all cases, as they provide the lowest impact solution based on the information they have available. This can also be viewed in the context of the maximal information, where Case C & D have the most information available, and should be able to provide the lowest impact solution. Here again, the pass/fail decision can change when viewing the requirement at different levels.

    verification def VerifyWorkloadByMeans :> VerifyMeansByExperimentCase {
        doc /* HLR-ATC-06: Verify that air traffic control resolves the conflict within the
         * instructions the sector team can sustain. */
        objective {
            doc /* By analysis, one case per means (A to D): the instructions issued plus
             * follow-ups for the option chosen are counted and reported; no ceiling is set, so
             * there is no pass or fail. */
            verify conflictResolvedWithinWorkload;
        }
    }
    // This is a requirement that is expected to be met in all cases. It is an assumed condition of the scenario.

    verification flyableRuleOfThumb : VerifyFlyableClearanceByMeans { :>> experimentCase = "A"; :>> means = MeansOfAchievement::ruleOfThumb; }
    verification flyableLowFidelity : VerifyFlyableClearanceByMeans { :>> experimentCase = "B"; :>> means = MeansOfAchievement::lowFidelityModel; }
    verification flyableHighFidelity : VerifyFlyableClearanceByMeans { :>> experimentCase = "C"; :>> means = MeansOfAchievement::highFidelityModel; }
    verification flyableHighFidelityWithConnections : VerifyFlyableClearanceByMeans { :>> experimentCase = "D"; :>> means = MeansOfAchievement::highFidelityModelWithConnections; }

    verification impactRuleOfThumb : VerifyLowestImpactByMeans { :>> experimentCase = "A"; :>> means = MeansOfAchievement::ruleOfThumb; }
    verification impactLowFidelity : VerifyLowestImpactByMeans { :>> experimentCase = "B"; :>> means = MeansOfAchievement::lowFidelityModel; }
    verification impactHighFidelity : VerifyLowestImpactByMeans { :>> experimentCase = "C"; :>> means = MeansOfAchievement::highFidelityModel; }
    verification impactHighFidelityWithConnections : VerifyLowestImpactByMeans { :>> experimentCase = "D"; :>> means = MeansOfAchievement::highFidelityModelWithConnections; }

    verification workloadRuleOfThumb : VerifyWorkloadByMeans { :>> experimentCase = "A"; :>> means = MeansOfAchievement::ruleOfThumb; }
    verification workloadLowFidelity : VerifyWorkloadByMeans { :>> experimentCase = "B"; :>> means = MeansOfAchievement::lowFidelityModel; }
    verification workloadHighFidelity : VerifyWorkloadByMeans { :>> experimentCase = "C"; :>> means = MeansOfAchievement::highFidelityModel; }
    verification workloadHighFidelityWithConnections : VerifyWorkloadByMeans { :>> experimentCase = "D"; :>> means = MeansOfAchievement::highFidelityModelWithConnections; }
}
