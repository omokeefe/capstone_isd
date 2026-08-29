# Assistant System — How This Repo Works With an AI Collaborator

This folder is a portable "research-assistant brain" for the capstone. It exists because
a project like this runs across dozens of AI sessions, possibly across different tools
(Claude Code, ChatGPT, Copilot, a plain browser chat), over months. Without an explicit
place to keep state, every new session re-derives context from scratch, forgets prior
decisions, and drifts from the plan. This folder fixes that.

It is **plain markdown, on purpose** — no tool-specific format is required to read or
update it. A Claude Code session, a ChatGPT project, or a Copilot chat can all use it
the same way: read the relevant files, do the work, write back what changed.

## Structure

```
assistant/
├── README.md            <- you are here
├── memory/               <- durable facts that should survive across every session
│   ├── project-brief.md         current scope, direction, and storyline
│   ├── glossary.md              domain acronyms/terms, defined once
│   ├── stakeholder-register.md  PESTLE stakeholder + objective inventory
│   ├── source-register.md       literature tracker (per Project_To-Do List.md §1)
│   ├── decisions-log.md         ADR-style log of decisions and why they were made
│   └── open-questions.md        unresolved scope/boundary questions (parking lot)
├── workflows/            <- step-by-step recipes for recurring tasks, tool-agnostic
│   ├── new-session-bootstrap.md
│   ├── process-references.md    triage new references/ files: bib + summary + 0-5 rating
│   ├── annotate-source.md
│   ├── literature-review-session.md
│   ├── update-architecture.md
│   ├── objective-ontology-pass.md
│   ├── compile-report.md        build report/main.tex -> report/main.pdf, self-fix common errors
│   ├── session-tagup.md         quick start-of-session status + advice ritual (see below)
│   └── session-wrap-up.md
├── personas/             <- optional voices to adopt for a task, tool-agnostic
│   ├── professor.md              hyper-critical SME advisor/tutor for content critique
│   ├── project-manager.md        schedule/status tracking against Project_To-Do List.md ECDs
│   └── technical-editor.md       writing/structure review of report and submission drafts
├── journal/              <- informal, append-as-you-go daily notebook (see its README)
│   └── YYYY-MM-DD.md              tag-ups, findings, ideas — one file per calendar day
├── tasks/
│   ├── task-board.md             cross-session focus state (not the full checklist)
│   └── sessions/                 one formal dated log file per work session, append-only
└── templates/
    ├── source-annotation-template.md
    ├── reference-summary-template.md
    └── session-log-template.md
```

Reference summaries themselves live in `references/summaries/`, one file per source —
see that folder's README.

## How to use this with different tools

- **Claude Code**: `CLAUDE.md` at the repo root already points here automatically at the
  start of every session. Thin skill wrappers in `.claude/skills/` map the workflows
  below to slash commands (`/session-bootstrap`, `/process-references`,
  `/annotate-source`, `/literature-review`, `/update-architecture`,
  `/objective-ontology-pass`, `/compile-report`, `/session-tagup`, `/session-wrap-up`)
  for convenience — but the underlying `workflows/*.md` files are the actual
  instructions, and work with or without those wrappers. `personas/*.md` are wrapped the
  same way (`/persona-professor`, `/persona-pm`, `/persona-editor`) but can also just be
  asked for by name in conversation ("as the professor, review this"). `/session-tagup`
  is a good default first command in a new session — a quick PM status check plus a
  brief professor's note, ahead of the fuller `/session-bootstrap` context reload if
  deeper context turns out to be needed.
- **ChatGPT / Copilot / anything else**: at the start of a session, paste in (or upload)
  `memory/project-brief.md`, `memory/glossary.md`, and whichever `workflows/*.md` file
  matches the task. At the end, ask the tool to draft an update to the relevant memory
  file and a session log entry, then review and commit them yourself.
- **A human (you), without any AI**: the files are just notes. Read `task-board.md` and
  `Project_To-Do List.md` to see what's next.

## The core loop

1. **Bootstrap** — read `workflows/new-session-bootstrap.md` (or just skim
   `memory/project-brief.md` + `tasks/task-board.md`) to reload context fast.
2. **Work** — follow the workflow that matches the task (annotate a source, push on the
   architecture, run an objective-ontology pass, whatever `Project_To-Do List.md` calls
   for next).
3. **Write back** — update `memory/` files if facts changed, check off boxes in
   `Project_To-Do List.md`, update `tasks/task-board.md` if the focus shifted.
4. **Wrap up** — log the session per `workflows/session-wrap-up.md`.

## Maintenance rules

- Memory files are **facts and decisions**, not conversation transcripts. Keep them
  current and terse; when something becomes wrong, edit it in place rather than leaving
  stale content next to a correction.
- Don't duplicate `Project_To-Do List.md`. It already tracks the full task checklist —
  `task-board.md` only holds *cross-session focus* (what's active, blocked, next).
- Session logs in `tasks/sessions/` are append-only and chronological — they're a diary,
  not a place to edit history. If a session log turns out to be wrong, add a correction
  in a later entry rather than rewriting the old one.
- Prefer linking (`[[like-this]]` in prose, or a normal relative markdown link) over
  repeating the same fact in two memory files.
