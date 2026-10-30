# Experiment scenario numbers

**Status: confirmed by the owner 2026-10-29 (OOK notes in each row; D-037). Proposal 2026-10-10; weights and the climb margin changed 2026-10-11 (D-023).** Drafted by Claude after the owner's direction in the 2026-10-10 plan review (FL380, westbound, Mach 0.80, a Miami-to-Los-Angeles flight with the conflict near DFW, a 6 percent weight spread, both aircraft B737-9). The machine-readable copy is `projects/nas-sos-capstone/simulation/scenario_base.yaml`; if the two disagree, the YAML is what the scoring ran. Every row marked **Decide** is the owner's call. Grades: [A] rule or order held, [B] published study held, [SME] owner's industry knowledge, [C] general knowledge or a computation here, not yet sourced.

## 1. Geometry

| Item | Value | Basis |
|---|---|---|
| Sector | Fort Worth Center (ZFW) high-altitude airspace | [C] from the crossing point's location. **Confirmed by the owner 2026-10-29.** |
| Crossing pair's tracks | **AC1: Orlando (MCO) to Los Angeles (LAX)**, great-circle heading 281 at the crossing. **AC2: Houston (IAH) to Denver (DEN)**, heading 324. | [C] computed on great circles 2026-10-10. **Confirmed by the owner 2026-10-29.** History: the owner asked for MIA to LAX near DFW; that track passes about 110 NM south of DFW and crosses nothing useful there. MCO to LAX is the nearest equivalent that crosses a westbound track near DFW. Alternative: MIA to LAX crossing San Antonio (SAT) to DEN, 150 NM southwest of DFW near San Angelo, also ZFW.  OOK, 10/29/2026, Confirmed. Plotted and it makes sense. |
| Crossing point | 32.2 N, 97.2 W, about 42 NM southwest of DFW | [C] computed |
| Crossing angle | about 43 degrees | [C] computed |
| Distance to go at the crossing | AC1 1,069 NM; AC2 584 NM | [C] computed |
| AC2 distance from departure | 165 NM | [C]. Just at or past top of climb for a 737 to FL380; both aircraft are taken as in level cruise. If the owner wants more margin, use the SAT alternative. |
| Level of the crossing pair | **FL380**, westbound, even level | Owner direction 2026-10-10; D-014 item 3 [SME]; above FL350 so the climb rule binds cases A and B (D-013 item 4) |
| In-trail pair | AC3 and AC4 on AC1's track at **FL360**, under the crossing point | experiment-definition.md §3; experiment-options-and-scoring.md §1 |
| Mach | **0.80** all four | Owner direction 2026-10-10; MMO 0.82 (OpenAP `prop.aircraft("B39M")`) |
| Decision point | 12 minutes before the crossing | [C] within the 8 to 20 minute range of the interview studies (journal 2026-10-04) |
| Maneuver hold | 15 minutes level at the new altitude before the aircraft is returned (as `experiment_scoring.py` uses it) | **Confirmed by the owner 2026-10-29.** Figure: `report/figures/scenario_altitude_vs_time.png` (`simulation/scenario_profile.py`). Owner's note: OOK, 10/29/2026, If they're flying 0.8 @ FL380, then that's about 459 KTAS, which would cover 91.8 NM in 12 minutes w/o wind. If both AC 1 & AC2 are 11 min out. AC2 requires 3.6 to descend & 6.3 to climb, then to clear AC3 & AC4 it shoudl be level at FL340 for about 10 min, bare minimum assuming minimum separation between 1, 3, and 4. So, 15 minutes is conservative and accounts for radio contact delays. Let's roll with it.  |
| Re-climb available | yes, as a second instruction | experiment-options-and-scoring.md §2 (second review notes 1.9, 2.5) |
| Climb that must be left at a level before an aircraft is cleared to it | **150 ft/min** | Owner [SME]: many airlines keep 150 ft/min for clear air turbulence and other unknowns. The service-ceiling definition is 100 ft/min, `faa2015ac61107b` para. 1-4r [A]. D-023. |

## 2. Aircraft

Type: B737-9 (737 MAX 9), both crossing aircraft and, for simplicity, both in-trail aircraft (D-015). OpenAP data for the type (`prop.aircraft("B39M")`, 2026-10-10): MTOW 88,000 kg; OEW 45,000 kg; max fuel 26,000 kg; MLW 71,000 kg; MMO 0.82; VMO 340 kt; ceiling 12,500 m; 178 to 220 seats; LEAP-1B.

**Nominal mass (the one weight per type the nominal model uses, case B): 67,000 kg** (was 70,000 until 2026-10-11, D-023). [C] A mid-cruise mass: OEW 45,000 plus about 16,000 kg of payload (160 passengers and bags at 100 kg) plus about 6,000 kg of fuel remaining. The idea of one weight per type is `coppenbarger1999climbPrediction` p. 4. **Confirmed 2026-10-29.**  OOK, 10/29/2026, Confirmed. This is a PAX of ~80-90%, which is good. 

**Spread: ±6 percent of the nominal mass.** Owner direction 2026-10-10 ("use 6 percent as a middle figure"). Source: `coppenbarger1999climbPrediction` Table 3, standard deviations of take-off weight for about 8,000 flights out of DFW and Denver in 1999: B737 4.5 percent, B757 6.4 percent, MD80 7.1 percent. The 4.5 to 7 percent range in `experiment-definition.md` §3 is these three narrow-body rows. Note for the report: the row for the 737 itself is 4.5 percent; 6 percent is the middle of the narrow-body range, and the heavy and light aircraft are one standard deviation either side of the mean under that choice.

| Aircraft | Airline | Route | Mass | Level | Cost index | Schedule on entry | Connections | Role |
|---|---|---|---|---|---|---|---|---|
| AC1 | X | MCO-LAX | **71,020 kg** (heavy, +6 %) | FL380 | CI 60 = 45.36 kg/min (high) | 8 min late | yes | crossing pair |
| AC2 | Y | IAH-DEN | **62,980 kg** (light, −6 %) | FL380 | CI 10 = 7.56 kg/min (low) | on time | no | crossing pair |
| AC3 | X | TPA-LAX | 67,000 kg | FL360 | CI 10 = 7.56 kg/min | 6 min early | no | in trail, under the crossing; same airline as AC1 |
| AC4 | Z | TPA-LAX | 67,000 kg | FL360 | CI 30 = 22.68 kg/min | on time | no | in trail behind AC3; context |

**Why these masses work (OpenAP, 2026-10-11, Mach 0.80, ISA; D-023).** The test is climb left at a level, not thrust against drag: 100 ft/min defines the service ceiling (`faa2015ac61107b` para. 1-4r) and the scenario asks for 150 ft/min [SME].

| Mass | Climb left at FL360 | at FL380 | at FL400 |
|---|---|---|---|
| 71,020 kg (heavy) | 329 ft/min | **181** | **8** |
| 67,000 kg (nominal) | 474 | 330 | 160 |
| 62,980 kg (light) | 630 | 489 | **322** |
| 74,200 kg (the old heavy weight) | 221 | 70 | below zero |

The old heavy weight left 70 ft/min at FL380, under both numbers, so that aircraft could not have been at FL380. Changing Mach does not help: the most it has at any Mach at FL380 is 87 ft/min. The heaviest the model allows at FL380 and Mach 0.80 is 73,300 kg for 100 ft/min and 71,900 kg for 150 ft/min. So the light aircraft can take the climb option and the heavy one cannot, which is the asymmetry D-013 item 4 asks for and which only a case that knows the weight can see. Cost index values are in the fuel-equivalent form of `mori2022massCruise` Eq. 1 to 3 (kg of fuel per minute); the values were 2.5, 0.8, 0.8 and 1.5 kg/min until 2026-10-29 and are now Boeing cost indexes 60, 10, 10 and 30 converted at 1 CI = 100 lb/hr = 0.756 kg/min (owner [SME], 2026-10-29). Schedule deltas and the 12-minute connection threshold (arrival slots 10 to 15 minutes apart [SME]): **confirmed as written 2026-10-29.** **Nominal cost index for case B and the similar-weights variation: CI 30 = 22.68 kg/min** [C], the middle of the scenario's range, replacing 1.0 kg/min (which sat in the middle of the old range). Proposed by Claude, **confirmed by the owner 2026-10-29** (D-037). This value decides case B's choice: O8 above about 9.9 kg/min (CI 13), the vector O5 below it (checked by re-running at 0.5 to 45.36 kg/min, 2026-10-29).
OOK, 10/29/2026, Typicallly Boeing measures cost index in $/hr per $/100-lbs fuel and values are reported between 0 & 100 w/fuel efficient operations being below 15 and more time-demanding flights above 60. Running that through, 15 = 1500 lbs/hr = 11.34 kg/min. If fuel is assumed $2.50 per kg, that's about $28.35 per minute. 

## 3. Options and rules

- Altitude steps +2,000, −2,000, −4,000 ft and the climb-only-at-or-below-FL350 rule for cases A and B: `engility2014tasarAlaska` p. 8 (D-013).
- Speed lever ±0.04 Mach, built to fail: D-014 item 2 [SME]. In the scoring it is marked infeasible for separation; its arrival-time effect is in `experiment-options-and-scoring.md` §4.2.
- Vector "pass behind": 6 NM of extra track, [C]: a path stretch that delays the aircraft about 5.4 NM along its track (5 NM ÷ cos 21.5° at the 43° crossing) plus a margin, flown over the roughly 90 NM to the crossing. **Confirmed 2026-10-29**, after the check that a 5 NM parallel offset (the owner's first proposal below) leaves only about 1.8 NM at closest approach, because AC2's track still crosses the offset track.
   - OOK, 10/29/2026, This is roughly 2*minimum separation required if 5 NM lateral separation is required and a 30-deg path departure is used. sin(30) = 5/x; cos(30) = y/x -> x = 10; y = 8.66 -> 2.68 extra NM w/ recapture. So it represents about 10NM of lateral separation. The 40 NM doesn't really matter, but it's less than 6 min of flight at 459 KTAS. Each a/c will cover 91.8 NM in 12 minutes. Let's change 40NM to the remainder of the 12 minutes after the lateral offset. We can approximate that as 90 NM. 
- Option O9's slow-down: **AC3 and AC4 both slow 0.04 Mach (0.80 to 0.76, about 440 KTAS) for 12 minutes. Confirmed 2026-10-29** (was AC3 only, 0.02 Mach for 10 minutes).
    - OOK, 10/29/2026, AC4 will also have to be slowed. Update the table in the report and the experiment code. If AC3 is 2 NM "behind" AC1, then 3+NM must be made up by speed. Presently covering about 91 NM in 12 min -> 88NM or less must be traversed in 12 min -> ~440 KTAS at FL360 is 0.766 Mach. To be conservative & match a/c control resolutions assume 0.76 = 0.04 Mach delta for 12 minutes. Update the scenario experiment and report to cite 12 minutes for both AC3 & AC4. 
- Instruction counts: `fothergill2013resolutionHeuristics` pp. 72 to 74.
- Case A tie-breaker when both crossing aircraft are in steady cruise (`kirwan2001coraStrategies` does not choose): **move AC2, the crossing aircraft with no in-trail traffic on its track** (owner 2026-10-29: it doesn't have the AC3/AC4 pressure). This needed a new option, **O10: AC2 descends 4,000 ft** (the mirror of O8), because AC2's 2,000 ft descent is blocked by AC3 and AC4. Until 2026-10-29 the rule was "move the aircraft with farther to go", which is AC1; the published resolver tie-breakers are "farthest from top of descent" and "not recently maneuvered" (`experiment-definition.md` §5).

## 4. Costs

| Item | Value | Basis |
|---|---|---|
| CO2 per kg of fuel | 3.16 | `icao2024icecMethodology` p. 6 (D-015) |
| Fuel price | **2.50 USD/kg** (about 7.60 USD/gal) | **Confirmed 2026-10-29** (owner: Jet-A seen at 4.80 to 8.47 USD/gal with airport markups); cite a dated price source before submission. Was 0.85 USD/kg.  OOK, 10/29/2026, Let's go with $2.50 per kg at airport markups.|
| Carbon price (airline column) | 15 USD per tonne CO2 | [C] CORSIA-style credit, trade-press range 10 to 22 USD/t in 2025 to 2026, unsourced; **confirmed 2026-10-29** (D-014 item 5)   OOK, 10/29/2026, This is good. Ranges vary widely, from $5 to $1000 |
| Missed-connection cost K | not set | unsourced; the table reports yes/no (experiment-options-and-scoring.md §4.2) |
| Connection threshold | 12 minutes | arrival slots 10 to 15 minutes apart [SME] |

## 5. What the scoring does with these numbers

`simulation/experiment_scoring.py` (D-017) scores each option for each aircraft as the fuel and time difference against flying on undisturbed: cruise fuel flow from OpenAP at the option's level for the hold period, plus a climb or descent increment, plus the re-climb; a vector adds track miles at cruise fuel flow; the speed lever is infeasible by construction. The truth model runs at the fidelity selected (`conceptual`, `nominalMass`, `actualMass`); each case chooses with its own information (A rule, B nominal mass, C actual mass, D actual mass plus connections). Outputs are the two tables of `experiment-options-and-scoring.md` §3 as CSV and LaTeX, and a results file for the model.
