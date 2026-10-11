"""The Python types must match the SysML model (D-025).

``cameo_models/*.sysml`` is the source of truth (D-006). These tests read that text and
fail when ``nas_types.py``, ``experiment_scoring.py`` or ``scenario_base.yaml`` uses a
name the model does not define. They read the text with regular expressions, which is
enough for flat definitions; this is not a SysML parser.

Run from the repo root:
    .venv/Scripts/python.exe -m pytest projects/nas-sos-capstone/simulation -q
"""

from __future__ import annotations

import dataclasses
import re
from enum import Enum
from pathlib import Path

import pytest
import yaml

import experiment_scoring as es
import nas_types as nt

HERE = Path(__file__).resolve().parent
MODEL_DIR = HERE.parent / "cameo_models"
SCENARIO = HERE / "scenario_base.yaml"


def definition_body(file_name: str, def_name: str) -> str:
    """Text between the braces of ``<keyword> def <def_name> ... { }`` in one model file."""
    text = (MODEL_DIR / file_name).read_text(encoding="utf-8")
    text = re.sub(r"/\*.*?\*/", "", text, flags=re.S)
    text = re.sub(r"//[^\n]*", "", text)
    m = re.search(rf"\bdef\s+{def_name}\b[^{{;]*{{", text)
    assert m, f"{def_name} is not defined in {file_name}"
    depth, i = 1, m.end()
    while depth:
        depth += {"{": 1, "}": -1}.get(text[i], 0)
        i += 1
    return text[m.end() : i - 1]


def member_names(body: str) -> set[str]:
    """Names declared directly in a definition body (nested bodies removed first)."""
    while re.search(r"{[^{}]*}", body):
        body = re.sub(r"{[^{}]*}", ";", body)
    pattern = r"\b(?:attribute|part|item|enum|in|return|calc|port)\s+(?:def\s+)?(\w+)"
    return set(re.findall(pattern, body))


def python_names(cls: type) -> set[str]:
    if issubclass(cls, Enum):
        return {m.value for m in cls}
    if dataclasses.is_dataclass(cls):
        return {f.name for f in dataclasses.fields(cls)}
    return set(cls.__annotations__)  # TypedDict


@pytest.mark.parametrize("cls", list(nt.SYSML_SOURCE), ids=lambda c: c.__name__)
def test_python_type_matches_its_definition(cls):
    file_name, def_name = nt.SYSML_SOURCE[cls]
    assert cls.__name__ == def_name
    model = member_names(definition_body(file_name, def_name))
    extra = python_names(cls) - model
    assert not extra, f"{cls.__name__} has names the model's {def_name} does not: {sorted(extra)}"
    if issubclass(cls, Enum):
        assert python_names(cls) == model, f"{def_name}: enumeration values differ from the model"


@pytest.mark.parametrize(
    ("method", "calc_def"),
    [("cruise_fuel_flow", "CruiseFuelFlow"), ("available_climb_rate", "AvailableClimbRate"), ("can_hold_level", "CanHoldLevel")],
)
def test_performance_method_takes_the_calc_defs_inputs(method, calc_def):
    body = definition_body("nas_analysis.sysml", calc_def)
    model_inputs = re.findall(r"\bin\s+(\w+)", body)
    code = getattr(es.PerformanceModel, method).__code__
    assert list(code.co_varnames[1 : code.co_argcount]) == model_inputs


def test_performance_model_has_every_calc_of_the_model():
    body = definition_body("nas_analysis.sysml", "PerformanceModel")
    calc_defs = set(re.findall(r"\bcalc\s+\w+\s*:\s*(\w+)", body))
    snake = {re.sub(r"(?<!^)(?=[A-Z])", "_", name).lower() for name in calc_defs}
    assert snake <= set(vars(es.PerformanceModel)), snake - set(vars(es.PerformanceModel))


def test_cases_are_paired_with_means_as_in_the_verification_model():
    text = (MODEL_DIR / "nas_verification.sysml").read_text(encoding="utf-8")
    pairs = set(re.findall(r'experimentCase = "(\w)";\s*:>> means = MeansOfAchievement::(\w+)', text))
    assert pairs == {(case, means.value) for case, means in es.CASE_MEANS.items()}


def test_scenario_file_uses_the_models_names():
    """Every camelCase key of the scenario file is an attribute of the definition it stands for."""
    data = yaml.safe_load(SCENARIO.read_text(encoding="utf-8"))

    def camel(d: dict) -> set[str]:
        return {k for k in d if "_" not in k and k != k.lower()} | {k for k in d if k in ("flight", "cruise", "kind", "maneuvers")}

    def names(file_name: str, def_name: str) -> set[str]:
        return member_names(definition_body(file_name, def_name))

    analysis, structure = "nas_analysis.sysml", "nas_sysml_package_definitions.sysml"
    assert camel(data["type"]) <= names(analysis, "PerformanceModel")
    for f in data["flights"]:
        assert camel(f) <= names(analysis, "ScenarioFlight"), f["flight"]
        assert set(f["flight"]) <= names(structure, "Flight")
        assert set(f["cruise"]) == names(analysis, "CruiseCondition")
    for o in data["options"]:
        assert set(o) == names(analysis, "ResolutionOption"), o
        for m in o["maneuvers"]:
            assert set(m) <= names(analysis, "Maneuver")
            assert m["kind"] in names(analysis, "ManeuverKind")
