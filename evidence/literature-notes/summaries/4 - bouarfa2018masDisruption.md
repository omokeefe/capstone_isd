# Evaluation of a Multi-Agent System Approach to Airline Disruption Management

- **File:** `evidence/sources/Evaluation of a Multi-Agent System approach to airline disruption management.pdf`
- **Bib key:** `bouarfa2018masDisruption`
- **Authors:** Bouarfa, Soufiane; Müller, Jasper; Blom, Henk A. P.
- **Year:** 2018
- **Venue:** Journal of Air Transport Management, Vol. 71, pp. 108-118 (Elsevier)
- **DOI:** 10.1016/j.jairtraman.2018.05.009

## What it is

A journal article (Delft University of Technology) that evaluates Castro's (2013)
MASDIMA — a Multi-Agent System approach to AOC disruption management — on a
challenging benchmark disruption scenario, comparing its performance and coordination
technique usage against four human-team-based AOC coordination policies from a companion
prior study (Bouarfa et al. 2016). Also conducts an expert-based evaluation of the human
AOC tasks/workload that remain (or increase) once MASDIMA automates the aircraft, crew,
and passenger management roles.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) —
  complements the existing disruption-management cluster (`hassanDisruptionReview`,
  `clarke1998irregular`, `hu2024disruptionOptReview`, `santana2023arpReview`,
  `dispatcherWorkload2025`) with a direct MAS-vs-human-team performance comparison.
- Decomposition / architecture (§6, §10): secondary support to `castro2013aoccMasThesis`
  — shows the MASDIMA agent architecture (Fig. 3/4: aircraft/crew/passenger
  managers + supervisor) applied to a concrete scenario, useful as a worked example.
- Stakeholder / objective ontology (§7-9): the expert-based workload evaluation (§6 of
  the paper) is directly relevant — it identifies which human roles gain/lose workload
  when automation replaces AOC teams, and flags stakeholder-level tradeoffs (loss of
  human experience/flexibility, supervisor workload concentration) that a
  myopic-optimization-vs-system-level framing should account for.
- Other: informs a possible open question about automation/human-role tradeoffs in the
  OCC domain, relevant to any ConOps discussion of how much of trajectory-intent
  propagation should be automated vs. human-mediated.

## Rating

**4/5** — strong supporting evidence with a concrete performance benchmark and a
human-factors angle that `castro2013aoccMasThesis` (the primary source) doesn't cover in
as much depth, but it's a follow-on evaluation rather than the originating architecture.

## Flags

- Companion to `castro2013aoccMasThesis` — not a duplicate; the thesis originates
  MASDIMA, this paper is a later third-party-style benchmark/evaluation of it (same
  research group, TU Delft, building on Castro's TAP Portugal work).
- No ambiguity in bibliographic metadata — DOI, volume, and pages confirmed directly from
  the PDF's first page.

## Processing metadata

- **Read depth:** fully read (all 10 pages, including all figures/tables)
- **Date processed:** 2026-09-13
