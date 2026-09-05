# Session: 2026-09-04 — literature review of 10 new references

**Tool used:** Claude Code
**To-do section(s) touched:** §1 (source register); background for §3, §4, §6, §7, §9, §10, §11-13

## What was worked on and why

The user added 10 new PDFs to `references/` (none yet in the source register) and asked
to "review, summarize, and score" them per the literature-review skill. Since the
literature-review skill's deep-annotation workflow assumes sources are already in the
register, ran a two-phase session instead (confirmed with the user via AskUserQuestion):
(1) a fast triage pass (`process-references.md`) on all 10 new files — bib entry, summary,
0-5 rating — then (2) deep annotation (`annotate-source.md`) on the three highest scorers,
plus a synthesis pass across those three.

Used 10 parallel background subagents to read the PDFs and extract bibliographic
metadata/ratings/duplicate-checks (reporting back as text only, no file edits), then
integrated all bib entries, summaries, and register updates centrally to avoid concurrent
edits to shared files.

## What changed

- **Files touched:** `references/references.bib` (10 new entries appended);
  `references/summaries/` (10 new summary files, rating-prefixed); `assistant/memory/
  source-register.md` (Processing Ledger: 20→30 files, distribution updated; Annotation
  status tables: 10 new rows added across §3, §4, and the MBSE/methodology table, plus a
  new "off-topic/process background" table for `jain2011pkm`; new Flags section for this
  sweep); `assistant/memory/glossary.md` (added: holon/holarchy, STAMP, IASMS,
  ISO/IEC/IEEE 42010, ARP/CRP/PRP); `assistant/memory/open-questions.md` (3 new
  housekeeping questions); `references/annotations/` (3 new deep-annotation notes:
  `romanideoliveira2026predictiveservices`, `yao2026loAltitudeSoSSafety`,
  `santana2023arpReview`); one file renamed on disk (`references/roactive Aircraft
  Turnaround...pdf` → `references/Proactive Aircraft Turnaround Buffer Optimization
  Integrating Machine Learning and Scenario Analysis.pdf`, truncated filename corrected).
- **Decisions made:** none requiring a `decisions-log.md` entry — no architecture/scope
  decision changed, though two of the three deep-annotated sources supply supporting
  evidence for the existing D-002 decomposition and the §9 myopic-optimization framing
  (see Synthesis below).
- **`Project_To-Do List.md` boxes checked:** none — these 10 sources aren't named
  entries in the to-do list's §2-§4 checklists (which name specific pre-identified
  papers), so there are no matching sub-bullets to check off. They're tracked entirely
  through `source-register.md`.

## Ratings assigned (this batch)

| Bib key | Rating | One-line reason |
|---|---|---|
| `romanideoliveira2026predictiveservices` | 4 | Real layered SoS-style predictive-services architecture inside the NAS, concrete SWIM/TFMS interfaces — strong §6/§10 fit |
| `yao2026loAltitudeSoSSafety` | 4 | Rigorous SoS-safety SLR; ISO 42010 decomposition + explicit stakeholder-conflict evidence — strong §6/§7/§9 fit |
| `santana2023arpReview` | 4 | Deep SLR on the Aircraft Recovery Problem; local-vs-system-level objective tension is directly citable for §9 |
| `younus2026fmeaOntology` | 3 | No aviation content, but citable SoS-blindness-of-FMEA argument for §7-9; ontology-design methodology background |
| `hu2024disruptionOptReview` | 3 | Complements (doesn't duplicate) `hassanDisruptionReview`; pure bibliometric/optimization-methods survey |
| `sadik2025holonicUAM` | 3 | Holonic decomposition rhymes with the capstone's intent-propagation story, but UAM-scoped, no empirical validation |
| `kontodimou2026turnaroundBuffer` | 3 | Clean predictive-prescriptive OR template and a self-declared bounded/myopic-optimization case study for §9 |
| `lu2025digitalTwinTurnaround` | 2 | Rigorous but below the capstone's core storyline (ground-service robotics, no stakeholder/objective content) |
| `wittenborg2025kbeAerospace` | 2 | Generic KBE/ontology methodology SLR, one level removed from the capstone's operational storyline |
| `jain2011pkm` | 1 | Off-topic for this register (library-science PKM survey, zero aerospace/MBSE content) |

Full detail in each source's `references/summaries/<rating> - <key>.md` file.

## Synthesis pass (across the 3 deep-annotated sources)

- **Convergent evidence:** All three deep-annotated sources (predictive services, SoS
  safety, ARP review) independently illustrate the same pattern the capstone's central
  thesis depends on — a system-level objective (efficient airspace, safety, minimized
  disruption cost) is achieved through a chain of narrower, often sequentially/locally
  optimized capabilities that eventually determine aircraft-level behavior. This
  strengthens the case that the trajectory-intent chain isn't unique to airline
  scheduling — it recurs in airspace-capacity management, safety governance, and
  disruption recovery alike.
- **Convergent evidence, more specifically:** `yao2026loAltitudeSoSSafety` (governance/
  authority fragmentation as a named SoS risk factor) and `santana2023arpReview`
  (sequential ARP→CRP→PRP local optimization) independently converge on the same
  myopic-optimization theme central to §9, from two unrelated literatures (safety
  engineering vs. operations research) — a stronger citation pairing than either alone.
- **Conflicts:** None direct between the three, but a scope-boundary tension is worth
  flagging: `yao2026loAltitudeSoSSafety`'s content is UAM/low-altitude-scoped, which the
  capstone's SOI boundary hasn't yet resolved as in/out of scope (existing open question,
  §1) — using it currently means citing it as an *analogous* SoS-safety framework, not
  direct NAS evidence.
- **Gaps:** None of the three sources — nor, per `santana2023arpReview`'s own finding,
  much of the wider ARP literature — actually *quantifies* a cross-stakeholder objective
  tradeoff; conflicts are named qualitatively (Yao) or structurally avoided by scoping
  (Santana) rather than resolved. This is genuinely open ground the capstone's own §8
  ontology work would be filling, not retreading.
- **New decomposition angle:** `yao2026loAltitudeSoSSafety`'s ISO/IEC/IEEE 42010-based
  three-facet decomposition is a standards-based precedent that could be cited alongside
  D-002 when §6 revisits/justifies the domain decomposition. Not a new decision —
  supporting evidence for the existing one.
- **New architecture-pattern angle:** `romanideoliveira2026predictiveservices`'s
  micro-service → higher-level-service → meta-service composition pattern is a reusable
  template for how a narrow Decision Support capability (like a predictive service)
  composes into a broader one — worth keeping in mind for §10 modeling of the Decision
  Support domain generally, beyond just this one source.
- No changes made to `stakeholder-register.md` — all three sources' actors/objectives map
  onto existing PESTLE rows; no new stakeholder class surfaced.

## Blocked / open

- **User decision needed:** `jain2011pkm` (1/5, off-topic) — keep in `references/` or
  remove? See `open-questions.md`.
- **User decision needed / quick check:** does the registered `delaurentis2005sosTransportation`
  PDF actually match "Understanding Transportation as a System-of-Systems Design Problem,"
  or is it the different DeLaurentis 2005 IEEE SMC taxonomy paper cited by
  `yao2026loAltitudeSoSSafety`? See `open-questions.md`.
- 7 of the 10 new sources remain at triage-only depth (not deep-annotated): `younus2026fmeaOntology`,
  `lu2025digitalTwinTurnaround`, `wittenborg2025kbeAerospace`, `jain2011pkm`,
  `hu2024disruptionOptReview`, `sadik2025holonicUAM`, `kontodimou2026turnaroundBuffer` —
  available for deep annotation in a future §3/§4 literature-review session if the user
  wants them taken further.

## Next step

Resolve the two open housekeeping questions above, then continue toward closing out §1
(SOI boundary) per `task-board.md`'s standing next-session priority — the source register
is now current for all 30 files in `references/`.
