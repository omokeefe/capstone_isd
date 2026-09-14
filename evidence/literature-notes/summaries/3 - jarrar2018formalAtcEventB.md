# Formal Modeling of a Complex Adaptive Air Traffic Control System

- **File:** `evidence/sources/Formal modeling of a complex adaptive air traffic control system.pdf`
- **Bib key:** `jarrar2018formalAtcEventB`
- **Authors:** Jarrar, Abdessamad; Balouki, Youssef
- **Year:** 2018
- **Venue:** Complex Adaptive Systems Modeling, vol. 6, article 6
- **DOI:** 10.1186/s40294-018-0056-4

## What it is

A primary formal-methods study. Develops a standard, reusable Event-B model (using the Rodin
platform, with refinement from an abstract to a detailed machine) of an airport ATC system,
covering takeoff/landing scheduling and a minimum-separation alerting mechanism, and reports
mechanized proof statistics (91% of proof obligations discharged automatically).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) — tangential;
  focused on airport surface/runway operations rather than dispatch/OCC.
- Decomposition / architecture (§6, §10): illustrates formal (provably-correct) modeling of ATC
  scheduling logic and safety invariants as a complementary rigor layer to SysML-based
  architecture — relevant if the capstone later wants to discuss formal verification of
  architectural safety properties, but the model itself is single-airport/single-runway scope, not
  a NAS-wide architecture.
- Stakeholder / objective ontology (§7-§9): not directly applicable.
- Optimization study (§11-§13): the scheduling logic (FCFS-based takeoff/landing sequencing) is
  tangentially related to scheduling optimization discussions but is not itself an optimization
  study.
- Glossary / terminology: Event-B, Rodin, refinement-based correct-by-construction modeling —
  candidate methodology-glossary terms if formal methods are discussed alongside MBSE.

## Rating

**3/5** — Useful background: a clean, complementary example of formal-methods rigor applied to
ATC, but narrow in scope (single airport, single runway, no NAS-level integration) and using
Event-B rather than SysML, so it sits outside the capstone's primary MBSE/SysML methodology track.

## Flags

No duplicates found. Complements (does not overlap) `axholt2004atcScenarios` (traffic scenario
testing tool) and the RESCUE/DMAN paper (`maiden2004rescueDman`) — all touch airport-level ATC
systems but from formal-verification, testing-tool, and requirements-engineering angles
respectively.

## Processing metadata

- **Read depth:** fully read (23 pages, including full derivation and proof-result sections)
- **Date processed:** 2026-09-13
