# En Route Climb Trajectory Prediction Enhancement Using Airline Flight-Planning Information

- **File:** `evidence/sources/coppenbarger-2012-en-route-climb-trajectory-prediction-enhancement-using-airline-flight-planning-information.pdf`
- **Bib key:** `coppenbarger1999climbPrediction`
- **Authors:** Richard A. Coppenbarger (NASA Ames Research Center)
- **Year:** 1999 (the file name says 2012; the paper is AIAA-99-4147)
- **Venue:** AIAA Guidance, Navigation, and Control Conference, 1999, paper AIAA-99-4147, pp. 1077–1087
- **DOI:** 10.2514/6.1999-4147

## What it is

A conference paper (11 pp) from NASA's En route Data Exchange programme. It describes what NASA's ground automation (CTAS) assumes about each aircraft when predicting a climb, lists what an airline operations center could supply instead, and measures how much difference airline-supplied take-off weight, speed profile and engine data would make.

## Why it's valuable — and to what

- Literature review section: none of §2–§4. It serves the §11 experiment and the architecture's AOC-to-ATC exchange.
- Decomposition / architecture (§6, §10):
  - **Two sources for the missing data:** ground-based (the airline operations center and its flight plans, available before departure) and airborne (the FMS over data link). The programme chose the ground source first "in the interest of exploiting currently available technology and minimizing cost" (p. 2).
  - **What ATC's flight plan lacks:** it is "limited to a broad description of aircraft type, expected route waypoints, and anticipated cruise altitude and airspeed" (p. 4).
  - **Candidate exchange items (Table 2):** specific airframe and engine type, estimated take-off weight, thrust and drag factors, intended climb speed profile, climb acceleration procedure, throttle setting.
- Stakeholder / objective ontology (§7–§9): with airline preferences known, automation "can more effectively accommodate airline operational considerations into traffic management advisories" (p. 5). Preferences may serve one flight's fuel or "the overall schedule efficiency of the airline as a whole."
- Optimization study (§11–§13):
  - **The ground weight assumption, stated outright:** "CTAS currently uses a nominal estimated takeoff weight, which is identical for all aircraft of a given type. This is clearly a gross approximation" (p. 4). Speed profiles are likewise "defined for each aircraft type, but are not tailored specifically for individual flights."
  - **How much real weights vary (Table 3;** about 8,000 flights from two airlines out of Dallas/Fort Worth and Denver, March–April 1999):

    | Type | Mean take-off weight (lb) | Std. dev. | Min to max from mean |
    |---|---|---|---|
    | B737 | 118,500 | 4.5% | -8.8% to +9.6% |
    | B757 | 192,500 | 6.4% | -23.8% to +37.2% |
    | MD80 | 129,900 | 7.1% | -27.0% to +51.6% |
    | B767 | 341,800 | 15.0% | -26.8% to +19.3% |
    | B777 | 424,400 | 5.2% | -9.3% to +8.6% |
    | DC10 | 448,100 | 20.1% | -29.3% to +36.6% |

  - **For three types (B737, B747, A319) the ground system's nominal weight was outside the whole observed range.**
  - **Effect of weight on climb prediction (worst cases):** altitude errors of nearly 10,000 ft; path distance errors of 15 NM or more; time and distance to top of climb varying by up to 35 minutes and 230 NM.
  - **Effect of speed profile:** a ±10 percent change in climb CAS/Mach gave 2,700 ft and 25 NM of error. Along-track error "is highly sensitive and grows with time."
  - **Effect of engine fit:** a 12 percent thrust difference between two engines on the same airframe gave 5,700 ft and 6 NM.
  - **"The absolute altitude ceiling for a given airframe/engine configuration will be determined solely by the aircraft gross weight"** (p. 5).
  - **Cost index is how the airline sets speed:** the recommended speed profile "is commonly issued by the AOC in the form of a cost index" (p. 6), for example to make up lost time.
  - **Better weight alone can make things worse.** A few predictions were less accurate with real weights, "likely due to inaccuracies in current CTAS engine models" (p. 9). Accurate weights need accurate performance models.
  - **Definitions (p. 1–2):** a missed advisory is a lost chance to resolve a problem "in a manner most efficient to the airspace user"; a false advisory is an unnecessary maneuver off the preferred trajectory. Both cost efficiency and workload, not safety, because predictions are refreshed.
- Glossary / terminology: CTAS, trajectory synthesizer, EDX (En route Data Exchange), calibration data versus intent data, top of climb, missed and false advisory.
- Other: even the airline does not know passenger and cargo weight well before departure; it knows fuel weight (p. 5). Inaccurate predictions also "waste airspace capacity by forcing the controller to apply larger than required separation buffers" (p. 2).

## Rating

**4/5** — The original, measured statement of what ground automation assumes about weight and speed and what airline data would fix, with real weight distributions. Climb phase only, which keeps it from a 5 for a cruise experiment.

## Flags

- The file name says 2012. The paper is 1999; the PDF was downloaded through the university library on 2026-10-04.
- Climb only. The cruise relevance is the ceiling statement and the weight spreads.
- The worst-case table uses the extreme observed weights, "not typical CTAS errors."
- 1999 fleet (B727, DC10, MD80, F100). The weight spreads are indicative for today's types, not current.
- Table 4 is badly scanned and only partly legible; the figures above come from the text.
- This is the 1999 paper. The 2001 companion on real-time data link of aircraft parameters is still not held.
- It confirms `schultz2012adaptiveClimb`, which cites it, and gives the primary source for that paper's second-hand statements.

## Highlighted passages

Fourteen digital highlights. They cover the abstract (prediction depends on aircraft state, performance, intent and atmosphere; airline data improves it), the introduction's point that prediction uncertainty affects conflict advisories and gives users less-than-optimal maneuvers (p. 1), the whole of Table 3 on weight variation (p. 6), and the conclusion that airline-provided weight, speed profile and engine type reduce climb uncertainty (p. 11).

## Processing metadata

- **Read depth:** fully read
- **Date processed:** 2026-10-04
