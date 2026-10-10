# NAS System-of-Systems Capstone — Project Index

_This is the project's one-page dashboard — current scope, direction, status, decisions,
and next actions, with links out to the file that owns each detail. It replaces what
used to be split across `PROJECT_CONTEXT.md` and `assistant/memory/project-brief.md`;
those two carried an acknowledged risk of silently diverging, so this reorg merged them
into one canonical file. Keep it current — edit in place when scope or direction
changes; update it at session sign-off per
[workflows/session-signoff.md](../../workflows/session-signoff.md)._

## What this is

A UofM ISD systems engineering & design capstone. System of interest: the **National
Airspace System (NAS)**, modeled as a **System of Systems** in SysML v2, emphasizing
architecture (structure, behavior, interfaces, traceability) over pure optimization.
Deliverables: a capstone report (`report/main.tex`) and a SysML v2 model (`cameo_models/`
— textual `.sysml` authored in Syside Modeler in VS Code, which is the source of truth
per D-006; Cameo is optional and downstream). Full framing: [README.md](../../README.md).

## How we got here

The project originally started as a **rendezvous / trajectory optimization** problem.
After scoping discussions (see `prework/gpt_convos.md`), the direction broadened to a
systems-of-systems architecture of the NAS itself, because that framing better fits an
ISD capstone's strengths (architecture, interfaces, responsibility, traceability) and
gives optimization a defined *place* — a decision-support capability inside the
architecture — instead of being the entire subject. See
[[decisions-log]] (`../../decisions/decisions-log.md`) D-001 for the fuller rationale.

## Center of gravity

The throughline that keeps the project bounded is the **lifecycle of trajectory
intent**:

```
Strategic objective -> mission plan -> flight plan -> ATC constraints ->
trajectory negotiation -> FMS intent -> guidance commands -> aircraft motion
```

Everything else (stakeholder analysis, objective ontology, architecture decomposition,
optimization study) should trace back to this chain somewhere.

## Current state

_As of 2026-10-10._ Interim Report #2 is due 2026-10-25; the full list of graded dates is in `to-do-list.md` §1.

- **Scope.** The system-of-interest boundary and research questions were closed on 2026-09-21 (D-007); the baseline is `knowledge/models/system_of_interest_definition.md`. Interim Report #1 was submitted 2026-09-17.
- **Adviser.** The meeting with Mark Petrotta has happened (reported by the owner 2026-10-10; date not recorded). He endorsed the project, its focus, and a scope that varies with schedule and availability. The owner found it less informative than hoped. The scope option (a/b/c) is therefore the owner's to set against the schedule. The owner did not report an answer on the course's current-state metric; it is treated as still open (`knowledge/questions/open-questions.md`, "Course minimum requirements fit").
- **Plan.** Adopted 2026-10-10 as D-016: four tracks (model, experiment, report, evidence on demand), nine weekly turns to 2026-12-13, five artifact states in place of checkboxes, and documented tailoring of the August plan. `to-do-list.md` opens with the turn table. One traced thread carries the project: airline cost objective → SN-AIR-05 → SLR-INF-02/03/04 and SLR-CLR-13 → the airline-to-ATC interface (D-019) → the conflict-resolution sequence → verification cases → the experiment's outcome table.
- **Model (Track A).** Context diagram and aircraft IBDs hand-reviewed (D-009 to D-012), links not yet evidence-graded. New 2026-10-10: `nas_analysis.sysml` (fidelity levels, performance calcs, the scoring analysis), `nas_verification.sysml` (six verification cases), the `AirlinePerformanceShare` item, ports and interface (D-019), and `architectureState = baseline | improved` on every requirement (D-018). Whole folder passes `syside check`. Airspace IBD still a placeholder; sequence view untested; swimlane answer in `knowledge/models/sysml-diagram-rendering.md` §9.
- **Experiment (Track B).** Four aircraft, one sector, cases A to D (D-013 to D-015). Scoring model is OpenAP (D-017), installed and running: `simulation/experiment_scoring.py` scores the base scenario end to end at three fidelities, 14 tests pass. First run: case A descends the heavy aircraft 4,000 ft; B, C and D all choose the 2,000 ft descent with the in-trail aircraft slowed, so C minus B = 0 in the base scenario (`knowledge/models/experiment-options-and-scoring.md` §8). Every scenario number is a Decide item (`experiment-scenario-numbers.md`).
- **Requirements.** 27 stakeholder and 53 system requirements drafted; the owner's review is in progress per the `#TODO` block in `knowledge/models/requirements-and-traceability.md`. "The NAS shall" stays the subject at the system-of-systems tier; a next tier is written for the thread only.
- **Report (Track C).** `report/main.tex` builds. Every part Interim Report #2 needs is marked with a red `\irtwo` note; the checklist is in `report/README.md`. Section 3 has the systems-engineering-approach table skeleton, the two-claims and proposed-interface subsections; Section 4 has the two OpenAP figures and the experiment tables. The owner writes the prose.
- **Evidence.** `evidence/source-register.md` has 84 rows; every file in `evidence/sources/` is registered. Web-only method entries: OpenAP, the INCOSE Guide to Writing Requirements, ISO/IEC/IEEE 15288.

Details: [[task-board]] (`task-board.md`) for active/blocked cross-session focus.

## Candidate top-level domains

Not yet finalized as a SysML package structure, but the working decomposition
([[decisions-log]] D-002) is:

Governance · Airspace Management · Airspace Resources · Flight Operations ·
Airport Operations · Aircraft Systems · Information Services · Infrastructure ·
Decision Support

The BDD ([[decisions-log]] D-008, 2026-09-22) now splits these by D-007 disposition rather
than nesting all nine uniformly: **Modeled Systems** (Airspace Management, Flight
Operations, Airport Operations, Aircraft Systems, and a new Flight Crew domain) compose
`NationalAirspaceSystem`; **Boundary Actors / Context Constraints / Absorbed capabilities**
(Governance, Passengers, Military, Infrastructure, Information Services, Decision Support)
compose a separate `Environment` part def for the context diagram to reference. D-002's
question of whether this nine-domain decomposition is itself final is unaffected and still
open — see below.

See [[open-questions]] (`../../knowledge/questions/open-questions.md`) for unresolved
architecture calls, and `to-do-list.md` §6 ("Explore Alternative System Decompositions")
for the plan to compare this against organization-based, lifecycle-based, physical,
information-flow, and decision-authority decompositions before committing.

## Decisions

Latest first — full rationale and history in
[[decisions-log]] (`../../decisions/decisions-log.md`):

- **D-019** — The proposed airline-to-ATC data share is modeled as an improved-architecture `interface def` with the `AirlinePerformanceShare` item (weight, cost index, connection priority; thrust, drag and fuel-flow model references present but unexercised); security is a stated assumption.
- **D-018** — Every requirement carries `architectureState`: `baseline` (today's NAS) or `improved`; the five unmet requirements are `improved`; case A is the course's current-state metric, cases C and D the improvement claim.
- **D-017** — OpenAP is the experiment's scoring model at three selectable fidelities (conceptual, nominal mass, actual mass); B39M borrows the MAX 8 drag polar; fallback decision 2026-11-08.
- **D-016** — The plan: four tracks, nine weekly turns, five artifact states, one traced thread, documented tailoring of the August plan, a lessons file, model freeze 2026-11-29.
- **D-015** — The experiment starts from one aircraft type (B737-900 MAX) for both crossing aircraft; ICAO's calculator is the source for CO2 per kg of fuel; the effect of a speed change on arrival time is acknowledged.
- **D-014** — Experiment second review: the speed lever is built to fail within ±0.04 Mach, a fourth case adds the airline's connection information, every aircraft's cost is listed, and emissions are priced for the airline only.
- **D-013** — Experiment scoring: altitude options and the climb rule come from the TASAR study, and system-level impacts are stated side by side with no weighted sum.
- **D-012** — Owner's hand review of the diagrams: the crew acts through flight deck controls, outside inputs are drawn as ports, decision support is owned per actor, and the airport and aircraft were trimmed.
- **D-011** — Aircraft decomposed in levels; the detail stays in the model and is hidden on diagrams by default.
- **D-010** — Context diagram rendering rule, datalink split, role naming, and supporting definitions.
- **D-009** — Context diagram baseline: every system assessed against D-007; the airline operations center link split to traffic flow management; flight deck merged.
- **D-008** — Reconciled the SysML BDD to D-007: `NationalAirspaceSystem` now composes only
  the five ratified Modeled System domains (adding a new Flight Crew domain that was
  missing entirely); a new `Environment` part def holds Governance, Passengers, Military,
  Infrastructure, Information Services, and Decision Support, undecomposed, for the context
  diagram to reference.
- **D-006** — The SysML v2 text (authored in Syside Modeler / VS Code) is the source of
  truth for the model; Cameo is optional and downstream. Amends the tool half of D-003.
- **D-007** — Ratified the SOI around trajectory-intent propagation: ATC, airport
  operations, Part 121 scheduled passenger flight operations, aircraft systems, and
  flight crew are modeled; passengers, governance, and military are boundary actors;
  infrastructure and suppliers are constraints; information systems and decision
  support are abstracted.
- **D-005** — Instance/scenario content (`cameo_models/scenarios/`) and simulation code
  (`simulation/`) are kept separate from the structural model, with a documented
  (not language-level) trace between a SysML `calc def` interface and its Python
  implementation.
- **D-004** — Questions the project will answer: External optimization analyses will evaluate how changes in decision scope, information, objective functions, and planning horizon propagate across stakeholder-specific measures of performance and effectiveness.
- **D-003** — (Tool choice amended by D-006: Cameo is no longer the source of truth.) The project will employ SysML in Cameo as its primary systems-modeling language. A decision-centric modeling method, informed by MagicGrid and selected UAF/DoDAF concepts, will represent stakeholder concerns, operational activities, constituent systems, decision authority, information availability, and quantitative performance relationships.
- **D-002** — Domain decomposition (Governance, Airspace Management, Airspace Resources,
  Flight Operations, Airport Operations, Aircraft Systems, Information Services,
  Infrastructure, Decision Support) built around authority/responsibility/information
  ownership, not a flat object list. Provisional — revisit at §6.
- **D-001** — Pivoted from a rendezvous/trajectory optimization capstone to a NAS-as-SoS
  architecture, with optimization demoted to one capability inside it.

## Open questions

Parking lot, grouped by topic, in [[open-questions]] (`../../knowledge/questions/open-questions.md`). Current groups: reconciling the model to the ratified boundary, scenario and simulation content, course minimum requirements (current-state metric, improvement claim, sponsor value), decomposition finality (§6), literature gaps, actor abstraction, unregistered sources, the experiment's scope and central claim (§11), and the diagram review questions from D-012.

## Working assumptions (guardrails)

- Emphasis is structure, behavior, interfaces, and traceability — not optimization math.
- The project must stay bounded enough to actually finish; the NAS is huge.
- Decision-support / optimization appears as a service *inside* the architecture.
- The model should show how information moves between domains, not just what physical
  things exist.

## Likely final storyline

A reference architecture for how airspace intent is managed across the NAS — spanning
the organizations that define/enforce rules, the domains managing airspace resources, the
systems supporting flight operations, and the onboard systems turning intent into
executable trajectory/guidance behavior. Success criterion: a reviewer can follow one
clear chain from a mission/operational goal down to aircraft-level execution, and back up
to the authorities/services that constrain it.

## Relevant people and systems

- **Owen O'Keefe** (omokeefe@gmail.com) — student, this capstone.
- **Mark Petrotta** (mpetrott@umich.edu) — faculty adviser this semester, has advised
  several MBSE-focused capstones.
- **Nicole Friedberg** (nmtucker@umich.edu) — ISD 503 course coordinator. Office hours
  Mondays 1:30-2:30p (Zoom or 3664 GG Brown), none Sep 28 or Oct 19. Extensions are
  approved by the adviser first, then the coordinator is informed. Course rules and
  milestone details: `prework/course-info-canvas.md`.
- Stakeholder inventory (PESTLE) and enterprise-objective hierarchy:
  [[stakeholder-register]] (`../../knowledge/models/stakeholder-register.md`); ConOps-
  scenario stakeholder personas: [[stakeholder-personas]]
  (`../../knowledge/models/stakeholder-personas.md`).
- Candidate NAS systems/components inventory:
  [[candidate-systems-inventory]] (`../../knowledge/models/candidate-systems-inventory.md`);
  draft interface/exchange map:
  [[interface-exchange-draft]] (`../../knowledge/models/interface-exchange-draft.md`).

## Links to source material

- Literature tracker (bib key, rating, summary per source):
  [[source-register]] (`../../evidence/source-register.md`).
- Bibliography and PDFs: `evidence/sources/references.bib`, `evidence/sources/`.
- Origin conversations that shaped the capstone direction: `prework/gpt_convos.md`.
- Domain/glossary terms: [[glossary]] (`../../knowledge/concepts/glossary.md`).

## Repository map

- `README.md` — the public-facing project overview (keep in sync with this file).
- `to-do-list.md` — canonical 16-section task checklist (this project's copy of what
  used to be the repo-root `Project_To-Do List.md`).
- `prework/nas_system_of_systems_architecture.xml` — earlier XML draft of the
  architecture content, predating the SysML v2 model; not kept in sync (D-006). If it
  disagrees with the `.sysml` files, the `.sysml` files win.
- `cameo_models/` — the SysML v2 model workspace and source of truth (D-006; the folder
  name is historical): start with `sysmlv2_exploration.md` (the working reference and file
  map — it covers the structural domain decomposition (D-002) and `scenarios/`, which
  holds concrete instance content; see also `workflows/sysml-instance-modeling.md`).
- `simulation/` — the vehicle-dynamics simulation capability (§12), plain Python, traced
  by hand back to a `calc def` in the model's `DecisionSupport` package (file map:
  `cameo_models/sysmlv2_exploration.md`) rather than embedded in the model (D-005; see
  `workflows/vehicle-simulation-model.md`).
- `prework/` — source material predating the structured workflow (`gpt_convos.md` is the
  most important: it captures the two conversations that shaped the direction and the
  PESTLE stakeholder / enterprise-objective analysis).
- `report/` — the LaTeX capstone report.
- `../../evidence/`, `../../knowledge/`, `../../decisions/` — the workspace-wide
  evidence/knowledge/decision layers this project draws on; see
  [_system/workspace-map.md](../../_system/workspace-map.md) for how the whole
  repository is organized.

## Next actions

Maintained in [[task-board]] (`task-board.md#next-session-priority`) — currently (2026-10-10, evening, turn 1): confirm the experiment's scenario numbers and re-run it; review the 27 stakeholder requirements; draft Assumptions and Methodology for Interim Report #2 (2026-10-25) from the red call-outs in the report; re-word the view captions; restate the candidate lessons.

## Risks (D-016, reviewed at each turn)

| Risk | Guard |
|---|---|
| OpenAP numbers implausible for the type (it borrows the MAX 8 polar) | Fallback to a `mori2022massCruise` lookup table, decided by 2026-11-08 (D-017). |
| Owner hours (10 to 20 a week) | Each turn carries about 12 owner-hours; "if time" items are marked in `to-do-list.md`. |
| Adviser asks how the experiment tests MBSE | The two claims are separated in Section 3 (`sec:two-claims`); the model's contribution is the interface, the ownership map, the unmet requirement and the fidelity swap. |
| Requirements too many to defend | Only the 27 stakeholder and the 15 thread requirements are reviewed; the rest are appendix, marked unreviewed. |
| Diagrams unreadable at page size | Each report figure is a view designed for its page (lessons-learned 2026-10-10); render at every welcome. |
| Syside Python licence or renderer limits (sequence view untested) | Licence works for `load_model` (2026-10-10); sequence view tested before turn 3; fallback is a hand-drawn sequence marked as such. |

## AI operating instructions

Start with [CLAUDE.md](../../CLAUDE.md) (Claude Code entry point) or
[_system/workspace-map.md](../../_system/workspace-map.md) (tool-agnostic workspace
orientation) — both explain the memory/workflow/task-state system this file summarizes.
Key working agreements: `to-do-list.md` is the only source of truth for task checkboxes;
update knowledge/evidence/decision files when facts change, not just when asked; log
every substantive session to the journal per
[workflows/session-signoff.md](../../workflows/session-signoff.md).
