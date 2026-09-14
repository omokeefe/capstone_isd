# SESAR eATM ATM Capability Model (Extracted Capability Catalogue)

- **File:** `evidence/sources/SESAR_eATM_ATM_Capabilities.xlsx`
- **Bib key:** `sesarju2025eatmCapabilities`
- **Authors:** SESAR Joint Undertaking (source); extraction compiler not identified in the workbook
- **Year:** 2025 (source catalogue; extraction date not stated)
- **Venue:** SESAR Joint Undertaking / ATM Master Plan online capability catalogue
  (atmmasterplan.eu)
- **DOI:** none (data extraction, not a publication)

## What it is

Not an authored publication — a structured .xlsx extraction of the SESAR/ATM Master Plan's public
ATM capability taxonomy (atmmasterplan.eu/capabilities and
atmmasterplan.eu/rnd/atm-capability-model). Three sheets: a Summary (162 capability nodes: 136
"Operations," 20 "Supporting," 6 "Other/undefined"; max hierarchy depth 2); a Capabilities sheet
(one row per node, with Capability ID, Parent ID, Level, Capability name, Description, Type,
Source Model, Hierarchy Path, and a description-endpoint URL); and a Hierarchy View sheet
(flattened tree). The Summary sheet notes descriptions are truncated where the public catalogue
view truncates them, and states the extraction is intended to support "follow-up extraction and
Cameo mapping."

## Why it's valuable — and to what

- Literature review section: none — a data resource, not literature.
- Decomposition / architecture (§6, §10): a ready-made, hierarchical (3-level) capability taxonomy
  for European ATM (Aerodrome Operations, Airspace Management, etc.) — directly usable as either a
  cross-check for a NAS-side capability decomposition or as source material to import into Cameo
  for a capability-based architecture view, consistent with the note's own stated purpose.
- Stakeholder / objective ontology (§7-§9): capability descriptions occasionally reference the
  responsible actor/system (e.g., "the ability for the Aerodrome to..."), giving light
  stakeholder-attribution cues.
- Optimization study (§11-§13): not directly applicable.
- Glossary / terminology: source of precise SESAR capability names/definitions (e.g., "Runway
  Occupancy Time Management," "Wake Vortex Decay Enhancement") — candidate glossary entries when
  discussing capability-based decomposition.
- Other: complements `sesarju2025masterPlan` as its structured-data counterpart.

## Rating

**3/5** — Useful background/data resource: a clean, structured, directly Cameo-importable
capability taxonomy, but it is an extracted dataset rather than an analyzed or argued source, and
several descriptions are truncated at the source — capping its standalone rating below the
core-architecture tier.

## Flags

- **Not an authored publication.** This is a data extraction (apparently made by the user/project
  team, not sourced from a formal SESAR publication) from a public website; bib entry uses `@misc`
  with the SESAR Joint Undertaking as the data owner, per the workflow's guidance to still record
  it in the bibliography.
- **Descriptions truncated at source** — the workbook's own Summary sheet warns that descriptions
  ending in "?" are cut off by the public catalogue view; verify against the live
  atmmasterplan.eu/capabilities site or a fuller SESAR capability document before using truncated
  descriptions verbatim.
- No duplicates found; complements `sesarju2025masterPlan` (the 2025 Master Plan narrative
  document) as its structured-data counterpart.

## Processing metadata

- **Read depth:** fully read (all three sheets inspected: Summary in full, Capabilities and
  Hierarchy View sampled via header row + first several data rows, sufficient to characterize
  structure and scope for triage)
- **Date processed:** 2026-09-13
