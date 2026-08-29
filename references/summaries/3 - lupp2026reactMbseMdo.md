# A Theoretical Foundation and Practical Demonstration of Integrating MDO, MBSE and the Digital Thread

- **File:** `references/2026_SciTech_Lupp_et_al_REACT_Database.pdf`
- **Bib key:** `lupp2026reactMbseMdo`
- **Authors:** Christopher A. Lupp, Jason Y. Kao, Neal Novotny, Timothy Wontor (AFRL), Alexander Xu, James Singleton, David A. Sandler (University of Dayton Research Institute)
- **Year:** 2026 (forthcoming AIAA SciTech Forum paper)
- **Venue:** AIAA SciTech Forum
- **DOI:** none found yet — AFRL case number AFRL-2025-6693, distribution unlimited

## What it is

A description of AFRL's REACT project: a centralized, vendor-neutral database ("Nucleus")
serving as an authoritative source of truth to integrate Multidisciplinary Design
Optimization (MDO), MBSE, and Digital Thread/Digital Engineering practices for aircraft
design. Presents the theoretical foundation plus practical demonstrations (Cameo/MagicDraw
integration, CREATE-AV workflows with NAVAIR).

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background
- Decomposition / architecture (§6, §10): offers a pattern for keeping an MBSE model (Cameo)
  synchronized with other analysis tools via an authoritative central database — relevant if
  the capstone ever needs to justify why Cameo is the single source of truth (see
  `assistant/workflows/update-architecture.md`'s ground rule).
- Stakeholder / objective ontology (§7-§9): not directly applicable.
- Optimization study (§11-§13): tangential — this is about aircraft-design MDO, not
  operational/scheduling optimization, but shows one way to keep an optimization capability
  traceable to an MBSE model.
- Glossary / terminology: MDO, Digital Thread, ASOT (authoritative source of truth), GRA
  (government reference architecture).
- Other: mostly a case study of large-defense-program MBSE tooling integration, not of NAS
  operations.

## Rating

**3/5** — solid methodology reference for MBSE/tooling practice, but its subject (aircraft
MDO workflows) is one layer removed from this capstone's NAS-operations/SoS focus. Useful
background, not core evidence.

## Flags

None beyond the missing DOI (forthcoming paper, likely doesn't have one assigned yet).

## Processing metadata

- **Read depth:** skimmed (pages 1-3)
- **Date processed:** 2026-08-29
