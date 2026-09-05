# Migration Manifest — 2026-09-05 Full PKM Reorg

Every path change made during the reorg from the pre-reorg flat/assistant-scaffold
structure to the `_system/`/`projects/`/`knowledge/`/`evidence/`/`decisions/` layout.
Derived directly from `git status`'s rename tracking (all moves used `git mv` or were
moved as whole directories, so git history/blame is preserved — verify with
`git log --follow <path>` on any file below).

## Bulk directory moves (uniform old-prefix → new-prefix, one row = the whole set)

| Old prefix | New prefix | Count |
|---|---|---|
| `references/*.pdf`, `references/references.bib` | `evidence/sources/` | 28 files |
| `references/summaries/*.md` | `evidence/literature-notes/summaries/` | 30 files |
| `references/annotations/*.md` | `evidence/literature-notes/annotations/` | 3 files |
| `prework/*` | `projects/nas-sos-capstone/prework/` | 8 files |
| `report/sections/*.tex` | `projects/nas-sos-capstone/report/sections/` | 9 files |
| `assistant/journal/*` | `projects/nas-sos-capstone/journal/` | 4 files |
| `assistant/tasks/sessions/*` | `projects/nas-sos-capstone/sessions/` | 3 files |
| `assistant/workflows/*.md` | `workflows/` | 9 files |
| `assistant/personas/*.md` | `personas/` | 3 files |
| `assistant/templates/*.md` | `templates/` | 3 files |

## One-to-one renames

| Old path | New path |
|---|---|
| `PROJECT_CONTEXT.md` | `_system/workspace-map.md` (rewritten — orientation content only, status moved out) |
| `assistant/README.md` | `_system/conventions.md` (rewritten — naming/linking/non-duplication rules) |
| `Project_To-Do List.md` | `projects/nas-sos-capstone/to-do-list.md` |
| `assistant/memory/decisions-log.md` | `decisions/decisions-log.md` |
| `assistant/memory/glossary.md` | `knowledge/concepts/glossary.md` |
| `assistant/memory/open-questions.md` | `knowledge/questions/open-questions.md` |
| `assistant/memory/source-register.md` | `evidence/source-register.md` |
| `assistant/memory/stakeholder-register.md` | `knowledge/models/stakeholder-register.md` |
| `assistant/memory/stakeholder-personas.md` | `knowledge/models/stakeholder-personas.md` |
| `assistant/memory/candidate-systems-inventory.md` | `knowledge/models/candidate-systems-inventory.md` |
| `assistant/memory/conops-scenarios.md` | `knowledge/models/conops-scenarios.md` |
| `assistant/memory/interface-exchange-draft.md` | `knowledge/models/interface-exchange-draft.md` |
| `assistant/tasks/task-board.md` | `projects/nas-sos-capstone/task-board.md` |
| `report/README.md` | `projects/nas-sos-capstone/report/README.md` |
| `report/main.tex` | `projects/nas-sos-capstone/report/main.tex` |
| `report/main.pdf` | `projects/nas-sos-capstone/report/main.pdf` |
| `report/main.synctex.gz` (untracked) | `projects/nas-sos-capstone/report/main.synctex.gz` |
| `report/figures/` | `projects/nas-sos-capstone/report/figures/` |
| `report/build_artifacts/` (gitignored) | `projects/nas-sos-capstone/report/build_artifacts/` |
| `references/exemplary_reports/README.md` | `projects/nas-sos-capstone/report/exemplary_reports/README.md` |
| `cameo_models/` (empty, untracked) | `projects/nas-sos-capstone/cameo_models/` |
| `.claude/skills/llm_pkm_reorg_prompt.md` | `.claude/skills/pkm-reorg/SKILL.md` (frontmatter added) |

## Merge

| Old path(s) | New path | Note |
|---|---|---|
| `PROJECT_CONTEXT.md` (status half) + `assistant/memory/project-brief.md` (all) | `projects/nas-sos-capstone/index.md` | Resolves the two files' acknowledged "more current than X if they diverge" risk by making one canonical file. |

## Deletions (not moves)

| Path | Reason |
|---|---|
| `assistant/memory/project-brief.md` | Content merged into `projects/nas-sos-capstone/index.md` above. |
| `references/MBSE Approach for designing aircraft engine inlet - cinar.pdf` | Confirmed byte-identical duplicate of `evidence/sources/Model-Based Systems Engineering Approach for a Systematic Design of Aircraft Engine Inlet.pdf` (same DOI 10.2514/6.2025-1410), already self-flagged in `source-register.md`. |
| `references/summaries/2 - jagtap2025mbseEngineInlet-duplicate-cinar.md` | Stub summary for the deleted duplicate above; no unique content, folded into the primary summary's Flags section. |

## New files created (no old path)

`_system/note-types.md`, `_system/retrieval-policy.md`, `_system/maintenance.md`,
`_system/metadata-schema.md`, `_system/migrations/` (this file), `archive/README.md`,
`inbox/README.md`, `assets/README.md`, `knowledge/claims/README.md`,
`workflows/process-inbox.md`, `.claude/skills/process-inbox/SKILL.md`.

## Content edits (same path, content changed for the reorg)

`CLAUDE.md`, `README.md`, `.gitignore` (build-artifact path), and every
`.claude/skills/*/SKILL.md` wrapper (path pointers updated) — plus internal relative-link
and path-mention fixes across `evidence/source-register.md`, `evidence/sources/references.bib`,
`knowledge/models/*.md`, `knowledge/concepts/glossary.md`, `knowledge/questions/open-questions.md`,
`decisions/decisions-log.md`, `projects/nas-sos-capstone/to-do-list.md`,
`projects/nas-sos-capstone/report/main.tex` (bib/graphics paths), and the individual
`evidence/literature-notes/summaries/*.md` / `annotations/*.md` files (bare
`Project_To-Do List.md` mentions only — no substantive content changed).

**Deliberately left untouched**: session logs in `projects/nas-sos-capstone/sessions/`
and journal entries in `projects/nas-sos-capstone/journal/` still contain old-path
mentions in their historical prose (e.g. "Project_To-Do List.md", "assistant/") — these
are append-only dated records of what was true when written, not live pointers, per this
workspace's rule against rewriting history.
