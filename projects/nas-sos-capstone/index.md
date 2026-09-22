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

ISD 503 Interim Report #1 (Introduction and Current State + References) was submitted
2026-09-17, ahead of its 2026-09-20 ECD. Working through `to-do-list.md` §1 ("Establish
Research Framework") — the SOI boundary and research questions were ratified/closed on
2026-09-21 through D-007. The resulting scope baseline is documented in
`knowledge/models/system_of_interest_definition.md`; §2-§16 otherwise remain in
progress or not yet started. All 29 files in `evidence/sources/` are processed (bib + summary + rating); three of the
newest ten (all rated 4/5) also have a full deep annotation. Details:
[[task-board]] (`task-board.md`) for active/blocked cross-session focus.

## Candidate top-level domains

Not yet finalized as a SysML package structure, but the working decomposition
([[decisions-log]] D-002) is:

Governance · Airspace Management · Airspace Resources · Flight Operations ·
Airport Operations · Aircraft Systems · Information Services · Infrastructure ·
Decision Support

See [[open-questions]] (`../../knowledge/questions/open-questions.md`) for unresolved
architecture calls, and `to-do-list.md` §6 ("Explore Alternative System Decompositions")
for the plan to compare this against organization-based, lifecycle-based, physical,
information-flow, and decision-authority decompositions before committing.

## Decisions

Latest first — full rationale and history in
[[decisions-log]] (`../../decisions/decisions-log.md`):

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

Parking lot, grouped by to-do section, in
[[open-questions]] (`../../knowledge/questions/open-questions.md`). Current groups: SOI
boundary (§1), decomposition finality (§6), literature gaps (missing PDFs for several bib
entries), optimization study scope (§11-§14 vs. the report's page cap).

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

Maintained in [[task-board]] (`task-board.md#next-session-priority`) — currently: close
out §1 (finalize research questions, resolve the SOI boundary), then start §2-§4
literature-review sessions prioritizing the 5-rated sources.

## AI operating instructions

Start with [CLAUDE.md](../../CLAUDE.md) (Claude Code entry point) or
[_system/workspace-map.md](../../_system/workspace-map.md) (tool-agnostic workspace
orientation) — both explain the memory/workflow/task-state system this file summarizes.
Key working agreements: `to-do-list.md` is the only source of truth for task checkboxes;
update knowledge/evidence/decision files when facts change, not just when asked; log
every substantive session to the journal per
[workflows/session-signoff.md](../../workflows/session-signoff.md).
