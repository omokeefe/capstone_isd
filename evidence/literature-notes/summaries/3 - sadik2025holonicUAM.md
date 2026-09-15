# Urban Air Mobility as a System of Systems: An LLM-Enhanced Holonic Approach

- **File:** `references/Urban Air Mobility as a System of Systems An LLM-Enhanced Holonic Approach.pdf`
- **Bib key:** `sadik2025holonicUAM`
- **Authors:** Sadik, Ahmed R.; Ashfaq, Muhammad; Mäkitalo, Niko; Mikkonen, Tommi
- **Year:** 2025
- **Venue:** 20th Annual System of Systems Engineering Conference (SOSE), IEEE
- **DOI:** not confirmed (see Flags)

## What it is

A short (6-page) IEEE conference paper (Honda Research Institute Europe / University of
Jyväskylä) proposing a holonic System-of-Systems architecture for Urban Air Mobility in
which each constituent system ("holon") has a three-layer internal structure (Reasoning,
Communication, Capabilities), with the Reasoning layer's decision-making driven by a
Large Language Model that parses natural-language requests, incorporates real-time
context (weather, traffic, airspace status), and generates/re-plans multimodal trip
strategies. Illustrated via a conceptual case study (scooter + air-taxi multimodal trip),
not a real-world deployment — no simulation results, no optimization formulation, no
empirical validation.

## Why it's valuable — and to what

- Literature review section: none of §2-4 — UAM/air-taxi scope, not conventional
  NAS/airline dispatch/turnaround literature.
- Decomposition / architecture (§6, §10): strong fit. The holonic decomposition pattern
  (Supervisor → Planner → Task → Resource holons, each recursively composed of
  Reasoning/Communication/Capabilities layers) is a directly relevant alternative
  decomposition paradigm to consider or contrast against the capstone's own NAS-as-SoS
  decomposition — structurally analogous to the capstone's "enterprise objectives down to
  aircraft trajectory" propagation problem (Supervisor Holon's strategic goals → Planner
  Holon's task sequences → Task Holon's atomic actions). Worth citing as a comparison
  architecture pattern even though the capstone's own architecture is SysML/MBSE-based.
- Stakeholder / objective ontology (§7-9): weak/indirect — the Supervisor Holon's
  human-in-the-loop override mechanism (regulation check → sensor feasibility check →
  human review) is a minor data point for objective/authority allocation between
  automated and human decision-makers.
- Optimization study (§11-13): minimal — explicitly no simulation/optimization results;
  flags large-scale simulation/testbeds as future work.
- Glossary / terminology: "holon"/"holonic architecture" (a semi-autonomous, recursively
  nested unit, simultaneously a self-contained whole and a subordinate part of a larger
  structure), "holarchy" (the recursive hierarchy of holons).
- Other: relevant as evidence (not content) for the §1 SOI-boundary open question — its
  UAM scope is the same category the open boundary question is asking about; its presence
  is itself a data point that UAM material keeps entering the corpus, worth resolving that
  scope question explicitly.

## Rating

**3/5** — Rigorous, recent (2025), IEEE-conference-vetted, and its holonic decomposition +
top-down intent-propagation structure genuinely rhymes with the capstone's central
"enterprise objectives → aircraft trajectory" story, earning a real seat at §6/§10. Loses
points because it's UAM-scoped (not classical-NAS-scoped, and the SOI boundary is still
open), has zero empirical/simulation validation (purely conceptual with a toy case study),
and its central novel contribution (LLM-as-reasoning-engine) is largely orthogonal to the
capstone's optimization-as-a-capability framing.

## Flags

DOI unverified — only an IEEE Xplore document ID (11083807) found via search, not the DOI
string itself; needs a direct IEEE Xplore lookup. This is an author preprint (also
arXiv:2505.00368), not the IEEE-typeset final version. Domain-adjacent, not duplicate, to
`yao2026loAltitudeSoSSafety` (both UAM/low-altitude-as-SoS, but this paper is architecture/
coordination/LLM-agent design vs. that paper's safety-literature review). Not a duplicate
of `sinharoy2024ontologyUAM` — same general topic (UAM-as-SoS architecture) but a
methodologically distinct approach (holonic multi-agent + LLM reasoning vs.
ontology-driven MBSE); complementary. A related companion source not yet in the corpus:
the same authors' earlier general (non-UAM) paper, arXiv:2501.07992 ("LLM-enhanced holonic
architecture for ad-hoc scalable SoS") — flagged as a possible future addition, not
registered.

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (0 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "1 May 2025"
- **Highlight:** "presents an intelligent holonic architecture that incorporates Large Language Model (LLM) to manage the com- plexities of UAM"
- **Highlight:** "Holons function semi-autonomously, allowing for real-time coordination among air taxis, ground transport, and vertiports. LLMs process natural language inputs, generate adaptive plans, and manage disruptions such as weather changes or airspace closures"
- **Highlight:** "The architectural requirements of UAM are fundamentally shaped by its SoS nature [9], [10]"
- **Highlight:** ". Table I contrasts traditional systems with SoS, highlighting key differences in autonomy, interoperability, diversity, and emergent behaviors [11]."

**Page 2**
- **Highlight:** "Emergent Behaviors: Managing unpredictable system phenomena, such as demand-driven resource allocation, adaptive route planning, and congestion resolution, that cannot be anticipated or controlled by centralized mech- anisms"

**Page 3**
- **Highlight:** "Holonic architecture"
- **Highlight:** "recursive hierarchy of mediator-based coordi- nation, forming dynamic holarchies where high-level nodes fo- cus on strategic goals while lower-level holons handle tactical operations"

**Page 5**
- **Highlight:** "A passenger"
- **Highlight:** "requests a ride from point X to point Y"
- **Highlight:** "Su- pervisor Holon (S-SoS) receives this request and collaborates with its two subordinate supervisors: Scooter Supervisor"
- **Highlight:** "AirTaxi Supervisor (S-CS2)"
- **Highlight:** "Planner Holon generates a trip structure"
- **Highlight:** "Each LLM-powered holon independently handles mission- critical
tasks—translating
passenger
requests
into airspace-compliant routes, negotiating landing slots with vertiports, and replanning for battery constraints— without central bottlenecks"
- **Highlight:** "Holons continuously integrate live operational data via LLM prompts, including sudden no-fly zones, vertiport congestion alerts, or traffic pattern shifts"

## Processing metadata

- **Read depth:** Fully read (all 7 pages)
- **Date processed:** 2026-09-04
