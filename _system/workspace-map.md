# Workspace Map

_A short, current pointer into how this repository is organized — not a second copy of
project status (that lives in [projects/nas-sos-capstone/index.md](../projects/nas-sos-capstone/index.md))
and not a comprehensive index of everything in it. Update this file when a top-level
folder's purpose changes; update the project index when the project's status changes._

## How to orient yourself

1. Read [CLAUDE.md](../CLAUDE.md) at the repo root — the short control document for AI
   agents, which points here.
2. Read this file for the shape of the workspace.
3. Read [projects/nas-sos-capstone/index.md](../projects/nas-sos-capstone/index.md) for
   what's actually being worked right now.
4. Load only the specific knowledge/evidence/decision files a task actually needs — don't
   read the whole repo "to be safe."

## Layers

- **Control** (`CLAUDE.md`, `_system/`) — instructions governing how an AI agent orients
  itself and behaves here.
- **Operational** (`projects/`) — the one active project: its status, task list,
  sessions, journal, and deliverables (report, Cameo model, prework).
- **Knowledge** (`knowledge/`) — durable concepts, models, and open questions that could
  in principle be reused if a second project ever starts here.
- **Evidence** (`evidence/`) — literature sources, kept distinct at three depths: the raw
  PDFs, a triage-level summary of each, and a deeper structured annotation for sources
  actively feeding architecture work.
- **Decisions** (`decisions/`) — an ADR-style log, separate from both knowledge and
  project status because a decision is neither a durable concept nor a status snapshot.
- **Capture and general media** (`inbox/`, `assets/`) — lightweight, workspace-wide
  holding areas; see their own README for what belongs in each.
- **Archive** (`archive/`) — inactive material, preserved but out of the active working
  surface. Empty for now — nothing in this single-project workspace is inactive yet.

## Top-level structure

```
CLAUDE.md, README.md              control-layer entry points (repo root)
_system/                          workspace map, conventions, note types, retrieval
                                   policy, maintenance routine, migration manifests
projects/nas-sos-capstone/        the one active project — index.md is its dashboard
knowledge/
  concepts/glossary.md            domain acronyms/terms, single file
  claims/                         contestable/reusable claims — see its README
  models/                         stakeholder register, personas, candidate systems,
                                   ConOps scenarios, interface/exchange draft
  questions/open-questions.md     unresolved scope/boundary questions, single file
evidence/
  sources/                        literature PDFs + references.bib
  literature-notes/summaries/     one triage summary per source (rated 0-5)
  literature-notes/annotations/   deep structured extraction for actively-used sources
  source-register.md              the ledger indexing both of the above
decisions/decisions-log.md        ADR-style decision log, single file
inbox/                            quick-capture zone for untriaged notes/excerpts
assets/                           uncurated general attachments, pre-deliverable
archive/                          inactive material (empty)
workflows/, personas/, templates/ reusable process recipes, tool-agnostic
tools/                            small scripts supporting workflows (not the deliverable)
.claude/skills/                   thin Claude Code skill wrappers around the above
```

## Note types, retrieval, maintenance

See [_system/note-types.md](note-types.md), [_system/retrieval-policy.md](retrieval-policy.md),
[_system/metadata-schema.md](metadata-schema.md), and
[_system/maintenance.md](maintenance.md) for the details behind this map.

## Human-review queue

Items an AI reorganized or flagged that are worth your own look, not yet resolved:

- `knowledge/claims/` is empty — the associative-retrieval baseline surfaced one strong
  candidate claim (individual trajectory optimization vs. sector-level throughput,
  already named in `knowledge/models/stakeholder-personas.md` and slated as a §9
  checklist item). Per `knowledge/claims/README.md`, state it in your own words before
  it becomes a claim note — don't let an AI pre-draft it.
- `evidence/sources/de Neufville_Engineering Systems.pdf` vs.
  `evidence/sources/Systems Engineering - 2011 - Bartolomei - ...pdf` — a draft/published
  pair of the same work, not byte-identical. `evidence/source-register.md`'s Flags
  section recommends a consolidation decision; not made automatically.
