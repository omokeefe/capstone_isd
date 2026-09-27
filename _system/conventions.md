# Conventions

Naming, linking, and non-duplication rules for this workspace. Read alongside
[_system/workspace-map.md](workspace-map.md) (what the folders are) and
[_system/note-types.md](note-types.md) (what belongs in each note type).

## Why this scaffold exists

This repository is used across dozens of AI sessions, possibly across different tools
(Claude Code, ChatGPT, Copilot, a plain browser chat), over months. Without an explicit
place to keep state, every new session re-derives context from scratch, forgets prior
decisions, and drifts from the plan. The `_system/`, `projects/`, `knowledge/`,
`evidence/`, and `decisions/` folders fix that. They are **plain markdown, on purpose** —
no tool-specific format is required to read or update them.

## How to use this with different tools

- **Claude Code**: `CLAUDE.md` at the repo root points here automatically at the start of
  every session. Thin skill wrappers in `.claude/skills/` map the workflows in
  `workflows/` to slash commands for convenience — but the underlying `workflows/*.md`
  files are the actual instructions, and work with or without those wrappers.
  `personas/*.md` are wrapped the same way but can also just be asked for by name in
  conversation ("as the professor, review this").
- **ChatGPT / Copilot / anything else**: at the start of a session, paste in (or upload)
  `projects/nas-sos-capstone/index.md`, `knowledge/concepts/glossary.md`, and whichever
  `workflows/*.md` file matches the task. At the end, ask the tool to draft an update to
  the relevant knowledge/evidence file and a session log entry, then review and commit
  them yourself.
- **A human (you), without any AI**: the files are just notes. Read
  `projects/nas-sos-capstone/task-board.md` and `projects/nas-sos-capstone/to-do-list.md`
  to see what's next.

## The core loop

1. **Bootstrap** — read `workflows/session-welcome.md` (or just skim
   `projects/nas-sos-capstone/index.md` + `task-board.md`) to reload context fast.
2. **Work** — follow the workflow that matches the task (annotate a source, push on the
   architecture, run an objective-ontology pass, whatever `to-do-list.md` calls for
   next).
3. **Write back** — update `knowledge/`/`evidence/`/`decisions/` files if facts changed,
   check off boxes in `to-do-list.md`, update `task-board.md` if the focus shifted.
4. **Sign off** — log the session to the journal per `workflows/session-signoff.md`.

## Naming

- Reference summaries: `<0-5 rating> - <bib-key-or-slug>.md` in
  `evidence/literature-notes/summaries/` — the numeric prefix makes file listings sort by
  relevance. Re-rating a source means renaming its file; update
  `evidence/source-register.md`'s link when you do.
- Annotations: `<bib-key-or-slug>.md` (no rating prefix) in
  `evidence/literature-notes/annotations/`.
- Session logs: `YYYY-MM-DD-<short-slug>.md` in `projects/nas-sos-capstone/sessions/`,
  append-only.
- Journal: one file per calendar day, `YYYY-MM-DD.md`, in
  `projects/nas-sos-capstone/journal/`.
- Bib keys: `lastname+year+shorttitle`, lowercase, no spaces (e.g.
  `schultz2017turnaround`).

## Text formatting (no hard wrapping)

Files here are read with soft word wrap on screens of widely varying width, so new or rewritten content should not be hard-wrapped to a fixed column.

- **Markdown prose: one paragraph per line** (or one list item per line). Let the editor wrap it. Don't insert line breaks mid-sentence to hit 80/100/120 characters.
- **Semantic line breaks are fine where they mean something** — separate list items, table rows, headings, block quotes, and deliberate breaks between distinct ideas. Just never break purely for width.
- **When editing an existing hard-wrapped paragraph**, it's fine to reflow that paragraph to a single line as part of the edit. Don't mass-reflow untouched files — it bloats diffs and obscures real changes.
- **Tables**: don't pad cells with spaces to align columns; `| a | b |` is enough.
- **Exceptions where fixed layout matters**: code blocks, ASCII diagrams/trees (e.g. the folder map in `workspace-map.md`), YAML/frontmatter, `.bib` entries, and source code (`.sysml`, `.py`, `.tex`) — follow the file's existing style or the language's own conventions there. In LaTeX, one sentence or paragraph per line is preferred over column wrapping.

## Linking

- Prefer linking (`[[like-this]]` in prose, or a normal relative markdown link) over
  repeating the same fact in two files.
- `[[wikilink]]`-style references are a prose convention in this workspace, not a
  resolved link format any tool follows — pair them with a real relative markdown link or
  a plain path in backticks when the target needs to actually be clickable/navigable.

## Non-duplication rules

- Knowledge/evidence/decision files are **facts and decisions**, not conversation
  transcripts. Keep them current and terse; when something becomes wrong, edit it in
  place rather than leaving stale content next to a correction.
- Don't duplicate `projects/nas-sos-capstone/to-do-list.md`. It already tracks the full
  task checklist — `task-board.md` only holds *cross-session focus* (what's active,
  blocked, next).
- Session logs in `projects/nas-sos-capstone/sessions/` are append-only and
  chronological — they're a diary, not a place to edit history. If a session log turns
  out to be wrong, add a correction in a later entry rather than rewriting the old one.
- `evidence/literature-notes/summaries/` and `evidence/literature-notes/annotations/` are
  the detail; `evidence/source-register.md` only indexes and links to them — it doesn't
  duplicate their content.
