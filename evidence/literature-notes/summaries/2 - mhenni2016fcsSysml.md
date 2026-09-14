# Flight Control System Modeling with SysML to Support Validation, Qualification and Certification

- **File:** `evidence/sources/Flight Control System Modeling with SysML to Support Validation, Qualification and Certification.pdf`
- **Bib key:** `mhenni2016fcsSysml`
- **Authors:** Mhenni, Faida; Choley, Jean-Yves; Nguyen, Nga; Frazza, Christophe
- **Year:** 2016
- **Venue:** IFAC-PapersOnLine, vol. 49-3, pp. 453-458 (13th IFAC/IEEE Conference on Programmable
  Devices and Embedded Systems)
- **DOI:** 10.1016/j.ifacol.2016.07.076

## What it is

A primary MBSE/MBSA (model-based safety analysis) case study. Presents "SafeSysE," a SysML-based
methodology merging system design and safety analysis, applied to an Airbus A380 flight control
system (ailerons, elevators, rudders, spoilers, slats, THS), and compares its structural,
functional, and dysfunctional views against the AltaRica-based safety models used by the French
DGA-TA certification authority for validation, qualification, and certification.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background
- Decomposition / architecture (§6, §10): demonstrates functional breakdown, activity diagrams,
  BDD-based component/functional allocation, and IBD-based failure-propagation modeling for a
  safety-critical aircraft system — a useful pattern reference for functional decomposition and
  allocation matrices, but at the single-aircraft (vehicle) level rather than the NAS-SoS level.
- Stakeholder / objective ontology (§7-§9): touches on the certification-authority relationship
  (DGA-TA / EASA) but not stakeholder objectives broadly.
- Optimization study (§11-§13): not applicable.
- Glossary / terminology: "SafeSysE," zonal/functional/structural/undesired-events views,
  MBSE-MBSA integration terminology.

## Rating

**2/5** — Marginal for this capstone: rigorous and well-executed MBSE+safety-analysis case study,
but it operates at the aircraft/vehicle level (flight control system internals), which is outside
this capstone's NAS-as-SoS scope; useful only as a generic SysML+safety-integration methodology
precedent, similar tier to `jagtap2025mbseEngineInlet`.

## Flags

No duplicates found. Adjacent to but distinct from `jagtap2025mbseEngineInlet` (both are
vehicle/component-level MBSE case studies rather than NAS-level architecture work).

## Processing metadata

- **Read depth:** fully read (6 pages)
- **Date processed:** 2026-09-13
