# Impact of Slot Substitution on CTOP Performance

- **File:** `evidence/sources/Impact of Slot Substitution on CTOP Performance.pdf` (10 pp., of which 7 are text)
- **Bib key:** `kulkarni2019ctopSlotSubstitution`
- **Authors:** Deepak Kulkarni (NASA Ames Research Center)
- **Year:** 2019 (March)
- **Venue:** NASA Technical Memorandum NASA/TM-2019-220158
- **DOI:** none

## What it is

A short NASA technical memorandum. It explains the FAA's Collaborative Trajectory Options Program (CTOP), then uses one invented two-route scenario, and one table of United flights at a Newark arrival fix on 2015-07-15, to argue that an airline which swaps its own flights among the slots it is given ("subbing") can cut its delay by about half, and that it would then gain by stating a very high relative cost for its alternative routes.

## Why it's valuable, and to what

- **Proposed airline-to-ATC interface (D-019; report Section 2.3):** a U.S. precedent, in operation, for an airline telling the FAA what its options cost it. In a Trajectory Options Set the airline lists several routes, altitudes and speeds for one flight and gives each a Relative Trajectory Cost, "in terms of equivalent ground delay minutes" (p. 4). The FAA's algorithm adds that number to the ground delay it would assign and picks the cheapest. So the idea of the airline supplying a cost figure that the traffic manager's automation then uses is not new; what differs in this project is the decision (a tactical conflict in cruise, not a flow program before departure) and the items (weight and cost index, not a ranked list of routes).
- **The misreporting limit (report Section 2.2):** direct support for the assumption that an airline could misstate what it shares. Section IV (p. 8): "an airline would reduce its delays by specifying a very high RTC in order to get maximum number of slots through a constrained FCA." That is a published statement that a stated cost can be set for advantage, not for truth.
- **`delayMarginMin` (D-025):** a second precedent beside `pilon2019udppMargins` for expressing an airline's preference as minutes of delay. Here it is a cost equivalent per option; in Pilon it is a time limit per flight.
- **Who decides what (D-012, the authority map):** "FAA has the responsibility of determining what slots are given to a flight operator and making an initial allocation of flights to slots. An operator can then change which flights use which slots" (p. 5). A clean statement of split authority over one resource.
- Literature review section: traffic flow management (`to-do-list.md` §4, the part moved to Future work by D-016).
- Decomposition / architecture (§6, §10): none beyond the authority split above.
- Optimization study (§11 to §13): none. The scenario is a flow program, not a conflict.
- Glossary / terminology: CTOP and TOS are already in `knowledge/concepts/glossary.md`. New: FCA (Flow Constrained Area), RTC (Relative Trajectory Cost), slot substitution ("subbing").

## Rating

**3/5.** Useful for two specific sentences in the report (a U.S. precedent for a stated cost, and evidence that a stated cost can be gamed). Not higher: it is a seven-page memorandum built on one invented scenario, it is strategic and pre-departure where the project is tactical, and its own conclusion calls the realistic case "an open research problem".

## Flags

- **Different phase and different decision from the project's.** CTOP acts before departure through ground delay and reroutes around a constrained area. Nothing in it concerns separation between two aircraft in cruise.
- **A technical memorandum, not a peer-reviewed paper.** NASA's own description of the type on p. 2: "preliminary or of specialized interest ... Does not contain extensive analysis."
- The 50 percent delay reduction is for the invented scenario (even spacing, every flight with the same 15-minute alternative). The author lists these as assumptions "that may not be valid in realistic situations" (p. 9).
- Two references only; the CTOP description rests on Smith and Stellings (2014), a CDM Flow Evaluation Team report not held.
- Not a duplicate. `roman2026predictiveServices` and `faa2025jo72103ee` also mention CTOP; neither covers slot substitution.
- No URL recorded: the file was added by the owner and its source page is not noted. The NASA Technical Reports Server should hold it under the report number.

## Highlighted passages

The owner's yellow highlights, read from the page images by Claude on 2026-10-11 (the extractor script was not run).

- p. 4: "CTOP allocates delay and reroutes around multiple FCA (Flow Constrained Area) -based airspace constraints in order to balance demand with available capacity."
- p. 4: "Similar to what is done with Airspace Flow Programs (AFPs), air traffic managers can create an FCA in a CTOP and control any air traffic that crosses that boundary by setting a flow rate for it."
- p. 4: "it permits airlines to provide a set of preferred reroute options (called a Trajectory Options Set or TOS) around an FCA"
- p. 4: "each trajectory option may contain the 'start' and 'end' times in which they are willing to accept for that particular option"
- p. 4: "Relative Trajectory Cost (RTC) for each trajectory option that specifies cost of each route relative to the most preferred option" and "RTC is in terms of equivalent ground delay minutes"
- p. 4: "CTOP assignment algorithm would add RTC to assigned ground delay to calculate total cost for each route and then assign the route with the lowest cost to an aircraft"
- p. 5: the caption "Figure 1. Trajectory Option Set"
- p. 5: "After CTOP allocation algorithm has assigned an airline a set of slots for its aircraft in constrained FCAs after processing submitted TOSs, it can choose to change which aircraft uses which slot. Thus, FAA has the responsibility of determining what slots are given to a flight operator and making an initial allocation of flights to slots. An operator can then change which flights use which slots."
- p. 5: "Slot assignment algorithm would consider all operator flights and all available slots and attempts to make optimal assignments"

## Processing metadata

- **Read depth:** read in full (10 pp.) by Claude on 2026-10-11. Highlighted by the owner on pp. 4 and 5.
- **Date processed:** 2026-10-11
