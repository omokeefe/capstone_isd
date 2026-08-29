# EUROCONTROL Specification for Airport Collaborative Decision Making (A-CDM)

- **File:** `references/eurocontrol-specification-for-acdm.pdf`
- **Bib key:** `eurocontrolACDMSpec`
- **Authors:** EUROCONTROL (NM Airport CDM Team, Standardisation Team)
- **Year:** 2025 (Edition 1.0, edition date 30 January 2025)
- **Venue:** EUROCONTROL Specification, Reference nr. EUROCONTROL-SPEC-198, ISBN 978-2-87497-130-3
- **DOI:** none — regulatory/technical specification, not an academic paper

## What it is

The current, formally-approved EUROCONTROL specification defining Airport Collaborative
Decision Making (A-CDM): the operational milestones, information objects, and stakeholder
responsibilities that let airports, airlines, ANSPs, and network management share timing
and status information about a flight's turnaround, from initial planning through
departure.

## Why it's valuable — and to what

- Literature review section: `Project_To-Do List.md` §3 ("EUROCONTROL Airport
  Collaborative Decision Making Specification") — this is the exact primary source that
  section's checklist is built around (actors, systems, operational milestones, information
  objects, producer/consumer of each, decision authority, target/estimated/actual times).
- Decomposition / architecture (§6, §10): milestones map directly to SysML events/states/
  activities per the to-do list's own instruction; information exchanges map to IBD item
  flows.
- Stakeholder / objective ontology (§7-§9): defines authority and information-sharing
  obligations across network ATM, airport, and airline interfaces — directly usable for the
  RACCI matrix and authority-transition analysis in §7.
- Glossary / terminology: A-CDM, milestone approach (target/estimated/actual times),
  Network Manager (NM).

## Rating

**5/5** — core, primary, current (2025 edition) regulatory specification for the
turnaround/CDM portion of the ConOps; about as authoritative a source as this literature
review will find.

## Flags

None — this is the current released edition (1.0, 30 Jan 2025); worth noting the separate
`eurocontrolACDMManual` (A-CDM Implementation Manual) bib entry still has no PDF in
`references/` — chase that down next, since the to-do list wants both the formal spec and
the practical implementation manual compared.

## Processing metadata

- **Read depth:** skimmed (pages 1-3, cover + document characteristics + change record)
- **Date processed:** 2026-08-29
