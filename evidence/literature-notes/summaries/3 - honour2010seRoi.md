# Systems Engineering Return on Investment

- **File:** `evidence/sources/Eric C. Honour - Systems Engineering Return on Investment (University of South Australia).pdf`
- **Bib key:** `honour2010seRoi`
- **Authors:** Honour, Eric C. (University of South Australia / Honourcode, Inc.)
- **Year:** 2010
- **Venue:** INCOSE International Symposium, vol. 20(1), pp. 1422-1439 (Chicago)
- **DOI:** 10.1002/j.2334-5837.2010.tb01150.x

## What it is

An 18-page interim results paper from the author's SE-ROI research programme. It reports structured
interviews with 51 completed programs in 16 organizations and correlates total SE effort (and eight SE
activity categories) against cost overrun, schedule overrun, and perceived success. The method is
statistical correlation, and the author states plainly that it cannot prove causality.

## Why it's valuable — and to what

- Literature review section: none of `to-do-list.md` §2-§4 — this is systems-engineering-practice
  background, not NAS/airline content.
- Decomposition / architecture (§6, §10): indirect only — "system architecting" and "requirements
  engineering" are two of the eight measured activities, with product architecture ranked the SE
  capability most correlated with program success in the Elm et al. survey it summarizes.
- Stakeholder / objective ontology (§7-§9): not applicable.
- Optimization study (§11-§13): not applicable.
- Glossary / terminology: the eight SE activities (mission definition, requirements engineering,
  system architecting, system integration, verification/validation, technical analysis, scope
  management, technical management); "SE Effort" = SE quality x SE cost / actual cost.
- Other: it is the closest thing in `evidence/sources/` to a primary source for the "value of SE"
  claim in `knowledge/models/systems_engineering.md`. Findings that hold: SE effort of ~15-20% of
  program cost is where cost, schedule and success measures are best; SE correlates with cost,
  schedule and perceived success but **not** with technical quality of the product; observed
  optimum values per activity (e.g., V&V 7%, technical analysis 4%, architecting 2.5%).

## Rating

**3/5** — Useful background that backs a cited claim in the SE knowledge note, but tangential to the
NAS-as-SoS storyline; would be cited once, in framing, if at all.

## Flags

- **This is not the 2013 thesis.** `references.bib` already had `honour2013seRoi` (Honour's doctoral
  thesis) as a web/catalogue entry with "PDF not obtained." The file on disk is the 2010 INCOSE
  paper, despite the filename saying "(University of South Australia)". Separate bib entry created;
  the thesis entry was left in place and annotated.
- **The 40% shorter schedule / 30% lower cost / 3.5:1-7:1 ROI figures in
  `knowledge/models/systems_engineering.md` (cited "Honour, 2013") are NOT in this paper**, and are not
  in the 2011 follow-on either (searched both). This paper supports only the ~15-20% optimum and the
  cost/schedule correlation. Either verify against the thesis or re-cite/soften those figures. The
  same knowledge note says SE runs at "approximately 15% of the project cost", which this paper does
  support (15.5% optimum; "between 15% and 20%").
- Sample caveats stated by the author: programs are self-selected from organizations that use formal
  SE; all used traditional (non-Agile) SE; data are proprietary and unavailable; wide scatter
  (R^2 on the order of 5-20% for single-activity charts).
- Same-author, same-programme overlap with `honour2011sizingSE` — a sequel, not a duplicate.

## Processing metadata

- **Read depth:** skimmed (abstract, background, method, conclusions; first ~15 of 18 pages of text)
- **Date processed:** 2026-09-20
