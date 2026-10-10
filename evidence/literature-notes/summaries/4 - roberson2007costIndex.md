# Fuel Conservation Strategies: Cost Index Explained

- **File:** `evidence/sources/boeing-aero-2007q2-cost-index-explained.pdf`
- **Bib key:** `roberson2007costIndex`
- **Authors:** Bill Roberson, Senior Safety Pilot, Flight Operations, Boeing
- **Year:** 2007
- **Venue:** Boeing AERO magazine, QTR_02 2007, pp. 26–28. Manufacturer magazine, not peer reviewed.
- **DOI:** none. URL: `https://skybrary.aero/sites/default/files/bookshelf/1956.pdf` (SKYbrary bookshelf copy)

## What it is

A three-page article by a Boeing pilot explaining what the cost index is, how the flight management computer uses it to set climb, cruise and descent speeds, and what goes into the time cost and fuel cost that define it. The first of a series on fuel conservation.

## Why it's valuable — and to what

- Optimization study (§11–§13): the manufacturer's plain definition of cost index, for the experiment's case in which weight and cost index are shared. Complements `mori2022massCruise`, which gives the cost function form.
- Stakeholder / objective ontology (§7–§9): cost index is where the airline's trade between time and fuel enters the aircraft. "The flight crew enters the company-calculated CI" (p. 26). The article also shows the airline's own setting can be far from its optimum.
- Decomposition / architecture (§6, §10): one concrete airline-to-flight-crew-to-FMC information item.

## What was taken from it (2026-10-10)

- "The CI is the ratio of the time-related cost of an airplane operation and the cost of fuel", time cost in dollars per hour over fuel cost in cents per pound (p. 26).
- "For all models, entering zero for the CI results in maximum range airspeed and minimum trip fuel." (p. 26)
- Figure 1: range 0–200 for the 737-300/-400/-500 and 0–500 for the 737-600/-700/-800/-900.
- Figure 4 and p. 28: at one airline, "The optimal CI was determined to be 12 for all 737 models", against 30 (737-400) and 45 (737-700) in use; the change added 1 to 3 minutes on "a typical 1,000-mile trip" and was worth "between US$4 million and $5 million a year".
- "the airspeed used during descent tends to be the most restricted of the three flight phases", to comply with air traffic control (p. 27).
- The 737 FMC limits its descent speed target to 330 knots, against 340 knots / Mach 0.82 maximum operating speed (p. 27).

## Flags

- **Predates the 737 MAX.** The MAX's cost index range is not given.
- The airline in Figure 4 is not named, and the dollar figures are 2007 fuel prices.
- **Read depth:** full text extracted by script and read; Figures 5 and 6 are sketches and were read from their captions only. The owner has not read it.

## Rating

**4/5** — A short, citable manufacturer definition of a quantity the experiment depends on, with one real example of an airline's setting. Old, and not specific to the MAX.
