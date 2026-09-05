# Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis

- **File:** `references/Proactive Aircraft Turnaround Buffer Optimization Integrating Machine Learning and Scenario Analysis.pdf`
  (renamed from the truncated on-disk filename "roactive Aircraft Turnaround..." during
  processing — see Flags)
- **Bib key:** `kontodimou2026turnaroundBuffer`
- **Authors:** Kontodimou, Konstantia (corresponding); Peteinatos, Dionysios; Bagioneta,
  Stavroula; Kepaptsoglou, Konstantinos
- **Year:** 2026
- **Venue:** Journal of the Air Transport Research Society, Vol. 6, Article 100117
- **DOI:** 10.1016/j.jatrs.2026.100117

## What it is

A journal article (National Technical University of Athens / West Virginia University)
proposing a predictive-prescriptive decision-support framework for airline turnaround
buffer allocation: an XGBoost regression model predicts flight-level propagated arrival
delay from historical BTS operational + weather data, residual-based scenario generation
captures prediction uncertainty, and a stochastic mixed-integer linear program (MILP)
allocates a limited system-wide buffer-minute budget across flights to minimize buffer
cost, expected delay cost, and an APU-emissions environmental proxy. Validated on real
January 2025 BTS data across four U.S. carriers and three aircraft types (217 daily
airline/fleet instances); best policy achieves 37.1% delay reduction vs. zero-buffer.

## Why it's valuable — and to what

- Literature review section: §3 (turnaround/day-of-ops) — direct fit, a good addition
  alongside `schultz2017turnaround` and `lu2025digitalTwinTurnaround`.
- Decomposition / architecture (§6, §10): weak/indirect — essentially no
  systems-architecture or interface framing of its own, but useful as an example of a
  bounded capability with declared upstream/downstream interface assumptions (schedule,
  fleet assignment, crew, maintenance held fixed).
- Stakeholder / objective ontology (§7-9): notably relevant. The paper is an explicit,
  self-declared example of bounded/myopic optimization — it deliberately fixes aircraft
  routing, fleet assignment, crew duty, maintenance, and passenger connectivity as
  "upstream constraints" and optimizes only the single decision layer of buffer-minute
  allocation, flagging this itself as a limitation. A clean, citable case study of the
  single-turn (local/tactical) vs. network-wide (system-level) optimization tradeoff for
  §9.
- Optimization study (§11-13): strong methodological reference — a clean template for a
  predictive-prescriptive pattern (ML forecast → scenario generation → stochastic MILP)
  and its sensitivity-analysis approach (scenario count, budget saturation, cost-parameter
  heatmaps).
- Glossary / terminology: predictive-prescriptive analytics, scenario-based (stochastic)
  optimization, buffer budget/turnaround buffer allocation.

## Rating

**3/5** — Solid, rigorous OR/ML methodology paper with a genuinely useful worked example
of a bounded, single-layer optimization capability and its declared interfaces to
upstream/downstream decisions — valuable for §7-9's myopic-optimization discussion and as
a methodological template for §11-13. Carries essentially no systems/architecture framing
of its own (no stakeholder analysis, no SoS decomposition, no interface modeling) per the
capstone's "architecture over pure optimization" emphasis — cite for methodology and as a
conflict-of-objectives illustration, not likely to be a central/authoritative source.

## Flags

**Filename corrected** — on-disk name was truncated ("roactive Aircraft Turnaround...");
renamed to the verified title during this processing sweep. Complementary to (not a
duplicate of) `lu2025digitalTwinTurnaround` — that paper is real-time/reactive digital-twin
automation, this one is pre-operational predictive-prescriptive planning; the paper's own
introduction explicitly contrasts itself against the digital-twin/automation literature on
exactly this basis. All bib fields confirmed directly from the PDF.

## Processing metadata

- **Read depth:** Fully read (all 10 pages)
- **Date processed:** 2026-09-04
