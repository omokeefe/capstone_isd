# D5.1: Report on ATM Avionic System Architecture Development

- **File:** `evidence/sources/GreAT_D5.1-ATM-avionic-system-architecture-development_VF.pdf`
- **Bib key:** `great2021d51avionicsArch`
- **Authors:** Hu, Haoliang (CARERI) et al. (CARERI-led, GreAT consortium — full author list in
  bib entry)
- **Year:** 2021
- **Venue:** GreAT (Greener Air Traffic Operations) Project deliverable, EU Horizon 2020 / China
  RIA, Grant Agreement 875154 (V1.00, 31/08/2021)
- **DOI:** none (institutional project deliverable)

## What it is

A primary EU-China Horizon 2020 project deliverable (technical report). Takes the airborne
avionics system as its research object; per the "greener operation" concept, extracts the
functions the aircraft undertakes during pre-cruise, cruise, and post-cruise flight stages
(scenario overview, stakeholders, activity analysis for each), then extracts and allocates
functional requirements (for level change and for conflict detection/alarm) down to the avionics
system-component level, deriving a functional architecture framework for future avionics
development.

## Why it's valuable — and to what

- Literature review section: none / directly an architecture source.
- Decomposition / architecture (§6, §10): extends the D2.1/D2.2 operational-and-system-architecture
  chain down to the aircraft avionics level — i.e., it traces trajectory-intent (greener-cruise
  operation) all the way from ATM-level concept through to the avionics functions that execute it
  on the aircraft. This is directly the "down to aircraft trajectory and behavior" end of this
  capstone's stated scope (per the CLAUDE.md framing).
- Stakeholder / objective ontology (§7-§9): includes explicit stakeholder-involved analysis for
  each flight stage (pre-cruise, cruise, post-cruise).
- Optimization study (§11-§13): not directly an optimization study, but the level-change and
  conflict-detection functional requirements it derives are natural inputs to trajectory
  optimization framing.
- Glossary / terminology: avionics-level functional-architecture terminology (level change,
  conflict detection and alarm, function allocation).

## Rating

**4/5** — Strong supporting: directly extends the core D2.1/D2.2 architecture chain to the
avionics/aircraft level (the capstone's other scope endpoint), but is narrower in ambition than
D2.2 (avionics functions only, not full system architecture) and, like the other GreAT
deliverables, not yet deeply read on this triage pass.

## Flags

No duplicates. Complementary to `great2020d21tboConcept` and `great2021d22operationalArch` — the
three GreAT deliverables form one concept -> architecture -> avionics progression, not overlapping
volumes.

## Processing metadata

- **Read depth:** skimmed (front matter, executive summary, and table of contents read in full;
  body chapters not read in depth on this triage pass)
- **Date processed:** 2026-09-13
