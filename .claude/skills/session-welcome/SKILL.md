---
name: session-welcome
description: Start-of-session ritual — silently reloads project context, gives a short plain-language recap of where things stand and what's active, then the Professor persona names 1-3 things worth focusing on this session, and logs that recap + focus picks to today's journal entry. Use at the start of any capstone work session, or when the user asks "where do I stand," wants a recap, or a tag-up.
---

Follow `workflows/session-welcome.md` exactly: a silent context refresh
(`projects/nas-sos-capstone/index.md`, `task-board.md`, `open-questions.md`, the latest
journal entry, plus any topic-specific file the task at hand calls for), a short plain
recap for the user (not a restatement of `task-board.md`'s prose), then
`persona-professor` naming 1-3 focus items for this session with reasons, then a short
`## HH:MM — Welcome` entry appended to today's `projects/nas-sos-capstone/journal/`
file recording that recap and those focus picks. Do not write to `task-board.md`,
`to-do-list.md`, or `open-questions.md` — those state changes still belong to
`session-signoff`. For a full PM schedule table against every ECD, invoke `persona-pm`
directly instead — this skill deliberately doesn't duplicate that.
