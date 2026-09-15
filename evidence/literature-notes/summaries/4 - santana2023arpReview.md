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

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (0 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "The aircraft recovery problem (ARP) consists of recovering the flight schedules lost due to such events, determining new flight departure times and possible flight cancellations, as well as revising routes for different aircraft"
- **Highlight:** "2023"
- **Highlight:** "An air operator is a legal entity that transports people or cargo between two different airports, i.e., areas intended for landing, take- off and aircraft movement (IAC 1223, 2000)."
- **Highlight:** "in the United States in 2018, costs resulting from such delays were estimated to have reached US$28 billion, according to the Federal Aviation Administration (FAA) (Airlines For America, 2018)"
- **Highlight:** "Ground delays greater than 60 min increased from 2.9% to 4.2%"
- **Highlight:** "February 2017 and February 2018"
- **Highlight:** "The main cause of such delays was bad weather conditions"
- **Highlight:** "several decisions must be taken so that such flights are rescheduled with minimal loss to airlines and discomfort for their users"
- **Highlight:** "airline recovery problem. This problem consists of three other sub-problems: the crew recovery problem (CRP), which essentially deals with the recovery of the crew’s scale; the passenger recovery problem (PRP), which addresses the recovery of passenger itineraries; and the aircraft recovery problem (ARP), which aims to determine new departure times for flights, as well as possible flight cancellations, and review routes for different aircraft."

**Page 2**
- **Highlight:** "the ARP consists of determining which flights to delay or cancel, and reassigning available aircraft to the flights in order to minimize the undesirable consequences of disruptions. Aircraft unavailability and failures and airport service disturbances are usually the main causes of flight disruptions"
- **Highlight:** "In their reviews, Clausen et al. (2010) and Hassan et al. (2021) compared studies in the literature on airline disruption management regarding the network representations, mathematical modeling and solution methods used"

## Processing metadata

- **Read depth:** Substantially read (front matter, abstract, intro, SLR methodology,
  §3 intro, and §4 discussion/insights/perspectives fully read; §3's exhaustive
  multi-fleet variant catalog and formal conclusion not read line-by-line but well
  summarized by §4)
- **Date processed:** 2026-09-04
