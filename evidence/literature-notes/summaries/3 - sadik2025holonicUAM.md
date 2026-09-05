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

## Processing metadata

- **Read depth:** Fully read (all 7 pages)
- **Date processed:** 2026-09-04
