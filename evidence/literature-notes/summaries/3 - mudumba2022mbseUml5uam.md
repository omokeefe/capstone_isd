# Model-Based Systems Engineering Approach for Simulating Urban Air Mobility Maturity Level 5 (UML-5) Operations

- **File:** `evidence/sources/mudumba-et-al-2022-model-based-systems-engineering-approach-for-simulating-uml-5-uam-operations.pdf`
- **Bib key:** `mudumba2022mbseUml5uam`
- **Authors:** Mudumba, Sai V.; Fung, Tien-Yueh; Sinha Roy, Sonali; Beck, Brady J.; Chao,
  Hsun; DeLaurentis, Daniel A.
- **Year:** 2022
- **Venue:** AIAA AVIATION Forum
- **DOI:** 10.2514/6.2022-4075

## What it is

An AIAA conference paper (Purdue University, for NASA's Safe and Secure Assured Autonomy
(S2A2) University Leadership Initiative) applying MBSE/SysML to define the operating
context, stakeholders, state transitions, and actions for UAM Maturity Level 5 (UML-5) —
NASA's most autonomous, highest-density UAM operating state (ground-based remote piloting,
M:N pilot-to-aircraft ratios). Uses SysML in MagicDraw to produce Block Definition
Diagrams, Internal Block Diagrams, State Machine Diagrams, and Activity Diagrams for a
nominal UAM flight, modeling interactions between an onboard controller, a fleet operator,
and a "Provide Service for UAM" (PSU) actor, including non-conformance/contingency
handling. Methodology/architecture-demonstration paper, not empirical operations data.

## Why it's valuable — and to what

- Literature review section: none of §2-§4 directly (UAM, not commercial airline
  ops/turnaround/dispatch) — MBSE methodology background, same cluster as this register's
  existing UAM-as-SoS sources.
- Decomposition / architecture (§6, §10): useful worked example of SysML diagram types
  (BDD/IBD/STM/AD) applied to a multi-actor aviation SoS with autonomy/contingency
  handling — directly transferable diagramming approach for this capstone's own Cameo
  model, even though the domain (UAM) differs from NAS mainline operations.
- Stakeholder / objective ontology (§7-9): the actor set (onboard controller, fleet
  operator, PSU) and their non-conformance-handling responsibilities are a compact
  example of decision-authority modeling that could inform how this capstone represents
  analogous handoffs (e.g. dispatcher/ATC/flight crew) in §7-9.
- Optimization study (§11-13): not applicable — no optimization content.
- Glossary / terminology: candidate terms — ROPE (Resources, Operations, Policies,
  Economics) table, UAM Maturity Level (UML) framework — both cited from prior
  Purdue/NASA-FAA work rather than original to this paper.
- Other: same DeLaurentis/Purdue lineage as `delaurentis2005sosTransportation` (already
  core to the register) and topically adjacent to `sinharoy2024ontologyUAM`,
  `sadik2025holonicUAM`, and `yao2026loAltitudeSoSSafety` — complementary to that existing
  UAM-as-SoS cluster (state-machine/activity-diagram modeling angle vs. ontology,
  holonic-architecture, or safety-review angles already covered), not duplicative.
  Reference [22] independently confirms `delaurentis2005sosTransportation`'s title/DOI
  (AIAA 2005-123) as cited by this paper.

## Rating

**3/5** — Useful MBSE-methodology and diagramming-technique background (concrete SysML
worked example for a multi-actor autonomous aviation SoS), and reinforces the existing
UAM-as-SoS literature cluster, but its subject matter (UAM/UML-5 autonomy) is tangential
to this capstone's core NAS/airline-ops storyline rather than a source the report would
cite for domain findings.

## Flags

None — no apparent duplicate elsewhere in the register; all bibliographic fields
confirmed directly from the PDF (title page + DOI in the running header).

## Processing metadata

- **Read depth:** Skimmed (abstract, nomenclature, introduction, literature review intro,
  one activity-diagram example, conclusion/future work; full diagram content not
  exhaustively reviewed)
- **Date processed:** 2026-09-05
