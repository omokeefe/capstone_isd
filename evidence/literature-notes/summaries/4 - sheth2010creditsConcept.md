# Simulations of Credits Concept with User Input for Collaborative Air Traffic Management

- **File:** `evidence/sources/sheth-et-al-2012-simulations-of-credits-concept-with-user-input-for-collaborative-air-traffic-management.pdf`
- **Bib key:** `sheth2010creditsConcept`
- **Authors:** Kapil S. Sheth (NASA Ames Research Center); Sebastian Gutierrez-Nolasco, James W. Courtney, Patrick A. Smith (UC Santa Cruz, at Moffett Field)
- **Year:** 2010 (the file name says 2012; the paper is AIAA 2010-8079)
- **Venue:** AIAA Guidance, Navigation, and Control Conference, Toronto, 2 to 5 August 2010
- **DOI:** 10.2514/6.2010-8079

## What it is

A human-in-the-loop simulation at NASA Ames (January 2010). Five certified airline dispatchers assigned "credits," an artificial currency, to prioritize their flights across route options while one traffic manager set airspace constraints, on the FACET simulation with a convective-weather traffic set. Credits let users state which flights matter most; the server assigns routes and ground delays by credit ranking when a sector is over capacity. The paper reports delay, fuel, credit balance and equity, and a questionnaire.

## Why it's valuable, and to what

- Literature review section: none of §2 to §4 directly; it serves the §7 to §9 stakeholder and objective work and the §11 experiment.
- Stakeholder / objective ontology (§7 to §9): **Figure 7 (PDF p. 11)** is the one thing this project uses: the dispatchers' ratings of ten factors behind flight priority. Schedule integrity rated first, crew connections second, with fuel in a tied group behind them; two of the ten factors exist only inside the study ("credits remaining," "delay of flights with more than 5 credits"). The paper says the ratings are "an aggregate of all the scenarios" and "the average rating values are not statistically significant." The transcription of the table is in `projects/nas-sos-capstone/journal/2026-10-05.md`.
- Optimization study (§11 to §13): the reason case D exists (D-014 item 4). Weight and cost index carry fuel and a flat value of time; what dispatchers rate highest, schedule integrity and connections, is carried by neither. Requirement SLR-INF-04 cites it.
- Decomposition / architecture (§6, §10): the introduction states the gap in the architecture's own terms: the FAA "does not know these preferences due to their proprietary nature," so traffic managers "impose changes to flight plans which do not incorporate users' preferences" (p. 1).

## Rating

**4/5.** The one measured statement of what airline dispatchers value, with the caveat the paper itself gives on significance. Not a 5: five participants, pre-departure flow management rather than sector conflict resolution, and an artificial-currency concept the project does not use.

## Flags

- Pre-departure flow management (the AOC to ATCSCC link in the model), not the sector controller's decision the experiment studies. The ratings support the general claim that the decider lacks the airline's priorities, at a different level.
- The owner's earlier question, why the table has 17 responses when five dispatchers took part, is not settled by the first two pages; check Section VI before citing a response count.
- Cited second-hand by `seamster2011collabSystems` for the ten factors "led by schedule integrity and flight connectivity."

## Processing metadata

- **Read depth:** first two pages and Figure 7 read; the rest skimmed. The owner's digital highlights are on pp. 1 to 2 and Figure 7.
- **Date processed:** 2026-10-10
