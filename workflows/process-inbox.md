# Workflow: Process Inbox

A lightweight triage pass over `inbox/` — distinct from `workflows/process-references.md`
(which is for independent, comprehensive sources: a full paper with a bib entry, rating,
and summary). This workflow is for the small, informal things that don't warrant that
machinery: a pasted web excerpt, a half-formed idea, a note from a conversation.

## When to run this

Whenever the user asks to "process the inbox" / "clear the inbox," or as a light check
during `workflows/session-wrap-up.md` if `inbox/` is non-empty. Not a required step every
session — an untriaged inbox item is not a failure state.

## Steps

1. List what's actually in `inbox/`. If it's empty, say so and stop.
2. For each item, read it and decide which of these it actually is:
   - **A literature source in disguise** (someone pasted in a paper excerpt or a link to
     one) — redirect it to `workflows/process-references.md` instead of processing it
     here.
   - **A durable concept or term** — fold it into `knowledge/concepts/glossary.md`.
   - **A contestable/reusable claim** — flag it as a candidate for
     `knowledge/claims/README.md`'s process (state it in the user's own words first, per
     that file's cognitive-value rule) rather than writing the claim note yourself.
   - **A model detail** (a new stakeholder, system, scenario, or interface) — add it to
     the relevant file under `knowledge/models/`.
   - **A decision that was actually already made** — add an entry to
     `decisions/decisions-log.md`.
   - **An open question** — add it to `knowledge/questions/open-questions.md`.
   - **Project-specific and not durable** (a to-do reminder, a task-board item) — fold it
     into `projects/nas-sos-capstone/task-board.md` or check off/annotate the relevant
     `to-do-list.md` item.
   - **Turned out not to matter** — delete it. Don't leave stale captures around just
     because deleting feels wrong.
3. Once an item is filed, remove it from `inbox/` — the inbox is a holding area, not a
   permanent archive of its own.
4. If more than a few items needed the same kind of judgment call (e.g., several are all
   candidate glossary terms), it's fine to batch them into one pass rather than filing
   one at a time.

## Notes

- Don't force every capture into an existing note type. If something is genuinely just an
  interesting tangent with no home yet, it's fine to leave it in `inbox/` a while longer
  rather than inventing a place for it.
- This workflow should stay fast — a few minutes per item, not a research session. If an
  inbox item turns out to need real investigation, that's a sign it should become a
  proper task (`to-do-list.md` item or `task-board.md` entry), not something resolved
  inline here.
