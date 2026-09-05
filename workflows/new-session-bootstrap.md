# Workflow: New Session Bootstrap

Run this at the start of any new AI session on this project — a fresh Claude Code
session, a new ChatGPT thread, a new Copilot chat, whatever. The goal is to reload
working context in under a couple minutes instead of re-deriving it from the whole repo.

## Steps

1. Read, in order:
   - `projects/nas-sos-capstone/index.md` — what this project is and where it stands.
   - `projects/nas-sos-capstone/task-board.md` — what's actively being worked, blocked,
     or next.
   - `knowledge/questions/open-questions.md` — anything unresolved that might bear on
     the task at hand.
2. If the task involves a specific area, also read the matching file:
   - Literature/sources -> `evidence/source-register.md`
   - Stakeholders/objectives -> `knowledge/models/stakeholder-register.md`
   - Terminology confusion -> `knowledge/concepts/glossary.md`
   - "Why did we decide X?" -> `decisions/decisions-log.md`
3. Skim the last 2-3 entries in `projects/nas-sos-capstone/sessions/` (most recent files
   by date) to see what just happened and avoid repeating or contradicting it.
4. State back, briefly, what you understand the current focus to be, before starting
   work — this is a cheap way to catch a stale or misread task-board entry early.
5. Proceed to the task using the matching workflow file in `workflows/`.

## When context is tight (portable-tool version)

If you're in a tool without full repo access (e.g. pasting into a plain chat), paste in
`index.md` and `task-board.md` at minimum. Add `glossary.md` if the conversation
will use a lot of domain jargon. Don't paste the entire `to-do-list.md` unless
the task is specifically about re-planning it — it's long and mostly not needed verbatim.
