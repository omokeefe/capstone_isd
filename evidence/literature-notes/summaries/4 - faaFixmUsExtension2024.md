# Flight Information Exchange Model (FIXM) US Extension v4.4.0: Logical Model Diagrams

- **File:** `evidence/sources/FIXM_US_Extension_v4.4.0_Logical_Model_Diagrams.pdf`
- **Bib key:** `faaFixmUsExtension2024`
- **Authors:** Federal Aviation Administration / FIXM Program (institutional; no individual byline
  in the document)
- **Year:** 2024 (approximate — not stated in the document itself; see Flags)
- **Venue:** FAA / FIXM Program (institutional technical report)
- **DOI:** none found

## What it is

Not a narrative document — an auto-generated UML/XSD logical-model diagram report for the FAA's
US national extension to the international Flight Information Exchange Model (FIXM) standard.
Each page is a class diagram for one logical grouping of the flight-data model (e.g.,
`NasAircraft`, `NasAirspace`, `NasAltitude`), showing complex types, enumerations, attributes, and
associations/multiplicities.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background — more precisely, a data-standard
  reference rather than literature.
- Decomposition / architecture (§6, §10): this is the FAA's authoritative logical data model for
  how flight information (aircraft identity, route/airspace structures, altitude/level
  representations) is exchanged between NAS systems — i.e., the concrete schema underlying
  "trajectory-intent" data as it actually propagates across FAA systems (SWIM, TFMS, etc.). Highly
  relevant as a grounding reference for how the capstone's architecture should represent flight
  intent data structures.
- Stakeholder / objective ontology (§7-§9): not directly applicable.
- Optimization study (§11-§13): not directly applicable.
- Glossary / terminology: candidate source for precise definitions of NAS-specific flight-data
  terms (e.g., `TfmsAircraftCategory`, `WakeTurbulenceCategoryExtended`, `NasLevelChoice`).
- Other: complements `mitreFAADataStandards` (2001 MITRE paper on the FAA Data Standards
  Initiative) as a much more current, concrete instantiation of FAA flight-data standardization.

## Rating

**4/5** — Strong supporting: authoritative and directly on-topic for the trajectory-intent data
model, but it is a diagram export with no analytical or narrative content, so it functions as a
reference/schema resource rather than an argued source — capping it below a 5.

## Flags

- **Authorship/year not confirmed on the pages read.** The document has no title-page byline
  beyond "FIXM" branding and no explicit publication date; FIXM is a joint effort involving FAA,
  EUROCONTROL, and ICAO, with "US Extension" being the FAA-specific layer. Web search confirmed
  FIXM v4.3.0 was released in 2023 (per FAA ATIEC conference materials); v4.4.0's exact release
  date was not found and is inferred as ~2024 — **verify against fixm.aero before citing
  precisely.**
- Not a duplicate of any registered source; no comparable FIXM-schema reference exists in the
  register yet.

## Processing metadata

- **Read depth:** skimmed (8 of ~50+ pages — sampled diagram pages sufficient to characterize
  content and scope for triage; not read page-by-page)
- **Date processed:** 2026-09-13
