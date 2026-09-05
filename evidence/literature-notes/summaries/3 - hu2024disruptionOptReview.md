# Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024

- **File:** `references/Review of Optimization Problems, Models and Methods for Airline Disruption Management from 2010 to 2024,.pdf`
- **Bib key:** `hu2024disruptionOptReview`
- **Authors:** Hu, Yuzhen; Wang, Sirui; Zhang, Song; Li, Zhisheng
- **Year:** 2024
- **Venue:** Digital Transportation and Safety, Vol. 3, Issue 4, pp. 246-263
- **DOI:** 10.48130/dts-0024-0022

## What it is

A bibliometric/statistical literature review (Harbin Engineering University) of 69
journal papers (2010-2024) on airline disruption management, classifying studies by
journal/field distribution, publication-year trend, and — most substantively — by degree
of integrated recovery (aircraft, crew, and passenger recovery treated singly, in pairs,
or jointly), concluding with identified research gaps and future directions in problems,
models, and solution methods.

## Why it's valuable — and to what

- Literature review section: §4 (OCC/dispatch/disruption management) — a recent, broad
  survey to sit alongside `hassanDisruptionReview` and `santana2023arpReview`.
- Decomposition / architecture (§6, §10): weak — no architectural or systems-decomposition
  content, only a resource-integration taxonomy (aircraft/crew/passenger), more a
  decision-domain grouping than an architecture artifact.
- Stakeholder / objective ontology (§7-9): its integrated-vs-single-resource recovery
  classification is a clean, literature-backed illustration of the local-vs-system-level
  optimization tension for §9 — optimizing aircraft recovery alone vs. jointly with
  crew/passengers is exactly a myopic-vs-system-wide tradeoff.
- Optimization study (§11-13): useful as a map of solution-method types
  (exact/heuristic/hybrid) and identified future research directions.
- Glossary / terminology: "integrated recovery," AOCC (shared with Hassan), "recovery
  resource."

## Rating

**3/5** — Explicitly a bibliometric/optimization-methods survey with no
systems-architecture framing, consistent with the capstone's caution against pure-
optimization deep-dives. Genuinely useful for currency/trends and the integrated-vs-
single-resource framing relevant to §9, but redundant in coverage with the stronger
`hassanDisruptionReview` (better AOCC-practice framing) and `santana2023arpReview` (deeper
on the aircraft-recovery sub-problem) — a corroborating/contextual citation, not primary.

## Flags

**Not a duplicate** of `hassanDisruptionReview` (2009-2018, critical/qualitative,
practice-gap framing) — this paper extends coverage to 2010-2024 with a different,
bibliometric/statistical lens. Also complementary to (not a duplicate of)
`santana2023arpReview` — that review is narrow-and-deep on aircraft recovery alone; this
one is broad-and-shallow-per-paper across aircraft/crew/passenger recovery. Substantial
thematic overlap across all three disruption-management sources in this batch — worth
noting so a future pass doesn't over-cite all three redundantly. All bib fields confirmed
directly from the PDF.

## Processing metadata

- **Read depth:** Skimmed (title page, abstract, intro, "previous research and
  motivation," conclusion, and reference list; middle classification sections not read
  in full)
- **Date processed:** 2026-09-04
