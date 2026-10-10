# ICAO Aircraft Engine Emissions Databank (issue 32)

- **File:** `evidence/sources/icao-engine-emissions-databank-v32.xlsx`
- **Bib key:** `icao2026engineEmissionsDatabank`
- **Authors:** International Civil Aviation Organization; hosted by the European Union Aviation Safety Agency; data supplied by engine manufacturers
- **Year:** 2026 (issue 32, March 2026)
- **Venue:** spreadsheet, four worksheets ("Record of Changes", "Column Description", "Gaseous Emissions and Smoke", "nvPM Emissions")
- **DOI:** none. Page: `https://www.easa.europa.eu/easa-and-you/environment/icao-aircraft-engine-emissions-databank`; file: `https://www.easa.europa.eu/en/downloads/131424/en`

## What it is

The certification record of exhaust emissions and fuel flow for turbofan engines, measured on a test stand at four thrust settings that stand for a landing and take-off cycle: take-off (100 percent of rated thrust), climb-out (85), approach (30) and idle (7).

## Why it's valuable — and to what

- Optimization study (§11–§13): an authoritative fuel flow for the 737 MAX 9's engine at low-altitude thrust settings. Used in `knowledge/models/b737-max9-rules-of-thumb.md` §6.2.
- Stakeholder / objective ontology (§7–§9): the same rows carry NOx, CO, hydrocarbon and particulate indices, if the community and environment objectives ever need a local air quality measure alongside CO2 (`icao2024icecMethodology`).
- Nothing for §2–§6.

## What was taken from it (2026-10-10)

One row from "Gaseous Emissions and Smoke": engine "LEAP-1B28/28B1/28B2/28B3", record 08P28CM143, combustor TAPS II, bypass ratio 8.24, rated thrust 130.4 kN. Fuel flow per engine: take-off 1.070 kg/s, climb-out 0.870, approach 0.290, idle 0.100. Fuel over the standard cycle 386 kg.

## Flags

- **Sea-level, static, test-stand values.** There is no cruise point. Not usable for cruise or for idle descent at altitude.
- The file has several superseded LEAP-1B28 rows (18CM084, 20CM101, 01P20CM140) with slightly different values. The row used is the one with no "superseded by" entry.
- Which LEAP-1B rating a given 737 MAX 9 carries was not checked against the type certificate. The 130 kN rating matches the EUROCONTROL page for the type.
- **Read depth:** LEAP-1B rows only, extracted by script.

## Rating

**3/5** — Authoritative, but it answers a narrow question (ground and low-altitude fuel flow) that the en-route experiment barely needs.
