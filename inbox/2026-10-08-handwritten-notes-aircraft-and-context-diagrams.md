# Handwritten notes on the aircraft IBDs, context diagram and definitions tree (transcribed 2026-10-08)

Untriaged capture. Transcribed by Claude from two annotated images in `projects/nas-sos-capstone/cameo_models/print/`:

- `aircraft_diagrams_with_handwritten_notes.jpg` (image 1): the default aircraft IBD (top), the detailed aircraft IBD (middle) and the context diagram (bottom).
- `aircraft_diagrams_with_handwritten_notes_part_2.jpg` (image 2): a nested view of the whole definitions tree (environment, airport, airspace, aircraft, flight ops, flight crew).

Nothing here has been applied to the model. The "Touches" column names the model element each note points at, which I confirmed against the `.sysml` files and the clean render `diagram-aircraftIbdDetail.png`. "Kind" is my reading of the note: **change** (the note says what to do), **question** (the note asks, the owner decides), **tooling** (a rendering question, not a model question). Wording in quotes is the handwriting; anything in square brackets is my guess at an unclear word.

## 1. Default aircraft IBD (`MyViews::aircraftIbd`, image 1 top)

| # | Note | Touches | Kind |
|---|------|---------|------|
| 1.1 | "☐ Would be nice to lay this all out on an outline of a B737." | Layout of the aircraft IBD | tooling |
| 1.2 | "Crew interface w/ controls, not FCS... prly not even AFCS w/ how I've defined it. Really should go through MCP + FMS." The crew-to-FCS and crew-to-AFCS lines are traced in orange and cyan, each marked with a small circle. | `crewFlightControls` (crew to `flightControlSystem`), `crewAfcs` (crew to `autoFlightControlSystem`) in `nas_ibd_aircraft.sysml` | change |
| 1.3 | "Crew → FlightDeckDisplays → Throttles, config levers, pedals, yoke." | Same as 1.2. Names what the crew actually touches. The definitions have no part for the flight deck controls or the MCP (mode control panel). | change |
| 1.4 | "Pipe Out: - Surveillance ADS-B - Emissions - Wake to environment." | Outputs that leave the aircraft boundary. None are on the IBD: ADS-B Out is only on the context diagram (`atcSurveillance`); emissions and wake are not in the model. | change |
| 1.5 | Arrows drawn in from outside, labelled "environment", ending on `navigationSystem` and `pitotStaticSystem`. | Inputs from outside the aircraft to the sensors. Today the only inputs to those two are the detail-level `responseNav` and `responseAirData` from the airframe. | change |
| 1.6 | Arrow drawn in from outside, labelled "Other A/c", ending on `surveillanceSystem`. | Input from other aircraft (TCAS, ADS-B In). Not in the model. | change |
| 1.7 | Arrow drawn from `surveillanceSystem` to `displaySystem`, labelled "ADD". | A new connection. Traffic is currently described only in the doc of `crewSurveillance` ("surveillance -> crew: TCAS advisories"). | change |
| 1.8 | "CPDLC, VHF, SATCOM, etc. Just add ports?" with an arrow to `communicationSystem`. | `CommunicationSystem` already has parts `vhfRadio`, `communicationsManagementUnit`, `satcom`. The note asks whether ports on the box would do instead of showing them. | question |
| 1.9 | "How to add labels @ entry/exit of every connection?" | Rendering of connection ends | tooling |
| 1.10 | Hand-traced lines labelled "Comms" (green), "Surveil" (purple), "FMS" (pink), "AFCS" (cyan), "FCS" (orange). | Tracing aids for the five crew links. No change asked, but it shows the crew links are hard to follow in the render. | tooling |

## 2. Detailed aircraft IBD (`MyViews::aircraftIbdDetail`, image 1 middle)

| # | Note | Touches | Kind |
|---|------|---------|------|
| 2.1 | "Not Avionics", pointing at `pitotStaticSystem`. | `AvionicsSystem.pitotStaticSystem` in the definitions (placed there by D-011). Moving it out changes six connection paths in `nas_ibd_aircraft.sysml` (`airDataFms`, `airDataAfcs`, `airDataDisplays`, `airDataSurveillance`, `airDataStandby`, `responseAirData`). | change |
| 2.2 | "6 PACK?", underlining `standbyInstruments`. | `AvionicsSystem.standbyInstruments`. I read this as asking whether the standby instruments should be modeled as the classic six-instrument set, or whether the name is right. | question |
| 2.3 | `eicas` and `displaySystem` circled together: "these overlap. Remove EICAS, leave engines into Displays", with "engines →" drawn into the circle. | `AvionicsSystem.eicas` and `eicasCrew` would go; a new engines-to-`displaySystem` connection replaces them. | change |
| 2.4 | `cabin` circled, "Fuselage ?" | `Aircraft.cabin`. `Airframe` already has a `fuselage` part. I read this as asking whether the cabin should sit inside the fuselage, or be replaced by it. | question |
| 2.5 | "[Reversionary]?" next to `flightControlSystem` (which shows `primaryFCS` and `secondaryFCS`). | `FlightControlSystem.reversionaryFCS` exists in the definitions but is untagged in the IBD, so it is not drawn. The note asks whether it should be. | question |
| 2.6 | The crew-to-FCS line traced in blue across the whole diagram, labelled "FCS". | Same link as 1.2; it crosses the full width of the detail view. | tooling |

## 3. Context diagram (`MyViews::systemContext`, image 1 bottom)

| # | Note | Touches | Kind |
|---|------|---------|------|
| 3.1 | The whole `environment` box circled: "Don't show... just show input ports on systems I'm interested in." | `environment` and its five links (`rulesToAoc`, `rulesToAtc`, `weatherToAoc`, `weatherToTfm`, `suaToTfm`). Rendering them was decided in D-009, so this reverses part of D-009. | change |
| 3.2 | At `weatherToTfm` and `suaToTfm`: "Why do these go to ATCSCC? TFMU [establishes, delivers] to ATCSCC, & they [enact] & coordinate?" | The far end of both links is `airspaceMgmt.atcscc`. The file's comment cites JO 7210.3EE 18-15/16 for weather (ATCSCC-led severe weather management); `suaToTfm` is graded [C], no source. | question |
| 3.3 | `atc` and `atcscc` circled together: "Why are these split out separately?" A hand-drawn box "TFMU or TMU?" points at `atcscc`. | The split is argued in the comments on `airspaceMgmt` (different authority under D-007: tactical control vs. final approving authority for traffic management initiatives). `tmu` is deliberately off this view under D-010. The note questions both. | question |
| 3.4 | "Duplicated?" pointing at the two lines from `atc` to `aircraft` (traced cyan and green). | They are two different links, `atcSurveillance` and `atcAircraftDatalink`. Neither name is printed on the render, which is why they look like one link drawn twice. See the known issue in `knowledge/models/sysml-diagram-rendering.md` (connection names with a doc body do not show). | question, and tooling |
| 3.5 | A hand-drawn "Cabin Crew" box under `flightDeckCrew`, arrows both ways. | `flightCrew.cabinCrew` is in the model but untagged (owner decision 2026-09-27), and `cabinToFlightDeck` is a commented-out draft that D-010 assigns to a Flight Crew IBD. The note draws it on the context view. | change |
| 3.6 | Arrow from `airport` to `aircraft`: "Fuel, etc." | This link exists: `aircraftAirport`, the rendered summary of the material turnaround set. Its name is not printed either (same cause as 3.4), so on paper it reads as an unexplained line. | tooling |
| 3.7 | Hand-traced lines labelled "Aircraft", "Crew", "Airport & ATCSCC", "Airport". | Tracing aids for the airline operations center's four links and the links into the airport. | tooling |

## 4. Definitions tree (image 2)

| # | Note | Touches | Kind |
|---|------|---------|------|
| 4.1 | "Should this be moved?" pointing at `passengers: PassengersDomain`. | `EnvironmentDomain.passengers`. D-007 classes passengers as a boundary actor. | question |
| 4.2 | At `decisionSupport: DecisionSupportDomain`: "This shouldn't sit in the environment domain. AOC, ATC, A/C & Crews (EFB) might have their own versions of this." | `EnvironmentDomain.decisionSupport` and the `DecisionSupport` package. D-007 has it as "absorbed". The note says each of those four owns its own decision support (EFB = electronic flight bag). | change |
| 4.3 | A red X on the calculation definition inside `vehicleDynamicsModel` (the teal box; its name is not legible in the scan). | Inside `DecisionSupport::VehicleDynamicsModel`. Also used by the simulation work in to-do-list §12 to §13, so check before removing. | change |
| 4.4 | "What are these abstract actions & how do I remove them?" | The pink `«abstract action» performedActions` box in every part. | tooling |
| 4.5 | Beside the airport: "This content seems somewhat arbitrary... while conceptually reasonable, I need more evidence of systems & their internal structures. Many of these are reasonable (marked w/ ✓), but many are unnecessary & questionable (marked w/ X)." | All of `AirportOperations::Airport`. | change |
| 4.6 | Red X on: `parkingAndTransportationServices`, `cargoTerminal`, `weatherStation`, `securityServices`, `gateAgents`, `marshaller`, `intoPlaneFueler`, `tanks`. | See the dependency list below. **No ✓ marks are on the scan.** A pixel search for green ink found only the ✓ in the legend, so the "reasonable" set is not recorded. | change |
| 4.7 | A "?" with one arrow up to `marshaller` and one across to `intoPlaneFueler`. | Both also carry an X. I read the "?" as "are these two really parts of the airport?" | question |
| 4.8 | "← Runways? Taxiways?" pointing at `apron`. | `Airport.apron`. `runways` exists; there is no taxiway part. I read this as asking whether the movement area is modeled consistently. | question |
| 4.9 | "What is this diagram? Actions = Activity / Sequence? It's a better depiction of the systems & their internal components, in so far as organization is concerned. But would need to add connections." | The nested definitions view itself. Not a view in `nas_package_my_views.sysml`, so it is not reproducible from the repo yet. | question |

### What the X marks in 4.6 would break

These parts are endpoints of connections in `nas_context_diagram.sysml`. Removing a part means removing or re-pointing the connection as well.

| Part marked X | Connections that use it |
|---|---|
| `gateAgents` | `caGateAgentCoordination` |
| `groundHandling.marshaller` | `caMarshalling` |
| `fuelDistributionSystem.intoPlaneFueler` | `caFuelSlip`, `apRefuelPanel`; also the source of `FuelSlip`, an input to `FlightCrew::PreflightCrossCheck` |
| `cargoTerminal` | `apCargoMail` |
| `weatherStation`, `securityServices`, `parkingAndTransportationServices`, `fuelDistributionSystem.tanks` | none |

## 5. Answers to the tooling questions, where I have one

- **4.4, the abstract actions.** `performedActions` is not in the model files. It is a feature every part inherits from the SysML library, and the view is drawing inherited rows (the `^` in front of `performedActions` on the print marks it as inherited). `knowledge/models/sysml-diagram-rendering.md` already lists the fix: the view attribute `showInheritedRows = false` "hides inherited (`^`) compartment rows". It is CLI-only, so the VS Code preview will keep showing them. Not tested on this view.
- **1.9, labels at connection ends.** The render already prints the end's name at each end of a line (for example `flightDeckCrew` and `atc` on the context diagram). Connecting through named ports would put the port name there instead, which is also what notes 1.8 and 3.1 ask for. Not tested.
- **3.4 and 3.6, unnamed lines.** Same known issue for both: a connection declared with a `{ doc ... }` body renders without its name. The five environment links have no body and are the only labelled ones. Cause not investigated.

## 6. Notes that collide with a logged decision

Applying these means a new decisions-log entry, not just an edit: 3.1 (D-009, environment links rendered), 3.3 (D-007 and D-010, the `atc` / `atcscc` / `tmu` treatment), 3.5 (D-010, cabin crew link belongs on a Flight Crew IBD), 4.2 (D-007, decision support "absorbed"), 2.1 and 2.3 (D-011, made today: pitot-static and EICAS placed in avionics).

## 7. Readings I am least sure of

- 3.2: the middle of the sentence. "establishes, delivers" and "enact" are guesses.
- 2.5: "Reversionary" (fits the position and the model; the handwriting alone would not settle it).
- 1.4: the first bullet. "Surveillance ADS-B" is a best fit.
- 4.7: what the "?" is asking.
