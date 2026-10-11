package RequirementDefinitions {
    doc /*
     * Shared requirement schema for this project: the attributes every stakeholder need
     * and system-level requirement (SLR) carries, plus the enumerations they draw on.
     * Instances live in requirements_stakeholders.sysml and requirements_nas_system.sysml
     * (definitions in one place, instances in another, per D-005).
     *
     * Each requirement's ID is its short name (e.g. <'SN-001'>) and its "shall" text is
     * its doc comment; everything else is an attribute below. Attribute choices follow
     * the best-practices list in sysmlv2_exploration.md section 5 (ID, shall, rationale,
     * parent, verification method chosen up front, threshold/objective where
     * quantifiable) and the traceability rule in workflows/update-architecture.md (every
     * element traces to a stakeholder need, a source, or the trajectory-intent chain).
     *
     * Names avoid SysML v2 reserved words, which is why some read oddly: 'stakeholder',
     * 'objective', 'analysis', 'interface', and 'constraint' are keywords and cannot be
     * plain feature or enum-literal names.
     *
     * Terms: a "stakeholder requirement" is a StakeholderNeed here (IDs SN-<group>-nn); a
     * "system requirement" is a SystemLevelRequirement (IDs SLR-<area>-nn).
     *
     * Checked with `syside check` on 2026-10-10, together with the two instance files and
     * nas_sysml_package_definitions.sysml: no errors.
     * Added 2026-10-10 (draft, for the owner's review): EvidenceGrade and `basis`,
     * `objectiveRefs` on StakeholderNeed, `derivedFrom` on SystemLevelRequirement, and
     * the `military` stakeholder group.
     * Added 2026-10-10 from the owner's hand review (D-020): Obligation and `obligation`,
     * so that a statement the owner judges a goal and not a requirement stays in the
     * model without being a "shall".
     * Added 2026-10-11 (D-022): MeansOfAchievement and ConstituentSystemRequirement, for
     * the tier below the system requirements (IDs HLR-<system>-nn; instances in
     * requirements_constituent_systems.sysml).
     */

    public import ScalarValues::*;

    enum def RequirementStatus {
        doc /* Lifecycle of the requirement statement itself, not of its verification. */
        enum draft;
        enum reviewed; // checked by the adviser/team, not yet frozen
        enum baselined; // frozen for a milestone; change goes through decisions-log.md
        enum withdrawn; // kept for traceability, no longer in force
    }

    enum def StakeholderGroup {
        doc /* The stakeholder groups named in requirements_stakeholders.sysml. Mirrors
         * that file's sub-packages so needs can be queried by group without relying on
         * package structure. */
        enum governmentsAndStandardsOrganizations;
        enum operators; // Part 121 scheduled passenger airlines (D-007)
        enum airTrafficControl; // includes traffic flow management
        enum aircraftAndEngineManufacturers; // no requirements at present: not in D-007 or the objective ontology
        enum airportAuthority; // no requirements at present (hand review 2026-10-10, D-020)
        enum flightCrews;
        enum passengers; // no requirements at present (D-020)
        enum environmentalAndSocietalOrganizations;
        enum military; // boundary actor under D-007; no requirements at present (D-020)
    }

    enum def EvidenceGrade {
        doc /* Where a requirement comes from. Same grades as the review key in
         * nas_context_diagram.sysml ([A], [B], [SME], [C]). */
        enum normativeSource; // [A] a rule or FAA order held in the source register
        enum literature; // [B] a published study held in the source register
        enum ownerExpertise; // [SME] the owner's industry knowledge
        enum generalKnowledge; // [C] general domain knowledge, not yet tied to a held source
    }

    enum def RequirementKind {
        doc /* Interface requirements are kept distinct from design requirements, per
         * sysmlv2_exploration.md section 5. */
        enum functional; // what the system shall do
        enum performance; // how well, fast, or often — usually carries a threshold/objective
        enum interfaceRequirement; // what crosses the boundary between systems
        enum designConstraint; // imposed on the solution (regulation, standard, technology)
        enum qualityAttribute; // safety, reliability, availability, and similar
    }

    enum def VerificationMethod {
        doc /* Standard INCOSE inspection / analysis / demonstration / test. Analysis
         * covers modeling and simulation, which is where this project's vehicle-dynamics
         * work (workflows/vehicle-simulation-model.md) would land. Literals are prefixed
         * 'by' because 'analysis' is a SysML v2 keyword. */
        enum byInspection; // examine the design, documents, or code
        enum byAnalysis; // math, model, or simulation
        enum byDemonstration; // exercise the system, qualitative pass/fail
        enum byTest; // instrumented measurement against a quantified criterion
    }

    enum def ArchitectureState {
        doc /* Which architecture a requirement describes (D-018, 2026-10-10). `baseline` is
         * the NAS as it operates today; `improved` is the proposed change the experiment
         * measures. Case A of the experiment measures the baseline set (the course's
         * current-state metric); cases C and D measure the improved set (the improvement
         * claim). Names chosen by the owner. */
        enum baseline;
        enum improved;
    }

    enum def Obligation {
        doc /* Whether a statement binds (D-020, 2026-10-10). A `mandatory` statement is a
         * requirement and is written with "shall". A `goal` is something the system should
         * pursue once the mandatory ones are met; it is written with "should" and is
         * measured, not passed or failed. */
        enum mandatory;
        enum goal;
    }

    abstract requirement def NasRequirement {
        doc /* Attributes common to every requirement in this project. */

        attribute status: RequirementStatus;
        attribute architectureState: ArchitectureState default ArchitectureState::baseline;
        attribute obligation: Obligation default Obligation::mandatory;
        attribute rationale: String[0..1]; // why it exists; what breaks if it is dropped
        attribute evidenceRefs: String[0..*]; // references.bib keys / source-register entries
        attribute basis: EvidenceGrade[0..1];
    }

    enum def MeansOfAchievement {
        doc /* The different ways one objective can be achieved (D-022, 2026-10-11). They
         * differ in what the party deciding works from. Each is one case of the experiment
         * (knowledge/models/experiment-options-and-scoring.md section 2), so the experiment
         * scores them side by side. Not the same thing as NasAnalysis::FidelityLevel, which
         * is the fidelity of the truth model that does the scoring (D-017 item 3). */
        enum ruleOfThumb; // case A: today's information and a rule (one descent; climb only at or below FL350)
        enum lowFidelityModel; // case B: a performance model with one nominal weight per aircraft type
        enum highFidelityModel; // case C: each aircraft's own weight and cost index, shared by the airline
        enum highFidelityModelWithConnections; // case D: case C plus the airline's connection priority
    }

    requirement def StakeholderNeed :> NasRequirement {
        doc /* A need in a stakeholder's own terms. Implementation-neutral: many solutions
         * can satisfy one need. Needs are validated (did we build the right system),
         * not verified, so they carry no verification method. */

        attribute stakeholderGroup: StakeholderGroup;
        // Objective rows this need comes from, written "<category>: <objective>" as they
        // appear in knowledge/models/stakeholder-objective-ontology.md. Empty only when no
        // row matches, in which case rationale says where the interest comes from.
        attribute objectiveRefs: String[0..*];
    }

    requirement def SystemLevelRequirement :> NasRequirement {
        doc /* A system-level requirement on the NAS as a whole, verified by a stated method.
         * It either answers one or more stakeholder needs (parentNeeds) or it is derived:
         * it has no stakeholder parent and exists because of a design choice or because
         * other system requirements cannot be met without it. A derived requirement must
         * carry derivedFrom and a rationale. */

        attribute kind: RequirementKind;
        ref requirement parentNeeds: StakeholderNeed[0..*]; // needs this SLR answers
        ref requirement derivedFrom: SystemLevelRequirement[0..*]; // only when parentNeeds is empty
        attribute verificationMethod: VerificationMethod[0..*];

        // Only for quantifiable requirements (typically kind = performance). Leave unset
        // for qualitative ones rather than inventing a number.
        attribute measureOfPerformance: String[0..1]; // e.g. "surveillance update latency"
        attribute unitOfMeasure: String[0..1]; // e.g. "seconds"
        attribute thresholdValue: Real[0..1]; // minimum acceptable
        attribute objectiveValue: Real[0..1]; // desired
    }

    requirement def ConstituentSystemRequirement :> NasRequirement {
        doc /* A requirement on one constituent system of the NAS (one of D-007's five modeled
         * systems, or a named part of one), with that system as the subject of the
         * sentence. The owner's name for this tier is HLR. It comes from one or more system
         * requirements (parentRequirements) and states what it is for (objectiveStatement).
         * Where the objective can be achieved in more than one way, candidateMeans lists
         * the ways; meansScoredInExperiment says whether the experiment compares them. */

        attribute kind: RequirementKind;
        attribute constituentSystem: String; // the D-007 system this is a requirement on
        attribute objectiveStatement: String; // what the requirement is for, in one sentence
        ref requirement parentRequirements: SystemLevelRequirement[1..*];
        attribute candidateMeans: MeansOfAchievement[0..*];
        attribute meansScoredInExperiment: Boolean default false;
        attribute verificationMethod: VerificationMethod[0..*];

        attribute measureOfPerformance: String[0..1];
        attribute unitOfMeasure: String[0..1];
        attribute thresholdValue: Real[0..1];
    }
}
