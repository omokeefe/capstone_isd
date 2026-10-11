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
    """The light aircraft can hold the climb level; the heavy one cannot (D-013 item 4)."""
    sc, _ = base
    perf = es.Performance(sc.type_icao)
    heavy, light = sc.aircraft[0], sc.aircraft[1]
    up = heavy.level_ft + 2000
    assert perf.can_hold(light.mass_kg, light.mach, up)
    assert not perf.can_hold(heavy.mass_kg, heavy.mach, up)


def test_case_b_cannot_tell_the_pair_apart(base):
    """With one type and a nominal mass, O1 and O2 (same maneuver, different aircraft) cost the same to case B."""
    sc, _ = base
    perf = es.Performance(sc.type_icao)
    nominal = {a.id: sc.nominal_mass_kg for a in sc.aircraft}
    o3 = es.score_option(sc, next(o for o in sc.options if o.id == "O3"), perf, nominal)
    o4 = es.score_option(sc, next(o for o in sc.options if o.id == "O4"), perf, nominal)
    assert o3.per_aircraft["AC1"].delta_fuel_kg == pytest.approx(o4.per_aircraft["AC2"].delta_fuel_kg, rel=1e-9)


def test_case_c_can_tell_the_pair_apart(base):
    sc, _ = base
    perf = es.Performance(sc.type_icao)
    actual = {a.id: a.mass_kg for a in sc.aircraft}
    o3 = es.score_option(sc, next(o for o in sc.options if o.id == "O3"), perf, actual)
    o4 = es.score_option(sc, next(o for o in sc.options if o.id == "O4"), perf, actual)
    assert not o3.feasible  # heavy cannot climb
    assert o4.feasible  # light can


def test_climb_rule_closes_climbs_to_a_and_b(base):
    sc, _ = base
    perf = es.Performance(sc.type_icao)
    o4 = next(o for o in sc.options if o.id == "O4")
    assert es.option_feasible_for_decider(sc, o4, "A", perf)[0] is False
    assert es.option_feasible_for_decider(sc, o4, "B", perf)[0] is False
    assert es.option_feasible_for_decider(sc, o4, "C", perf)[0] is True


def test_speed_lever_fails(base):
    sc, res = base
    assert res["truth"]["O7"].feasible is False


def test_instruction_counts_match_options_table(base):
    """Instructions now per experiment-options-and-scoring.md section 2."""
    sc, res = base
    expected_now = {"O1": 1, "O2": 1, "O3": 1, "O4": 1, "O5": 1, "O6": 1, "O7": 1, "O8": 1, "O9": 2}
    for oid, n in expected_now.items():
        assert res["truth"][oid].total_instructions() == n, oid


def test_every_case_chooses_a_feasible_option(base):
    _, res = base
    for case in es.CASES:
        c = res["cases"][case]
        assert c["option"] is not None, case
        assert c["truth"].feasible, (case, c["option"], c["truth"].why)


def test_similar_weights_variation_makes_c_match_b():
    """When the pair have the same weight and cost index, sharing them changes nothing (experiment-definition.md section 8)."""
    sc = es.Scenario.load(SCENARIO, "similar-weights")
    res = es.run(sc, "actualMass")
    assert res["cases"]["C"]["option"] == res["cases"]["B"]["option"]


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
    assert len(written) == 3 and all(p.exists() for p in written)
    out = es.write_results_sysml(res)
    text = out.read_text(encoding="utf-8")
    assert "package ExperimentResults" in text and "caseAOption" in text
