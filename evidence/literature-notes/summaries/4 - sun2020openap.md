# OpenAP: An Open-Source Aircraft Performance Model for Air Transportation Studies and Simulations

- **File:** `evidence/sources/sun2020openap_aerospace-07-00104.pdf` (24 pp.; open access, CC BY 4.0; downloaded from the publisher by Claude on 2026-10-11)
- **Bib key:** `sun2020openap`
- **Authors:** Junzi Sun, Jacco M. Hoekstra, Joost Ellerbroek (TU Delft)
- **Year:** 2020
- **Venue:** Aerospace 7(8), 104
- **DOI:** 10.3390/aerospace7080104

## What it is

The journal paper that describes OpenAP, the open aircraft performance model and Python library the experiment's scoring runs on (D-017). It sets out four components (aircraft and engine properties, kinematic performance, dynamic performance, utilities), gives the equations for thrust, drag and fuel flow, and compares the model with BADA 3 and with one recorded flight.

## Why it's valuable, and to what

- **Experiment (Track B; `to-do-list.md` §11 to §13):** the citable source for the equations the report's Section 3.4 no longer repeats.
  - Point-mass motion: Eq. 8 to 13 (p. 6). Speed along the path is Eq. 12, `dV/dt = (T − D)/m − g sin γ`.
  - Maximum thrust from 30,000 to 40,000 ft: Eq. 22 and 23 (pp. 7 to 8), taken from Bartel and Young (the paper's reference 22). The coefficients are the ones the installed package uses (−0.4204, 1.0824, exponent −0.11).
  - Reference cruise thrust when the engine data has none: Eq. 29 (p. 9), `Tcr = 0.2 T0 + 890` N, from Svoboda (the paper's reference 20), not from Bartel and Young.
  - Drag: Eq. 15, 16, 30 and 31 (pp. 7 and 9), a two-term polar, `CD = CD0 + k CL²`.
  - Compressibility: Eq. 34 (p. 10), a wave-drag term `20 (M − Mcrit)⁴` above a critical Mach number, added to the zero-lift drag in Eq. 36. See the first flag.
  - Fuel flow: Eq. 38 to 40 (pp. 11 to 12), a third-degree polynomial of thrust ratio fitted to the four ICAO databank points, plus a linear altitude correction. See the second flag.
- **What the paper says about its own accuracy** (pp. 14 to 17), which the report needs for the truth model's uncertainty:
  - Against BADA 3.12, the clean drag polar differs by a mean of about 0.007 in both `CD0` and `k` (Figure 11, p. 15). The authors warn that this "should not be directly used to quantify the accuracy of our model". For scale, the `CD0` the experiment uses is 0.020.
  - Thrust and fuel flow were checked against one flight of the TU Delft Cessna Citation II, cruising at about 10,000 ft on a test profile. "Overall, OpenAP displays slightly better accuracy than BADA" (p. 17). No airliner and no cruise above 30,000 ft was checked.
  - Limitations as stated (p. 17): thrust and fuel models come from external sources whose uncertainty carries over; the drag polars come from a Bayesian estimate with its own uncertainty; "limited access to accurate flight data from a wider range of aircraft types also limits the validation".
- **Digital-thread argument (D-019):** thrust, drag and fuel flow are the three quantities the project has airlines expose; the paper's own motivation (p. 2) is that the usual model, BADA, cannot be redistributed. Usable in the report as the reason an open model stands in for an airline's.
- Decomposition / architecture (§6, §10): none.
- Glossary / terminology: none new.

## Rating

**4/5.** The scoring model the experiment runs on, now with a held and read paper behind its equations. Not a 5: the paper describes a 2020 model that differs from the installed 2.6.2 in two places that matter here, and its validation does not reach an airliner in cruise.

## Flags

- **The paper treats compressibility drag as part of the model; the installed package does not apply it by default.** Section 5.5 (p. 10): "When an aircraft flies at a higher speed than critical Mach number, the compressibility effect should not be ignored." In openap 2.6.2 the term is behind `wave_drag=False` and its docstring calls it experimental (`.venv/Lib/site-packages/openap/drag.py`). The experiment runs with it off (D-024). The report's simplification on this now says so. This strengthens the open decision on whether to switch the term on and set the scenario weights again.
- **The fuel-flow curve in the installed package is not the paper's.** The paper's is a cubic in thrust ratio with an altitude correction (Eq. 40). Version 2.6.2 uses a different curve shape with three default coefficients (0.9376, 1.9768, 1.3955), scaled by the engine's take-off fuel flow. The paper can be cited for where the data comes from (the ICAO databank) and not for the curve the experiment uses. The curve itself is documented only in the package source.
- **The 737 MAX 9 is not in the paper.** Table A1 (p. 19) lists 27 types; the newest 737 is the 737-900 (`B739`). The MAX types and the LEAP-1B were added to the package later. The package borrows the 737 MAX 8's drag polar for `B39M` (`use_synonym=True`).
- **Licence.** The paper says GNU GPL v3 (p. 18). The installed package's metadata says GNU LGPL v3. The package is what is used; the earlier version of this note said LGPL-3.0, which matches the package.
- Bartel and Young (`bartel2008thrustFuel`) is still not held. The thrust equations can be cited from this paper, which reproduces them.
- Fallback if the numbers prove implausible by 2026-11-08: a lookup table from `mori2022massCruise` (D-017 item 5).
- Smoke test of 2026-10-10 (`simulation/openap_smoke.py`), kept from the earlier version of this note: the light aircraft can hold FL400 and the heavy one cannot. Current weights and figures are in `knowledge/models/experiment-scenario-numbers.md`.

## Processing metadata

- **Read depth:** body read in full by Claude on 2026-10-11 (pp. 1 to 18, the type table on p. 19 and the reference list); the code listings in Appendix C (pp. 21 to 23) skimmed. Not read by the owner. Before 2026-10-11 this note was written from the documentation at openap.dev and the package source only.
- **Date processed:** 2026-10-11 (first written 2026-10-10)
