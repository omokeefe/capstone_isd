# FAA Data Standards Initiative: Systems Engineering Base for Air Traffic Modernization

- **File:** `references/FAA_data_standards_initiative_systems_engineering_base_for_air_traffic_modernization.pdf`
- **Bib key:** `mitreFAADataStandards`
- **Authors:** Bolczak, Katie; Broste, Nels; Rhoades, Ron; Schwarz, Ron (MITRE Corporation); Uri, Carol (FAA)
- **Year:** 2001
- **Venue:** IEEE conference paper, likely 20th Digital Avionics Systems Conference (DASC), paper 7.F.2-1
- **DOI:** none found — pre-DOI-era IEEE Xplore paper

## What it is

Describes the FAA's early-2000s effort to standardize data exchanged among National
Airspace System (NAS) systems, motivated by the finding that the same information (e.g. a
flight's position) was named and represented inconsistently across systems, causing
integration cost and ambiguity. Proposes a metadata-registry-based approach (ISO/IEC 11179)
for defining NAS data standards.

## Why it's valuable — and to what

- Literature review section: none of §2-§4 directly / background for the NAS information
  architecture itself.
- Decomposition / architecture (§6, §10): directly supports the "Information Services"
  domain in `assistant/memory/project-brief.md`'s candidate decomposition — this is a
  primary-source justification for why information-object standardization is a first-class
  architecture concern, not an afterthought.
- Stakeholder / objective ontology (§7-§9): identifies the FAA's Information Architecture
  Committee and configuration-control board as decision authorities over NAS data
  standards — relevant to the RACCI work in §7.
- Glossary / terminology: NAS Configuration Control Board (CCB), NAS Information
  Architecture Committee (NIAC), data standard vs. metadata.

## Rating

**4/5** — strong supporting evidence for treating information exchange/ownership as a
first-class architecture element (this capstone's stated differentiator per
`project-brief.md`'s working assumptions), though it's dated (2001) and pre-dates current
NAS System Wide Information Management (SWIM) architecture — worth pairing with a more
current FAA data-architecture source if one turns up.

## Flags

Title corrected from "...Air Traffic Management" to "...Air Traffic Modernization" to
match the PDF exactly. Publication venue (DASC 2001) is inferred from the paper numbering
convention and IEEE copyright line, not explicitly stated on the pages read — low
confidence on the exact conference name.

## Processing metadata

- **Read depth:** skimmed (pages 1-2, intro + background)
- **Date processed:** 2026-08-29
