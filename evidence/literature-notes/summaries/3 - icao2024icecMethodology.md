# ICAO Carbon Emissions Calculator Methodology

- **File:** `evidence/sources/ICEC_Methodology_Passengers_v13.pdf`
- **Bib key:** `icao2024icecMethodology`
- **Authors:** International Civil Aviation Organization
- **Year:** 2024 (title page: Version 13.1, Aug 2024)
- **Venue:** ICAO methodology document, published with the ICAO Carbon Emissions Calculator
- **DOI:** none. URL: `https://www.icao.int/sites/default/files/environmental-protection/ENVtools/SuportingMaterials/ICEC_Methodology_Passagers_v13_Final.pdf`, linked from `https://www.icao.int/environmental-protection/environmental-tools/icec`

## What it is

A 37-page methodology document for ICAO's public calculator, which estimates the CO2 attributed to one passenger on a flight between two airports. It takes the scheduled aircraft types on the route, estimates fuel from a corrected great-circle distance, removes the share carried for cargo, divides among occupied seats by cabin class, and multiplies by 3.16.

## Why it's valuable — and to what

- Literature review section: none of §2–§4.
- Decomposition / architecture (§6, §10): none.
- Stakeholder / objective ontology (§7–§9): a public, internationally agreed way of stating a flight's emissions to a passenger. Relevant to the passenger's view of a flight.
- Optimization study (§11–§13): **one constant.** "3.16 = constant representing the number of tonnes of CO2 produced by burning a tonne of aviation fuel" (p. 6). The experiment uses this to convert a fuel difference into CO2 (`knowledge/models/experiment-options-and-scoring.md` §4.1). The calculator's own fuel estimate is not used; the experiment takes fuel from its own truth model.
- Glossary / terminology: ICEC (ICAO Carbon Emissions Calculator); GCD (great-circle distance).
- Other: the owner accepted this as the source for the CO2 factor on 2026-10-09 (D-015).

## Limits the document states itself (§5)

- Distance is the great-circle distance plus a fixed correction (50, 100 or 125 km by distance band), because collecting actual flown distances "showed to be not feasible for the time being".
- Load factors are averages by route group; "Version 13 data is based on traffic during calendar year 2016" (Appendix A).
- "Considerable differences in fuel consumption between aircraft belonging to the same aircraft type variant" are not captured.
- Passenger-to-cargo factors are held at their last published values, because the underlying dataset stopped publishing them.

## Criticisms from outside the document

These are leads from a web search on 2026-10-09. Only the first was read at its source. None is a registered source.

- **CO2 only.** ICAO's own FAQ (`https://icec.icao.int/FAQ`, read) says the calculator "is limited to the calculation of the CO2 amounts released into the atmosphere by the aircraft engines during a flight" and does not apply a Radiative Forcing Index or similar multiplier, because the scientific community "has not yet reached consensus". Other calculators are reported to apply multipliers of about 1.9 to 3 for effects such as contrails.
- **Low compared with other calculators, and calculators disagree.** Reported in an IATA publication on discrepancies between calculators, in a 2025 *Sustainability* review comparing the ICAO and EUROCONTROL estimators (average differences reported as about 2 to 28 percent), and in a 2020 travel-footprint paper (arXiv 2004.05603). Not read in full.
- **Why the first one matters here.** The experiment's options are altitude changes. Effects other than CO2, contrails in particular, depend on altitude, so a CO2-only measure may miss part of what a climb or descent changes. [C]: this link is from general knowledge and needs a source before the report states it.

## Rating

**3/5** — An authoritative source for one number the experiment needs, and a clear statement of what a CO2-only measure leaves out. The rest of the document (per-passenger allocation) is not used.

## Flags

- The title page says Version 13.1; ICAO's page labels the file v13 and the calculator "version 2026". Cited as Version 13.1, Aug 2024.
- The file name on ICAO's site misspells "Passengers" and "Supporting"; the local copy is renamed.
- Read for the constant, the calculation steps and §5. The appendices (load factors, aircraft mapping, fuel table) were not read.
- No owner highlights; the owner has not read this file.

## Processing metadata

- **Read depth:** pp. 1–9 read; appendices skimmed
- **Date processed:** 2026-10-09
