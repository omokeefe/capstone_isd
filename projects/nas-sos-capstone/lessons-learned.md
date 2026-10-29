# Lessons learned

One dated entry per lesson, four fields each: what happened, what was learned, what changes from now on, and where it appears in the report. Captured at sign-off when the answer to "did anything this session change how the work should be done?" is yes (`workflows/session-signoff.md`, step 2), and reviewed at the end of each weekly turn when the next turn's goals are set. A lesson that changes the plan changes `to-do-list.md` in the same sitting. Created 2026-10-10 under D-016.

The report uses this file twice: the course's learning objectives ask the student to reflect on the validity of the tools used, and the MBSE claim's cost side is the modeling time recorded here, in the journal and in git history.

**Status of the entries below:** the first eight are Claude's reading of the journals and the decisions log, written 2026-10-10 as candidates. **#TODO (owner):** restate each in your own words or strike it; nothing here goes into the report until that is done.

## 2026-10-08 — Review on paper finds what review on screen missed

- **What happened:** the owner could not defend several elements on the printed diagrams (D-012). Structure the owner could not defend was removed, not hidden.
- **What was learned:** a print marked by hand is a different review from scrolling a render. The hand finds the box with no reason behind it.
- **What changes:** every diagram and table goes through one printed hand review before it reaches state 3 (D-016).
- **Where in the report:** Section 3, methodology (the working loop).

## 2026-10-08 — Model structure can grow faster than its evidence

- **What happened:** about 45 part definitions were added in one session, most of them empty and none graded.
- **What was learned:** adding parts is cheap and grading links is not; the gap between the two is where a model stops being defensible.
- **What changes:** grade before adding. No new parts off the thread until the thread's links are graded; model freeze 2026-11-29.
- **Where in the report:** Section 3, methodology; Section 6, limitations.

## 2026-10-08 — A rendering rule belongs in the rendering note the day it is found

- **What happened:** diagram lines could not be read without names (D-012 item 6); the cause and fix (`comment about` instead of a `doc` body) were found the same day.
- **What was learned:** tool behaviour that is not written down is re-derived at the next render.
- **What changes:** `knowledge/models/sysml-diagram-rendering.md` is edited in the session that finds the rule.
- **Where in the report:** Section 3, tool reflection.

## 2026-10-09 — Numbers from experience still get one check against a published figure

- **What happened:** the 105,000 lb weight for the light aircraft was close to the type's empty weight (D-015).
- **What was learned:** an [SME] figure can be wrong by a type; the check costs minutes.
- **What changes:** every [SME] number in the experiment is held against one published limit (OpenAP's type data, D-017) before it is used.
- **Where in the report:** Section 3, assumptions.

## 2026-10-09 — Author and date come from the document itself

- **What happened:** a source's author was first taken from a web search summary and was wrong.
- **What was learned:** search summaries are leads, not citations.
- **What changes:** `evidence/source-register.md` rows are filled from the PDF's own title page.
- **Where in the report:** References (method note, if any).

## 2026-10-09 — Change one thing at a time in the base scenario

- **What happened:** two aircraft types would have let the nominal-model case tell the pair apart, hiding the effect being measured (D-015).
- **What was learned:** a scenario that varies two things at once cannot attribute the result to either.
- **What changes:** one type in the base scenario; the second type is a variation.
- **Where in the report:** Section 3, experiment design.

## 2026-10-10 — Decide the page a diagram must fit before drawing it, and render last

- **What happened:** the aircraft diagrams are about 6:1 wide and unreadable at page size; the renders were ten minutes older than the model text.
- **What was learned:** a view's expose and filter decide its shape; the page decides what the view may expose.
- **What changes:** each report figure is a view designed for its page; `tools/render_sysml_diagrams.py` runs at every welcome so renders cannot lag the text.
- **Where in the report:** Section 3, tool reflection; appendix figure captions.

## 2026-09 to 2026-10 — A plan for iterative work should count review turns

- **What happened:** dates from the August proposal were reported as slipped while the artifacts were being revised.
- **What was learned:** a one-pass checklist cannot describe work that goes round a loop.
- **What changes:** artifact states and weekly turns replace single checkboxes (D-016); "slipped" is redefined in `personas/project-manager.md`.
- **Where in the report:** Section 1.6, project timing; Section 3, methodology.

## 2026-10-20 — Scope by tagging, not by deleting

- **What happened:** two hand reviews cut the requirements to the studied decision by striking what did not bear on it (D-020, D-021). On the third review the owner asked how to show that the study's requirements are a subset of what the NAS would carry, and restored the struck ones, tagged out of study, with the cut made at the HLR tier (D-031).
- **What was learned:** deleting out-of-scope requirements makes the scoping invisible; a reviewer cannot see what was left out or why. A scope tag keeps the full set and makes the boundary a traceable property. The first draft had never been committed, so restoring it meant reading text back off the marked-up prints.
- **What changes:** out-of-scope requirements are tagged (`studyScope`), not deleted; drafts that may be cut are committed before a hand review, so struck text stays in git.
- **Where in the report:** Section 2, methodology (requirements and scoping); the requirements appendix.


## 2026-10-28 — An actor is outside the subject

- **What happened:** the first idea for a use case diagram drew the flight crew, with the captain and first officer under it, as actors of the NAS (D-035).
- **What was learned:** an actor acts on the subject from outside it. The crew is a modeled system inside the NAS (D-007), so it cannot be an actor of the NAS. A use case diagram shows one actor as a kind of another (generalization), not as part of it; composition belongs in the BDD. With the airline also inside the NAS, the passengers are the primary actor of "operate scheduled flight".
- **What changes:** before drawing a use case, name the subject, then check every actor against the D-007 boundary.
- **Where in the report:** Section 2, methodology (modeling method); the use case figure's text.

## 2026-10-28 — A constraint is not an actor

- **What happened:** the regulator and the military were proposed as actors of "fly en route" because they set up the environment the flight flies in (D-035).
- **What was learned:** an actor interacts with the subject to get something of value. The regulator does not use the NAS; it constrains it, and that is already modeled as a requirement (SN-GOV-01, background). The military does use the airspace, for its own goal, so it is an actor, but of its own use case (special use airspace, out of study).
- **What changes:** a party that only sets rules is modeled as requirements or constraints; a party is an actor only if it uses the subject for a goal of its own.
- **Where in the report:** Section 2, methodology; the use case figure's text.

## 2026-10-28 — A sequence diagram tests the structure

- **What happened:** connecting the planned behavior diagrams to the BDD and IBDs raised the question of what ties them together (D-035).
- **What was learned:** every lifeline in a sequence diagram is a part from the IBDs and every message is an item carried over a connection or interface between those parts. A message with no connection under it means the IBD is missing a link or the sequence is wrong. Drawing the exchange is a check of the structure, not only a picture of the behavior. The same holds for a state machine: each transition is triggered by something a port of its owner receives.
- **What changes:** the "Resolve Conflict" sequence is drawn against the IBDs, and each message with no connection is logged as a gap to close or to justify.
- **Where in the report:** Section 2, methodology; Section 4 or 5, where the sequence diagram is discussed.

## 2026-10-28 — The tool decides part of the layout

- **What happened:** in the "Case C Conflict Resolve" sequence, Syside drew the messages in an order of its own until each was ordered explicitly, and it places lifelines left to right by first appearance in the messages, not in the order declared. The heavy aircraft landed between ATC decision support and ATC, and could only be moved by changing which message comes first (D-035).
- **What was learned:** a text-first tool trades layout control for a model that stays the source; some reading order in a diagram is the renderer's, not the modeler's. That is a property of the tool to state, not a defect of the model to work around.
- **What changes:** order every message explicitly; accept the tool's lifeline order unless it misleads, and say so in the figure's text when it matters; record each such limit in `knowledge/models/sysml-diagram-rendering.md` the day it is found.
- **Where in the report:** Section 2 or 3, tool reflection (the validity of the tools used).
