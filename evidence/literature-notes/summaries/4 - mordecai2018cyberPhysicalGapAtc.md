# Conceptual Modeling of Cyber-Physical Gaps in Air Traffic Control

- **File:** `evidence/sources/Conceptual Modeling of Cyber-Physical Gaps in Air Traffic Control.pdf`
- **Bib key:** `mordecai2018cyberPhysicalGapAtc`
- **Authors:** Mordecai, Yaniv
- **Year:** 2018
- **Venue:** Procedia Computer Science, vol. 140, pp. 21-28 (Complex Adaptive Systems Conference,
  CAS 2018)
- **DOI:** 10.1016/j.procs.2018.10.288

## What it is

A primary MBSE/conceptual-modeling study using Object-Process Methodology (OPM) and the
author's own CPG-Aware Modeling and Engineering (CPGAME) framework. Uses the Malaysia Airlines
MH-370 disappearance as a case study to formally define a "Cyber-Physical Gap" (CPG) — the
difference between a physical entity's actual state and its state as perceived/represented by a
cybernetic agent — and progressively elaborates a naive model of airplane-ATC interaction into a
fault-aware, then CPG-aware, model with concrete mitigation mechanisms (peer-ATC/airline
information sharing, inbound/outbound route handoff).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) — directly
  relevant to how ATC tracks/loses track of aircraft intent and position.
- Decomposition / architecture (§6, §10): the CPG concept — a gap between an entity's actual state
  and another agent's perceived/represented state of it — maps almost directly onto this capstone's
  central "trajectory-intent" propagation problem (how intent set at one level of the NAS SoS is or
  isn't faithfully perceived/tracked at another level, e.g., aircraft actual trajectory vs. ATC's
  tracked/expected trajectory). Strong conceptual anchor for framing that chain formally.
- Stakeholder / objective ontology (§7-§9): illustrates ATC/airline/peer-ATC information
  dependencies relevant to responsibility/authority analysis.
- Optimization study (§11-§13): not directly applicable.
- Glossary / terminology: introduces "Cyber-Physical Gap (CPG)," "Cyber-Physical Duality (CPD),"
  and the naive/fault-aware/CPG-aware modeling progression — candidate glossary terms.

## Rating

**4/5** — Strong supporting source: not NAS-wide in scope (single ATC-airplane interaction, narrow
case study) and uses OPM rather than SysML, but the core CPG concept is unusually well-aligned
with this capstone's trajectory-intent propagation framing and is likely citable in the conceptual
framing sections of the final paper.

## Flags

No duplicates found in the register. Uses OPM (Object-Process Methodology) rather than SysML —
worth noting if the capstone standardizes on SysML/Cameo terminology, since CPG concepts would
need translating into that notation.

## Processing metadata

- **Read depth:** fully read (8 pages)
- **Date processed:** 2026-09-13
