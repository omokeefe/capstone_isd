# Airport Surface Operations: A Holistic Framework for Operations Modeling and Risk Management

- **File:** `evidence/sources/Airport surface operations - A holistic framework for operations modeling and risk management.pdf`
- **Bib key:** `wilke2014airportSurface`
- **Authors:** Wilke, Sabine; Majumdar, Arnab; Ochieng, Washington Y. (Imperial College London)
- **Year:** 2014
- **Venue:** Safety Science, vol. 63, pp. 18-33
- **DOI:** 10.1016/j.ssci.2013.10.015

## What it is

A 16-page primary research article that builds a holistic model of airport surface (manoeuvring-area)
operations in three parts: a Business Process Model of the five stakeholders' tasks (airport operator,
pilot, ATC, ground handling, regulator, plus vehicle/pedestrian drivers), a causal-factor taxonomy from
a reference set of 12 safety databases (airports, airlines, ANSPs, ground handlers, regulators), and a
macroscopic scenario tool for change management. The core argument is that existing surface-safety
work is piecemeal — one occurrence type from one stakeholder's viewpoint — so mitigations are biased.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §3 (turnaround & day-of-operations) — the surface/
  ramp end of the flight, complementing `schultz2017turnaround` and `eurocontrolACDMSpec`.
- Decomposition / architecture (§6, §10): a worked example of decomposing a NAS subsystem by
  stakeholder with explicit interactions (communication is the formal interface; "location" is a
  second, unplanned interface) — a comparable pattern for the SysML surface/airport model.
  Notes the BPMN vs. UML vs. SysML notation choice.
- Stakeholder / objective ontology (§7-§9): **strong.** Its thesis is the local-vs-system problem
  for safety: each stakeholder's analysis is biased by its own viewpoint, and the interactions and
  dependencies between stakeholders are neglected. Concrete dependency chains (ground handling must
  finish before the aircraft can leave; pilot obtains pushback clearance from ATC and relays it to
  the tug driver, while ground handling is only indirectly linked to ATC). Feeds the Airport-operator,
  Ground-handling, Tower/Ground-controller personas and §9.
- Optimization study (§11-§13): not directly applicable.
- Glossary / terminology: manoeuvring area, apron/ramp, V/PD (vehicle/pedestrian drivers), SMS
  (Safety Management System), runway excursion/incursion, FOD.

## Rating

**4/5** — Strong supporting source: rigorous and well-aligned with the stakeholder-interaction theme
and the airport actor set, but safety-scoped and surface-only; not central to the trajectory-intent chain.

## Flags

- Safety-management orientation (SMS, accidents/incidents), not efficiency/throughput — takes the
  airport-side actor structure, not an objective/cost model.
- Data span North America, Europe and Oceania (58-airport survey), but no US-airline data set could
  be obtained for confidentiality reasons — 20 US pilots were interviewed instead, so the US airline
  perspective is second-hand.
- Overlaps thematically with `delaurentis2008airportsSos` (airports in an SoS view) but a different
  angle (operational safety model vs. network/topology).

## Processing metadata

- **Read depth:** skimmed (abstract, intro, background, model outline, discussion, conclusions)
- **Date processed:** 2026-09-20
