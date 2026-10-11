"""OpenAP smoke test for the experiment's aircraft type (D-017).

Prints the B737-9 (ICAO B39M) properties OpenAP holds and its cruise fuel flow,
drag and maximum cruise thrust at a few masses and flight levels at Mach 0.80, ISA.
This is the turn-1 exit test in the 2026-10-10 plan: OpenAP installs, imports and
returns numbers for the type.

Run from the repo root with the project venv:
    .venv/Scripts/python.exe projects/nas-sos-capstone/simulation/openap_smoke.py

Known limitation: OpenAP has no drag polar for B39M and borrows the 737 MAX 8's
(``use_synonym=True``; the warning it prints says so). Every number from it is
graded as that: a published open model for a sibling type, not flight-test data.
"""

from __future__ import annotations

import math
import warnings
from importlib.metadata import version

from openap import Drag, FuelFlow, Thrust, prop

AC = "B39M"
MACH = 0.80
MASSES_KG = (66_000, 70_000, 74_000, 78_000)
LEVELS = (320, 340, 360, 380, 400)


def tas_kt(mach: float, alt_ft: float) -> float:
    """True airspeed in knots at a Mach number in the ISA (tropopause at 36,089 ft)."""
    temp_k = 288.15 - 0.0019812 * alt_ft if alt_ft < 36_089 else 216.65
    return mach * math.sqrt(1.4 * 287.05 * temp_k) / 0.514444


def main() -> None:
    print(f"openap {version('openap')}")
    ac = prop.aircraft(AC)
    for key in ("mtow", "oew", "mfc", "mlw", "mmo", "vmo", "ceiling", "cruise", "wing", "engine", "pax"):
        print(f"  {key}: {ac.get(key)}")

    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always")
        ff = FuelFlow(AC, use_synonym=True)
        th = Thrust(AC, use_synonym=True)
        dr = Drag(AC, use_synonym=True)
    for w in caught:
        print(f"  note: {w.message}")

    print(f"\nMach {MACH}, ISA. Columns: fuel flow kg/h, drag kN, max cruise thrust kN.")
    header = "mass kg | " + " | ".join(f"FL{fl:3d}" for fl in LEVELS)
    print(header)
    for mass in MASSES_KG:
        cells = []
        for fl in LEVELS:
            alt = fl * 100
            tas = tas_kt(MACH, alt)
            fuel = ff.enroute(mass, tas, alt) * 3600
            drag = dr.clean(mass, tas, alt) / 1000
            thrust = th.cruise(tas, alt) / 1000
            flag = "" if thrust >= drag else "*"
            cells.append(f"{fuel:5.0f} {drag:4.1f}/{thrust:4.1f}{flag}")
        print(f"{mass:7d} | " + " | ".join(cells))
    print("* thrust below drag: the level cannot be held at this mass and Mach.")


if __name__ == "__main__":
    main()
