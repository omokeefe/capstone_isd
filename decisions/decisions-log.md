# Decisions Log

ADR-style record of decisions and why they were made. Append new entries at the top
(newest first). Don't rewrite old entries when a decision changes — add a new entry that
supersedes it and link back with `[[decisions-log]]`-style references or a direct note.

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
