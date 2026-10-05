# Prior work overlapping the experiment definition: what to learn from each paper

Written 2026-10-04. These papers were downloaded for the §11 experiment definition (a crossing conflict among about four aircraft in one en-route sector, comparing a rule-based baseline against a decision that knows each aircraft's weight and cost index). They are **not registered sources**: no bib entries, no ledger rows, no ratings. If one earns a place in the report, run it through `workflows/process-references.md` first.

Each entry says how much was read. Page numbers are PDF pages.

Twenty documents are covered, in the order they were read. Two sections at the end are the place to start: "What the set says, taken together" and "Not obtained."

---

## 1. Erzberger (2006), "Automated Conflict Resolution for Air Traffic Control"

- **File:** `erzberger2006_icas083.pdf` (ICAS 2006, 28 pp). Read in full.
- **What it is:** the design of NASA's automated conflict resolver for the Automated Airspace Concept, with fast-time results for Cleveland Center.

### Decisions and rationale

- **Mimic what controllers issue.** Resolutions are altitude clearances, route changes and speed profiles "that controllers customarily issue," so pilots will accept them and the system can sit next to manually controlled airspace (p. 2).
- **Search, don't optimize.** The algorithm tries candidate maneuvers in a preference order and takes the first one that is conflict-free. It does not compute an optimum. A later enhancement would keep searching and pick the most efficient (p. 9).
- **One aircraft moves at a time.** Cooperative maneuvers are known to be more efficient but harder to implement, so they are excluded (p. 6). Compound maneuvers (two lever types at once) are excluded for the same reason (p. 7).
- **Altitude first.** For non-arrival conflicts, all altitude options for the preferred aircraft and then the other aircraft are tried before any horizontal or speed option. A fast-time comparison showed "a significant advantage in delay reduction" over a horizontal-first resolver (p. 7). The paper notes that controllers themselves vary, "some favoring horizontal and some favoring vertical."
- **Climb before descend.** Trial order is two steps up, then three steps down, because "step ups are preferred because of fuel efficiency considerations." The climb is checked against the aircraft's ceiling first (p. 12).
- **Minimum deviation.** Each lever starts with the smallest change and grows by the smallest usable increment. This is how "airspace user preferences" enter: by minimizing deviation from the original trajectory, not by any airline cost data (pp. 6, 8).
- **Do not act too early.** Conflicts are predicted up to about 20 minutes out, but resolution starts at 8 minutes, because beyond that "the more likely it is that the conflict will be a false alarm" (p. 5). The resolution must then be conflict-free for 12 minutes.

### Which aircraft moves (Table 1, p. 8)

For a cruise-versus-cruise crossing with a large crossing angle, the preferred aircraft is the one **farthest from an airspace boundary or its top of descent**, and the first maneuver is a step altitude. The other aircraft is tried next, then a minimum-separation turn, path stretch, and speed last. For in-trail or small-angle conflicts, the faster aircraft moves first.

### Control levers and their sizes

| Lever | Options | Notes |
|---|---|---|
| Step altitude | Up to 2 levels up, 3 down, in 1,000 ft steps | 2,000 ft minimum if the other aircraft is climbing or descending. Returns to the original level after the conflict clears plus a 1-minute buffer. |
| Horizontal (path stretch) | 4 delay levels, 2 turn directions, vector angles of 15, 30, 45, 60 degrees | Up to 32 options per aircraft. A 2 NM buffer is added to the 5 NM minimum. |
| Speed | Up to 3 increments up or down, each the smaller of 10 kt CAS or 0.025 Mach | Limited by the aircraft's speed envelope at that altitude. |

A cruise-versus-cruise conflict has up to 86 trial trajectories; most resolve in fewer than five.

### On speed as a lever

"Speed profile changes generally play a limited role in the resolution of non-arrival conflicts. These changes become increasingly ineffective for resolving conflicts when the time to first loss falls below 6 min" (p. 22). Speed is the first choice only for two arrivals converging on the same fix, where speeding up the leader avoids delaying everyone behind.

### Methodology

- Fast-time simulation in ACES, using type-specific aircraft performance models and a point-mass trajectory synthesizer.
- Cleveland Center, 24 hours of recorded flight plans (21 April 2005), scaled to about 2x and 3x traffic.
- Metric: resolution success rate and average delay per resolution. No fuel or cost metric.

### Results worth knowing

- Non-arrival conflicts: 100 percent resolved at all traffic levels, with 22 to 31 seconds average delay.
- 58 percent of resolutions were vertical at today's traffic, falling to 48 percent at 3x as vertical options ran out.
- Only 30 to 36 percent of detected conflicts were between two aircraft in steady cruise.

### Why it matters for the experiment

- It is a published, rule-based preference order for exactly the crossing case, including a tie-breaker for which aircraft moves. That is a candidate source for the baseline.
- It disagrees with the "one descent" baseline on direction: it tries a climb first for fuel reasons and only falls back to descent if the climb is infeasible or conflicted. This is where aircraft weight enters, since the ceiling check needs it.
- Its speed step (0.025 Mach) and its 6-minute effectiveness limit are concrete numbers to hold the ±0.04 M idea against.
- It has no notion of airline cost. "User preference" means minimum deviation. That is the gap the experiment sits in.

---

## 2. Erzberger, Lauderdale and Chu (2010), "Automated Conflict Resolution, Arrival Management and Weather Avoidance for ATM"

- **File:** `icas2010_197.pdf` (ICAS 2010, 20 pp). Read in full.
- **What it is:** the second-generation Autoresolver. It adds arrival sequencing and weather avoidance, and changes how the conflict resolution is chosen.

### Decisions and rationale

- **From first-success to best-of-many.** The 2006 version stopped at the first conflict-free maneuver. This version keeps searching across horizontal, altitude and speed options for both aircraft, then picks the one with the **least time delay**, "an economically important performance criterion" (p. 4). Average en-route delay per resolution fell by a factor of three as a result (a few seconds at 1x, about 10 seconds at 3x).
- **Why the change was made:** in human-in-the-loop simulations, "controllers and pilots wanted the flexibility to choose from horizontal, vertical, and speed resolutions" (p. 4). Pilots shown a step climb "often inquired if a step descent was available," for reasons including "a desire by a pilot to avoid turbulence and/or optimize fuel efficiency, factors not considered in the algorithm decision process" (p. 8).
- **Rules can override least delay.** The preferred-aircraft rules (p. 9):
  - A non-arrival moves before an arrival.
  - An aircraft not recently maneuvered moves before one that just was. This is a fairness rule.
  - A climbing aircraft moves before an overflight.
  - An aircraft near an airspace boundary is usually exempt.
- **A preference parameter** lets the user favor a maneuver class, at the price of a non-minimum-delay choice (p. 18).
- **Weather:** a horizontal resolution that enters a weather cell is rejected like a secondary conflict. For a weather-induced conflict, altitude is tried first "because they preserve the existing weather-avoidance path" (p. 15).

### Control levers

Eleven resolution types (Table 1, p. 18). Share of resolutions at today's traffic: path stretch 37 percent, step altitude 18, temporary altitude in climb 12, direct-to 12, descent speed profile 8, cruise speed 7, the rest under 3 each. Two newer levers:

- **Direct-to:** skip a dogleg in the flight plan. It gives a time saving, so it usually wins the least-delay comparison.
- **Route offset:** a parallel track, typically 10 NM to the side, entered at 30 degrees, in lengths of 50 to 200 NM. Chosen because many FMSs have a built-in offset function, so it is easy to issue by voice.

On speed: "attempted speed resolutions for aircraft in cruise flight seldom succeed and, even if they do, they are usually not the recommended resolution" (p. 8).

### Methodology

Same ACES fast-time setup as 2006 (Cleveland Center, 1x to 3x traffic). 99 percent of en-route conflicts had more than one feasible resolution, so there is nearly always a choice to make.

### Why it matters for the experiment

- This is the closest published analogue to cases B and C: generate every feasible resolution, score each, pick the best. The experiment's enumeration approach has a direct precedent.
- Its objective is **time delay only**. Fuel, weight and cost index do not appear. Substituting a cost-index-weighted cost for delay is the specific step the experiment adds.
- The pilot comments on p. 8 are evidence that crews hold fuel and ride-quality preferences the ground system cannot see.
- The "not recently maneuvered" rule is a ready-made equity mechanism to compare against a "who pays" metric.
- The 30 NM offset in the handwritten notes is three times the paper's typical 10 NM.

---

## 3. Mueller (2007), "Experimental Evaluation of an Integrated Datalink and Automation-Based Strategic Trajectory Concept"

- **File:** `ntrs_20080002300.pdf` (AIAA ATIO 2007, AIAA 2007-7777, 15 pp). Read in full.
- **What it is:** a simulation linking NASA's ground automation (CTAS) to a real FANS-1 FMS in a B747-400 Level D simulator, to test whether a ground-generated resolution can be uplinked, loaded and flown.

### Decisions and rationale

- **A "strategic trajectory" is one continuous clearance** that deviates the aircraft and returns it to its route, in place of several tactical instructions. Expected to cut controller and pilot workload and keep the full trajectory known to the ground (p. 3).
- **Use CPDLC message um79** ("cleared to [fix] via [route]") over a full-route uplink. A full-route message would erase what the airline has loaded downstream, such as a preferred approach, because "the ground automation in every ATC facility cannot be expected to know exactly the flight plan contained in the FMS" (p. 7).
- **The interrupted climb needs no "resume climb" call.** The altitude restriction is attached to a waypoint, and the FMS resumes the climb by itself "at its most efficient rate" (p. 9).

### Methodology

- Ground side generates the clearance; the FMS loads and flies it; ground predictions are compared with the flown track.
- Test conditions vary the ground system's knowledge: wind matched or 10 kt off, weight matched or about 20 percent off.
- Metrics: along-track, cross-track and vertical prediction error.

### Results worth knowing

- **"CTAS assumes aircraft weight based on the maximum takeoff weight and phase of flight"**, and a 20 percent mismatch with the real weight "is not uncommon" (p. 10). This is the direct evidence that the ground model uses a nominal, type-based weight.
- Cruise, single auxiliary waypoint: mean along-track error 1.10 NM (maximum 3.72), cross-track 0.43 NM.
- Climb with a 20 percent weight error: mean vertical error 1,016 ft (maximum 4,943 ft), against 279 ft (maximum 1,110 ft) with the weight known.
- Along-track error is larger than cross-track because the FMS tracks a lateral path at a set airspeed and does not control time.
- **Fixing one unknown can make things worse.** A weight error sometimes offset a speed error. "The only way to consistently increase the accuracy of predictions is to decrease the uncertainty in many parameters at once by, for instance, using datalink to communicate aircraft weight, measured wind field, desired cruise speed, and other intent variables" (p. 11).
- "Certain (possibly proprietary) information sources like aircraft weight may need to be shared for this concept to be feasible" (p. 12).
- Minimum crew time to load, accept and execute an uplinked route: 17 seconds, excluding thinking time. Operational averages for complex clearances are above 60 seconds.

### Why it matters for the experiment

- It closes the gap flagged in the journal as "still unsourced": that the ground aircraft model is type-based with a nominal weight.
- It gives measured prediction errors for a known weight error, which can size the "lo-fi model" in case B.
- The warning about fixing one unknown at a time applies to case C. Sharing weight without speed intent may not improve the decision. The experiment should say which variables are shared and treat them as a set.
- It shows the exchange in the other direction (ground to FMS) already works with fielded equipment, which matters for the architecture's interface between ATC automation and the FMS.

---

## 4. Renkhoff (2025), "Identifying Potential Conflicts and Corresponding Resolutions in the Upper Airspace from Historical Air Traffic Data"

- **File:** `dglr_650174.pdf` (German Aerospace Congress 2025, DLR, 9 pp). Read in full.
- **What it is:** a method for mining real controller behaviour. It finds clearances in recorded Swedish traffic that prevented a conflict, to build a dataset of what controllers actually do.

### Methodology

- **Data:** the public SCAT dataset (Swedish en-route, 13 weeks between October 2016 and September 2017, 167,547 flights), which includes ADS-B tracks, flight plans and the clearances controllers issued. Only traffic above FL200.
- **Step 1:** match each turn or level change to a clearance issued shortly before it (within 30 seconds for headings, 100 seconds for levels).
- **Step 2:** predict where the aircraft would have gone without the clearance, and check for another aircraft within 10 NM and 1,200 ft over the next 10 minutes. The thresholds are deliberately wider than 5 NM and 1,000 ft because the prediction is imperfect.
- **Step 3:** keep the case only if the clearance increased the separation.

### Results worth knowing

- **3,720 conflicts resolved by a flight level change against 135 by a heading change**, a ratio of about 28 to 1.
- The author's explanation: in low-density airspace "it might be more efficient to assign an aircraft to a less occupied flight level than to issue a heading change, particularly given that the required lateral separation standards are greater than the corresponding vertical minima" (p. 8).
- Vertical and heading changes "are the most common and preferred strategies" (p. 3). Speed clearances were not analysed.

### Limits

- Sweden is quiet airspace; a French study cited in the paper (Gaume et al.) found proportionally more cases. The ratio will not transfer directly to a busy US center.
- Level changes larger than 5,000 ft and those starting from a climb or descent were excluded.
- The paper does not report how many level changes were climbs and how many were descents.

### Why it matters for the experiment

- It is recent, empirical support for a vertical-first baseline from real clearances, not from simulation or interviews.
- Its three-step method is a template for a small scripted "what would have happened without the clearance" check if the experiment needs one.
- It names the motive for decision support that matches controller habits: advisories are accepted more readily when they match what the controller would have chosen. That bears on whether a cost-aware recommendation that departs from habit would be used.

---

## 5. EUROCONTROL (2003), "CORA: Conflict Resolution Assistant, Human Factors Lab Experiments"

- **File:** `nextor2003_cora_conflict_resolution.pdf` (slides, NEXTOR-FAA conference, 3 June 2003, 23 slides). Read in full. This is a slide deck, so there is little reasoning on the page.
- **What it is:** results of an experiment on how a resolution advisory tool should work with the controller. It is not the Kirwan and Flynn strategies paper, which could not be downloaded.

### Decisions tested

Three ways to divide the work between controller and tool:

| Philosophy | Who finds the resolution | What the tool shows |
|---|---|---|
| User-driven | Controller, who may ask the tool | Five best-ranked resolutions by type, on request |
| Automatic | Tool; it implements unless the controller rejects | The one best-ranked resolution |
| Collaborative | Tool calculates; controller chooses | Signals that resolutions exist; shows the ranked list when asked |

Also tested: how far ahead the conflict is presented (5, 10 or 15 minutes), and whether resolutions are listed in a fixed order by type or ranked by a quality index.

### Methodology

- Ten controllers (mean experience 18.7 years) from seven European providers, November 2002.
- Within-subject factorial designs (3 x 2 x 2 and 3 x 3), each scenario containing one conflict, with the controller observing and not controlling.
- Questionnaire measures: human-automation cooperation, mental workload (NASA-TLX, revised), situation awareness.

### Results worth knowing

- **Preference:** collaborative 7 of 10, user-driven 3 of 10, automatic 0 of 10.
- **Timeline:** a significant effect on rated cooperation (p = 0.003). Controllers preferred 10 and 15 minutes, describing it as support "at Planning stage."
- No statistical difference between philosophies on the cooperation scale. The slides list possible reasons, including that the task was observational.

### Why it matters for the experiment

- The "automated procedure" in the treatment is not one thing. Whether the tool decides, proposes one answer, or offers a ranked list is a design decision with a known controller preference (collaborative, never fully automatic).
- It supports allocating the capability to the planning (D-side) role with a 10 to 15 minute horizon, consistent with EDST's placement.
- It offers three ready workload and acceptance measures if the experiment ever needs a human-factors proxy beyond counting clearances.

---

## 6. Lauderdale, Bosson, Chu and Erzberger (2018), "Autonomous Coordinated Airspace Services for Terminal and Enroute Operations with Wind Errors"

- **File:** `ntrs_20180005217.pdf` (AIAA paper, NASA Ames, 10 pp). Read in full.
- **What it is:** the Autoresolver extended to cover terminal and en-route airspace together, then tested with a deliberately wrong wind forecast.

### Decisions and rationale

- **Coordination rules at the boundary.** Each agent can only maneuver aircraft in its own airspace, so three simple rules guarantee a conflict-free period on each side of a handoff (65 and 135 seconds). With the rules on, conflicts first detected with under a minute to go fell from 10 to 2.
- **Both agents must agree on the predicted trajectory** of an aircraft in the other's airspace. Different predictions produce pop-up conflicts that are hard to solve (p. 3).
- **Conformance monitoring over big buffers.** For merging arrivals, a large detection buffer wastes capacity, so the system watches each aircraft's predicted arrival time and nudges it back when it drifts more than 5 seconds, using very small speed changes (down to 1 kt).

### Methodology

- Fast-time simulation in ACES, about 350 operations in and out of the Dallas-Fort Worth terminal area.
- **Two trajectories per aircraft:** a "perfect" one and one with errors. A missed alert is a conflict in the perfect set that the erroneous set does not show; a false alert is the reverse. This is the truth-model design the experiment needs.
- Only wind magnitude was perturbed (a 25 kt wind, off by 50 percent). The paper lists what it left out: "aircraft weight uncertainty, descent speed uncertainty, and pilot timing uncertainty" (p. 4).

### Results worth knowing

- With the wind error and a 1 NM buffer: about 5 percent of alerts missed and about 20 percent of alerts false.
- The buffer roughly halves missed alerts and adds a near-constant amount of false alerts.
- Resolutions rose about 50 percent and total delay more than 100 percent.
- Conformance monitoring cut delay by about 16 percent and schedule changes by nearly half, but needed more than six times as many resolutions.
- "For general interactions between cruising aircraft, trajectory prediction errors can largely be handled by adding detection buffers" (p. 5). The hard case is merging traffic, not cruise crossings.

### Why it matters for the experiment

- It is a worked example of scoring decisions made on an imperfect model against a truth model, with missed and false alerts as the measures.
- It shows a direct trade between prediction quality and workload: a tighter tolerance means many more interventions. A workload proxy should capture that.
- It says cruise crossings are the easy case for prediction error. That is a caution: in the experiment's scenario, better information may buy less than expected on the safety side, so the benefit has to come from cost.
- The "agents must agree on the trajectory" point is an interface requirement between adjacent ATC units worth carrying into the model.

---

## 7. Windhorst and Erzberger (2006), fast-time comparison of conventional and automated conflict detection and resolution

- **File:** `ntrs_20060054002.pdf` (NASA Ames, 6 pp; the title line did not survive the scan). Read in full.
- **What it is:** a short simulation study comparing today's concept with the automated concept as demand grows.

### Decisions and rationale

- **How the baseline was modelled.** The conventional concept is represented by its flow-management effect only: sector counts are held at or below each sector's Monitor Alert Parameter by delaying flights upstream. No controller was modelled doing conflict resolution, "because it was assumed that delays produced by CD&R are much smaller than those produced by TFM" (p. 2).
- **How the treatment was modelled.** Automated resolution on, flow management off, on the argument that automation removes the workload limit behind the sector cap.

### Methodology

ACES, Cleveland Center, 1x, 1.5x and 2x demand from 21 April 2005. Metric: delay only.

### Results worth knowing

- Conventional: 38 seconds average delay per flight at 1x, 1,990 at 1.5x, 6,014 at 2x.
- Automated: 22 seconds per conflict at 1x, 25 at 2x.
- Total delay at 2x: about 93 million seconds conventional against about 89 thousand automated.
- "Whereas the TFM algorithm imposes delays on broad groups of flights, the automated CD&R algorithm imposes delay on only the flights that are predicted to be in conflict" (p. 6).

### Why it matters for the experiment

- It is a precedent for a two-case comparison, and a warning. The baseline and treatment differ in more than one way (automation on, sector caps off), and the baseline controller is not modelled at all. That is the confounding and straw-man risk already identified for the experiment.
- It ties controller workload to capacity through the Monitor Alert Parameter. That is a sourced way to say why workload matters to the system and not only to the controller.
- Its stated exclusions (weather, equipment failure, mixed equipage, workload not tied to conflict resolution) are a model for a limitations paragraph.

---

## 8. Fukuda, Shirakawa and Senoguchi (2010), "Development and Evaluation of Trajectory Prediction Model"

- **File:** `icas2010_818.pdf` (ICAS 2010, Electronic Navigation Research Institute, Japan, 8 pp). Read in full.
- **What it is:** a ground trajectory predictor built on BADA and weather forecasts, with its ground speed predictions compared against data recorded on board.

### Methodology

- Aircraft model: BADA 3.7 total energy model. The "airline operation data" (preferred altitude, speed and weight per phase) also comes from BADA defaults.
- Error analysis: ground speed error is split by partial derivatives into contributions from wind speed, wind direction, temperature, track angle, and Mach or CAS. More than 100 flights analysed; four shown.

### Results worth knowing

- **The aircraft speed model is a bigger error source than the weather forecast** in most samples. When ground speed error was large, the Mach or CAS difference was usually the cause.
- Example: predicted cruise Mach 0.840 against a measured 0.831 produced about one minute of time error per hour of flight.
- Speed is "decided in consideration of various conditions, such as aircraft weight, fuel costs, weather conditions, and delay," and "is influenced by the cost index (CI) of FMS" (p. 7).
- A 30-second en-route time accuracy looks feasible "if the speed intention of the aircraft is reflected in trajectory prediction."
- Suggested sources of speed intent: Mode S downlinked aircraft parameters (Mach and CAS) and SWIM.
- The FMS optimizes for one aircraft only: "Trajectory optimization is limited to individual aircraft. It does not work for all aircraft" (p. 1).

### Why it matters for the experiment

- It links cost index to ground prediction error directly: the ground assumes a default speed, the airline flies its cost-index speed, and the gap dominates the error. This is cruise-phase evidence, which the climb papers do not give.
- A 0.009 Mach difference is worth a minute an hour. That is a scale for judging what a ±0.04 M change does to timing at a crossing point.
- The partial-derivative breakdown is a simple method for attributing an outcome difference to each shared variable in case C.
- The individual-versus-all-aircraft sentence is a citable statement of the capstone's central theme.

**Correction to an earlier note in this session:** the quotation that take-off weight and climb speed intent are "not entirely available to ground-based trajectory prediction infrastructure" was attributed to this paper. It is not in it. That sentence came from a search summary of a different paper that has not been obtained.

---

## 9. SESAR Solution PJ.18-W2-53B (2023), "Improved Performance of CD/R Tools Enabled by Reduced Trajectory Prediction Uncertainty" (contextual note)

- **File:** `sesar_pj18_53b.pdf` (SESAR 4DSkyways deliverable D2.2.010, edition 03.00.00, 20 September 2023, 25 pp). Read in full. It is a summary note; the detailed validation report (VALR) and cost-benefit analysis it points to were not obtained.
- **What it is:** the European programme's result on feeding aircraft-downlinked data into ground trajectory prediction and conflict tools. Five validation exercises by several air navigation service providers with Airbus and Indra. Reached V3 maturity (pre-industrial validation).

### The problem statement, in its own words

"The accuracy of today's ATC predicted Trajectories is limited by the lack of information about, amongst others, Airspace User's preferences or Meteorological data" (p. 7).

### Decisions and rationale

- **What the aircraft sends (ADS-C Extended Projected Profile):** gross mass, speed schedule, top of climb and top of descent, turn radius and turn type, the FMS predicted profile, preferred speeds, and predicted speeds at route points.
- **How the ground uses it:**
  - Reported actual mass plus Mode S true airspeed set the starting conditions of the prediction.
  - Speed schedule and Mode S IAS/Mach set the target speeds by phase.
  - The FMS profile is used to **calibrate the BADA performance model** for that flight, by comparing the downlinked vertical profile with the ground-computed one.
- **It applies to "what-if" trajectories too,** so a proposed resolution is evaluated with the better model.
- **Narrower detection envelopes.** With better prediction the tools draw a thinner uncertainty band around each trajectory, which aims to cut "false [low probability] conflicts."
- **A common service.** One ground service collects each aircraft's data once and shares it over SWIM, so every unit along the route does not need its own contract with the aircraft. The calibration data is produced in climb, so a unit that receives the aircraft in cruise needs it from that shared service.

### Methodology

Real-time, human-in-the-loop simulations with controllers at 2035 traffic levels, comparing legacy prediction against the new prediction, the downlinked profile and the tracks. Measures: human performance (workload, situation awareness), capacity, flight efficiency, safety.

### Results worth knowing

- Controllers handled 2035 traffic without degrading safety and "rely on having less false conflicts."
- **Capacity:** en-route increase of 3.21 percent at 30 percent equipage and 5.11 percent at 50 percent (one exercise); 5 percent alone and up to 7.5 percent combined with a companion datalink solution at 80 percent equipage (another).
- **Flight efficiency:** one exercise found fuel, distance and CO2 improvements in the terminal area but "negligible improvement" en-route. Another found no clear trend in lateral efficiency but better vertical profiles in climb, cruise and descent.
- One exercise recorded only a limited human-performance benefit and no cost-efficiency benefit from the controllers' viewpoint.
- Benefit depends on equipage; regulation requires a share of aircraft to be capable by 2026.

### Stated gaps

- **"Higher variability of cost indexes was not part of the validation exercises."** The first research recommendation after degraded modes is "to validate the impact of cost-index variations on conflict detection and resolution tools" (pp. 14, 17).
- Corrupted but credible downlinked data was not tested. This is a trust and safety issue.
- A delay in the downlink when the aircraft changes its speed profile mid-flight makes the aircraft behave differently from the ground prediction.
- Resolutions that were safe "often don't correspond with ATCO's plan. Therefore, the ATCOs might not use them" (p. 17).

### Why it matters for the experiment

- This is case C built and validated with real controllers. It confirms the architecture choice is realistic: mass and speed schedule over datalink, a per-flight calibrated model, and a shared service.
- It names cost-index variation as unstudied. The experiment's spread of cost indexes across aircraft addresses a gap the programme itself listed.
- Its en-route efficiency result was negligible in one exercise. That is a caution about effect size: the benefit showed up as capacity and fewer false conflicts more than as fuel.
- It supplies candidate architecture elements: the data items on the exchange, the common service, equipage as a parameter, and degraded modes as a risk.

---

## 10. SESAR PJ.38 ADSCENSIO (2023), "Paving the way towards the use of ADS-C Extended Projected Profile in CP1"

- **File:** `sesar_adscensio_2023.pdf` (7 slides, SESAR event, March 2023). Read in full. Very little text.
- **What it is:** a status summary of the demonstration that collected downlinked profile data from revenue flights.

### What it adds

- 45,000 flights and 2.5 million ADS-C reports collected between December 2020 and January 2023.
- Uses evaluated in real operations or shadow mode: display of top of climb and top of descent, arrival time at key waypoints, speed schedule in descent, consistency checks between the aircraft's and the ground's route, and integration into ground trajectory prediction for conflict detection and resolution.
- The "ADS-C Common Service" collects the data from the aircraft once and serves it to many ground users over a SWIM service, cutting network load and investment cost.
- Satellite datalink was tested as a complement to VHF datalink, to relieve its capacity.

### Why it matters for the experiment

It shows the information exchange in case C is past the concept stage in Europe and names the infrastructure it needs. It gives no performance numbers.

---

## 11. Engility for NASA Langley (2014), "Traffic Aware Strategic Aircrew Requests (TASAR): Annualized TASAR Benefits for Alaska Airlines Operations"

- **File:** `tasar_ntrs_20140012787.pdf` (contractor report NNL12AA06C, 2 September 2014, 23 pp). Read in full.
- **What it is:** a fast-time benefits study of a cockpit tool that proposes route and altitude changes the controller is likely to approve. It is the mirror image of the experiment: the aircraft is given a picture of the traffic, where the experiment gives ATC a picture of the aircraft's costs.

### Decisions and rationale

- **Optimize one aircraft at a time.** "All automation and pilot procedures are fully dedicated to a single aircraft which allows tailoring of optimization criteria to the objectives of each flight" (p. 6). This is local optimization by design.
- **Objective:** 50 percent fuel, 50 percent time. An advisory is rejected if it increases either one, so no fuel-for-time trade is allowed.
- **Only ask for what will be approved.** The tool withholds a request when:
  - it predicts a traffic conflict (probed 8 minutes ahead with a conservative 10 NM and 1,000 ft shell, using state projection only, since the aircraft does not have other aircraft's flight plans);
  - it would enter weather or special activity airspace;
  - the crew has already made a request to this sector controller;
  - the aircraft is within about 20 NM of the sector boundary (handoff);
  - the aircraft is still in its initial climb;
  - the aircraft is within 200 NM of a large hub destination.
- **Why voice limits the levers.** Requests go by voice, so lateral changes are limited to one or two named waypoints.

### Control levers

- Lateral: one or two named waypoints, then rejoin.
- Vertical: 2,000 ft above, 2,000 ft below, or 4,000 ft below the assigned altitude.
- **Climbs were allowed only at or below FL350, "to be conservative since aircraft weight was not modeled in the simulation"** (p. 8).
- Combinations of the two.

### The controller model (how the baseline ATC decision was simulated)

The simulated controller rejects a request if:

1. It would cause a conflict. The controller knows more than the aircraft: all flight plans, and traffic beyond the aircraft's 60 NM ADS-B range.
2. The sector is over its Monitor Alert Parameter ("a red sector"). The reasoning: as traffic rises, controllers form a plan, and a request that does not fit the plan is likely to be denied.
3. The request would send the aircraft into an adjacent red sector.

### Methodology

- Two linked instances of NASA's FACET tool, one simulating the present and one predicting ahead.
- Baseline is the historically flown trajectory of real Alaska Airlines flights (July to September 2012). The treatment replays the flight with the tool allowed to make requests every five minutes from top of climb to 200 NM from destination.
- Results are scaled to a year by route frequency from public traffic statistics, then converted to dollars with fuel price and per-minute maintenance and depreciation costs from public financial filings. Crew cost and customer satisfaction are left out.

### Results worth knowing

- 8,000 to 12,000 gallons of fuel and 900 to 1,300 minutes saved per aircraft per year; a little over 5 million dollars a year fleet-wide.
- Per flight, for the "more wind-optimal trajectory" case: about 27 gallons and 2.3 minutes. The rare "reroute initiative has ended" case gave the most per flight (103 gallons, 7.8 minutes).
- Mix of requests: 44 percent lateral only, 5 percent vertical only, 51 percent combined.
- 6 percent of requests were rejected by the simulated controller. Without ADS-B traffic information on board, about 23 percent would have been.
- Request load on ATC: 4 to 8 requests per hour in the busiest sectors at peak times. The report suggests managing that through dispatcher coordination.

### Why it matters for the experiment

- It gives an order of magnitude for what en-route trajectory changes are worth on a 737: tens of gallons and a couple of minutes per flight. A single conflict resolution will be worth less. This is the back-of-envelope check the experiment needs before building anything.
- It is a clean instance of locally optimal behaviour. Each aircraft asks for its own best trajectory, and the cost to the system appears as requests per sector per hour. That is the sub-system versus system tension in measurable form.
- The controller model is a sourced, simple rule set for the baseline: approve unless there is a conflict or the sector is saturated.
- It shows the same information gap from the other side. The aircraft lacks other aircraft's flight plans; ATC lacks the aircraft's weight and cost. The study had to restrict climbs because weight was not modelled.
- Its cost conversion (fuel price plus per-minute costs from public filings) is a workable method for the airline cost metric.

---

## 12. Mogford et al. (2016), "NASA Research to Support the Airlines"

- **File:** `tasar_ntrs_20160008387.pdf` (38 slides, NASA Ames and Langley). Read in full. Slides, so little reasoning on the page. Roughly a third of the deck is about cockpit state-awareness displays and is not relevant.
- **What it is:** an overview of NASA work aimed at airline operations. Three parts overlap with the experiment.

### Dynamic Weather Routes (McNally et al., with American Airlines)

- **Problem:** dispatchers file routes one to two hours before departure with conservative buffers around forecast weather. The weather then changes, and there is "no automation to help operators determine when weather avoidance routes have become stale."
- **Decision:** a ground tool at the airline's operations center continuously searches airborne flights for a route correction with a time saving, built as a maneuver start point, auxiliary waypoints and a return fix.
- **Result:** two years of operational testing at American Airlines. A 2013 analysis for Fort Worth Center found about 100,000 minutes of potential savings across 15,000 flights. One sample correction saved 7.8 minutes.

### TASAR overview (Wing)

- The tool evaluates 400 to 800 candidate trajectories a minute with a pattern-based genetic algorithm, and offers three solution types (lateral, vertical, combined) with the time and fuel outcome of each.
- Simulator study with 24 pilots: no effect on pilot workload.
- Flight trials (2013 and 2015) with about 50 controller interviews: controllers "found most TASAR requests acceptable."
- **A 2012 study compared three objectives** for a network carrier, as mean savings per flight:

| Objective | Time saved (min) | Fuel saved (lb) |
|---|---|---|
| Save time | 4.2 | -122 (more fuel burned) |
| Save fuel | 3.4 | 575 |
| 50/50 weighted | 3.6 | 543 |

### Flight Awareness Collaboration Tool

A shared winter-weather display for the airline operations center, ATC, the airport authority and de-icing operators. Relevant only as an example of a shared-information tool across the same stakeholders.

### Why it matters for the experiment

- The three-objective table shows that changing the objective changes the outcome, including a case where saving time costs fuel. It is a small, published version of what the experiment's cost-index spread is meant to show.
- Dynamic Weather Routes puts the optimizer at the airline operations center, a third place to allocate the capability besides ATC and the cockpit. The architecture has to choose one, and this deck documents all three being tried.

---

## 13. Sherali, Staats and Trani (2003), "An Airspace Planning and Collaborative Decision Making Model (APCDM) Under Safety, Workload, and Equity Considerations"

- **File:** `nextor2003_airspace_planning.pdf` (35 slides, NEXTOR research seminar, 3 June 2003). Read in full. Slides with dense formulas, several of which did not survive text extraction, so the constraint details below are from the legible parts only.
- **What it is:** a mixed-integer optimization model that picks one flight plan per flight from a set of alternatives, at the strategic (flow) level, while accounting for conflicts, sector workload and fairness between airlines.

### Decisions and rationale

- **Objective:** minimize total flight cost, with penalty terms for sector workload, conflict risk, collaboration inefficiency and inequity.
- **The motivating statement:** "Optimal Individual Decisions vs. Optimal Group Decision. Each participating airline's decisions represent conflicting objectives," leading to "inefficient overall use of the NAS" (slide 15).
- **Flight cost** is fuel (from the BADA performance model) plus delay cost. Delay cost multiplies the length of delay, a connection-delay factor, an estimated passenger load, and a cost per passenger-minute.
- **Collaboration efficiency:** for each airline, the ratio of the cost it bears under the group decision to the cost of its own individually optimized plan. A cap limits how far any airline can be pushed from its own optimum.
- **Collaboration equity:** how far each airline's efficiency sits from the weighted mean across airlines. The spread is penalized.
- **Workload:** average sector occupancy and peak occupancy, with a hard cap on peak.
- **Conflicts are probabilistic.** Each aircraft has a set of possible displaced trajectories (random and wind-induced), and a conflict counts when its probability passes a threshold. Vertical displacement produced almost no conflicts because separation is much larger than altitude-keeping error.

### Results worth knowing

- **"More stringent equity requirements induce reduced collaboration efficiencies"** (slide 28). Fairness and total efficiency trade against each other.
- The efficiency cap only changed the solution when it was tight (at or below 1.2 times an airline's own optimum).
- Conflict counts were insensitive to moderate changes in the probability thresholds.

### Why it matters for the experiment

- It gives two defined, computable measures for the "who pays" question: each airline's cost relative to its own optimum, and the spread of that ratio across airlines. These are better than a single "largest penalty" number because they separate efficiency from fairness.
- It is a precedent for scoring one decision at the airline level and the system level at once, which is the experiment's multi-level table.
- Its delay cost formula includes connections and passenger load. That is a way to bring schedule and passenger value into airline cost without a separate passenger value curve.
- It works at the flight-plan-selection level, not the sector conflict. That difference is the experiment's space.
- It is the kind of optimization study the capstone guardrail warns about. Take the measures, not the method.

---

## 14. Dias and Rey (2022), "Aircraft Conflict Resolution with Trajectory Recovery Using Mixed-Integer Programming"

- **File:** `arxiv_2203.11990.pdf` (arXiv preprint 2203.11990v1, 36 pp). Read in full. Most of the paper is mathematical formulation.
- **What it is:** an optimization method that resolves conflicts with speed and heading changes and then plans each aircraft's return to its route. It is an operations-research paper, tested on abstract benchmark geometries, not on real traffic.

### Decisions and rationale

- **Count the return, not only the avoidance.** Most optimization work minimizes the deviation needed to avoid the conflict and ignores the cost of getting back on route. Solving the two stages separately gives a "myopic" answer. Here the recovery cost is fed back into the avoidance stage and the two are iterated.
- **Penalize the number of aircraft moved.** A standard minimum-total-deviation objective spreads tiny maneuvers across every aircraft. The paper adds a fixed cost per controlled aircraft, because "solutions where there are many aircraft manoeuvring lead to higher workload and are not desirable or implementable in real applications" (p. 33).
- **Resulting trade:** fewer aircraft moved, each with a larger deviation, and an earlier return to route.

### Control levers and their sizes

- Speed: -6 percent to +3 percent, described as the "subliminal speed control" range.
- Heading: ±30 degrees.
- Recovery time: one of 15 two-minute periods.
- Horizontal only. Altitude is left for future work.

### Methodology

- Objective: a weighted sum of squared heading deviation, squared speed deviation, a fixed cost per aircraft controlled, and squared recovery time. The weights are swept in a sensitivity analysis.
- Benchmarks: the "circle problem" (aircraft evenly spaced on a circle, all heading to the center) and a randomized version, with 4 to 30 aircraft.
- Compared against solving the two stages once (naive) and a greedy recovery heuristic.
- Deterministic: no wind or prediction uncertainty.

### Results worth knowing

- In one 10-aircraft case, moving 3 aircraft resolved what the naive approach resolved by moving 9.
- Total cost was lower than both comparison methods on every instance.
- Runs to 30 aircraft within a 10-minute limit; the larger cases time out in the recovery stage.
- The speed-only literature it reviews notes that subliminal speed control "may fail to resolve all conflicts" in dense traffic.

### Why it matters for the experiment

- It supplies the speed range to compare against ±0.04 M. At Mach 0.78, -6 percent to +3 percent is roughly -0.047 to +0.023 Mach. The slow side is close to 0.04; the fast side is about half of it.
- The fixed cost per aircraft moved is a simple way to put workload into a cost function, as an alternative to counting clearances afterwards.
- The return-to-route cost supports the point already raised about the baseline: a descent is not finished until the aircraft is back at its level, and a score that ignores the return is myopic.
- Its objective is geometric deviation with arbitrary weights. Nothing in it reflects fuel, weight or cost index. This is the method-first, optimization-paper end of the spectrum, and the capstone should cite its ideas without adopting its machinery.

---

## 15. Pilon, Guichard and Cliff (2019), "Reducing Impact of Delays using Airspace User-Driven Flight Prioritisation"

- **File:** `sids2019_paper39.pdf` (9th SESAR Innovation Days, EUROCONTROL, 8 pp). Read in full.
- **What it is:** the validation of the User Driven Prioritisation Process (UDPP), which lets an airline reshuffle its own flights among the delay slots it has been given during a capacity shortfall. It works at the flow-management level, hours before departure, not at the sector conflict.

### The baseline it replaces

- Delay slots are handed out "first planned, first served." The paper explains why this rule persists: it minimizes total delay, it treats every flight by the same rule, and it preserves the original order, so both the flow managers and the airlines accept it as equitable.
- Its weakness: it "does not consider the different impacts of allocated delay on the flights' operational costs."

### Decisions and rationale

- **Aim to reduce the impact of delay, not the delay.** Total delay is unchanged; who absorbs it changes.
- **Let the airline decide among its own flights only.** Three features: reorder its flights by priority; protect one flight's schedule by giving up an earlier slot; and set a "time not after" margin per flight for the automation to respect.
- **The airline never reveals its costs.** "Each flight has its own not linear complex cost structure, which is only known by the [airline]." It sends priorities and margins, not cost functions.
- **Equity is a hard rule:** no flight of a non-participating airline may get more delay.
- **An earlier credit scheme was dropped** as no longer needed once the features were simplified.

### The cost-of-delay model

Delay cost per flight is a step function, not a line. It is small while the delay stays inside the flight's margin and jumps when:

- connecting passengers miss their onward flight;
- the crew runs out of duty time;
- the aircraft's next rotation is delayed;
- a night curfew is hit, which means hotels and compensation for everyone on board.

The exercise's model covered passenger duty of care (thresholds at 2 and 6 hours and overnight), curfew, transferring passengers and a per-passenger-minute overhead. It left out crew duty time, maintenance, cancellations and diversions.

### Methodology

- Real-time, human-in-the-loop simulation with dispatchers from six airlines and airport operations staff. 51 runs, 23 including the airport operations center.
- Six scenarios of arrival capacity loss at Paris Charles de Gaulle (fog, runway loss, thunderstorm, snow, morning and afternoon capacity).
- **Reference versus solution:** the same event under first-planned-first-served, then with the features applied.
- **Metric construction:** the share of the additional cost recovered, computed as (solution cost minus reference cost) divided by (reference cost minus standard cost), where the standard cost is what the day would have cost without the event.
- Measures: airline cost, missed passenger connections, equity (delay to non-participants), flexibility, human performance.

### Results worth knowing

- Airlines recovered 58 percent of the additional cost on average (range 2.6 to 124 percent). The paper's headline figure is "more than 40 percent."
- Passenger connections improved by 2.1 percent on average.
- No non-participating flight was made worse; 7.8 percent were made better.
- Only 8 percent of flights moved by 15 minutes or more.
- Point-to-point carriers recovered the most, because they had fewer constraints to juggle.
- Stated limits: one airport, one day of traffic, other real-life options (such as swapping aircraft) switched off, which "may have exaggerated the use and benefits."

### Why it matters for the experiment

- It is the strongest precedent for the experiment's framing: keep the system-level quantity fixed and change who bears it using information only the airline holds.
- First-planned-first-served is the flow-level twin of "one descent for the aircraft that is easiest to move." Both are cost-blind and accepted because they are simple and even-handed. The paper's account of why that rule is trusted helps make the baseline a fair one.
- The step-shaped cost of delay argues against a linear time cost. A cost index is a linear proxy; a connection-critical flight has a cliff. The "late with connections" aircraft in the scenario should be modelled with a threshold.
- "Share of additional cost recovered," with a standard, a reference and a solution, is a ready template for the improvement metric the course asks for.
- The design answer to gaming is worth noting: the airline is never asked for its costs, only for an ordering among its own flights, so it has nothing to inflate.
- "No one outside is worse off" is a testable equity constraint for the experiment's system-level case.

---

## 16. Gurtner and Bolić (2023), "Impact of Cost Approximation on the Efficiency of Collaborative Regulation Resolution Mechanisms"

- **File:** `westminster_cost_approx.pdf` (Journal of Air Transport Management 113, 102471, open access, 13 pp). Read in full.
- **What it is:** a simulation study asking how much is lost when airlines tell a central optimizer a simplified version of their costs, and how much more is lost when airlines do not know their own costs well. Flow-management level.

### The four things that corrupt cost information

The paper lists what can go wrong between an airline's true cost and what a central optimizer uses (p. 4):

1. The airline's own errors about its costs.
2. The approximation used to communicate costs simply.
3. Gaming: declaring dishonest costs to gain an advantage.
4. Behavioural effects, such as clinging to a slot already held.

It studies the first two and names the other two as known problems. On gaming: with any scheme where declared weights are compared across airlines, "airlines could put very high weights to have a better allocation for their flights," an instance of "the so-called tragedy of the commons."

### The four mechanisms compared

| Mechanism | What it does | Role in the study |
|---|---|---|
| First planned, first served | Minimizes total delay | Today's rule |
| UDPP | Each airline minimizes cost within its own slots | Local optimization; the one to beat |
| MINCOST | Central optimizer minimizes total cost across all airlines | Upper bound; can be "extremely unfair" |
| NNBOUND | MINCOST with the constraint that no airline ends up worse than under first planned, first served | Upper bound with built-in equity |

The paper says in so many words that UDPP "can be thought of as a local optimisation."

### Methodology

- Agent-based model with airline agents and a network manager agent. Each iteration draws a real delay regulation and applies a mechanism.
- "True" cost-of-delay functions per flight come from a detailed mobility simulator (Mercury) built on published European cost-of-delay values, with passenger itineraries, crew, maintenance and curfew. Data: one day of European schedules and passenger itineraries (12 September 2014) and a year of regulations at 21 airports.
- **Approximation:** each true cost function is fitted with a simple step-function archetype ("jump": a margin, a jump size and a slope).
- **Noise:** the true cost is perturbed with correlated random error to mimic an airline that does not know its costs well.
- **Efficiency:** total true cost saved relative to first planned, first served, as a fraction.

### Results worth knowing

- With true costs: UDPP about 45 percent and NNBOUND about 41 percent. For MINCOST the paper gives 46 percent in one experiment and 58 percent in another.
- Simple step functions fit real cost functions poorly (the best fits explain under 70 percent of the variance), and adding a slope matters more than adding a second step.
- **With approximated costs, the fully central optimum falls to about the level of UDPP with true costs.** The room for a cross-airline mechanism to beat local optimization is "a pretty small interval."
- **Approximation protects against the airline's own errors.** With heavy noise, MINCOST on true costs fell from 58 percent to minus 8 percent (worse than today's rule), but only from 48 to 38 percent when the noisy costs were first approximated.
- Airlines differ widely in whether they can compute their costs at all. Some run learning models; others work from proxies like on-time performance and the number of missed connections.
- Airlines "may be comfortable with sending a few parameters for their flights" but not detailed costs.
- UDPP at about 30 percent efficiency corresponds to roughly 600 euros saved per regulated flight.

### Conclusions the authors draw

- A new cross-airline mechanism will struggle to beat UDPP, and if it does, by a few percentage points.
- Future work should perhaps hold efficiency at the UDPP level and improve equity instead.
- Market mechanisms (auctions) avoid revealing costs but demand trading strategies too complex for airline operations.

### Why it matters for the experiment

- It is the most direct test of the capstone's motivating claim, and it complicates it. A central, system-level optimum beats local optimization only if the information is good. With realistic, simplified or noisy information, the local scheme is nearly as good and much more robust.
- For case C this is the key threat. A cost index is exactly a few-parameter approximation of a non-linear cost. The benefit of sharing it with ATC may be smaller than a "true cost" calculation suggests, and the experiment should score case C with both the true cost and the cost-index approximation of it.
- Its four mechanisms map onto the experiment's levels: today's rule, airline-level optimization, system optimum, and system optimum with a no-loser constraint. NNBOUND in particular is a defined version of the "who pays" safeguard.
- It gives the gaming limitation a citation and a name.
- The two-layer design (a detailed model to produce "truth," then a light agent model that decides on degraded information and is scored on truth) is the structure the experiment needs, at a scale that is too large to copy but simple to shrink.

---

## 17. Gasparin, Castelli, Bolić, Gurtner and Pilon (2025), "A User-Driven Prioritisation Process Implementation and Optimisation for ATFM Hotspot Resolution"

- **File:** `gasparin_trc2025.pdf` (Transportation Research Part C 170, 104894, open access, 23 pp). Sections 1 to 3 and 6 to 8 and the cost-model appendix read in full; the algorithm and integer-programming sections (4 and 5) read in part.
- **What it is:** the first mathematical formulation of the UDPP mechanism, plus an optimizer an airline could run privately to set its priorities, tested on 1,000 simulated capacity shortfalls at the 25 largest European airports.

### Decisions and rationale

- **How to judge a mechanism.** A cost reduction against today's rule says little by itself, because it depends on how bad the starting allocation was and on the shape of the cost functions. The paper's method is to bracket any mechanism between two bounds: the unconstrained minimum cost (MINCOST) and the minimum cost under a "no negative impact" constraint (no airline worse off than under first planned, first served).
- **The equity principle used.** Airlines themselves recognised "that a basic requirement for a delay handling mechanism in order to be considered equitable is that it should not cause any negative impact on any airline involved." The paper notes there is still no single accepted definition of equity.
- **Why the central optimum cannot be deployed.** It needs every airline's delay costs, "which [airlines] are generally reluctant to reveal as they are considered confidential business information," and it does not involve airlines in the decision.
- **Keep the optimization local.** The airline runs the optimizer on its own costs and sends only priorities, so confidentiality holds.

### Methodology

- 1,000 synthetic but data-driven shortfalls built from real regulation records (June to August 2019), with flights, aircraft types, passenger loads and connections sampled from real data.
- Cost-of-delay model from the standard European reference values: smooth components (maintenance, crew, passenger "soft" cost such as lost goodwill) plus step components (compensation, re-accommodation, curfew). Three cost scenarios by airline business model.
- Results broken down by airline size within the shortfall.

### Results worth knowing

- Total delay cost under today's rule: 1.05 billion euros across the 1,000 cases. Reductions: local optimization (UDPP) 34 percent, the no-loser optimum 57.9 percent, the unconstrained optimum 61.5 percent.
- **Adding the no-loser constraint costs only about 4.5 percent of the achievable saving.** Equity was nearly free in aggregate.
- **But the unconstrained optimum is harsh on small players.** Averaged per airline, it produced a negative mean percentage change, because airlines with a few low-cost flights were pushed back to benefit others.
- **Local optimization leaves small players out.** Airlines with three or fewer flights in the shortfall were 83 percent of the airlines and held 25 percent of the cost, and had almost nothing to swap.
- The no-loser optimum helped small airlines most, because their single flights could not be pushed back but could still be pulled forward.
- Missed passenger connections fell 50.8 percent (unconstrained), 34.5 percent (no-loser) and 33.9 percent (local). Curfew violations fell 56, 48 and 42 percent.
- A linear cost model and a quadratic one gave very different bounds on the same example.

### Why it matters for the experiment

- It supplies the evaluation frame the experiment lacks: report each case as a share of the best achievable, with and without a no-loser constraint, instead of only against the baseline.
- It shows the three outcomes the capstone is about in one table: local optimization captures about half the available benefit; the system optimum captures the rest by making some parties worse off; a constrained optimum recovers most of it fairly.
- The small-player finding translates to the scenario. With four aircraft, an airline with one aircraft in the conflict has nothing to trade. The two-aircraft airline in the scenario is what makes an airline-level optimum possible at all.
- The sensitivity to linear versus non-linear cost is a warning to state the cost function's shape as an assumption and test one alternative.

---

## 18. Erzberger and Heere (2008), "Algorithm and Operational Concept for Resolving Short-Range Conflicts"

- **File:** `erzberger2008_icas383.pdf` (ICAS 2008, 25 pp). Sections 1 to 6 and 8 to 11 read in full; the secondary-conflict procedure (section 7) and the derivations in section 3 read in part.
- **What it is:** the last-two-minutes layer of the same NASA concept (called TSAFE): a horizontal-turn resolver for conflicts that the strategic layer missed, plus a proposal for when automation may act without the controller. Low relevance to the experiment's maneuver choice; relevant for the layering and the authority rules.

### Decisions and rationale

- **Three independent layers, by time to loss of separation:** the strategic resolver (about 2 to 20 or 30 minutes), this tactical layer (under 2 minutes), and TCAS on board (about 20 to 35 seconds). Independence between layers is the safety argument.
- **Speed is ruled out at short range** because "aircraft typically respond too slowly to speed change inputs."
- **Horizontal turns only**, partly so the advisory cannot be confused with a TCAS vertical advisory.
- **Search order:** one aircraft at a standard bank angle (15 degrees); then one aircraft at a high bank angle (30 degrees); then both aircraft together. Among successful maneuvers, pick the least heading change. If separation cannot be kept, pick the maneuver that maximizes the minimum separation.
- **Prefer passing behind.** Turning to cross behind the other aircraft gives separation that grows steadily with turn angle. Crossing in front is "unstable": a small change in turn angle can collapse the separation. Controllers already prefer the back-side resolution "because it produces stable and predictable resolutions."
- **Who decides, by the clock.** With between two minutes and one minute to go, the controller can inhibit the automation, tell it to issue its advisory, or do nothing. Under one minute, responsibility "defaults automatically" to the automation, which uplinks the advisory and tells the controller at the same moment. Afterwards the controller takes the aircraft back and returns it to its route.
- **Liability follows authority.** A controller is generally not held responsible for a loss of separation the automation failed to prevent, unless a clearance issued in the last minute caused it.
- **Use what is already installed.** The advisory rides on the Mode S data link that supports TCAS, with a parity check and a read-back, and a worst-case delay of one 12-second radar scan.

### Human factors reasoning

Rare, high-consequence, time-critical events are good candidates for automation because automating them is unlikely to erode the controller's skill. Telling the controller what the automation did, at the moment it does it, avoids the confusion controllers report after a TCAS maneuver.

### Why it matters for the experiment

- It places the experiment clearly: the scenario sits in the strategic layer, 8 to 20 minutes out, where there is time to weigh cost. Inside two minutes cost is irrelevant and the objective changes to maximum separation.
- It is a worked example of a time-based transfer of decision authority between a human and automation, with the liability rule written down. That is direct material for the responsibility (RACCI) analysis and for the "authority transition" items already noted from the AIM.
- "Pass behind" is a second sourced controller heuristic for the baseline, alongside "altitude first."

---

## 19. del Pozo de Poza (2012), "Assessment of Fairness and Equity in Trajectory Based Air Traffic Management"

- **File:** `delpozo2012_glasgow_thesis.pdf` (PhD thesis, University of Glasgow, sponsored by Boeing Research & Technology Europe, 258 pp). **Read in part:** abstract, contents, chapter 4 sections 4.1 to 4.3 (cost function, cost index, penalty function), and the conclusions of chapter 6 (airline incentives). Chapters 1 to 3, 5, 7 and the appendices were not read.
- **What it is:** a framework for measuring whether an air navigation service provider distributes the cost of trajectory changes fairly among airlines, built directly on the cost index.

### Decisions and rationale

- **Fairness and equity are different things.** Equity is equal treatment. Fairness accounts for each party's needs and limits. The thesis's illustration: two hungry students and one slice of pizza. Cutting it in half is equitable. Dividing it by how hungry each one is, on an agreed measure, is fair, "as long as both students define their hunger according to the agreed measure and provide the value truthfully."
- **Cost is measured as a penalty against the airline's preferred trajectory.** The airline's variable cost is time cost plus fuel cost, with the cost index as their ratio. A penalty is the extra time and extra fuel of the assigned trajectory over the preferred one. Flying faster or burning less than preferred carries no penalty.
- **Each flight has a tolerance.** The airline has a maximum acceptable extra time and extra fuel for each flight. The penalty saturates at that point.
- **Compare flights on a relative scale.** The penalty divided by its saturation value gives a dimensionless number between 0 and 1, so a flight with a small tolerance and a flight with a large one can be compared.
- **The cost index sets the shape.** A high-cost-index (punctuality) airline saturates on a small delay but tolerates more fuel; a low-cost-index airline is the reverse. "If [service providers] take into account the weight the airline gives to the time-related and fuel-related costs, the incurred costs could be maintained closer to the preferred costs."
- **Two ways to use the metric:** inside a resolution algorithm as an extra criterion before the decision, or afterwards to compare algorithms.

### Methodology of the incentive study (chapter 6)

A two-airline game with a fairness-oriented service provider. Each airline tells the provider its cost index and its two tolerance values, and may report values different from its true ones. Equilibria are found with a minimax criterion across scenarios that vary route length and business strategy.

### Results worth knowing

- **Airlines misreport whenever they can.** "Whenever the airlines can provide a value... different than the inside parameter value they do."
- **The time tolerance is the lever worth gaming.** Understating it produced benefits of roughly 40 to 75 percent for the airline that did so in the single-parameter cases, against about 1 to 3 percent for misreporting the cost index.
- **"The impact of providing values for the cost index that are not equal to the inside parameter value is not significantly beneficial neither to the airlines nor to the system."**
- Misreporting does not always harm total system cost; sometimes it lowers it. What it destroys is the provider's ability to guarantee fairness.
- **The thesis's main conclusion:** to keep the system fair, airlines "cannot be allowed to communicate their reference values" for acceptable delay and fuel. It suggests a neutral body set them.
- When airlines have the same preferred time and fuel, the one with the higher cost index gains more from misreporting; when preferences differ, the one on the longer route does.

### Why it matters for the experiment

- It is the closest prior work to the experiment's core idea: a service provider using each flight's cost index to decide who absorbs a trajectory change. The thesis formalizes it and applies it to conflict resolution.
- Its penalty measure is a ready-made, defined "who pays" metric at the flight level, and it generalizes to airlines operating several flights.
- **It partly answers the gaming question, in the experiment's favour.** Sharing the cost index alone gives an airline little to gain by lying. The danger is in sharing tolerance or priority values. That supports limiting the exchange to cost index and weight, and it contradicts the simpler worry that airlines would just inflate the cost index.
- It gives the vocabulary to state the baseline precisely: "one descent for the easiest aircraft" is neither equitable nor fair in this sense, it is cost-blind.
- The chapters not read (5 and 7) contain the application to three conflict resolution algorithms. They are the part to read next if this thesis is used.

---

## 20. Erzberger (2005), "Automated Conflict Resolution for Air Traffic Control" (extended abstract)

- **File:** `ntrs_20050242942.pdf` (NASA Ames, 3 pp). Not read separately. It is the abstract submitted for paper 1 and adds nothing to it.

---

## What the set says, taken together

### On the baseline

- **Altitude first is well supported.** The NASA resolver chose it because it gave the least delay (paper 1). Swedish clearance data shows about 28 level changes for every heading change used to prevent a conflict (paper 4).
- **The direction is contested.** The NASA resolver tries a climb first for fuel efficiency and checks the ceiling (paper 1). Rantanen and Wickens, since obtained and registered as `rantanen2012conflictManeuvers`, found the opposite in U.S. track data: descents more than three times as frequent as climbs, and 23 descents to 6 climbs for level crossing conflicts. The experiment's "one descent" baseline is defensible as the option that needs no knowledge of the aircraft, which is the point the journal already makes.
- **Which aircraft moves has published tie-breakers:** the one farthest from a boundary or its top of descent; the one not recently maneuvered; a non-arrival before an arrival; the climbing aircraft before the overflight (papers 1 and 2).
- **Speed is a weak lever for a crossing conflict.** It "seldom succeeds" in cruise and loses effect inside six minutes (papers 1 and 2). Published step sizes are 0.025 Mach or 10 kt, and the subliminal range is -6 to +3 percent (papers 1 and 14).
- **A simulated controller can be simple and still sourced:** approve unless there is a conflict or the sector is over its Monitor Alert Parameter (paper 11).

### On what ATC knows

- Ground automation assumes a weight from the aircraft type and phase of flight, and a 20 percent error is "not uncommon" (paper 3).
- The assumed speed is a bigger source of prediction error than the wind forecast, and the real speed follows the cost index (paper 8).
- Europe has validated downlinking mass and speed schedule to ground tools, with a per-flight calibrated model and a shared data service (papers 9 and 10).
- Fixing one unknown can make predictions worse, so the shared variables should be treated as a set (paper 3).

### On local versus system optimization

- Local optimization by each airline captured about a third to a half of the available cost saving; the system optimum captured about 60 percent, by making some parties worse off; a no-loser constraint cost only a few points of that (papers 16 and 17).
- With simplified or noisy cost information the system optimum loses most of its edge, and with bad information it does worse than today's rule (paper 16).
- Tighter fairness reduces total efficiency (paper 13). Smaller players are the ones a pure optimum sacrifices and the ones local optimization leaves out (paper 17).
- Aircraft-level optimization shows up at the system as request load on controllers (paper 11).

### On gaming

- Misreporting is expected wherever declared values are compared across airlines (paper 16).
- The cost index itself is a poor thing to lie about; tolerance and priority values are the ones worth gaming (paper 19).
- The deployed European answer is never to ask for costs, only for an ordering among the airline's own flights (paper 15).

### On method

- Score every decision against a higher-fidelity "truth" trajectory, using missed and false alerts or true cost (papers 6 and 16).
- Report results as a share of the best achievable, with and without a no-loser constraint, not only against the baseline (paper 17).
- "Share of additional cost recovered" is a usable improvement metric (paper 15).
- Enumerate candidate maneuvers and pick the best; this is what the NASA resolver does (paper 2).
- Keep baseline and treatment different in one respect only. Paper 7 is an example of what happens otherwise.

### Cautions for the experiment

- **Expect a small effect.** En-route trajectory optimization is worth tens of gallons per flight (paper 11), and the European validation found negligible en-route fuel benefit in one exercise (paper 9). The benefit there appeared as capacity and fewer false conflicts.
- **Cost is not linear in time.** Delay cost jumps at missed connections, crew limits and curfews (papers 15 and 17). A cost index is a linear proxy.
- **Cruise crossings are the easy case for prediction error** (paper 6), so better information is unlikely to show a safety benefit in this scenario.
- **Controllers may not use a resolution that does not match their plan** (papers 4, 5 and 9).

### The gap the experiment sits in

None of these papers scores a single sector-level conflict resolution by each aircraft's fuel-and-time cost using weight and cost index. The NASA resolver minimizes delay and ignores cost (paper 2). The European programme downlinks the data but lists cost-index variation as unstudied (paper 9). The fairness thesis uses cost index for distribution but not weight (paper 19). The flow-management work does the multi-level comparison but hours ahead and on delay slots (papers 15 to 17). This is a reading of 20 documents, not a literature review.

---

## Not obtained

These were on the list and could not be downloaded. The first four are the ones most worth getting through the university library.

**Update, 2026-10-04 evening:** the owner obtained Rantanen and Wickens (2012), Kirwan and Flynn (2001) and Coppenbarger (1999), plus Fothergill and Neal (2013). All four are registered sources with summaries in `evidence/literature-notes/summaries/`. Coppenbarger (2001) and the rest of this table are still not held.

| Paper | Why it matters | What blocked it |
|---|---|---|
| Rantanen and Wickens (2012), "Conflict Resolution Maneuvers in Air Traffic Control: Investigation of Operational Data," *International Journal of Aviation Psychology* | The empirical US source for the baseline's preference order and the descent-versus-climb split | Journal paywall |
| Coppenbarger (2001), "Real-Time Data Link of Aircraft Parameters to the Center-TRACON Automation System (CTAS)," 4th USA/Europe ATM R&D Seminar; and Coppenbarger (1999), "Climb Trajectory Prediction Enhancement Using Airline Flight-Planning Information," AIAA GNC | The original measurements of what weight and speed intent are worth to ground prediction | Not found on NASA's report server |
| Kirwan and Flynn (2001), controller conflict resolution strategies for CORA, EUROCONTROL, 4th USA/Europe ATM R&D Seminar | The interview-based account of controller rules of thumb | Not found online |
| "Subliminal Speed Control in Air Traffic Management: Optimization and Simulation," *Transportation Science* 50(1), 2016 | The speed-only lever studied directly | Repository returned a web page, not the file |
| Rantanen, Wickens and Keller (2009), "Maneuver Stereotypes in Airborne Conflict Resolutions," ISAP | Pilot maneuver preferences | HTTP 403 |
| "Equity-oriented aircraft collision avoidance model," *IEEE Transactions on Intelligent Transportation Systems* (doi 10.1109/TITS.2014.2329012) | Equity inside a conflict resolution model | IEEE paywall |
| "A simulation based study of subliminal control for air traffic management," *Transportation Research Part C*, 2010 | ERASMUS results | Paywall |
| ERASMUS, "Strategic Deconfliction to Benefit SESAR" | Programme summary | HTTP 403 |
| MITRE URET functional performance assessment; Paglione, Cale and Ryan (1999); Brudnicki and McFarland (1997) | Measured false alert rates for the fielded conflict probe | HTTP 403 or not found |
| SESAR Solution 53B validation report (VALR) and cost-benefit analysis | The numbers behind paper 9 | Not searched for |
