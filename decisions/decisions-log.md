# Decisions Log

ADR-style record of decisions and why they were made. Append new entries at the top
(newest first). Don't rewrite old entries when a decision changes — add a new entry that
supersedes it and link back with `[[decisions-log]]`-style references or a direct note.

---

## D-010 — Context diagram rendering rule, datalink split, role naming, and supporting definitions

**Date:** 2026-09-27
**Status:** active. Refines D-009 after the owner's line-by-line review of `cameo_models/nas_context_diagram.sysml` (journal 2026-09-27, "Context diagram review").

**Decision:**

1. **Rendering rule.** A sub-part is rendered on the context view only if it has an exchange that crosses a domain boundary. Links inside one domain go on that domain's IBD. Applied: `atcsccTmu` and the drafted `tmuAtc` move to a new placeholder IBD (`cameo_models/nas_ibd_airspace_management.sysml`, view `MyViews::airspaceManagementIbd`), with the open "`atc` umbrella vs tower/TRACON/ARTCC" question. `tmu` is no longer rendered on the context view.
2. **Exchanges that carry a decision without making one are kept but not rendered.** This extends the D-009 aircraft ↔ airport rule. Applied: `aocFlightPlanFiling` stays in the model (the filed plan is the intent object ATC clears against) but is no longer rendered. The route decision is made at the AOC, traded on `aocTfm`, and accepted or amended in the clearance. The same rule gives the new unrendered crew ↔ airport set (`ca*`: lighting, docking guidance, marshalling, pushback coordination, de-icing, fuel slip, gate agent) under the rendered `airportToCrew` summary.
3. **"Datalink" is split by counterpart and function.** `aocAircraftDatalink` = AOC ↔ aircraft over ACARS (AOC messages). New `atcAircraftDatalink` = ATC ↔ aircraft (PDC, D-ATIS, CPDLC / Data Comm), rendered. `atcSurveillance` = aircraft → ATC (transponder, ADS-B Out). ADS-B is surveillance, not a datalink to the AOC. The aircraft-side equipment is broken out in the definitions (`CommunicationSystem`, `SurveillanceSystem.transponder`, `tcas`).
4. **Navaids stay in Infrastructure; lighting stays at the airport.** Most navaids are FAA-owned and FAA-maintained (NAS roadmaps; some non-federal). Airfield lighting is airport-owned and airport-maintained (14 CFR 139.311) and operated from the tower (BB 3-4-x). So navaids are *not* handled like lights (owner's question, answered).
5. **Role naming: Captain / First Officer.** `PilotInCommand` is renamed `Captain`. "PIC" is used only where the text is about legal authority (14 CFR 91.3). PF/PM and PNF are not used in the model. This matches the existing Seamster crosswalk abstraction ("PF/PM dropped; only Captain/FO kept").
6. **Supporting definitions added to `nas_sysml_package_definitions.sysml`:** AOC roles (dispatcher, flight follower, ATC coordinator, load planner, maintenance controller, crew scheduler, aircraft router, duty manager); TFM tools as absorbed media (`AirTrafficFlowManagementSystem`: TFMS, FSM, NTML, TBFM, DRT); TFM exchange items (EDCT, TMI advisory, FEA/FCA, TOS, CTOP assignment, schedule change, slot substitution, diversion recovery request); the dispatch release, fuel slip, FMS prediction, and the `PreflightCrossCheck` action performed by `FlightDeckCrew`; ground-handling roles, into-plane fueler, airfield lighting, and gate agents.
7. **Evidence grade `[SME]` added** for the owner's professional FMS knowledge (16 years in industry). It is stated as such in the write-up unless a citable source is found.

**Rationale:** the context view is a domain-to-domain picture of the NAS, so intra-domain links sit one level too deep for it (item 1). Rendering only decision-bearing exchanges keeps the view about where the intent chain can be changed (item 2). The ambiguous "datalink" term hid three different counterparts and authorities (item 3). Items 4–5 answer the owner's questions directly. Item 6 moves draft code into the definitions file per methods §10.1.

**Alternatives considered:**

- Keep ATCSCC ↔ TMU on the context view as the "enterprise → tactical" step. Rejected: that step now shows on the IBD, and the context view still shows where TFM meets the airline (`aocTfm`) and where the clearance meets the crew (`atcToCrew`).
- Drop flight plan filing from the model entirely (the owner's first instinct). Rejected: the filed plan is the data ATC correlates the track to (BB 5-3-3d) and the "cleared as filed" baseline. It is kept for traceability, just not rendered.
- One ATC ↔ aircraft connection for surveillance and datalink. Rejected: they differ in direction, medium, and whether the crew is in the loop.
- PIC/PNF or PF/PM naming. Rejected: those mix axes (legal authority vs task). Captain/FO is the only symmetric pair, and PNF was replaced by PM (FAA AC 120-71B).

**Evidence / source:** JO 7110.65BB 2-1-6, 2-6-2, 2-6-4, 2-7-1, 4-6-1/4, 5-1-2, 5-2-x, 5-3-3, 8-1-6 (extracted 2026-09-27); JO 7210.3EE 6-5, 18-4-5, 18-10-12, 18-12-3/4; Berry & Pace 2011; Munro 2018; Seamster 2011; `knowledge/models/context-diagram-exchange-evidence.md`.

**Consequences:**

- The context view renders 11 operational connections (was 12: minus `aocFlightPlanFiling` and `atcsccTmu`, plus `atcAircraftDatalink`) plus the 5 environment links that are live in the file.
- The §10 "Create operational IBDs" work has a first placeholder file.
- `FlightCrew::PilotInCommand` no longer exists; anything that referenced it uses `FlightCrew::Captain`.
- Open: the `atc` umbrella question (IBD file); a US source for gate authority; CTOP and SMART sources (to-do-list §4 additions); the GDP-substitution / diversion-recovery scenario (§9 addition).

---

## D-009 — Context diagram baseline: every system assessed against D-007; AOC link split to TFM; flight deck merged

**Date:** 2026-09-27
**Status:** active. Applies D-007 to the context diagram (`cameo_models/nas_context_diagram.sysml`), as D-008 applied it to the BDD. The candidate "retarget AOC → `atcscc`" from the 2026-09-26 journal is adopted here in modified form (a split).

**Decision:**

1. **Every system on the context diagram gets an explicit D-007 disposition**, recorded as a comment on its part in the `.sysml` file and in the table below. D-007's test: an entity is *modeled* when it has distinct decision authority or execution behavior, dynamically coupled to in-scope decisions, that materially affects cost, safety, workload, schedule reliability, or passenger value. Otherwise it is a boundary actor (supplies objectives, demand, feedback, or rules), a context constraint (exogenous), or absorbed (kept only as exchange content or a capability). Only modeled systems are rendered on the context view (`#ContextVisible`).
2. **The AOC ↔ Airspace Management link is split by counterpart.** Traffic-flow content (EDCTs, TMI and reroute advisories, TOS, Early Intent, FSM schedule changes, GDP substitutions) goes on a new `aocTfm` connection to `atcscc`. Flight-plan filing and amendment stays on `atc` as `aocFlightPlanFiling`.
3. **Pilot in command and first officer are merged into one `FlightDeckCrew` part** (new in `nas_sysml_package_definitions.sysml`, inside `FlightCrewDomain`). All crew connections attach to it. The two roles remain as its sub-parts for IBD and behavior work.
4. **The aircraft ↔ airport exchanges are kept as a complete set of 20 unrendered connections**, with one rendered summary link (`aircraftAirport`). The Airport sub-parts they attach to are absorbed.
5. **The mapping of the FAA's "system users / customers / flight operators" to `airlineOperationsCenter` (via its ATC coordinator) is recorded as an abstraction.**
6. **Takeoff performance (V-speeds, thrust / assumed-temperature settings) is modeled as provided by the AOC in the release package.** This is an abstraction: in practice it depends on the aircraft type, and some types (e.g. the 737) compute it in the FMS (owner, 2026-09-27). It keeps the crew's plan-vs-FMS cross-check limited to fuel, weight, ETA, and altitude predictions. Fuel is uplifted by the airport fuel carrier, whose fuel slip reaches the crew on `airportToCrew`.

**D-007 assessment of each system:**

| System (part) | Authority or execution behavior coupled to in-scope decisions | Material effect | Disposition | On context view |
|---|---|---|---|---|
| Airline Operations Center (`flightOps.airlineOperationsCenter`) | Operational control; dispatcher and PIC jointly responsible for the release (14 CFR 121.533); sets route and fuel plan | cost, schedule reliability | Modeled | rendered |
| ATCSCC (`airspaceMgmt.atcscc`) | "Final approving authority" for interfacility TMIs (JO 7210.3EE ¶18-2-3i); EDCT/CTOP/reroutes act directly on airline decisions | delay cost, schedule reliability | Modeled | rendered |
| TMU (`airspaceMgmt.tmu`) | Local TM latitude (MIT, fix balancing; ¶18-2-3 NOTE); turns national TMIs into sector constraints | schedule, controller workload | Modeled (one part for terminal and ARTCC TMUs) | rendered |
| Tactical ATC (`airspaceMgmt.atc`) | Clearance and separation authority (JO 7110.65BB) shapes the flown trajectory | safety, schedule | Modeled | rendered |
| TRACON, ARTCC (`tracon`, `artcc`) | Same as tactical ATC | same | Modeled in the BDD; covered by the `atc` umbrella at context level | not rendered |
| Flight deck crew (`flightCrew.flightDeckCrew`) | PIC final authority (14 CFR 91.3); turns plan + clearances into FMS intent | safety, workload, fuel | Modeled, as one element | rendered |
| Cabin crew (`flightCrew.cabinCrew`) | No authority over in-scope decisions; "cabin secure" couples to departure time only weakly, through the PIC | safety (outside the selected scenarios) | Inside the modeled Flight Crew domain, absorbed at context level | not rendered |
| Aircraft (`aircraftSys.aircraft`) | No decision authority, but its execution behavior (FMS intent → guidance → motion) is the end of the intent chain | fuel burn, safety | Modeled | rendered |
| Airport operator (`airportOps.airport`) | Gates, non-movement area, closures, slots at coordinated airports; departure readiness couples to EDCT compliance | schedule reliability | Modeled (weakest evidence of the set: C/B) | rendered |
| Airport sub-parts (fuel distribution, ground handling, gates, terminals, baggage, cargo, maintenance hangar) | Carry out decisions made by other actors (AOC fuel and load orders, passengers, weather, maintenance status, ATC/ramp clearance) | turnaround time, but not as a decision lever | Absorbed | only as ends of unrendered connections |
| Ticketing system (`flightOps.ticketingSystem`) | Revenue/booking side; enters only as passenger demand | — | Absorbed (a boundary-actor effect) | not rendered |
| Governance (`environment.governance`) | Supplies rules | — | Boundary actor | not rendered (draft link) |
| Passengers (`environment.passengers`) | Supply demand; mediated by airline decisions | — | Boundary actor | not rendered |
| Military (`environment.military`) | Special-use airspace as a scenario condition | — | Boundary actor | not rendered (draft link) |
| Infrastructure incl. navaids, weather service (`environment.infrastructure`) | Exogenous signals and constraints | — | Context constraint | not rendered; `apNavaidSignals` unrendered, weather link drafted |
| Maintenance Suppliers | Exogenous parts/cost/availability | — | Context constraint | no part yet |
| Information Services (`environment.informationServices`) | Channels (NTML, TFMS, ACARS) matter only when they change a decision or KPI | — | Absorbed (carried as the media in connection docs) | not rendered |
| Decision Support (`environment.decisionSupport`) | Tools (FSM, TBFM, CTOP) operated by modeled systems | — | Absorbed (a capability of ATCSCC/TMU/AOC) | not rendered |

**Rationale:**

- *Split:* JO 7210.3EE Ch. 18 (grade A) shows the operator exchanging EDCTs, TOS, schedule changes, and GDP options directly with the ATCSCC/TFMS, not with tactical controllers. §6-5 of the same order shows flight plans going computer-to-computer to the ARTCC host. The old single link mixed two counterparts with different authority. Separating them puts the airline-vs-NAS flow conflict (§9) on its own link.
- *Merge:* under D-007's test, the Captain and FO do not hold separate decision authority at context level. Final authority attaches to the PIC, and pilot-flying/pilot-monitoring duties swap between them (Seamster 2011, p.44). Every crew link had been drawn twice with identical content. GreAT D2.2's operational IBD also has no separate crew node.
- *Aircraft ↔ airport set:* none of these exchanges changes an optimization outcome. Each one carries out a decision made on another actor's link, so rendering them would add clutter without showing a decision lever (owner, 2026-09-27).

**Alternatives considered:**

- Pure retarget of AOC → `atcscc` (the 09-26 proposal). Rejected: it would drop the grade-A flight-plan filing path to the ARTCC host.
- Keep one AOC → `atc` link. Rejected: the TFM counterpart is evidenced as the ATCSCC, not tactical ATC.
- Keep PIC and FO as separate endpoints. Rejected: duplicate connectors, no authority difference at context level.
- Connect crew links to the whole `flightCrew` domain. Rejected: that would fold cabin crew into the flight-deck interface.
- Drop the aircraft ↔ airport exchanges from the model. Rejected: the owner wants the set kept for completeness and later IBD reuse.

**Evidence / source:** `knowledge/models/context-diagram-exchange-evidence.md`; `evidence/literature-notes/summaries/5 - faa2025jo72103ee.md` (¶18-2-3i, 18-4-1d, 18-8-2c/3d, 18-10-3/6e/12, 18-12-3b, §6-5); `5 - faa2025jo711065bb.md`; `knowledge/models/interaction-catalog-flight-execution.md` (PF/PM → Captain/FO crosswalk); GreAT D2.2 Figure 3; journal 2026-09-26 (14:06 recommendations) and 2026-09-27.

**Consequences:**

- The context view renders 12 connections among 7 systems. The per-connection doc comments give the evidence grade and sources.
- Anything that referenced `flightCrew.pilotInCommand` or `.firstOfficer` directly must now go through `flightCrew.flightDeckCrew`. Only the context diagram did.
- The PIC/FO distinction, including the FO working the radio, returns only at IBD or behavior level.
- Open items carried forward in the `.sysml` TODOs: whether `atc` should hold `tracon`/`artcc` as sub-parts; the environment links (drafted, not rendered); the AOC ↔ Airport link, which has the weakest US evidence.

---

## D-008 — BDD reconciled to D-007: modeled systems vs. Environment, split by ratified disposition

**Date:** 2026-09-22
**Status:** active. Applies D-007's ratified boundary to the SysML v2 BDD
(`cameo_models/nas_sysml_package_definitions.sysml`); does not touch D-002's domain-
decomposition question, which stays provisional pending §6.

**Decision:** Restructured the BDD's top-level composition to mirror D-007's disposition
column instead of treating all nine pre-ratification D-002 packages uniformly:

1. `part def NationalAirspaceSystem` now composes only the five ratified Modeled System
   domains: Airspace Management, Flight Operations, Airport Operations, Aircraft Systems,
   and a new `FlightCrew` package (Captain/First Officer roles) that was entirely absent
   from the pre-ratification first pass.
2. A new `part def Environment` composes everything else — Governance, Passengers,
   Military, Infrastructure, Information Services, Decision Support — so the still-unbuilt
   NAS context diagram has boundary-crossing actors/constraints to reference, without
   decomposing any of them into constituent systems.
3. Governance's `FederalAviationAdministration` constituent part was removed (Governance
   is now a single opaque actor); the empty `AirspaceResources` package was merged into
   `Infrastructure` (D-007 treats "Infrastructure / Airspace Resources" as one row);
   `Passengers` and `Military` packages were added as opaque boundary actors (previously
   unmodeled).

**Rationale:** `system_of_interest_definition.md`'s "Included and excluded scope" is
explicit that the project does not decompose passengers, regulators, military, suppliers,
information services, infrastructure, or decision support into independent internal
systems — but the pre-ratification BDD did exactly that (nested FAA under Governance,
SatelliteSystem/WeatherService under Infrastructure, SWIM under InformationServices) and
was entirely missing Flight Crew, a ratified Modeled System. Splitting the composition by
D-007 disposition (modeled vs. environment) makes the model match the ratified boundary
and gives the context diagram a real SOI-boundary/environment split to draw ports and item
flows across, per MagicGrid step 0 (`sysmlv2_exploration.md` §3a).

**Alternatives considered:** Keep all nine domains flat inside `NationalAirspaceSystem`
and just strip internal decomposition from the non-modeled ones in place (rejected by the
project owner — a separate `Environment` part def was preferred so the context diagram,
which the project owner is authoring directly rather than delegating, has an explicit
boundary to draw against).

**Open question carried forward:** Information Services and Decision Support are rated
"Absorbed / Abstracted" in D-007, not "Boundary Actor" or "Context Constraint" — arguably
their effects should stay attached to the modeled systems they inform (e.g. Decision
Support's `VehicleDynamicsModel` feeds §12-§13 traceability) rather than sit in
`Environment` alongside true external actors. Placed in `Environment` here as a
simplification; flagged in `knowledge/questions/open-questions.md` for confirmation before
the context diagram treats them as boundary-crossing actors.

**Evidence / source:** `knowledge/models/system_of_interest_definition.md`,
`decisions-log.md` D-007, `cameo_models/sysmlv2_exploration.md` §3a (MagicGrid step 0).

---

## D-007 — Ratified SOI boundary and analytical scope

**Date:** 2026-09-21
**Status:** active. Supersedes the provisional SOI boundary documented before this
decision; it refines, but does not supersede, D-002's candidate domain decomposition.

**Decision:** Ratify the NAS-as-SoS System of Interest around the trajectory-intent
lifecycle from enterprise objectives through aircraft motion. Model Airspace
Management/ATC, Airport Operations, Flight Operations for Part 121 scheduled passenger
operators, Aircraft Systems, and Flight Crew as modeled systems. Include Governance /
Regulatory and Legal, Passengers, and Military as boundary actors. Treat Infrastructure
/ Airspace Resources and Maintenance Suppliers as context constraints. Absorb or
abstract Information Systems and Decision Support, while retaining their effects as
information exchanges or capabilities when relevant.

**Rationale:** An entity is modeled when it has distinct decision authority or execution
behavior dynamically coupled to in-scope decisions and materially affects cost, safety,
workload, schedule reliability, or passenger value. Boundary actors supply objectives,
demand, feedback, or rules without being decomposed as decision mechanisms. Exogenous
influences enter as constraints or scenario parameters. This criterion preserves the
authority and responsibility relationships needed for a systems-of-systems architecture
without expanding the project into a model of every NAS participant.

Passengers remain boundary actors because demand, willingness to pay, passenger mix, and
time sensitivity influence airline choices about fares, frequency, aircraft assignment,
connections, and delay/rerouting tradeoffs. Revenue passenger miles provide an
aggregate measure of passenger traffic and airline output; affordability, schedule
reliability, and satisfaction remain value measures. Passengers do not directly set
fares or aircraft speed, which are mediated by airline revenue-management and
operations decisions.

Part 121 scheduled passenger operations define the modeled operator population. General
aviation, scheduled cargo, international airspace, and military operations remain
outside that modeled population, but may be represented as background traffic or
constraints when their omission would materially distort a selected KPI. This is an
analytical scope choice, not a claim that those activities are unimportant to the real
NAS.

**Alternatives considered:** A broad model of all NAS organizations was rejected as
unbounded. A purely physical decomposition was rejected because it hides authority,
information ownership, and stakeholder tradeoffs. Treating passengers, regulators, or
military operations as fully decomposed systems was rejected because their internal
decision mechanisms are not the focus of the selected scenarios. Treating all
information services and decision support as external was rejected because their
information and recommendations still affect modeled decisions; they are therefore
abstracted rather than ignored.

**Evidence / source:** `knowledge/models/system_of_interest_definition.md`, the
2026-09-21 SOI-boundary review conversation, `knowledge/models/stakeholder-register.md`,
and D-002's authority/responsibility/information-ownership framing.

**Consequences:** The SOI definition and project index become the scope baseline for
architecture work. Future changes to the modeled population require a new decision or
an explicit scenario-level justification. The baseline holds regulation and external
constraints fixed; sensitivity analysis may vary them later.

---

## D-006 — SysML v2 text (authored in Syside Modeler / VS Code) is the source of truth; Cameo is optional and downstream

**Date:** 2026-09-19
**Status:** active. Amends the tool half of D-003 ("SysML in Cameo"); the language,
method, and everything else in D-003 stand.

**Decision:**

1. The `.sysml` files under `projects/nas-sos-capstone/cameo_models/`, authored in
   Syside Modeler in VS Code, are the single source of truth for the architecture model.
2. Cameo/MagicDraw is **not** the source of truth. Anything brought into Cameo (by
   import, script, or hand rebuild) is a derived copy; if it and the `.sysml` text
   disagree, the text wins and the Cameo copy is regenerated or fixed.
3. Getting the model into Cameo is deferred and optional — see the hand-off options in
   `workflows/update-architecture.md`.
4. `prework/nas_system_of_systems_architecture.xml` is a pre-modeling draft. It was
   described as generated from Cameo, but no Cameo export ever existed; it is not kept in
   sync with the `.sysml` files. If it disagrees with them, the `.sysml` files win.

**Rationale:** The university's Cameo/MagicDraw install (2024x Refresh 1, checked
2026-09-19) does not support SysML v2 out of the box, and no known tool converts v2 text
into a form it can open. The model was already being authored in SysML v2 text, so making
Cameo the source of truth would have meant rebuilding it by hand in SysML v1 just to
satisfy the workflow doc. Keeping the text as the source avoids a two-model sync problem
until a reliable import path exists.

**Alternatives considered:** Cameo (SysML v1) as the source of truth with the `.sysml`
text as a scratch draft (rejected — duplicates the model in a different metamodel, and
the v1 copy would drift); requesting a newer Cameo release that supports v2 (the university may be able to
provide one, but the user chose not to pursue it; if it were obtained, direct textual
import would become the hand-off path and this decision's source-of-truth call would be
unchanged).

**Adviser:** Mark Petrotta recommended Syside/SysML v2 and will accept it as the model
deliverable (per the user, 2026-09-19).

**Open consequences:** The `cameo_models/` folder name is now historical (it holds the
SysML v2 model); renaming it would touch many references and hasn't been done.

**Evidence / source:** 2026-09-19 session — user's report of Cameo 2024x Refresh 1
lacking SysML v2 support, and the direction that Syside/VS Code is the source of truth.

---

## D-005 — Instance/scenario content and simulation code kept separate from the structural model, with a documented (not language-level) trace between SysML and Python

**Date:** 2026-09-19
**Status:** active

**Decision:** Three file-organization/pattern choices for extending the SysML v2 model
going forward:

1. Structural definitions (domains, system types — D-002's decomposition) stay in
   `cameo_models/tutorial.sysml`; concrete scenario instances (a specific flight, its
   airports/procedures) go in new files under `cameo_models/scenarios/`, one per
   scenario.
2. The vehicle-dynamics simulation capability is split: SysML declares only the
   interface (a `calc def` in the `DecisionSupport` package — reflecting the project's
   existing "decision-support is a capability, not a physical system" framing), and the
   real physics is a plain Python module under
   `projects/nas-sos-capstone/simulation/` (a sibling of `cameo_models/`, not inside it,
   since it's code/deliverable content for §12, not model content for §10).
3. The link between the `calc def` and the Python implementation is a documented,
   hand-maintained trace (doc comments naming the module/function, and field names kept
   identical on both sides) — not a language-level binding.

**Rationale:** SysML v2 does support an opaque external-language `calc def` body
(`language "..." /* code */`), but the only broadly-implemented execution path for that
runs through Jython (JVM Python 2), tool-specific to commercial modelers like
NoMagic/Cameo — not CPython, and not a fit for real physics (numpy/scipy) or for a tool
this project can't confirm supports it. Keeping the model and the code as separate
artifacts with an explicit, human-readable trace is the same shape the project already
uses for decision-support/optimization generally (README.md/index.md working
assumptions: a capability layered on the architecture, not embedded in it) — extending
that pattern to simulation keeps the project's tooling assumptions consistent instead of
introducing a second, incompatible integration style.

**Alternatives considered:** Embedding Python via `calc def`'s `language` opaque body
(rejected — Jython-only in practice, not verified against this project's tool, wrong
Python semantics for numeric work); a `part def` for the vehicle dynamics model under
`AircraftSystems` instead of `DecisionSupport` (rejected — it's a simulation/analysis
capability that reads and predicts Aircraft state, not a constituent onboard system,
same reasoning the project already applies to decision-support/optimization).

**Evidence / source:** `workflows/sysml-instance-modeling.md`,
`workflows/vehicle-simulation-model.md`, and 2026-09-19 web research on SysML v2 calc-def
external-language support (Jython-based in current tools) — see
`projects/nas-sos-capstone/journal/2026-09-19.md` for the session's search trail.

---

## D-002 — Layered domain decomposition over a flat object list

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active, but explicitly provisional — see [[open-questions]]

**Decision:** Organize the architecture around connected domains (Governance, Airspace
Management, Airspace Resources, Flight Operations, Airport Operations, Aircraft Systems,
Information Services, Infrastructure, Decision Support) built around authority,
responsibility, and information ownership — rather than a flat catalog of aviation
objects (aircraft, radars, airports, etc.).

**Rationale:** A flat list of "things in aviation" doesn't expose who owns what
responsibility or how information moves between owners, which are the questions an ISD
architecture needs to answer. The domain decomposition makes airspace sectors, controller
responsibilities, flight intent, clearances, weather products, surveillance tracks, and
trajectory intent into first-class architecture elements instead of background noise.

**Alternatives considered:** Physical/object-based decomposition (rejected — hides
authority/information ownership); a single all-encompassing NAS diagram (rejected — not
bounded enough to finish).

**Revisit when:** `projects/nas-sos-capstone/to-do-list.md` §6 ("Explore Alternative
System Decompositions") is worked — that section explicitly plans to build organization-based,
lifecycle-based, physical, information-flow, and decision-authority decompositions and
compare them. This decision may be confirmed, refined, or replaced by a decision to keep
multiple parallel viewpoints instead of one canonical decomposition.

---

## D-001 — Pivot from trajectory/rendezvous optimization to NAS-as-SoS architecture

**Date:** captured retroactively, 2026-08-29 (decision predates this log)
**Status:** active

**Decision:** Reframe the capstone from a rendezvous/trajectory optimization problem to
a broader systems-of-systems architecture of the National Airspace System, with
optimization/decision-support demoted to one capability inside that architecture rather
than the whole subject.

**Rationale:** The original optimization framing didn't showcase the strengths an ISD
capstone is meant to demonstrate — architecture, interfaces, responsibility,
traceability. The NAS-as-SoS framing does, while still leaving room for an optimization
case study (see `projects/nas-sos-capstone/to-do-list.md` §11–§13) to demonstrate how
architecture exposes cross-stakeholder impacts that a standalone optimizer would miss.

**Alternatives considered:** Keep the narrow trajectory-optimization scope (rejected —
too mathematical, not architecture-centric enough); go fully broad and survey all of
aviation (rejected — not bounded enough to finish, see index.md working
assumptions).

**Evidence:** `projects/nas-sos-capstone/prework/gpt_convos.md` (both conversations),
`README.md` "Capstone Direction" and "Working Assumptions" sections.

---

_Template for new entries:_

```
## D-00N — <short decision title>

**Date:** <date>
**Status:** active | superseded by D-00X | reverted

**Decision:** <what was decided>
**Rationale:** <why, including the specific constraint/tradeoff that drove it>
**Alternatives considered:** <what else was on the table and why it lost>
**Evidence / source:** <file or conversation that documents this>
```
