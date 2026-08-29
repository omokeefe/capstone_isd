# Design Ontology Supporting Model-based Systems-engineering Formalisms

- **File:** `references/Design Ontology Supporting Model-based Systems-engineering formalisms.pdf`
- **Bib key:** `luDesignOntologyMBSE2020`
- **Authors:** Lu, Jinzhi; Ma, Junda; Zheng, Xiaochen; Wang, Guoxin; Kiritsis, Dimitris
- **Year:** 2020
- **Venue:** arXiv preprint (arXiv:2010.07627v1 [cs.SE])
- **DOI:** none found — preprint; peer-reviewed venue not confirmed from pages read

## What it is

Proposes GOPPRRE (Graphs, Objects, Points, Properties, Roles, Relationships with
extensions), a unified meta-model/ontology meant to make different MBSE formalisms
(SysML, BPMN, UML, etc.) interoperable via knowledge-graph representations, evaluated with
a case study using a domain-specific tool called MetaGraph.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background.
- Decomposition / architecture (§6, §10): mostly relevant if the project ever needs to
  justify cross-tool data interoperability (e.g. Cameo export ↔ another modeling
  language) — not a live need right now per `assistant/workflows/update-architecture.md`'s
  "Cameo is the source of truth" rule.
- Stakeholder / objective ontology (§7-§9): not applicable — this is about formalism
  interoperability, not domain stakeholders/objectives.
- Glossary / terminology: GOPPRRE, M0-M3 layered MBSE architecture.

## Rating

**2/5** — marginal for this capstone. It's a legitimate, well-constructed MBSE ontology
paper, but it solves a cross-tool-interoperability problem this project doesn't currently
have (single Cameo model, no multi-tool integration need).

## Flags

No confirmed peer-reviewed publication venue found on the pages read — worth checking
whether this arXiv preprint was later published somewhere before citing it as such.

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro)
- **Date processed:** 2026-08-29
