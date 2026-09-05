# Workflow: Session Wrap-Up

Run this before ending any substantive work session, so the next session (yours, a
different AI tool's, or a human's) doesn't have to reconstruct what happened.

## Steps

1. Copy `assistant/templates/session-log-template.md` to
   `assistant/tasks/sessions/YYYY-MM-DD-<short-slug>.md` (use today's date; if this is
   the second session that day, append `-2`, etc.) and fill it in:
   - What was worked on and why.
   - What changed (files touched, decisions made, boxes checked).
   - What's blocked, and why.
   - What the natural next step is.
2. Update `assistant/tasks/task-board.md`:
   - Move completed focus items off "active."
   - Add any new blockers.
   - Set the next-session priority if it's obvious from this session's ending point.
3. Sweep for memory drift — if anything discovered this session makes a memory file
   wrong or stale, fix it now rather than leaving a note to "update later":
   - Scope/direction changed? -> `assistant/memory/project-brief.md`
   - Decision made? -> `assistant/memory/decisions-log.md`
   - Question resolved? -> remove it from `assistant/memory/open-questions.md`
   - Question raised? -> add it there
   - Source annotated? -> `assistant/memory/source-register.md`
4. Confirm `Project_To-Do List.md` checkboxes reflect reality — don't leave a box
   unchecked if the work is genuinely done, and don't check one off for partial work.
5. If step 3 changed the current phase, a decision, an open question, next actions, or
   people/systems involved, check whether `PROJECT_CONTEXT.md`'s corresponding bullet is
   now stale and update it — it should stay a short, current pointer, not drift from the
   files it links to.
6. If working in git, review the diff before it's committed (or ask the user to) —
   memory/task files are content, not code, but they still deserve a real look before
   being saved, same as any other change.

## Notes

- A short, honest log beats a polished one. "Spent an hour, made little progress,
  blocked on X" is a genuinely useful entry — don't skip logging just because the
  session didn't produce much.
