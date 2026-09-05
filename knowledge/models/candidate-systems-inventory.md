# Candidate Systems Inventory

_Draft inventory of constituent systems extracted from
`prework/Air Transport System Architecture.pdf` — a generic transport-system
decomposition diagram (authored by the user prior to starting this project), used here as raw material for
`to-do-list.md` §6 (Alternative System Decompositions) and §10 (Build the SysML
Architecture: context diagram, BDDs, package structure). Cross-reference against
[[project-brief]]'s candidate top-level domains and [[open-questions]] before treating
any of this as settled._

## Source document

<embed src="../../prework/Air Transport System Architecture.pdf" type="application/pdf" width="100%" height="600px" />

*(Renders inline in viewers that allow local PDF embeds, e.g. a browser opening this file
directly — VS Code's Markdown preview and GitHub's rendered view generally block it for
security, so if you see nothing above, use the link instead:*
[open prework/Air Transport System Architecture.pdf](<../../prework/Air Transport System Architecture.pdf>)*.
This is a reference to the existing file, not a copy — nothing below duplicates its
content beyond the manual extraction already in this document.)*

## Extraction caveat — read before using this

The source PDF is a large hierarchical box diagram plus a smaller hub-and-spoke diagram.
It was read via text-layer extraction, not a verified visual trace of the connecting
lines — so **the node inventory below is reliable, but the exact parent/child nesting
is reconstructed from context and domain knowledge, not confirmed against the actual
lines in the diagram.** Before this feeds a BDD or package structure, open the PDF
directly and confirm the groupings below, especially anywhere marked "(inferred
grouping)". The information-exchange content (the hub-and-spoke, left side of the page)
is captured separately in [[interface-exchange-draft]] with the same caveat.

## Top-level context (multi-modal transport)

The source frames the whole thing as a **Transport System** with three
modal siblings — confirms that the NAS/Air Transport System sits inside a broader
context, useful directly for the §10 NAS context diagram (what's the "next system up"):

```
Transport System
├── Ground Transport System
├── Air Transport System   <- this project's SOI sits here
└── Maritime Transport System
```

## Systems identified, grouped by likely domain

Grouped against [[project-brief]]'s nine candidate domains (Governance · Airspace
Management · Airspace Resources · Flight Operations · Airport Operations · Aircraft
Systems · Information Services · Infrastructure · Decision Support). Groupings marked
"(inferred)" are my best read of where a node belongs, not a confirmed diagram edge.

### Governance
- Regulatory System
- Governments / Agencies: **FAA**, **EASA**, **CAAC** (named as examples — confirms the
  diagram treats regulators as instances of a generic "Regulatory System," not
  US-specific; relevant if the project wants to note NAS is a US instance of a more
  general pattern)
- **ICAO**
- Flight Information Regions: Lower FIR, Upper FIR ("Optional; Highest Altitudes" — noted
  on the source as a qualifier, not fully explained)

### Airspace Management
- Air Traffic Control System (top-level node)
- **TRACON** (Departure & Arrival Airspace)
- Departure & Arrival Control
- **ARTCC** (Regional En-Route Airspace)
- **ATCSCC** (ATCS Command Center)
- **GMTOs** (General Managers of Tactical Operations)
- **ANSPs** (Air Navigation Service Providers)
- Traffic Flow Monitoring Center
- Air Traffic Flow Management Systems (**ATFMs**)
  - Time-Based Flow Management
  - **ETFMS** (Enhanced Tactical Flow Management System)
  - Arrival Management (**AMAN**) — sourced with a "?" on the original diagram, i.e. the
    source itself marks this one uncertain
- A separate, more granular ATC/ANSP functional block list appears elsewhere on the page
  (reads like a real ANSP functional decomposition, possibly EUROCONTROL-derived — worth
  checking against `references/` once the EUROCONTROL sources are annotated, to-do §3-4):
  Surveillance, Conflict Management, Monitoring Aids, Local Traffic Complexity
  Management, Operational Supervision, Safety Nets, Arrival Management, Correlation
  Management, Legacy Ground-Ground Datalink Communications, Technical Supervision,
  Air-Ground Datalink Communications, Flight Planning/Lifecycle/Distribution, Ground-Ground
  IOP Management, Support Functions, Code Management, Trajectory Prediction & Management,
  Coordination & Transfer, Air/Ground Datalink Services, Controller HMI Management.
  **(inferred grouping — this cluster's exact parent node in the tree isn't clear from
  text extraction alone; it reads as ATC/ANSP-internal functions, not airport or
  aircraft.)**

### Airport Operations
- Airport System (top-level node)
- **APRON** / Control Tower (Gates, Taxi, Takeoff, & Landing)
- Fuel Distribution System
  - Fuel Transfer System
  - Tanks & Cavities
  - Fuel Quantity Processing System (**FQPS**)
- Airport Management System (**AMS**) — this is also the hub of the interface diagram;
  see [[interface-exchange-draft]]
- Ground Handling, Customs and Immigration, Security Services, Parking and Transportation
  Services, Baggage Handling System — named as AMS's exchange partners; captured as
  systems/service-providers here, and as candidate personas/actors in
  [[stakeholder-personas]] (not yet drafted there — see that file's "Not yet drafted"
  list, which should be extended with these)

### Flight Operations
- Airline Operations Center
- Ticketing System
- Named actor roles (map to [[stakeholder-personas]], not systems per se): Dispatcher,
  ATC Coordinator, Flight Crew (Captain, First Officer, Cabin Crew), Remote Pilot

### Aircraft Systems
- Aircraft System (top-level node)
- Flight Management System (**FMS**)
- Flight Control System
  - Auto-Flight Control System
  - Primary FCS
  - Reversionary FCS
- Pitot-Static System
- Fuel System
- Navigation, Guidance, Surveillance Systems, Radar (aircraft-side instruments —
  **(inferred grouping)**: could equally be read as avionics sub-nodes of Flight
  Management/Flight Control rather than siblings; verify against the diagram)

**A separate generic "Functional Decomposition" example** appears near this cluster,
reading as a template for aircraft-level decomposition rather than NAS-specific content:
Mission System, **Weapons System**, Propulsion System, Airframe, Vehicle Network,
Entertainment System. Flag for the professor/SOI discussion: **Weapons System / Mission
System are military-aircraft-specific** — their presence here is likely just a generic
"how to decompose a vehicle" teaching example on the source diagram, not evidence that
military aircraft internals are in scope. Don't let this quietly pull "Weapons System"
into the architecture without a deliberate SOI decision — see [[open-questions]]
("is military airspace operations beyond their PESTLE/objective role in scope?").

### Information Services
- Information Exchange Systems (top-level node)
- **SWIM** (System Wide Information Management)

### Infrastructure / Airspace Resources
- Satellite System (comm, nav, wx) — **(inferred grouping)**: could belong to either
  domain; it's infrastructure shared across Airspace Management and Aircraft Systems
  (comm/nav/surveillance), not owned by one
- Weather Service

### Decision Support
- **No systems in this source map to Decision Support.** Worth noting as a gap: this
  external/generic reference diagram doesn't represent optimization/decision-support
  capability as a first-class system at all — consistent with this project's own
  framing (decision-support as a capability layered on top of the architecture, not a
  physical system), but means this source gives no evidence to cross-check that domain
  against.

## What this is (and isn't) useful for

- **Useful for:** sanity-checking that the project's 9-domain decomposition has
  reasonable real-world analogues (it does, for 8 of 9 domains); populating the §10
  context diagram's "systems the NAS interfaces with" layer; a starter list of
  Airport-Operations-domain systems, which the project's own material hasn't detailed
  much yet.
- **Not useful for:** a citable evidentiary source (it's the user's own prework diagram,
  not literature — don't cite it in the report the way an annotated §2-4 source would be
  cited); a confirmed hierarchy (see the extraction caveat above).

## Status

Extracted 2026-08-30, not yet reconciled with `to-do-list.md` §6/§10 work or the
Cameo model. Next step: when §10 (or §6's alternative-decomposition comparison) is
worked, pull specific nodes from here rather than starting the systems list from
scratch — but verify groupings marked "(inferred)" against the source PDF first.
