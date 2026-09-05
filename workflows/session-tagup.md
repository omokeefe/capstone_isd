# Workflow: Session Tag-Up

A fast, two-voice status ritual for the start of a session — distinct from
`new-session-bootstrap.md` (which silently reloads context for the assistant's own use).
This one produces a short report *for the user*: where the schedule stands, what's due
this week, and one piece of advice on what actually matters to work on next. Run when the
user asks for a "tag-up," "status check," "where do I stand," or similar — and it's a
reasonable default to offer at the start of any session that isn't already mid-task.

## Step 1 — Quick context refresh (silent)

Skim (don't narrate this part): `projects/nas-sos-capstone/index.md`,
`projects/nas-sos-capstone/task-board.md`, and today's date. This is a fast read, not the
full `new-session-bootstrap.md` pass — skip `open-questions.md` and `decisions-log.md`
unless something in the status check below needs them.

## Step 2 — EPM status check (`persona-pm`)

Follow `personas/project-manager.md`. Walk `projects/nas-sos-capstone/to-do-list.md`'s
ECD-tagged sections against today's date and classify each as **done / on track / at
risk / slipped** (definitions in that persona file — "done" requires the stated
verification metric to plausibly be met, not just that the date passed).

Report:

1. **One-line overall verdict** — on track, at risk, or behind — stated plainly first,
   not buried at the end.
2. **What's due or at risk in the next 7 days** — the actual point of this ritual; name
   the specific sections/bullets and their ECDs.
3. **Anything slipped** — passed ECD, not done — named explicitly, not glossed over.
4. **A recommended action for the coming week** — not just a status dump; per the PM
   persona's rule, always close with what to actually do about it.

Keep this compact — a handful of lines, not a restatement of the whole to-do list. If
`to-do-list.md` has no dated sections yet (e.g. dates haven't been assigned), say
so and suggest running the milestone-date assignment first rather than fabricating a
verdict.

## Step 3 — Professor's brief advice (`persona-professor`)

Follow `personas/professor.md`, but keep it short — a few sentences, not a full
critique pass. The point isn't to re-review everything; it's to flag the one thing (or
two, at most) that the schedule view in Step 2 wouldn't catch: a reasoning gap, a
scope/rigor risk, an unresolved open question that's quietly blocking real progress, or a
section that's "on track" by date but under-scoped for what it actually needs to
accomplish. If nothing stands out, it's fine to say the plan looks sound and name what
makes it sound (specific, not generic praise).

## Step 4 — Log it to today's journal

Append the tag-up (both voices, as delivered to the user) to
`projects/nas-sos-capstone/journal/YYYY-MM-DD.md` per
`projects/nas-sos-capstone/journal/README.md`'s format — today's date, a `## HH:MM —
Tag-Up` heading (real wall-clock time, e.g. via `date +%H:%M`, not a guess). If today's
journal file doesn't exist yet, create it with the `# Journal — YYYY-MM-DD` header
first. If it exists, read it and append rather than overwriting earlier entries.

This is a real step, not optional bookkeeping — the journal is what makes tag-ups useful
as a record later (report-writing raw material, or just a log of what was flagged and
when), so don't skip it even though the user only asked to see the report on-screen.

## Notes

- These two voices should read as distinct — the PM reports schedule fact and a
  recommended action; the professor adds one substantive judgment call the PM's
  schedule-only view can't make. Don't blend them into one undifferentiated status
  report.
- This is a status ritual, not a work session — don't start executing on the "what needs
  to get done" items unless the user asks you to after seeing the tag-up.
- If a real schedule change or replan comes out of this (the user decides to re-scope, or
  accepts a slip and moves a date), update `projects/nas-sos-capstone/task-board.md`
  accordingly per the PM persona's own rule.
