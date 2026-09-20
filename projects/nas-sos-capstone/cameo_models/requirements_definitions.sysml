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
     * DRAFT: authored without a linter pass — no diagnostics surfaced in the session that
     * wrote it. Check the IDE Problems panel before relying on it.
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
        enum operators; // airlines, charter operators, cargo operators
        enum airTrafficControl;
        enum aircraftAndEngineManufacturers;
        enum airportAuthority;
        enum flightCrews;
        enum passengers;
        enum environmentalAndSocietalOrganizations;
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

    abstract requirement def NasRequirement {
        doc /* Attributes common to every requirement in this project. */

        attribute status: RequirementStatus;
        attribute rationale: String[0..1]; // why it exists; what breaks if it is dropped
        attribute evidenceRefs: String[0..*]; // references.bib keys / source-register entries
    }

    requirement def StakeholderNeed :> NasRequirement {
        doc /* A need in a stakeholder's own terms. Implementation-neutral: many solutions
         * can satisfy one need. Needs are validated (did we build the right system),
         * not verified, so they carry no verification method. */

        attribute stakeholderGroup: StakeholderGroup;
    }

    requirement def SystemLevelRequirement :> NasRequirement {
        doc /* A system-level requirement on the NAS as a whole, derived from one or more
         * stakeholder needs and verified by a stated method. */

        attribute kind: RequirementKind;
        ref requirement parentNeeds: StakeholderNeed[0..*]; // needs this SLR is derived from
        attribute verificationMethod: VerificationMethod[0..*];

        // Only for quantifiable requirements (typically kind = performance). Leave unset
        // for qualitative ones rather than inventing a number.
        attribute measureOfPerformance: String[0..1]; // e.g. "surveillance update latency"
        attribute unitOfMeasure: String[0..1]; // e.g. "seconds"
        attribute thresholdValue: Real[0..1]; // minimum acceptable
        attribute objectiveValue: Real[0..1]; // desired
    }
}
