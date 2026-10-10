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
