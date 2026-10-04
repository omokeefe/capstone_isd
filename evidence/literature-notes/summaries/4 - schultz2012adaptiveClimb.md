# Adaptive Trajectory Prediction Algorithm for Climbing Flights

- **File:** `evidence/sources/NASA NTRS 20140004896_weight_estimation_from_climb_performance (Schultz, Thipphavong, Erzberger).pdf`
- **Bib key:** `schultz2012adaptiveClimb`
- **Authors:** Charles A. Schultz, David Thipphavong, Heinz Erzberger (NASA Ames / University-Affiliated Research Center)
- **Year:** 2012
- **Venue:** AIAA Guidance, Navigation, and Control Conference, AIAA-2012-4931 (venue taken from the citation in `mori2022massCruise`; the PDF shows only the AIAA footer)
- **DOI:** none found

## What it is

A conference paper (16 pp) describing an algorithm that lets a ground trajectory predictor correct its modeled aircraft weight during climb. It compares the energy rate observed in track data with the energy rate from the predictor's aircraft model and adjusts the modeled weight to close the gap. Evaluated in the ACES fast-time NAS simulation with about 4,800 departures, not on recorded traffic.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment definition.
- Decomposition / architecture (§6, §10): evidence for a missing exchange. The paper says a real-time data link of aircraft state would improve prediction, and that "aircraft weight and speed intent are considered competitive parameters by airlines and are not available for use" (p. 2). This is the citation for "ATC does not receive weight or speed intent."
- Stakeholder / objective ontology (§7–§9): airlines withholding weight and speed intent for competitive reasons is a stakeholder constraint on any architecture that asks them to share it.
- Optimization study (§11–§13):
  - Of the aircraft states examined in earlier studies, weight and speed intent "had the greatest influence on trajectory prediction accuracy, reducing the mean altitude error by 53 percent" (p. 2, citing Coppenbarger).
  - With weight uncertainty only, adaptation reached within 3 percent of actual gross weight within two minutes and cut the five-minute altitude error standard deviation from 1,151 ft to 305 ft (73 percent). Missed alerts fell by up to 15 percent and false alerts by up to 10 percent.
  - With climb speed intent also uncertain, the improvement dropped to 20–30 percent. The paper's conclusion: climb profile and capture speeds "will remain unknown to the automation unless it is published in the flight plan or made available via data-link" (p. 13).
  - The adapted weight is limited to 80–120 percent of the nominal modeled weight, which shows the ground model starts from a nominal weight per aircraft.
- Glossary / terminology: ACES (Airspace Concepts Evaluation System), CTAS (Center-TRACON Automation System), BADA (Base of Aircraft Data).
- Other: p. 6 reports that 95 percent of altitude clearances but fewer than one-third of route clearances issued by voice were entered into the automation as flight plan amendments (citing Paglione et al. 2009). Useful for the ATC-automation link in the context diagram.

## Rating

**4/5** — The clearest citable statement that ground automation lacks weight and speed intent, with measured consequences for conflict detection. Climb only, so it supports the cruise experiment by analogy.

## Flags

- Venue, year and paper number are not on the PDF; they come from another paper's reference list. DOI not found.
- Climb phase only (15,000–25,000 ft, constant-CAS segment). Nothing on cruise.
- Results are from a simulation with no track noise; the authors say the gains may not hold with real radar data.
- The "53 percent" and "not available for use" statements are this paper's summary of earlier work (Coppenbarger 1999, 2001), which is not in the register.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
