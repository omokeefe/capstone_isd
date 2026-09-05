# Project Context

_A one-page dashboard. Each section is a short, current summary that links to the file
that actually owns the detail — don't grow this file into a second narrative. Update it
whenever the linked files change materially (session wrap-up is the natural time)._

## Objective and deliverable

UofM ISD systems engineering & design capstone. System of interest: the **National
Airspace System (NAS)**, modeled as a **System of Systems** in SysML/Cameo, emphasizing
architecture (structure, behavior, interfaces, traceability) over pure optimization.
Deliverables: a capstone report (`report/main.tex`) and a Cameo/SysML model
(`cameo_models/`, exported to [nas_system_of_systems_architecture.xml](nas_system_of_systems_architecture.xml)).
Full framing: [README.md](README.md).

## Current state

Working through `Project_To-Do List.md` §1 ("Establish Research Framework") — SOI
boundary, research questions, and source register are being stood up; §2-§16 not yet
started. All 20 files in `references/` are processed (bib + summary + rating). Details:
[assistant/memory/project-brief.md](assistant/memory/project-brief.md) (storyline/direction)
and [assistant/tasks/task-board.md](assistant/tasks/task-board.md) (active/blocked work).

## Decisions

Latest first — full rationale and history in
[assistant/memory/decisions-log.md](assistant/memory/decisions-log.md):

- **D-002** — Domain decomposition (Governance, Airspace Management, Airspace Resources,
  Flight Operations, Airport Operations, Aircraft Systems, Information Services,
  Infrastructure, Decision Support) built around authority/responsibility/information
  ownership, not a flat object list. Provisional — revisit at §6.
- **D-001** — Pivoted from a rendezvous/trajectory optimization capstone to a NAS-as-SoS
  architecture, with optimization demoted to one capability inside it.

## Open questions

Parking lot, grouped by to-do section, in
[assistant/memory/open-questions.md](assistant/memory/open-questions.md). Current groups:
SOI boundary (§1), decomposition finality (§6), literature gaps (missing PDFs for several
bib entries), optimization study scope (§11-§14 vs. the report's page cap).

## Relevant people and systems

- **Owen O'Keefe** (omokeefe@gmail.com) — student, this capstone.
- **Mark Petrotta** (mpetrott@umich.edu) — faculty adviser this semester, has advised
  several MBSE-focused capstones.
- Stakeholder inventory (PESTLE) and enterprise-objective hierarchy:
  [assistant/memory/stakeholder-register.md](assistant/memory/stakeholder-register.md);
  ConOps-scenario stakeholder personas:
  [assistant/memory/stakeholder-personas.md](assistant/memory/stakeholder-personas.md).
- Candidate NAS systems/components inventory:
  [assistant/memory/candidate-systems-inventory.md](assistant/memory/candidate-systems-inventory.md);
  draft interface/exchange map:
  [assistant/memory/interface-exchange-draft.md](assistant/memory/interface-exchange-draft.md).

## Links to source material

- Literature tracker (bib key, rating, summary per source):
  [assistant/memory/source-register.md](assistant/memory/source-register.md).
- Bibliography and PDFs: [references/references.bib](references/references.bib),
  `references/`.
- Origin conversations that shaped the capstone direction: `prework/gpt_convos.md`.
- Domain/glossary terms: [assistant/memory/glossary.md](assistant/memory/glossary.md).

## Next actions

Maintained in
[assistant/tasks/task-board.md](assistant/tasks/task-board.md#next-session-priority) —
currently: close out §1 (finalize research questions, resolve the SOI boundary), then
start §2-§4 literature-review sessions prioritizing the 5-rated sources.

## AI operating instructions

Start with [CLAUDE.md](CLAUDE.md) (Claude Code entry point) or
[assistant/README.md](assistant/README.md) (tool-agnostic scaffold explanation) — both
explain the memory/workflow/task-state system this file summarizes. Key working
agreements: `Project_To-Do List.md` is the only source of truth for task checkboxes;
update memory files when facts change, not just when asked; log every substantive
session per [assistant/workflows/session-wrap-up.md](assistant/workflows/session-wrap-up.md).
