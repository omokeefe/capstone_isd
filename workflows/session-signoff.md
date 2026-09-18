# Workflow: Session Sign-Off

Run at the end of a substantive work session. Produces one durable narrative record —
a daily journal entry — plus the minimum state housekeeping needed for the next
`session-welcome` to read something accurate. This is where "what changed" and "what's
next" get written down; `session-welcome` only ever reads.

Supersedes the old `session-wrap-up` workflow's `sessions/*.md` log file for this
purpose. `projects/nas-sos-capstone/sessions/` remains as historical record from before
2026-09-17 but isn't written to by default going forward — the journal is now the one
place session narrative lives.

## Step 1 — Get today's journal file

Open `projects/nas-sos-capstone/journal/YYYY-MM-DD.md` (today's date, from the system
clock). Create it with a `# Journal — YYYY-MM-DD` header if it doesn't exist yet; if it
exists, append rather than overwrite anything already there.

## Step 2 — Summarize the work

Append a `## HH:MM — Sign-Off` entry (real wall-clock time, e.g. via `date +%H:%M`, not
a guess) with:

- **What was worked on and why** — plain narrative, a few sentences, not a bullet dump
  of file paths.
- **What changed** — files touched, decisions made, boxes checked in `to-do-list.md`,
  facts updated in knowledge/evidence/decisions.
- **What's blocked**, and why, if anything is.

## Step 3 — PM persona status check (`persona-pm`)

Follow `personas/project-manager.md`. In the same journal entry, add a compact status
read: overall verdict, what's due/at-risk in the next 7 days, anything slipped, and a
recommended action for next session. Keep it to the persona's usual compact form — lead
with what's at risk, don't restate the whole to-do list.

## Step 4 — Next steps, and a terse task-board update

Close the journal entry with **1-3 concrete next steps** — the same ground the PM's
recommended action covers, made concrete enough that `session-welcome` can hand them
straight to the professor persona next time.

Then update `projects/nas-sos-capstone/task-board.md`:

- Move completed focus items off "Active."
- Replace "Next session priority" with these next steps as terse bullets, not
  paragraphs — point at the journal entry for the reasoning (e.g. "see journal
  2026-09-17") instead of re-explaining it in `task-board.md` itself.
- Add any new blockers.

## Step 5 — Confirm to-do-list.md and sweep for drift

- Confirm `projects/nas-sos-capstone/to-do-list.md` checkboxes reflect reality — don't
  leave a box unchecked if the work is genuinely done, and don't check one off for
  partial work.
- If anything discovered this session makes a knowledge/evidence/decision file wrong or
  stale, fix it now rather than leaving a note to "update later":
  - Scope/direction changed? -> `projects/nas-sos-capstone/index.md`
  - Decision made? -> `decisions/decisions-log.md`
  - Question resolved? -> remove it from `knowledge/questions/open-questions.md`
  - Question raised? -> add it there
  - Source annotated? -> `evidence/source-register.md`
- If any of the above changed the current phase, a decision, an open question, next
  actions, or people/systems involved, check whether `_system/workspace-map.md`'s
  corresponding bullet is now stale.
- If anything landed in `inbox/` this session, triage what's easy to place now per
  `workflows/process-inbox.md` — don't block sign-off on clearing it entirely.

## Step 6 — Review before committing

If working in git, review the diff before it's committed (or ask the user to) —
journal/task/knowledge files are content, not code, but they still deserve a real look
before being saved, same as any other change.

## Notes

- A short, honest entry beats a polished one. "Spent an hour, made little progress,
  blocked on X" is genuinely useful — don't skip logging just because the session
  didn't produce much.
- Don't duplicate the journal entry's narrative into `task-board.md` — `task-board.md`
  stays terse bullets that point at the journal, never the reverse. This is the actual
  fix for `task-board.md`/`to-do-list.md`/`open-questions.md` blurring together on
  "what to do next": the journal is the one place with reasoning and narrative,
  `task-board.md` is the one place with current-state pointers, `to-do-list.md` is the
  one place with checkboxes, and `open-questions.md` is the one place with unresolved
  questions. If an update doesn't fit one of those descriptions, it's going in the
  wrong file.
