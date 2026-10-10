# Project plan proposal (2026-10-10)

**Status: proposal, not adopted.** Drafted by Claude on 2026-10-10 at the owner's request. `to-do-list.md` stays the only task checklist until the owner accepts, changes or rejects this. This file has no checkboxes on purpose, so it cannot become a second checklist. Every item marked **Decide** is the owner's call.

## 1. Why the current plan no longer fits

`to-do-list.md` is 16 sections in a fixed order (research, then architecture, then optimization, then the paper), each with one completion date taken from the August proposal (`prework/ISD 503 Submittal.pdf`). The work since late September has not run that way. Three things show it:

- The same diagram is revised several times. The context diagram was due 2026-09-07 and has been through three decisions (D-009, D-010, D-012). Its checkbox is still open, so every status check reports it as "slipped" when it is in fact improving.
- The experiment, the model and the report now move together. On 2026-10-09 one hand review changed the experiment (D-014), added a source, and added placeholders to three report sections in the same sitting.
- Several sections describe work that later decisions replaced. Section 11 asks for a weighted sum of objectives and section 12 for weight sweeps and Pareto fronts; D-013 item 2 chose to state impacts side by side with no weighted sum.

The proposal below keeps the graded course dates fixed and reorganizes everything else around how the work is actually done.

## 2. The working loop

This is the loop already in use, written down so the plan can count turns of it instead of one-time completions:

1. Draft the artifact (a diagram view, an experiment table, a report section skeleton).
2. Print it and mark it up by hand.
3. Transcribe the notes into `projects/nas-sos-capstone/handwritten/`, one line per note with what was done about it.
4. Apply the notes that are directions. Log each reversal or new choice in `decisions/decisions-log.md`.
5. Re-render the diagram with a revision suffix (`-rev2`, `-rev3`) and keep the earlier render, because the marked-up scans refer to it.
6. Carry the result into the report: a figure, a table skeleton, or a `\plantodo` note naming what the owner still has to write.
7. Write down anything learned that changes how the next turn is done (section 6).

## 3. Four tracks that run in parallel

### 3.1 How finished an artifact is

Each diagram and each experiment table is given one of five states. A state is recorded in `to-do-list.md` beside the artifact, in place of a single checkbox.

| State | Meaning | Test |
|---|---|---|
| 0 | Not started | No file |
| 1 | Drafted | Renders or reads without errors |
| 2 | Hand-reviewed | A transcription exists in `handwritten/` and its directions are applied |
| 3 | Evidence-graded | Every link or number carries a source, an `[SME]` mark, or a stated assumption |
| 4 | In the report | Body text written by the owner refers to it |

### 3.2 Track A: diagrams and model

Current states are read from `task-board.md` and the journals of 2026-10-06 to 2026-10-10. Targets are proposals.

| Artifact | File or view | Now | By Oct 25 | By Nov 22 | By Dec 13 |
|---|---|---|---|---|---|
| Context diagram | `cameo_models/nas_context_diagram.sysml`, `diagram-systemContext-rev2.png` | 2 | 4 | 4 | 4 |
| Definitions tree (block definition diagram) | `cameo_models/nas_sysml_package_definitions.sysml` | 2 | 2 | 3 | 4 |
| Aircraft internal block diagram, default view | `cameo_models/nas_ibd_aircraft.sysml`, view `aircraftIbd` | 2 | 3 | 4 | 4 |
| Aircraft internal block diagram, detail view | same file, view `aircraftIbdDetail` | 2 | 2 | 2 | appendix only |
| Airspace management internal block diagram | `cameo_models/nas_ibd_airspace_management.sysml` | 1 | 1 | 3 | 4 |
| Nominal operations activity diagram | `cameo_models/nas_activity_diagram-nominal_ops.sysml` | 1 | 1 | 2 | 4 |
| Sequence diagram of the experiment's conflict resolution (controller, crew, FMS, airline operations center) | new | 0 | 1 | 3 | 4 |
| One trace thread: stakeholder need, objective, requirement, system, exchange, experiment measure | `cameo_models/requirements_*.sysml` | 0 to 1 | 1 | 3 | 4 |

Three recommendations sit inside this table, each a **Decide**:

- **The sequence diagram is drawn for the experiment's exchange only**, not for every critical exchange. It is the one diagram that shows where weight and cost index would have to travel, so it joins the model to the experiment.
- **Traceability is one complete thread, not "complete allocation".** The August plan asks for five full trace layers by 2026-10-12, with nothing started. One thread, the one the experiment exercises, can be finished and defended.
- **A model freeze on 2026-11-29.** After that date no new parts or links are added; only corrections and renders. The 2026-10-08 session added about 45 mostly empty part definitions, and the 2026-10-09 welcome entry already asked for no new parts until the existing links are graded.

### 3.3 Track B: experiment

The source files are `knowledge/models/experiment-definition.md` and `knowledge/models/experiment-options-and-scoring.md`. The steps, in order:

1. Decide the central claim (`experiment-definition.md` §1). The 2026-10-09 hand-review notes 1.2, 2.1 and 4.1 read as an answer, but the owner has not confirmed that reading.
2. Fix the scenario: heavy and light weights for the B737-900 MAX, the crossing pair's level above FL350, and how late the late aircraft is (open items in D-014 and D-015).
3. Do the two checks before building (`experiment-definition.md` §9): the size of the effect by hand, and the information check by hand on three or four context-diagram decisions.
4. Choose and build the scoring model that gives fuel flow from weight, altitude and speed (`experiment-definition.md` §7). `simulation/vehicle_dynamics.py` uses a constant fuel flow and cannot do this yet.
5. Run cases A to D on the base scenario and fill the outcome tables.
6. Run one variation (a second weight spread, or the second aircraft type kept back in D-015).
7. Write what the result does and does not show, including the limits already listed in `experiment-definition.md` §10.

Step 4 is the largest schedule risk in the whole plan. Proposed guard: if the scoring model is not giving believable numbers by 2026-11-08, fall back to a lookup table built from a published relation (`mori2022massCruise`) and state that as a limitation. This also keeps the experiment a capability inside the architecture and not a flight-performance modeling project, which is the drift the project's working assumptions warn about.

### 3.4 Track C: report

The report is built in dated cuts. Each cut is whatever is at state 4 on that date, plus honest placeholders for the rest.

| Cut | Date | What it must contain (from `prework/course-info-canvas.md`) |
|---|---|---|
| Interim Report #2 | Sun 2026-10-25 | Introduction; Assumptions and Methodology; Results and Discussion (preliminary); References. Word format to the adviser, after a review meeting, then Progress Update #2 on Canvas. |
| Peer presentation | slot 2026-11-17 to 19, upload by Fri 2026-11-20 | About 10 minutes, course template. |
| Project Review #3 | Sun 2026-11-22 | Short progress update, or a final-report draft with Results and Discussion. The adviser chooses. |
| Draft to adviser (optional) | about Sun 2026-12-06 | Whole report. |
| Final Report #4 and synopsis | Sun 2026-12-13 | All sections, adviser first, then Canvas. |

The working agreement on authorship is unchanged: Claude adds skeletons, figures, captions marked as AI-drafted and `\plantodo` notes; the owner writes the prose.

### 3.5 Track D: evidence on demand

A source is read when a diagram link or an experiment number needs it, and is registered when it is used. This is how the TASAR study and the ICAO calculator entered on 2026-10-09. It replaces reading the section 2 to 4 papers in list order. The August metric for the literature milestone, "10 to 20 papers categorized", is already met: `evidence/source-register.md` has 75 rows.

## 4. Calendar: nine one-week turns

Each turn ends on a Sunday. Each has one goal per track and one exit test. Today is Saturday 2026-10-10.

| Turn | Dates | Diagrams and model | Experiment | Report and course | Exit test |
|---|---|---|---|---|---|
| 1 | Oct 10 to 18 | Write the reason for each context-diagram link (who receives it, who acts, which paragraph). Grade the default aircraft diagram's links. | Steps 1 to 3: claim, scenario numbers, both hand checks. | Adviser meeting held. Propose a current-state metric in writing and confirm whether a second review meeting is needed before Interim Report #2. | The central claim is logged as a decision. |
| 2 | Oct 19 to 25 | Split or resize the wide aircraft diagrams so they can be read on a page. Regenerate renders from the current text. | Write the experiment design as fixed. The two hand checks are the preliminary results. | **Interim Report #2.** Owner writes Assumptions and Methodology and preliminary Results. Ask the adviser which Review #3 option they want. | Report sent to adviser; Canvas update done. |
| 3 | Oct 26 to Nov 1 | Decide the `atc` umbrella question on the airspace diagram. Draft the sequence diagram. | Step 4: choose and start the scoring model. | Apply the adviser's comments. | Scoring model reproduces one published figure. |
| 4 | Nov 2 to 8 | Hand-review the sequence diagram. Draft the trace thread. | Step 5: run cases A to D. **Fallback decision on Nov 8.** | Fill the two results table skeletons in `report/sections/04_results_discussion.tex`. | Outcome tables have numbers. |
| 5 | Nov 9 to 15 | Grade the airspace diagram and the trace thread. | Step 6: one variation. | Build the presentation from the diagrams and the tables. | Slides complete in the course template. |
| 6 | Nov 16 to 22 | Corrections only. | Step 7: what the result shows and does not show. | **Presentation** and **Project Review #3.** | Both submitted. |
| 7 | Nov 23 to 29 | Final review of every diagram going in the body. **Model freeze Nov 29.** | Closed, except errors. | Results and Discussion in full; evaluation of the architecture. | No diagram in the body is below state 3. |
| 8 | Nov 30 to Dec 6 | Final renders. | Closed. | Recommendations, Impact, Conclusions, Executive Summary, GenAI citation. Draft to adviser. | Whole draft sent. |
| 9 | Dec 7 to 13 | None. | None. | Adviser's comments, synopsis, **Final Report #4.** | Submitted. |

## 5. What happens to each section of `to-do-list.md`

Each row is a **Decide**. "Future work" means the item is named in the report's limitations or future-work text and not done.

| Section | Proposal | Reason |
|---|---|---|
| 1 Research framework | Closed. Move its four open report fixes (annotation-coverage claim, citation spot-checks, 1998-dollar figure, scenario wording) to Track C. | They are edits to report text. |
| 2 to 4 Literature review, per-paper checklists | Replace with Track D. Keep the four traffic-flow source leads in section 4 only if the experiment or a graded link needs them. | About 250 unchecked boxes that no current work depends on. |
| 5 Nominal-flight concept of operations | Shrink to the experiment scenario plus the activity diagram already started. The hub-to-hub draft in `knowledge/models/conops-hub-to-hub-trajectory-cost.md` is still unreviewed. | The experiment is an en-route sector, not a full gate-to-gate flight. |
| 6 Alternative decompositions | One paragraph in the report on why this decomposition was kept (D-002, D-007), the rest as future work. | Building five more decompositions does not fit before 2026-12-13. |
| 7 Responsibility analysis | Shrink to the decisions on the experiment's thread: who decides, who holds the information, who carries it out. | This is the same question as the information check in `experiment-definition.md` §1. |
| 8 Objectives and costs | Done. | |
| 9 Local against system-level conflicts | One conflict analyzed in full (the experiment's); the other eight listed as future work. | |
| 10 SysML architecture | Becomes Track A. | |
| 11 to 12 Optimization study and simulation | Becomes Track B. Drop the weighted sum, weight sweeps and Pareto fronts. | Superseded by D-013 item 2. |
| 13 Simulation back to the model | Becomes the one trace thread in Track A. | |
| 14 Demonstration | Becomes the presentation and the Results section. | |
| 15 Verification | Becomes "every diagram in the body reaches state 3" plus the limitations list drawn from the lessons file. | |
| 16 Paper | Becomes Track C. | |

## 6. Lessons learned

Nothing in the repository collects these today. Proposed:

- **One file,** `projects/nas-sos-capstone/lessons-learned.md`, one dated entry per lesson with four fields: what happened, what was learned, what changes from now on, and where it appears in the report.
- **Captured at sign-off.** One added question in `workflows/session-signoff.md`: "Did anything this session change how the work should be done?" Most sessions will answer no.
- **Reviewed at the end of each weekly turn,** when the next turn's goals are set. A lesson that changes the plan changes `to-do-list.md` in the same sitting.
- **Used in the report twice.** The course's learning objectives ask the student to reflect on the validity of the tools used, and `experiment-definition.md` §1 says the cost side of the MBSE claim is the modeling time recorded in the journal and git history. The lessons file is the record both draw on.

Candidate first entries, taken from the journals and decisions log. The owner should restate or discard each one; they are Claude's reading.

| Date | What happened | Candidate lesson |
|---|---|---|
| 2026-10-08 | The owner could not defend several elements on the printed diagrams (D-012). | A print marked by hand finds what review on screen missed. Structure the owner cannot defend is removed, not hidden. |
| 2026-10-08 | About 45 part definitions were added in one session, most of them empty and none graded. | Model structure can grow faster than its evidence. Grade before adding. |
| 2026-10-08 | Diagram lines could not be read without names (D-012 item 6). | A rendering rule belongs in `knowledge/models/sysml-diagram-rendering.md` the day it is found. |
| 2026-10-09 | The 105,000 lb weight for the light aircraft turned out to be near the type's empty weight (D-015). | Numbers given from experience still get one check against a published figure. |
| 2026-10-09 | A source's author was first taken from a web search summary and was wrong. | Author and date come from the document itself. |
| 2026-10-09 | Two aircraft types would have let the nominal-model case tell the pair apart, hiding the effect being measured (D-015). | Change one thing at a time in the base scenario; keep the rest as variations. |
| 2026-10-10 | The aircraft diagrams are about 6:1 wide and unreadable at page size; the renders were ten minutes older than the model text. | Decide the page a diagram must fit before drawing it, and render last. |
| Sept to Oct | Dates from the August proposal were reported as slipped while the artifacts were being revised. | A plan for iterative work should count review turns. This proposal is the response. |

## 7. Decisions needed to adopt this

1. Accept, change or reject the five states in section 3.1 as the replacement for single checkboxes on diagrams.
2. Accept, change or reject each row of section 5. Rows 2 to 4, 6 and 11 to 12 remove the most planned work and change what the August proposal promised. The adviser's endorsement of a scope that varies with schedule (reported 2026-10-10) covers this in general; whether to name the specific cuts to him is the owner's call.
3. Accept or move the two dated guards: the scoring-model fallback on 2026-11-08 and the model freeze on 2026-11-29.
4. Accept the lessons file and the sign-off question in section 6.

If adopted, the change is made in `to-do-list.md` itself: sections regrouped under the four tracks, dropped items moved to a "Future work" section at the bottom and not deleted, and the nine turns added at the top. `task-board.md`, `index.md` ("Current state" and "Next actions" are out of date) and the timeline subsection of `report/sections/02_introduction.tex` would follow. It is one commit and can be reverted.

## 8. Risks this plan does not remove

- **The central claim is still undecided,** and turn 1 depends on it. It has been carried since 2026-10-05.
- **The current-state metric has no answer yet.** The adviser meeting has happened (reported by the owner 2026-10-10): the adviser endorsed the project, its focus, and a scope that varies with schedule and availability, which supports the cuts in section 5. The owner did not report an answer on the metric, so it is the owner's to propose in Interim Report #2. Whether that meeting also counts as the review meeting Interim Report #2 asks for is not confirmed.
- **The scoring model** (section 3.3, step 4) has no chosen source and no code.
- **Fifteen days to Interim Report #2** with sections 3 and 4 of the report still placeholders. The plan answers this by making the two hand checks the preliminary results, which needs no code.
