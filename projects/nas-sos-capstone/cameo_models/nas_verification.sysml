package NasVerification {
    doc /* Verification cases for the requirements the experiment exercises (D-018, 2026-10-10).
     * INCOSE layering, as used here: the verification case is the test procedure; the
     * analysis (NasAnalysis::ConflictResolutionScoring, run by experiment_scoring.py)
     * executes it and produces the measures of performance; the measures of effectiveness
     * are read off the outcome table per stakeholder level. The measured values land in
     * results/experiment_results.sysml, which the script generates.
     *
     * Three verification defs for SLR-INF-02 (one per item shared: weight, cost index,
     * connection priority), one each for the other two `improved` statements (SLR-CLR-10,
     * SLR-CLR-13), plus one for the instruction-count requirement (SLR-CLR-15, D-021).
     * SLR-CLR-13 is a goal (D-020): the case measures it, it does not pass or fail it.
     * Each def names the experiment case that exercises it.
     * tools/check_model.py (plan turn 5) asserts every `improved` requirement is verified. */

    public import ScalarValues::*;
    private import SystemLevelRequirements::ClearanceAndSeparation::*;
    private import SystemLevelRequirements::InformationForTrajectoryDecisions::*;
    private import NasAnalysis::*;
    private import RequirementDefinitions::MeansOfAchievement;
    private import ConstituentSystemRequirements::AirspaceManagementRequirements::*;

    verification def VerifyByExperimentCase {
        doc /* Common shape: which case of the experiment is the procedure, which scenario
         * file it runs on, and what was measured when it ran. The scenario file holds the
         * flights (NasAnalysis::ScenarioFlight) and the options
         * (NasAnalysis::ResolutionOption); its values are cited here by file and are not
         * repeated in the model (D-025). */
        attribute experimentCase : String; // "A", "B", "C" or "D"
        attribute scenarioFile : String default "projects/nas-sos-capstone/simulation/scenario_base.yaml";
        attribute measuredSystemDeltaFuelKg : Real[0..1];
        attribute measuredInstructions : Integer[0..1];
        subject scoring : ConflictResolutionScoring;
    }

    verification def VerifyWeightToDecidingParty :> VerifyByExperimentCase {
        doc /* Case C: the deciding party receives the aircraft's weight. Verified by analysis
         * if case C can offer a climb to the light aircraft that cases A and B cannot.
         * One of three cases on SLR-INF-02, which after the hand review of 2026-10-10
         * (D-020) covers weight, cost index and connection priority in one statement. */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyCostIndexToDecidingParty :> VerifyByExperimentCase {
        doc /* Case C: the deciding party receives the cost index. Verified by analysis if
         * the option chosen changes with the pair's cost indexes (similar-weights variation
         * as the control). Second case on SLR-INF-02. */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyConnectionPriorityToDecidingParty :> VerifyByExperimentCase {
        doc /* Case D: the deciding party receives the airline's connection priority, stated
         * as AirlinePerformanceShare.delayMarginMin (minutes of further delay before
         * connections are lost; D-025). Third case on SLR-INF-02. */
        objective { verify decisionInformationToDecidingParty; }
    }

    verification def VerifyClearanceWithinCapability :> VerifyByExperimentCase {
        doc /* Case C: no clearance is issued that the aircraft cannot fly (the truth model's
         * thrust check against the option chosen). */
        objective { verify clearanceWithinAircraftCapability; }
    }

    verification def VerifyLowestImpactResolution :> VerifyByExperimentCase {
        doc /* Cases C and D against B: the lowest impact on the aircraft involved, scored by
         * the experiment as fuel cost plus cost index times time. A goal (D-020, D-021). */
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
    verification weightShareCaseC : VerifyWeightToDecidingParty { :>> experimentCase = "C"; }
    verification costIndexCaseC : VerifyCostIndexToDecidingParty { :>> experimentCase = "C"; }
    verification connectionsCaseD : VerifyConnectionPriorityToDecidingParty { :>> experimentCase = "D"; }
    verification capabilityCaseC : VerifyClearanceWithinCapability { :>> experimentCase = "C"; }
    verification lowestImpactCaseC : VerifyLowestImpactResolution { :>> experimentCase = "C"; }
    verification instructionCountCaseA : VerifyInstructionsWithinWorkload { :>> experimentCase = "A"; }

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
        doc /* HLR-ATC-05 (a goal): the fuel and airline cost of the option this means chose,
         * per aircraft and summed. Compared across means; not passed or failed. */
        objective { verify lowestImpactResolutionChosen; }
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
