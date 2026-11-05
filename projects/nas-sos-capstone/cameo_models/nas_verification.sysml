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
     * VERIFICATION STATEMENTS (D-040). Where a def's objective carries a doc, that doc
     * says in one sentence how the requirement is verified and what counts as met.
     * tools/export_report_tables.py prints it in the report's table of improved HLRs, with
     * the def's name. Drafted by Claude, 2026-11-05, for the owner to review.
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

    verification def VerifyPerformanceToDecidingParty :> VerifyByExperimentCase {
        doc /* Case C: the deciding party receives the aircraft's state and performance (in the
         * experiment, its weight). Verified by analysis if case C can offer a climb to the
         * light aircraft that cases A and B cannot. One of three cases on SLR-INF-02, which
         * after the hand review of 2026-10-10 (D-020) covers everything shared in one
         * statement. Was VerifyWeightToDecidingParty (renamed by D-040). */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyCostOfTimeToDecidingParty :> VerifyByExperimentCase {
        doc /* Case C: the deciding party receives the airline's cost of time (in the
         * experiment, the cost index). Verified by analysis if the option chosen changes with
         * the pair's cost of time (similar-weights variation as the control). Second case on
         * SLR-INF-02. Was VerifyCostIndexToDecidingParty (renamed by D-040). */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyConnectionPriorityToDecidingParty :> VerifyByExperimentCase {
        doc /* Case D: the deciding party receives the airline's connection priority, stated
         * as ExperimentPerformanceShare.delayMarginMin (minutes of further delay before
         * connections are lost; D-025). Third case on SLR-INF-02. */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyClearanceWithinCapability :> VerifyByExperimentCase {
        doc /* Case C: no clearance is issued that the aircraft cannot fly (the truth model's
         * thrust check against the option chosen). SLR-CLR-10 is baseline since D-040 (the
         * rule's descent meets it); the case stays because every case is measured on it. */
        objective { verify clearanceWithinAircraftCapability; }
    }

    verification def VerifyLowestImpactResolution :> VerifyByExperimentCase {
        doc /* Cases C and D against B: the lowest impact on the aircraft involved, scored by
         * the experiment as fuel cost plus cost index times time. A requirement since D-040
         * (was a goal, D-020, D-021). */
        objective { verify lowestImpactResolution; }
    }

    verification def VerifyInstructionsWithinWorkload :> VerifyByExperimentCase {
        doc /* Case A (baseline) against C and D: instructions issued plus follow-ups. The
         * one baseline requirement the experiment measures. SLR-CLR-15 replaced the struck
         * goal SLR-CLR-12 on 2026-10-11 (D-021); no ceiling is set, so the case reports
         * the count and does not pass or fail it. */
        objective { verify instructionsWithinSustainableWorkload; }
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
        doc /* HLR-OPS-05: the airline makes its share available. Case C. */
        objective {
            doc /* By inspection of the case C run: met if, for every aircraft in the conflict,
             * the airline's share (the aircraft's state and performance, and the airline's
             * priorities) reaches the deciding party before the options are scored. */
            verify performanceShareProvided;
        }
    }

    verification def VerifyPerformanceShareUsed :> VerifyByExperimentCase {
        doc /* HLR-ATC-08: the decision support uses what it is given. Case C against case B. */
        objective {
            doc /* By analysis, case C against case B: met if the decision support's estimates
             * use the shared values where case B uses the type's nominal ones, so that the
             * options or the choice change where the two differ. */
            verify performanceShareUsedInResolution;
        }
    }

    verification def VerifyViableOptionsDetermined :> VerifyByExperimentCase {
        doc /* HLR-ATC-10: every viable option is found. Case C. */
        objective {
            doc /* By analysis, case C: met if the options the decision support finds viable are
             * exactly those the truth model finds restore separation and can be flown by every
             * aircraft moved. */
            verify viableOptionsDetermined;
        }
    }

    verification def VerifyOptionImpactDetermined :> VerifyByExperimentCase {
        doc /* HLR-ATC-11: the impact of each viable option is estimated. Case C. */
        objective {
            doc /* By analysis, case C: met if the decision support's estimate of each viable
             * option's impact (fuel burned and airline cost, per aircraft and summed) matches
             * the truth model's within a stated tolerance (to be set). */
            verify optionImpactDetermined;
        }
    }

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
        doc /* HLR-ATC-04: was the option this means chose one that every moved aircraft can
         * fly, by the truth model's thrust check. */
        objective { verify conflictResolvedWithFlyableClearance; }
    }

    verification def VerifyLowestImpactByMeans :> VerifyMeansByExperimentCase {
        doc /* HLR-ATC-05 (a requirement since D-040, was a goal): the fuel and airline cost of
         * the option this means chose, per aircraft and summed, against the lowest-impact
         * viable option. Compared across means. */
        objective {
            doc /* By analysis, one case per means (A to D): met if the option chosen has the
             * lowest impact among the viable options under the truth model; the four means are
             * compared side by side. */
            verify lowestImpactResolutionChosen;
        }
    }

    verification def VerifyWorkloadByMeans :> VerifyMeansByExperimentCase {
        doc /* HLR-ATC-06: instructions issued plus follow-ups for the option this means
         * chose. No ceiling is set, so the count is reported and not passed or failed. */
        objective { verify conflictResolvedWithinWorkload; }
    }

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
