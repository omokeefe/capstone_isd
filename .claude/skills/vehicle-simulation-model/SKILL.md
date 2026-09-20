---
name: vehicle-simulation-model
description: Build or extend the vehicle-dynamics simulation capability and connect it back to the SysML architecture — to-do-list.md §12 ("Implement Simulation/Analysis Capability") and §13 ("Connect Simulation Back to MBSE"). Use when the user wants to simulate aircraft motion or state change, or wants a Python physics model wired to the model.
---

Follow `workflows/vehicle-simulation-model.md` exactly. Interface only in SysML (a
`calc def` in the `DecisionSupport` package of `cameo_models/nas_sysml_package_definitions.sysml`), the real
physics in a plain Python module under `projects/nas-sos-capstone/simulation/`, and an
explicit doc-comment trace between them — SysML v2 has no first-class binding to real
CPython, so don't embed physics as literal text in a `.sysml` file. Start with the
simplest model that satisfies the current need (a point-mass kinematic integrator, not
6-DOF) per the "not an optimization/simulation paper" guardrail in `README.md`/
`CLAUDE.md`. Update `to-do-list.md` §12/§13 boxes for what's actually done, and sign off
per `workflows/session-signoff.md`.
