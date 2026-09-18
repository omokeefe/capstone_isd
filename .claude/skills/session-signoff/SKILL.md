---
name: session-signoff
description: End-of-session ritual — appends a Sign-Off entry to today's daily journal (creating it if needed) summarizing what was worked on, runs a PM persona status check, and closes with 1-3 concrete next steps; also updates task-board.md tersely and confirms to-do-list.md checkboxes match reality. Use at the end of a session or when the user says they're done for now.
---

Follow `workflows/session-signoff.md` exactly: append a `## HH:MM — Sign-Off` entry to
`projects/nas-sos-capstone/journal/YYYY-MM-DD.md` (create the file with a
`# Journal — YYYY-MM-DD` header if it doesn't exist yet) summarizing what was worked on
and what changed, run `persona-pm`'s compact status check in the same entry, close with
1-3 concrete next steps, then update `projects/nas-sos-capstone/task-board.md` tersely
(bullets pointing at the journal entry, not re-explained prose), confirm
`projects/nas-sos-capstone/to-do-list.md` checkboxes reflect reality, and sweep for
knowledge/evidence/decision drift.
