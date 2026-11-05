# Air Traffic by the Numbers (FY2024 data)

- **File:** `evidence/sources/air-traffic-by-the-numbers-FY2024.pdf` (61 pp.)
- **Bib key:** `faa2025airTrafficByNumbers`
- **Authors:** Federal Aviation Administration, Air Traffic Organization, System Operations Services, Office of Performance Analysis (System Events and Analysis Group, AJR-G3)
- **Year:** 2025 (cover dated June 2025; introduction signed May 2025). Data through fiscal year 2024.
- **Venue:** FAA report 2025-AJO-094, 9th edition of the annual "ATO Fact Book". URL: https://www.faa.gov/air_traffic/by_the_numbers/air-traffic-by-the-numbers-FY2024.pdf (found by search 2026-11-05; the file name on disk matches it).
- **DOI:** none

## What it is

The FAA Air Traffic Organization's annual statistical fact book. It reports a year of NAS traffic counts, facility counts, capacity, delays, diversions, go-arounds, cancellations, traffic management initiatives and safety metrics, mostly as charts and tables with a paragraph of commentary each. It has no method section: each figure names its data source (OPSNET, ASPM, TFMS, NTML and others).

## Why it's valuable, and to what

The report has no figure anywhere for how big the NAS is. This is the FAA's own source for one: "By FAA Order, Air Traffic by the Numbers ... is the official source of IFR flights counts" (p. 7). Page numbers below are the printed ones; the PDF page is the printed page plus 5.

- **Introduction (report Section 2), the scale of the system of systems:**
  - 16,191,379 IFR flights in FY2024 (p. 7), of which 9,802,886 were scheduled and 6,388,493 unscheduled (p. 2). FY2024 had 366 days, so about 44,200 a day; the FAA's landing page says "more than 44,000 flights" a day, from the same figure.
  - On the peak day (July 25, 2024), an average of 5,500 IFR flights were en route every minute between 1500 and 2200 GMT, with a maximum of 5,700 (p. 12).
  - 14,264 controllers (p. 2).
  - 21 air route traffic control centers and 4 combined control facilities (25 en route facilities), 146 TRACONs (121 of them combined with a tower), and 406 towers (142 federal, 264 contract) (pp. 2, 8).
- **Decomposition / architecture (§6, §10):** the facility counts and the hand-off description on p. 8 (towers pass departures to TRACONs, TRACONs to centers, centers to each other) are a citable description of the ATC hierarchy that the `atc` block abstracts into one box (D-038 kept it as one). They support the context diagram's text, not its structure.
- **Experiment framing (§11, report Sections 3 and 5):** 43.6 million center operations (p. 11) and 30,021 airborne holdings (p. 29) in FY2024. Useful only as context: see the flag below on what the book does not count.
- **Safety context:** 679 losses of standard separation across all centers in FY2024, against 1,026 in FY2023 and a pre-pandemic average of 1,221 (p. 33). A separation loss is the failure the controller's conflict resolution exists to prevent, so the count can frame why resolution is conservative. It is not a count of conflicts.
- **Traffic management initiatives (Future work under D-016):** 765 ground delay programs and 1,439 ground stops at the Core 30 airports, and 186 airspace flow programs (pp. 26 to 28).
- Literature review section: none of §2 to §4. This is data, not literature.
- Stakeholder / objective ontology (§7 to §9): none directly. Page 23 says the reasons for cancellations "may not necessarily be under FAA's control and air carriers cancel their own flights", a one-line confirmation of the airline's authority over cancellations.
- Optimization study (§11 to §13): none.
- Glossary / terminology: added to `knowledge/concepts/glossary.md`: CCF (combined control facility), OPSNET, and loss of standard separation. The book's own glossary (pp. 49 to 55) also defines Core 30, called rate and average daily capacity, which the project does not use.

## Rating

**3/5.** The authoritative source for the size of the NAS, which the report currently never states, and it will likely be cited once or twice in the Introduction. Not higher: it is aggregate counting data with nothing about intent, trajectories, decisions or the airline-to-ATC exchange the project studies, so it frames the report rather than supporting any claim in it.

## Flags

- **It does not count conflicts or resolutions.** Nothing in the book gives how many en route conflicts controllers resolve a year, or how many are level crossings like the experiment's. The case C − B result (−19.9 kg of system fuel for one conflict) cannot be scaled to a national figure from this source. Any such scaling needs a conflict count from elsewhere; none is in `evidence/sources/`.
- **A typo on p. 33:** the text says losses of standard separation fell "from 1,026 in FY2024 to 679 in FY2024". The table on the same page shows 1,026 is FY2023. Cite the table, not the sentence. Some center rows also swing hard year to year (ZMA 43 to 1, ZLA 92 to 10, ZLC 61 to 85); the source is "unpublished Airborne Loss Event data", so treat center-level counts with care.
- **Most tables and charts are images.** The figures above were read from the narrative text and from rendered pages 7, 11, 12 and 33 (PDF 12, 16, 17 and 38). Other tables were not checked against the text.
- **FY2024 is a fiscal year** (Oct 1, 2023 to Sep 30, 2024). Pilot certificates and GA activity are calendar-year figures (CY2024, CY2023).
- An FY2024 edition; the search on 2026-11-05 found no FY2025 edition yet. Recheck before final submission (Dec 13).
- Not a duplicate of anything registered.
- No digital highlights or comments in the PDF.

## Processing metadata

- **Read depth:** narrative text read in full; four image-only table pages read from rendered images; the appendices (facility codes, Core 30 list, historical operations) and glossary skimmed.
- **Date processed:** 2026-11-05
