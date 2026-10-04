# Performance Analysis of a Conflict Probe Utilizing Only State Vector Information

- **File:** `evidence/sources/Performance Analysis of a Conflict Probe Utilizing Only State Vector Information.pdf`
- **Bib key:** `bilimoria2004stateVectorProbe`
- **Authors:** Karl D. Bilimoria (NASA Ames), Mike M. Paglione (FAA William J. Hughes Technical Center), Hilda Q. Lee (UC Santa Cruz)
- **Year:** 2004
- **Venue:** 24th International Congress of the Aeronautical Sciences (ICAS), Yokohama, paper 216
- **DOI:** none found

## What it is

A conference paper (9 pp) that measures missed and false alert rates, as a function of look-ahead time from 0 to 20 minutes, for a conflict probe that only projects each aircraft's current velocity vector forward. It was run on almost 8 hours of Indianapolis ARTCC track data from 26 May 1999 (over 2,500 Class A flights), time-shifted to create 546 conflicts.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment definition.
- Decomposition / architecture (§6, §10): defines what a conflict probe needs (state vector at minimum; optionally flight plans, wind and temperature forecasts, and "aircraft aero-propulsive models," p. 1) and separates strategic probes from the short-term conflict alert in the ARTCC Host.
- Stakeholder / objective ontology (§7–§9): none directly.
- Optimization study (§11–§13):
  - Definitions of missed, correct and false alert (Fig. 1) and a method for rates by look-ahead time. Reusable if the experiment scores detection.
  - Both rates rise steeply to 5 minutes and approach 100 percent at long look-ahead for this probe (Fig. 4). The false alert rate was above the missed alert rate at every look-ahead time.
  - Lack of flight plan (route and altitude intent) explains a large share of the errors at short look-ahead and less at long look-ahead, where track data errors dominate (Fig. 7).
  - "Speed (longitudinal intent) information is generally not available in flight plans" (pp. 6–7). This supports the point that speed intent is a gap even for intent-based probes.
  - Adding a horizontal buffer trades missed alerts for false alerts (p. 8).
- Glossary / terminology: state vector probe, look-ahead time, missed alert, false alert, flight intent.
- Other: its references [2] (Paglione, Cale and Ryan 1999) and [3] (Brudnicki and McFarland 1997) are the URET conflict-probe accuracy studies. Those, not this paper, are the sources for EDST-type false alert rates.

## Rating

**3/5** — Good definitions and a clear demonstration that intent information drives probe reliability, but the probe studied is deliberately not the one controllers use.

## Flags

- **Not a measurement of URET or EDST.** Those use flight plan intent, winds and aircraft performance characteristics. Do not cite the rates here as today's false alert rate.
- This is not the paper recommended in the 2026-10-04 session as "Paglione, FAA Technical Center" on wind forecast error. That one and the MITRE URET assessment could not be downloaded (see the register flags).
- 1999 traffic data; no horizontal buffer was used.
- No DOI on the pages.

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
