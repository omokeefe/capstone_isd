# Capstone ISD — Project Instructions

This repository is the workspace for a University of Michigan ISD (Interdisciplinary
Systems Design) systems engineering capstone: **the National Airspace System (NAS)
modeled as a System of Systems**, centered on how operational intent propagates from
enterprise objectives down to aircraft trajectory and behavior.

## Start here

Read [_system/workspace-map.md](_system/workspace-map.md) first — a short, current map
of how this repository is organized (control / operational / knowledge / evidence /
decision layers, what lives where) that links out to the file that owns each detail.
Then read [projects/nas-sos-capstone/index.md](projects/nas-sos-capstone/index.md), the
one active project's dashboard (objective, current state, decisions, open questions,
people/systems, source links, next actions). Both are model-agnostic (work with Claude,
ChatGPT, Copilot, etc.); this file is the Claude Code-specific entry point into them.

Then, as needed:

1. [README.md](README.md) — project purpose, scope, and current architectural direction.
2. [projects/nas-sos-capstone/to-do-list.md](projects/nas-sos-capstone/to-do-list.md) —
   the canonical, checkbox-based work plan (16 sections, research → architecture →
   optimization → deliverables).
3. [projects/nas-sos-capstone/task-board.md](projects/nas-sos-capstone/task-board.md) —
   cross-session focus state: what's active right now, what's blocked, what's next.
4. [_system/note-types.md](_system/note-types.md) and
   [_system/conventions.md](_system/conventions.md) — what kind of note goes where, and
   the naming/linking rules, if a task involves adding new content rather than just
   reading it.

## Working agreements

- **`to-do-list.md` is the single source of truth for task checkboxes.** Check
  items off there directly as work completes. Do not recreate or fork the task list
  elsewhere — `task-board.md` only tracks cross-session *focus*, not the full checklist.
- **Log every substantive session.** Before ending a session, write a short entry to
  `projects/nas-sos-capstone/sessions/` per
  [workflows/session-wrap-up.md](workflows/session-wrap-up.md).
- **Update knowledge/evidence/decision files when facts change**, not just when asked. If
  a session changes the system boundary, resolves an open question, or makes an
  architectural decision, update the relevant file under `knowledge/` or `evidence/` and
  log it in [decisions/decisions-log.md](decisions/decisions-log.md).
- **This is a systems-engineering capstone, not an optimization paper.** Optimization and
  decision-support work should stay framed as capabilities inside the architecture, per
  the "Working Assumptions" in [README.md](README.md). If a task starts pulling toward a
  pure math/optimization deep-dive, flag the drift instead of just continuing.
- **Citations live in [evidence/sources/references.bib](evidence/sources/references.bib)**;
  source PDFs live in `evidence/sources/`. When adding a new source, add both the PDF and
  a bib entry, and register it in
  [evidence/source-register.md](evidence/source-register.md).
- **SysML/Cameo model work** lives in `projects/nas-sos-capstone/cameo_models/`; the
  architecture's XML export is
  `projects/nas-sos-capstone/prework/nas_system_of_systems_architecture.xml` (currently a
  draft; promote it once real Cameo modeling starts). Don't hand-edit the XML export
  casually — treat Cameo as the source of truth and the XML as a generated artifact, per
  [workflows/update-architecture.md](workflows/update-architecture.md).
- **Quick, untriaged notes go in `inbox/`, not straight into knowledge/evidence.** Triage
  them per [workflows/process-inbox.md](workflows/process-inbox.md) before treating
  anything in there as settled fact.

## Scope and safety boundaries

- **Stay inside this repository (`c:\repos\capstone_isd`).** Do not read, write, move,
  or delete files anywhere else on the machine unless the user gives an explicit,
  specific instruction naming that path in the current conversation. Don't wander into
  sibling repos, home-directory dotfiles, or system locations "to check something."
- **Treat `git commit` and `git push` as requiring fresh, explicit approval every time.**
  A prior approval to commit or push does not carry over to later changes in the same
  session — confirm scope again before each one. Never `--force` push, never push to
  `main` without being asked, and never use `--no-verify` or similar hook-skipping flags.
- **Treat file/branch deletion, `git reset --hard`, `git clean`, and any bulk overwrite
  as high-caution actions**, even inside this repo. Prefer a reversible move/rename or a
  stash over deleting, and always run `git status` first to check for uncommitted work
  before anything that could discard it.
- **Never run destructive or system-altering commands outside the project directory** —
  no deleting/moving files elsewhere on disk, no touching other repos, no modifying
  global git config, shell profiles, or OS settings — even if a task seems to call for
  it. If something outside this repo's scope seems necessary, stop and ask first.
