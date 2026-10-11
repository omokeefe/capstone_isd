package NasAnalysis {
    doc /* The analysis side of the architecture (D-017, 2026-10-10): the one calculation the
     * experiment depends on, declared here as an interface, with its two fidelity usages
     * and the analysis that uses them. The implementation is Python
     * (projects/nas-sos-capstone/simulation/experiment_scoring.py, class Performance and
     * function maneuver_cost); the trace between the two is documentary, by name (D-005).
     *
     * Why this package exists: the project's claim is that a low-fidelity rule of thumb
     * can be replaced by a higher-fidelity model with the architecture unchanged. That
     * claim needs a place in the model where the fidelity is a selectable value and the
     * calculation's signature is fixed. This is that place. The removed
     * DecisionSupport::VehicleDynamicsModel::StepDynamics calc (D-012) was a time-step
     * integrator; this is a steady-state performance function, which is all the
     * experiment needs (D-017 item 4).
     *
     * Generated results are written by the script to results/experiment_results.sysml. */

    public import ScalarValues::*;

    enum def FidelityLevel {
        doc /* How the truth model scores an option. The decider's case (A to D) says what
         * information the decision used; this says what the scoring used. They are set
         * independently (D-017 item 3). */
        enum conceptual;  // feasibility and instruction counts only; no fuel numbers
        enum nominalMass; // OpenAP at the type's one nominal mass (coppenbarger1999climbPrediction p. 4)
        enum actualMass;  // OpenAP at each aircraft's actual mass
    }

    calc def CruiseFuelFlow {
        doc /* Steady cruise fuel flow for one aircraft. Implemented by
         * Performance.fuel_flow_kg_s in experiment_scoring.py, which calls
         * openap.FuelFlow(type).enroute(mass, tas, altitude). Units in the names. */
        in massKg : Real;
        in machNumber : Real;
        in altitudeFt : Real;
        return fuelFlowKgPerS : Real;
    }

    calc def CanHoldLevel {
        doc /* Whether maximum cruise thrust meets clean drag at this mass, Mach and level.
         * Implemented by Performance.can_hold (openap Thrust.cruise and Drag.clean).
         * This is the thrust limit that closes the climb to the heavy aircraft. */
        in massKg : Real;
        in machNumber : Real;
        in altitudeFt : Real;
        return feasible : Boolean;
    }

    part def PerformanceModel {
        doc /* One realization of the performance functions at one fidelity. The nominal
         * and actual usages below differ only in where the mass comes from, which is the
         * whole of the "interchangeable fidelity" claim. */
        attribute fidelity : FidelityLevel;
        attribute aircraftType : String; // ICAO code; B39M for the experiment (D-015)
        calc fuelFlow : CruiseFuelFlow;
        calc canHold : CanHoldLevel;
    }

    part nominalPerformance : PerformanceModel {
        doc /* The one weight per type that today's ground automation uses; what case B
         * decides with. */
        :>> fidelity = FidelityLevel::nominalMass;
        :>> aircraftType = "B39M";
    }

    part actualPerformance : PerformanceModel {
        doc /* The aircraft's own weight, as the FMS holds it and as
         * FlightOperations::AirlinePerformanceShare would carry it (D-019); what cases C
         * and D decide with, and what the truth model scores with by default. */
        :>> fidelity = FidelityLevel::actualMass;
        :>> aircraftType = "B39M";
    }

    analysis def ConflictResolutionScoring {
        doc /* The experiment (knowledge/models/experiment-definition.md,
         * experiment-options-and-scoring.md). Implemented end to end by
         * experiment_scoring.py: nine options for four aircraft, each case choosing with
         * its own information, one truth model scoring all. Inputs are the scenario file
         * simulation/scenario_base.yaml; outputs are the two outcome tables and
         * results/experiment_results.sysml. */
        attribute truthFidelity : FidelityLevel default FidelityLevel::actualMass;
        attribute scenarioFile : String default "projects/nas-sos-capstone/simulation/scenario_base.yaml";
        objective scoringObjective {
            doc /* For each case A to D: which option it chose, and the cost of that option
             * to each aircraft, each airline, the sector and the system, stated side by
             * side with no weighted sum (D-013 item 2). */
        }
    }

    analysis baseScenarioScoring : ConflictResolutionScoring;
}
