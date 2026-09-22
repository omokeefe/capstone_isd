# Examining the Actors and Functions of an Airline Operations Center

- **File:** `evidence/sources/berry-pace-2011-examining-the-actors-and-functions-of-an-airline-operations-center.pdf`
- **Bib key:** `berry2011aocActors`
- **Authors:** Berry, Katherine A.; Pace, John J. (TASC, Inc.)
- **Year:** 2011
- **Venue:** Proceedings of the Human Factors and Ergonomics Society 55th Annual Meeting, 55(1), pp. 1412-1416
- **DOI:** 10.1177/1071181311551294

## What it is

A short (5-page) human-factors paper, funded by FAA AJP-61, that sets a pre-NextGen baseline for the
airline operations center (AOC). It tabulates the critical AOC actors (Table 1: aircraft dispatcher,
operations manager, AOC duty director, flight follower, aircraft router, ATC coordinator, tactical
ATC, crew scheduler and manager, maintenance controller and manager, with alternate titles, role
descriptions, and whether a dispatcher license/currency is required), then allocates day-to-day
functions to them (Figure 1). Sources are an unpublished "Airline X" AOC manual, literature and
subject-matter experts — no new data collection.

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) — a compact,
  citable actor inventory to sit alongside `clarke1998irregular` and `castro2013aoccMasThesis`.
- Decomposition / architecture (§6, §10): a role/function decomposition of the AOC usable for
  the airline-operations subsystem breakdown.
- Stakeholder / objective ontology (§7-§9): **directly feeds `knowledge/models/stakeholder-personas.md`.**
  Its actors line up with the blank AOC-group stubs (Duty Manager, Aircraft/Fleet Controller, Crew
  Controller, Maintenance Controller) and with the persona-file question of whether a role
  is "materially different from parent." Most useful finding for that test: the **dispatcher does not
  talk to ATC directly** — the ATC coordinator is the single point of contact, and information from
  the dispatcher is relayed. The airline dispatcher persona's ATC interactions should be adjusted
  accordingly. It also finds the flight follower is widely used but hardly studied.
- Optimization study (§11-§13): not applicable.
- Glossary / terminology: "third leg of the NAS" (AOC alongside ATC and flight crew); flight follower;
  aircraft router; ATC coordinator; functional allocation.

## Rating

**4/5** — Strong supporting source: short and shallow (no empirical data; a single airline's manual),
but it is the most direct AOC role-and-function inventory in the register and it maps onto
persona stubs that already exist.

## Flags

- The AOC manual it relies on ("Airline X, 2002") is unpublished and unidentified — single-airline
  evidence, 2002-vintage procedures, and the paper is a NextGen (2010-11) baseline. Titles vary by
  carrier, so treat the table as one example of structure, not the industry standard.
- Complements, does not duplicate, `clarke1998irregular` (AOC state-of-the-practice) and
  `castro2013aoccMasThesis`.
- Cites the FAA HSI Roadmap and NAS EA OV-6c scenarios — possible leads for §4 nominal-flight sources.

## Highlighted passages

_Digital highlights the user marked up in the PDF (30 found, no ink annotations), extracted 2026-09-21 via `tools/extract_pdf_annotations.py`. Prose highlights are verbatim; the Table 1 and Figure 1 highlights are condensed because the text layer of those graphics is scrambled — read them in the PDF itself._

**Page 1**
- **Highlight:** "In this study, AOC actors that are critical to the day-to-day operation of an AOC were identified and a functional allocation was performed."
- **Highlight:** "The typical AOC is comprised of fifty to one hundred operators in various roles."

**Page 2**
- **Highlight:** "Only those members who are critical to the day-to- day operation of the AOC and those functions that are frequent and critical to day-to-day operation will be included in this analysis"

**Page 3**
- **Highlight (Table 1, "Select AOC Actors"):** the whole table — actor, alternate names, role description, "requires dispatcher license/currency", and literature references — for Aircraft Dispatcher, Operations Manager, AOC Duty Director, Flight Follower, Aircraft Router, ATC Coordinator, Manager Tactical ATC, Crew Scheduler, Crew Scheduling Manager, Maintenance Controller, Manager Maintenance Control. (The text layer interleaves the columns; the reconstructed pairings are in the source's actor inventory, not here.)

**Page 4**
- **Highlight (Figure 1, "AOC Functional Allocation"):** the actor x function matrix (X = major role, ● = minor role). Functions marked: plan flight, monitor/track flight, communicate with flight crew, communicate with ATC, assist during diversions, plan aviation maintenance, schedule flight crew. Actors marked: the eleven listed under Table 1. The X/● cell values are unreadable in the text layer.
- **Highlight:** "As such, the flight follower is not nearly as prevalent in the scientific literature as the dispatch role, but the safety implications of the flight follower role are evident and substantial."
- **Highlight:** "For example, the ATC coordinator’s primary obligation is to communicate with ATC and act as the singular point-of-contact with ATC. While the dispatcher may communicate with ATC in emergency situations, the dispatcher does not interact directly with ATC; rather information provided by the dispatcher and other members is relayed to ATC via the ATC coordinator."

**What the markup emphasizes:** the scope limit (critical, frequent roles only), the actor inventory and actor x function allocation as the paper's core products, and two role-boundary points — the flight follower is under-studied relative to the dispatcher, and the ATC coordinator (not the dispatcher) is the AOC's single point of contact with ATC. Both feed the OCC-group persona stubs in `knowledge/models/stakeholder-personas.md`.

## Processing metadata

- **Read depth:** fully read (5 pages)
- **Date processed:** 2026-09-20
