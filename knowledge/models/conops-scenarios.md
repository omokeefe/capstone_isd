# ConOps Scenario Exploration

_Working document for `to-do-list.md` §5 ("Construct the Nominal-Flight ConOps"),
used deliberately as a vehicle for §1 ("Establish Research Framework") too — each
scenario should double as a probe of the System of Interest boundary and the research
questions, not just an operational walkthrough. See
[[project-brief]] for the trajectory-intent throughline this should trace to, and
[[open-questions]] ("System boundary" section) for the boundary questions each scenario
should try to answer._

## Why scenarios drive SOI/research-question work

A boundary question like "is general aviation in scope?" is hard to answer in the
abstract. It's easier to answer against a concrete scenario: walk the scenario, and where
it forces a call (include this actor/system or not; this level of abstraction or not),
that's evidence for the boundary, not just an assertion. Each scenario entry below has a
field for exactly that — "SOI questions this exercises" — so the exploration accumulates
into an answer to `open-questions.md` rather than living only as a narrative.

Similarly, "research questions this probes" ties each scenario back to §1's six research
questions (decomposition, authority/responsibility/ownership boundaries, intent
propagation, differing definitions of optimal, myopic-optimization failure modes, MBSE
support for tradeoff analysis) so scenario selection stays purposeful rather than
open-ended world-building.

## Candidate scenarios to consider

Seeded from the open SOI boundary questions and the to-do §5 phase list — not yet
written up, just starting candidates. Add/remove freely; the goal is 1-3 *representative*
scenarios for the formal ConOps deliverable (to-do §5's stated metric), so this list
should get cut down, not all built out in full.

- **Nominal domestic commercial flight** — the baseline case; walks all six phases in
  to-do §5 (strategic/commercial planning through postflight/continuation) with no
  disruptions. Almost certainly one of the final 1-3.
- **International flight crossing NAS boundary** — probes "is international airspace
  outside the US NAS in scope?" and where authority transfers at the boundary (FAA to a
  foreign ANSP or vice versa).
- **General aviation flight (non-scheduled, non-airline)** — probes "is GA in scope?" —
  much of the strategic/commercial planning phase doesn't apply; tests whether the
  decomposition still holds without an airline OCC/dispatch layer.
- **Military airspace interaction (e.g. TFR or restricted-area transit)** — probes the
  "military as stakeholder vs. military as constituent system" boundary question and a
  candidate §9 conflict ("military mission effectiveness vs. civil-airspace capacity").
- **Off-nominal / disruption case (e.g. weather diversion or mechanical delay)** — probes
  intent *re*-propagation (research question 3) and surfaces a concrete local-vs-system
  optimization conflict for §9, rather than only the nominal happy path.

## Scenario entry template

Copy this block per scenario below the seed list once you start writing one up.

```
### <Scenario name>

**Status:** candidate | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>
```

## Scenarios

### Domestic Commercial Flight w/Wx Re-Route

**Status:** candidate |**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>## Status

Not yet started. Once 1-3 scenarios are drafted here and stable, synthesize the summary
into `report/sections/04_results_discussion.tex` (plantodo tagged `S5`) and the full
activity breakdown into `report/sections/08_appendices.tex` (`app:conops`), per the
mapping comment at the top of `report/main.tex`.

--- 

### Nominal International Flight 

* concept | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** 

### Business Flight 

* concept | drafted | reconciled with architecture

**Summary:** <1-3 sentences — what happens, why it's representative>

**Phases exercised (to-do §5):** <which of strategic/commercial planning, resource
planning, day-of-operations, turnaround, flight execution, postflight/continuation apply
— note any that don't, and why>

**Actors/systems involved:** <who/what participates — link to their persona in
[[stakeholder-personas]] where one exists; draft a new persona there rather than
inventing actor detail inline here>

**SOI questions this exercises:** <which `open-questions.md` boundary question(s) this
scenario forces a call on, and what the scenario suggests the answer should be — link
back to `open-questions.md`/`project-brief.md` once resolved, don't leave the resolution
only here>

**Research questions this probes (to-do §1):** <which of the six>

**Notes / open issues:** <anything unresolved about the scenario itself>