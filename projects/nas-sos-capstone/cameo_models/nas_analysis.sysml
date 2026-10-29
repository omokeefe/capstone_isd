package NasAnalysis {
    doc /* The analysis side of the architecture (D-017, 2026-10-10): the one calculation the
     * experiment depends on, declared here as an interface, with its two fidelity usages
     * and the analysis that uses them. The implementation is Python
     * (projects/nas-sos-capstone/simulation/experiment_scoring.py, class PerformanceModel
     * and function maneuver_cost). The definitions in this package that the Python reads or
     * writes are mirrored field for field in simulation/nas_types.py, and
     * simulation/test_model_conformance.py fails when a Python field or enum value is not in
     * the model (D-025, which amends the by-hand trace of D-005).
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

    attribute def CruiseCondition {
        doc /* One aircraft's steady cruise point: the three inputs every performance
         * function below takes (D-025). Flight levels, Mach and kilograms, because that is
         * what a clearance and the performance model work in and the experiment compares
         * levels exactly. AircraftSystems::AircraftState stays in SI (metres, metres per
         * second); the experiment does not use it (the kinematic vehicle_dynamics.py that
         * steps it is kept but unused, D-017 item 4). The two are not converted into each
         * other anywhere. */
        attribute massKg : Real;
        attribute machNumber : Real;
        attribute altitudeFt : Real;
    }

    calc def CruiseFuelFlow {
        doc /* Fuel flow for one aircraft at a cruise condition, level or with a vertical
         * speed. Implemented by PerformanceModel.cruise_fuel_flow in experiment_scoring.py,
         * which calls openap.FuelFlow(type).enroute(mass, tas, altitude, vs). Units in the
         * names. The first three inputs are a CruiseCondition. */
        in massKg : Real;
        in machNumber : Real;
        in altitudeFt : Real;
        in verticalSpeedFtPerMin : Real default 0.0;
        return fuelFlowKgPerS : Real;
    }

    calc def AvailableClimbRate {
        doc /* Rate of climb left in level flight at this mass, Mach and level: excess thrust
         * (maximum cruise thrust minus clean drag) times speed over weight. Implemented by
         * PerformanceModel.available_climb_rate (openap Thrust.cruise and Drag.clean).
         * A climb between two levels is costed at this rate at the mid-altitude, capped at
         * 1,500 ft/min (D-024). */
        in massKg : Real;
        in machNumber : Real;
        in altitudeFt : Real;
        return climbRateFtPerMin : Real;
    }

    calc def CanHoldLevel {
        doc /* Whether at least minClimbRateFtPerMin of climb is left at this mass, Mach and
         * level (AvailableClimbRate >= the minimum). 100 ft/min defines the service ceiling
         * (faa2015ac61107b para. 1-4r); the experiment asks for 150 [SME] (D-023). Until
         * D-023 the test was "thrust meets drag", which is this with a minimum of 0.
         * Implemented by PerformanceModel.can_hold_level. This is the limit that closes the
         * climb to the heavy aircraft. */
        in massKg : Real;
        in machNumber : Real;
        in altitudeFt : Real;
        in minClimbRateFtPerMin : Real default 0.0;
        return feasible : Boolean;
    }

    part def PerformanceModel {
        doc /* One realization of the performance functions at one fidelity. The nominal
         * and actual usages below differ only in where the mass comes from, which is the
         * whole of the "interchangeable fidelity" claim. */
        attribute fidelity : FidelityLevel;
        attribute aircraftType : String; // ICAO code; B39M for the experiment (D-015)
        attribute nominalMassKg : Real[0..1]; // the one weight per type the nominal model uses; value held in the scenario file (type.nominalMassKg)
        calc fuelFlow : CruiseFuelFlow;
        calc climbRate : AvailableClimbRate;
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

    // ---- What the analysis reads (D-025, 2026-10-11) --------------------------------------
    // The scenario file's flights and options, defined here so the YAML keys and the Python
    // fields have a definition to match. Values stay in the scenario file; they are not
    // repeated in the model.

    enum def ManeuverKind {
        doc /* The kinds of instruction a resolution option is built from. */
        enum altitude; // a level change of deltaFt; a descent is followed by a climb back when the scenario allows it
        enum vector;   // extra track miles to pass behind the other aircraft, then resume own navigation
        enum speed;    // a Mach change on one of the crossing pair; built to fail (D-014 item 2)
        enum slow;     // a Mach reduction held for a few minutes on an in-trail aircraft, to open a gap (option O9)
    }

    attribute def Maneuver {
        doc /* One instruction to one flight. */
        attribute flightNumber : String;
        attribute kind : ManeuverKind;
        attribute deltaFt : Real[0..1]; // altitude only: positive is a climb
    }

    item def ResolutionOption {
        doc /* One way to resolve the conflict: one or more maneuvers issued together. The
         * nine options of the experiment are O1 to O9 in the scenario file
         * (knowledge/models/experiment-options-and-scoring.md section 2). */
        attribute optionId : String;
        attribute instructionsNow : Integer; // instructions issued at the decision; follow-ups are counted by the scoring
        attribute maneuvers : Maneuver[1..*];
    }

    part def ScenarioFlight {
        doc /* One flight as the experiment needs it: where it is, what it would cost its
         * airline to move it, and what the airline would share about it. The truth model
         * reads the facts (cruise, costIndex, scheduleDeltaMin, hasConnections). A decider
         * in cases C and D reads only performanceShare; cases A and B are not given it.
         * That split is the information gap the experiment measures. */
        ref part flight : NationalAirspaceSystem::FlightOperations::Flight;
        attribute cruise : CruiseCondition;   // the true condition; massKg is the actual mass
        attribute distanceToGoNm : Real;
        attribute costIndex : Real;           // airline's fact: kg of fuel per minute
        attribute scheduleDeltaMin : Real;    // airline's fact: positive = late on entry
        attribute hasConnections : Boolean;   // airline's fact
        item performanceShare : NationalAirspaceSystem::FlightOperations::AirlinePerformanceShare;
        // performanceShare is derived from the facts above, as the airline would send it:
        // grossWeightKg = cruise.massKg; costIndex = costIndex; delayMarginMin =
        // the connection threshold minus scheduleDeltaMin when hasConnections, else absent.
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
        ref part flights : ScenarioFlight[*];     // the scenario file's `flights`
        ref item options : ResolutionOption[*];   // the scenario file's `options`
        objective scoringObjective {
            doc /* For each case A to D: which option it chose, and the cost of that option
             * to each aircraft, each airline, the sector and the system, stated side by
             * side with no weighted sum (D-013 item 2). */
        }
    }

    analysis baseScenarioScoring : ConflictResolutionScoring;
}
