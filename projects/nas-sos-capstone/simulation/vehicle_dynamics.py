"""Minimum-viable point-mass vehicle dynamics model.

Implements the interface declared as `DecisionSupport::VehicleDynamicsModel::StepDynamics`
in `cameo_models/nas_sysml_package_definitions.sysml` (see `workflows/vehicle-simulation-model.md` for why the
physics lives here rather than as an embedded SysML calc body). Field names mirror
`AircraftSystems::AircraftState`'s attributes so the two stay traceable by inspection:
`state`/`next_state` dicts here use exactly those attribute names.

This is a kinematic point-mass model, not an aerodynamic one: speed and heading move
toward their commanded values at bounded rates, altitude integrates commanded climb rate
directly, and horizontal position updates from an equirectangular (flat-earth) projection.
Fuel burn is a constant placeholder rate while the engine is on. Extend this module rather
than adding a parallel one if higher fidelity (wind, weight-dependent performance,
aerodynamic drag) is needed later.
"""

from __future__ import annotations

import math
from typing import Any

EARTH_RADIUS_M = 6_371_000.0

MAX_ACCELERATION_MPS2 = 2.0  # bound on how fast speed can approach the commanded value
MAX_TURN_RATE_DEG_S = 3.0  # bound on how fast heading can approach the commanded value
FUEL_FLOW_KG_S = 0.5  # placeholder constant burn rate while the engine is on


def _clamp(value: float, low: float, high: float) -> float:
    return max(low, min(high, value))


def _wrap_deg(angle_deg: float) -> float:
    return angle_deg % 360.0


def _shortest_angle_delta_deg(from_deg: float, to_deg: float) -> float:
    delta = (to_deg - from_deg + 180.0) % 360.0 - 180.0
    return delta


def step_dynamics(
    state: dict[str, Any],
    control_heading: float,
    control_speed: float,
    control_climb_rate: float,
    dt: float,
) -> dict[str, Any]:
    """Advance one AircraftState by dt seconds under the given commanded controls.

    `state` and the return value are dicts keyed exactly like
    `AircraftSystems::AircraftState`'s attributes (altitude, speed, heading, pitch, roll,
    yaw, position, fuelOnBoard, zeroFuelWeight, grossWeight, and the boolean configuration
    flags). `position` is itself a dict with latitude/longitude/altitude/timestamp, per
    `Common::Position`.
    """
    speed = state["speed"] + _clamp(
        control_speed - state["speed"], -MAX_ACCELERATION_MPS2 * dt, MAX_ACCELERATION_MPS2 * dt
    )
    heading = _wrap_deg(
        state["heading"]
        + _clamp(
            _shortest_angle_delta_deg(state["heading"], control_heading),
            -MAX_TURN_RATE_DEG_S * dt,
            MAX_TURN_RATE_DEG_S * dt,
        )
    )
    altitude = state["altitude"] + control_climb_rate * dt

    heading_rad = math.radians(heading)
    dx_east_m = speed * dt * math.sin(heading_rad)
    dy_north_m = speed * dt * math.cos(heading_rad)

    lat = state["position"]["latitude"]
    lat_rad = math.radians(lat)
    dlat_deg = math.degrees(dy_north_m / EARTH_RADIUS_M)
    dlon_deg = math.degrees(dx_east_m / (EARTH_RADIUS_M * math.cos(lat_rad)))

    fuel_on_board = state["fuelOnBoard"]
    if state["isEngineOn"]:
        fuel_on_board = max(0.0, fuel_on_board - FUEL_FLOW_KG_S * dt)

    next_state = dict(state)
    next_state.update(
        {
            "altitude": altitude,
            "speed": speed,
            "heading": heading,
            "yaw": heading,
            "position": {
                **state["position"],
                "latitude": lat + dlat_deg,
                "longitude": state["position"]["longitude"] + dlon_deg,
                "altitude": altitude,
            },
            "fuelOnBoard": fuel_on_board,
            "grossWeight": state["zeroFuelWeight"] + fuel_on_board,
        }
    )
    return next_state
