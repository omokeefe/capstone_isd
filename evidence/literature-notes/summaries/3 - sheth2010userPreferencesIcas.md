# Analysis of Factors for Incorporating User Preferences in Air Traffic Management: A System Perspective

- **File:** `evidence/sources/Analysis of Factors for Incorporating User Preferences in Air Traffic Management - A system Perspective (Sheth).pdf`
- **Bib key:** `sheth2010userPreferencesIcas`
- **Authors:** Kapil Sheth (NASA Ames Research Center), Sebastian Gutierrez-Nolasco (UC Santa Cruz)
- **Year:** 2010
- **Venue:** 27th International Congress of the Aeronautical Sciences (ICAS 2010), Nice
- **DOI:** none on the paper

## What it is

A fast-time FACET study of what happens when airlines file optional routes with priorities ("credits") instead of one route per flight, against today's first-come-first-served handling, measured as NAS-wide delay and equity. Four cases (with and without optional routes, with and without priorities), then the effect of the planning interval and of the system-imposed departure-delay increment, for nominal and increased traffic and for different users. Three optional routes were provided for about 60 percent of flights; a two-hour planning interval with a five-minute delay increment gave the largest delay reduction.

## Why it's valuable, and to what

- Literature review section: none of §2 to §4; background for §7 to §9 and the §11 experiment.
- Stakeholder / objective ontology (§7 to §9): the clearest short statement of the problem the project's improved architecture addresses: "users always file a single route per flight, which often may be replaced with another plan by the air traffic manager. Replacement plans may not conform to user preferences," and "flight planning by the users is difficult due to a lack of mechanisms for specifying importance of their flights and concerns about sharing company proprietary information" (p. 1). Both halves, no mechanism and proprietary data, are the two stakeholder requirements SN-AIR-05 and SN-AIR-06 pull between.
- Optimization study (§11 to §13): a worked example of scoring a change in what the decider knows against a first-come-first-served baseline, at system level (delay, equity). The measures are flow-management measures, not the per-flight cost the experiment uses.
- Decomposition / architecture (§6, §10): names the electronic exchange being fielded in 2011 through which users could convey "primary and alternate route cost, minimum notification time, and valid times for each of their route options" (p. 2), an early form of the trajectory options set now in JO 7210.3EE.

## Rating

**3/5.** Useful framing and two quotable sentences on the gap; the results are about pre-departure route options and credits, which the project does not model.

## Flags

- Companion to `sheth2010creditsConcept`; cite that one for the dispatcher ratings and this one for the problem statement.
- Fast-time simulation with automated credit assignment, not human input.

## Processing metadata

- **Read depth:** first two pages read; the rest skimmed. The owner's digital highlights are on pp. 1 to 2.
- **Date processed:** 2026-10-10
