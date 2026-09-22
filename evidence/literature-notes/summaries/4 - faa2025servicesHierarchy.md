# FAA Services Hierarchy

- **File:** `evidence/sources/faa-services-hierarchy.pdf`
- **Bib key:** `faa2025servicesHierarchy`
- **Authors:** Federal Aviation Administration (PDF author field: "ANG-B2")
- **Year:** 2025 (PDF creation date 2025-02-24; no version or date on the slide itself)
- **Venue:** FAA NAS Enterprise Architecture (one-page slide, PowerPoint export)
- **DOI:** none

## What it is

A single-page FAA slide showing the FAA's service taxonomy as a two-level tree: nine numbered
service groups, each with numbered component services. The FAA's NAS Enterprise Architecture pages
describe the hierarchy as a set of solution-independent, time-invariant core services that bound the
NAS EA. There is no narrative, rationale, or definition of any service on the slide — it is a
structure diagram only.

The nine groups and their component services:

| # | Group | Component services |
|---|---|---|
| 1 | Air Traffic Management | 101 Flight Planning; 102 Air Traffic Control - Separation Assurance; 103 Air Traffic Control - Advisory; 104 Traffic Management - Synchronization; 105 Traffic Management - Strategic Flow; 106 Emergency and Alerting; 107 Navigation; 108 Airspace Design and Management; 109 Government/Agency Support |
| 2 | Airport Management | 201 Grants Management; 202 Airport Safety Certification and Compliance; 203 Airport Planning and Development |
| 3 | Security | 301 Facilities Security; 302 Information Security; 303 Personnel Security; 304 Emergency & Disaster Planning & Response |
| 4 | Safety | 401 Aviation Safety; 402 Facilities Safety; 403 Hazardous Materials Management |
| 5 | Enterprise Management | 501 FAA Strategies, Planning, and Concepts; 502 Acquisitions; 503 Regional Administration; 504 FAA Facilities; 505 FAA Technical Operations; 506 Training; 507 Workforce Planning and Development (Human Resources); 508 Budget and Financial Management; 509 Enterprise Policy and Guidance Development; 510 Legal; 511 Public Affairs, Information, and Outreach |
| 6 | Certification | 601 Risk-Based Decision Making; 602 Aircraft Certification; 603 Flight Standards; 604 Rulemaking; 605 Accident Investigation; 606 Aviation Medicine |
| 7 | Environment and Energy | 701 Science and Tools; 702 Technology; 703 Alternative Fuels; 704 Policy Development |
| 8 | Commercial Space Transportation | 801 CST Licensing and Permits; 802 CST Safety; 803 CST Rulemaking; 804 CST Infrastructure; 805 CST Research; 806 CST Grants |
| 9 | ATM Infrastructure Management | 901 FAA Data and Information Management; 902 Spectrum Management; 903 Automation Infrastructure; 904 Communication Infrastructure; 905 Navigation Infrastructure; 906 Surveillance Infrastructure; 907 Weather Infrastructure; 908 Computing Infrastructure |

## Why it's valuable — and to what

- Literature review section: `to-do-list.md` §4 (flight execution) — group 1 names the FAA's own
  ATM service set for the ATC side of the chain, and the 101/102/103 split (flight planning; separation
  assurance; advisory) is a ready framing for who does what to a trajectory.
- Decomposition / architecture (§6, §10): **the main use.** It is an authoritative, service-oriented
  decomposition of the FAA enterprise, the counterpart to the domain-oriented decomposition in
  `faaNasInfrastructureRoadmaps2025` (the same enterprise organized by infrastructure domain). Group 9
  (ATM Infrastructure Management: automation, communication, navigation, surveillance, weather,
  computing) lines up with the roadmap domains, and group 1 lines up with the operational side. A
  natural cross-check of the candidate domain list in `projects/nas-sos-capstone/index.md` and of the
  SysML package structure — group 1 in particular against the operational-layer decomposition. It also
  shows what the FAA treats as *outside* air traffic management (certification, commercial space,
  environment, enterprise management), useful for the system-of-interest boundary question.
- Stakeholder / objective ontology (§7-§9): 104 (Synchronization) vs. 105 (Strategic Flow) separates
  tactical from strategic traffic management, and 102 vs. 103 separates separation assurance from
  advisory service — different services with potentially different local objectives, a seed for
  the objective-conflict analysis. The slide states no objectives itself.
- Optimization study (§11-§13): none directly; 104/105 name the traffic-management services that any
  flow/synchronization decision support would sit inside.
- Glossary / terminology: the service names above (e.g. "Separation Assurance", "Traffic Management -
  Synchronization", "Strategic Flow", "Advisory") — check them against `glossary.md`.
- Other: not a source of airline-side (AOC/dispatch) roles — the hierarchy is FAA-side only.

## Rating

**4/5** — Authoritative and directly usable as a service-side cross-check for the §6/§10
decomposition, and the FAA's own decomposition is likely to be cited; held below 5 because it is a
one-page structure with no definitions, rationale, version, or date, so it cannot carry claims about
what any service does.

## Flags

- **Bibliographic details unconfirmed:** year taken from the PDF creation date, not a stated issue
  date; "ANG-B2" is the PDF author field and its expansion was not verified; whether this is the
  current issue on the FAA NAS EA site was not checked. Recorded in the bib `note`.
- **Related, not duplicate:** complements `faaNasInfrastructureRoadmaps2025` (infrastructure-domain view
  of the same enterprise); not a duplicate of any registered source. Its group 9 subsumes what the
  roadmaps call domains, so cite the two together.
- No digital highlights, underlines, or comments in the PDF (checked 2026-09-21).
- Already in the repo (committed in `d99fee5`) but had not been registered until this sweep.

## Processing metadata

- **Read depth:** fully read (1 page; viewed as an image and the text layer cross-checked)
- **Date processed:** 2026-09-21
