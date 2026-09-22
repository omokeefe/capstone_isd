# Collaborative Systems Assessment: Flightdeck, Air Traffic Control, Flight Operations Center and Automation

- **File:** `evidence/sources/Collaborative Systems Assessment - Flightdeck, Air Traffic Control, Flight Operations Center and Automation.pdf`
- **Bib key:** `seamster2011collabSystems`
- **Authors:** Seamster, Thomas L.; Chevalley, Eric; Kanki, Barbara G.
- **Year:** 2011 (August, Draft Final Report)
- **Venue:** NASA Ames Research Center report for FAA (Office of NextGen Human Factors, AJP-61); FAA task 05-04 / AJP61SSP-0050
- **DOI:** none

## What it is

A 142-page FAA-sponsored technical report (a draft). It reviews the literature and state of practice
for the roles and responsibilities of flightdeck, ATC and flight operations center (FOC) personnel;
builds a synchronized task listing into a **Flightdeck-ATC-FOC Interaction Matrix** (by flight phase,
communication medium, collaborators and interactions; Appendix E); examines how NextGen changes those
responsibilities; and proposes a framework and tool for assessing future collaborative arrangements
with automation as a fourth collaborator. It includes a trajectory-based-operations (TBO) worked example
(§4.2) and pilot/FOC communication surveys and ATC data collection (appendices).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (OCC, dispatch & flight execution) — the most
  direct source in the register for how the flight deck, ATC and the airline OCC interact in current
  operations; a candidate source for the "nominal ATC/IFR flight execution" item still marked
  TBD there.
- Decomposition / architecture (§6, §10): task-level allocation of functions among four actors
  (flight deck, ATC, FOC, automation), and the interaction points between them — a template for
  actor-to-actor information flows in the SysML model; the TBO example is close to the project's
  trajectory-intent framing.
- Stakeholder / objective ontology (§7-§9): **strong.** Written for exactly the "who is responsible
  for what, and what happens when it moves" question behind §7 and the RACCI work. §2.2 gives current
  responsibilities for flight deck, ATC (by facility/position) and FOC (the dispatch release is
  signed by both dispatcher and captain — the joint-authority case), and §4 discusses redistributing
  responsibilities. It feeds the personas file (Captain, ATC controller, dispatcher, and the
  tower/ground/TRACON/ARTCC-position stubs) and RACCI rows.
- Optimization study (§11-§13): not applicable.
- Glossary / terminology: FOC = AOC = OCC (this report treats FOC/AOC as equivalent), collaborative
  decision making, TMI, TBO/4D, CSA (collaborative system assessment); the acronym list is broad.
- Other: the transition-to-NextGen framing ("keep current high-level responsibilities to preserve
  the allocation of expertise") is a useful design principle for any future-state ConOps.

## Rating

**5/5** — Core: the register's best single source on flightdeck-ATC-FOC roles, responsibilities and
interaction points, directly serving the personas, the RACCI (§7) and the trajectory-intent chain.

## Flags

- **Draft, not final** — the documentation page has unfilled fields (report number, "Click here to enter
  text") and the header reads "Draft Report"; look for a published final before citing page-specific
  claims. (The body is ~86 pages plus appendices; the cover says 142 total pages.)
- 2011 (NextGen-era): specific programs and procedures have moved on; use it for roles, responsibilities and
  interaction structure rather than current procedures.
- Companion to `berry2011aocActors` (both FAA AJP-61 human-factors work on the AOC/FOC role) —
  complementary, not duplicate. Overlaps in subject with `clarke1998irregular`.
- Deep extraction done 2026-09-20 for the interaction tables (see the annotation); Sections 4–5 (NextGen) and the §2.2 narrative are not yet extracted.

## Highlighted passages

_Digital highlights the user marked up in the PDF (29 found, no ink annotations), extracted 2026-09-21 via `tools/extract_pdf_annotations.py`. Prose highlights are verbatim; highlights on table captions or whole tables are listed by caption only — the full interaction tables are already extracted in `annotations/seamster2011collabSystems-interactions.md/.csv`._

**Page 6**
- **Highlight:** "The objective of the human factors program is to develop and implement human factors policies, regulations, programs, and procedures which promote the safety and productivity of the NAS."

**Page 7**
- **Highlight:** "Conduct literature and state-of-the-practice reviews"
- **Highlight:** "Delineate roles and responsibilities of flightdeck, ATC and FOC in current operations and identify interaction/collaboration points"
- **Highlight:** "Product: Flightdeck-ATC-FOC Interaction Matrix (see Section 3 of this Report and Appendix E)."

**Page 43**
- **Highlight:** "The goals were threefold, to: 1) Identify and describe current interactions that are potential candidates for NextGen collaboration, 2) Provide operational context for assessing collaborative procedures, and 3) Provide a basis for assessing collaborative scenarios and procedures"
- **Highlight:** "The sequence of the interaction points were drawn from flightdeck, ATC and FOC documentation and data collections in sections 2.2 and 2.3. Flightdeck information came from documents, such as Federal Aviation Regulations 14 CFR Part 91, Part 121, S-8081-12B, the Aeronautical Information Manual, and a Flight Operation Manual, as well as from data, such as a cognitive task analysis (proprietary) and the pilot survey reported in section 2.3. Controllers’ information came from documentation gathered in JO 7110.65T, SOPs, and LOAs, as well as from data collected for the task listing and process charts in section 2.3. Dispatcher information came from regulatory documents, such as 14 CFR Part 121, S-8081-10C, 8900.1, as well as data collected during observation logs and from the dispatcher survey described in Section 2.3.3."

**Page 49**
- **Highlight (Table 3.1, "Current Possible Collaborative Interactions"):** the whole table — interaction by flight phase (flight planning, taxi-out, cruise, off-nominal rerouting, holding, descent, final approach, missed approach), with the collaborating groups (FOC-ATC, flightdeck-FOC, flightdeck-ATC, and intra-ATC pairs such as GC/LC, TMU/en route/APP/LC, LC/DEP, DEP/APP) and the medium (telcon/telephone, radio, face-to-face, Satcom/ACARS).

**Page 74**
- **Highlight (Table 5.1, "Functions by Collaborators by the Dimension of Time Criticality"):** the whole table (checked against the rendered page; the text layer scrambles it). Rows = time criticality, columns = collaborator:
  - *Time critical:* flightdeck — collision avoidance or emergency; FOC — emergency or unusual situation management; ATC — emergency or unusual situation management; automation — collision avoidance.
  - *Time sensitive:* flightdeck — navigation; FOC — spacing and merging or management; ATC — separation management; automation — separation management.
  - *Planning:* flightdeck — flight management; FOC — flight management; ATC — flow or airspace management or traffic management; automation — flow or airspace management.
  - (PDF page 74; the report's own page label is "72 of 86".)

**Page 80**
- **Highlight:** "With proper Flightdeck displays to generate trajectory reroutes and with the Flightdeck responsible for the reroutes, it is possible to reduce ATC workload with just moderate increase in Flightdeck workload during cruise that generally has lower workload operations. With proper Flightdeck tools to help generate and analyzed trajectory reroutes and with the Flightdeck responsible for the reroutes, it is possible to reduce ATC workload with minor increase in Flightdeck workload during cruise operations. With shared weather and wind information, it should be possible for ATC and the Flightdeck to maintain shared situation awareness. With automation, either ground or airborne, responsible for generating the reroutes with both ATC and Flightdeck options for rejecting the automated solution, along with shared situation awareness, it is possible that both ATC and Flightdeck workload would be reduced."

**Appendices (captions only)**
- p. 91 Table A.1 (nominal pilot communication, frequency/criticality survey); p. 92 Table A.2 (off-nominal pilot communications); p. 94 Figure 1 (extract of a handoff between two ARTCC sectors); p. 96 Table C-1 (nominal interactions with flightdeck and FOC); p. 97 Table C-2 (nominal interactions within ATC); p. 98 Table C-3 (off-nominal interactions with flightdeck/FOC and within ATC).
- pp. 103-115 Tables E-1 through E-13: flightdeck-ATC-FOC interactions by phase of a generic flight — planning before release (E-1), planning after release (E-2), pushback (E-3), taxi-out (E-4), takeoff (E-5), cruise (E-6), off-nominal cruise (E-7), continued cruise (E-8), second off-nominal cruise (E-9), descent (E-10), final approach (E-11), off-nominal final approach (E-12), landing and taxi-in (E-13).

**What the markup emphasizes:** the report's product (the Flightdeck-ATC-FOC interaction matrix), where the interaction points came from (14 CFR 91/121, AIM, JO 7110.65T, 8900.1 — the same source list the to-do §4 nominal-flight gap refers to), and the time-criticality x collaborator grid of functions (Table 5.1). The highlighted page-80 passage (reroute generation shared among flightdeck, ATC and automation) is one of the few NextGen-collaboration conclusions marked.

## Processing metadata

- **Read depth:** tables extracted and verified (2026-09-20 — see the annotation `annotations/seamster2011collabSystems.md`); narrative sections still skimmed only (abstract, introduction, §2.2 responsibilities, §2.3 interaction summaries, §3 method and collaboration discussion, TBO example); Sections 4–5 not read
- **Date processed:** 2026-09-20
