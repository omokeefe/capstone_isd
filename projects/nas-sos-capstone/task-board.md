# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-wrap-up.md` at the end of each session._

**Last updated:** 2026-09-04 (paths updated 2026-09-05 during the PKM reorg; no content
changed otherwise)

## Current phase

`to-do-list.md` §1 ("Establish Research Framework") is the active section — the
SOI boundary, research questions, and source register are still being stood up. Sections
§2-§16 are not yet started.

## Active

- Processed 10 new references added to `../../evidence/sources/` — full triage (bib +
  summary + 0-5 rating) on all 10, plus deep annotation and a cross-source synthesis pass
  on the three highest scorers (`romanideoliveira2026predictiveservices`,
  `yao2026loAltitudeSoSSafety`, `santana2023arpReview`, all rated 4/5). See
  `sessions/2026-09-04-literature-review-new-references.md`. Source register now covers
  29 of 29 files in `../../evidence/sources/` (one duplicate PDF removed 2026-09-05).
- Extracted `prework/Air Transport System Architecture.pdf` into
  `../../knowledge/models/candidate-systems-inventory.md` (systems/tree) and
  `../../knowledge/models/interface-exchange-draft.md` (AMS-centered exchange hub) — both
  draft, both flagged as reconstructed from PDF text extraction rather than a verified
  visual trace; feeds §6/§10 architecture work and the Turnaround phase of
  `conops-scenarios.md`. Not yet reconciled with the architecture or Cameo model.
- Begin ConOps scenario exploration (`../../knowledge/models/conops-scenarios.md`, new
  2026-08-30) — scaffold created, used deliberately to work §1 (SOI boundary, research
  questions) and §5 (ConOps) together; candidate scenarios seeded, none drafted yet.
- Stand up the AI-collaboration scaffold (originally `assistant/`, reorganized 2026-09-05
  into `_system/`/`knowledge/`/`evidence/`/`decisions/`/`projects/`) — done, see
  `sessions/2026-08-29-bootstrap-assistant-scaffold.md` for the original bootstrap.
- Full reference-processing sweep — done this session, see
  `sessions/2026-08-29-process-references-full-sweep.md`. All processed files have a bib
  entry, a summary, and a 0-5 rating in
  `../../evidence/source-register.md`'s Processing Ledger.
- Resolve the System of Interest boundary questions in
  `../../knowledge/questions/open-questions.md` (§1) — not yet started.

## Blocked

- Several literature sources referenced in `../../evidence/sources/references.bib` have
  no PDF yet (see `../../evidence/source-register.md` "Housekeeping" section) — blocks
  their annotation until located.
- Nominal ATC/IFR flight-execution research (to-do §4) has no identified FAA source
  documents yet.

## Needs a user decision

- `jain2011pkm` (Personal Knowledge Management, added 2026-09-04) rated 1/5 — off-topic
  for this register (library-science survey, zero aerospace/MBSE content). Keep in
  `../../evidence/sources/` or remove? See `../../knowledge/questions/open-questions.md`.
- Confirm whether the registered `delaurentis2005sosTransportation` PDF is actually
  "Understanding Transportation as a System-of-Systems Design Problem" or a different
  DeLaurentis 2005 paper (an IEEE SMC SoS-taxonomy paper) — a new source
  (`yao2026loAltitudeSoSSafety`) cites the latter separately, raising the question. See
  `../../knowledge/questions/open-questions.md`.
- Two citation-integrity errors were found and corrected in `references.bib` during the
  reference sweep (wrong authors on the `schultz2017turnaround` and renamed
  `xu2024airlineSchedOpt`/ex-`deng2023airline` entries) — `to-do-list.md`'s §2/§3
  section headers still say the old (wrong) author names; user should decide whether to
  correct those headers too.
- One exact-duplicate PDF pair (the two aircraft-engine-inlet files) was resolved
  2026-09-05 during the PKM reorg — the duplicate copy and its stub summary were removed.
  One remaining pair, `de Neufville_Engineering Systems.pdf` vs. the Bartolomei
  2011/2012 paper, is a draft-vs-published pair (not byte-identical) and was
  deliberately left as two files — still a candidate for a consolidation decision. See
  `../../evidence/source-register.md`'s Processing Ledger flags for details.
- Two low-rated sources (rating 1-2) may be candidates to drop from
  `../../evidence/sources/` entirely: `de Neufville_Engineering Systems.pdf` (1/5,
  superseded draft) and the two MBSE component-level case studies rated 2/5 (engine
  inlet, graph-database technique, design-ontology preprint) — worth a decision once
  literature-review sessions start.

## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and open
  design questions. Partially addressed by the 2026-09-05 reorg (workflows/personas/
  templates are now workspace-level, ready to be reused if a second project starts) —
  revisit whether a separate portable template folder is still wanted, or whether "reuse
  this repo's structure" is now sufficient. No target date.

## Next session priority

Work `to-do-list.md` §1 to closure (finalize research questions, define the SOI
boundary using `../../knowledge/questions/open-questions.md` as the checklist). The
source register is now fully populated and rated, so §2-§4 literature-review sessions can
start any time — prioritize the 5-rated sources first (`eltoukhy2017airline`,
`hassanDisruptionReview`, `schultz2017turnaround`, `clarke1998irregular`,
`dispatcherWorkload2025`, `eurocontrolACDMSpec`).
