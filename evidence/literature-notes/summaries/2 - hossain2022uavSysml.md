# Modeling and Analysis of Unmanned Aerial Vehicle System Leveraging Systems Modeling Language (SysML)

- **File:** `evidence/sources/Article Modeling and Analysis of Unmanned Aerial Vehicle System Leveraging Systems Modeling Language (SysML).pdf`
- **Bib key:** `hossain2022uavSysml`
- **Authors:** Hossain, Niamat Ullah Ibne; Lutfi, Mostafa; Ahmed, Ifaz; Akundi, Aditya; Cobb, Daniel
- **Year:** 2022
- **Venue:** Systems (MDPI), vol. 10, no. 6, article 264
- **DOI:** 10.3390/systems10060264

## What it is

A primary MBSE methodology study: applies the Magic Grid methodology to model a UAV system
(air vehicle, GCS, mission planning/control station, payload, comms, navigation, launch/recovery)
across SysML's four pillars (structure, behavior, requirements, parametric), then demonstrates
interoperability between the SysML model and external simulation/optimization tools (MATLAB,
OpenMDAO) to verify a functional requirement.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background
- Decomposition / architecture (§6, §10): illustrates a concrete SysML four-pillar decomposition
  pattern (structural, behavioral, requirements, parametric views) that could inform how the NAS
  SoS architecture organizes its own SysML views, though the UAV domain itself is not part of this
  capstone's scope.
- Stakeholder / objective ontology (§7-§9): not directly applicable.
- Optimization study (§11-§13): demonstrates SysML-to-MATLAB/OpenMDAO tool coupling for
  parametric verification — a pattern relevant if the capstone's optimization capability needs to
  interface with the Cameo model.
- Glossary / terminology: reinforces "Magic Grid" as an MBSE methodology term.
- Other: none.

## Rating

**2/5** — Solid, well-executed MBSE/SysML demonstration but on UAVs, not NAS/ATM; useful only as
generic methodology precedent for SysML-to-external-tool integration, similar tier to
`luDesignOntologyMBSE2020` and `jagtap2025mbseEngineInlet`.

## Flags

No duplicates found. Not a direct overlap with any registered MBSE-cluster source (closest is
`lupp2026reactMbseMdo`, which combines MDO+MBSE but for a different domain/tool chain).

## Processing metadata

- **Read depth:** fully read (title/intro/lit-review table, implications, conclusions, references)
- **Date processed:** 2026-09-13
