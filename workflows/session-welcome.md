# Workflow: Session Welcome

Run at the start of a session — a reasonable default opener unless the session is
already mid-task. Read-only: produces a spoken recap and a short focus recommendation,
and writes nothing to `task-board.md`, `to-do-list.md`, `open-questions.md`, or the
journal. All state changes happen at `session-signoff`, not here — this keeps the
ritual fast and keeps "what to do next" living in exactly one place instead of being
re-derived and re-written at both ends of a session.

## Step 1 — Context refresh (silent)

Read, without narrating:

- `projects/nas-sos-capstone/index.md`
- `projects/nas-sos-capstone/task-board.md`
- `knowledge/questions/open-questions.md`
- The most recent entry (or two) in `projects/nas-sos-capstone/journal/` — the latest
  dated file — for anything from last session that hasn't been folded into
  `task-board.md` yet.

If the task at hand names a specific area, also read the matching file:

- Literature/sources -> `evidence/source-register.md`
- Stakeholders/objectives -> `knowledge/models/stakeholder-register.md`
- Terminology confusion -> `knowledge/concepts/glossary.md`
- "Why did we decide X?" -> `decisions/decisions-log.md`

## Step 2 — Recap (for the user)

State back, briefly and plainly — two or three short bullets, not a restatement of
`task-board.md`'s prose:

- **Where things stand** — current phase/milestone, one line.
- **What's actively in flight** — the Active section's items, compressed to their
  actual point rather than pasted verbatim.
- Anything urgent worth naming up front — a passed ECD, a flag left unresolved from
  last session's sign-off.

## Step 3 — Professor's focus picks (`persona-professor`)

Follow `personas/professor.md`. Name **1-3 things** worth spending this session on,
ranked, each with a one-line reason tied to what actually matters — a rigor risk, a
blocking open question, scope drift, or a milestone that's both due and under-scoped —
not a copy of `task-board.md`'s "Next session priority" text. If that stated priority
is still the right call, say so plainly and explain why briefly rather than inventing a
different answer just to sound independent. If something `task-board.md` doesn't
mention is more urgent, say that instead.

## Notes

- This is a status ritual, not a work session — don't start executing until the user
  picks a direction.
- If the recap surfaces something wrong in `task-board.md`/`index.md` (stale,
  contradicted by the journal), say so, but don't silently fix it here — that's a
  write, and writes belong to `session-signoff` (or a deliberate correction the user
  asks for mid-session).
- For a full PM schedule read (on-track/at-risk/slipped against every ECD), that's a
  separate ask — invoke `persona-pm` directly. This ritual deliberately doesn't
  duplicate that table every session; it belongs to `session-signoff` instead, where it
  can inform the next session's starting point.
