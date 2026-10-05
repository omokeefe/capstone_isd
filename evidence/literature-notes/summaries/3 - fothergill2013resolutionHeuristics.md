# Conflict-Resolution Heuristics for En Route Air Traffic Management

- **File:** `evidence/sources/fothergill-neal-2013-conflict-resolution-heuristics-for-en-route-air-traffic-management.pdf`
- **Bib key:** `fothergill2013resolutionHeuristics`
- **Authors:** Selina Fothergill, Andrew Neal (The University of Queensland)
- **Year:** 2013
- **Venue:** Proceedings of the Human Factors and Ergonomics Society 57th Annual Meeting, pp. 71–75
- **DOI:** 10.1177/1541931213571018

## What it is

A short proceedings paper (5 pp), the first study of a PhD on workload and conflict resolution. Fourteen en-route controllers from Brisbane Centre talked through how they would manage five static traffic pictures. The paper lists the scanning, detection and resolution heuristics they described.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment's baseline, workload proxy and scenario design.
- Decomposition / architecture (§6, §10): none directly.
- Stakeholder / objective ontology (§7–§9): controllers cannot search the whole solution space, so they use "simple heuristics... to make fast decisions with little information" and keep "a 'library' of solutions" from experience (p. 71). The trade they describe is present workload against future workload.
- Optimization study (§11–§13):
  - **Thirteen heuristics, five lateral and eight vertical.** For each, the paper says how many instructions it takes and what follow-up it creates. That makes it a ready workload accounting:

    | Heuristic | Cost to the controller |
    |---|---|
    | Point behind the other aircraft | One instruction; "set and forget" |
    | Direct away / parallel track / 5 NM off and back | One instruction now, then monitor and bring the aircraft back |
    | Pass in front | Has to estimate crossing times; "very time consuming to calculate and monitor" |
    | Cut off a climb at the nearest level | One instruction, little monitoring |
    | Cut off at the highest reachable level | Has to estimate climb performance and monitor |
    | Descend to the nearest level | One instruction, quick; a second later to re-climb |
    | Step climb or descent | Several instructions, each with a read-back |

  - **On descending (p. 74):** quick and needs one instruction, but "it poses a penalty for the aircraft. By descending to a lower level, the aircraft will use more fuel." It also adds later workload to re-climb. "It is not usually preferred and is primarily used in periods of high workload when other options are not available."
  - **On climbing:** "No point asking aircraft to climb if they come back and say they can't" (p. 73). Controllers avoid climb requests because they do not know whether the aircraft can do it.
  - **Workload changes the choice (p. 72).** Level changes are preferred under high workload. With time available, the controller gives the highest vacant level the aircraft can reach, to protect its climb profile. With less time, a level close to the current one. Under extreme time pressure, a vector.
  - **Aircraft type and weight category enter the reasoning:** "BAW12 is going north and is heavy. VHTTO is a medium jet, so must turn him away" (p. 73).
- Glossary / terminology: heuristic, "set and forget," "take out," cut off, step climb, report maintaining.
- Other: sources of complexity named by controllers include aircraft climbing or descending through others, number of conflicts, aircraft type, time constraints, vector monitoring, and how much has to be held in memory.

## The scenario excerpt (Figure 1, scenario four)

Saved as `attachments/fothergill_airspace_scenario.png`. A fictitious en-route radar sector with six crossing routes (including H66, Q181, W421, V76) and two holding patterns, with eight aircraft frozen in place. Each data block shows callsign and wake category (H, M or L), current and cleared flight level, ground speed, aircraft type and route. Controllers were told there was no wind and no coordination to consider.

The worked example is MUA177, a B777 northbound on H66 at about FL280 climbing to FL370, opposite in direction to a group of aircraft at FL310 to FL350. Several controllers stopped its climb at FL290, below all of them, "for four minutes until he comes out the other side of the pack."

Scenarios ranged from 5 to 10 aircraft and from 2 to 28 potential pairwise conflicts. They were built by subject-matter experts at Melbourne Centre as low-complexity or high-complexity cases.

## Rating

**3/5** — Useful for the workload accounting and for a second, independent view that descent is a fallback. Five pages, 14 controllers from one center, self-reported, with no counts of how often each heuristic was chosen.

## Flags

- **It disagrees with `rantanen2012conflictManeuvers` on descent.** Here controllers say descending is not preferred because of fuel; the U.S. track data shows descent as the most common maneuver for aircraft in level flight. The difference may be stated preference against observed behaviour, planning time against alert response, or Australia against the U.S.
- The authors note "a discrepancy between what controllers say they do, and what they actually do."
- No frequencies are reported, so the heuristics cannot be ranked from this paper.
- The text says scenarios went up to "scenario six" with 10 aircraft while describing five scenarios. An inconsistency in the paper.
- Australian airspace and procedures.

## Highlighted passages

Four digital highlights (pp. 71–72): the abstract's description of static maps and interviews; the scanning and grouping result; the five SME-built screen shots at two complexity levels; and the briefing given to controllers ("a fictitious sector in En Route, radar control...").

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
