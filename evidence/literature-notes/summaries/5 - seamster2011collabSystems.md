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

## Processing metadata

- **Read depth:** tables extracted and verified (2026-09-20 — see the annotation `annotations/seamster2011collabSystems.md`); narrative sections still skimmed only (abstract, introduction, §2.2 responsibilities, §2.3 interaction summaries, §3 method and collaboration discussion, TBO example); Sections 4–5 not read
- **Date processed:** 2026-09-20
