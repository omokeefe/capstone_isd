# B737 MAX 9 — pilot rules of thumb

Quick mental-arithmetic rules a 737 crew uses for descent, deceleration and fuel, collected from a web search on 2026-10-10, with the source of each number. Written to give the experiment in `knowledge/models/experiment-options-and-scoring.md` plausible orders of magnitude for its one aircraft type (the 737 MAX 9, D-015), and to give the owner numbers to check against their own FMS experience.

**Status: AI-collected, not yet reviewed by the owner.** Nothing here is certified performance data. Every source says so about itself.

## 1. Read this first: how much of this is actually MAX 9 data

Very little. Be clear about this before citing anything from this file.

| What the number applies to | Sources | Sections |
|---|---|---|
| **The 737 MAX 9 itself** | EUROCONTROL's aircraft performance page for the type; a 2021 Aircraft Commerce flight-planning study; ICAO's engine emissions databank for the LEAP-1B28 engine | 5, 6.1, 6.2 |
| **Older 737s** (737-300 and 737-700, and "the 737" in general) | b737.org.uk "Rules of Thumb" page; Boeing's AERO article on cost index | 3, 4, 6.3, 6.4, 7 |
| **Any jet transport** | FAA Instrument Procedures Handbook, Chapter 3 | 2, 3 |
| **Airbus aircraft, offered as "typical values"** | Airbus Flight Operations Briefing Note on energy management | 3, 4 |

Using an older-737 or generic-jet rule for the MAX 9 is an abstraction, and each one is listed in section 9 with the reason it is or is not safe to make.

**Grades** follow `knowledge/models/context-diagram-exchange-evidence.md`: **A** = primary or normative source (FAA handbook, ICAO databank); **B** = published study or manufacturer guidance, with caveats; **C** = unofficial page, or arithmetic done in this file. The owner's own FMS knowledge would be **[SME]** and is not used anywhere below; section 10 lists where it is wanted.

**Sources**, by bib key in `evidence/sources/references.bib`. All six files are in `evidence/sources/`.

| Short name used below | Bib key | What it is |
|---|---|---|
| FAA handbook | `faa2017iphCh3` | FAA-H-8083-16B, Instrument Procedures Handbook, Chapter 3 "Arrivals" (2017) |
| Airbus briefing note | `airbus2005energyMgmtApproach` | Airbus Flight Operations Briefing Note "Aircraft Energy Management during Approach", Rev 02, Oct 2005 |
| b737.org.uk page | `brady2026b737RulesOfThumb` | "Rules of Thumb", The Boeing 737 Technical Site, page marked "Updated 27 Jul 2026" |
| Aircraft Commerce study | `britchford2021max89FuelBurn` | "737 MAX 8 & 9 fuel burn and operating performance", Aircraft Commerce no. 137, Aug/Sep 2021 |
| ICAO databank | `icao2026engineEmissionsDatabank` | ICAO Aircraft Engine Emissions Databank, issue 32, March 2026 (hosted by EASA) |
| Boeing cost index article | `roberson2007costIndex` | "Fuel Conservation Strategies: Cost Index Explained", Boeing AERO QTR_02 2007 |
| EUROCONTROL page | `eurocontrol2026b39mPerformance` | Aircraft Performance Database, type B39M (web page only, no file) |

## 2. Where to start down

| Rule | Number | Source | Applies to | Grade |
|---|---|---|---|---|
| The "3 to 1" rule | "it takes 3 NM to descend 1,000 feet." Worked example: FL310 to 6,000 ft is 25,000 ft to lose, so start down 75 NM out. | FAA handbook p. 3-6 | Any jet | A |
| What the 3 to 1 rule assumes | "a normal jet airplane, idle thrust, speed Mach 0.74 to 0.78, and vertical speed of 1,800–2,200 fpm" | FAA handbook p. 3-6 | Any jet | A |
| Wind correction | "add 2 NM for each 10 knots of tailwind"; "subtract 2 NM for each 10 knots of headwind" | FAA handbook p. 3-6 | Any jet | A |
| Idle descent | "Idle descent allow 3nm/1000'" | b737.org.uk page | 737, variant not stated | C |
| Descent rate for a 3 degree path | "multiply your groundspeed by 5". Example: 120 knots gives 600 ft/min. | FAA handbook p. 3-4 | Any aircraft | A |
| What 3 degrees is in feet per mile | "about 318 ft/NM, or about three degrees" (the gradient arrival routes are designed to) | FAA handbook p. 3-12 | Procedure design | A |
| Same, rounded | "typically equivalent to a descent-gradient of 300 ft-per-nm or a 700 ft/mn vertical speed, for a final approach ground speed of 140 kt" | Airbus briefing note p. 3 | Generic | B |
| Cost of starting down early | "Descending early results in more flight at low altitudes with increased fuel consumption, and starting down late results in problems controlling both airspeed and descent rates" | FAA handbook p. 3-3 | Any jet | A |

A wind correction of 1 NM per 10 knots also turned up, on a flight-simulator forum. It is not used here: the FAA handbook gives 2 NM and is the better source.

## 3. Slowing down

This is the section that answers "how many knots can be lost over how much distance or height".

### 3.1 In level flight

| Rule | Number | Source | Applies to | Grade |
|---|---|---|---|---|
| Arrival-route design guideline | "deceleration considerations typically add 1 NM of distance for each 10 knots of speed reduction required" | FAA handbook p. 3-12 | Any jet | A |
| 737 pilot notes | "Level flight deceleration allow 10kts/nm & 1kt/sec (deceleration is faster at lower weights)" | b737.org.uk page | 737, variant not stated | C |
| With approach flaps out | "10 to 15 kt-per-nm" | Airbus briefing note p. 3 | Airbus, "typical values" | B |
| With gear down and full flaps | "20 to 30 kt-per-nm" | Airbus briefing note p. 3 | Airbus, "typical values" | B |

Three independent sources agree on about **10 knots per nautical mile in level flight**. Example: slowing from 280 to 250 knots in level flight needs about 3 NM.

### 3.2 While descending

| Rule | Number | Source | Applies to | Grade |
|---|---|---|---|---|
| 737 pilot notes | "Descending deceleration allow 5kts/nm & 0.5kt/sec" (path angle and flap setting not stated) | b737.org.uk page | 737, variant not stated | C |
| On a 3 degree path, gear down and landing flaps | "10 to 20 kt per nm" | Airbus briefing note p. 3 | Airbus, "typical values" | B |
| On a 3 degree path, clean (no flaps, no gear) | "Decelerating on a 3 degree glide path in clean configuration usually is not possible." | Airbus briefing note p. 3 | Generic | B |
| On a 3 degree path, slats only | "it takes approximately 3 nm (1000 ft) to decelerate down to the target final approach speed and to establish the landing configuration" | Airbus briefing note p. 4 | Airbus | B |
| Worked example | At a "conservative deceleration rate of 10 kt per nm", from the outer marker 6 NM out to the stabilization point 3 NM out (1,000 ft above the airfield): 10 x (6.0 − 3.0) = 30 knots. So to be stable at 130 knots, the most that can be held to the marker is 160 knots. | Airbus briefing note p. 4, Figure 1 | Airbus, illustrative | B |
| Speedbrakes | "Usually the use of speedbrakes is not recommended when below 1000 ft above airfield elevation and/or in the landing flaps configuration." | Airbus briefing note p. 4 | Generic | B |

**Converted to "knots per feet of descent on a 3 degree path" (arithmetic done here, grade C).** A 3 degree path loses about 318 ft per NM, so:

| Starting figure | Knots lost per 1,000 ft of descent | Condition |
|---|---|---|
| 5 kt/NM (b737.org.uk page) | about 16 | Not stated. Assumed here to be a clean or lightly configured descent. |
| 10 kt/NM (Airbus briefing note, conservative) | about 31 | Gear down, landing flaps |
| 20 kt/NM (Airbus briefing note, top of range) | about 63 | Gear down, landing flaps |
| Clean on a 3 degree path | about 0 | "usually is not possible" |

The first row applies a 737 rule to a 3 degree path that the page does not mention. Treat it as a guess until checked (section 10).

### 3.3 Speed gates on the way in

| Rule | Number | Source | Applies to | Grade |
|---|---|---|---|---|
| 737 pilot notes | "Aim for 250kts, 10,000ft by 30nm out"; "Aim for 210kts, On ILS at 12nm" | b737.org.uk page | 737, variant not stated | C |
| FAA example of such rules | "planning airspeed at 25 NM from the runway threshold to be 250 knots, 200 knots at 20 NM, and 150 knots at 15 NM until gear and flap speeds are reached, never to fall below approach speed" | FAA handbook p. 3-4 | Any jet | A |
| What controllers ask for | Requests to hold "160 kt to 200 kt IAS typically" down to the outer marker "are frequent at high-density airports" | Airbus briefing note p. 3 | Generic | B |
| Slats before the final fix | "slats should be extended not later than 3 nm before the FAF" | Airbus briefing note p. 4 | Airbus | B |

## 4. Thrust and pitch (older 737s, for orientation only)

From the b737.org.uk page (grade C). The page says these are "based on a gross weight of 47.5" (tonnes, implied), with N1 varying by 5 percent and attitude by 2 degrees at other weights. A MAX 9 is much heavier than that (section 5), and its LEAP-1B engines will not show the same N1 numbers as a CFM56. Do not use these values for the MAX 9; they are here to show what kind of rule exists.

| Condition | N1 (percent) | Pitch (degrees nose up) |
|---|---|---|
| Level, 250 knots | 65 | 4 |
| Level, 210 knots | 60 | 6 |
| Level, flap 5, 180 knots | 62 | 7 |
| Level, gear down, flap 15, 150 knots | 70 | 8 |
| On glideslope, gear down, flap 30, Vref + 5 | 55 | 2.5 |
| On glideslope, gear down, flap 40, Vref + 5 | 62 | 1 |

- Cruise N1: "N1 = (2 x Alt/1000) + 10", so about 80 percent at FL350.
- Climb speeds without FMC guidance: "250KIAS until 10,000ft then 280KIAS/M0.74 thereafter."
- Engine response from idle (Airbus briefing note pp. 6–7, generic certification figures, grade B): about 5 seconds to reach the thrust needed to recover; a stabilized 3 degree approach needs about 20 percent of take-off/go-around thrust.

## 5. Typical profile for the MAX 9

From the EUROCONTROL page for type B39M (grade B; the page states "All data presented is only indicative and should not be used operationally" and gives no date). Read 2026-10-10 through an automated page summary, not by eye, so re-read the page before citing any figure from this table.

| Phase | Speed | Vertical rate |
|---|---|---|
| Take-off | V2 149 kt | Distance 2,600 m; maximum take-off weight 88,300 kg |
| Initial climb to 5,000 ft | 165 kt IAS | 2,300 ft/min |
| Climb to FL150 | 290 kt IAS | 2,000 ft/min |
| Climb to FL240 | 290 kt IAS | 1,800 ft/min |
| Mach climb | Mach 0.78 | 1,400 ft/min |
| Cruise | 453 kt TAS, Mach 0.79 | Ceiling FL410; range 3,550 NM |
| Initial descent to FL240 | Mach 0.78 | 1,000 ft/min |
| Descent to FL100 | 290 kt IAS | 3,500 ft/min |
| Approach | 250 kt IAS; minimum clean speed 220 kt | 1,500 ft/min |
| Landing | 150 kt over the threshold | Distance 1,700 m |

Engines: "2 x CFM International LEAP-1B (130 kN)". Wake category medium; approach category D.

Weights from the Aircraft Commerce study (p. 19–20, the variant it analysed): maximum take-off 194,700 lb, maximum landing 163,900 lb, operating empty 105,000 lb. The EUROCONTROL 88,300 kg is 194,700 lb, so the two agree. This also confirms the note already in `experiment-options-and-scoring.md` that 105,000 lb is an empty weight.

## 6. Fuel

### 6.1 MAX 9 fuel per mile and per hour, gate to gate (grade B source, grade C arithmetic)

The Aircraft Commerce study ran flight plans from Boston for a 737-9 in flight-planning software ("PPS"). These rows are its payload scenario 2 (p. 24): 152 passengers, 35,112 lb payload, no cargo. The study's own columns are distance, block time and block fuel in US gallons. The last four columns are computed here, using the study's stated density of "6.55lbs per USG".

| Route | Air distance (NM) | Block time (min) | Block fuel (US gal) | Block fuel (lb) | lb per NM | kg per NM | lb per block hour |
|---|---|---|---|---|---|---|---|
| Boston–Toronto | 485 | 112 | 1,144 | 7,493 | 15.4 | 7.0 | 4,014 |
| Boston–Atlanta | 977 | 178 | 1,960 | 12,838 | 13.1 | 6.0 | 4,327 |
| Boston–Denver | 1,824 | 294 | 3,443 | 22,552 | 12.4 | 5.6 | 4,602 |
| Boston–Los Angeles | 2,731 | 418 | 5,121 | 33,543 | 12.3 | 5.6 | 4,815 |

In round numbers: **about 12 to 13 lb per air mile on a long sector, about 15 on a short one, and roughly 4,000 to 4,800 lb (1,800 to 2,200 kg) per block hour.**

What these numbers are and are not:

- They are **block** fuel: taxi out, flight and taxi in, with both engines running on the ground. Cruise-only fuel per mile is lower. The study does not give a cruise fuel flow.
- Distance is equivalent still-air distance (the distance flown through the air mass), not ground distance. All routes had a headwind.
- Flown at long-range cruise speed, not at an airline cost index, at the optimum flight level, with no holding or delay, in standard temperature.
- Software output, not measured from flights.
- The study found the 737-9 burns "11.2% to 12.7%" less than the 737-900ER on the same routes (p. 25).

### 6.2 LEAP-1B28 engine fuel flow at fixed thrust settings (grade A source, with a large caveat)

From the ICAO databank, the current row for "LEAP-1B28/28B1/28B2/28B3" (record 08P28CM143, rated thrust 130.4 kN). Values are **per engine**. The kg/h and lb/h columns are converted here.

| Setting (share of rated thrust) | kg/s | kg/h | lb/h |
|---|---|---|---|
| Take-off (100%) | 1.070 | 3,852 | 8,492 |
| Climb-out (85%) | 0.870 | 3,132 | 6,905 |
| Approach (30%) | 0.290 | 1,044 | 2,302 |
| Idle (7%) | 0.100 | 361 | 797 |

The caveat: these are test-stand measurements at sea level with the engine not moving, made for emissions certification. They are not in-flight fuel flows, and there is no cruise row. Their honest use here is for the ground and low-altitude ends of a flight: two engines at idle is about 720 kg/h, or roughly 12 kg per minute of taxi (arithmetic here, grade C).

The 130.4 kN rating matches the EUROCONTROL page's "LEAP-1B (130 kN)". The Aircraft Commerce study names the MAX 9 engine as LEAP-1B28B1 in its text and LEAP-1B27B1 in its tables; see section 8.

### 6.3 Fuel rules from older 737s (b737.org.uk page, grade C)

The page cites Boeing's Flight Planning and Performance Manual ("FPPM") for the two tables. That manual was not seen.

**Fuel penalty for cruising away from the optimum altitude** (cited to FPPM p. 2.1.1):

| Altitude relative to optimum | 737-300 at Mach 0.74 | 737-700 at Mach 0.78 |
|---|---|---|
| 2,000 ft above | 1% | 2% |
| At optimum | 0 | 0 |
| 2,000 ft below | 2% | 2% |
| 4,000 ft below | 4% | 5% |
| 8,000 ft below | 11% | 14% |
| 12,000 ft below | 20% | 24% |

**Wind that makes a 4,000 ft step climb not worth it** (cited to FPPM p. 3.2.16). The climb pays off unless the wind at the higher level is worse by more than:

| Step | 737-300 | 737-700 |
|---|---|---|
| FL290 to FL330 | 34 kt | 75 kt |
| FL310 to FL350 | 25 kt | 69 kt |
| FL330 to FL370 | 12 kt | 55 kt |
| FL370 to FL410 | not applicable | 24 kt |

Other rules on the same page:

- "The 737 burns approx 30kg/min." That is 1,800 kg/h, at the low end of the MAX 9 block-hour range in 6.1, which is the wrong way round for an older, thirstier aircraft unless the figure is for a lighter variant. Treat it as a round number for an unstated variant.
- Carrying less weight: "Trip Fuel Reduction = Weight reduction x Flight time in hrs x 3.5%". The page's example: 1,000 kg lighter over 2 hours saves 70 kg.
- Cruise fuel flow from airspeed: "FF = (IAS*10)/2 -200", giving 1,050 kg/h per engine at 250 knots.
- Landing flap: "Flap 30 uses 25kgs less fuel than flap 40 from 1500 ft to touchdown."
- Anti-ice: engine anti-ice 90 kg/h; engine plus wing 250 kg/h.
- Compared with normal two-engine long-range cruise: one engine out burns 21% more; depressurised at 10,000 ft burns 49% more; gear down burns 89% more.

### 6.4 Cost index (Boeing cost index article, grade B)

- Definition: "The CI is the ratio of the time-related cost of an airplane operation and the cost of fuel", in dollars per hour over cents per pound (p. 26).
- "entering zero for the CI results in maximum range airspeed and minimum trip fuel"; the maximum value gives "a minimum time speed schedule" (p. 26).
- Allowed range, Figure 1 (p. 27): 0–200 for the 737-300/-400/-500 and 0–500 for the 737-600/-700/-800/-900. The MAX is not listed; the article is from 2007.
- One airline's study, Figure 4 (p. 27–28): the optimum was 12 "for all 737 models", against 30 and 45 in use. Changing to 12 added 1 to 3 minutes on "a typical 1,000-mile trip".
- Descent speed, 737 Classic and NG (p. 27): the FMC limits its descent speed target to 330 knots, against a maximum operating speed of 340 knots / Mach 0.82.
- "the airspeed used during descent tends to be the most restricted of the three flight phases", because of air traffic control (p. 27).

This article is also a citable definition of cost index for the experiment's case D (shared weight and cost index). `mori2022massCruise` already gives the cost function form; this gives the manufacturer's plain statement.

## 7. Other rules on the b737.org.uk page (grade C)

- Kinetic heating: total air temperature rises "approximately 1°/10kts IAS".
- Best angle of climb "V2 + 80"; best rate "V2 + 120".
- After an engine failure, accelerating from driftdown speed to long-range cruise "will cost approximately 3000ft".

## 8. Where the sources disagree or look wrong

- **3 degrees is 300 or 318 ft per NM.** 318 is the geometry (the tangent of 3 degrees times 6,076 ft). 300 is the rounding that makes the 3 to 1 rule work. A path flown by the 3 to 1 rule is slightly shallower than 3 degrees.
- **Wind correction to the top of descent:** 2 NM per 10 knots (FAA handbook) against 1 NM (forum). The FAA figure is used.
- **Descending deceleration:** 5 kt/NM (b737.org.uk page) against 10 to 20 kt/NM (Airbus briefing note). Probably not a real conflict: the Airbus figure is with gear and landing flaps, and the 737 page does not say. This needs the owner's check.
- **Aircraft Commerce study engine name:** LEAP-1B28B1 in the text and weights table, LEAP-1B27B1 in the results tables. One of them is a misprint. The same tables print one fuel figure as "1.111" where 1,111 is meant.
- **"The 737 burns approx 30kg/min"** sits oddly against the MAX 9 block figures (see 6.3).

## 9. Abstractions made here, and why

| Abstraction | Why it is reasonable | Why it might not hold |
|---|---|---|
| Generic-jet descent rules (3 to 1, groundspeed x 5, 10 kt/NM) are used for the MAX 9 | They are geometry or FAA design guidance, not type performance. The 3 to 1 rule's stated speed range (Mach 0.74–0.78) brackets the MAX 9's Mach 0.78 descent in section 5. | The MAX 9 is heavier and has lower drag than the jets the rule grew up with; an idle descent may need more than 3 NM per 1,000 ft. |
| Airbus "typical values" for deceleration are shown alongside 737 values | The briefing note offers them as typical for a quick assessment and says they depend on type and weight. | They are Airbus numbers. They are never used here as MAX 9 data. |
| The 737-700 altitude penalty table is offered as the shape of the MAX 9's | Same wing family, same cruise Mach (0.78–0.79). | Different engine and weights. The percentages are not MAX 9 data and must not be reported as such. |
| ICAO test-stand idle fuel flow is used for taxi fuel | Taxi is close to the test condition (sea level, near static). | Says nothing about flight idle at altitude, which is what a descent uses. |
| Block fuel per mile is used as a stand-in for cruise fuel per mile | It is the only MAX 9 fuel figure found. On the long routes taxi and climb are a small share. | It overstates cruise fuel per mile, most on short routes. |

## 10. Not found, and what the owner could check

Looked for and not found in a public source:

- **The Boeing 737 Flight Crew Training Manual.** It is the proper source for 737 descent and deceleration rules. It is proprietary and no copy was found. Nothing in this file is quoted from it.
- **MAX 9 cruise fuel flow by weight and altitude**, and a MAX 9 optimum-altitude penalty table. These are in the operations manual performance tables, not public.
- **Boeing's fuel conservation workshop slides** (Anderson, ICAO/Transport Canada 2006) and the later AERO articles in the same series on cruise and descent: links dead or not located.
- **AirInsight's analysis of 737 MAX fuel burn from US operator filings:** the site refused automated download (HTTP 403).
- A NASA study said in a search summary to find penalties "generally less than 1%" within about 2,000 ft of optimum altitude (NTRS 20110014792) was not read; the download came back unreadable. Not used.

Where the owner's FMS experience would settle something ([SME] if stated):

1. Is 5 kt/NM a fair figure for a clean, idle, descending 737, and at what path angle?
2. Does a MAX 9 hold a 3 degree path clean at idle without accelerating? The Airbus note says decelerating clean on that path is "usually not possible".
3. Is 3 NM per 1,000 ft still right for a MAX 9 idle descent, or is it closer to 3.3–3.5?
4. A realistic cruise fuel flow for a MAX 9 at a stated weight and level.
5. What cost index range does the MAX FMC accept?

## 11. Use in the experiment

This file supplies orders of magnitude only. It does not replace the experiment's truth model (`experiment-options-and-scoring.md`), and it is not a step toward an optimization study; the experiment stays a demonstration of what shared information changes inside the architecture.

- **Size of a level change.** With about 12.4 lb per air mile (6.1) and a 2 percent penalty for 2,000 ft off optimum (6.3, a 737-700 figure), holding a wrong level for 100 NM costs on the order of 25 lb. That is small. It suggests the fuel term alone may not separate the options unless the weights put the two aircraft well apart in optimum altitude, or the level is held for a long time. This is an illustration with a borrowed percentage, not a result.
- **Weights.** Section 5 gives the bounds for the "heavy" and "light" MAX 9 that `experiment-options-and-scoring.md` leaves unset: empty 105,000 lb, maximum landing 163,900 lb, maximum take-off 194,700 lb.
- **Descent as a resolution.** Section 3 gives the distances a descent-and-slow instruction consumes, if the scenario is ever moved from cruise toward the arrival.
