# SysML v2 — Working Reference

A pocket reference for modeling the NAS in SysML v2: what to do, in what order, and where
the detail lives. It is a **map, not a manual** — each section is a few lines plus a
pointer. Ties to the SE process (the "M") in
[systems_engineering.md](../../../knowledge/models/systems_engineering.md) and to the
plan in [to-do-list.md](../to-do-list.md) §10, §12–§13, §15.

**Status tags used below:** *verified* = confirmed against this project's language server
on 2026-09-19 (recorded in
[sysml-instance-modeling.md](../../../workflows/sysml-instance-modeling.md)); *unchecked* =
written from general SysML v2 knowledge, not yet run through the linter — confirm with
the IDE diagnostics before relying on it. (When this file was written, diagnostics were
not surfacing in the session, so the *unchecked* patterns could not be linted then.)

## 1. Orientation

- **Language / tool / method** are three separate things. Language: SysML v2 (textual
  `.sysml` plus graphical views). Tool: Syside Modeler in VS Code — the authoring tool
  of record (D-006); Cameo is optional and downstream. Method: MagicGrid, per D-003 in
  [index.md](../index.md) (a decision-centric method informed by MagicGrid and selected
  UAF/DoDAF concepts). SE is the goal; the model is how.
- **The `.sysml` text here is the source of truth** (D-006 in
  [decisions-log.md](../../../decisions/decisions-log.md)). Cameo is not; the university's
  Cameo (2024x Refresh 1) can't open SysML v2. Any Cameo copy is derived — options in
  [update-architecture.md](../../../workflows/update-architecture.md).
- **The model is the single source of truth.** Diagrams are generated views. Change the
  model, never a picture of it.

## 2. Tutorial / Overview and tooling

[YouTube Ansys Learning Tutorial](https://www.youtube.com/watch?v=EHnouINc5rI&list=PLtt6-ZgUFmMIRvQMdSSbfVqkRcafbhZ9O&index=3)
This lesson covers the objectives, key elements, and capabilities of SysML v2, a modeling language used in systems engineering. It discusses the goals of SysML v2, such as increasing the adoption and effectiveness of Model-Based Systems Engineering (MBSE), enhancing the precision and expressiveness of models, and ensuring consistency and interoperability with other engineering models and tools. The lesson also highlights the new features of SysML v2, including a new metamodel, robust visualizations, and a standardized Application Programming Interface (API). For instance, the new metamodel is not constrained by UML but preserves many of its useful modeling capabilities.

[Syside Installation](https://docs.sensmetry.com/modeler/install/#modeler-install)
[Sensmetry Sysml V2 Documentation](https://docs.sensmetry.com/modeler/essentials/#modeler-diagram-visualization)
[Training Blogs, Videos, & Tutorials](https://sensmetry.com/advent-of-sysml-v2/)

Not fetched this session — check before relying: the OMG SysML v2 specification page and
the `Systems-Modeling/SysML-v2-Release` GitHub repository (its `doc/` folder carries the
official textual/graphical-notation introductions and a quick-reference card). The
MagicGrid Book of Knowledge and the ISD 521 sample climate-control model are course
materials outside this repo.

## 3. Language essentials

- **Definition vs. usage.** `part def X` is a reusable type; `part x : X { … }` is a
  concrete use. Definitions live in
  [nas_sysml_package_definitions.sysml](nas_sysml_package_definitions.sysml); instances
  live under [scenarios/](scenarios/) (D-005). *verified*
- **Packages and imports.** One package per D-002 domain; imports need explicit
  visibility: `public import ScalarValues::*;`. *verified*
- **Choosing the feature kind.** `attribute` is typed by a value type only (`attribute
  def` or a scalar: `Boolean`, `String`, `Integer`, `Real`). Use `part` when the owner
  composes it, `ref part` when it only points at something owned elsewhere. Collections
  are multiplicity (`[*]`, `[0..1]`), never `List<T>`. *verified*
- **Setting values.** A plain `=` sets a scalar or reference. Reopening a composite
  feature's body needs `:>>` **and** the type restated (`:>> flightState: AircraftState
  { … }`). *verified*
- **Reserved words** (`state`, `case`, `action`, `flow`, `event`, …) cannot be plain
  feature names. *verified*
- **Requirements and their links.** *unchecked* — the constructs to reach for:

  ```sysml
  requirement def <'SLR-001'> StatusLatency {
      doc /* Rationale: … Parent need: SN-014. Verification: analysis. */
      attribute thresholdValue: Real;   // not `objective` — a reserved keyword
      attribute objectiveValue: Real;
  }
  requirement slr001 : StatusLatency;
  satisfy slr001 by nas.informationServices;          // design element that meets it
  verification def V001 { objective { verify slr001; } } // how it gets proven
  ```

  Other constructs to learn as needed: `use case def` (value to a stakeholder), `action
  def` (behavior), `state def` (lifecycle), `port`/`interface`/`connection` (interfaces
  and item flows), `allocate … to …`, `constraint def`/`calc def` (parametrics), `view`
  (generated diagrams). All *unchecked* here.
- **`individual`** (a specific serial-numbered thing / digital twin) is *not* confirmed;
  use a plain usage with bound values until it is tried against the linter.

## 3a. Where to start

Follow MagicGrid's order — problem before solution, outside before inside:

1. NAS **context**: the system as an opaque box, its environment, actors, and the item
   flows crossing the boundary.
2. **Stakeholders** and their needs, in their own words.
3. **Use cases and activities** from the ConOps scenarios.
4. **System-level requirements**, each traced to a need.
5. **Structure** (domains, constituent systems) allocated against those requirements.
6. **Parametrics**, then **implementation** hand-off (simulation).

**Where the model stands:** the structure (step 5) and a scenario/simulation stub (step 6)
exist; steps 1–4 are not yet in SysML. That order is backwards relative to the M, so the
open trace gap already logged in `open-questions.md` is the priority, not polish.

## 4. The SE process in SysML v2

One row per stage of the M (full stage descriptions, gates, and actions:
[systems_engineering.md](../../../knowledge/models/systems_engineering.md)). "Have" =
what exists in the repo today.

| M stage | SysML v2 constructs | Have | Next |
|---|---|---|---|
| 0 System + environment | top-level `part def`, environment parts, `port`/item flows, boundary `doc` | NAS + 9 domains | context diagram (§10) |
| 1 Stakeholders, context | stakeholder/actor parts, `use case def`, scenarios, MOE attributes | registers and ConOps in markdown | model stakeholders and use cases |
| 2 Stakeholder needs | `requirement def` with source-stakeholder attribute, IDs | prose stubs | convert to model elements |
| 3 Concept selection | one package (or project) per alternative decomposition | D-002 only | compare per §6 |
| 4 SLR | `requirement def`, `satisfy`, threshold/objective, verification method | 6 prose statements | rationale, parent, method per SLR |
| 5 HLR (domains) | `allocate`/`satisfy` to domain parts, `action def`, ports/interfaces | domains, no interfaces | interface matrix → item flows (§10) |
| 6 LLR (constituents) | same, at constituent-system depth | constituents as blocks | limit depth to the intent chain |
| 7 Implementation | instance scenarios; `calc def` interface ↔ Python | hub-to-hub scenario; `StepDynamics` ↔ `simulation/` | finish §13 traces |
| 8 Verify | `verification def`, `verify`; coverage checks | none | verification matrix (§15) |
| 9 Validate | scenario walkthrough with stakeholders/adviser | — | §14 demonstration |
| 10 Operate → Retire | `state def` lifecycles; versioned baseline | — | decide scope (see M stage 10) |

## 5. Best practices

- **Model the problem before the solution.** Keep the problem domain implementation-
  neutral; many solutions can satisfy one problem.
- **Trace everything.** Each new element points at a stakeholder need, a source, or the
  trajectory-intent chain. An untraceable element is a smell — log it in `open-questions.md`
  rather than adding it. Target chain: stakeholder → need → SLR → HLR → LLR → system →
  activity → information exchange → verification evidence.
- **Requirements are complete or they are not requirements:** ID, "shall", rationale,
  parent, verification method chosen up front, threshold/objective where quantifiable.
  Interface requirements separate from design requirements.
- **Make interfaces explicit** — ports and item flows, seeded by an interface matrix,
  not implied by containment. Interfaces are where systems-of-systems fail.
- **Definitions in one place, instances in another** (D-005); do not invent a new `def`
  inside a scenario file.
- **Write → check diagnostics → fix → repeat.** Do not hand-verify complex syntax from
  memory. If diagnostics are not surfacing, say so instead of assuming clean.
- **Header `doc` on every package:** scope, source of its content, and what is
  deliberately excluded (the existing files do this).
- **Naming:** `PascalCase` definitions, `camelCase` usages, no reserved words. Put units
  and meaning on value properties (comments today; a units library is worth trying),
  because models exchanging data need both.
- **Keep the model bounded.** Filter to the provisional SOI boundary; record omissions as
  known limitations (§15) rather than padding.
- **Physics stays outside SysML** — interface in a `calc def`, implementation in Python,
  trace by doc comment ([vehicle-simulation-model.md](../../../workflows/vehicle-simulation-model.md)).
- **Route changes through the model** and re-check downstream trace; changing a parent
  requirement orphans its children.
- **Log real decisions** in [decisions-log.md](../../../decisions/decisions-log.md);
  record gaps in `open-questions.md`; check off `to-do-list.md`.

## 6. File map

| File | What it is | Note |
|---|---|---|
| [nas_sysml_package_definitions.sysml](nas_sysml_package_definitions.sysml) | NAS + 9 domain packages, constituent systems, `StepDynamics` interface | draft; source of truth (not in Cameo) |
| [scenarios/hub-to-hub-example.sysml](scenarios/hub-to-hub-example.sysml) | instance-level pattern demo | placeholder city pair, not a decided ConOps |
| [requirements_definitions.sysml](requirements_definitions.sysml) | shared requirement schema: `NasRequirement`, `StakeholderNeed`, `SystemLevelRequirement`, status/kind/verification enums | unlinted |
| [requirements_stakeholders.sysml](requirements_stakeholders.sysml) | stakeholder needs | 10 needs in 8 stakeholder sub-packages; unlinted |
| [requirements_nas_system.sysml](requirements_nas_system.sysml) | SLRs | 6 SLRs; unlinted, not yet traced to needs |
| `../simulation/` | Python vehicle dynamics + tests | code, not model content |

## 7. Known issues (flagged, not fixed)

1. **~~The two `requirements_*.sysml` files were Markdown prose.~~ Converted 2026-09-19**
   to SysML v2 `requirement` usages (`SN-001..010`, `SLR-001..006`) grouped in packages,
   with the original description/scope kept in package `doc`, and typed by the schema in
   `requirements_definitions.sysml` (status, stakeholder group / kind now set). Not yet
   linted (no diagnostics surfaced). Still unset, because they are judgment calls:
   `rationale`, `evidenceRefs`, `parentNeeds`, `verificationMethod`, and `satisfy` links —
   those are what put them in the trace.
2. **Stale filename — fixed 2026-09-19.** The structure file was `tutorial.sysml`; it is
   now `nas_sysml_package_definitions.sysml`, and live docs, workflows, skills, and
   `simulation/vehicle_dynamics.py` cite the new name. The old name remains only in
   `decisions-log.md` D-005 and the journal, deliberately left as historical record.
3. **D-003 and D-004 are cited in `index.md` but missing from `decisions-log.md`.**
4. **No Cameo hand-off is planned.** The university's Cameo (2024x Refresh 1) doesn't
   support SysML v2, so there is no direct import (D-006 made the text the source of
   truth for this reason). The adviser recommended Syside and accepts it as the model
   deliverable; a newer Cameo may be obtainable, but the user isn't pursuing it. Options,
   if it ever matters: `update-architecture.md`.
5. Diagnostics did not surface in the session that wrote this, so the *unchecked* patterns
   above still need a linter pass.

## 8. Where the detail lives

- Process and stage-by-stage actions: [systems_engineering.md](../../../knowledge/models/systems_engineering.md)
- Verified syntax rules and instance patterns: [sysml-instance-modeling.md](../../../workflows/sysml-instance-modeling.md)
- Architecture changes and traceability rules: [update-architecture.md](../../../workflows/update-architecture.md)
- Simulation ↔ model trace: [vehicle-simulation-model.md](../../../workflows/vehicle-simulation-model.md)
- Content sources for the model: [stakeholder-register.md](../../../knowledge/models/stakeholder-register.md),
  [stakeholder-objective-ontology.md](../../../knowledge/models/stakeholder-objective-ontology.md),
  [conops-scenarios.md](../../../knowledge/models/conops-scenarios.md),
  [candidate-systems-inventory.md](../../../knowledge/models/candidate-systems-inventory.md),
  [interface-exchange-draft.md](../../../knowledge/models/interface-exchange-draft.md),
  [system_of_interest_definition.md](../../../knowledge/models/system_of_interest_definition.md)
- Decisions and open questions: [decisions-log.md](../../../decisions/decisions-log.md),
  [open-questions.md](../../../knowledge/questions/open-questions.md)
