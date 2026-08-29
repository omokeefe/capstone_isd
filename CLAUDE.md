# Capstone ISD — Project Instructions

This repository is the workspace for a University of Michigan ISD (Interdisciplinary
Systems Design) systems engineering capstone: **the National Airspace System (NAS)
modeled as a System of Systems**, centered on how operational intent propagates from
enterprise objectives down to aircraft trajectory and behavior.

## Start here

Read [assistant/README.md](assistant/README.md) first. It explains the AI-collaboration
scaffold in this repo — memory, workflows, and task state — and how to use it. That
scaffold is model-agnostic (works with Claude, ChatGPT, Copilot, etc.); this file is the
Claude Code-specific entry point into it.

Then, in order:

1. [README.md](README.md) — project purpose, scope, and current architectural direction.
2. [assistant/memory/project-brief.md](assistant/memory/project-brief.md) — the living
   summary of where the project stands (more current than README.md if they ever diverge).
3. [Project_To-Do List.md](Project_To-Do%20List.md) — the canonical, checkbox-based work
   plan (16 sections, research → architecture → optimization → deliverables).
4. [assistant/tasks/task-board.md](assistant/tasks/task-board.md) — cross-session focus
   state: what's active right now, what's blocked, what's next.

## Working agreements

- **`Project_To-Do List.md` is the single source of truth for task checkboxes.** Check
  items off there directly as work completes. Do not recreate or fork the task list
  elsewhere — `assistant/tasks/task-board.md` only tracks cross-session *focus*, not the
  full checklist.
- **Log every substantive session.** Before ending a session, write a short entry to
  `assistant/tasks/sessions/` per
  [assistant/workflows/session-wrap-up.md](assistant/workflows/session-wrap-up.md).
- **Update memory when facts change**, not just when asked. If a session changes the
  system boundary, resolves an open question, or makes an architectural decision, update
  the relevant file under `assistant/memory/` and log it in `decisions-log.md`.
- **This is a systems-engineering capstone, not an optimization paper.** Optimization and
  decision-support work should stay framed as capabilities inside the architecture, per
  the "Working Assumptions" in [README.md](README.md). If a task starts pulling toward a
  pure math/optimization deep-dive, flag the drift instead of just continuing.
- **Citations live in [references/references.bib](references/references.bib)**; source
  PDFs live in `references/`. When adding a new source, add both the PDF and a bib entry,
  and register it in `assistant/memory/source-register.md`.
- **SysML/Cameo model work** lives in `cameo_models/`; the architecture's XML export is
  [nas_system_of_systems_architecture.xml](nas_system_of_systems_architecture.xml). Don't
  hand-edit the XML export casually — treat Cameo as the source of truth and the XML as a
  generated artifact, per
  [assistant/workflows/update-architecture.md](assistant/workflows/update-architecture.md).
