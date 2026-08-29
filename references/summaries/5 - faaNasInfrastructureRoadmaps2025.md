# NAS Enterprise Architecture: Infrastructure Roadmaps

- **File:** `references/NAS-Infrastructure-Roadmaps-v20.pdf`
- **Bib key:** `faaNasInfrastructureRoadmaps2025`
- **Authors:** Federal Aviation Administration
- **Year:** 2025 (Baseline, May 2025)
- **Venue:** FAA NAS Enterprise Architecture planning document
- **DOI:** none — government planning document, not an academic source

## What it is

The FAA's own roadmap of NAS investments, organized by domain (Aircraft, Airport, Airspace
& Procedures, Automation, Commercial Space, Communication, Enterprise Services &
Capabilities, Extensible Traffic Management, Facilities, Human Systems Integration,
Information Systems Security, Navigation, Safety, Surveillance, Weather), showing a 17-year
outlook of projects, systems, services, and decision points evolving the NAS from "As-Is" to
"To-Be."

## Why it's valuable — and to what

- Literature review section: none of §2-§4 / most relevant to §1 (SOI definition) and §6
  (decomposition alternatives).
- Decomposition / architecture (§6, §10): **this is the single most important cross-check
  available for the domain decomposition itself.** The FAA's own domain list (Aircraft,
  Airport, Airspace, Automation, Communication, Navigation, Safety, Surveillance, Weather,
  Human Systems, Information Security, etc.) is an authoritative, real-world decomposition
  of the NAS to compare directly against the candidate domain list in
  `assistant/memory/project-brief.md` (Governance, Airspace Management, Airspace Resources,
  Flight Operations, Airport Operations, Aircraft Systems, Information Services,
  Infrastructure, Decision Support). Worth an explicit reconciliation pass before finalizing
  the decomposition in §6.
- Stakeholder / objective ontology (§7-§9): implicitly encodes FAA investment priorities and
  timelines, which is evidence for the "Political"/"Regulatory Compliance" stakeholder
  objectives already in `assistant/memory/stakeholder-register.md`.
- Glossary / terminology: CIP (Capital Investment Plan), NSIP, OI/BTI (Operational
  Improvement / Business Trigger Item), xTM (Extensible Traffic Management).

## Rating

**5/5** — core, authoritative primary source for the SOI-boundary and decomposition work;
this is exactly the kind of "ground truth" reference an ISD capstone's architecture
decisions should be checked against.

## Flags

**Version mismatch:** the filename says `v20`, but the document's own title page reads
"Infrastructure Roadmaps v19.1" (Baseline, May 2025). Worth confirming which version is
actually current before citing a specific version number in the final paper — either the
filename anticipates an unreleased v20, or it was renamed incorrectly when saved.

## Processing metadata

- **Read depth:** skimmed (pages 1-3, cover + content summary + roadmap-legend page — this
  is a large slide-deck-style document; a full read of all domain roadmaps was not done)
- **Date processed:** 2026-08-29
