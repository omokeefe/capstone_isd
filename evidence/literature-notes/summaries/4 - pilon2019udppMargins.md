# Reducing Impact of Delays using Airspace User-Driven Flight Prioritisation: User Driven Prioritisation Process Validation Simulation and Results

- **File:** `evidence/sources/Pilon_2019_SIDs_UDPP_Reducing_Impact_of_Delays.pdf`
- **Bib key:** `pilon2019udppMargins`
- **Authors:** Nadine Pilon, Laurent Guichard (EUROCONTROL Experimental Centre, Network Management Research unit); Katherine Cliff (Think Research Ltd)
- **Year:** 2019
- **Venue:** 9th SESAR Innovation Days, 2 to 5 December 2019 (ISSN 0770-1268), paper 39; 8 pp.
- **DOI:** none found. Retrieved 2026-10-11 from https://sesarju.eu/sites/default/files/documents/sid/2019/papers/SIDs_2019_paper_39-1.pdf

## What it is

A conference paper from the EUROCONTROL team that develops the User Driven Prioritisation Process (UDPP), the European scheme that lets an airline reorder its own delayed flights inside an air traffic flow management regulation. It describes three features (Fleet Delay Reordering, Selective Flight Protection and the new "Margins") and reports a human-in-the-loop simulation of arrival constraints at Paris Charles de Gaulle with dispatchers from six airlines (51 runs).

## Why it's valuable — and to what

- Literature review section: airline operations control and collaborative decision making (how an airline's priorities reach the air traffic management system).
- Decomposition / architecture (§6, §10): published precedent for one attribute of `FlightOperations::AirlinePerformanceShare`, `delayMarginMin` (D-025).
  - **The airline states a time, not its costs.** "The Margins allows assigning 'time windows' -Time not before and Time not after- to each flight in combination with the SFP and FDR features, reflecting the AU's internal constraints" (Section III.C.3, p. 3). AU is airspace user, the airline.
  - **The cost structure stays with the airline.** "Each flight has its own not linear complex cost structure, which is only known by the AU" (Section II.A, p. 2).
  - Margins was "a new feature requested by AUs to automatically find the best position of each flight" (Section III.C, p. 3).
- Stakeholder / objective ontology (§7-§9): the shape of an airline's delay cost for one flight.
  - "As soon as the first connecting passengers risks to miss their outbound flights, delay costs surge. The same occurs if crew gets out of duty time or if the aircraft rotation delays the next scheduled flight" (Section II.A, p. 2).
  - "flights often have some tolerance to delay (i.e., margins), and this cost can often be considered as marginal in practice, provided that the delay is not bigger than the more constraining operational margins" (Section II.A, p. 2). Figure 1 (p. 2) draws it: a shallow slope, then a step at each "max delay target (Margin of manoeuvre)".
  - Dispatchers "make decisions (such as prioritisation) based on event-driven costs that define their margins of manoeuvre", where air traffic management policy "traditionally use a linear cost of delay" (Section II.A, p. 2).
- Optimization study (§11-§13): supports treating a missed connection as a step in cost at a threshold (the experiment's `connection_threshold_min` and case D), and gives a measured benefit of sharing the margin: on average 58.2 percent of the additional delay cost recovered (Table I, p. 5), reported in the conclusions as "40 % reduction on average" by airline type (Section V, p. 8); passenger connections improved by 2.1 percent on average (Table II, p. 6); no non-participating flight was delayed more (Table III, p. 6).
- Glossary / terminology: margin of manoeuvre; Time Not Before / Time Not After; UDPP.
- Other: none.

## Rating

**4/5** — the one published statement held of what an airline is willing to say about a flight's connection sensitivity (a time limit, with the cost behind it kept private), which is what the project's proposed share carries for case D. Not 5: the setting is different from the project's (see Flags).

## Flags

- **Different receiver and different decision from the project's.** UDPP is used in the planning phase, before departure, for slots in a regulation; the margin goes to the UDPP server and the Network Manager, and the airline reorders only its own flights. The project's share goes to the party resolving one en-route conflict between two airlines' aircraft. Cite this for "an airline would state a delay margin and keep its costs to itself", not for "this is done tactically by air traffic control".
- **A margin there is a clock time; here it is minutes of further delay.** `delayMarginMin` is the paper's "Time not after" minus the flight's current estimate. The paper does not use that form.
- The paper does not give the data format, units or message in which a margin is sent.
- The cost and passenger-flow models behind the 58.2 and 40 percent figures were set "based on expert judgement" in a workshop (Section IV.B.3, p. 5); one airport, one day of traffic, and participants lacked other tools such as airframe swaps, which "may have exaggerated the use and benefits" (Section IV.C.4, p. 8).
- The abstract's "more than 40%" and Table I's 58.2 percent are different averages (by airline type, and over all runs). Quote one with its table.
- The paper has one broken cross-reference in its own text ("Error! Reference source not found", p. 1).
- Not a duplicate of any held source. `SESAR_Solutions_Catalogue_2019_web.pdf` may describe the same solution at catalogue level; not checked.

## Processing metadata

- **Read depth:** read in full (8 pp.) by Claude on 2026-10-11. Not reviewed by the owner.
- **Date processed:** 2026-10-11
