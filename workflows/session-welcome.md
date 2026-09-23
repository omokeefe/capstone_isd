# Workflow: Session Welcome

Run at the start of a session — a reasonable default opener unless the session is
already mid-task. Produces a spoken recap and a short focus recommendation, and logs
that same context to today's journal entry (Step 4). It still writes nothing to
`task-board.md`, `to-do-list.md`, or `open-questions.md` — those state changes still
belong to `session-signoff`, keeping "what to do next" living in exactly one place
instead of being re-derived and re-written at both ends of a session.

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

## Step 4 — Log the welcome context to the journal

Open `projects/nas-sos-capstone/journal/YYYY-MM-DD.md` (today's date, from the system
clock). Create it with a `# Journal — YYYY-MM-DD` header if it doesn't exist yet; if it
exists, append rather than overwrite anything already there.

Append a `## HH:MM — Welcome` entry (real wall-clock time, not a guess) with:

- **Recap** — the same two-or-three-bullet state-of-things from Step 2, compressed
  further if needed; this is a log entry, not a repeat of the full spoken recap.
- **Focus picks** — the Professor's 1-3 ranked items from Step 3, with their one-line
  reasons.

Keep this entry short — it's a record of what the session opened with, not new
analysis. Don't touch `task-board.md`, `to-do-list.md`, or `open-questions.md` here;
those stay `session-signoff`'s job.

## Notes

- This is a status ritual, not a work session — don't start executing until the user
  picks a direction.
- If the recap surfaces something wrong in `task-board.md`/`index.md` (stale,
  contradicted by the journal), say so, but don't silently fix it here beyond the Step 4
  log — correcting `task-board.md`/`index.md` themselves belongs to `session-signoff`
  (or a deliberate correction the user asks for mid-session).
- For a full PM schedule read (on-track/at-risk/slipped against every ECD), that's a
  separate ask — invoke `persona-pm` directly. This ritual deliberately doesn't
  duplicate that table every session; it belongs to `session-signoff` instead, where it
  can inform the next session's starting point.
