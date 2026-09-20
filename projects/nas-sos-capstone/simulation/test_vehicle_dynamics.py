"""Smoke tests for vehicle_dynamics.step_dynamics — run with `pytest` or directly."""

from vehicle_dynamics import step_dynamics


def _base_state():
    return {
        "altitude": 10000.0,
        "speed": 200.0,
        "heading": 90.0,
        "pitch": 0.0,
        "roll": 0.0,
        "yaw": 90.0,
        "position": {"latitude": 41.9786, "longitude": -87.9048, "altitude": 10000.0, "timestamp": None},
        "fuelOnBoard": 5000.0,
        "zeroFuelWeight": 60000.0,
        "grossWeight": 65000.0,
        "isEngineOn": True,
        "isLandingGearDeployed": False,
        "isFlapsExtended": False,
        "isAutopilotEngaged": True,
        "isNavigationLightsOn": True,
        "isStrobeLightsOn": True,
        "isBeaconLightOn": True,
        "isFuelPumpOn": True,
        "isHydraulicSystemActive": True,
    }


def test_holding_commanded_state_holds_track():
    state = _base_state()
    next_state = step_dynamics(state, control_heading=90.0, control_speed=200.0, control_climb_rate=0.0, dt=1.0)
    assert next_state["speed"] == 200.0
    assert next_state["heading"] == 90.0
    assert next_state["altitude"] == 10000.0
    # Heading 90 (due east) should move longitude east, not latitude.
    assert next_state["position"]["longitude"] > state["position"]["longitude"]
    assert abs(next_state["position"]["latitude"] - state["position"]["latitude"]) < 1e-9


def test_climb_command_increases_altitude():
    state = _base_state()
    next_state = step_dynamics(state, control_heading=90.0, control_speed=200.0, control_climb_rate=5.0, dt=10.0)
    assert next_state["altitude"] == 10000.0 + 5.0 * 10.0


def test_speed_change_is_rate_limited():
    state = _base_state()
    next_state = step_dynamics(state, control_heading=90.0, control_speed=400.0, control_climb_rate=0.0, dt=1.0)
    # MAX_ACCELERATION_MPS2 = 2.0, dt = 1.0s -> at most +2 m/s in one step.
    assert next_state["speed"] == 202.0


def test_fuel_burns_while_engine_on():
    state = _base_state()
    next_state = step_dynamics(state, control_heading=90.0, control_speed=200.0, control_climb_rate=0.0, dt=10.0)
    assert next_state["fuelOnBoard"] < state["fuelOnBoard"]
    assert next_state["grossWeight"] == next_state["zeroFuelWeight"] + next_state["fuelOnBoard"]


if __name__ == "__main__":
    test_holding_commanded_state_holds_track()
    test_climb_command_increases_altitude()
    test_speed_change_is_rate_limited()
    test_fuel_burns_while_engine_on()
    print("All smoke tests passed.")
