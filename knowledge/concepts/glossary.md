# Glossary

_Domain terms and acronyms, defined once so they don't get redefined inconsistently
across sessions or documents. Add to this file whenever a new term shows up in a source
or conversation — don't let definitions live only in someone's head or a single PDF._

## Systems engineering / MBSE

- **ISD** — Interdisciplinary/Integrative Systems Design (the UofM capstone program this
  project is for).
- **SoS** — System of Systems.
- **SOI** — System of Interest.
- **MBSE** — Model-Based Systems Engineering.
- **SysML** — Systems Modeling Language.
- **BDD** — Block Definition Diagram (SysML structural view).
- **IBD** — Internal Block Diagram (SysML structural view showing internal connections).
- **ConOps** — Concept of Operations.
- **RACCI** — Responsible / Accountable / Consulted / Contributing / Informed (a RACI
  variant used for responsibility mapping — see `to-do-list.md` §7).
- **PESTLE** — Political, Economic, Social, Technical(/Technological), Legal,
  Environmental (stakeholder-discovery framework — see
  [[stakeholder-register]]).
- **MOE / MOP** — Measure of Effectiveness / Measure of Performance.
- **Holon / holarchy** — A holon is a semi-autonomous unit that is simultaneously a
  self-contained whole and a subordinate part of a larger structure; a holarchy is the
  recursive hierarchy of holons. Used as an alternative SoS decomposition pattern in
  `sadik2025holonicUAM` — see [[source-register]].
- **ISO/IEC/IEEE 42010** — the international standard for architecture description,
  defining architecture in terms of stakeholders, concerns, and viewpoints. Used by
  `yao2026loAltitudeSoSSafety` to justify a three-facet SoS decomposition
  (composition/environment interaction; organizational/operational structure;
  governance/evolution).
- **STAMP** — System-Theoretic Accident Model and Processes (Leveson); frames safety as a
  control problem (Controller–Actuators–Sensors–Controlled Process feedback loop). Used in
  `yao2026loAltitudeSoSSafety`'s safety-control-loop framing.
- **IASMS** — In-Time Aviation Safety Management System; an evolution of traditional
  Safety Management Systems (SMS) toward continuous, real-time safety monitoring. See
  `yao2026loAltitudeSoSSafety`.
- **TBO** — Trajectory-Based Operations; the ATM operational paradigm in which flight
  trajectories (not just clearances) are the primary object shared and managed across
  ATM systems — closely related to this project's "trajectory-intent" framing. See
  `great2020d21tboConcept` and `sesarju2025masterPlan` in [[source-register]].
- **CPG** — Cyber-Physical Gap; the difference between a physical entity's actual state
  and its state as perceived/represented by a cybernetic agent (e.g., an aircraft's true
  position/route vs. ATC's tracked/expected position/route). See
  `mordecai2018cyberPhysicalGapAtc` in [[source-register]].
- **KARMA** — Kombination of ARchitecture Model specificAtion; a semantic MBSE modeling
  language (paired with the GOPPRR metamodel) used by `lu2022karmaRoadmap` and
  `liu2025mbseAtmSmt` for ATM architecture modeling and formal verification.

## Airspace / ATC

- **NAS** — National Airspace System.
- **ATC** — Air Traffic Control.
- **ATM** — Air Traffic Management.
- **ANSP** — Air Navigation Service Provider.
- **ARTCC** — Air Route Traffic Control Center (enroute control).
- **ATFM** — Air Traffic Flow Management.
- **NOTAM** — Notice to Air Missions (formerly Notice to Airmen).
- **IFR** — Instrument Flight Rules.
- **FMS** — Flight Management System (onboard system that turns trajectory intent into
  guidance commands).
- **TRACON** — Terminal Radar Approach Control (departure & arrival airspace, between
  tower and ARTCC — see [[candidate-systems-inventory]]).
- **FIR** — Flight Information Region (ICAO-defined airspace block; a NAS may contain a
  Lower and Upper FIR — see [[candidate-systems-inventory]]).
- **ATCSCC** — Air Traffic Control System Command Center (national-level traffic-flow
  management, works with GMTOs — General Managers of Tactical Operations).
- **ATFMS** — Air Traffic Flow Management System(s); includes **ETFMS** (Enhanced
  Tactical Flow Management System) and **AMAN** (Arrival Management) — see
  [[candidate-systems-inventory]].
- **SWIM** — System Wide Information Management (shared information-exchange
  infrastructure across ATC/ANSP systems — see [[candidate-systems-inventory]]).
- **FIXM** — Flight Information Exchange Model; a joint FAA/EUROCONTROL/ICAO logical data
  standard for exchanging flight information across ATM systems, with FAA-specific "US
  Extension" fields. See `faaFixmUsExtension2024` in [[source-register]].
- **EASA / CAAC** — European Union Aviation Safety Agency / Civil Aviation Administration
  of China (regulator analogues to the FAA, named in [[candidate-systems-inventory]] as
  examples of a generic "Regulatory System" pattern).

## Airline operations

- **OCC / AOC** — Operations Control Center / Airline Operations Center (day-of-ops
  disruption management, dispatch oversight).
- **A-CDM** — Airport Collaborative Decision Making (EUROCONTROL specification governing
  shared milestone/information exchange during turnaround — see
  `evidence/sources/eurocontrol-specification-for-acdm.pdf`).
- **W&B** — Weight and Balance (load control).
- **ARP / CRP / PRP** — Aircraft Recovery Problem / Crew Recovery Problem / Passenger
  Recovery Problem — the three sequential sub-problems of airline disruption management
  (see `santana2023arpReview` in [[source-register]]).

- **FOC** — Flight Operations Center; the term used by Seamster et al. (2011) for what this
  project calls the OCC/AOC (their acronym list: "AOC … see FOC").
- **PF / PM** — Pilot Flying / Pilot Monitoring: task states that swap between Captain and
  First Officer, not separate roles (`seamster2011collabSystems`).
- **PDC** — Pre-Departure Clearance: the IFR clearance delivered to the crew as a datalink
  (ACARS) message instead of by voice, with voice as fallback (`seamster2011collabSystems`,
  Table E-2). JO 7110.65BB has no paragraph on it by name.
- **EDCT** — Expect Departure Clearance Time: a controlled departure time assigned by traffic
  management (`seamster2011collabSystems` E-1; defined in JO 7110.65BB's Pilot/Controller
  Glossary; departure-release rules in ¶4-3-4).
- **OOOI** — Out / Off / On / In: aircraft-generated reports (out of the gate, wheels off,
  wheels on, in the gate) sent automatically over ACARS to the FOC
  (`seamster2011collabSystems`, p.43).
- **PVD / datablock** — Plan View Display: the En Route controller display through which a
  flight's datablock (its track label) is handed off to the next sector
  (`seamster2011collabSystems`, pp.44, App. B).
- **HOST** — the En Route host computer system that files and processes flight data and
  distributes it to sectors (`seamster2011collabSystems`, pp.43–44). JO 7110.65BB refers to
  ERAM entries (e.g., ¶5-13-9).
- **URET / EDST** — User Request Evaluation Tool (2011 En Route conflict-probe and
  flight-plan-amendment tool, `seamster2011collabSystems`). Where the 2011 report says URET,
  JO 7110.65BB ¶2-10-1 says EDST.
- **CDM / ICR / Early Intent** — Collaborative Decision Making; Integrated Collaborative
  Rerouting, in which stakeholders facing a constraint share *Early Intents* and traffic
  managers decide whether they suffice. Information is shared but "responsibilities are not
  shared and the decision is ultimately made by Traffic Management"
  (`seamster2011collabSystems`, §3.3).
- **LOA** — Letter of Agreement: standing agreement between ATC facilities regulating
  airspace configuration, handoff altitudes/speeds, approaches and procedures
  (`seamster2011collabSystems`, p.20).
- **TMU** — Traffic Management Unit: the traffic-flow function located at ARTCCs, TRACONs and
  major towers, coordinated nationally by the Command Center (**ATCSCC**, above). A *unit*, not
  a single role — see the crosswalk in [[interaction-catalog-flight-execution]].
- **Handoff / point out** — JO 7110.65BB ¶5-4-2: a *handoff* transfers radar identification
  **and** radio communications to the receiving controller; a *point out* transfers radar
  identification for the aircraft to pass through another controller's airspace **without** a
  communications transfer.
- **Radar (R) / Radar Associate (RA) / Radar Coordinator (RC) / Radar Flight Data (FD)** —
  En Route sector team positions defined in JO 7110.65BB ¶2-10-1: R talks to the aircraft and
  uses radar for separation; RA ("D-side", "Manual Controller"); RC ("Coordinator", "Tracker",
  "Handoff Controller"); FD ("Assistant Controller", "A-side"). The team as a whole holds the
  responsibility ("no absolute divisions of responsibilities").
- **SPAR** — Systems Performance Adjustments Reference: an operator procedure for adjusting
  takeoff/landing performance to weight, speed, runway length or altitude, sometimes needing
  captain–dispatch coordination (`seamster2011collabSystems`, p.28; operator-specific term).
- **Collaboration (NAS, Seamster et al.)** — "A joint effort between groups to reach a common
  solution based on shared information, consideration for each other's needs and shared
  responsibilities." Their test for whether a current interaction is collaborative
  (`seamster2011collabSystems`, p.47).

## Notes

- This list is intentionally partial. Expand it as sources get annotated
  ([[source-register]]) rather than trying to front-load every possible term now.
