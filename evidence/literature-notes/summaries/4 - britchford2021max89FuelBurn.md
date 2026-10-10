# 737 MAX 8 & 9 fuel burn and operating performance

- **File:** `evidence/sources/aircraft-commerce-137-737max-8-9-fuel-burn.pdf`
- **Bib key:** `britchford2021max89FuelBurn`
- **Authors:** Ian Britchford (named in the article's standfirst)
- **Year:** 2021 (issue 137, August/September)
- **Venue:** Aircraft Commerce, trade magazine, pp. 18–26. Not peer reviewed.
- **DOI:** none. URL: `https://www.aircraft-commerce.com/wp-content/uploads/aircraft-commerce-docs/General%20Articles/2021/137_FLTOPS.pdf`

## What it is

A flight-planning comparison of eight narrowbody types (A320ceo, A321ceo, A320neo, A321neo, 737-800, 737-900ER, 737-8, 737-9) on 14 routes from Boston, 484 to 2,730 NM of air distance. Fuel and times come from "PPS flight planning software". Two payload cases: equal passenger counts, and an 85 percent load factor.

## Why it's valuable — and to what

- Optimization study (§11–§13): **the only source found with fuel numbers for the 737 MAX 9 itself**, the experiment's one aircraft type (D-015). Block fuel by route, and the type's weights. Used in `knowledge/models/b737-max9-rules-of-thumb.md` §5 and §6.1.
- Stakeholder / objective ontology (§7–§9): states why the study did not use a cost index: it "is heavily dependent on the operator's internal financial cost structure and their fuel prices" and no two operators use the same one (p. 21). Supports treating cost index as private to the airline.
- Nothing for §2–§6.

## What was taken from it (2026-10-10)

- 737-9 weights used: maximum take-off 194,700 lb, maximum landing 163,900 lb, operating empty 105,000 lb; 179 seats; LEAP-1B28B1 at 28,000 lb thrust (p. 20).
- 737-9 block fuel at 152 passengers (p. 24): 1,144 US gallons over 485 NM in 112 minutes; 1,960 over 977 NM in 178 minutes; 3,443 over 1,824 NM in 294 minutes; 5,121 over 2,731 NM in 418 minutes.
- "A fuel density of 6.55lbs per USG was used for conversion to volume."
- "The 737-9 has an 11.2% to 12.7% lower fuel burn compared to the 737-900ER(W)" (p. 25).

## Method limits

- Long-range cruise speed, not a cost index. Optimum flight level assumed available. No holding or delay. Standard temperature. Winds at an 85 percent value for June; all routes westbound with a headwind.
- Block fuel includes taxi with both engines running. No cruise fuel flow is given.
- Software output, not flight data.

## Flags

- **Engine name is inconsistent:** LEAP-1B28B1 in the text and weights table, LEAP-1B27B1 in the results tables.
- One table cell prints "1.111" where 1,111 gallons is meant.
- **Read depth:** the 737-9 passages, the assumptions section and both results tables were extracted by script and read. The Airbus comparisons were skimmed. The owner has not read it.

## Rating

**4/5** — Type-specific fuel and weight numbers for the experiment's aircraft from a named analyst with stated assumptions. Trade press and software output, so supporting, not core.
