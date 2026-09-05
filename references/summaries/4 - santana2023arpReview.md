# The Aircraft Recovery Problem: A Systematic Literature Review

- **File:** `references/The Aircraft Recovery Problem A Systematic Literature Review.pdf`
- **Bib key:** `santana2023arpReview`
- **Authors:** Santana, Mateus; De La Vega, Jonathan; Morabito, Reinaldo (corresponding
  author); Pureza, Vitória
- **Year:** 2023
- **Venue:** EURO Journal on Transportation and Logistics, Vol. 12, Article 100117
- **DOI:** 10.1016/j.ejtl.2023.100117

## What it is

A systematic literature review (Federal University of São Carlos, UFSCar; following the
Biolchini et al. 2005 protocol) of 50 journal articles on the Aircraft Recovery Problem
(ARP) — the sub-problem of airline disruption management concerned with
rescheduling/rerouting aircraft (new departure times, cancellations, swaps) after schedule
disruptions — covering studies from the seminal 1984 paper through 2022, classified by
network representation, optimization objectives, practical constraints, and
heuristic/exact solution methods, with identified gaps and future-research directions.

## Why it's valuable — and to what

- Literature review section: §4 (OCC/dispatch/disruption management) — strong direct
  fit; ARP is core disruption-recovery/OCC decision content, and this is a rigorous,
  up-to-date (2023) survey covering 40 years of the sub-topic.
- Decomposition / architecture (§6, §10): indirect — could inform how the "aircraft
  recovery" capability/interface is scoped within an OCC/dispatch domain node, though the
  paper itself is not architecture-focused.
- Stakeholder / objective ontology (§7-9): good fit. The paper repeatedly frames ARP
  objectives as delay-minimization vs. cancellation vs. aircraft-swap tradeoffs and notes
  studies rarely optimize all three simultaneously — a clean, citable example of local
  (per-aircraft/per-flight) objective tension vs. network-level airline objectives, useful
  for the myopic-optimization-conflict narrative.
- Optimization study (§11-13): strong fit — catalogs network representations (connection,
  time-line, time-band networks), MIP/set-partitioning/set-covering formulations, and
  heuristic/exact/metaheuristic solution approaches that could inform how a decision-
  support/optimization capability is modeled inside the architecture.
- Glossary / terminology: ARP (Aircraft Recovery Problem), CRP (Crew Recovery Problem),
  PRP (Passenger Recovery Problem), connection/time-line/time-band network, ferry flight,
  GPOS.

## Rating

**4/5** — Highly relevant, rigorous SLR directly on a named disruption-recovery
sub-problem central to OCC/dispatch modeling, and it usefully illustrates the
local-vs-network objective conflict theme for §7-9. Rated 4 rather than 5 because it's a
narrow OR/optimization-methods survey (matching the project's caution against a pure
optimization deep-dive) rather than a source that directly shapes the trajectory-intent/
enterprise-to-aircraft architecture chain — strong supporting evidence/vocabulary for one
capability area, not a central architectural driver. Selected for deep annotation (§4/§7-9
angle) in the 2026-09-04 literature-review pass.

## Flags

**Not a duplicate** of `hassanDisruptionReview` or `hu2024disruptionOptReview` — those are
broad/umbrella disruption-management reviews spanning aircraft/crew/passenger recovery;
this is a deep-dive specifically on the aircraft-recovery sub-problem, explicitly
positioning itself against Clausen et al. (2010) and Hassan et al. (2021) as narrower and
more solution-method-focused. All bib fields (title, authors, year, venue, article number,
DOI, dates) confirmed directly from the PDF — no unverifiable fields.

## Processing metadata

- **Read depth:** Substantially read (front matter, abstract, intro, SLR methodology,
  §3 intro, and §4 discussion/insights/perspectives fully read; §3's exhaustive
  multi-fleet variant catalog and formal conclusion not read line-by-line but well
  summarized by §4)
- **Date processed:** 2026-09-04
