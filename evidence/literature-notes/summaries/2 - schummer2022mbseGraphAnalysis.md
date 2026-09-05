# An Approach for System Analysis with Model-Based Systems Engineering and Graph Data Engineering

- **File:** `references/an-approach-for-system-analysis-with-model-based-systems-engineering-and-graph-data-engineering.pdf`
- **Bib key:** `schummer2022mbseGraphAnalysis`
- **Authors:** Schummer, Florian; Hyba, Maximillian (Technical University of Munich)
- **Year:** 2022
- **Venue:** Data-Centric Engineering, Vol. 3, article e33
- **DOI:** 10.1017/dce.2022.33

## What it is

Proposes transferring a SysML/MBSE model (built in MagicDraw) into a labelled-property
graph database (Neo4j) via a defined graph schema, enabling deep system analysis and
anomaly resolution — answering questions like "what happens if there's an electrical short
in a component?" — demonstrated on the MOVE-II small-spacecraft mission.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background.
- Decomposition / architecture (§6, §10): a candidate **technique** (not a source of
  content) for querying the eventual Cameo model — e.g. tracing which stakeholders/
  activities are affected if a given information exchange fails — relevant if the capstone
  wants to demonstrate traceability queries programmatically rather than by manual diagram
  inspection.
- Stakeholder / objective ontology (§7-§9): not applicable — no operational stakeholders in
  this paper.
- Glossary / terminology: MOVE-II (small spacecraft mission used as case study), labelled
  property graph.

## Rating

**2/5** — marginal. An interesting technique for MBSE-model analysis, but the case study
domain (spacecraft assembly/integration/test anomaly resolution) is far from NAS/airline
operations, and adopting a graph-database technique isn't currently a stated need for this
capstone.

## Flags

None.

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro)
- **Date processed:** 2026-08-29
