# Creating Executable Agent-Based Models Using SysML

- **File:** `evidence/sources/Creating Executable Agent-Based Models Using SysML.pdf`
- **Bib key:** `maheshwari2015sysmlAbmAtc`
- **Authors:** Maheshwari, Apoorv; Kenley, C. Robert; DeLaurentis, Daniel A.
- **Year:** 2015
- **Venue:** 25th Annual INCOSE International Symposium (IS2015), Bellevue, WA
- **DOI:** none found (INCOSE symposium paper)

## What it is

A primary MBSE methodology study from Purdue's Center for Integrated Systems in Aerospace.
Develops a generic translation framework from a SysML system-of-systems conceptual model to an
executable agent-based simulation model, and demonstrates it on a simplified air traffic
management problem: three aircraft agents with ADS-B In/Out logical and physical networks,
translated into a MATLAB-based Distributed Agent-based Framework (DAF) simulation that runs a
simple collision-avoidance algorithm, including a faulty-ADS-B failure case.

## Why it's valuable — and to what

- Literature review section: none / MBSE methodology background
- Decomposition / architecture (§6, §10): demonstrates mapping SysML structural (BDD/IBD),
  behavioral, and parametric viewpoints onto agent-based simulation elements (agents/objects,
  space, time, dynamics) — a concrete pattern for connecting a Cameo architecture model to
  executable agent-based analysis of NAS-SoS behavior.
- Stakeholder / objective ontology (§7-§9): not directly applicable.
- Optimization study (§11-§13): the SysML-to-ABM translation pipeline (and its noted
  scalability/coarse-graining limitations) is directly relevant if the capstone's optimization
  capability is implemented as an agent-based simulation layered on the SysML architecture.
- Glossary / terminology: none new beyond standard SysML/ABM vocabulary.
- Other: same Purdue/DeLaurentis research lineage as `delaurentis2005sosTransportation` and
  `mudumba2022mbseUml5uam`, extending that cluster with an executable-simulation angle.

## Rating

**3/5** — Useful background/methodology: directly demonstrated on an ATM-flavored example
(aircraft collision avoidance via ADS-B), which is more domain-relevant than most of the MBSE
cluster, but it is a narrow proof-of-concept (3 agents, 14 parameters) rather than an architectural
or analytical contribution to the NAS SoS itself.

## Flags

No exact duplicate. Complements rather than duplicates the existing DeLaurentis/Purdue cluster
(`delaurentis2005sosTransportation`, `mudumba2022mbseUml5uam`, `sinharoy2024ontologyUAM`) — this
is the only one of that cluster demonstrating SysML-to-agent-based-simulation translation rather
than SysML modeling alone.

## Processing metadata

- **Read depth:** fully read (12 pages)
- **Date processed:** 2026-09-13
