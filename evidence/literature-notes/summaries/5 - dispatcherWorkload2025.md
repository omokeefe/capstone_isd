# Workload Balancing for Flight Dispatchers

- **File:** `references/Workload Balancing for Flight Dispatchers.pdf`
- **Bib key:** `dispatcherWorkload2025`
- **Authors:** Turhan, Serkan; Gzara, Fatma; Elhedhli, Samir (University of Waterloo)
- **Year:** 2026 (journal issue) — accepted Oct 2025, available online Oct 2025
- **Venue:** Computers & Operations Research, Vol. 186, article 107303
- **DOI:** 10.1016/j.cor.2025.107303

## What it is

Defines and solves the flight dispatcher workload-balancing problem: assigning flights to
dispatcher workstations to minimize peak workload and/or absolute deviation from average
workload, using Lagrangian relaxation for a closed-form lower bound plus a genetic-algorithm
metaheuristic, tested on 2019 US Bureau of Transportation Statistics data (231 instances, up
to 3968 flights).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 ("Flight Dispatcher Research") —
  directly the paper that section is built around, and unusually recent/on-target (the
  paper explicitly notes this is a novel, previously under-studied problem — "we only found
  three studies that focus on flight dispatcher scheduling and assignment").
- Decomposition / architecture (§6, §10): models dispatcher-to-workstation assignment with
  shift overlaps for handover continuity — directly usable for dispatcher responsibility/
  handoff architecture elements.
- Stakeholder / objective ontology (§7-§9): dispatcher workload is explicitly named as a
  Flight Crew/Dispatcher-side concern in `knowledge/models/stakeholder-register.md`'s
  enterprise-objective hierarchy (Human Well-Being → workload) — this paper gives a
  quantifiable measure for it.
- Optimization study (§11-§13): a strong, self-contained methodological template — real
  formulation, real data, Lagrangian bound plus heuristic — usable almost directly as a
  pattern for the §11 multi-objective optimization study if dispatcher workload becomes one
  of the modeled objectives.

## Rating

**5/5** — core §4 reference, directly on-target, recent, and unusually reusable for the
§11-13 optimization-study work given its explicit mathematical formulation.

## Flags

**Year discrepancy in bib key:** the paper's journal issue is dated **2026** (Computers &
Operations Research, Vol. 186 (2026)), not 2025. The bib key `dispatcherWorkload2025` was
kept for continuity with existing references to it, and the `year` field in
`references.bib` has been corrected to 2026 with a note explaining the mismatch.

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro + lit review start)
- **Date processed:** 2026-08-29
