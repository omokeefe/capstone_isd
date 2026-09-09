# Model-Based Systems Engineering Supporting Architecture Modeling of Air Traffic Management System and Model Verifying Based on SMT

- **File:** `evidence/sources/51.Model-BasedSystemsEngineeringSupportingArchitectureModelingofAirTrafficManagementSystemandModelVerifyingBasedonSMT.pdf`
- **Bib key:** `liu2025mbseAtmSmt`
- **Authors:** Liu, Tianning; Wang, Xuesong; Lu, Jinzhi; Tong, Yao; Liu, Yixiao; Hu, Xiaodu
- **Year:** 2025 (KSEM 2024 conference, Springer CCIS proceedings)
- **Venue:** Knowledge Science, Engineering and Management (KSEM 2024), Communications in
  Computer and Information Science vol. 2269, pp. 183-197
- **DOI:** 10.1007/978-981-96-0178-3_13

## What it is

A conference paper (Beihang University / China Electronics Information Industry Group)
demonstrating a full MBSE pipeline for Air Traffic Management (ATM) system architecture:
metamodels defined via the GOPPRR method, an architecture model library built in the
KARMA multi-architecture modeling language/tool (Airdraw), and functional-completeness
verification of that model library against ICAO annex requirements using an SMT
(Satisfiability Modulo Theories) checker. Motivated by needing to re-verify ATM system
compliance for a new aircraft type (supersonic airliners) without redoing document-based
system engineering from scratch. Methodology/demonstration paper, not empirical
operations data.

## Why it's valuable — and to what

- Literature review section: none of §2-§4 directly (not airline-ops/turnaround/dispatch
  literature) — this is MBSE methodology background.
- Decomposition / architecture (§6, §10): directly relevant — a worked example of going
  from regulatory requirements (ICAO annexes, analogous to FAA/NAS requirements this
  capstone must trace to) to a verified architecture model library, including how many
  viewpoints/models a real ATM architecture effort produced (8 viewpoints, 65 main
  models) as a scale reference.
- Stakeholder / objective ontology (§7-9): not directly — no stakeholder analysis.
- Optimization study (§11-13): not applicable.
- Glossary / terminology: candidate terms if the glossary ever needs them — GOPPRR
  (Goal-Object-Process-Performer-Rule-Result metamodel method), KARMA modeling language,
  SMT-based verification — currently niche to this one paper's toolchain, not yet used
  elsewhere in the register.
- Other: strongest direct parallel yet in the register for "verify an architecture model
  against traceable regulatory requirements" — worth returning to when the capstone
  reaches its own architecture-verification step, even though the toolchain (KARMA/GOPPRR)
  is unlikely to be replicated in Cameo/SysML.

## Rating

**4/5** — Strong supporting methodology reference: a concrete, verifiable worked example
of requirements-traceable MBSE architecture verification for an ATM-adjacent system, but
its toolchain (KARMA/GOPPRR/SMT) is specific to this paper's own tool ecosystem rather
than SysML/Cameo, and its case study (supersonic-aircraft ATM integration in a Chinese
regulatory context) doesn't overlap with this capstone's airline-ops/NAS-trajectory
subject matter — informs methodology/framing, not a citable data source for the core
storyline.

## Flags

None — single-author-team conference paper, no apparent duplicate elsewhere in the
register, all bibliographic fields confirmed directly from the PDF (title page + DOI
badge).

## Processing metadata

- **Read depth:** Skimmed (abstract, intro, problem statement, conclusion; figures/tables
  spot-checked for the modeling and verification results)
- **Date processed:** 2026-09-05
