# Modeling with SysML (INCOSE 2010 tutorial)

- **File:** `evidence/sources/ModelingwithSysMLTutorial.pdf` (148 slides)
- **Bib key:** `friedenthal2010modelingSysmlTutorial`
- **Authors:** Sanford Friedenthal (Lockheed Martin), Joseph Wolfrom (Johns Hopkins University Applied Physics Laboratory)
- **Year:** 2010 (July)
- **Venue:** tutorial presented at the INCOSE International Symposium 2010, Chicago, IL. Hosted by JHU/APL at https://jhuapl.edu/sites/default/files/2023-03/ModelingwithSysMLTutorial.pdf (found by search 2026-11-05; same file name as the copy on disk).
- **DOI:** none

## What it is

A one-day tutorial slide deck on SysML version 1 (the slides cite specification v1.1 and v1.2), built on the OMG SysML specification and on Friedenthal, Moore and Steiner's book *A Practical Guide to SysML*, from which most figures are reproduced. It walks through the nine diagram types one by one (package, requirement, use case, block definition, internal block, activity, sequence, state machine, parametric), then allocation, with a parking garage gate as the running example and a dishwasher as the class exercise. It closes with the OOSEM process and a 2010 list of tools.

## Why it's valuable, and to what

- **The owner's SysML orientation, already in use.** Two of its slides are in `attachments/`: slide 10 ("4 Pillars of SysML", the requirements / behavior / structure / parametrics model with cross-links) as `sysml_diagram_relations.png`, and slide 11 (the nine-diagram taxonomy) as `syml_diagram_hierarchy.png`. Both are embedded in `projects/nas-sos-capstone/journal/2026-10-19.md`. The owner's model-map table of 2026-10-28 (content area by SysML v1 diagram by SysML v2 view) uses the same v1 vocabulary.
- **Report Section 3 (methodology) and Section 4 (system model):** the report cites no source at all for the SysML language. The deck could carry a citation for v1 terms the report uses: the seven requirement relationships, "Containment, Satisfy, Verify, Derive, Refine, Trace, Copy" (slide 51), and allocation as a mapping of activities, requirements or logical elements onto blocks (slides 130 to 135).
- **MBSE method (§10):** the OOSEM activity flow (slides 9 and 138: analyze needs, define system requirements, define logical architecture, synthesize allocated architecture, optimize and evaluate alternatives, validate and verify) is a named method the report could compare its own sequence against.
- Literature review section: none of §2 to §4. MBSE methodology background only.
- Decomposition / architecture (§6), stakeholder ontology (§7 to §9), optimization (§11 to §13): none.
- Glossary / terminology: OOSEM added to `knowledge/concepts/glossary.md`.

## Rating

**2/5.** Marginal. It has already helped the owner map v1 diagram types onto the model, and it is the only SysML language source in `evidence/sources/`. But the project's model is SysML v2 (D-006), which replaces v1's nine diagram types with views over one textual model, and a conference tutorial deck is a weak citation. For any SysML claim in the report, the OMG SysML v2 specification or a current Friedenthal book would be the stronger source; neither is held.

## Flags

- **SysML v1, not v2.** Do not cite it for how the project's model is built. Its diagram types, the «block» stereotype and its tool list all predate SysML v2. Cite it only for v1 vocabulary, or for the history the report gives (the v1 diagram set the owner mapped from).
- **Secondary source.** The diagrams are reproduced from *A Practical Guide to SysML* (Elsevier, 2008 and 2009 editions); the book is the primary source for them and is not held.
- **Misleading PDF metadata.** The PDF's title field reads "Briefing at introductory meeting with AFIT students and Advisor", left over from a slide template. The real title is on slide 1.
- Copyright: slides are marked © OMG 2006 to 2009, © JHU/APL 2010 (all rights reserved), © Lockheed Martin and © Elsevier. Fine for the owner's notes; a figure reused in the submitted report needs a credit line.
- Not a duplicate of anything registered. The register's MBSE papers (`hill2024nasaMbseHumanExploration`, `maheshwari2015sysmlAbmAtc` and others) apply SysML; none teaches the language.
- No digital highlights or comments in the PDF.

## Processing metadata

- **Read depth:** skimmed: agenda, introduction, every section summary slide, allocation, OOSEM and wrap-up read; the per-diagram worked examples were not read slide by slide.
- **Date processed:** 2026-11-05
