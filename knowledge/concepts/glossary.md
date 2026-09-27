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
- **Captain / First Officer (FO) / PIC** — the project's standard pilot-role names (D-010). Captain and FO are the two persistent roles in the model. **PIC** (pilot in command) is used only where the text is about legal authority: the PIC has final authority over the aircraft (14 CFR 91.3) and is normally the captain.
- **PF / PM** — Pilot Flying / Pilot Monitoring: task states that swap between Captain and
  First Officer, not separate roles (`seamster2011collabSystems`). **PNF** (pilot not flying) is the older term PM replaced. Not used in the model (D-010).
- **Flight follower / ATC coordinator** — AOC roles (`berry2011aocActors`). The flight follower monitors and tracks flights in progress (the "radar-focused" dispatcher role). The ATC coordinator is the AOC's single point of contact with ATC/TFM; the dispatcher does not talk to ATC directly except in emergencies. Role boundaries blur in practice (`munro2018managingVariability`).
- **Tankering** — carrying extra fuel from a station where it is cheaper to avoid buying it at the destination. A dispatcher fuel decision driven by station fuel prices.
- **ACARS** — Aircraft Communications Addressing and Reporting System: the air-ground datalink (VHF or Satcom) that carries AOC messages (OOOI, maintenance, W&B) and some ATS services (PDC, D-ATIS, FANS 1/A CPDLC).
- **CPDLC / Data Comm** — Controller-Pilot Data Link Communications: ATC clearances and requests as datalink messages. The FAA's Data Comm program delivers departure clearances and en route CPDLC domestically. Oceanic CPDLC is the primary means outside VHF coverage (JO 7110.65BB ¶8-1-6). The crew must accept a CPDLC clearance before it can be loaded into the FMS.
- **D-ATIS** — Digital ATIS delivered over ACARS.
- **ADS-B (Out)** — Automatic Dependent Surveillance–Broadcast: the aircraft broadcasts its position and the ATC-assigned beacon code. Surveillance, not a datalink to the AOC. ADS-B-equipped aircraft still need an operable transponder (JO 7110.65BB ¶5-2-1 NOTE).
- **Mode 3/A / Mode C / Mode S** — transponder replies: beacon code (3/A), pressure altitude (C), and selective addressing/data (S). ATC validates Mode C when it is within 300 ft of the pilot-reported altitude (JO 7110.65BB ¶5-2-15).
- **EFC** — Expect Further Clearance: the time a holding aircraft can expect to leave the fix, issued with holding instructions (JO 7110.65BB ¶4-6-1).
- **Safety alert** — controller call for unsafe proximity to terrain, obstructions or other aircraft; a first-priority duty. Once issued, the action is "solely the pilot's prerogative" (JO 7110.65BB ¶2-1-6).
- **FSM / TBFM / TFMS / DRT** — TFM tools, modeled as media, not parties (D-010): Flight Schedule Monitor (GDP/AFP/GS slots, used by FAA and operators); Time-Based Flow Management (metering); Traffic Flow Management System (TOS, Early Intent, monitor/alert, RAD); Diversion Recovery Tool (operator priorities for diverted flights, JO 7210.3EE ¶18-4-5).
- **SMART** — Strategic Management of Airspace, Routes and Trajectories: an AI-supported FAA TFM planning tool, in limited use around Washington, D.C. since 2026-09-21 (news coverage; not yet a registered source, see `inbox/2026-09-27-tfm-research-leads.md`).
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
- **TMI** — Traffic Management Initiative: a technique for matching demand to capacity. JO 7210.3EE ¶18-7-4 lists the types: altitude (capping, tunneling, LAADR), miles-in-trail (MIT), minutes-in-trail (MINIT), fix balancing, airborne holding, departure sequencing (DSP), TFMS programs (GDP, AFP, CTOP), reroutes, and ground stops (GS). The ATCSCC approves interfacility TMIs that cause reportable (≥ 15 min) delays (¶18-7-7). TMIs exclude controller-coordinated actions (`faa2025jo72103ee`).
- **GDP / AFP / GS** — Ground Delay Program (ATCSCC assigns arrival slots, so flights get EDCTs and wait on the ground), Airspace Flow Program (the same idea applied to an FCA), and Ground Stop (flights meeting given criteria stay on the ground; one of the most restrictive TMIs). JO 7210.3EE §§18-10, 18-11, 18-13.
- **CTOP / TOS** — Collaborative Trajectory Options Program: a TMI that assigns each flight the most preferred available option from its **Trajectory Options Set**. The TOS is a message sent *by the flight operator* to TFMS that ranks route/altitude/speed options by acceptable ground delay (JO 7210.3EE ¶18-12-1, ¶18-12-3).
- **FEA / FCA** — Flow Evaluation Area / Flow Constrained Area: an airspace region, flight filters, and time window used to identify flights affected by a constraint. Stakeholders *may* need to act on an FEA and *are required* to act on an FCA (JO 7210.3EE ¶18-8-2).
- **NTML** — National Traffic Management Log: the FAA tool in which facilities record and coordinate TM events, TBM operations, TMIs, delays, and restrictions. Facilities must use it "in preference to other methods" (JO 7210.3EE ¶18-5-3, ¶18-5-8).
- **MAP** — Monitor Alert Parameter: the sector/airport load threshold in TFMS monitor/alert. The recommended look-ahead is 1.5–2.5 h. Red and yellow alerts are handled within the facility, and changes to MAP values are reported to the ATCSCC (JO 7210.3EE §18-9).
- **TCA** — Tactical Customer Advocate: the ATCSCC position that operators coordinate with when they cannot comply with an FEA/FCA, or when they need an earlier EDCT (JO 7210.3EE ¶18-8-3d, ¶18-11-4e).
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
