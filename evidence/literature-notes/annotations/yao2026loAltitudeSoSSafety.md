# Annotation: System-of-Systems Safety for Low-Altitude Aviation Transportation

- **File:** `references/System-of-systems safety for low-altitude aviation transportation.pdf`
- **Bib key:** `yao2026loAltitudeSoSSafety`
- **Type:** journal review (systematic literature review)
- **To-do section:** `to-do-list.md` §6 (Explore Alternative System
  Decompositions) / §7 (Stakeholder and Responsibility Analysis) / §9 (Analyze Myopic
  Optimization) / §10 (Build the SysML Architecture) — no §2-4 fit (low-altitude/UAM
  scope, not conventional commercial-airline-ops literature)

## Extraction

- **Actors / stakeholders:** Regulators (FAA-equivalent authorities for low-altitude
  airspace), UAM/eVTOL/UAS operators, vertiport/ground-infrastructure operators, ANSPs
  extending traditional ATC into low-altitude airspace, manufacturers of autonomous
  aircraft/automation systems, and the traveling public/communities affected by
  low-altitude operations (noise, safety risk exposure). Maps onto existing PESTLE rows
  (FAA, airports/airport authorities, local communities, aircraft manufacturers) but
  applied to a new, lower-altitude operating layer the current `stakeholder-register.md`
  does not explicitly distinguish — worth a note if the capstone's SOI boundary ends up
  including UAM/low-altitude operations.
- **Systems / organizations:** The paper frames the entire low-altitude airspace
  ecosystem (aircraft, ground infrastructure, ATC/traffic-management automation,
  regulatory bodies) as a single SoS, decomposed via ISO/IEC/IEEE 42010 into three
  facets: composition/environment interaction, organizational/operational structure, and
  governance/evolution principle.
- **Objectives:** Safety (primary) — specifically extending safety assurance from
  single-aircraft/single-organization contexts to a multi-stakeholder, multi-automation
  SoS context; secondary objectives include maintaining operational capacity/throughput
  and enabling scalable low-altitude operations without proportionally scaling risk.
- **Costs / penalties:** Safety incidents/accidents as the primary "cost" being managed
  against; the paper discusses risk in qualitative/architectural terms rather than a
  quantified cost function.
- **Decisions:** Architecture-design decisions (how to structure automation/human
  authority in the safety control loop), testing/evaluation-method decisions (how to
  validate a new SoS design before deployment), and safety-management decisions
  (real-time monitor-assess-mitigate actions under the proposed IASMS).
- **Decision authority:** Distributed and explicitly flagged as a risk factor — the paper
  states that "fragmented authority... can blur accountability... during critical
  events," directly naming authority fragmentation across regulators, operators, and
  automation as a source of SoS-level risk. This is a directly citable data point for
  the capstone's authority/responsibility boundary criteria (open question in
  `open-questions.md` §1).
- **Activities / processes:** Architecture design (safety control loop specification),
  testing & evaluation (digital-physical test platforms, simulation), and ongoing safety
  management (in-time monitoring, assessment, mitigation per IASMS) — the paper's
  three-part framework.
- **Resources:** Not resource-focused; this is an architecture/framework paper, not an
  operations paper with resource-allocation content.
- **Information inputs:** Real-time operational/telemetry data feeding the safety control
  loop's sensor layer; historical incident/hazard data informing the SMS/IASMS layer.
- **Information outputs:** Safety-relevant control commands/interventions from the
  controller layer to actuators/automation; safety-status assessments feeding
  regulatory/operator decision-making.
- **Constraints:** Regulatory frameworks not yet mature for low-altitude SoS-scale
  operations (the paper's motivating gap); heterogeneous automation levels across
  operators; the need for new "digital flight rules" distinct from traditional IFR/VFR.
- **Interfaces / handoffs:** Human-automation handoffs within the safety control loop
  (controller ↔ actuators ↔ sensors ↔ controlled process, per Leveson's STAMP model);
  cross-organization handoffs between regulators, operators, and infrastructure providers
  implied by the governance/evolution facet.
- **Timescales of decisions:** Spans strategic (architecture design, done once/rarely),
  tactical (testing & evaluation, done per system update), and real-time (in-time safety
  management, continuous) — a clean illustration of decisions operating at multiple
  timescales within one SoS, directly relevant to the capstone's own multi-timescale
  decision-authority mapping.
- **Upstream dependencies:** Regulatory policy and airspace-design decisions made above
  the safety-architecture layer; automation/aircraft capability limits set by
  manufacturers.
- **Downstream consequences:** Safety-architecture and governance choices propagate down
  to how individual aircraft/automation systems are permitted to behave and how quickly
  they can be grounded/redirected in a safety event — a direct (if UAM-specific) parallel
  to the capstone's enterprise-objective-to-aircraft-behavior intent chain, here framed
  through safety authority rather than economic objectives.
- **Optimization variables:** n/a — not an optimization paper; the paper explicitly lists
  digital twins, multi-agent simulation, and Monte Carlo testing as future-research
  directions rather than presenting an optimization formulation itself.
- **Objective functions / measures of effectiveness:** Not formalized; safety is treated
  qualitatively via the 42010 architecture facets and the STAMP control-loop framing
  rather than a numeric objective function.
- **Evidence of local-vs-system-level conflicts:** Strong and explicit — §3.3 states that
  "divergent stakeholder objectives cause uneven safety prioritization" and "incentive
  misalignment can push stakeholders to optimize local efficiency at the expense of
  system resilience." This is directly usable, citable evidence for the capstone's §9
  myopic-optimization-conflict argument: local (operator-level) efficiency optimization
  can degrade system-level (airspace-wide) safety/resilience.

## Mapping to architecture

- **Candidate SysML elements:** The paper's ISO/IEC/IEEE 42010 three-facet decomposition
  (composition/environment interaction; organizational/operational structure;
  governance/evolution) is a standards-based justification pattern that could be cited
  alongside the capstone's own D-002 domain decomposition (Governance, Airspace
  Management, Flight Operations, etc.) to argue the decomposition follows recognized
  architecture-description practice. The safety control loop (STAMP:
  Controller-Actuators-Sensors-Controlled Process) is a reusable pattern for a Behavior
  Diagram or Activity Diagram showing how a governance/authority decision propagates
  through automation down to physical aircraft behavior — directly analogous to what the
  capstone's trajectory-intent chain is trying to depict, but for safety-control commands
  rather than economic-objective flow-down.
- **New glossary terms surfaced:** ISO/IEC/IEEE 42010 (architecture description
  standard), STAMP (System-Theoretic Accident Model and Processes), IASMS (In-Time
  Aviation Safety Management System) — added to `glossary.md`. Also present but not
  added (lower priority, more UAM-specific): "digital flight rules," NASA UAM Maturity
  Levels, "monitor-assess-mitigate" decision loop.
- **New stakeholders/objectives not yet in `stakeholder-register.md`:** No new
  stakeholder *class* — existing PESTLE rows (FAA, airports, local communities,
  manufacturers) cover the actors named. What is new is the explicit framing of
  **authority fragmentation across regulators/operators/automation as itself a named risk
  factor** — worth carrying into the §7 responsibility-analysis pass as a citable
  argument for why authority/responsibility boundaries need to be drawn carefully, not
  just as a modeling nicety.

## Confidence / limitations

High confidence — the paper was fully read (all 12 pages) and is a rigorous, recent
(2026), 106-source systematic review in a top-tier reliability/safety journal. Main
limitation for capstone use: its domain is low-altitude/UAM aviation, which the paper
itself explicitly distinguishes from "traditional aviation" — if the capstone's SOI
boundary excludes UAM/low-altitude operations (an open question in
`knowledge/questions/open-questions.md` §1), this source's content should be cited as an
*analogous SoS-safety framework* rather than as direct evidence about the conventional
NAS. It is also a review/framework paper, not primary empirical research — its
stakeholder-conflict claims (§3.3) are synthesized from the literature it surveys, not
independently demonstrated.
