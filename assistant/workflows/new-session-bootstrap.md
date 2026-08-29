# Workflow: New Session Bootstrap

Run this at the start of any new AI session on this project — a fresh Claude Code
session, a new ChatGPT thread, a new Copilot chat, whatever. The goal is to reload
working context in under a couple minutes instead of re-deriving it from the whole repo.

## Steps

1. Read, in order:
   - `assistant/memory/project-brief.md` — what this project is and where it stands.
   - `assistant/tasks/task-board.md` — what's actively being worked, blocked, or next.
   - `assistant/memory/open-questions.md` — anything unresolved that might bear on the
     task at hand.
2. If the task involves a specific area, also read the matching memory file:
   - Literature/sources -> `assistant/memory/source-register.md`
   - Stakeholders/objectives -> `assistant/memory/stakeholder-register.md`
   - Terminology confusion -> `assistant/memory/glossary.md`
   - "Why did we decide X?" -> `assistant/memory/decisions-log.md`
3. Skim the last 2-3 entries in `assistant/tasks/sessions/` (most recent files by date)
   to see what just happened and avoid repeating or contradicting it.
4. State back, briefly, what you understand the current focus to be, before starting
   work — this is a cheap way to catch a stale or misread task-board entry early.
5. Proceed to the task using the matching workflow file in `assistant/workflows/`.

## When context is tight (portable-tool version)

If you're in a tool without full repo access (e.g. pasting into a plain chat), paste in
`project-brief.md` and `task-board.md` at minimum. Add `glossary.md` if the conversation
will use a lot of domain jargon. Don't paste the entire `Project_To-Do List.md` unless
the task is specifically about re-planning it — it's long and mostly not needed verbatim.
