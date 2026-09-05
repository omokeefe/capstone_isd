# System-of-Systems Safety for Low-Altitude Aviation Transportation

- **File:** `references/System-of-systems safety for low-altitude aviation transportation.pdf`
- **Bib key:** `yao2026loAltitudeSoSSafety`
- **Authors:** Yao, Anzhuo; Li, Shanghan; Feng, Kaifeng; Zhang, Tengfei; Song, Xueying;
  Wang, Lizhi; Wang, Ruixin; He, Peng; Zhou, Hang; Li, Hang; Ding, Shuiting; Li, Daqing
  (corresponding author)
- **Year:** 2026
- **Venue:** Reliability Engineering and System Safety, Vol. 273, Article 112276
- **DOI:** 10.1016/j.ress.2026.112276

## What it is

A systematic literature review (Beihang University / Civil Aviation University of China;
106 of 6,402 initially identified sources, screened via ASReview) framing low-altitude
(LA) aviation transportation (UAM, eVTOL, drones/UAS) as a new System-of-Systems using
the ISO/IEC/IEEE 42010 architecture lens (composition/environment interaction;
organizational/operational structure; governance/evolution principle). Analyzes new
SoS-level risk patterns versus conventional aviation and proposes a three-part safety
engineering framework: architecture design (human-automation safety control loop + digital
flight rules), testing & evaluation (digital-physical test platforms), and safety
management (extending traditional SMS toward an In-Time Aviation Safety Management System,
IASMS).

## Why it's valuable — and to what

- Literature review section: none of §2-4 directly — LA/UAM-specific, not commercial-
  airline-ops literature. Its own SLR methodology (research questions → search strings →
  inclusion/exclusion → ASReview screening) is a usable rigor template if needed.
- Decomposition / architecture (§6, §10): strong fit. The ISO/IEC/IEEE 42010-based
  three-facet decomposition parallels the capstone's own D-002 domain decomposition
  (Governance, Airspace Management, Flight Operations, etc.) and could be cited as an
  architecture-standard justification for that structure. Its safety control loop
  (Leveson STAMP: Controller-Actuators-Sensors-Controlled Process, human-automation
  collaboration, multi-level command/feedback) is directly reusable framing for how
  operational intent/commands propagate down to aircraft-level behavior — the capstone's
  central storyline.
- Stakeholder / objective ontology (§7-9): strong fit. §3.3 (Governance and evolution)
  explicitly documents multi-stakeholder conflict patterns — "divergent stakeholder
  objectives cause uneven safety prioritization," "incentive misalignment can push
  stakeholders to optimize local efficiency at the expense of system resilience,"
  "fragmented authority... can blur accountability... during critical events" — directly
  usable as literature evidence for local-vs-system-level (myopic) optimization conflicts
  and stakeholder/authority mapping.
- Optimization study (§11-13): weak/indirect — mentions digital twins, multi-agent
  simulation, Monte Carlo testing as future-research directions, but not an optimization
  paper itself.
- Glossary / terminology: SoS (Maier's 5 properties, Boardman & Sauser's 5
  characteristics), ISO/IEC/IEEE 42010 architecture facets, IASMS, STAMP (Leveson),
  "digital flight rules," "safety control loop," NASA UAM Maturity Levels,
  "monitor-assess-mitigate" decision loop.
- Other: could inform the §1 SOI-boundary open question by illustrating how a closely
  related SoS (LA/UAM airspace) has been explicitly bounded and distinguished from
  "traditional aviation" — a useful contrast case for scoping the capstone's own NAS
  boundary.

## Rating

**4/5** — Not core because its domain (low-altitude/UAM/drone operations) is adjacent to,
not the same as, the capstone's general NAS/commercial-aviation-trajectory focus — it
explicitly distinguishes LA SoS from "traditional aviation." But it is rigorous
(top-tier journal, 106-source systematic review, Jan 2026), and its architectural framing
(42010 facets, STAMP-based safety control loop, governance/stakeholder-conflict analysis)
is directly transferable to §6/§7/§9/§10. Selected for deep annotation in the 2026-09-04
literature-review pass.

## Flags

Not a duplicate of `delaurentis2005sosTransportation` (general transportation-SoS design
framing vs. this paper's domain-specific LA/UAM safety review) — complementary. Note: this
paper's own reference list cites a *different* DeLaurentis 2005 paper ("A Taxonomy-Based
Perspective for Systems-of-Systems Design Methods," IEEE SMC 2005) for its SoS taxonomy —
worth cross-checking whether the registered `delaurentis2005sosTransportation` PDF matches
"Understanding Transportation..." or this SMC taxonomy paper (flagged in
`references.bib` and `open-questions.md`). Domain-adjacent, not duplicate, to
`sadik2025holonicUAM` (both UAM/low-altitude-as-SoS, but this is a safety-literature
review/framework vs. that paper's proposed holonic architecture technique). All bib
fields confirmed directly from the PDF.

## Processing metadata

- **Read depth:** Fully read (all 12 pages)
- **Date processed:** 2026-09-04
