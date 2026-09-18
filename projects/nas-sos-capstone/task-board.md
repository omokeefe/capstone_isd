# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-09-17 (see `journal/2026-09-17.md` 21:24 Sign-Off for reasoning)

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

- Drafted a candidate §5 ConOps scenario ("Hub-to-Hub Trajectory Cost vs. Sector
  Workload Tradeoff") in `../../knowledge/models/conops-scenarios.md` and a full
  phase-by-phase elaboration in
  `../../knowledge/models/conops-hub-to-hub-trajectory-cost.md`. Not yet reviewed by the
  user — see `journal/2026-09-17.md` (20:37, 20:49, 21:09 entries) for the reasoning and
  open issues (city pair, background-bank size, monetization placeholders unset).

- New: `session-welcome`/`session-signoff` skills replace the old
  `session-bootstrap`/`session-tagup`/`session-wrap-up` skills — session narrative now
  lives in the daily journal instead of `sessions/`. See `journal/2026-09-17.md` (21:24
  Sign-Off) for what changed. Unexercised so far; watch for rough edges.


## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and open
  design questions. Partially addressed by the 2026-09-05 reorg (workflows/personas/
  templates are now workspace-level, ready to be reused if a second project starts) —
  revisit whether a separate portable template folder is still wanted, or whether "reuse
  this repo's structure" is now sufficient. No target date.

## Next session priority

See `journal/2026-09-17.md` (21:24 Sign-Off) for full reasoning. Terse version:

1. Review/rewrite the six AI-drafted `02_introduction.tex` subsections (including
   further uncommitted manual edits since 2026-09-14) into the user's own judgment;
   ratify the SOI boundary as part of that pass.
2. Resolve LaTeX-to-Word conversion, compile, send the adviser copy, complete the
   Canvas Progress Status Update #1.
3. Try `session-welcome` next session and flag anything off about it.

**After the interim report:** work `to-do-list.md` §1 to closure for real, then start
§2-§4 literature-review sessions prioritizing the 5-rated sources first
(`eltoukhy2017airline`, `hassanDisruptionReview`, `schultz2017turnaround`,
`clarke1998irregular`, `dispatcherWorkload2025`, `eurocontrolACDMSpec`).
