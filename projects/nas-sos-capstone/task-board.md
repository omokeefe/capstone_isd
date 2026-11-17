# Task Board

_Cross-session focus state only. The full task checklist lives in
`to-do-list.md` — don't duplicate it here. Update this file per
`../../workflows/session-signoff.md` at the end of each session. Keep entries here
terse and current-state-only — narrative reasoning belongs in the daily
`journal/`, not here._

**Last updated:** 2026-11-17, evening (at the owner's request, mid-session). Entries from September and October that were done or superseded were removed; their history is in the journals and git (`fd7ac22` has the previous version). Last sign-off: `journal/2026-11-05.md`.

## Current phase

**Turn 6 of the nine-turn plan (Nov 16 to 22; D-016): corrections only.** Presentation **Thu Nov 19, 10 AM** (upload by Fri Nov 20). Review #3 **Sun Nov 22** (the owner settled the option 11-05; which option is not recorded). Model freeze Nov 29. Final report Dec 13.

## Active

- **Presentation (Track C).** Working deck: `report/presentations/503 Project Presentation - O'Keefe (210055806) - NAS SoI.pptx` (in git; read as saved 11-16 21:38). Slides 1 to 7 are the owner's: title, overview, scope, methodology, preliminary results, benefits, thank you. Slide 8 is blank; slides 9 to 14 are the template's examples, still to delete. Slide 5's results table shows C and D at 1+1 calls, and the notes on slides 5 and 6 say every case takes the same number of radio calls. Since D-048, Table 8 has C and D at 1+0. `speaker-notes.md` already has the corrected wording for slide 5. See journal 2026-11-17.
- **Report (Track C).** The owner's 11-14 markup is applied (D-048); 87 pages. The owner's open items are listed at the end of `handwritten/2026-11-14_main.md`. `\aidraft` passages for the owner to rewrite: Section 2.1's first paragraph, Section 2.2, and the Section 3.7 additions. The owner is drafting the Executive Summary (first paragraph, uncommitted 11-17). Still open from Report #1: the annotation-coverage claim, citation spot-checks against skimmed-only sources, and the 1998-dollar disruption-cost figure.
- **Experiment (Track B).** Sixth run (D-047), scored with the aircraft staying at a better level (D-048). A and B choose O10, C and D choose O4. B − A = 0; C − B = −28.8 kg, 70 percent. Calls: A and B 1+1, C and D 1+0. Turn 6 item: what the result shows and does not show. Low-cost-index run is "if time".
- **Requirements (Track A).** 30 SN / 42 SLR / 31 HLR. Open: the measure of SLR-CLR-13 (owner, TBD). Table 5 lists HLR-OPS-05 only (D-046).
- **Model (Track A).** The whole folder passed `syside check` on 11-14. Open: the owner's hand review of the sequence and the O4 hand check; whether the three drafted item defs (G4) move to the definitions; Turn 2's FMS → AOC and ATC → crew interface defs (not in the model); Turn 5's grading of the airspace IBD and thread links, and `tools/check_model.py` (does not exist yet).
- **Older diagram items, not re-checked since October.** No written reason for each context-diagram link; IBD links not evidence-graded; the nominal-flight activity has no swimlanes and placeholder sub-actions. Details in `knowledge/questions/open-questions.md`, "Diagram review" and "Nominal operations activity model".
- **Sources.** Every file in `evidence/sources/` is registered. Confirm the GtWR document number before citing.

## Blocked

- **SysML diagram renders, since 2026-11-10.** `tools/render_sysml_diagrams.py` fails because Windows blocks the compiled modules of Syside's diagram drawer: "An Application Control policy has blocked this file" (most likely Smart App Control). The report's figures stay at their last render, so Figure 12 predates D-048. The owner unblocks it (Windows setting or a Syside update); needed before the model freeze on Nov 29. See journal 2026-11-17.

## Backlog / ideas

- Extract today's `assistant/` additions (personas, `session-tagup`, the journal) into a
  reusable `project-ai-interaction/` template folder for other projects — see
  `journal/2026-08-29.md` ("Idea / TODO" entry, 17:48) for the full writeup and open
  design questions. Partially addressed by the 2026-09-05 reorg (workflows/personas/
  templates are now workspace-level, ready to be reused if a second project starts) —
  revisit whether a separate portable template folder is still wanted, or whether "reuse
  this repo's structure" is now sufficient. No target date.

## Next session priority

Presenting Thu Nov 19, 10 AM; upload by Fri Nov 20; Review #3 Sun Nov 22. See journal 2026-11-17.

1. Deck: delete slides 8 to 14; bring slide 5's table and the notes on slides 5 and 6 to the 1+0 calls (copy from `speaker-notes.md`); rehearse to time.
2. Q&A on slide 6's 70 percent: 28.8 kg of fuel, about 72 USD, in one conflict; B − A = 0, so the gain comes from the shared information.
3. Before Review #3: rewrite the `\aidraft` method passages; confirm what the chosen Review #3 option needs.
