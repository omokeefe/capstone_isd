# Aeronautical Information Manual (AIM): Official Guide to Basic Flight Information and ATC Procedures (Basic 2025-02-20, with Changes 1–3 through 2026-07-09)

- **File:** `evidence/sources/AIM_Basic_w_Chg_1_and_2_and_3_dtd_7-9-26_FINAL.pdf`
- **Bib key:** `faa2025aim`
- **Authors:** Federal Aviation Administration (U.S. Department of Transportation)
- **Year:** 2025 (Basic effective February 20, 2025); consolidated with CHG 1 (Aug 7, 2025), CHG 2 (Jan 22, 2026), CHG 3 (Jul 9, 2026)
- **Venue:** FAA Aeronautical Information Manual (918 pp. in this PDF, including the Pilot/Controller Glossary and index)
- **DOI:** none (government publication)

## What it is

The FAA's pilot-facing guide to flight information and ATC procedures in the NAS. It is the pilot-side counterpart to JO 7110.65BB (`faa2025jo711065bb`): 7110.65 tells the controller what to do, and the AIM tells the pilot what to expect and what is expected of them. Eleven chapters: 1 Air Navigation, 2 Lighting and Visual Aids, 3 Airspace, **4 Air Traffic Control**, **5 Air Traffic Procedures** (preflight, departure, en route, arrival, pilot/controller roles), 6 Emergency Procedures, 7 Safety of Flight, 8 Medical, 9 Charts, 10 Helicopters, 11 UAS. This copy is consolidated through Change 3, so it is current as of 2026-07-09.

## Why it's valuable — and to what

This is the source the register was missing for the **flight-crew side of nominal IFR flight execution** (the "Literature gaps" item in `knowledge/questions/open-questions.md`, and the placeholder row in the §3–§4 annotation table).

- **Literature review:** `to-do-list.md` §4 (nominal ATC/flight execution, flight-crew side). Pairs with `faa2025jo711065bb` (controller side) and `faa2025jo72103ee` (traffic management side) as the FAA primary source set.
- **Decomposition / architecture (§6, §10):**
  - **Facility roles in plain terms:** ARTCC, tower, FSS (¶4-1-1 to 4-1-3); Departure Control as "an approach control function" (¶5-2-8); an ARTCC "divided into sectors," each "handled by one or a team of controllers" (¶5-3-1). The last one bears on the open position-level vs team-level question.
  - **A tower → airline → aircraft exchange:** ¶5-2-2 says the PDC clearance goes from the tower's Clearance Delivery controller "via data link to participating airline/service provider computers," and "the airline/service provider will then deliver the clearance via … ACARS." CPDLC-DCL instead goes from the tower straight to the avionics and needs a crew response. So the departure clearance can pass through the operator's systems. Check this against the context diagram's tower, AOC, and flight-deck links.
  - **Message vocabulary for sequence diagrams and item flows:** the CPDLC message tables in ¶5-3-1 list uplink (UM, controller → crew) and downlink (DM, crew → controller) messages for route, altitude, hold, and deviation. They are a ready-made, FAA-published set of named exchanges.
- **Stakeholder / objective ontology and RACCI (§7-§9):** Section 5-5, "Pilot/Controller Roles and Responsibilities," lists pilot and controller responsibilities side by side for 15 procedures (clearance, approaches, vectors, safety alert, see and avoid, speed adjustments, traffic advisories, visual separation, instrument departures, minimum fuel, RNAV/RNP). This is close to a pre-built responsibility matrix for the pilot ↔ controller pair. Key statements:
  - PIC "is directly responsible for, and is the final authority as to the safe operation of that aircraft" (¶5-5-1b, pointing to 14 CFR 91.3).
  - Controller priorities: first separation and safety alerts, second other required services, third additional services "to the extent possible" (¶5-5-1c).
  - "The responsibilities of the pilot and the controller intentionally overlap in many areas providing a degree of redundancy" (¶5-5-1e). This is direct evidence for the "ambiguous/shared authority" item in to-do §7.
  - Speed: "It is the pilot's responsibility and prerogative to refuse speed adjustments considered excessive or contrary to the aircraft's operating specifications" (¶5-5-9 NOTE).
- **Optimization study (§11-§13):** the clearance text shows where the operator's preferred trajectory gets overridden. Clearances "are normally issued for the altitude or flight level and route filed by the pilot," but ATC "frequently" specifies something different "due to traffic conditions," and preferred routes exist because "traffic capacity is increased by routing all traffic on preferred routes" (¶4-4-3). That is the airline-cost vs. ATC-capacity tension in the FAA's own words. ¶4-4-12 gives numeric speed-adjustment limits usable as constraints.
- **Trajectory-intent chain:** the AIM covers the middle of the chain end to end: flight plan (¶5-1) → clearance "as filed" for route but *not* altitude (¶5-2-6) → amended clearances (¶4-4-4) → adherence (¶4-4-10) → FMS loading rules (¶5-5-16: an RNAV procedure must be "retrievable by the procedure name from the current aircraft navigation database"; crews "must verify that the appropriate changes are loaded" after a runway or procedure change).
- **Glossary / terminology:** clearance, "cruise" clearance, ATIS, TEC, LUAW, STR, PDC, CPDLC-DCL, TDLS, TIS, RCAG, minimum fuel. The Pilot/Controller Glossary is bound in (PDF pp. 755–904).

## Rating

**5/5** — Core: the FAA's own statement of flight-crew responsibilities and of the pilot ↔ controller exchange for every phase of a nominal IFR flight. It closes the flight-crew-side literature gap and will be cited next to JO 7110.65BB.

## Flags

- **Not regulatory.** The AIM is guidance. ¶5-5-1a says pilot responsibilities "are in the CFRs," and ¶5-5-1f says the Section 5-5 list "is not meant as an interpretation of the rules nor is it intended to extend or diminish responsibilities." For an authority claim (for example PIC final authority), cite 14 CFR 91.3 as the rule and the AIM as the FAA's explanation of it. 14 CFR 91/121 is still not in the register.
- **Written for all pilots, not for Part 121.** It never mentions a dispatcher or an AOC. The operator appears only as "company procedures" (¶4-4-4) and "airline/service provider computers" (¶5-2-2). Joint dispatcher/PIC authority under Part 121 is not covered here, so the dispatch side of the literature gap stays open.
- **Flight-plan change cutoff differs slightly between sources.** AIM ¶5-1-12 says changes "should be completed more than 46 minutes prior to the proposed departure time." JO 7210.3EE says 45 minutes. JO 7110.10EE TBL 6-2-1 shows the lockout is per ARTCC: 46 minutes at most centers, 55 at Boston, 61 at Indianapolis and New York, 43 at Anchorage. Use the table if a number is needed.
- **Overlap with other registered sources, not a duplicate:** the Pilot/Controller Glossary is also bound into `faa2025jo711065bb` and `faa2025jo711010ee` (this copy is the newest). Appendix 4 (FAA Form 7233-4) has the same title as Appendix A of `faa2025jo711010ee`; the two were not compared.
- **Edition:** consolidated through CHG 3. JO 7110.65BB in the register is Basic only, so paragraph cross-references between the two may be one or more changes apart.
- **Read depth is partial** (see below). Chapters 1–3, 6, and 8–11 were read from the table of contents only.

## Second pass (2026-10-04): sections marked in the contents but not highlighted

_The owner marked 17 sections in the table of contents that had no body highlights. Three of them (¶5-5-1, 5-5-2, 5-5-9) were covered in the first pass above. The other 14 were read in full here. Each finding is checked against what the repo already holds (`context-diagram-exchange-evidence.md`, the `faa2025jo711065bb` and `faa2025jo72103ee` summaries, the Seamster interaction catalog, the `.sysml` doc comments). "New" means no existing note says it. Quotes are verbatim; page numbers are PDF pages._

### New and directly useful

**1. Landing sequence is first-come, first-served (¶5-4-26, p. 459).** New; no existing note mentions it.
- "ATCTs handle all aircraft, regardless of the type of flight plan, on a 'first-come, first-served' basis. Therefore, because of local traffic or runway in use, it may be necessary for the controller in the interest of safety, to provide a different landing sequence. In any case, a landing sequence will be issued to each aircraft as soon as possible to enable the pilot to properly adjust the aircraft's flight path."
- **Use:** this is the FAA's stated allocation rule for the runway today. It is a candidate current-state policy to compare an alternative objective against (to-do §11, and the open "current-state metric" question). An approach clearance type "does not mean that landing priority will be given over other traffic." It applies to towers; the en-route and TFM counterpart is the "equitable assignment of delays" in JO 7210.3EE ¶18-10-2.

**2. Fuel conservation is a stated aim of an ATC program (¶5-4-2 Local Flow Traffic Management Program, pp. 395–396).** New.
- "This program is a continuing effort by the FAA to enhance safety, minimize the impact of aircraft noise and conserve aviation fuel." "Fuel conservation is accomplished by absorbing any necessary arrival delays for aircraft included in this program operating at the higher and more fuel efficient altitudes."
- "A fuel efficient descent is basically an uninterrupted descent (except where level flight is required for speed adjustment) from cruising altitude to the point when level flight is necessary for the pilot to stabilize the aircraft on final approach. … This will generally result in a descent gradient window of 250−350 feet per nautical mile."
- "ATC will expect the pilot to descend first to the crossing altitude and then reduce speed."
- **Use:** three objectives in one FAA paragraph (safety, noise, fuel), with fuel named as something ATC procedure design serves. That is an *alignment* between the airline fuel objective and ATC, to set beside the conflict in ¶4-4-3. It belongs in the objective ontology (§8) cross-category synthesis. The 250–350 ft/NM window is a citable descent parameter for the §12 simulation. Note that it applies to turbojet and turboprop aircraft over 12,500 lb.

**3. "Descend via" hands the vertical profile to the crew (¶5-4-1 STAR Procedures, pp. 393–395).** Partly new. The BB summary lists "climb/descend via a route" as a clearance type (¶4-4-2) but not what it authorizes.
- "Clearance to 'descend via' authorizes pilots to: (1) Descend at pilot's discretion to meet published restrictions and laterally navigate on a STAR."
- "If vectored or cleared to deviate off a STAR, pilots must consider the STAR canceled. If the STAR contains published altitude restrictions, speed restrictions, or a chart note used to transition from Mach to IAS, those restrictions are also canceled and pilots will receive an altitude to maintain and, if necessary, a speed."
- "'Expect' altitudes/speeds are not considered STAR procedures crossing restrictions unless verbally issued by ATC."
- "As with any ATC clearance or portion thereof, it is the responsibility of each pilot to accept or refuse an issued STAR. Pilots should notify ATC if they do not wish to use a STAR by placing 'NO STAR' in the remarks section of the flight plan."
- Pilots cleared to descend via "must inform ATC upon initial contact with a new frequency, of the altitude leaving, 'descending via (procedure name),' the runway transition or landing direction if assigned, and any assigned restrictions not published on the procedure."
- **Use:** a clean authority transition for the RACCI (to-do §7 "authority transitions"). Under "descend via," ATC sets the constraints and the crew (in practice the FMS) chooses the path within them. A vector takes that discretion back. It also shows operator intent reaching ATC through a flight plan remark ("NO STAR"), and intent being restated by the crew at each frequency change. Five worked phraseology examples (pp. 394–395) are ready material for a sequence diagram.

**4. FAA text for what a clearance does to the FMS (¶5-4-6 Approach Clearance, pp. 420–422).** New as a citable source. Link 6 (crew ↔ aircraft) is graded [SME] today.
- STAR-to-approach connectivity: "pilots are expected to ensure that the RNAV system is loaded with the approach beginning at that IAF or IF so that the STAR and approach are connected. ATC will clear the aircraft for the instrument approach by stating the IAF fix/waypoint by name with the approach clearance."
- "Selection of 'Vectors-to-Final' or 'Vectors' option for an instrument approach may prevent approach fixes located outside of the FAF from being loaded into an RNAV system. Therefore, the selection of these options is discouraged due to increased workload for pilots to reprogram the navigation system."
- RF legs: "Since not all aircraft have the capability to fly these leg types, pilots are responsible for knowing if they can conduct an RNAV approach with an RF leg." "ATC will not clear aircraft direct to any waypoint beginning or within an RF leg."
- RNAV aircraft may be cleared direct to the IAF/IF "at intercept angles not greater than 90 degrees" and to a fix between the IF and FAF at "not greater than 30 degrees"; ATC "will advise the pilot to expect clearance direct to the IF at least 5 miles from the fix."
- **Use:** with ¶5-5-16, this is FAA-published text on the ATC constraint → FMS intent step of the chain: the form of the clearance decides what the crew must load, and aircraft capability limits what ATC may issue. It lets part of link 6 be cited to a source in addition to the owner's expertise.

**5. Position reports stop under radar contact (¶5-3-2, 5-3-3, pp. 375–378).** New as a correction. The exchange-evidence table for link 4 lists "Position, altitude-vacating and reporting-point reports" as crew → ATC without a condition.
- "When informed by ATC that their aircraft are in 'Radar Contact,' pilots should discontinue position reports over designated reporting points. They should resume normal position reporting when ATC advises 'RADAR CONTACT LOST' or 'RADAR SERVICE TERMINATED.'"
- Position report items: identification; position; time; altitude or flight level; type of flight plan; "ETA and name of next reporting point"; "the name only of the next succeeding reporting point along the route of flight"; pertinent remarks.
- Reports made "at all times" without a request (¶5-3-3a1): vacating an assigned altitude; unable to climb or descend at 500 fpm; missed approach; true airspeed change of 5 percent or 10 knots from the flight plan; time and altitude reaching a holding fix; leaving a holding fix; loss of navigation or communication capability; "any information relating to the safety of flight."
- Not in radar contact: "a corrected estimate at anytime it becomes apparent that an estimate as previously submitted is in error in excess of 2 minutes."
- **Use:** for a nominal domestic flight (radar environment), the crew → ATC flow is the ¶5-3-3 list, not routine position reports. Label the position-report exchange as non-radar/oceanic in the model. The position report itself is a small trajectory-intent message (current position plus the next two points and an ETA), with a 2-minute accuracy tolerance.

### New, supporting

**6. Approach and departure control are functions, not facilities (¶5-4-3, pp. 396–397; with ¶5-2-8).** Bears on the open ownership question in `context-diagram-exchange-evidence.md` ("who do apron, tower, and departure/arrival controllers belong to?").
- "ARTCCs are approved for and may provide approach control services to specific airports."
- "Prior to arriving at the destination radio facility, instructions will be received from ARTCC to contact approach control on a specified frequency." "When radar handoffs are utilized, successive arriving flights may be handed off to approach control with radar separation in lieu of vertical separation."
- "Radar vectors and altitude or flight levels will be issued as required for spacing and separating aircraft. Therefore, pilots must not deviate from the headings issued by approach control."
- **Use:** supports modeling approach/departure control as a function allocated to a facility (TRACON, or an ARTCC), not as a part of one fixed facility.

**7. How PIREPs travel (¶7-1-18, pp. 560–562).** Fills a gap the BB summary recorded as not covered ("how PIREPs reach forecasters").
- "PIREPs should be given to the ground facility with which communications are established; i.e., FSS, ARTCC, or terminal ATC."
- "The ARTCC uses the reports to expedite the flow of en route traffic, to determine most favorable altitudes, and to issue hazardous weather information within the center's area." "The NWS uses the reports to verify or amend conditions contained in aviation forecast and advisories."
- "All air traffic facilities and the NWS forward the reports received from pilots into the weather distribution system."
- TBL 7-1-8 gives the 13 PIREP elements (station, type UA/UUA, location, time, altitude, aircraft type, sky cover, weather, temperature, wind, turbulence, icing, remarks).
- **Use:** a crew → ATC → weather-service feedback loop, with the aircraft acting as a sensor. It is an exchange that crosses from the modeled systems into the Environment (Information Services / NWS). TBL 7-1-8 is an attribute list for a `PilotReport` item if one is wanted.

**8. TCAS resolution advisory moves separation responsibility for a time (¶4-4-16, pp. 287–288).** Pilot-side wording of what the BB summary already has from the controller side. Off-nominal.
- "Each pilot who deviates from an ATC clearance in response to an RA must notify ATC of that deviation as soon as practicable."
- "The serving IFR air traffic facility is not responsible to provide approved standard IFR separation to an IFR aircraft, from other aircraft, terrain, or obstructions after an RA maneuver until one of the following conditions exists: 1. The aircraft has returned to its assigned altitude and course. 2. Alternate ATC instructions have been issued. 3. A crew member informs ATC that the TCAS maneuver has been completed."
- "At this time, no air traffic service nor handling is predicated on the availability of TCAS equipment in the aircraft."
- **Use:** an explicit, bounded responsibility transfer with its end conditions listed. Keep for the off-nominal catalog, not the nominal scenario.

**9. The FAA states an efficiency-vs-separation tradeoff outright (¶5-3-5 Airway or Route Course Changes, pp. 380–381).**
- Providing extra separation for fast turning aircraft "creates an unacceptable waste of airspace and imposes a penalty upon the preponderance of traffic which operate at low speeds. Consequently, the FAA expects pilots to lead turns." Airway width is "4 nautical miles each side of centerline."
- **Use:** a small, quotable example of the FAA choosing system throughput over a per-aircraft margin and assigning the fix to the pilot. Marginal for the model.

### Read, little or nothing to use

- **¶5-2-1 Pre-taxi Clearance Procedures (p. 343):** participation is optional; pilots call "not more than 10 minutes before proposed taxi time." One timing number for the activity diagram. For Part 121 the PDC path in ¶5-2-2 matters more.
- **¶7-1-8 Inflight Weather Advisory Broadcasts (pp. 538–539):** ARTCCs broadcast SIGMETs and center weather advisories "once on all frequencies" when the area is "within 150 miles" of their airspace; towers and approach controls may use 50 miles. Corroborates the weather exchange already on link 4 (BB ¶2-6-x) and adds the distance thresholds.
- **¶7-1-5 Preflight Briefing (pp. 524–527):** describes FSS briefings for pilots (standard, abbreviated, outlook). The standard briefing includes "ATC Delays. Any known ATC delays and flow control advisories which might affect the proposed flight." For Part 121 the dispatcher supplies this, which the AIM does not cover. Not useful beyond a list of what a briefing contains.
- **¶5-4-19 Side-step Maneuver (p. 447):** an approach to one of two parallel runways "separated by 1,200 feet or less" with a landing on the other. Nothing for this project.

### Also resolved by the first pass, noted here because it changes a grade

`context-diagram-exchange-evidence.md` records "domestic CPDLC unsourced" (C) and PDC over ACARS at B. AIM ¶5-2-2 (PDC and CPDLC-DCL via TDLS) and ¶5-3-1 (En Route CPDLC services and message tables) are FAA-published descriptions of both. Candidate upgrade for `atcAircraftDatalink`; the owner decides.

## Highlighted passages

_Digital highlights the user marked up in the PDF (about 100 marks plus one underline, no ink annotations), extracted 2026-10-04 via `tools/extract_pdf_annotations.py`. Text is verbatim, re-read from the page to remove extraction artifacts, and grouped by paragraph. Page numbers are PDF pages. The CPDLC table highlights are condensed to a list._

**Table of contents (pp. 57–63): sections marked to read.** Body highlights exist for these: ARTCCs, Control Towers, FSS, ATIS, TEC, Airports with an Operating Control Tower, Clearance, Pilot Responsibility upon Clearance Issuance, Speed Adjustments (Ch. 4), Taxi Clearance, LUAW, Departure Control, ARTCC Communications. **Marked in the contents but with no body highlight yet:** TCAS I & II, Pre-taxi Clearance Procedures, Position Reporting, Additional Reports, Airway or Route Course Changes, STAR Procedures (one stray mark only), Local Flow Traffic Management Program, Approach Control, Approach Clearance, Side-step Maneuver, Landing Priority, Air Traffic Clearance, General, Speed Adjustments (Ch. 5), Preflight Briefing, Inflight Weather Advisory Broadcast, PIREPs. These were read on 2026-10-04; see "Second pass" above.

**¶4-1-1 to 4-1-3, facilities (p. 204)**
- "Centers are established primarily to provide air traffic service to aircraft operating on IFR flight plans within controlled airspace, and principally during the en route phase of flight."
- "Towers have been established to provide for a safe, orderly and expeditious flow of traffic on and in the vicinity of an airport. When the responsibility has been so delegated, towers also provide for the separation of IFR aircraft in the terminal areas."
- "Flight Service Stations (FSSs) are air traffic facilities that provide pilot briefings, flight plan processing, en route flight advisories, search and rescue services, and assistance to lost aircraft and aircraft in emergency situations. FSSs also relay ATC clearances, process Notices to Airmen, and broadcast aviation weather and aeronautical information. In Alaska, designated FSSs also take weather observations, and provide Airport Advisory Services (AAS)."

**¶4-1-9 (p. 208)**
- "UNICOM is a nongovernment air/ground radio communication station which may provide airport information at public use airports where there is no tower or FSS."

**¶4-1-13 ATIS (pp. 212–213)**
- "ATIS is the continuous broadcast of recorded noncontrol information in selected high activity terminal areas. Its purpose is to improve controller effectiveness and to relieve frequency congestion by automating the repetitive transmission of essential but routine information. The information is continuously broadcast over a discrete VHF radio frequency or the voice portion of a local NAVAID. Arrival ATIS transmissions on a discrete VHF radio frequency are engineered according to the individual facility requirements, which would normally be a protected service volume of 20 NM to 60 NM from the ATIS site and a maximum altitude of 25,000 feet AGL."
- "ATIS information includes: 1. Airport/facility name 2. Phonetic letter code 3. Time of the latest weather sequence (UTC) 4. Weather information consisting of: (a) Wind direction and velocity (b) Visibility (c) Obstructions to vision (d) Present weather consisting of: sky condition, temperature, dew point, altimeter, a density altitude advisory when appropriate, and other pertinent remarks included in the official weather observation 5. Instrument approach and runway in use."
- Example: "Dulles International information Sierra. One four zero zero zulu. Wind three five zero at eight. Visibility one zero. Ceiling four thousand five hundred broken. Temperature three four. Dew point two eight. Altimeter three zero one zero. ILS runway one right approach in use. Departing runway three zero. Advise on initial contact you have information sierra."

**¶4-1-16 Safety Alert (p. 216)**
- "A safety alert will be issued to pilots of aircraft being controlled by ATC if the controller is aware the aircraft is at an altitude which, in the controller's judgment, places the aircraft in unsafe proximity to terrain, obstructions or other aircraft."

**¶4-1-19 Tower En Route Control (pp. 220–221)**
- "TEC is an ATC program to provide a service to aircraft proceeding to and from metropolitan areas. It links designated Approach Control Areas by a network of identified routes made up of the existing airway structure of the National Airspace System. The FAA initiated an expanded TEC program to include as many facilities as possible. The program's intent is to provide an overflow resource in the low altitude system which would enhance ATC services."
- "A few facilities have historically allowed turbojets to proceed between certain city pairs, such as Milwaukee and Chicago, via tower en route and these locations may continue this service. However, the expanded TEC program will be applied, generally, for nonturbojet aircraft operating at and below 10,000 feet."
- "The program is entirely within the approach control airspace of multiple terminal facilities. Essentially, it is for relatively short flights. Participating pilots are encouraged to use TEC for flights of two hours duration or less. If longer flights are planned, extensive coordination may be required within the multiple complex which could result in unanticipated delays."

**¶4-3-1, 4-3-2 airport operations (p. 237)**
- "Increased traffic congestion, aircraft in climb and descent attitudes, and pilot preoccupation with cockpit duties are some factors that increase the hazardous accident potential near the airport. The situation is further compounded when the weather is marginal, that is, just meeting VFR requirements. Pilots must be particularly alert when operating in the vicinity of an airport."
- "Initial callup should be made about 15 miles from the airport."

**¶4-3-20 Standard Taxi Routes (p. 263)**
- "Standard Taxi Routes (STRs) provide a standard, predictable taxi route from an origination point to a termination point on the airport movement area. The use of STRs helps reduce frequency congestion and streamline taxi procedures. STRs may be available at certain airports. Absent an STR Letter of Agreement (LOA), issuance of an STR will be at the request of the pilot and discretion of ATC. STRs used under an LOA are issued by ATC and are not required to be requested by the pilot."

**¶4-4-1 Clearance (p. 275)**
- "A clearance issued by ATC is predicated on known traffic and known physical airport conditions. An ATC clearance means an authorization by ATC, for the purpose of preventing collision between known aircraft, for an aircraft to proceed under specified conditions within controlled airspace. IT IS NOT AUTHORIZATION FOR A PILOT TO DEVIATE FROM ANY RULE, REGULATION, OR MINIMUM ALTITUDE NOR TO CONDUCT UNSAFE OPERATION OF THE AIRCRAFT."
- "if a pilot prefers to follow a different course of action, such as make a 360 degree turn for spacing to follow traffic when established in a landing or approach sequence, land on a different runway, takeoff from a different intersection, takeoff from the threshold instead of an intersection, or delay operation, THE PILOT IS EXPECTED TO INFORM ATC ACCORDINGLY. When the pilot requests a different course of action, however, the pilot is expected to cooperate so as to preclude disruption of traffic flow or creation of conflicting patterns."

**¶4-4-3 Clearance Items (p. 276)**
- "Clearances are normally issued for the altitude or flight level and route filed by the pilot. However, due to traffic conditions, it is frequently necessary for ATC to specify an altitude or flight level or route different from that requested by the pilot. In addition, flow patterns have been established in certain congested areas or between congested areas whereby traffic capacity is increased by routing all traffic on preferred routes. Information on these flow patterns is available in offices where preflight briefing is furnished or where flight plans are accepted." (The last sentence is also underlined.)
- "The altitude or flight level instructions in an ATC clearance normally require that a pilot 'MAINTAIN' the altitude or flight level at which the flight will operate when in controlled airspace. Altitude or flight level changes while en route should be requested prior to the time the change is desired."
- "When possible, if the altitude assigned is different from the altitude requested by the pilot, ATC will inform the pilot when to expect climb or descent clearance or to request altitude change from another facility. If this has not been received prior to crossing the boundary of the ATC facility's area and assignment at a different altitude is still desired, the pilot should reinitiate the request with the next facility."
- "The term 'cruise' may be used instead of 'MAINTAIN' to assign a block of airspace to a pilot from the minimum IFR altitude up to and including the altitude specified in the cruise clearance. The pilot may level off at any intermediate altitude within this block of airspace. Climb/descent within the block is to be made at the discretion of the pilot. However, once the pilot starts descent and verbally reports leaving an altitude in the block, the pilot may not return to that altitude without additional ATC clearance."

**¶4-4-4 Amended Clearances (p. 277)**
- "Amendments to the initial clearance will be issued at any time an air traffic controller deems such action necessary to avoid possible confliction between aircraft. Clearances will require that a flight 'hold' or change altitude prior to reaching the point where standard separation from other IFR traffic would no longer exist."
- "Pilots have the privilege of requesting a different clearance from that which has been issued by ATC if they feel that they have information which would make another course of action more practicable or if aircraft equipment limitations or company procedures forbid compliance with the clearance issued."

**¶4-4-7 Pilot Responsibility upon Clearance Issuance (p. 278)**
- "When conducting an IFR operation, make a written record of your clearance. The specified conditions which are a part of your air traffic clearance may be somewhat different from those included in your flight plan. Additionally, ATC may find it necessary to ADD conditions, such as particular departure route. The very fact that ATC specifies different or additional conditions means that other aircraft are involved in the traffic situation."

**¶4-4-10 Adherence to Clearance (p. 280)**
- "When air traffic clearance has been obtained under either visual or instrument flight rules, the pilot-in-command of the aircraft must not deviate from the provisions thereof unless an amended clearance is obtained. When ATC issues a clearance or instruction, pilots are expected to execute its provisions upon receipt. ATC, in certain situations, will include the word 'IMMEDIATELY' in a clearance or instruction to impress urgency of an imminent situation and expeditious compliance by the pilot is expected and necessary for safety. The addition of a VFR or other restriction; i.e., climb or descent point or time, crossing altitude, etc., does not authorize a pilot to deviate from the route of flight or any other provision of the ATC clearance."
- "When a heading is assigned or a turn is requested by ATC, pilots are expected to promptly initiate the turn, to complete the turn, and maintain the new heading unless issued additional instructions."
- "When ATC has not used the term 'AT PILOT'S DISCRETION' nor imposed any climb or descent restrictions, pilots should initiate climb or descent promptly on acknowledgement of the clearance. Descend or climb at an optimum rate consistent with the operating characteristics of the aircraft to 1,000 feet above or below the assigned altitude, and then attempt to descend or climb at a rate of between 500 and 1,500 fpm until the assigned altitude is reached."
- "If at anytime the pilot is unable to climb or descend at a rate of at least 500 feet a minute, advise ATC. If it is necessary to level off at an intermediate altitude during climb or descent, advise ATC, except when leveling off at 10,000 feet MSL on descent, or 2,500 feet above airport elevation (prior to entering a Class C or Class D surface area), when required for speed reduction."

**¶4-4-12 Speed Adjustments (pp. 282–283)**
- "ATC will issue speed adjustments to pilots of radar controlled aircraft to achieve or maintain appropriate spacing. If necessary, ATC will assign a speed when approving deviations or radar vectoring off procedures that include published speed restrictions or a chart note used to transition from Mach to IAS. If no speed is assigned, speed becomes pilot's discretion."
- "ATC will express all speed adjustments in terms of knots based on indicated airspeed (IAS) in 5 or 10 knot increments except that at or above FL 240 speeds may be expressed in terms of Mach numbers in 0.01 increments. The use of Mach numbers is restricted to aircraft with Mach meters."
- "Pilots complying with speed adjustments (published or assigned) are expected to maintain a speed within plus or minus 10 knots or 0.02 Mach number of the specified speed."
- "When ATC assigns speed adjustments, it will be in accordance with the following recommended minimums: 1. To aircraft operating between FL 280 and 10,000 feet, a speed not less than 250 knots or the equivalent Mach number. … To arriving turbojet aircraft operating below 10,000 feet: (a) A speed not less than 210 knots, except; (b) Within 20 flying miles of the airport of intended landing, a speed not less than 170 knots. 3. To arriving reciprocating engine or turboprop aircraft within 20 flying miles of the runway threshold of the airport of intended landing, a speed not less than 150 knots. 4. To departing aircraft: (a) Turbojet aircraft, a speed not less than 230 knots. (b) Reciprocating engine aircraft, a speed not less than 150 knots."

**¶4-4-17 and ¶4-5-6 Traffic Information Service (pp. 288, 293–294)**
- "TIS provides proximity warning only, to assist the pilot in the visual acquisition of intruder aircraft. No recommended avoidance maneuvers are provided nor authorized as a direct result of a TIS intruder display or TIS alert. It is intended for use by aircraft in which TCAS is not required."
- "The Traffic Information Service (TIS) provides information to the cockpit via data link, that is similar to VFR radar traffic advisories normally received over voice radio. Among the first FAA-provided data services, TIS is intended to improve the safety and efficiency of 'see and avoid' flight through an automatic display that informs the pilot of nearby traffic and potential conflict situations."
- "TIS provides estimated position, altitude, altitude trend, and ground track information for up to 8 intruder aircraft within 7 NM horizontally, +3,500 and −3,000 feet vertically of the client aircraft … TIS will alert the pilot to aircraft (under surveillance of the Mode S radar) that are estimated to be within 34 seconds of potential collision, regardless of distance or altitude. TIS surveillance data is derived from the same radar used by ATC; this data is uplinked to the client aircraft on each radar scan (nominally every 5 seconds)."

**¶4-5-9 and ¶4-6-2 (pp. 308, 311)**
- Table title marked: "FIS-B Over UAT Product Update and Transmission Intervals."
- "Flight Level Orientation Scheme … Odd Flight Levels: Magnetic Course 000-179 Degrees Even Flight Levels: Magnetic Course 180-359 Degrees."

**¶5-1-1 Preflight Preparation (p. 322)**
- "Prior to every flight, pilots should gather all information vital to the nature of the flight, assess whether the flight would be safe, and then file a flight plan. Pilots can receive a regulatory compliant briefing without contacting Flight Service. Pilots are encouraged to use automated resources and review Advisory Circular AC 91-92, Pilot's Guide to a Preflight Briefing, for more information. Pilots who prefer to contact Flight Service are encouraged to conduct a self-brief prior to calling."
- "Pilots may access Flight Service through www.1800wxbrief.com or by calling 1-800-WX-BRIEF (1-800-992-7433) in the CONUS, Hawaii, and U.S. territories; or 1-833-AK-BRIEF (1-833-252-7433) in Alaska."
- "The information required by the FAA to process flight plans is obtained from FAA Form 7233-4, International Flight Plan."

**¶5-1-3 NOTAM System (p. 324)**
- "Preflight. 14 CFR § 91.103, Preflight Action directs pilots to become familiar with all available information concerning a planned flight prior to departure, including NOTAMs. Pilots may change their flight plan based on available information. Current NOTAM information may affect: 1. Aerodromes. 2. Runways, taxiways, and ramp restrictions. 3. Obstructions. 4. Communications. 5. Airspace. 6. Status of navigational aids or radar service availability. 7. Other information essential to planned en route, terminal, or landing operations."
- "ARTCC NOTAMs. Pilots should also review NOTAMs for the ARTCC area (for example, Washington Center (ZDC), Cleveland Center (ZOB), etc.) in which the flight will be operating. You can find the 3 letter code for each ARTCC on the FAA's NOTAM webpage. These NOTAMs may affect the planned flight. Some of the operations include Central Altitude Reservation Function (CARF), Special Use Airspace (SUA), Temporary" (the highlight ends mid-sentence).

**¶5-1-12 Change in Flight Plan (p. 339)**
- "In addition to altitude or flight level, destination and/or route changes, increasing or decreasing the speed of an aircraft constitutes a change in a flight plan. Therefore, at any time the average true airspeed at cruising altitude between reporting points varies or is expected to vary from that given in the flight plan by plus or minus 5 percent, or 10 knots, whichever is greater, ATC should be advised."
- "All changes to existing flight plans should be completed more than 46 minutes prior to the proposed departure time. Changes must be made with the initial flight plan service provider. If the initial flight plan's service provider is unavailable, filers may contact an ATC facility or FSS to make the necessary revisions. Any revision 46 minutes or less from the proposed departure time must be coordinated through an ATC facility or FSS."

**¶5-2-2 Automated Pre-Departure Clearance Procedures (p. 343)**
- "Many airports in the National Airspace System are equipped with the Terminal Data Link System (TDLS) that includes the Pre-Departure Clearance (PDC) and Controller Pilot Data Link Communication–Departure Clearance (CPDLC-DCL) functions. Both the PDC and CPDLC-DCL functions automate the Clearance Delivery operations in the ATCT for participating users. Both functions display IFR clearances from the ARTCC to the ATCT. The Clearance Delivery controller in the ATCT can append local departure information and transmit the clearance via data link to participating airline/service provider computers for PDC. The airline/service provider will then deliver the clearance via the Aircraft Communications Addressing and Reporting System (ACARS) or a similar data link system, or for non-data link equipped aircraft, via a printer located at the departure gate. For CPDLC-DCL, the departure clearance is uplinked from the ATCT via the Future Air Navigation System (FANS) to the aircraft avionics and requires a response from the flight crew. Both PDC and CPDLC-DCL reduce frequency congestion, controller workload, and are intended to mitigate delivery/read back errors."
- "Both services are available only to participating aircraft that have subscribed to the service through an approved service provider."

**¶5-2-4 Taxi Clearance, ¶5-2-5 LUAW (p. 344)**
- "Pilots on IFR flight plans should communicate with the control tower on the appropriate ground control or clearance delivery frequency prior to starting engines, to receive engine start time, taxi, and/or clearance information."
- "Line up and wait is an air traffic control (ATC) procedure designed to position an aircraft onto the runway for an imminent departure. The ATC instruction 'LINE UP AND WAIT' is used to instruct a pilot to taxi onto the assigned departure runway, align the aircraft with the correct departure direction and await for further ATC instructions. LUAW is not an authorization to takeoff."

**¶5-2-6 Abbreviated IFR Departure Clearance (p. 346)**
- "ATC facilities will issue an abbreviated IFR departure clearance based on the ROUTE of flight filed in the IFR flight plan, provided the filed route can be approved with little or no revision."
- "ATC procedures now require the controller to state the DP name, the current number and the DP transition name after the phrase 'Cleared to (destination) airport' and prior to the phrase, 'then as filed,' for ALL departure clearances when the DP or DP transition is to be flown. The procedures apply whether or not the DP is filed in the flight plan."
- "STARs, when filed in a flight plan, are considered a part of the filed route of flight and will not normally be stated in an initial departure clearance. If the ARTCC's jurisdictional airspace includes both the departure airport and the fix where a STAR or STAR transition begins, the STAR name, the current number and the STAR transition name MAY be stated in the initial clearance."
- "'Cleared to (destination) airport as filed' does NOT include the en route altitude filed in a flight plan. An en route altitude will be stated in the clearance or the pilot will be advised to expect an assigned or filed altitude within a given time frame or at a certain point after departure. This may be done verbally in the departure instructions or stated in the DP."

**¶5-2-8 Departure Control (p. 348)**
- "Departure Control is an approach control function responsible for ensuring separation between departures. So as to expedite the handling of departures, Departure Control may suggest a takeoff direction other than that which may normally have been used under VFR handling. Many times it is preferred to offer the pilot a runway that will require the fewest turns after takeoff to place the pilot on course or selected departure route as quickly as possible. At many locations particular attention is paid to the use of preferential runways for local noise abatement programs, and route departures away from congested areas."

**¶5-2-9 Instrument Departure Procedures (p. 350)**
- "if an obstacle penetrates what is called the 40:1 obstacle identification surface, then the procedure designer chooses whether to: 1. Establish a steeper than normal climb gradient; or 2. Establish a steeper than normal climb gradient with an alternative that increases takeoff minima to allow the pilot to visually remain clear of the obstacle(s); or 3. Design and publish a specific departure route; or 4. A combination or all of the above."
- "Unless specified otherwise, required obstacle clearance for all departures, including diverse, is based on the pilot crossing the departure end of the runway at least 35 feet above the departure end of runway elevation, climbing to 400 feet above the departure end of runway elevation before making the initial turn, and maintaining a minimum climb gradient of 200 feet per nautical mile (FPNM), unless required to level off by a crossing restriction, until the minimum IFR altitude."

**¶5-3-1 ARTCC Communications (pp. 359–365)**
- "ARTCCs are capable of direct communications with IFR air traffic on certain frequencies. Maximum communications coverage is possible through the use of Remote Center Air/Ground (RCAG) sites comprised of both VHF and UHF transmitters and receivers. These sites are located throughout the U.S. Although they may be several hundred miles away from the ARTCC, they are remoted to the various ARTCCs by land lines or microwave links. Since IFR operations are expedited through the use of direct communications, pilots are requested to use these frequencies strictly for communications pertinent to the control of IFR aircraft."
- "An ARTCC is divided into sectors. Each sector is handled by one or a team of controllers and has its own sector discrete frequency. As a flight progresses from one sector to another, the pilot is requested to change to the appropriate sector discrete frequency."
- "Controller Pilot Data Link Communications (CPDLC) is a system that supplements air/ground voice communications."
- "En Route CPDLC offers many services including the following: Altimeter Setting (AS), Transfer of Communications (TOC), Initial Contact (IC), route assignments, including airborne reroutes (ABRR), altitude assignments, speed assignments, crossing constraints, holding, and advisory and emergency messages."
- CPDLC message tables, marked rows (UM = uplink from controller, DM = downlink from crew):
  - Route, uplink: UM74 PROCEED DIRECT TO (position); UM75 WHEN ABLE PROCEED DIRECT TO (position); UM77 AT (position) PROCEED DIRECT TO (position); UM78 AT (altitude) PROCEED DIRECT TO (position); UM79 CLEARED TO (position) via (route clearance); UM80 CLEARED (route clearance); UM83 AT (position) CLEARED (route clearance).
  - Hold, uplink: UM91 HOLD AT (position) MAINTAIN (altitude) INBOUND TRACK (degrees) (direction) TURN LEG TIME (leg type); UM93 EXPECT FURTHER CLEARANCE AT (time).
  - Route, downlink: DM22 REQUEST DIRECT TO (position); DM23 REQUEST (procedure name); DM24 REQUEST (route clearance).
  - Deviation: UM82 CLEARED TO DEVIATE UP TO (distance offset) (direction) OF ROUTE; DM27 REQUEST WEATHER DEVIATION UP TO (specified distance) (direction) OF ROUTE; DM60 OFFSETTING (distance offset) (direction) OF ROUTE; DM80 DEVIATING (deviation offset) (direction) OF ROUTE.
  - Altitude, uplink: UM19 MAINTAIN (altitude); UM20 CLIMB TO AND MAINTAIN (altitude); UM23 DESCEND TO AND MAINTAIN (altitude); UM30 MAINTAIN BLOCK (altitude) TO (altitude); UM31 CLIMB TO AND MAINTAIN BLOCK (altitude) TO (altitude); UM32 DESCEND TO AND MAINTAIN BLOCK (altitude) TO (altitude); UM36 EXPEDITE CLIMB TO (altitude); UM37 EXPEDITE DESCEND TO (altitude); UM38 IMMEDIATELY CLIMB TO (altitude); UM39 IMMEDIATELY DESCEND TO (altitude).

**Stray marks (no usable text):** one empty highlight on p. 263 (¶4-3-20) and a single letter on p. 393 (¶5-4-1 STAR Procedures).

## Processing metadata

- **Read depth:** skimmed overall (title page, full table of contents, Explanation of Changes for the Basic edition). **Read in full from a text extract:** Section 5-5, ¶5-5-1 to 5-5-16 (PDF pp. 461–470); every highlighted passage listed above in its page context; and, in the second pass, ¶4-4-16, 5-2-1, 5-3-2, 5-3-3, 5-3-5, 5-4-1, 5-4-2, 5-4-3, 5-4-6, 5-4-19, 5-4-26, 7-1-5, 7-1-8, 7-1-18. Chapters 1–3, 6, 8–11, the rest of Section 5-4 and Chapter 7, and the appendices were not read.
- **Date processed:** 2026-10-04
