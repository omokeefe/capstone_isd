# A Distributed Approach to Integrated and Dynamic Disruption Management in Airline Operations Control

- **File:** `evidence/sources/Tese_Doutoramento_AntonioCastro_18Julho2013.pdf`
- **Bib key:** `castro2013aoccMasThesis`
- **Authors:** António Jesus Monteiro de Castro (supervisor: Eugénio de Oliveira)
- **Year:** 2013
- **Venue:** PhD thesis (Informatics Engineering), Faculdade de Engenharia, Universidade do Porto (FEUP)
- **DOI:** none found (institutional repository thesis, no DOI on the pages read)

## What it is

A doctoral thesis proposing a distributed, decentralized, integrated, and dynamic
Multi-Agent System (MAS) approach — MASDIMA — to airline disruption management in
Airline Operations Control (AOC), using TAP Portugal's Airline Operations Control Center
(AOCC) as the case study. Primary contributions: the MASDIMA architecture itself (agents
for aircraft, crew, and passenger managers negotiating under a supervisor agent), a novel
negotiation protocol (Generic Q-Negotiation, GQN), and an Agent-Oriented Software
Engineering methodology (PORTO) used to build it.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) —
  directly extends the existing disruption-management cluster
  (`hassanDisruptionReview`, `clarke1998irregular`, `hu2024disruptionOptReview`,
  `santana2023arpReview`, `dispatcherWorkload2025`) with a primary MAS-based
  decision-support architecture rather than a review.
- Decomposition / architecture (§6, §10): strong candidate — MASDIMA is a real,
  implemented distributed decomposition of the AOC disruption-recovery problem into
  interacting agents (aircraft/crew/passenger managers + supervisor), a concrete
  precedent for decomposing an operational-control problem into a system-of-systems-like
  agent architecture.
- Stakeholder / objective ontology (§7-9): each MASDIMA agent has an explicit utility
  function (aircraft delay/cost, crew delay/cost, passenger delay/compensation cost) that
  the supervisor agent must reconcile — a directly reusable pattern for this capstone's
  objective/cost ontology work, showing how conflicting local objectives (myopic
  per-resource optimization) get negotiated toward a system-level solution.
- Glossary / terminology: MASDIMA, GQN (Generic Q-Negotiation), AOSE, PORTO
  methodology, AOCC (Airline Operations Control Center).
- Other: companion/evaluation paper `bouarfa2018masDisruption` benchmarks this same
  MASDIMA approach against human-team coordination policies — read together.

## Rating

**5/5** — the originating primary source for a real, implemented distributed
agent-based architecture with explicit per-stakeholder utility functions; directly
informs both the decomposition work (§6/§10) and the objective-ontology/myopic-conflict
analysis (§7-9) this capstone is built around, not just background reading.

## Flags

- No DOI found on the pages read (institutional thesis repository); verify whether FEUP's
  repository assigns one before final citation.
- Only skimmed (front matter, abstract/resumo in Portuguese and English, dedication,
  acknowledgments) — the technical chapters (MASDIMA architecture, GQN protocol
  specification, PORTO methodology, experimental results) were not read in this triage
  pass; flagged as a strong candidate for a full `annotate-source.md` deep-read pass
  given the 5/5 rating.
- Companion to `bouarfa2018masDisruption` — read together, not duplicative (thesis =
  the method's origin; journal paper = a later third-party benchmark of it).

## Processing metadata

- **Read depth:** skimmed (front matter only — pages 1-15 of a much longer thesis)
- **Date processed:** 2026-09-13
