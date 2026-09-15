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
  language) — not a live need right now per `workflows/update-architecture.md`'s
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

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (22 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "For this reason, this paper presents an ontology based upon graphs, objects, points, properties, roles, and relationships with entensions (GOPPRRE)"
- **Highlight:** "Owing to advances in artificial intelligence (AI) and machine-learning (ML) techniques, the concept of MBSE is undergoing a digital transformation that will ultimately lead to advanced facilitation to complex system developmen"
- **Highlight:** "This paper focuses on a unified MBSE ontology based on a meta-meta model built upon six key concepts with extensions: Graph; Object; Point; Property; Role; and Relationship (GOP- PRRE). This ontology presents a formalization opportunity for MBSE modeling via a unified syntax and data structure to support systems-engineering information exchange via the integration of AI and ML"

**Page 2**
- **Highlight:** "MBSE supports complex systems engineering and de- velopment efforts [6] by formalizing development processes, system architectures, and operational interrelationships"
- **Highlight:** "Recently, researchers have proposed an Object Management Group standard for model-driven engineering, comprising a four-layered architecture. The four layers are labeled M0– M3 and provide the modeling framework needed to support MBSE. The M0–M3 layers are described thoroughly in the “Ontology Design for MBSE Formalism” section of this paper."
- **Highlight:** "It applies the GOPPRR formalization of specific system views with new extensions [10]"
- **Highlight:** "Generic modeling languages have difficulty supporting the complete formalism of a specific domain; they do not support multiple system views in a unified way."

**Page 3**
- **Highlight:** "M0: Meta-meta models that refer to basic elements of the constructed model compositions and their intercon- nections. We adopt GOPPRR meta-meta models and their extensions to support meta-model development. • M1: Meta-models refer to the model compositions and connections needed to develop models. • M2: MBSE models represent real-world systems."
- **Highlight:** "M3: Real-world artifacts are considered, including com- plex systems and their development processes."
- **Highlight:** "needed to support information exchange dur- ing system development."
- **Highlight:** "The GOPPRRE approach uses the M0–M3 modeling frame- work, as inspired by the GOPPRR meta-meta models and their extensions, to construct the MBSE model syntax and semantics"

**Page 4**
- **Highlight:** "Graph is an entity collection of Object, Relationship, and Role, represented in one layout (e.g., a UML class diagram). The graph is either a visual diagram or another that was decomposed (explored) by one Object. • Object is an entity that constructs a Graph. • Point is one attached port in an Object. • Relationship refers to one connection between the Points and/or Objects. • Role is used to define the binding restrictions with the relevant Relationship. One Relationship is associated with two Roles. Through each role, the Relationship is defined as one that binds with one Point or one Object in its one end. • Property is a specific attribute of meta-models that is attached to the other five meta-meta models. • Extension refers to the additional constraints used to construct meta-models. In this paper, one constraint is developed as a connector. It refers to one binding between one Point or Object and one Role in one side of the Relationship."

**Page 5**
- **Highlight:** "For example, in Magic draw, some properties were defined as elements in their diagram-building environment so that the users could easily configure an object’s property."

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro)
- **Date processed:** 2026-08-29
