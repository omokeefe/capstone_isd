"""Walk through the scoring of option O4 (AC2 climbs 2,000 ft) one step at a time.

For the hand check of one table entry (to-do-list.md Track B, "the two checks"; journal
2026-10-29: recompute O4's 12.4 kg by hand and compare with OpenAP).

Under the VS Code debugger (launch configuration "Debug O4 walk-through" in
.vscode/launch.json), every ``breakpoint()`` in ``main()`` is a stop. The Variables pane
shows the numbers just computed; the comment above each stop says how to check them by
hand. F5 goes to the next stop; F11 on a line that calls OpenAP steps into it.

Without the debugger it prints the same numbers as a worksheet and does not stop:
    .venv/Scripts/python.exe projects/nas-sos-capstone/simulation/debug_o4_walkthrough.py

The steps repeat the altitude branch of ``experiment_scoring.maneuver_cost`` in the open,
down to OpenAP's drag polar and fuel curve. The last stops call the real functions and
assert that every number matches, so the walk cannot drift from the code that produced
Table 8 of the report. Writes nothing.
"""

from __future__ import annotations

import math
import os
import sys
from pathlib import Path
from typing import Any

if "debugpy" not in sys.modules:
    os.environ.setdefault("PYTHONBREAKPOINT", "0")  # plain run: the breakpoint() calls do nothing

import experiment_scoring as es

OPTION = "O4"
FLIGHT = "AC2"


def close(a: float, b: float) -> bool:
    return math.isclose(a, b, rel_tol=1e-9, abs_tol=1e-12)


def show(title: str, **values: Any) -> None:
    print(f"\n== {title}")
    for name, v in values.items():
        print(f"   {name:<34} {v:,.6g}" if isinstance(v, float) else f"   {name:<34} {v}")


def fuel_model_constants(ff: Any) -> tuple[float, float, float, float]:
    """c1, c2, c3 and scale of OpenAP's fuel curve, chosen the way FuelFlow._load_fuel_model chooses them."""
    import openap
    import pandas as pd

    table = pd.read_csv(Path(openap.__file__).parent / "data" / "fuel" / "fuel_models.csv")
    table["typecode"] = table.typecode.str.lower()
    code = ff.ac if ff.ac in table.typecode.values else "default"
    p = table[table.typecode == code].iloc[0]
    if code == "default":
        scale = ff.engine["ff_to"]  # B39M is not in the table: default curve x this engine's take-off fuel flow
    elif ff.engine_type != str(p["engine_type"]).upper():
        scale = ff.engine["ff_to"] / openap.prop.engine(p["engine_type"])["ff_to"]
    else:
        scale = 1.0
    return float(p["c1"]), float(p["c2"]), float(p["c3"]), float(scale)


def fuel_flow_breakdown(perf: es.PerformanceModel, mass: float, mach: float, alt_ft: float, vs_fpm: float = 0.0) -> dict[str, float]:
    """OpenAP's FuelFlow.enroute, one term at a time. Asserted equal to the real call."""
    ff = perf.fuel
    aero = ff.drag.aero
    assert not ff.drag.wave_drag, "wave drag is on: this breakdown leaves it out"
    tas = es.tas_kt(mach, alt_ft)
    v = tas * aero.kts                              # m/s
    # Flight-path angle, rad, as OpenAP computes it (FuelFlow.enroute and Drag._cl): atan2 treats TAS as
    # the horizontal side. TAS is the hypotenuse, so asin(vs / TAS) is the exact angle; kept as OpenAP has
    # it so the asserts hold. For O4's climb the two differ by 0.00002 deg and 0.001 kg of fuel.
    gamma = math.atan2(vs_fpm * aero.fpm, v)
    rho = float(aero.density(alt_ft * aero.ft))     # ISA density, kg/m^3
    S = ff.drag.aircraft["wing"]["area"]            # m^2
    qS = 0.5 * rho * v**2 * S                       # dynamic pressure x wing area, N
    L = mass * aero.g0 * math.cos(gamma)            # lift, N
    CL = L / qS
    cd0, k = ff.drag.polar["clean"]["cd0"], ff.drag.polar["clean"]["k"]
    CD = cd0 + k * CL**2                            # drag polar
    D = CD * qS                                     # drag, N
    T = D + mass * 9.81 * math.sin(gamma)           # thrust needed, N (OpenAP uses 9.81 here)
    n_eng = ff.aircraft["engine"]["number"]
    max_thrust = ff.engine["max_thrust"]            # per engine, N
    ratio_raw = T / n_eng / max_thrust
    # OpenAP's smooth limit to [0.03, 1.2]; inside that range it changes nothing that matters
    ratio = (math.log(1 + math.exp(50 * (ratio_raw - 0.03))) - math.log(1 + math.exp(45 * (ratio_raw - 1.2)))) / math.log(1 + math.exp(50)) + 0.03
    c1, c2, c3, scale = fuel_model_constants(ff)
    ff_engine = scale * (c1 - math.exp(-c2 * (ratio * math.exp(c3 * ratio) - math.log(c1) / c2)))
    ff_total = ff_engine * n_eng                    # kg/s
    real = perf.cruise_fuel_flow(mass, mach, alt_ft, verticalSpeedFtPerMin=vs_fpm)
    assert close(ff_total, real), (ff_total, real)
    return {
        "tas_kt": tas, "v_m_s": v, "gamma_deg": math.degrees(gamma), "rho_kg_m3": rho, "S_m2": S,
        "qS_N": qS, "lift_N": L, "CL": CL, "cd0": cd0, "k": k, "CD": CD, "drag_N": D, "thrust_N": T,
        "max_thrust_per_engine_N": max_thrust, "engines": n_eng, "thrust_ratio": ratio_raw,
        "thrust_ratio_limited": ratio, "c1": c1, "c2": c2, "c3": c3, "scale_kg_s": scale,
        "fuel_flow_per_engine_kg_s": ff_engine, "fuel_flow_kg_s": ff_total, "fuel_flow_kg_h": ff_total * 3600,
    }


def climb_rate_breakdown(perf: es.PerformanceModel, mass: float, mach: float, alt_ft: float) -> dict[str, float]:
    """PerformanceModel.available_climb_rate, one term at a time. Asserted equal to the real call."""
    tas = es.tas_kt(mach, alt_ft)
    thrust_avail = float(perf.thrust.cruise(tas, alt_ft))   # OpenAP maximum cruise thrust, both engines, N
    drag = float(perf.drag.clean(mass, tas, alt_ft))        # level-flight drag, N
    excess = thrust_avail - drag
    roc_m_s = excess * tas * 0.514444 / (mass * 9.80665)    # (T - D) x V / W
    roc_fpm = roc_m_s / 0.3048 * 60
    assert close(roc_fpm, perf.available_climb_rate(mass, mach, alt_ft))
    return {"tas_kt": tas, "thrust_available_N": thrust_avail, "drag_N": drag, "excess_thrust_N": excess, "climb_rate_m_s": roc_m_s, "climb_rate_ft_min": roc_fpm}


def main() -> None:
    sc = es.Scenario.load(es.HERE / "scenario_base.yaml")
    perf = es.PerformanceModel(sc.aircraftType)
    g, costs = sc.geometry, sc.costs
    ac = sc.by_flight_number(FLIGHT)
    opt = next(o for o in sc.options if o.optionId == OPTION)
    man = opt.maneuver_for(FLIGHT)
    mass = ac.cruise.massKg            # the truth model at actualMass scores AC2 at its own mass
    mach = ac.cruise.machNumber
    alt_old = ac.cruise.altitudeFt
    alt_new = alt_old + man.deltaFt
    alt_mid = (alt_old + alt_new) / 2
    hold_min = g["maneuver_hold_min"]
    ci = ac.costIndex
    show("1. Inputs", option=OPTION, flight=FLIGHT, airline=ac.airline, aircraft_type=sc.aircraftType, mass_kg=mass, mach=mach,
         from_ft=alt_old, to_ft=alt_new, hold_min=hold_min, min_climb_left_ft_min=g["min_climb_rate_ft_min"],
         climb_rate_cap_ft_min=es.CLIMB_RATE_FPM, cost_index_kg_min=ci, fuel_usd_kg=costs["fuel_price_usd_per_kg"],
         co2_per_kg_fuel=costs["co2_per_kg_fuel"], carbon_usd_t=costs["carbon_price_usd_per_t"])
    # STOP 1 - Inputs. Check against scenario_base.yaml and knowledge/models/experiment-scenario-numbers.md:
    # AC2 62,980 kg, Mach 0.80, FL380 to FL400, CI 10 = 7.56 kg/min, hold 15 min, 150 ft/min of climb left.
    breakpoint()

    temp_k = es.isa_temp_k(alt_old)
    sound_m_s = math.sqrt(1.4 * 287.05 * temp_k)
    tas_old = es.tas_kt(mach, alt_old)
    tas_new = es.tas_kt(mach, alt_new)
    show("2. Speed", isa_temp_K=temp_k, speed_of_sound_m_s=sound_m_s, tas_FL380_kt=tas_old, tas_FL400_kt=tas_new)
    # STOP 2 - Speed. By hand: above 36,089 ft ISA is 216.65 K; a = sqrt(1.4 x 287.05 x 216.65) = 295.1 m/s;
    # TAS = 0.80 x a = 236.1 m/s = 458.9 kt (/ 0.514444). FL400 is also above the tropopause, so TAS is
    # the same there: the climb costs no time, only fuel.
    breakpoint()

    ff_old = fuel_flow_breakdown(perf, mass, mach, alt_old)
    show("3. Fuel flow, level at FL380 (ff_old)", **ff_old)
    # STOP 3 - Level cruise at FL380, the baseline every other fuel flow is compared with. By hand, in order:
    # qS = 0.5 x rho x v^2 x S; CL = m x 9.80665 / qS; CD = 0.020 + 0.042 x CL^2 (MAX 8 polar, borrowed);
    # D = CD x qS; level flight so thrust = D; ratio = T / (2 x 111,300 N); per engine
    # ff = 0.877 x (c1 - exp(-c2 x (ratio x exp(c3 x ratio) - ln(c1) / c2))), x 2 engines.
    # rho: ISA above the tropopause, rho = 0.36392 x exp(-(h - 11,000 m) / 6,341.6 m).
    breakpoint()

    hold400 = climb_rate_breakdown(perf, mass, mach, alt_new)
    can_hold = hold400["climb_rate_ft_min"] >= g["min_climb_rate_ft_min"]
    show("4. Can AC2 hold FL400?", **hold400, required_ft_min=g["min_climb_rate_ft_min"], can_hold=can_hold)
    # STOP 4 - Feasibility. Climb left at FL400 = (T_available - D) x V / (m x g), in ft/min; O4 is open only
    # if it is at least 150 (the margin [SME]; 100 defines the service ceiling). Cases C and D run this same
    # test at the weight the airline shares, which is AC2's actual weight.
    breakpoint()

    mid = climb_rate_breakdown(perf, mass, mach, alt_mid)
    climb_rate = min(es.CLIMB_RATE_FPM, mid["climb_rate_ft_min"])
    assert close(climb_rate, perf.climb_rate_fpm(mass, mach, alt_old, alt_new))
    t_climb_min = man.deltaFt / climb_rate
    show("5. Climb rate and time", **mid, climb_rate_used_ft_min=climb_rate, climb_time_min=t_climb_min)
    # STOP 5 - The climb is flown at the climb rate maximum thrust leaves at the mid-altitude, FL390, capped at
    # 1,500 ft/min (D-024). Climb time = 2,000 ft / rate.
    breakpoint()

    ff_climb = fuel_flow_breakdown(perf, mass, mach, alt_mid, vs_fpm=climb_rate)
    ff_new = fuel_flow_breakdown(perf, mass, mach, alt_new)
    show("6a. Fuel flow climbing through FL390 (ff_change)", **ff_climb)
    show("6b. Fuel flow, level at FL400 (ff_new)", **ff_new)
    # STOP 6 - Same chain as stop 3 with two differences. Climbing: gamma = atan(vs / V), lift = m g cos(gamma),
    # thrust = D + m x 9.81 x sin(gamma). Level at FL400: thinner air, so a higher CL and a different drag.
    breakpoint()

    climb_extra_kg = (ff_climb["fuel_flow_kg_s"] - ff_old["fuel_flow_kg_s"]) * t_climb_min * 60
    hold_extra_kg = (ff_new["fuel_flow_kg_s"] - ff_old["fuel_flow_kg_s"]) * hold_min * 60
    delta_fuel_kg = climb_extra_kg + hold_extra_kg
    delta_time_min = hold_min * (tas_old / tas_new - 1.0)
    show("7. AC2's cost of O4 against flying on at FL380", climb_extra_kg=climb_extra_kg, hold_extra_kg=hold_extra_kg,
         delta_fuel_kg=delta_fuel_kg, delta_time_min=delta_time_min)
    # STOP 7 - The number to check: extra fuel = (ff_change - ff_old) x climb time + (ff_new - ff_old) x 15 min.
    # Table 8 row C shows 12 (AC2). Not counted by the code (worth a sentence in the write-up): the descent back
    # to FL380 after the hold (the follow-up instruction), and any cruise beyond the 15-minute hold at FL400.
    breakpoint()

    real = es.maneuver_cost(perf, sc, ac, mass, man)
    assert close(real.delta_fuel_kg, delta_fuel_kg) and close(real.delta_time_min, delta_time_min), real
    actual = {a.flightNumber: a.cruise.massKg for a in sc.flights}
    nominal = {a.flightNumber: sc.nominalMassKg for a in sc.flights}
    score = es.score_option(sc, opt, perf, actual)
    per_aircraft = {f: f"fuel {c.delta_fuel_kg:+.2f} kg, time {c.delta_time_min:+.2f} min, calls {c.instructions}+{c.follow_ups}" for f, c in score.per_aircraft.items()}
    show("8. The real code agrees", maneuver_cost_fuel_kg=real.delta_fuel_kg, feasible=score.feasible, **per_aircraft)
    # STOP 8 - experiment_scoring.maneuver_cost and score_option give the same numbers (asserted). Only AC2
    # moves; the other three aircraft cost nothing. Calls: 1 now + 1 later (cleared back), as in Table 8.
    breakpoint()

    per_nm_old = ff_old["fuel_flow_kg_s"] * 3600 / tas_old
    per_nm_new = ff_new["fuel_flow_kg_s"] * 3600 / tas_new
    better = per_nm_new < per_nm_old
    after_hold_min = max(0.0, ac.distanceToGoNm / tas_old * 60 - hold_min)
    after_hold_fuel_kg = (ff_new["fuel_flow_kg_s"] - ff_old["fuel_flow_kg_s"]) * after_hold_min * 60 if better else 0.0
    assert real.new_level_better == better
    if better:
        assert close(real.beyond_hold_min, after_hold_min) and close(real.beyond_hold_fuel_kg, after_hold_fuel_kg)
    show("8b. Would AC2 rather stay at FL400? (D-041)", fuel_per_nm_FL380_kg=per_nm_old, fuel_per_nm_FL400_kg=per_nm_new, new_level_better=better,
         distance_to_go_nm=ac.distanceToGoNm, minutes_after_hold=after_hold_min, fuel_after_hold_if_it_stays_kg=after_hold_fuel_kg)
    # STOP 8b - Fuel per NM = fuel flow (kg/h) / TAS (kt), at each level. Less at FL400, so the crew would
    # likely ask to stay (stay_at_new_level: if_better drops the call back; the 12.44 kg is unchanged). The
    # rest of the flight after the hold is reported, not counted: 584 NM / 458.9 kt = 76.4 min, less the
    # 15-min hold = 61.4 min, x (ff_new - ff_old). Constant mass, cruise to destination: this scenario only.
    breakpoint()

    fe_kg = delta_fuel_kg + ci * delta_time_min
    co2_kg = costs["co2_per_kg_fuel"] * delta_fuel_kg
    usd = fe_kg * costs["fuel_price_usd_per_kg"] + co2_kg / 1000 * costs["carbon_price_usd_per_t"]
    airline = es.airline_cost_usd(sc, score, with_connections=True)
    assert close(airline[ac.airline]["usd"], usd), airline
    show("9. Costs", fuel_equivalent_kg=fe_kg, co2_kg=co2_kg, airline=ac.airline, airline_usd=usd)
    # STOP 9 - Fuel-equivalent = fuel + CI x time = fuel here (no time lost). CO2 = 3.16 x fuel (ICAO).
    # Airline Y = fuel-equivalent x $2.50/kg + CO2 / 1,000 x $15/t. Table 8 row C: Y 32; system fuel and CO2 12, 39.
    breakpoint()

    scores = {"actual": {o.optionId: es.score_option(sc, o, perf, actual) for o in sc.options},
              "nominal": {o.optionId: es.score_option(sc, o, perf, nominal) for o in sc.options}}
    case_c_estimates: dict[str, Any] = {}
    for o in sc.options:
        ok, why = es.option_feasible_for_decider(sc, o, "C", perf)
        s = scores["actual"][o.optionId]
        if not ok:
            case_c_estimates[o.optionId] = f"not offered: {why}"
        elif not s.feasible:
            case_c_estimates[o.optionId] = f"infeasible: {s.why}"
        else:
            case_c_estimates[o.optionId] = round(sum(s.per_aircraft[a.flightNumber].delta_fuel_kg + a.performanceShare.costIndex * s.per_aircraft[a.flightNumber].delta_time_min for a in sc.flights), 2)
    chosen, reason = es.decide(sc, "C", perf, scores)
    assert chosen == OPTION, (chosen, reason)
    show("10. Case C's choice", chosen=chosen, reason=reason, **case_c_estimates)
    # STOP 10 - Case C adds fuel + CI x time over all four aircraft for every option it can offer and picks the
    # lowest: O4. Compare O10 (AC2 down 4,000 ft, the pick of cases A and B). O8 (AC1 down 4,000 ft) is
    # offered by no case since D-047: AC1 would pass through FL360 with AC3 2 NM behind.
    breakpoint()

    print("\nAll steps match experiment_scoring.py.")


if __name__ == "__main__":
    main()
