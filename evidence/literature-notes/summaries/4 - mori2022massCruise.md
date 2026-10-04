# Aircraft Mass Estimation Using Cruise Flight Profile

- **File:** `evidence/sources/Aircraft Mass Estimation Using Cruise Flight Profile.pdf`
- **Bib key:** `mori2022massCruise`
- **Authors:** Ryota Mori (Electronic Navigation Research Institute, Japan)
- **Year:** 2022
- **Venue:** 33rd Congress of the International Council of the Aeronautical Sciences (ICAS), Stockholm, paper 0105
- **DOI:** none found

## What it is

A conference paper (10 pp) proposing a way to estimate aircraft mass from cruise data alone. It uses the fact that the cost-optimal cruise altitude rises as mass falls, computes that altitude with the BADA model, and matches it to the altitude the aircraft actually flew. A clustering step picks the flight segment where the aircraft appears closest to its optimum. Validated against recorded (QAR) mass for 39 B787-8 flights on North Pacific oceanic routes.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment definition.
- Decomposition / architecture (§6, §10): the method uses only "data available to ATC and numerical weather forecast" (p. 10). It is evidence that the weight exchange is absent today and has to be inferred.
- Stakeholder / objective ontology (§7–§9): mass "is usually not openly-available, because it is often airline's confidential data" (p. 1).
- Optimization study (§11–§13):
  - Eq. (1)–(3) state the direct operating cost objective in cost-index form: J = (CI + fuel flow) / ground speed, per unit distance. This is a ready form for the airline cost metric.
  - Figure 1 shows cost-optimal altitude against mass for a B787-8 at M0.82: roughly 1,000 ft higher for each 20,000 lb lighter, between 360,000 and 460,000 lb. It is a direct illustration of why the cost of a descent depends on weight.
  - Section 3.1 gives three reasons aircraft do not fly their cost-optimal altitude: 1,000 ft level spacing, the level being unavailable "due to other traffic or turbulence," and crews changing level infrequently. Aircraft usually fly below the optimum and rarely above it.
  - Accuracy: mean absolute error 5.23 percent using the whole flight and 3.29 percent with clustering. One flight of 39 was off by 22 percent because it flew far below its optimum throughout.
  - Cost index is assumed to be 30 because "the actual cost index is unknown" (p. 2).
- Glossary / terminology: ADS-C, QAR (quick access recorder), cost-optimal altitude, NOPAC.
- Other: answers the question raised in the 2026-10-04 journal of whether anyone estimates weight in cruise. The paper says most prior work uses climb and that it knows of only one earlier cruise-based study (He et al. 2018, which used detailed flight data).

## Rating

**4/5** — The only source in the register on cruise-phase weight, with a cost function and an altitude-versus-mass relationship that map directly onto the crossing-conflict experiment. Narrow evidence base keeps it from a 5.

## Flags

- One aircraft type, 39 flights, oceanic routes with 10-minute ADS-C reports. Do not generalize the accuracy figure to domestic en-route traffic.
- No DOI on the pages; ICAS proceedings paper.
- The method fails when the aircraft is held below its optimum for the whole cruise, which is the congested case the capstone cares about.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
