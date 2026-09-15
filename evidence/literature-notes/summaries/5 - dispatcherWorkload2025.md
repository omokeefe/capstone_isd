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

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (112 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "231 instances based on 2019 U.S. Bureau of Transportation flight data that involve 17 different carriers and up to 3968 flights per instanc"
- **Highlight:** "e."
- **Highlight:** "d the heuristic finds optimal solutions in 33.4% of the instances"
- **Highlight:** ".5 billion passengers in 2023 and a yearly demand growth of 13.8% in March 2024, measured in revenue passenger kilo- meters (ACI, 2024; IATA, 2024)."
- **Highlight:** ". B"
- **Highlight:** "Before departure, dispatcher planning tasks include: fuel, passenger, and cargo load for efficiency; flight adherence to regulations and standards; and flight path determination and release"
- **Highlight:** "at least 30 to 60 min before flight departure"
- **Highlight:** "compiles"
- **Highlight:** "d"
- **Highlight:** "di"
- **Highlight:** "ispatch release repor"
- **Highlight:** "t"
- **Highlight:** "continuous communication with pilots, regular checking for weather along the flight path, and monitoring any potential events that could jeopardize safety."
- **Highlight:** "emergency"
- **Highlight:** "contingency"

**Page 2**
- **Highlight:** "dispatchers may not have suffi- cient time t"
- **Highlight:** "may resort to conservative approaches, which can have financial implications for airlines."
- **Highlight:** "As noted by Tan et al. (2024), workload management is of great im- portance in aviation operations,"
- **Highlight:** "Investments"
- **Highlight:** "training"
- **Highlight:** "stress management programs,"
- **Highlight:** "decision-support systems"
- **Highlight:** "flight management system, and meteorological data sources."
- **Highlight:** "operate at workstations"
- **Highlight:** "30 min overlap for takeover"
- **Highlight:** "multi-task"
- **Highlight:** "Airline operations planning like flight and crew scheduling have substantial bodies of literature devoted to them and share mixed integer optimization models and path-based column generation solution frame- works. More comprehensive models involving integrated decisions, practical features or uncertainty/robustness may lead to larger models that are further tackled with metaheuristics; see for example (Xu et al., 2021) and the review paper (Xu, 2024). I"
- **Highlight:** "there is scarce dispatcher related work and the flight assignment problem does not have a path structure that is amenable to column generation like other airline problems due to the fact that flights are assigned to and processed at a workstation simultaneously."
- **Highlight:** "In"
- **Highlight:** "n this paper we introduce load as a unit-less quantity that captures the relative effort of flight planning and following as a function of flight distance. This measure allows the use of an additive function of task loads to calculate dispatcher workload"

**Page 3**
- **Highlight:** "A dispatcher usually manages multiple flights, some in planning and others en-route, at any given time"
- **Highlight:** "air traffic control specialists (ATC) provide ground support for flights"
- **Highlight:** "ATC are government employees responsible for ensuring safety and order in air traffic"
- **Highlight:** "manage flight operations at the airport and ensure that flight paths are followed and that there is sufficient separation."
- **Highlight:** "an make changes to the aircraft speed and altitude to manage the traffic"
- **Highlight:** "ATC workload is determined by the preset airspace sector and consequently the flights that use it."

**Page 4**
- **Highlight:** "Dispatcher scheduling may resemble"
- **Highlight:** "parallel machine scheduling"

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro + lit review start)
- **Date processed:** 2026-08-29
