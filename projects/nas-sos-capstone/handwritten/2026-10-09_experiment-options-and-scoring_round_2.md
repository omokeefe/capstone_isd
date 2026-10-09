# Handwritten notes on the experiment options and scoring draft, round 2 (transcribed 2026-10-09)

Transcribed by Claude from `2026-10-09_experiment-options-and-scoring_round_2.pdf` in this folder: a six-page print of `knowledge/models/experiment-options-and-scoring.md` (printed 2026-10-09, 12:08 PM) with red ink notes and yellow highlighter. The other PDF of the same print in this folder, `2026-10-09_experiment-options-and-scoring_ook-review.pdf`, carries no markup.

Wording in quotes is the handwriting; anything in square brackets is my guess at an unclear word. Section numbers (§) are sections of `knowledge/models/experiment-options-and-scoring.md` as printed. "Kind" is my reading of the note:

- **change**: the note says what the file or the report should say or contain.
- **decision**: the note settles an item the draft had marked for the owner.
- **question**: the note asks; an answer or a recommendation is given in the last column where one exists.
- **check**: the note asks for a source to be found.
- **agree**: the note endorses what is printed.

The last column says what was done with the note on 2026-10-09. "Applied" means `knowledge/models/experiment-options-and-scoring.md` was edited.

## Page 1 (§1, the four aircraft)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 1.1 | Beside the §1 heading: "Need an image of the scenario...", with a sketch: "AC4" and "AC3" side by side, each with a small arrow; "AC1" above and to the right with an arrow; "AC2" at the far right marked with an X. | A picture of the scenario. I read the sketch as AC4 and AC3 in trail, AC1 on its own track, and AC2 crossing. | change | Recorded in the file as a needed figure. Not drawn. |
| 1.2 | In the AC1 row: "600 klb B777 w/ 200+ PAX." | AC1's type, weight and passenger load. | decision | Applied, graded [SME]. |
| 1.3 | In the AC2 row: "105 klb 737". | AC2's type and weight. | decision | Applied, graded [SME]. |
| 1.4 | Struck through: "A heavy aircraft is nearer its optimum at the lower level; a light one loses more by descending (`mori2022massCruise`, Fig. 1)." Beside it: "I don't think this is true, necessarily. The heavier one will fly faster to maintain the lower alt, which means more drag." | The reason given for making AC1 heavy and AC2 light. | change | Applied: the sentence is removed. See "Points where I differ" below. |
| 1.5 | Highlighted: "So 'which one descends' has a cost-based answer the controller cannot see." Beside it: "↑ True, Definitely." | The conclusion of the same bullet. | agree | Kept. |
| 1.6 | Highlighted, no words: "AC3 from the same airline as AC1 is what makes the airline column differ from the aircraft column." | The reason for AC3's airline. | agree | Kept. |
| 1.7 | Beside "AC3 and AC4 below the crossing point make the level below L matter": "Regardless, they impact effectiveness of speed control." | The role of the two in-trail aircraft. They matter for speed resolutions as well as for the level below. | change | Applied. |
| 1.8 | Highlighted: "but removes the question of fairness between airlines from the main pair." Beside it: "Use ChatGPT to create visual." | The alternative assignment; and the tool for the scenario figure in 1.1. | change | Recorded with 1.1. |
| 1.9 | Beside the follow-up cells of O1 and O2 ("clear AC1 back up", "clear AC2 back up"), with an arrow to each: "May not be able to occur." | The re-climb after a descent is not guaranteed. | change | Applied, with 2.5. |

## Page 2 (§2, options and the climb rule)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 2.1 | Across the O6 and O7 rows: "Set up distances & speed such that +/- 0.04 Mach won't separate." | The speed option, O7. The scenario is to be built so that a speed change inside ±0.04 Mach cannot resolve the conflict. | decision | Applied. ±0.04 Mach is the owner's [SME] figure. |
| 2.2 | Beside "Where the rule comes from matters for how it is described": "The TASAR authors provide rationale. Include it." | The climb rule's stated reason. | change | Applied: the authors' reason is now quoted in that bullet as well. |
| 2.3 | Beside "One detail to settle": "West-bound even FLs; Eastbound odd... FL370 making FL390 impossible? or FL380 → FL400?" | The level of the crossing pair. Two candidates: an eastbound pair at FL370, for which the climb is to FL390; or a westbound pair at FL380, climbing to FL400. | question | Applied as two candidates. See "Points where I differ". |
| 2.4 | At the heading "Sources for the option set and the counts:": "Add these to report!" | The six source bullets. | change | A placeholder was added to the report's methodology section. |
| 2.5 | Left margin, with an arrow to "a descent is one instruction now and a second later to re-climb": "Re-climb or a large fuel penalty." | The follow-up to a descent: either a second clearance, or the aircraft stays low and pays in fuel. | change | Applied, with 1.9. |
| 2.6 | Beside "The three levers (altitude, vector, speed) ... are the same in every case": "Also cited in the TASAR paper." | A second source for the lever set. | change | Applied, with a limit: the TASAR study uses lateral and altitude changes and their combination. It does not use speed. |
| 2.7 | With an arrow to "The 2,000 ft step still needs one check against JO 7110.65BB ... Not yet looked up": "It's a fact. Assume as much for now. If I really feel the need later I'll adjust." | The 2,000 ft spacing between levels for one direction of flight. | decision | Applied: the open check is removed and the spacing is graded [SME]. |

## Page 3 (§2 case table, §3 outcome tables)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 3.1 | In the case A row, after "Which aircraft is the one-pager's §5 Decide": "What's the decision? AC1 vs AC2, ...?" | What the open item is. | question | Yes: the open item is which of the two crossing aircraft the baseline rule descends, AC1 or AC2. It is in `knowledge/models/experiment-definition.md` §5. Applied: the cell now says so. |
| 3.2 | After "it should be said in the report so the baseline does not look hobbled": "Add to existing report content or notes." | The point that the baseline may climb at or below FL350 and does not. | change | A placeholder was added to the report's methodology section. |
| 3.3 | After "The aircraft column reports the worst-off aircraft, not the average. An average hides who pays.": "I like listing all." | The aircraft column of both outcome tables. | decision | Applied: all four aircraft are listed, and the largest is marked. |
| 3.4 | After "(one-pager §8)": "These references are confusing. Always link to a named file." | Every shorthand reference in the file ("one-pager §8", "note 6.2"). | change | Applied throughout: each reference now names its file. Saved as a standing preference. |

## Page 4 (§4.1 aircraft, §4.2 airline)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 4.1 | Under the cost-index bullet: "Do I need to test across a range of CIs? This is not an optimization paper. It's an exploration of model interchangeable benefits." | Whether the experiment sweeps the cost index. | question | Recommendation: no sweep. One fixed cost index per aircraft, set by the scenario. Applied as a proposal. |
| 4.2 | Beside the airline equation: "Slots are typically 10-15 min between, so need distances & speed Δs that cross them." | The connection threshold. The scenario needs a delay large enough to cross a 10 to 15 minute slot boundary. | change | Applied, graded [SME]. See "Points where I differ". |
| 4.3 | Underlined: "which paper it comes from is still unconfirmed". Beside it: "No it's not. We discussed it in a chat & I extracted it. Find it!" | The source of the ten-factor dispatcher table. | check | Found. See "Sources found" below. Applied. |
| 4.4 | After "does this option cause a missed connection?": "It will depend on the passenger count & crew schedule. This will be difficult to quantify even though we have aggregate data in sources. Maybe total nationwide cost ÷ # of occurrences?" | The value of K, the cost of a missed connection. | question | Applied as the candidate method. No source for either number is held yet. |
| 4.5 | After "or a fourth information level is added. See §5.": "ATC & Airports can exchange this via SWIM & the inclusion or omission is consistent w/ my study parameters. Add it!" | Whether connection information becomes a level of shared information. | decision | Applied as a fourth case, D: case C plus the airline's connection information. That it is a separate case, and not folded into C, is my reading. The SWIM statement is graded [SME]. |
| 4.6 | Highlighted: "a third is listed because it is the usual one in public analysis." Beside it: "Cite source!" | My statement that a social cost of carbon is the usual measure. | check | I have no source for it. Applied: the statement is removed and a source is listed as needed. |
| 4.7 | In the caution cell of route 1 (carbon credits): "OK to assume their approach." | Using the international scheme's credit price for a U.S. domestic flight. | decision | Applied as a stated assumption. |
| 4.8 | In the caution cell of route 2 (passenger value): "It = $ lost, though, & they publish its b/c passengers care." | The owner's argument that passenger value is real money: airlines publish emissions because passengers care. | change | Applied as the owner's position. Still needs a study to cite. |
| 4.9 | In the caution cell of route 3 (social cost of carbon): "Should use in the 'system' column." | Where the social cost goes. | decision | Applied. |
| 4.10 | After the "Proposed (Decide)" paragraph: "Agreed on all accounts." | Route 1 for the airline column, route 2 in the discussion, route 3 with the system column. | decision | Applied. |
| 4.11 | After "Whether it does so here should be checked once a price is sourced.": "This can be contrasted w/ typical controller actions, where schedule gets priority. Is that the right priority?" | A discussion point: a carbon price makes fuel weigh more against time, while controllers' usual practice favors schedule. | question | Recorded as a discussion prompt. Not answered; it is a question for the report. |
| 4.12 | After "Both are candidates for `/process-references`.": "Find it from ICAO." | Where to get the emissions sources. | check | Leads found, none registered. See "Sources found". |

## Page 5 (§4.3 sector, §4.4 system)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 5.1 | After the "Automated decision" proposal: "Agreed. An EFB App w/ATC info can lead crew to request automatically via CPDLC, confirmed automatically on ground & manually clearance" (the line runs to the edge of the page). | Who does what in cases B and C. | decision | Applied: the proposal is agreed. The described chain (cockpit application, data link request, automatic check on the ground, clearance issued by the controller) is recorded as the owner's picture of how it could work. |
| 5.2 | After "Sector loading as a condition": "Maybe discuss in report... in morning rushes @ hub airports or near holidays more denial?" | A discussion point on when requests are more likely to be refused. | question | Recorded as a discussion prompt and added to the report's results placeholders. It is a hypothesis; no source is held. |
| 5.3 | After "the 'system optimum' depends on who sets the weights.": "I like this." | Computing a weighted sum for several weight sets to see whether the ranking changes. | agree | Kept. |
| 5.4 | After "Way 3 (dominance) is still open as an extra column (Decide).": "I don't get this. I think it's analogous to being on the pareto front. Opportunity for visuals." | The dominance column. | question | The analogy is exact. Applied: the paragraph is rewritten in those terms. |
| 5.5 | After "This needs a sentence in the report, and it is the link back to D-004.": "Isn't this explained by its cost equation. Add to report & refer back to." | What the system column stands for. | change | Applied, with 6.1. A placeholder was added to the report. |

## Page 6 (§6 abstractions)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 6.1 | In the row "System column not mapped to one model part": "It's a measure of the airspace as a whole SoS. Explain where needed." | What the system column stands for. | decision | Applied: the system column is the airspace as a whole system of systems. |

No marks on §5 (cases D, E and F) or §7.

## Sources found

- **The ten-factor table (note 4.3).** It is Figure 7 of Sheth, Gutierrez-Nolasco, Courtney and Smith, "Simulations of Credits Concept with User Input for Collaborative Air Traffic Management", held as `evidence/sources/sheth-et-al-2012-simulations-of-credits-concept-with-user-input-for-collaborative-air-traffic-management.pdf`. The text on PDF p. 11 says "schedule integrity with a score of 4.5 was the most important flight parameter out of 10 considered here. Crew connection was the next importance parameter." Two things from the same page that the report must carry: the results "are an aggregate of all the scenarios", which is why there are 17 responses from five dispatchers, and "the average rating values are not statistically significant." The PDF is not yet registered (no bib entry, no ledger row), so it cannot be cited in the report until it is.
- **Emissions (note 4.12).** Leads from a web search, not opened and not registered:
  - ICAO Carbon Emissions Calculator methodology, version 13 (`icec.icao.int`). Secondary sources say it applies 3.16 kg of CO2 per kg of fuel; the search did not confirm the number in ICAO's own text.
  - An ICAO document on CORSIA costs from its periodic review (`icao.int`, "CAEP CORSIA Periodic Review ... Focus on Costs").
  - Trade-press reports of CORSIA credit prices between about 10 and 22 dollars per tonne of CO2 during 2025 and 2026. These are not ICAO figures and should not be cited as such.

## Points where I differ, for the owner to weigh

- **Note 1.4, heavy against light.** The sentence was wrong as written, because it was unconditional. The conditional version is what `mori2022massCruise` Fig. 1 supports: the cost-optimal altitude is lower for a heavier aircraft of the same type. Whether descending helps or hurts the heavy aircraft depends on where level L sits against that aircraft's own optimum. The note's reason (more drag at the lower altitude) is one side of the trade; lower induced drag is the other. I removed the sentence and left the question to the truth model, which is where it can be settled.
- **Notes 1.2 and 1.3, two different types.** The draft assumed the crossing pair could be the same type, so that only weight told them apart. A B777 and a 737 differ by type, and case B already knows the type. A B777 also burns several times the fuel of a 737, so "move the 737" may be the cheaper answer on type alone. What case C adds over case B then narrows to two things: how far each aircraft is from its type's nominal weight (which decides whether the climb is open), and the cost index. This may be what the owner intends. It should be a deliberate choice, because it changes what "C minus B" measures.
- **Note 2.3, sharing a level.** For two crossing aircraft to be at the same level under the east-odd, west-even practice in the note, both tracks have to fall in the same half of the compass. That constrains the crossing angle in the scenario figure.
- **Note 4.2, crossing a slot boundary.** One conflict resolution costs a flight seconds to a couple of minutes. For that to cross a 10 to 15 minute boundary, the flight has to be within that margin of the boundary already. So the scenario has to state AC1's delay on entry, and the result will depend on that number.
