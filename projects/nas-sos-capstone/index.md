# NAS System-of-Systems Capstone — Project Index

_This is the project's one-page dashboard — current scope, direction, status, decisions,
and next actions, with links out to the file that owns each detail. It replaces what
used to be split across `PROJECT_CONTEXT.md` and `assistant/memory/project-brief.md`;
those two carried an acknowledged risk of silently diverging, so this reorg merged them
into one canonical file. Keep it current — edit in place when scope or direction
changes; update it at session wrap-up per
[workflows/session-wrap-up.md](../../workflows/session-wrap-up.md)._

## What this is

A UofM ISD systems engineering & design capstone. System of interest: the **National
Airspace System (NAS)**, modeled as a **System of Systems** in SysML/Cameo, emphasizing
architecture (structure, behavior, interfaces, traceability) over pure optimization.
Deliverables: a capstone report (`report/main.tex`) and a Cameo/SysML model
(`cameo_models/`, exported to `prework/nas_system_of_systems_architecture.xml` until a
real Cameo export exists). Full framing: [README.md](../../README.md).

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

Working through `to-do-list.md` §1 ("Establish Research Framework") — SOI boundary,
research questions, and source register are being stood up; §2-§16 not yet started. All
29 files in `evidence/sources/` are processed (bib + summary + rating); three of the
newest ten (all rated 4/5) also have a full deep annotation. Details:
[[task-board]] (`task-board.md`) for active/blocked cross-session focus.

## Candidate top-level domains

Not yet finalized as a SysML package structure, but the working decomposition
([[decisions-log]] D-002) is:

Governance · Airspace Management · Airspace Resources · Flight Operations ·
Airport Operations · Aircraft Systems · Information Services · Infrastructure ·
Decision Support

See [[open-questions]] (`../../knowledge/questions/open-questions.md`) for unresolved
boundary calls, and `to-do-list.md` §6 ("Explore Alternative System Decompositions") for
the plan to compare this against organization-based, lifecycle-based, physical,
information-flow, and decision-authority decompositions before committing.

## Decisions

Latest first — full rationale and history in
[[decisions-log]] (`../../decisions/decisions-log.md`):

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
- `prework/nas_system_of_systems_architecture.xml` — architecture content exported as
  XML (currently a draft; promote to a real Cameo export once modeling starts).
- `cameo_models/` — SysML/Cameo model workspace (currently empty scaffolding).
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
every substantive session per
[workflows/session-wrap-up.md](../../workflows/session-wrap-up.md).
