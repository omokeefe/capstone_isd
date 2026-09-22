# Managing Variability: A Cognitive Ethnography of the Work of Airline Dispatchers

- **File:** `evidence/sources/Managing Variability - A Cognitive Ethnography of the Work of Airline Dispatchers.pdf`
- **Bib key:** `munro2018managingVariability`
- **Authors:** Munro, Pamela (Feiji Consulting); Mogford, Richard (NASA Ames Research Center)
- **Year:** 2018
- **Venue:** Proceedings of the Human Factors and Ergonomics Society Annual Meeting, 62(1), pp. 182-186
- **DOI:** 10.1177/1541931218621043

## What it is

A 5-page primary empirical study: ethnographic field observation over five months at three major US
airlines (15 line dispatchers, chief dispatchers and ATC coordinators), analyzed with grounded theory.
It follows flight planning, and fuel planning in particular, and identifies four sources of variability
that force fuel to be recalculated — contingency planning, load planning, pilots, and station
operations — plus the strategies dispatchers use (pattern identification, buffers, rounding up, tool
workarounds).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) — the
  ground-truth, on-the-floor counterpart to the OCC-structure and disruption-management papers
  already registered; pairs naturally with `dispatcherWorkload2025`.
- Decomposition / architecture (§6, §10): shows the release (route, fuel, payload, MEL items,
  NOTAMs) as an information object that other airline work groups (load planning, ramp, pilots)
  consume, and re-issue when its inputs change — a concrete example of intent being set, released,
  and amended. Distinguishes the *flight plan* (route filed with ATC) from the *dispatch release*
  (the whole operational plan).
- Stakeholder / objective ontology (§7-§9): **strong.**
  - Airline Dispatcher persona: dispatcher's release timing (60-90 min before domestic
    departure, 120 min international) is a performance metric; the dispatcher is told to keep
    fuel cost down and accommodate revenue payload, while regulation makes them jointly
    responsible for adequate fuel.
  - §9 conflict material: dispatch vs. load planning "ongoing negotiation" over weight capacity
    (fuel vs. payload; each side adds its own ~1,000 lb buffer, so 2,000 lb is buried in the ZFW),
    dispatch vs. pilots (captain fuel requests), dispatch vs. station gate agents (late
    passengers). Also an instance of workload driving conservative decisions: "the more flights
    you give me, the more conservative I become," which shifts cost onto the airline — a
    local-behavior-vs-network-cost effect.
  - Captain persona: captains request more fuel and dispatchers "always give it."
- Optimization study (§11-§13): relevant to the dispatcher-workload work (`dispatcherWorkload2025`) as
  qualitative evidence that workload, not just numbers, is a constraint.
- Glossary / terminology: dispatch release vs. flight plan, schedule release time, ZFW (zero fuel
  weight), flight following, "back side of the clock."

## Rating

**4/5** — Strong supporting source: real observational evidence on how dispatch, load planning,
pilots and stations conflict, directly usable for personas and §9; limited by its narrow focus on fuel
planning and small sample.

## Flags

- **Venue/DOI not on the PDF** (no masthead) — confirmed via web search (SAGE Journals; also in NASA
  NTRS). Low risk.
- Qualitative and small (15 participants, three airlines); findings are about fuel planning, not
  dispatch as a whole, and only for US carriers.
- Related to but distinct from `dispatcherWorkload2025` (optimization of dispatcher workload
  balancing) — complementary.

## Highlighted passages

_Digital highlights the user marked up in the PDF (20 found, no ink annotations), extracted 2026-09-21 via `tools/extract_pdf_annotations.py`. Verbatim._

**Page 1**
- **Highlight:** "Planning fuel was dynamic, with recalculations required whenever other factors varied (e.g., payload, route, alternates). This rework increased workload and opportunities for error while reducing efficiency."
- **Highlight:** "Four main factors contributed variability to fuel planning:  contingency planning, load planning, pilots, and station operations. Strategies for managing variability included pattern identification, use of buffers, rounding up, and leveraging software tools. Software design often added to workload by forcing dispatchers to attend to low level tasks."
- **Highlight:** "Such high-level descriptions of" / "dispatchers’ work fail to recognize the number and complexity of tasks involved in each of these activities."
- **Highlight:** "flight planning involves seeking out information relevant to a flight (including but not limited to: weather, aircraft capabilities, runway configuration, airspace, station operations, and flight crew qualifications), assessing the potential impact of these pieces of information (individually and collectively) on the successful conduct of a flight, then building a plan that mitigates any such impact while also providing the pilot with sufficient resources to deal with any unforeseen events"
- **Highlight:** "it involves skills such as perception, attention, memory, situation awareness, pattern-recognition, decision-making, and multi-tasking, each of which contributes to dispatchers’ human performance capabilities but also introduces limitations and biases that can lead to errors"
- **Highlight:** "All of this is performed in an environment that includes stressors such as time pressure, productivity goals, and the risk of professional liability for decisions made"
- **Highlight:** "Further, it often takes place on the ‘back side of the clock’ which brings risks associated with fatigue (FAA, 2010)"

**Page 2**
- **Highlight:** "As a result, the flight’s plan is based on a number of estimations or predictions about the conditions in which the flight will take place, e.g., forecast weather, estimated passenger loads, predicted delays, expected air traffic programs"
- **Highlight:** "Many can also change once the flight is enroute"
- **Highlight:** "Each change requires the dispatcher to review the new information, assess its impact to the existing plan, and identify the best strategy for mitigating that impact"
- **Highlight:** "Flight planning is therefore best characterized as ongoing, dynamic process rather than as a linear task with discrete steps that lead to a fixed output."
- **Highlight:** "Similarly, a dispatcher’s workflow cannot always be neatly divided into discrete phases of flight planning or flight following. Because each dispatcher in this study was responsible for multiple flights over the course of a shift, planning for some flights was conducted concurrently with following other flights"

**Page 3**
- **Highlight:** "Flight plan versus dispatch release. The term flight plan is often used to refer to what is properly called the dispatch release. The flight plan (also called the flight strip), is only one part of the dispatch release. It contains the proposed route of flight and is submitted to ATC for approval before departure. The dispatch release, on the other hand, includes all aspects of the operational plan (route, fuel, payload, performance or mechanical restrictions, etc.) and the information used to create it, e.g., weather forecasts, fuel calculations, deferred mechanical items, passenger and cargo loads, Notices to Airmen (NOTAMs), in addition to the proposed route."
- **Highlight:** "Once he/she has completed flight planning the dispatcher ‘releases’ the plan, i.e., makes it available to other work groups throughout the airline (e.g., pilots, load planners, ramp controllers, etc.), who use it to support their own work processes."
- **Highlight:** "ramp controllers cannot generate the fuel slips that must be sent to fuel trucks in order to begin fueling the aircraft until the total fuel quantity needed is received via the release"
- **Highlight:** "As they begin working with the release these work groups may discover some of the predictions on which it was based were not accurate or that situational factors have changed. They communicate this information to the dispatcher who must amend and update the release."
- **Highlight:** "Schedule release time. Each dispatch release has an assigned time by which it must be completed, known as the ‘schedule release time’. Airlines in this study had schedule release times of between 60-90 minutes before domestic departures and 120 minutes before international departures. A dispatcher can, however, choose to release a flight earlier than the schedule release time. Indeed this was often done when a dispatchers had multiple releases due at roughly the same time"
- **Highlight:** "Dispatchers were sensitive to meeting their airline’s release times not only because it was a metric on which their own performance was evaluated,"
- **Highlight:** "his study identified five key planning tasks:  checking weather, choosing a route, selecting alternates, reviewing NOTAMs, and planning fuel"

**What the markup emphasizes:** (1) the flight plan vs. dispatch release distinction — the ATC-filed flight plan is one component of the release, which is the airline-internal operational plan that downstream groups consume; (2) the release as a handoff artifact and its schedule release time (60-90 min domestic, 120 min international) as a timing constraint and dispatcher performance metric; (3) planning as continuous re-planning against predicted conditions, not a one-shot step; (4) fuel planning as the main variability source, managed with buffers and rounding up. Points (1)-(3) bear directly on where the trajectory-intent chain leaves the airline and enters the ATC filing.

## Processing metadata

- **Read depth:** fully read (5 pages)
- **Date processed:** 2026-09-20
