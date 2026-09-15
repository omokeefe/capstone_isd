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

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (6 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "modeling language KARMA"
- **Highlight:** "modeling tool Airdraw,"
- **Highlight:** "GOPPRR method"
- **Highlight:** "tested using the SMT checker in the modeling tool"

**Page 2**
- **Highlight:** "the relevant indexes and properties of the existing air traffic control system need to be optimized and modified for the supersonic passenger aircraft."
- **Highlight:** "establishing a system modeling of the ATM system to form a model library."
- **Highlight:** "(1) Metamodel designing based on GOPPRR method"
- **Highlight:** "UAF methodology for formalizing the model library."
- **Highlight:** "First, the functions of ATM identified by ICAO through files are expressed through a graphical system model"
- **Highlight:** "The model captures all the functions mentioned on ICAO annex of the ATM system"
- **Highlight:** "optimization of radar cabin layout are presented"

**Page 5**
- **Highlight:** "The M1 layer is"
- **Highlight:** "model compositions and connections"
- **Highlight:** "The M0 layer consists of 6 meta-meta models t"
- **Highlight:** "graphs, objects, relationships, roles, points and property."
- **Highlight:** "M2 is the model layer,"
- **Highlight:** "It is an abstract expression of a cer- tain viewpoint in the real world"
- **Highlight:** "For example, the requirements diagram is used to represent certain design requirements of the system during modelling"
- **Highlight:** "M3 represents a certain viewpoint in the real world, that is, expressing the system’s concerns from a certain system perspective"
- **Highlight:** "the architectural modeling was completed with the following specific missions"

**Page 6**
- **Highlight:** "create a methodological model view."
- **Highlight:** "conforms to the standard ATM architecture model"
- **Highlight:** "A model of the architecture of part of the ATM system specially designed for supersonic passenger aircraft was completed"

## Processing metadata

- **Read depth:** Skimmed (abstract, intro, problem statement, conclusion; figures/tables
  spot-checked for the modeling and verification results)
- **Date processed:** 2026-09-05
