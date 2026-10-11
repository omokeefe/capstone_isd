"""Score the conflict-resolution experiment (D-013 to D-017).

Implements ``NasAnalysis::ConflictResolutionScoring`` in
``cameo_models/nas_analysis.sysml``. The flights, options, enumerations and performance
functions used here are the model's own definitions, mirrored in ``nas_types.py`` and
checked against the ``.sysml`` text by ``test_model_conformance.py`` (D-025). One scenario
file (``scenario_base.yaml``) describes four aircraft in one sector, nine resolution
options and the rules. This module:

1. scores every option for every aircraft against flying on undisturbed, with the
   TRUTH MODEL at the fidelity selected (``--fidelity``);
2. lets each CASE choose an option with only the information that case has
   (A: rule; B: nominal mass; C: actual mass and cost index; D: C plus connection
   priority);
3. writes the two tables of ``knowledge/models/experiment-options-and-scoring.md``
   section 3 as CSV and LaTeX, and a small SysML v2 results file.

Fidelity (``NasAnalysis::FidelityLevel``):
  conceptual   feasibility and instruction counts only; no fuel numbers
  nominalMass  OpenAP fuel flow at the type's nominal mass for every aircraft
  actualMass   OpenAP fuel flow at each aircraft's actual mass (the default truth)

The decider's case and the truth model's fidelity are independent settings.

Scoring of one maneuver (steady cruise, ISA, still air):
  altitude change   climb or descent increment (OpenAP enroute fuel flow with a
                    vertical speed; a descent at 1,500 ft/min, a climb at the rate
                    maximum thrust allows at the mid-altitude, capped at 1,500 ft/min,
                    D-024) 
                    + cruise at the new level for the hold period
                    - cruise at the old level for the same period; then a re-climb
                    (second instruction) if the scenario allows it, else cruise at
                    the new level for the rest of the flight
  vector            extra track miles at cruise fuel flow and cruise speed
  speed             infeasible for separation by construction (D-014 item 2)
  slow (AC3, O9)    a Mach reduction held for a few minutes: time lost, fuel saved
Feasibility of an altitude: the level must not be occupied under the crossing
(``blocked_levels_ft``); a climb must be within the aircraft's thrust limit at the
mass the DECIDER believes (cases A and B: climb only at or below the climb rule
level, because they do not know the mass; cases C and D: at the actual mass, OpenAP
thrust must leave ``min_climb_rate_ft_min`` of climb at the new level, 150 ft/min in
the base scenario [SME], against the 100 ft/min that defines the service ceiling in
faa2015ac61107b para. 1-4r). The truth model checks the same limit afterwards; an option
a case chose that the aircraft cannot fly is reported as "unable".

Run from the repo root:
    .venv/Scripts/python.exe projects/nas-sos-capstone/simulation/experiment_scoring.py
        [--fidelity actualMass] [--variation similar-weights] [--scenario path]
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import math
import warnings
from dataclasses import dataclass, field
from pathlib import Path
from typing import Any

import yaml

from nas_types import (
    AirlinePerformanceShare,
    CruiseCondition,
    FidelityLevel,
    Flight,
    Maneuver,
    ManeuverKind,
    MeansOfAchievement,
    ResolutionOption,
    ScenarioFlight,
)

HERE = Path(__file__).resolve().parent
PROJECT = HERE.parent
TABLE_DIR = PROJECT / "report" / "figures" / "tables"
RESULTS_SYSML = PROJECT / "cameo_models" / "results" / "experiment_results.sysml"
KT = 0.514444 # m/s per kt
FIDELITIES = tuple(FidelityLevel)
CASES = ("A", "B", "C", "D")
# The means of achievement each case is (D-022), paired as in cameo_models/nas_verification.sysml.
CASE_MEANS = {
    "A": MeansOfAchievement.ruleOfThumb,
    "B": MeansOfAchievement.lowFidelityModel,
    "C": MeansOfAchievement.highFidelityModel,
    "D": MeansOfAchievement.highFidelityModelWithConnections,
}
CASE_LABEL = {
    "A": "rule, today's information",
    "B": "automation, nominal model",
    "C": "automation, shared weight and cost index",
    "D": "case C plus connection information",
}
CLIMB_RATE_FPM = 1500.0  # cap; a climb is flown at the rate maximum thrust allows when that is less (D-024)
DESCENT_RATE_FPM = -1500.0
EFFORT = {"A": 1, "B": 3, "C": 3, "D": 3}  # 1 rule from memory, 2 mental estimate, 3 automation proposes
RISK = {"altitude": "low", "vector": "medium", "speed": "high", "slow": "medium"}


# --------------------------------------------------------------------------- atmosphere
def isa_temp_k(alt_ft: float) -> float:
    return 288.15 - 0.0019812 * alt_ft if alt_ft < 36_089 else 216.65


def tas_kt(mach: float, alt_ft: float) -> float:
    return mach * math.sqrt(1.4 * 287.05 * isa_temp_k(alt_ft)) / KT


# --------------------------------------------------------------------------- performance
class PerformanceModel:
    """``NasAnalysis::PerformanceModel`` for one type, over OpenAP.

    One method per calc def of the model, with the calc def's parameter names (units in
    the names): ``cruise_fuel_flow`` is CruiseFuelFlow, ``available_climb_rate`` is
    AvailableClimbRate, ``can_hold_level`` is CanHoldLevel.
    """

    def __init__(self, aircraftType: str) -> None:
        from openap import Drag, FuelFlow, Thrust

        self.aircraftType = aircraftType
        with warnings.catch_warnings():
            warnings.simplefilter("ignore")
            self.fuel = FuelFlow(aircraftType, use_synonym=True)
            self.thrust = Thrust(aircraftType, use_synonym=True)
            self.drag = Drag(aircraftType, use_synonym=True)

    def cruise_fuel_flow(self, massKg: float, machNumber: float, altitudeFt: float, verticalSpeedFtPerMin: float = 0.0) -> float:
        """Fuel flow in kg/s."""
        return float(self.fuel.enroute(massKg, tas_kt(machNumber, altitudeFt), altitudeFt, vs=verticalSpeedFtPerMin))

    def available_climb_rate(self, massKg: float, machNumber: float, altitudeFt: float) -> float:
        """Rate of climb left in level flight, ft/min: excess thrust x speed / weight."""
        tas = tas_kt(machNumber, altitudeFt)
        excess = float(self.thrust.cruise(tas, altitudeFt)) - float(self.drag.clean(massKg, tas, altitudeFt))
        return excess * tas * 0.514444 / (massKg * 9.80665) / 0.3048 * 60

    def can_hold_level(self, massKg: float, machNumber: float, altitudeFt: float, minClimbRateFtPerMin: float = 0.0) -> bool:
        return self.available_climb_rate(massKg, machNumber, altitudeFt) >= minClimbRateFtPerMin

    def climb_rate_fpm(self, mass: float, mach: float, alt_from_ft: float, alt_to_ft: float) -> float:
        """Rate a climb between two levels is flown at: AvailableClimbRate at the mid-altitude, capped (D-024)."""
        return min(CLIMB_RATE_FPM, self.available_climb_rate(mass, mach, (alt_from_ft + alt_to_ft) / 2))


# --------------------------------------------------------------------------- scenario
def airline_share(ac: ScenarioFlight, connection_threshold_min: float) -> AirlinePerformanceShare:
    """What the airline would send about one flight (``ScenarioFlight.performanceShare``).

    The airline keeps its schedule and connection data and states one number: the minutes
    of further delay the flight can take before connections are lost.
    """
    margin = connection_threshold_min - ac.scheduleDeltaMin if ac.hasConnections else None
    return AirlinePerformanceShare(grossWeightKg=ac.cruise.massKg, costIndex=ac.costIndex, delayMarginMin=margin)


@dataclass
class Scenario:
    """The scenario file. ``aircraftType`` and ``nominalMassKg`` are ``NasAnalysis::PerformanceModel``'s."""

    name: str
    aircraftType: str
    nominalMassKg: float
    geometry: dict[str, Any]
    costs: dict[str, Any]
    flights: list[ScenarioFlight]
    options: list[ResolutionOption]

    @classmethod
    def load(cls, path: Path, variation: str | None = None) -> "Scenario":
        data = yaml.safe_load(path.read_text(encoding="utf-8"))
        flights = [
            ScenarioFlight(Flight(**f["flight"]), CruiseCondition(**f["cruise"]), f["distanceToGoNm"], f["costIndex"], f["scheduleDeltaMin"], f["hasConnections"])
            for f in data["flights"]
        ]
        opts = [
            ResolutionOption(o["optionId"], o["instructionsNow"], [Maneuver(m["flightNumber"], ManeuverKind(m["kind"]), m.get("deltaFt")) for m in o["maneuvers"]])
            for o in data["options"]
        ]
        sc = cls(data["name"], data["type"]["aircraftType"], float(data["type"]["nominalMassKg"]), data["geometry"], data["costs"], flights, opts)
        if variation == "similar-weights":
            # The check that the comparison is not rigged (experiment-definition.md section 8):
            # both crossing aircraft at the nominal mass with the same cost index.
            sc.name = "similar-weights"
            for a in sc.flights[:2]:
                a.cruise.massKg = sc.nominalMassKg
                a.costIndex = 1.0
        elif variation:
            raise SystemExit(f"unknown variation {variation!r}")
        for a in sc.flights:
            a.performanceShare = airline_share(a, sc.costs["connection_threshold_min"])
        return sc

    def by_flight_number(self, flight_number: str) -> ScenarioFlight:
        return next(a for a in self.flights if a.flightNumber == flight_number)


# --------------------------------------------------------------------------- scoring
@dataclass
class AircraftCost:
    """One aircraft's cost for one option, relative to flying on undisturbed."""

    delta_fuel_kg: float = 0.0
    delta_time_min: float = 0.0
    instructions: int = 0
    follow_ups: int = 0
    unable: bool = False  # the truth model says the aircraft cannot fly the maneuver
    note: str = ""

    @property
    def fuel_equivalent_kg(self) -> float:
        return self.delta_fuel_kg  # cost index term added by the caller, which knows CI


@dataclass
class OptionScore:
    option: ResolutionOption
    feasible: bool
    why: str
    per_aircraft: dict[str, AircraftCost] = field(default_factory=dict)
    risk: str = ""

    def total_instructions(self) -> int:
        return sum(c.instructions for c in self.per_aircraft.values())

    def total_follow_ups(self) -> int:
        return sum(c.follow_ups for c in self.per_aircraft.values())


def maneuver_cost(perf: PerformanceModel | None, sc: Scenario, ac: ScenarioFlight, mass: float, man: Maneuver) -> AircraftCost:
    """Cost of one maneuver for one aircraft, evaluated at ``mass``.

    ``perf`` is None at conceptual fidelity: only counts are returned.
    """
    g = sc.geometry
    cost = AircraftCost(instructions=1)
    kind = man.kind
    if kind == "speed":
        cost.unable = not g["speed_lever_separates"]
        cost.note = "built to fail: cannot separate the pair within +/-%.2f Mach" % g["speed_change_mach"]
        cost.follow_ups = 1
        return cost
    if perf is None:
        cost.follow_ups = 1 if kind in ("altitude", "vector") else 0
        if kind == "altitude" and man.deltaFt < 0 and not g["reclimb_available"]:
            cost.follow_ups = 0
        return cost

    hold_h = g["maneuver_hold_min"] / 60.0
    tas = tas_kt(ac.cruise.machNumber, ac.cruise.altitudeFt)
    ff_old = perf.cruise_fuel_flow(mass, ac.cruise.machNumber, ac.cruise.altitudeFt)

    if kind == "altitude":
        new_alt = ac.cruise.altitudeFt + man.deltaFt
        if not perf.can_hold_level(mass, ac.cruise.machNumber, new_alt, g.get("min_climb_rate_ft_min", 0.0)):
            cost.unable = True
            cost.note = f"cannot hold FL{int(new_alt/100)} at {mass:.0f} kg"
            return cost
        rate = perf.climb_rate_fpm(mass, ac.cruise.machNumber, ac.cruise.altitudeFt, new_alt) if man.deltaFt > 0 else DESCENT_RATE_FPM
        t_change_h = abs(man.deltaFt / rate) / 60.0
        ff_change = perf.cruise_fuel_flow(mass, ac.cruise.machNumber, (ac.cruise.altitudeFt + new_alt) / 2, verticalSpeedFtPerMin=rate)
        ff_new = perf.cruise_fuel_flow(mass, ac.cruise.machNumber, new_alt)
        tas_new = tas_kt(ac.cruise.machNumber, new_alt)
        # the change itself, then the hold at the new level
        delta_fuel = (ff_change - ff_old) * t_change_h * 3600 + (ff_new - ff_old) * hold_h * 3600
        delta_time_h = hold_h * (tas / tas_new - 1.0)  # same ground distance at a different TAS
        if man.deltaFt < 0 and g["reclimb_available"]:
            # second instruction: climb back after the hold
            rate_back = perf.climb_rate_fpm(mass, ac.cruise.machNumber, new_alt, ac.cruise.altitudeFt)
            t_back_h = abs(man.deltaFt / rate_back) / 60.0
            ff_back = perf.cruise_fuel_flow(mass, ac.cruise.machNumber, (ac.cruise.altitudeFt + new_alt) / 2, verticalSpeedFtPerMin=rate_back)
            delta_fuel += (ff_back - ff_old) * t_back_h * 3600
            cost.follow_ups = 1
        elif man.deltaFt < 0:
            # stays at the lower level for the rest of the flight
            rest_h = max(0.0, ac.distanceToGoNm / tas - hold_h)
            delta_fuel += (ff_new - ff_old) * rest_h * 3600
            delta_time_h += rest_h * (tas / tas_new - 1.0)
            cost.follow_ups = 0
            cost.note = "stays at the lower level"
        else:
            cost.follow_ups = 1  # cleared back to the planned level, or left higher: one more call
        cost.delta_fuel_kg = delta_fuel
        cost.delta_time_min = delta_time_h * 60
        return cost

    if kind == "vector":
        extra_h = g["vector_extra_nm"] / tas
        cost.delta_fuel_kg = ff_old * extra_h * 3600
        cost.delta_time_min = extra_h * 60
        cost.follow_ups = 1  # resume own navigation
        return cost

    if kind == "slow":
        new_mach = ac.cruise.machNumber - g["slow_ac3_mach"]
        t_h = g["slow_ac3_min"] / 60.0
        ff_slow = perf.cruise_fuel_flow(mass, new_mach, ac.cruise.altitudeFt)
        dist = tas * t_h  # NM covered at the slower speed during the hold
        t_slow_h = dist / tas_kt(new_mach, ac.cruise.altitudeFt)
        cost.delta_fuel_kg = ff_slow * t_slow_h * 3600 - ff_old * t_h * 3600
        cost.delta_time_min = (t_slow_h - t_h) * 60
        cost.follow_ups = 1  # resume normal speed
        return cost

    raise ValueError(f"unknown maneuver kind {kind!r}")


def option_feasible_for_decider(sc: Scenario, opt: ResolutionOption, case: str, perf: PerformanceModel | None) -> tuple[bool, str]:
    """Can this case offer this option, given what it knows?"""
    g = sc.geometry
    for man in opt.maneuvers:
        ac = sc.by_flight_number(man.flightNumber)
        if man.kind == "altitude":
            new_alt = ac.cruise.altitudeFt + man.deltaFt
            if new_alt in g["blocked_levels_ft"] and not any(m.kind == ManeuverKind.slow for m in opt.maneuvers):
                return False, f"FL{int(new_alt/100)} occupied under the crossing"
            if man.deltaFt > 0:
                if case in ("A", "B"):  # not given the share: no weight
                    if ac.cruise.altitudeFt > g["climb_rule_ft"]:
                        return False, f"climb not offered above FL{int(g['climb_rule_ft']/100)} without the weight"
                elif perf is not None and not perf.can_hold_level(ac.performanceShare.grossWeightKg, ac.cruise.machNumber, new_alt, g.get("min_climb_rate_ft_min", 0.0)):
                    return False, f"{ac.flightNumber} cannot hold FL{int(new_alt/100)} at its weight"
        if man.kind == "speed" and case == "A":
            return False, "usable speed range unknown"
    return True, ""


def score_option(sc: Scenario, opt: ResolutionOption, perf: PerformanceModel | None, mass_of: dict[str, float]) -> OptionScore:
    """Truth-model score of an option: every aircraft, at the masses given."""
    g = sc.geometry
    feasible, why = True, ""
    for man in opt.maneuvers:
        ac = sc.by_flight_number(man.flightNumber)
        if man.kind == "altitude":
            new_alt = ac.cruise.altitudeFt + man.deltaFt
            if new_alt in g["blocked_levels_ft"] and not any(m.kind == ManeuverKind.slow for m in opt.maneuvers):
                feasible, why = False, f"FL{int(new_alt/100)} occupied under the crossing"
        if man.kind == "speed" and not g["speed_lever_separates"]:
            feasible, why = False, "speed change cannot separate the pair"
    score = OptionScore(opt, feasible, why)
    kinds = {m.kind for m in opt.maneuvers}
    score.risk = "high" if "speed" in kinds else ("medium" if kinds & {"vector", "slow"} else "low")
    for ac in sc.flights:
        man = opt.maneuver_for(ac.flightNumber)
        if man is not None:
            c = maneuver_cost(perf, sc, ac, mass_of[ac.flightNumber], man)
            if c.unable:
                score.feasible, score.why = False, f"{ac.flightNumber} unable: {c.note}"
        else:
            c = AircraftCost()
        score.per_aircraft[ac.flightNumber] = c
    return score


def airline_cost_usd(sc: Scenario, score: OptionScore, with_connections: bool) -> dict[str, dict[str, float | bool]]:
    """Per-airline cost: fuel + CI x time (in fuel-equivalent kg, then USD), connection flag, CO2 priced."""
    costs = sc.costs
    out: dict[str, dict[str, float | bool]] = {}
    for ac in sc.flights:
        c = score.per_aircraft[ac.flightNumber]
        fe = c.delta_fuel_kg + ac.costIndex * c.delta_time_min
        co2 = costs["co2_per_kg_fuel"] * c.delta_fuel_kg
        missed = bool(ac.hasConnections and (ac.scheduleDeltaMin + c.delta_time_min) > costs["connection_threshold_min"] and ac.scheduleDeltaMin <= costs["connection_threshold_min"])
        row = out.setdefault(ac.airline, {"fuel_equivalent_kg": 0.0, "usd": 0.0, "co2_kg": 0.0, "missed_connection": False})
        row["fuel_equivalent_kg"] += fe
        row["usd"] += fe * costs["fuel_price_usd_per_kg"] + co2 / 1000 * costs["carbon_price_usd_per_t"]
        row["co2_kg"] += co2
        row["missed_connection"] = bool(row["missed_connection"] or (missed and with_connections))
    return out


# --------------------------------------------------------------------------- the cases
def decide(sc: Scenario, case: str, perf: PerformanceModel | None, scores_by_mass: dict[str, dict[str, OptionScore]]) -> tuple[str | None, str]:
    """Which option this case picks, using only what it knows. Returns (option id, reason)."""
    if case == "A":
        # One descent clearance (rantanen2012conflictManeuvers). Tie-breaker: move the
        # crossing aircraft with farther to go (farther from top of descent).
        pair = sorted(sc.flights[:2], key=lambda a: -a.distanceToGoNm)
        for ac in pair:
            for opt in sc.options:
                man = opt.maneuver_for(ac.flightNumber)
                if man and man.kind == "altitude" and man.deltaFt < 0 and len(opt.maneuvers) == 1:
                    ok, why = option_feasible_for_decider(sc, opt, case, perf)
                    if ok:
                        return opt.optionId, f"rule: one descent; {ac.flightNumber} moved (farther to go)"
            # a descent blocked under the crossing: the combined option (descend + open a gap)
            for opt in sc.options:
                man = opt.maneuver_for(ac.flightNumber)
                if man and man.kind == "altitude" and man.deltaFt < 0 and len(opt.maneuvers) > 1:
                    ok, why = option_feasible_for_decider(sc, opt, case, perf)
                    if ok:
                        return opt.optionId, f"rule: one descent, gap opened; {ac.flightNumber} moved"
        return None, "no descent available"

    key = "nominal" if case == "B" else "actual"
    best, best_cost, reason = None, math.inf, ""
    for opt in sc.options:
        ok, why = option_feasible_for_decider(sc, opt, case, perf)
        if not ok:
            continue
        sc_opt = scores_by_mass[key][opt.optionId]
        if not sc_opt.feasible:
            continue
        # the decider's estimate: sum over the aircraft it moves of fuel + CI x time
        est = 0.0
        for ac in sc.flights:
            c = sc_opt.per_aircraft[ac.flightNumber]
            share = ac.performanceShare if case in ("C", "D") else None  # A and B are not given the share
            ci = share.costIndex if share else 1.0  # B knows no cost index: time at 1 kg/min
            est += c.delta_fuel_kg + ci * c.delta_time_min
            if case == "D" and share.delayMarginMin is not None:
                over = c.delta_time_min > share.delayMarginMin >= 0
                est += 1e6 if over else 0.0  # K unsourced: treated as prohibitive
        if perf is None:
            est = sc_opt.total_instructions() + sc_opt.total_follow_ups()  # conceptual: fewest calls
        if est < best_cost - 1e-9:
            best, best_cost, reason = opt.optionId, est, f"lowest estimated cost {est:.1f} ({'calls' if perf is None else 'kg fuel-equivalent'})"
    return best, reason


# --------------------------------------------------------------------------- outputs
def run(sc: Scenario, fidelity: str) -> dict[str, Any]:
    fidelity = FidelityLevel(fidelity)
    perf = None if fidelity == FidelityLevel.conceptual else PerformanceModel(sc.aircraftType)
    actual = {a.flightNumber: a.cruise.massKg for a in sc.flights}
    nominal = {a.flightNumber: sc.nominalMassKg for a in sc.flights}
    truth_mass = nominal if fidelity == FidelityLevel.nominalMass else actual
    scores = {
        "actual": {o.optionId: score_option(sc, o, perf, actual) for o in sc.options},
        "nominal": {o.optionId: score_option(sc, o, perf, nominal) for o in sc.options},
    }
    truth = {o.optionId: score_option(sc, o, perf, truth_mass) for o in sc.options}
    cases = {}
    for case in CASES:
        chosen, reason = decide(sc, case, perf, scores)
        cases[case] = {"option": chosen, "reason": reason, "truth": truth[chosen] if chosen else None}
    return {"fidelity": fidelity, "scenario": sc, "truth": truth, "cases": cases}


def write_tables(res: dict[str, Any]) -> list[Path]:
    sc: Scenario = res["scenario"]
    truth: dict[str, OptionScore] = res["truth"]
    TABLE_DIR.mkdir(parents=True, exist_ok=True)
    tag = f"{sc.name}_{res['fidelity']}"
    written = []
    conceptual = res["fidelity"] == "conceptual"

    # Table 1: every option at four levels
    p1 = TABLE_DIR / f"options_{tag}.csv"
    with p1.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        head = ["option", "feasible", "why"] + [f"{a.flightNumber} fuel kg" for a in sc.flights] + [f"{a.flightNumber} time min" for a in sc.flights]
        head += [f"airline {x} USD" for x in sorted({a.airline for a in sc.flights})] + ["instructions", "follow-ups", "risk", "system fuel kg", "system CO2 kg", "largest fuel-equiv kg (ac)"]
        w.writerow(head)
        for oid, s in truth.items():
            air = airline_cost_usd(sc, s, with_connections=True)
            fe = {a.flightNumber: s.per_aircraft[a.flightNumber].delta_fuel_kg + a.costIndex * s.per_aircraft[a.flightNumber].delta_time_min for a in sc.flights}
            worst = max(fe, key=fe.get)
            row = [oid, "yes" if s.feasible else "no", s.why]
            row += ["" if conceptual else f"{s.per_aircraft[a.flightNumber].delta_fuel_kg:.1f}" for a in sc.flights]
            row += ["" if conceptual else f"{s.per_aircraft[a.flightNumber].delta_time_min:.2f}" for a in sc.flights]
            row += ["" if conceptual else f"{air[x]['usd']:.0f}" for x in sorted(air)]
            row += [s.total_instructions(), s.total_follow_ups(), s.risk]
            row += ["" if conceptual else f"{sum(c.delta_fuel_kg for c in s.per_aircraft.values()):.1f}", "" if conceptual else f"{sc.costs['co2_per_kg_fuel']*sum(c.delta_fuel_kg for c in s.per_aircraft.values()):.1f}", "" if conceptual else f"{fe[worst]:.1f} ({worst})"]
            w.writerow(row)
    written.append(p1)

    # Table 2: one row per case, as a difference from case A
    p2 = TABLE_DIR / f"cases_{tag}.csv"
    ref = res["cases"]["A"]["truth"]
    with p2.open("w", newline="", encoding="utf-8") as f:
        w = csv.writer(f)
        w.writerow(["case", "label", "option", "reason", "largest cost to any one aircraft (fuel-equiv kg, vs A)", "airline totals USD (vs A)", "sector: clearances / effort / risk", "system fuel kg (vs A)", "system CO2 kg (vs A)", "missed connection"])
        for case in CASES:
            c = res["cases"][case]
            s: OptionScore | None = c["truth"]
            if s is None:
                w.writerow([case, CASE_LABEL[case], "none", c["reason"], "", "", "", "", "", ""])
                continue
            air = airline_cost_usd(sc, s, with_connections=True)
            air_ref = airline_cost_usd(sc, ref, with_connections=True) if ref else {}
            fe = {a.flightNumber: s.per_aircraft[a.flightNumber].delta_fuel_kg + a.costIndex * s.per_aircraft[a.flightNumber].delta_time_min for a in sc.flights}
            fe_ref = {a.flightNumber: ref.per_aircraft[a.flightNumber].delta_fuel_kg + a.costIndex * ref.per_aircraft[a.flightNumber].delta_time_min for a in sc.flights} if ref else {}
            worst = max(fe, key=fe.get)
            sys_fuel = sum(x.delta_fuel_kg for x in s.per_aircraft.values())
            sys_fuel_ref = sum(x.delta_fuel_kg for x in ref.per_aircraft.values()) if ref else 0.0
            w.writerow([
                case, CASE_LABEL[case], c["option"], c["reason"],
                "" if conceptual else f"{fe[worst]:.1f} ({worst}); vs A {fe[worst]-max(fe_ref.values()):+.1f}",
                "" if conceptual else "; ".join(f"{x}: {air[x]['usd']:.0f} ({air[x]['usd']-air_ref.get(x, {}).get('usd', 0):+.0f})" for x in sorted(air)),
                f"{s.total_instructions()}+{s.total_follow_ups()} / {EFFORT[case]} / {s.risk}",
                "" if conceptual else f"{sys_fuel:.1f} ({sys_fuel-sys_fuel_ref:+.1f})",
                "" if conceptual else f"{sc.costs['co2_per_kg_fuel']*sys_fuel:.1f}",
                "yes" if any(v["missed_connection"] for v in air.values()) else "no",
            ])
    written.append(p2)

    # LaTeX copy of table 2 (the one the report embeds)
    p3 = TABLE_DIR / f"cases_{tag}.tex"
    lines = [
        "% Generated by simulation/experiment_scoring.py; do not edit. Fidelity: " + res["fidelity"],
        "% Scenario: " + sc.name + "; run " + dt.date.today().isoformat(),
        r"\begin{tabular}{@{}llp{3.0cm}p{3.2cm}p{2.6cm}p{2.4cm}@{}}",
        r"\toprule",
        r"Case & Option & Largest cost to any one aircraft (kg fuel-equiv.) & Airline totals (USD) & Sector (calls / effort / risk) & System fuel, CO2 (kg) \\",
        r"\midrule",
    ]
    for case in CASES:
        c = res["cases"][case]
        s = c["truth"]
        if s is None:
            lines.append(f"{case} & none & \\multicolumn{{4}}{{l}}{{{c['reason']}}} \\\\")
            continue
        air = airline_cost_usd(sc, s, with_connections=True)
        fe = {a.flightNumber: s.per_aircraft[a.flightNumber].delta_fuel_kg + a.costIndex * s.per_aircraft[a.flightNumber].delta_time_min for a in sc.flights}
        worst = max(fe, key=fe.get)
        sys_fuel = sum(x.delta_fuel_kg for x in s.per_aircraft.values())
        cell_worst = "--" if conceptual else f"{fe[worst]:.0f} ({worst})"
        cell_air = "--" if conceptual else ", ".join(f"{x} {air[x]['usd']:.0f}" for x in sorted(air))
        cell_sys = "--" if conceptual else f"{sys_fuel:.0f}, {sc.costs['co2_per_kg_fuel']*sys_fuel:.0f}"
        lines.append(f"{case} & {c['option']} & {cell_worst} & {cell_air} & {s.total_instructions()}+{s.total_follow_ups()} / {EFFORT[case]} / {s.risk} & {cell_sys} \\\\")
    lines += [r"\bottomrule", r"\end{tabular}"]
    p3.write_text("\n".join(lines) + "\n", encoding="utf-8")
    written.append(p3)
    return written


def write_results_sysml(res: dict[str, Any]) -> Path:
    """A small SysML v2 file holding the measured values, so the model carries the numbers."""
    sc: Scenario = res["scenario"]
    RESULTS_SYSML.parent.mkdir(parents=True, exist_ok=True)
    lines = [
        "package ExperimentResults {",
        "    doc /* GENERATED by projects/nas-sos-capstone/simulation/experiment_scoring.py on",
        f"     * {dt.date.today().isoformat()}; scenario {sc.name}; truth-model fidelity {res['fidelity']}.",
        "     * Do not edit. One attribute usage per case: the option chosen and the measured",
        "     * values the verification cases in nas_verification.sysml read (D-017, D-018). */",
        "    private import ScalarValues::*;",
        "",
    ]
    for case in CASES:
        c = res["cases"][case]
        s = c["truth"]
        sys_fuel = sum(x.delta_fuel_kg for x in s.per_aircraft.values()) if s else 0.0
        lines += [
            f"    attribute case{case}Option : String = \"{c['option'] or 'none'}\";",
            f"    attribute case{case}SystemDeltaFuelKg : Real = {sys_fuel:.1f};",
            f"    attribute case{case}Instructions : Integer = {s.total_instructions() + s.total_follow_ups() if s else 0};",
        ]
    lines.append("}")
    RESULTS_SYSML.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return RESULTS_SYSML


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    ap.add_argument("--fidelity", choices=FIDELITIES, default="actualMass")
    ap.add_argument("--variation", choices=["similar-weights"], default=None)
    ap.add_argument("--scenario", type=Path, default=HERE / "scenario_base.yaml")
    ap.add_argument("--no-sysml", action="store_true", help="do not write the results .sysml file")
    args = ap.parse_args(argv)

    sc = Scenario.load(args.scenario, args.variation)
    res = run(sc, args.fidelity)
    for case in CASES:
        c = res["cases"][case]
        s = c["truth"]
        extra = ""
        if s is not None and args.fidelity != "conceptual":
            sys_fuel = sum(x.delta_fuel_kg for x in s.per_aircraft.values())
            extra = f"; system fuel {sys_fuel:+.1f} kg; calls {s.total_instructions()}+{s.total_follow_ups()}"
        print(f"case {case}: {c['option']} ({c['reason']}){extra}")
    for p in write_tables(res):
        print("wrote", p.relative_to(PROJECT.parent.parent))
    if not args.no_sysml:
        print("wrote", write_results_sysml(res).relative_to(PROJECT.parent.parent))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
