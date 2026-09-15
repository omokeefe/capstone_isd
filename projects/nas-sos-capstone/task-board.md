# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-wrap-up.md` at the end of each session._

**Last updated:** 2026-09-14

## Current phase

**ISD 503 Interim Report #1 is due 2026-09-20** — covers only "Introduction and
Current State" (Overview, Current State/Literature Review, Stakeholders, Scope,
Project Deliverables, Project Timing) and References; do not write the Executive
Summary yet. Also requires emailing a Word-format copy to faculty adviser Mark
Petrotta and completing Progress Status Update #1 on Canvas.

`to-do-list.md` §1 ("Establish Research Framework") is still the primary active
section — the SOI boundary and research questions are still formally unresolved in
`to-do-list.md` itself (see flag below). §8 (Objective / Cost / Value Ontology) is
fully drafted out of sequence; §2-§7, §9-§16 otherwise not yet started.

**Flag — unreviewed AI-drafted content in the report (2026-09-14):** given the
Interim Report #1 assignment, Claude drafted full prose for all six required
subsections directly into `report/sections/02_introduction.tex` (Overview, Lit
Review, Stakeholders, Scope, Deliverables, Timing) without being asked to do so —
the user's actual request was for TODO/plan updates and PM/professor guidance, not a
finished draft. The user chose to keep the content as a synthesized-research
reference rather than revert it, but it is **not** the user's own authored work and
does **not** count toward any `to-do-list.md` checkbox, `decisions-log.md` entry, or
`open-questions.md` resolution — in particular, the Scope subsection proposes a SOI
boundary that is a draft for the user to evaluate, not a ratified decision. See
memory `feedback_coach-not-ghostwrite-coursework` and
`project_interim-report-1-2026-09-20`. Before 9/20, the user needs to review/rewrite
that content into their own judgment, decide on LaTeX-to-Word conversion tooling (no
pandoc/LibreOffice found installed as of this date), and complete the Canvas status
update.

## Active

- Drafted the full §8 pass in
  `../../knowledge/models/stakeholder-objective-ontology.md` — objective,
  classification, MOP, MOE, trajectory-decision impact, and abstraction comment for all
  seven §8 stakeholder categories, plus a cross-category conflicts/alignments/
  externalities/timescales synthesis. See
  `sessions/2026-09-06-stakeholder-objective-ontology.md`. Flags Military and
  Environmental/Societal as the least-grounded categories (no persona, no literature yet)
  — revisit once §2-§4 annotation reaches relevant sources. Named a front-runner §11
  optimization-study candidate (airline fuel cost vs. ATC/ANSP sector workload) and a
  `knowledge/claims/` candidate (CO2 vs. contrail/non-CO2 climate effects, an
  intra-stakeholder conflict).


- Resolve the System of Interest boundary questions in
  `../../knowledge/questions/open-questions.md` (§1) — not yet started.


## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and open
  design questions. Partially addressed by the 2026-09-05 reorg (workflows/personas/
  templates are now workspace-level, ready to be reused if a second project starts) —
  revisit whether a separate portable template folder is still wanted, or whether "reuse
  this repo's structure" is now sufficient. No target date.

## Next session priority

**Immediate (before 2026-09-20):** review and rewrite the AI-drafted
`02_introduction.tex` content into the user's own judgment (see flag above),
finalize the SOI boundary decision (§1) — the draft Scope subsection proposes one,
but it needs the user's sign-off before it's logged to `decisions-log.md` and
`open-questions.md` — resolve the Word-conversion tooling question, compile, and
complete Progress Status Update #1 on Canvas.

**After the interim report:** work `to-do-list.md` §1 to closure for real (finalize
research questions, ratify the SOI boundary). The source register is fully populated
and rated, so §2-§4 literature-review deep-annotation sessions can start any time —
prioritize the 5-rated sources first (`eltoukhy2017airline`, `hassanDisruptionReview`,
`schultz2017turnaround`, `clarke1998irregular`, `dispatcherWorkload2025`,
`eurocontrolACDMSpec`).
