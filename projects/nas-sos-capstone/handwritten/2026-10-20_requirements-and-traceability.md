# Handwritten notes on requirements-and-traceability.md, 2026-10-20 print (transcribed 2026-10-20)

Transcribed by Claude from `2026-10-20_requirements-and-traceability.pdf` in this folder: a 14-page print of `knowledge/models/requirements-and-traceability.md` with digital ink on pages 1 to 5, 7 to 11 and 13. Pages 6, 12 and 14 have no markup.

Wording in quotes is the handwriting. "Kind" uses the meanings of `2026-10-13_main.md`: change, strike, move, question, check, do. The last column says what was done on 2026-10-20; the decision is D-031. "From a question" means the owner's note was a question that suggested wording, and the owner chose (in session) to have it applied and flagged for confirmation.

## Page 1 (section 2, the test)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 1.1 | "Is this a fair test? How do I convey that the reqts I identify are a subset of those that would otherwise be created w/o D-007?" | Section 2. | question | Answered by D-031: the full set is kept in the model, and the study's subset is the `inStudy` tag. Said in section 6 of the requirements file. |

## Page 2 (section 3)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 2.1 | ", so that the flight is flown within safety and capacity limits" struck. | SN-AIR-01 | strike | Applied. |
| 2.2 | "...clearances & ..." inserted before "instructions". | SN-CRW-03 | change | Applied: "only trajectory clearances and instructions". |

## Page 3 (section 3, regulator and environment)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 3.1 | "How is this relevant via D-007? I think I need to remove." | SN-GOV-01 | question | Kept and tagged `background` (owner's choice in session). |
| 3.2 | "This is currently in my cost, but not in my stakeholders. They're treated as background/input." | SN-ENV-01 | change | Tagged `background`. |

## Page 4 (section 4, clearance)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 4.1 | The Measure of SLR-CLR-13 circled: "TBD". | SLR-CLR-13 | change | Measure set to TBD. HLR-ATC-05 keeps the experiment's scoring measure. |

## Page 5 (section 4, information)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 5.1 | "sector controller" circled: "modeled?" | SLR-INF-01 | question | Not as its own part: `airspaceManagement.atc` stands for the controllers. Recorded in the rationale; open question. |

## Page 7 (sections 7 and 8)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 7.1 | Item 1 (SLR-CLR-15) ticked: "ok". | SLR-CLR-15 | check | Accepted as worded. |
| 7.2 | Item 2 (the measure on SLR-CLR-13): "still TBD". | SLR-CLR-13 | change | See 4.1. |
| 7.3 | "I think I need to keep all stakeholder requirements, even those I won't be keeping... drop at the sub-system/HLR level." | Sections 6 and 8. | change | D-031: 17 stakeholder and 19 system requirements restored, tagged `outOfStudy`, no HLRs. The owner chose "the stakeholder requirements and their system requirements" in session. |

## Page 8 (section 11, flight crew)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 8.1 | "Draft written by Claude ... Not reviewed by the owner." struck. | Section 11 header. | change | Now "hand-reviewed by the owner on 2026-10-20". |
| 8.2 | "when the flight management system's predictions show the flight would be better off with it" circled: "Why call out FMS?" and "When deemed beneficial by the crew, optionally in collaboration w/ dispatch." | HLR-CRW-03 | change | Applied. |
| 8.3 | Beside HLR-CRW-04's measure: "Period?" | HLR-CRW-04 | change | See 9.1. |

## Page 9 (section 11, flight crew and flight operations)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 9.1 | "that moves the estimated arrival time by more than 5 minutes or takes the fuel predicted at the destination below the required reserve" struck. | HLR-CRW-04 | strike | Applied; the sentence ends at "trajectory". Measure removed; the 5 minutes stays on SLR-INF-07. |
| 9.2 | "EPP gives weight, if available." "Dispatch has final fuel #s I believe & planned burn." | HLR-CRW-05 | check | Recorded in the rationale. Wording not changed. |

## Page 10 (section 11, flight operations)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 10.1 | "Also it's performance model. Abstract from CI & talk about a measure of the relative cost of flight time?" | HLR-OPS-05 | question | From a question: "current gross weight, performance model, relative cost of flight time and connection priority". `AirlinePerformanceShare` not changed. |
| 10.2 | "or flight safety." | HLR-OPS-06 | change | Applied: "the arrival time, the fuel at the destination or flight safety at risk". |

## Page 11 (section 11, air traffic control)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 11.1 | "show" circled: "inform of". | HLR-ATC-03 | change | Applied. |
| 11.2 | "aircraft" circled: "systems?" | HLR-ATC-05 | question | From a question: "the systems involved". The parent SLR-CLR-13 still says "aircraft". |
| 11.3 | "Confirm ATC 'unable'. I think it's actually deny/negative." | HLR-ATC-07 | check | Checked against the held summary of JO 7110.65BB 2-1-18: APPROVED, approved with restrictions, UNABLE, STAND BY. "Unable" kept. The order itself was not re-read. |
| 11.4 | "Why not use the best information available to them?" | HLR-ATC-08 | question | From a question: "the best information available to it about each flight, including ... the airline has shared". |

## Page 13 (section 11, aircraft, and the parts with no requirement)

| # | Note | Touches | Kind | Done |
|---|------|---------|------|------|
| 13.1 | HLR-ACF-05's "current gross weight and ... to the airline operations center" circled: "Need one HLR for ADS-B data... the GW, CI & Perf data can come from the flight and/or dispatch or the same computer system, whether the airline's or ATC's." | HLR-ACF-05, new HLR | change / question | New HLR-ACF-06 (ADS-B Out broadcast, from SLR-CLR-01 and SLR-CLR-02). HLR-ACF-05 from a question: "available for sharing ... whether through the airline's systems or air traffic control's". |
| 13.2 | Beside "Parts of the five systems with no requirement here": "Carry these concerns forward." | Section 11 | do | Kept as the list of what a fuller model would add; a note says which parts now carry out-of-study requirements. |
