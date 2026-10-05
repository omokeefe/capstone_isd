# Conflict Resolution Maneuvers in Air Traffic Control: Investigation of Operational Data

- **File:** `evidence/sources/Conflict Resolution Maneuvers in Air Traffic Control  Investigation of Operational Data.pdf`
- **Bib key:** `rantanen2012conflictManeuvers`
- **Authors:** Esa M. Rantanen (Rochester Institute of Technology), Christopher D. Wickens (Alion Science and Technology)
- **Year:** 2012
- **Venue:** The International Journal of Aviation Psychology, 22(3), 266–281
- **DOI:** 10.1080/10508414.2012.691048

## What it is

A journal article that infers, from radar track data, which maneuver en-route controllers used after a conflict alert. It covers 256 maneuvers (223 conflicts, 33 of them with both aircraft moved) at five U.S. centers. The authors first build a simple expected-utility model of maneuver choice and then test it against the data.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It is the main empirical source for the §11 experiment's baseline.
- Decomposition / architecture (§6, §10): none directly.
- Stakeholder / objective ontology (§7–§9): states what the controller optimizes. Three influences on maneuver choice (p. 268): expediency, preserving airspace structure and traffic flow, and how easily the result can be seen on the display. Workload management "is critical to their performance" (p. 267). Fuel appears only as a secondary consideration (p. 279).
- Optimization study (§11–§13):
  - **Overall frequencies (p. 273):** level-offs of an aircraft already climbing or descending 44 percent, turns 32 percent, descents 18 percent, climbs 5 percent. Vertical changes 68 percent against 32 percent for turns.
  - **The experiment's own geometry, crossing tracks with both aircraft level (Table 4, 36 cases):** descend 23, climb 6, turn 4. That is about two-thirds descents and about four descents per climb. (The printed row adds to 33 against a stated total of 36.)
  - **Any aircraft in level flight (Table 5, 65 cases):** descend 42, turn 15, climb 8.
  - **No vertical reversals.** A climbing aircraft was never told to descend, nor a descending one to climb (Table 5).
  - **Turns avoid right-angle crossings.** Turns were used mostly at crossing angles under 45 or over 135 degrees (Fig. 2).
  - **Rule-based, not optimized.** Geometry explained little of the choice. Controllers "probably do not delay to 'optimize' the choice of a maneuver, but rather, probably use more predetermined rules... and then presumably examine if the particular geometry makes the chosen maneuver unsafe" (p. 278).
  - **Why descend and not climb, in the authors' words (p. 279):** "climbing aircraft above their desired altitudes increases fuel burn, whereas descending an aircraft exploits gravity and does not significantly decrease efficiency, especially if the additional distance flown at the lower altitude... is short."
  - **Why vertical at all (p. 268):** "Two aircraft at different altitudes will not be in conflict no matter what they do as long as they maintain their levels," while a turn creates new potential conflicts at the same level and has to be undone.
  - The utility model (Table 1) scores each maneuver on five yes/no factors and predicted the ranking of the four vertical maneuvers almost exactly. It under-predicted turns.
- Glossary / terminology: conflict alert (CA), expected utility, level-off, vertical reversal, "distance over speed" bias.
- Other: the FAA Academy lesson plan gives "no particulars whatsoever about conflict geometries or how to resolve various conflicts" (p. 267). Resolution technique is passed on in training, not written down. This is why the baseline rule has to come from behaviour data.

## Rating

**5/5** — Peer-reviewed, U.S. operational data, and it contains the exact case the experiment uses. It is the citation for "one descent" as the baseline.

## Flags

- **Corrects an earlier note.** The 2026-10-04 journal recorded "descents twice as frequent as climbs" from a search summary. The paper says more than three times overall (18 against 5 percent) and about four to five times for aircraft in level flight.
- **These are responses to a conflict alert,** the short-range warning, not strategic resolutions made 10 to 20 minutes ahead. Controllers under time pressure may choose differently from controllers planning ahead.
- Maneuvers were inferred from tracks. There were no voice recordings, so intent is assumed, and speed changes were not analysed at all.
- Half the cases are from one center (Indianapolis, 128 of 256); Salt Lake City and Los Angeles together contribute 9.
- The authors' claim that descending "does not significantly decrease efficiency" is unquantified and takes no account of weight. It is the assumption the experiment tests.
- It disagrees with the NASA resolver, which tries a climb first for fuel reasons (Erzberger 2006, in `evidence/prior-work-experiment-definition/`).

## Highlighted passages

Three digital highlights in the PDF, all captured above: the abstract's "256 cases... from 5 U.S. air traffic control centers" (p. 267), and the two frequency statements on p. 273.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
