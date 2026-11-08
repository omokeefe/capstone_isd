"""Tests for experiment_scoring.py (D-017).

Run from the repo root:
    .venv/Scripts/python.exe -m pytest projects/nas-sos-capstone/simulation -q
"""

from __future__ import annotations

from pathlib import Path

import pytest

import experiment_scoring as es

HERE = Path(__file__).resolve().parent
SCENARIO = HERE / "scenario_base.yaml"


@pytest.fixture(scope="module")
def base():
    sc = es.Scenario.load(SCENARIO)
    return sc, es.run(sc, "actualMass")


def test_scenario_asymmetry(base):
    """The light aircraft can hold the climb level with the climb margin left; the heavy one cannot (D-013 item 4, D-023)."""
    sc, _ = base
    perf = es.PerformanceModel(sc.aircraftType)
    heavy, light = sc.flights[0], sc.flights[1]
    up = heavy.cruise.altitudeFt + 2000
    margin = sc.geometry["min_climb_rate_ft_min"]
    assert margin >= 100  # the service-ceiling definition, faa2015ac61107b para. 1-4r
    assert perf.can_hold_level(heavy.cruise.massKg, heavy.cruise.machNumber, heavy.cruise.altitudeFt, margin)
    assert perf.can_hold_level(light.cruise.massKg, light.cruise.machNumber, up, margin)
    assert not perf.can_hold_level(heavy.cruise.massKg, heavy.cruise.machNumber, up, margin)


def test_case_b_cannot_tell_the_pair_apart(base):
    """With one type and a nominal mass, O1 and O2 (same maneuver, different aircraft) cost the same to case B."""
    sc, _ = base
    perf = es.PerformanceModel(sc.aircraftType)
    nominal = {a.flightNumber: sc.nominalMassKg for a in sc.flights}
    o3 = es.score_option(sc, next(o for o in sc.options if o.optionId == "O3"), perf, nominal)
    o4 = es.score_option(sc, next(o for o in sc.options if o.optionId == "O4"), perf, nominal)
    assert o3.per_aircraft["AC1"].delta_fuel_kg == pytest.approx(o4.per_aircraft["AC2"].delta_fuel_kg, rel=1e-9)


def test_case_c_can_tell_the_pair_apart(base):
    sc, _ = base
    perf = es.PerformanceModel(sc.aircraftType)
    actual = {a.flightNumber: a.cruise.massKg for a in sc.flights}
    o3 = es.score_option(sc, next(o for o in sc.options if o.optionId == "O3"), perf, actual)
    o4 = es.score_option(sc, next(o for o in sc.options if o.optionId == "O4"), perf, actual)
    assert not o3.feasible  # heavy cannot climb
    assert o4.feasible  # light can


def test_climb_rule_closes_climbs_to_a_and_b(base):
    sc, _ = base
    perf = es.PerformanceModel(sc.aircraftType)
    o4 = next(o for o in sc.options if o.optionId == "O4")
    assert es.option_feasible_for_decider(sc, o4, "A", perf)[0] is False
    assert es.option_feasible_for_decider(sc, o4, "B", perf)[0] is False
    assert es.option_feasible_for_decider(sc, o4, "C", perf)[0] is True


def test_speed_lever_fails(base):
    sc, res = base
    assert res["truth"]["O7"].feasible is False


def test_instruction_counts_match_options_table(base):
    """Instructions now per experiment-options-and-scoring.md section 2."""
    sc, res = base
    expected_now = {"O1": 1, "O2": 1, "O3": 1, "O4": 1, "O5": 1, "O6": 1, "O7": 1, "O8": 1, "O9": 3, "O10": 1}
    for oid, n in expected_now.items():
        assert res["truth"][oid].total_instructions() == n, oid


def test_every_case_chooses_a_feasible_option(base):
    _, res = base
    for case in es.CASES:
        c = res["cases"][case]
        assert c["option"] is not None, case
        assert c["truth"].feasible, (case, c["option"], c["truth"].why)


# The two tests below replace test_similar_weights_variation_makes_c_match_b (D-024). With the
# pair at the same weight and cost index, case C still differs from case B in one way: it knows
# the weight, so the climb rule does not bind it. Each test checks one half of "not rigged".
def test_similar_weights_same_numbers_for_every_option():
    """Same weights in, same fuel and time out: the nominal-mass and actual-mass scores agree on every option."""
    sc = es.Scenario.load(SCENARIO, "similar-weights")
    perf = es.PerformanceModel(sc.aircraftType)
    actual = {a.flightNumber: a.cruise.massKg for a in sc.flights}
    nominal = {a.flightNumber: sc.nominalMassKg for a in sc.flights}
    assert actual == nominal
    for opt in sc.options:
        at_actual, at_nominal = es.score_option(sc, opt, perf, actual), es.score_option(sc, opt, perf, nominal)
        assert at_actual.feasible == at_nominal.feasible, opt.optionId
        for ac in sc.flights:
            a, n = at_actual.per_aircraft[ac.flightNumber], at_nominal.per_aircraft[ac.flightNumber]
            assert a.delta_fuel_kg == pytest.approx(n.delta_fuel_kg), (opt.optionId, ac.flightNumber)
            assert a.delta_time_min == pytest.approx(n.delta_time_min), (opt.optionId, ac.flightNumber)


def test_similar_weights_with_the_climb_closed_c_matches_b():
    """With the level above occupied, so nobody can climb, case C chooses what case B chooses: the climb is all that separates them."""
    sc = es.Scenario.load(SCENARIO, "similar-weights")
    pair_level = sc.flights[0].cruise.altitudeFt
    sc.geometry = {**sc.geometry, "blocked_levels_ft": [*sc.geometry["blocked_levels_ft"], pair_level + 2000]}
    res = es.run(sc, "actualMass")
    assert res["cases"]["C"]["option"] == res["cases"]["B"]["option"]
    # and with the level above open again, the climb is what case C takes
    open_res = es.run(es.Scenario.load(SCENARIO, "similar-weights"), "actualMass")
    chosen = next(o for o in sc.options if o.optionId == open_res["cases"]["C"]["option"])
    assert any(m.kind == es.ManeuverKind.altitude and m.deltaFt > 0 for m in chosen.maneuvers)
    assert es.option_feasible_for_decider(sc, chosen, "B", perf=None)[0] is False


def test_conceptual_fidelity_has_no_fuel_numbers():
    sc = es.Scenario.load(SCENARIO)
    res = es.run(sc, "conceptual")
    for s in res["truth"].values():
        assert all(c.delta_fuel_kg == 0.0 for c in s.per_aircraft.values())
    for case in es.CASES:
        assert res["cases"][case]["option"] is not None


def test_tables_and_results_file(tmp_path, monkeypatch, base):
    sc, res = base
    monkeypatch.setattr(es, "TABLE_DIR", tmp_path / "tables")
    monkeypatch.setattr(es, "RESULTS_SYSML", tmp_path / "results" / "experiment_results.sysml")
    written = es.write_tables(res)
    assert len(written) == 5 and all(p.exists() for p in written)  # options, cases (csv, tex), level check (csv, tex)
    assert any(p.name.startswith("level_check_") and p.suffix == ".tex" for p in written)
    out = es.write_results_sysml(res)
    text = out.read_text(encoding="utf-8")
    assert "package ExperimentResults" in text and "caseAOption" in text


# --------------------------------------------------------------------------- D-041: stay at the new level
def _o(sc, oid):
    return next(o for o in sc.options if o.optionId == oid)


def _stay(sc):
    sc.geometry = {**sc.geometry, "stay_at_new_level": "if_better"}
    return sc


def test_stay_rule_is_off_by_default():
    """Table 8 is the 'never' run: O4's climb is followed by a call back, and the level check is only reported."""
    sc = es.Scenario.load(SCENARIO)
    assert sc.geometry["stay_at_new_level"] == "never"
    perf = es.PerformanceModel(sc.aircraftType)
    actual = {a.flightNumber: a.cruise.massKg for a in sc.flights}
    c = es.score_option(sc, _o(sc, "O4"), perf, actual).per_aircraft["AC2"]
    assert c.follow_ups == 1 and not c.stays
    assert c.new_level_better is True and c.beyond_hold_fuel_kg < 0


def test_stay_if_better_keeps_the_fuel_and_drops_the_return_call():
    never = es.Scenario.load(SCENARIO)
    stay = _stay(es.Scenario.load(SCENARIO))
    perf = es.PerformanceModel(never.aircraftType)
    actual = {a.flightNumber: a.cruise.massKg for a in never.flights}
    for oid, flight in (("O4", "AC2"), ("O8", "AC1"), ("O10", "AC2")):
        a = es.score_option(never, _o(never, oid), perf, actual).per_aircraft[flight]
        b = es.score_option(stay, _o(stay, oid), perf, actual).per_aircraft[flight]
        assert b.delta_fuel_kg == pytest.approx(a.delta_fuel_kg, rel=1e-12), oid  # hold window unchanged
        assert b.follow_ups == (0 if a.new_level_better else a.follow_ups), oid
    assert es.run(stay, "actualMass")["cases"]["C"]["option"] == "O4"


def test_after_the_hold_is_the_rest_of_the_flight_at_the_new_level():
    sc = es.Scenario.load(SCENARIO)
    perf = es.PerformanceModel(sc.aircraftType)
    ac2 = sc.by_flight_number("AC2")
    m, M, alt = ac2.cruise.massKg, ac2.cruise.machNumber, ac2.cruise.altitudeFt
    c = es.score_option(sc, _o(sc, "O4"), perf, {a.flightNumber: a.cruise.massKg for a in sc.flights}).per_aircraft["AC2"]
    rest_h = ac2.distanceToGoNm / es.tas_kt(M, alt) - sc.geometry["maneuver_hold_min"] / 60
    assert c.beyond_hold_min == pytest.approx(rest_h * 60)
    assert c.beyond_hold_fuel_kg == pytest.approx((perf.cruise_fuel_flow(m, M, alt + 2000) - perf.cruise_fuel_flow(m, M, alt)) * rest_h * 3600)


def test_a_climb_that_is_not_better_comes_back_and_the_descent_is_costed(monkeypatch):
    """Make FL400 worse for AC2 (10% more fuel there): under if_better it returns, and the descent back is costed."""
    never = es.Scenario.load(SCENARIO)
    stay = _stay(es.Scenario.load(SCENARIO))
    perf = es.PerformanceModel(never.aircraftType)
    real = perf.cruise_fuel_flow
    monkeypatch.setattr(perf, "cruise_fuel_flow", lambda m, M, alt, verticalSpeedFtPerMin=0.0: real(m, M, alt, verticalSpeedFtPerMin) * (1.1 if alt == 40000 and verticalSpeedFtPerMin == 0 else 1.0))
    actual = {a.flightNumber: a.cruise.massKg for a in never.flights}
    a = es.score_option(never, _o(never, "O4"), perf, actual).per_aircraft["AC2"]
    b = es.score_option(stay, _o(stay, "O4"), perf, actual).per_aircraft["AC2"]
    assert a.new_level_better is False and b.new_level_better is False
    assert not b.stays and b.follow_ups == 1 and b.beyond_hold_fuel_kg == 0.0
    ac2 = stay.by_flight_number("AC2")
    t_back_h = 2000 / abs(perf.descent_rate_fpm) / 60
    descent_back = (real(ac2.cruise.massKg, 0.80, 39000, perf.descent_rate_fpm) - real(ac2.cruise.massKg, 0.80, 38000)) * t_back_h * 3600
    assert descent_back < 0  # a descent burns less than cruise
    assert b.delta_fuel_kg == pytest.approx(a.delta_fuel_kg + descent_back)
