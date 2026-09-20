# Workflow: SysML Instance / Scenario Modeling

For adding *instance-level* content to the SysML v2 model: a specific flight, its route
(airports, enroute segment, SIDs/STARs/approaches), or any other concrete occurrence of
the structural types built under `workflows/update-architecture.md`. That workflow
covers the *definitions* (what kinds of systems exist, per D-002's domain decomposition);
this one covers *usages* — specific instances of those definitions, bound with concrete
values, that populate a scenario.

Relevant `to-do-list.md` sections: §10's trace bullets (systems → activities →
information exchanges → decisions → aircraft behavior all need a concrete scenario to
walk), and it's the modeling half of §12-§13 (a simulation run needs a concrete
Aircraft/AircraftState to start from — see `workflows/vehicle-simulation-model.md` for
the physics side of that).

## Ground rules

- **Definitions vs. usages.** A `part def` is a reusable blueprint (already built in
  `cameo_models/nas_sysml_package_definitions.sysml`'s domain packages). A `part <name> : SomeDef { ... }` is a
  concrete usage — this workflow's subject. Don't add new `part def`s here unless a
  genuinely new *kind* of system showed up; that belongs back in
  `workflows/update-architecture.md`.
- **Scenario content lives under `cameo_models/scenarios/`**, one file per scenario, not
  mixed into `nas_sysml_package_definitions.sysml` (which holds the structural/definition model). Name files
  for the scenario, e.g. `hub-to-hub-example.sysml`.
- **A scenario file is illustrative until it's tied to a real ConOps scenario.** If it
  isn't standing in for a specific entry in `knowledge/models/conops-scenarios.md`, say so
  in a header `doc` comment — don't let a syntax-demo flight get mistaken for a decided
  scenario (e.g. the city pair for the Hub-to-Hub CONOPS is still open per
  `knowledge/models/conops-hub-to-hub-trajectory-cost.md` — a demo scenario using ORD/JFK
  does not resolve that).

## Verified SysML v2 syntax rules (this project's tool, confirmed 2026-09-19)

The IDE surfaces this project's SysML v2 language-server diagnostics automatically after
every file write/edit — treat a clean diagnostic pass as the acceptance test for "does
this parse," the same way you'd run a test suite for code. **Write, check the diagnostics
that come back, fix, repeat** — don't try to hand-verify complex textual SysML v2 from
memory alone; this environment can actually check it. Rules learned the hard way so far:

- **Scalar types are `Boolean`, `String`, `Integer`, `Real`** (KerML `ScalarValues`
  library) — there is no `Float` or `Double`. They must be imported explicitly with
  **explicit visibility**: `public import ScalarValues::*;` inside whichever
  package/namespace uses them (a bare `import` without `public`/`private` is a syntax
  error).
- **No generic collection syntax.** `List<Type>` is invalid. Use multiplicity instead:
  `attribute equipment: String[*];`, `part gates: Gate[*];`, `[0..1]` for optional,
  `[2..5]` for a bounded range.
- **`attribute` features must be typed by a value type** (`attribute def`, or a scalar) —
  never by a `part def`. If a feature needs to point at a system/part:
  - `part x: SomeDef;` when this usage *owns* (composes) it.
  - `ref part x: SomeDef;` when it's a reference to a part owned elsewhere — this is the
    right choice for cross-domain pointers, e.g. `Flight.aircraft`,
    `Flight.departureAirport` (the Flight doesn't own the Aircraft or Airport; it
    references them).
- **Reserved words can't be used as plain feature names** — `state` is one (state-machine
  keyword); collided with `Aircraft.state`, renamed to `flightState`. Others in the same
  family to watch for: `case`, `action`, `then`, `while`, `loop`, `event`, `flow`,
  `perform`, `accept`, `send`. If a diagnostic says "Unexpected reserved keyword" where
  you used a plain name, rename the feature.
- **Setting a plain scalar/reference feature never needs `:>>`** (`registrationNumber =
  "N12345";` just works, matched by name against the usage's own type). **Reopening a
  nested body for a composite feature to set its sub-values does need `:>>`, and needs
  the type restated**, or every member inside the body gets flagged as "shadows" the
  inherited feature instead of specifying it: `:>> flightState: AircraftState { altitude
  = 0.0; ... }` — dropping the `: AircraftState` (i.e. just `:>> flightState { ... }`)
  breaks name resolution for everything inside the body, even plain scalar assignments
  that would otherwise be fine.
- **`individual`** is a real modifier for a specific occurrence-with-a-lifetime (serial
  numbers, digital twins), but its concrete syntax wasn't confirmed against public
  documentation as of 2026-09-19. Prefer the pattern below (plain usage + bound values)
  until/unless `individual` usage is specifically tried and confirmed clean against this
  project's linter — don't guess at it in content meant to stay.

## Pattern: a concrete scenario instance

Bind values directly in a usage's body — no `individual` keyword needed for this level of
concreteness:

```sysml
package Scenarios {
    doc /* Illustrative — not tied to a decided ConOps scenario. See
     * knowledge/models/conops-scenarios.md for the real candidates. */

    public import NationalAirspaceSystem::AirportOperations::*;
    public import NationalAirspaceSystem::AirspaceManagement::*;
    public import NationalAirspaceSystem::AircraftSystems::*;
    public import NationalAirspaceSystem::FlightOperations::*;
    public import NationalAirspaceSystem::Common::*;

    part ord: Airport {
        icaoCode = "KORD";
    }

    part jfk: Airport {
        icaoCode = "KJFK";
    }

    part exampleAircraft: Aircraft {
        registrationNumber = "N12345";
    }

    part exampleFlight: Flight {
        flightNumber = "EX100";
        aircraft = exampleAircraft;
        departureAirport = ord;
        arrivalAirport = jfk;
    }
}
```

Because `Flight.aircraft`/`departureAirport`/`arrivalAirport` are declared `ref part` in
the definition (see `nas_sysml_package_definitions.sysml`), a plain `=` inside the usage body binds the
reference to a specific part declared elsewhere in the same scenario — no `:>>`
redefinition needed unless you're narrowing an inherited feature's *type*, not just
supplying its value.

## Pattern: route — procedures and enroute segments

SIDs, STARs, and approaches are FAA/ATC-published procedures, airport-specific, so they
belong as constituent systems of `AirspaceManagement` (which already owns TRACON/ARTCC/
ATCSCC), each referencing the airport they're published for:

```sysml
package AirspaceManagement {
    part def StandardInstrumentDeparture {
        ref part airport: AirportOperations::Airport;
        attribute name: String; // e.g., "BENKY4"
    }

    part def StandardTerminalArrival {
        ref part airport: AirportOperations::Airport;
        attribute name: String;
    }

    part def InstrumentApproachProcedure {
        ref part airport: AirportOperations::Airport;
        attribute name: String; // e.g., "ILS RWY 22L"
    }

    part def EnrouteSegment {
        attribute waypoints: Common::Position[*];
    }
}
```

A scenario's flight then references a concrete instance of each, in sequence, alongside
its existing `route: Common::Position[*]` waypoint list — the procedures are the
*named/published* structure; `route` stays the raw waypoint sequence a simulation would
actually fly.

## Steps

1. Bootstrap per `workflows/session-welcome.md` if starting fresh.
2. Confirm the structural type you need already exists under `nas_sysml_package_definitions.sysml`'s domain
   packages. If not, that's a `workflows/update-architecture.md` change first — don't
   invent a new definition inline in a scenario file.
3. Write the scenario file under `cameo_models/scenarios/`, importing the packages you
   need (`import <Package>::*;` or a qualified path — check diagnostics either way).
4. Save and read back whatever diagnostics the IDE hook surfaces. Fix and repeat until
   clean.
5. If the scenario is standing in for a real ConOps entry, cross-link it from
   `knowledge/models/conops-scenarios.md`. If it's a pattern demo, say so in the file's
   header `doc` comment instead.
6. Note gaps (e.g., a procedure name that's a placeholder, not a real published
   procedure) in `knowledge/questions/open-questions.md` rather than letting them look
   decided.
7. Sign off per `workflows/session-signoff.md`.
