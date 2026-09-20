# Workflow: Vehicle Simulation Model

For building and connecting a real-physics vehicle dynamics model to the SysML
architecture — `to-do-list.md` §12 ("Implement Simulation / Analysis Capability") and
§13 ("Connect Simulation Back to MBSE"). Read `workflows/sysml-instance-modeling.md`
first if the scenario that will drive the simulation doesn't exist yet.

## Ground rule: interface in SysML, physics in Python, trace between them explicitly

SysML v2 does have a mechanism for an "opaque" external-language calculation body
(`language "..." /* code */` inside a `calc def`), but the only broadly-implemented path
for that today runs the body through **Jython** (a JVM Python-2-era interpreter) inside
specific commercial tools (e.g. NoMagic/Cameo) — it does not run CPython, and doesn't get
you numpy/scipy. That's not a fit for "the real physics," and isn't confirmed to work
against whatever tool actually parses this project's `.sysml` files. So: **don't embed
the physics as literal Python text inside a `.sysml` file.**

Instead:

- **SysML side** declares the *interface only* — a `calc def` with `in`/`return`
  parameters — as the modeled contract between the architecture and the simulation.
- **Python side** implements the real numeric behavior in an ordinary `.py` module,
  living in `projects/nas-sos-capstone/simulation/` (a sibling of `cameo_models/`, not
  inside it — this is code, not model content, per `to-do-list.md`'s own §10 vs. §12
  split).
- **The trace between them is a doc comment / mapping note, not a language feature** —
  SysML v2 doesn't have a first-class "this Python function implements this calc def"
  binding, so state the mapping explicitly (function name, module path, and which
  fields correspond) wherever the `calc def` is declared, and mirror the field names on
  the Python side so the correspondence is visible without translation.

This mirrors how the project already treats decision-support/optimization generally
(README.md / `index.md` working assumptions: a capability layered on the architecture,
not the whole subject) — the vehicle dynamics model is that same kind of capability, not
a physical constituent system, which is why its `calc def` lives in the `DecisionSupport`
package rather than under `AircraftSystems`.

## Steps

1. Confirm the `AircraftSystems::AircraftState` fields (position, speed, heading, pitch/
   roll/yaw, fuel, weights, boolean configuration flags — see `nas_sysml_package_definitions.sysml`) are
   actually what the physics model needs to read/write. Extend `AircraftState` first if
   not — that's a `workflows/update-architecture.md` change, not this workflow.
2. Declare the interface in SysML: a `calc def` (input state + controls + `dt`, return
   next state) inside `package DecisionSupport` in `nas_sysml_package_definitions.sysml`, with a `doc` comment
   naming the Python module/function that implements it. Save, check diagnostics, fix.
3. Implement the model in `projects/nas-sos-capstone/simulation/`: a plain function whose
   parameter/return field names match the SysML `calc def`'s signature and
   `AircraftState`'s attribute names field-for-field. Start with the simplest model that
   satisfies the current need (`to-do-list.md` §12: "Develop minimum viable simulation")
   — a point-mass kinematic integrator (position/altitude update from speed/heading/climb
   rate over `dt`) is enough to "simulate the vehicle motion or simply a change in
   state"; don't build 6-DOF/aerodynamic fidelity unless a specific study needs it. Scope
   creep here pulls directly against the "not an optimization/simulation paper" guardrail
   in `README.md`/`CLAUDE.md`.
4. Validate the constituent model independently before wiring it into anything bigger
   (§12: "Validate constituent models independently") — a short script or `pytest` case
   showing a known input produces the expected state change (e.g., constant heading/speed
   holds a straight track) is enough; this doesn't need a test framework if one isn't
   already in the repo.
5. Connect it to a scenario: take a `cameo_models/scenarios/*.sysml` flight's initial
   `AircraftState` values as the model's starting input (by hand for now — reading the
   SysML file programmatically is a later automation step, not a requirement to build
   this first time through).
6. Record the trace: which scenario, which `calc def`, which Python function, in the
   scenario file's `doc` comment or a short note in `knowledge/models/` if it's reused
   across scenarios. This *is* §13 ("Connect Simulation Back to MBSE") for whatever slice
   you just built — don't leave it implicit.
7. Update `to-do-list.md` §12/§13 checkboxes for what's actually done (a minimum-viable
   point-mass model isn't the whole section — check off only the specific bullets met).
8. Sign off per `workflows/session-signoff.md`.

## Notes

- If a future need genuinely requires more fidelity (wind, weight-and-balance-driven
  performance, engine-out cases), extend the same Python module rather than starting a
  parallel one — keep one vehicle-dynamics implementation per vehicle class.
- If the model is ever brought into a tool (Cameo or otherwise) whose simulation tooling
  offers a real binding to this Python model, that supersedes the doc-comment trace above — note
  the change in `decisions/decisions-log.md` rather than silently dropping the manual
  trace.
