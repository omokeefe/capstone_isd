"""Python mirrors of the SysML definitions the simulation code reads or writes (D-025).

The ``.sysml`` text in ``cameo_models/`` is the source of truth (D-006). Each class below
mirrors one definition there: same name, same attribute names, same enumeration values.
``SYSML_SOURCE`` says which file and which definition, and ``test_model_conformance.py``
reads those files and fails when a field or value here is not in the model. A class may
hold fewer attributes than its definition (only what the code uses), never more. To add a
field, add it to the model first (``workflows/update-architecture.md``).

Units are the model's. ``AircraftState`` and ``Position`` are SI (metres, metres per second,
kilograms) and are what ``vehicle_dynamics.py`` steps. ``CruiseCondition`` is feet, Mach and
kilograms and is what the experiment (``experiment_scoring.py``) works in. Nothing converts
one into the other.

A ``ref part`` in the model (an airport, a flight) is held here by its identifier: an
airport by its ``icaoCode``.
"""

from __future__ import annotations

from dataclasses import dataclass
from enum import StrEnum
from typing import Any, TypedDict


# --------------------------------------------------------------------------- enumerations
class FidelityLevel(StrEnum):
    """NasAnalysis::FidelityLevel: how the truth model scores an option."""

    conceptual = "conceptual"
    nominalMass = "nominalMass"
    actualMass = "actualMass"


class MeansOfAchievement(StrEnum):
    """RequirementDefinitions::MeansOfAchievement: the experiment's cases A to D (D-022)."""

    ruleOfThumb = "ruleOfThumb"
    lowFidelityModel = "lowFidelityModel"
    highFidelityModel = "highFidelityModel"
    highFidelityModelWithConnections = "highFidelityModelWithConnections"


class ManeuverKind(StrEnum):
    """NasAnalysis::ManeuverKind: the kinds of instruction an option is built from."""

    altitude = "altitude"
    vector = "vector"
    speed = "speed"
    slow = "slow"


# --------------------------------------------------------------------------- aircraft state (SI)
class Position(TypedDict):
    """Common::Position."""

    latitude: float
    longitude: float
    altitude: float
    timestamp: Any


class AircraftState(TypedDict):
    """AircraftSystems::AircraftState, as the dict ``vehicle_dynamics.step_dynamics`` takes and returns."""

    altitude: float
    speed: float
    heading: float
    pitch: float
    roll: float
    yaw: float
    position: Position
    fuelOnBoard: float
    zeroFuelWeight: float
    grossWeight: float
    isEngineOn: bool
    isLandingGearDeployed: bool
    isFlapsExtended: bool
    isAutopilotEngaged: bool
    isNavigationLightsOn: bool
    isStrobeLightsOn: bool
    isBeaconLightOn: bool
    isFuelPumpOn: bool
    isHydraulicSystemActive: bool


# --------------------------------------------------------------------------- the experiment
@dataclass
class CruiseCondition:
    """NasAnalysis::CruiseCondition: the inputs of every performance function."""

    massKg: float
    machNumber: float
    altitudeFt: float


@dataclass
class Flight:
    """FlightOperations::Flight (the attributes the experiment uses)."""

    flightNumber: str
    airline: str
    departureAirport: str  # icaoCode of the Airport the model references
    arrivalAirport: str


@dataclass
class AirlinePerformanceShare:
    """FlightOperations::AirlinePerformanceShare: what the airline shares with the deciding party (D-019)."""

    grossWeightKg: float
    costIndex: float
    delayMarginMin: float | None = None  # None: no connection constraint


@dataclass
class Maneuver:
    """NasAnalysis::Maneuver: one instruction to one flight."""

    flightNumber: str
    kind: ManeuverKind
    deltaFt: float | None = None  # altitude only: positive is a climb


@dataclass
class ResolutionOption:
    """NasAnalysis::ResolutionOption: one or more maneuvers issued together."""

    optionId: str
    instructionsNow: int
    maneuvers: list[Maneuver]

    def maneuver_for(self, flight_number: str) -> Maneuver | None:
        return next((m for m in self.maneuvers if m.flightNumber == flight_number), None)


@dataclass
class ScenarioFlight:
    """NasAnalysis::ScenarioFlight: one flight's facts, and what its airline would share.

    The truth model reads the facts. A decider that is given the share (cases C and D)
    reads ``performanceShare`` and nothing else about the airline.
    """

    flight: Flight
    cruise: CruiseCondition
    distanceToGoNm: float
    costIndex: float
    scheduleDeltaMin: float
    hasConnections: bool
    performanceShare: AirlinePerformanceShare | None = None

    @property
    def flightNumber(self) -> str:
        return self.flight.flightNumber

    @property
    def airline(self) -> str:
        return self.flight.airline


# Which definition each class mirrors: file under cameo_models/, definition name.
SYSML_SOURCE: dict[type, tuple[str, str]] = {
    FidelityLevel: ("nas_analysis.sysml", "FidelityLevel"),
    MeansOfAchievement: ("requirements_definitions.sysml", "MeansOfAchievement"),
    ManeuverKind: ("nas_analysis.sysml", "ManeuverKind"),
    Position: ("nas_sysml_package_definitions.sysml", "Position"),
    AircraftState: ("nas_sysml_package_definitions.sysml", "AircraftState"),
    CruiseCondition: ("nas_analysis.sysml", "CruiseCondition"),
    Flight: ("nas_sysml_package_definitions.sysml", "Flight"),
    AirlinePerformanceShare: ("nas_sysml_package_definitions.sysml", "AirlinePerformanceShare"),
    Maneuver: ("nas_analysis.sysml", "Maneuver"),
    ResolutionOption: ("nas_analysis.sysml", "ResolutionOption"),
    ScenarioFlight: ("nas_analysis.sysml", "ScenarioFlight"),
}
