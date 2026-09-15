# Model-Driven Requirements Engineering: Synchronising Models in an Air Traffic Management Case Study

- **File:** `evidence/sources/Model-Driven Requirements Engineering - Synchronising Models in an Air Traffic Management Case Study.pdf`
- **Bib key:** `maiden2004rescueDman`
- **Authors:** Maiden, N. A. M.; Jones, S. V.; Manning, S.; Greenwood, J.; Renou, L.
- **Year:** 2004
- **Venue:** 16th International Conference on Advanced Information Systems Engineering (CAiSE
  2004), Riga, Latvia — Lecture Notes in Computer Science, vol. 3084, pp. 368-383
- **DOI:** none found (year/venue confirmed via web search; not printed on the PDF's captured
  pages)

## What it is

A primary requirements-engineering case study, co-authored with National Air Traffic Services
(NATS, UK) and Sofreavia-CENA (France) engineers. Describes the application of RESCUE
(Requirements Engineering with Scenarios for User-Centred Engineering), a process integrating four
modeling techniques — human activity modeling, i* strategic dependency/rationale (goal) modeling,
use-case modeling, and requirements management — synchronized via 5 checkpoint workshops, to
determine requirements for DMAN (Departure Manager), a real socio-technical system for scheduling
and managing aircraft departures at major European airports (Heathrow, Charles de Gaulle).

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §2-§4 — real-world requirements-engineering practice
  on an actual operational ATM system (DMAN), co-authored by the operational stakeholder (NATS).
- Decomposition / architecture (§6, §10): the RESCUE process's synchronized multi-model approach
  (human activity + goal/actor dependency + use cases) is a directly applicable pattern for
  decomposing a socio-technical NAS-SoS boundary and allocating functions between human and
  automated actors — the i* Strategic Dependency model for DMAN (Figure 3) is essentially an
  actor-goal-dependency architecture diagram for a real ATM subsystem.
- Stakeholder / objective ontology (§7-§9): directly relevant — the i* goal-modeling stream
  explicitly captures actor goals, soft goals (e.g., "workload should not be increased"), resource
  dependencies, and requirements traced to specific actors (Runway ATCO, Tower Departure
  Sequencer, TMA Departure Coordinator), a strong methodological precedent for this capstone's
  stakeholder/objective ontology work.
- Optimization study (§11-§13): not directly applicable.
- Glossary / terminology: RESCUE, i* (Strategic Dependency / Strategic Rationale models),
  synchronisation checkpoints.

## Rating

**4/5** — Strong supporting: a real, NATS-co-authored requirements case study on an actual
European ATM system (DMAN) with directly transferable stakeholder/goal-modeling technique —
probably citable for both the requirements-methodology and stakeholder-ontology portions of the
capstone, short of a 5 only because it predates and doesn't use SysML/MBSE terminology directly.

## Flags

Bibliographic year/venue were not visible on the PDF's captured pages (no explicit publication
info shown); confirmed via web search against City University London's institutional repository
(City Research Online) as CAiSE 2004, LNCS 3084. No duplicates found in the register.

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (6 found) not extracted -- not requested._

**Page 2**
- **Highlight:** "g and task analysis from human-computer interaction are two
Safety-critical socio-technical systems such as ATM demand obvious examples. Safety-critical socio-technical systems such as ATM demand
rigorous analyses of controller work, software systems that support this controller rigorous analyses of controller work, software systems that support this controller
work, and the complex interactions between the controllers, the air traffic and the work, and the com
software systems."

## Processing metadata

- **Read depth:** fully read (8 pages, through Section 4)
- **Date processed:** 2026-09-13
