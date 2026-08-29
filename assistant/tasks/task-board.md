# Task Board

_Cross-session focus state only. The full task checklist lives in
`Project_To-Do List.md` — don't duplicate it here. Update this file per
`assistant/workflows/session-wrap-up.md` at the end of each session._

**Last updated:** 2026-08-29

## Current phase

`Project_To-Do List.md` §1 ("Establish Research Framework") is the active section — the
SOI boundary, research questions, and source register are still being stood up. Sections
§2-§16 are not yet started.

## Active

- Stand up the AI-collaboration scaffold (`assistant/`) — done this session, see
  `assistant/tasks/sessions/2026-08-29-bootstrap-assistant-scaffold.md`.
- Full reference-processing sweep — done this session, see
  `assistant/tasks/sessions/2026-08-29-process-references-full-sweep.md`. All 20 files in
  `references/` now have a bib entry, a summary, and a 0-5 rating in
  `assistant/memory/source-register.md`'s Processing Ledger.
- Resolve the System of Interest boundary questions in
  `assistant/memory/open-questions.md` (§1) — not yet started.

## Blocked

- Several literature sources referenced in `references/references.bib` have no PDF yet
  (see `assistant/memory/source-register.md` "Housekeeping" section) — blocks their
  annotation until located.
- Nominal ATC/IFR flight-execution research (to-do §4) has no identified FAA source
  documents yet.

## Needs a user decision

- Two citation-integrity errors were found and corrected in `references.bib` during the
  reference sweep (wrong authors on the `schultz2017turnaround` and renamed
  `xu2024airlineSchedOpt`/ex-`deng2023airline` entries) — `Project_To-Do List.md`'s §2/§3
  section headers still say the old (wrong) author names; user should decide whether to
  correct those headers too.
- Two exact-duplicate PDF pairs found in `references/` (the two aircraft-engine-inlet
  files, and `de Neufville_Engineering Systems.pdf` vs. the Bartolomei 2011/2012 paper) —
  recommend deleting one file from each pair; not done automatically. See
  `assistant/memory/source-register.md`'s Processing Ledger flags for details.
- Two low-rated sources (rating 1-2) may be candidates to drop from `references/`
  entirely: `de Neufville_Engineering Systems.pdf` (1/5, superseded draft) and the two
  MBSE component-level case studies rated 2/5 (engine inlet, graph-database technique,
  design-ontology preprint) — worth a decision once literature-review sessions start.

## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `assistant/journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and
  open design questions. Not started; no target date.

## Next session priority

Work `Project_To-Do List.md` §1 to closure (finalize research questions, define the SOI
boundary using `assistant/memory/open-questions.md` as the checklist). The source register
is now fully populated and rated, so §2-§4 literature-review sessions can start any time —
prioritize the 5-rated sources first (`eltoukhy2017airline`, `hassanDisruptionReview`,
`schultz2017turnaround`, `clarke1998irregular`, `dispatcherWorkload2025`,
`eurocontrolACDMSpec`).
