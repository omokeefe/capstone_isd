# Handwritten notes on the experiment one-pager (transcribed 2026-10-09)

Transcribed by Claude from `experiment-definition-hand_review.pdf` in this folder: a two-page print of `knowledge/models/experiment-definition.md` (printed 2026-10-09, 9:56 AM) with red ink notes and yellow highlighter.

Nothing here has been applied to the one-pager. Wording in quotes is the handwriting; anything in square brackets is my guess at an unclear word. "Kind" is my reading of the note:

- **change**: the note says what the one-pager should say or contain.
- **question**: the note asks, and the owner decides.
- **check**: the note asks for a number or a source to be verified.
- **agree**: the note endorses what is printed.

The "Touches" column says which part of the one-pager the note points at and, where the repository already holds something relevant, where it is. I did not open any source PDF to do the checks; the pointers are to notes already in the repository.

## Red ink notes

### §1 Central claim

| # | Note | Touches | Kind |
|---|------|---------|------|
| 1.1 | "(about 27 gallons and 2.3 minutes per flight in NASA's TASAR study)" circled, with "Fact check." | The effect-size figure in the "Alternative" paragraph. The repository's note on the TASAR paper (`evidence/prior-work-experiment-definition/prior-work-writeup.md`, line 411) gives this figure for one case type only, the "more wind-optimal trajectory" case; the rare "reroute initiative has ended" case gave 103 gallons and 7.8 minutes. So the one-pager states a per-case figure as if it were the study's overall figure. **Checked 2026-10-09 against the paper (p. 12), which is now registered as `engility2014tasarAlaska`:** the figure is correct and is the typical case (the other two cases were fewer than 5 percent of flights). The convective weather case gave 12 gallons and 1.3 minutes, and the earlier study it builds on reported about 80 gallons and 3.6 minutes for network carriers (p. 6). The one-pager now names the case and the range. | check |
| 1.2 | Beside "What the proposed claim lets the project say about MBSE": "I don't want this to be 'assemble model w/ less than perfect understanding & see if gaps exist'. I want to demonstrate the value of MBSE in automation by 'simulating' lo-fi rules of thumb easily replaced by hi-fi models. Why is that not reflected here?" | The proposed central claim (the decision-by-decision information check) and its MBSE paragraph. The note rejects the check as the main result and names a different one: a simulation in which low-fidelity rules of thumb are swapped for high-fidelity models. This is the first "Decide" item. | change |

### §2 The gap being measured

| # | Note | Touches | Kind |
|---|------|---------|------|
| 2.1 | "Here... gap's measured & obvious. Coppenbarger & SESAR already document the opportunity!" | The whole of §2. The note says the gap in §2 was not found by the model: prior work already documents it. That undercuts the proposed claim in §1, which counts as a benefit only the gaps "the owner did not already know". | change |

### §4 The one thing that differs

| # | Note | Touches | Kind |
|---|------|---------|------|
| 4.1 | "This holds true w/ my written comments & is a primary thrust I want to demonstrate." An arrow points at the last sentence of §4. | "B against A is the value of automation. C against B is the value of the information exchange, which is the architecture claim." The A/B/C comparison stays, and the note promotes it from "one worked example" to a main result. Read with 1.2. | agree |

### §6 Metrics

| # | Note | Touches | Kind |
|---|------|---------|------|
| 6.1 | Beside the airline cost bullet: "Say fuel = $ & emissions, so has increased value." | "Airline cost per aircraft: fuel plus time weighted by cost index". The note asks for fuel to be stated as both money and emissions, so a fuel saving counts twice. The cost-index formula cited (`mori2022massCruise`, Eq. 1–3) prices fuel as money only, so emissions would need its own term or its own row. | change |
| 6.2 | Under the last paragraph: "I really like this table idea. If each option (A/B/C) is a row, then you can see the impact on optimality across levels. I think 'sector' implies ATC's score... workload... a/c & airline are obvious. System is not, though. Aggregating the other 3 w/ a weighting?" | The four-level table (aircraft, airline, sector, system). Three things: the table is kept; its rows are the cases A, B and C; the sector column is the controller's workload score. The open part is what the system column holds, with one candidate: a weighted sum of the other three. | agree, and question |

### §8 Possible results

| # | Note | Touches | Kind |
|---|------|---------|------|
| 8.1 | Beside result 3: "Workload depends on automation, though. There are the # of clearances/controls issued & there is the time/energy to devise them + the 'residual risk', which changes w/ knowledge & action. Might need D/E/F." | "A different maneuver: lower cost, more workload", and the workload metric in §6 ("instructions issued plus follow-ups"). The note splits workload into three parts: the count of clearances issued, the effort to work them out, and the risk left over afterward. Automation changes the second and third even when the first is unchanged, so result 3's "more workload" does not follow for cases B and C. "D/E/F" proposes further cases beyond A, B and C; the note does not say what they are. | change, and question |

### §9 Two checks before building anything

| # | Note | Touches | Kind |
|---|------|---------|------|
| 9.1 | "delta" in the left margin, beside the highlighted line "per 20,000 lb for a B787-8". | The effect-size sentence. I read this as a wording fix: the 20,000 lb is a difference in weight, not a weight. The repository's summary of the paper says the same thing more exactly: "roughly 1,000 ft higher for each 20,000 lb lighter, between 360,000 and 460,000 lb" (`evidence/literature-notes/summaries/4 - mori2022massCruise.md`, line 21). [My guess at intent; the margin note is the one word.] | change |
| 9.2 | Beside "The check by hand": "Create table of options... each a/c & maneuvers needed", with a sketched table. Columns: "AC 1", "AC 2", "..", "AC 4". Rows: "OPT 1" with "DES" under AC 1 and dashes under the others; "OPT 2" with "CLB" under AC 1; "[OPT 3]" with "SPD" under AC 1. | A new artifact: one row per resolution option, one column per aircraft, each cell the maneuver that aircraft is given (descend, climb, speed; a dash for no instruction). It is written beside the hand check but describes the maneuver list in §3 ("a short list of discrete maneuvers by enumeration"), which the one-pager never writes out. | change |

### §10 Known limits

| # | Note | Touches | Kind |
|---|------|---------|------|
| 10.1 | Beside the first bullet: "Along-path L.O.S. more? Check source". | "Level crossing conflicts are a minority: 36 of 256 in the U.S. data." I read "L.O.S." as loss of separation, and the note as asking whether along-path (in-trail) conflicts are the larger share. The 36 comes from `rantanen2012conflictManeuvers` per §5; the one-pager gives no citation on this bullet. | check |
| 10.2 | Beside the second bullet: "Need a cost/benefit equation per viewpoint that accounts for it!" | "Cost index understates a connection-critical flight, and dispatchers rate schedule integrity and connections above fuel". The note asks for one cost/benefit equation per viewpoint, with connections and schedule in the airline's. This ties to the four-level table in 6.2: each level needs its own stated equation. | change |
| 10.3 | An arrow at "(1 to 3 percent)": "Source?" | The misreporting figure. The repository has it: del Pozo de Poza 2012, a game-theory study, about 1 to 3 percent for misreporting cost index against 40 to 75 percent for understating time tolerance (`prior-work-writeup.md`, line 737; journal 2026-10-04). The one-pager left the citation off. | check |
| 10.4 | Under the last bullet: "SME", underlined twice. | "The ±0.04 M speed figure is still unsourced." The note grades the figure as the owner's own subject-matter knowledge. This closes the question the 2026-10-04 journal left open ("If they are from experience, grade them [SME]"). The published ranges to hold it against are already noted: a 0.025 Mach step, and -6 to +3 percent (about -0.047 to +0.023 at Mach 0.78). | change |

## Yellow highlights (no words written)

| # | Highlighted text | Section |
|---|------------------|---------|
| H1 | "does the actor who makes this decision receive the information the decision depends on?" | §1 |
| H2 | "the one that already needs something (`kirwan2001coraStrategies`)" | §5 |
| H3 | "(farthest from top of descent; not recently maneuvered)" | §5 |
| H4 | "The existing `simulation/vehicle_dynamics.py` uses a constant placeholder fuel flow, so it cannot do this as it stands." | §7 |
| H5 | "`mori2022massCruise` reports about 1,000 ft of optimum altitude per 20,000 lb for a B787-8, which is roughly 4 to 5 percent of its weight." | §9 |
| H6 | "Is 'one measured example under a model-wide check' an acceptable central claim for the capstone?" | §11 |

## Sections with no marks

§3 (scenario) has no ink or highlight. §5 and §7 have highlights only, so the two "Decide" items in §5 (which aircraft descends; what happens after the descent) and the one in §7 (the truth model) carry no written answer.

## What the notes add up to (Claude's reading, for the owner to confirm)

- **Notes 1.2, 2.1 and 4.1 together answer the first "Decide" item, and the answer is not the proposed one.** The owner wants the simulation to be a main result: it should show that low-fidelity rules of thumb can be replaced by high-fidelity models, and that sharing information (C against B) has a measurable value. The decision-by-decision check drops to a supporting role or goes.
- **One objection printed in §1 is not answered by any note.** The "Alternative" paragraph says the simulation "compares two ways of operating, so it cannot test MBSE as an engineering method". Note 1.2 says the aim is "the value of MBSE in automation", which is a claim about MBSE. The notes do not say what in the experiment shows the model did the work, as opposed to the automation or the shared data doing it. This is the question an adviser is most likely to ask.
- **Note 2.1 cuts both ways.** If Coppenbarger and SESAR already document the opportunity, the model did not find the gap, but the same prior work is also why the one-pager calls the experiment's result already studied. The notes do not say what this project's version adds to theirs.
- **Four notes ask for something to be built before the simulation:** the options table (9.2), a cost/benefit equation per viewpoint (10.2), a definition of the system-level score (6.2), and a three-part definition of workload (8.1).
