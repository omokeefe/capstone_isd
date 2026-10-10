# OpenAP: An Open-Source Aircraft Performance Model for Air Transportation Studies and Simulations

- **File:** none in `evidence/sources/`; software installed in `.venv` (openap 2.6.2) and documented at https://openap.dev
- **Bib key:** `sun2020openap`
- **Authors:** Junzi Sun, Jacco M. Hoekstra, Joost Ellerbroek (TU Delft)
- **Year:** 2020
- **Venue:** Aerospace 7(8), 104
- **DOI:** 10.3390/aerospace7080104

## What it is

An open aircraft performance model and Python library (LGPL-3.0): aircraft and engine data for about 36 types, a drag-polar model, a thrust model, a fuel-flow model and emissions, kinematic flight-phase models and trajectory tools. The experiment's scoring model (D-017).

## Why it's valuable, and to what

- Optimization study (§11 to §13): supplies the three functions the experiment needs without a licence: `FuelFlow(ac).enroute(mass, tas, alt, vs)` in kg/s, `Thrust(ac).cruise(tas, alt)` and `.climb(tas, alt, roc)` in N, `Drag(ac).clean(mass, tas, alt)` in N, plus `prop.aircraft(ac)` for limits (for B39M: MTOW 88,000 kg, OEW 45,000 kg, max fuel 26,000 kg, MMO 0.82, VMO 340 kt, 178 to 220 seats, LEAP-1B). Thrust, drag and fuel flow are also exactly the three quantities the project's digital-thread vision has airlines expose (D-019), so one library stands in for what an airline API would provide.
- Decomposition / architecture (§6, §10): none.
- Smoke test 2026-10-10 (`simulation/openap_smoke.py`, Mach 0.80, ISA): at 65,800 kg the type can hold FL400 and its best specific range is at or above FL400; at 74,200 kg it can hold FL380 but not FL400. That asymmetry is what the experiment's cases C and D can see and cases A and B cannot (`knowledge/models/experiment-scenario-numbers.md`).

## Rating

**4/5.** The scoring model the experiment runs on; open, documented, supports the type. Not a 5: it is a fitted model, not flight-test data, and it has no drag polar of its own for the 737 MAX 9.

## Flags

- **No drag polar for B39M.** OpenAP borrows the 737 MAX 8's (`use_synonym=True`; it prints a warning). State this wherever a number from it is reported.
- The journal paper has not been read; the API was checked against the handbook pages at openap.dev on 2026-10-10. Read the paper's validation section before the final report and note its stated accuracy here.
- Fallback if the numbers prove implausible by 2026-11-08: a lookup table from `mori2022massCruise` (D-017 item 5).

## Processing metadata

- **Read depth:** documentation and API only; paper not read
- **Date processed:** 2026-10-10
