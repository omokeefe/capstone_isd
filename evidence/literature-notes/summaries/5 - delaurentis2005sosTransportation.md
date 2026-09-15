# Understanding Transportation as a System-of-Systems Design Problem

- **File:** `references/delaurentis-2005-understanding-transportation-as-a-system-of-systems-design-problem.pdf` (filename year is wrong — see flag)
- **Bib key:** `delaurentis2005sosTransportation`
- **Authors:** DeLaurentis, Daniel A. (Purdue University)
- **Year:** 2005
- **Venue:** 43rd AIAA Aerospace Sciences Meeting and Exhibit, Reno, Nevada (AIAA 2005-123)
- **DOI:** 10.2514/6.2005-123

## What it is

Introduces "system-of-systems" (SoS) as an emerging problem class distinguished by
evolutionary and emergent behavior — a network-of-systems, dynamic-behavior focus as
opposed to an individual system's static behavior — and specifically casts civil
transportation as an SoS problem, presenting an early "proto-method" for modeling and
simulating such problems, motivated by the observation that most SoS literature at the time
came from the defense domain, not civil transportation.

## Why it's valuable — and to what

- Literature review section: none of §2-§4 / foundational for the capstone's own framing
  choice.
- Decomposition / architecture (§6, §10): **this is likely the single most foundational
  reference for the capstone's core premise** — that the NAS should be treated as a System
  of Systems rather than a single system or a flat catalog of objects
  (`decisions/decisions-log.md` D-001/D-002). Should be cited early in the paper's
  motivation/background section, and revisited directly when §6 compares decomposition
  approaches, since DeLaurentis explicitly discusses evolutionary/emergent traits that a
  decomposition needs to accommodate.
- Stakeholder / objective ontology (§7-§9): discusses the "information gap between data
  produced by engineers/analysts and insights used by decision-makers" — relevant framing
  for why the RACCI/authority-transition work in §7 matters.
- Glossary / terminology: System-of-Systems (SoS), evolutionary/emergent behavior,
  "federalism" as a construct for SoS (per Sage, cited within).

## Rating

**5/5** — core, foundational reference for the capstone's central methodological premise;
same author lineage as `sinharoy2024ontologyUAM` (DeLaurentis is the senior/last author on
both), so the two form a nice pair spanning 2005→2024 of applying SoS thinking to
aviation-adjacent domains.

## Flags

**Year mismatch in filename:** the source filename reads
"delaurentis-2005-understanding-transportation-as-a-system-of-systems-design-problem.pdf,"
but the paper itself is **AIAA 2005-123**, presented 10-13 January 2005 — there is no 2012
version evident from the pages read. The bib key and `references.bib` entry use the
verified 2005 date; worth double-checking there isn't a separate, later DeLaurentis
follow-up paper that was intended by the "2012" in the filename and never actually
downloaded.

## Highlighted passages

_Digital highlights/underlines/comments the user marked up in the PDF, extracted 2026-09-14 via `tools/extract_pdf_annotations.py`. Ink/handwritten annotations (493 found) not extracted -- not requested._

**Page 1**
- **Highlight:** "A holistic framework is needed that enables decision makers to discern whether related infrastructure, policy, and/or technology considerations together are good, bad (or 
1 indifferent) over time.1"
- **Highlight:** "the SoS type almost always involves decisions that commit large amounts of money, for which ultimate failure or success carries heavy consequences over several generations, and that impact large segments of the public"
- **Highlight:** "integration interfaces are needed at multiple levels to understand the problem in full context and ensure that interconnections between related algorithms can be exploited."
- **Highlight:** "a tenet"
- **Highlight:** "must be"
- **Highlight:** "that the organization of systems/algorithms is just as important as the nature of the systems/algorithms to be organized"

**Page 2**
- **Highlight:** "here is an information gap between the data produced by engineers/analysts and the insights best utilized by decision-makers"
- **Highlight:** "Similarities of observed phenomena across fields of study lend credence to the idea that commonalities can be instructive and useful"
- **Highlight:** "The focus on interconnections within systems, in general, is an important aspect for SoS, and especially important for the “unintended consequences” behavior that will be mentioned later."

**Page 3**
- **Highlight:** "hat is next set of innovations that improve the effectiveness of methodology? An understanding of system-of-systems for which air vehicles are a primary part may be the answer."
- **Highlight:** "W"
- **Highlight:** "If an air vehicle is a mere part of a SoS, then both the understanding of objectives y and relevant subset of x depends on this larger context. The advent of proposed revolutionary air vehicle concepts (e.g., uninhabited air vehicles, personal air vehicles) and next-generation airspace networks as part of a revamped transportation system are indicative of this scenario"

**Page 4**
- **Highlight:** "A mission statement for the on-going research could be summarized as this: generation of system-of-systems formulations/tools/processes to understand and bound complex problems and create an ability to determine sensitivities and guide policies/decisions/visions"
- **Highlight:** "Table 2. Distinguishing Traits of System-of-Systems"

**Page 5**
- **Highlight:** "categories of systems and levels of organization"
- **Highlight:** "For each category, there is a hierarchy of levels"
- **Highlight:** "This framework intuits an important point about SoS problems: the behavior of the SoS is dominated by the structure and organization at higher levels as opposed to the characteristics of the α-level entities"
- **Highlight:** "How does the preferred or observed behavior at the upper levels (e.g. γ-level) affect the possibilities for alternatives at the lower levels (α and β)?"

**Page 6**
- **Highlight:** "a Monte Carlo sampling technique operates on expected variability in selected parameters"
- **Highlight:** "The evolutionary trait of SoS can be traced to two important points- most SoS applications of interest already exist and their internal structure does and will change over time."

**Page 7**
- **Highlight:** "Modeling and evaluating the behavior of the NTS is overwhelmingly difficult due especially to: the extreme number and heterogeneity of independent systems, the distributed nature of these systems, and the presence of deep uncertainty in understanding their co-evolution"
- **Highlight:** "a collection of diverse things that evolve over time, organized at multiple levels, to achieve a range of (likely) conflicting objectives, but never quite behaving as planned."

**Page 8**
- **Highlight:** "Table 4. Mapping of SoS Traits to the NTS"
- **Highlight:** "the challenge to provide effective design methods for decision-support in this context must also be faced. Strategies are under development to deal with these challenges
16,17 and some portions have already been applied to transportation."
- **Highlight:** "he major activity in the Definition Phase is one of understanding- characterize the SoS as it currently exists and establishing categories and levels that will later be required to detect evolutionary and emergent properties."
- **Highlight:** "In the Abstraction Phase, the main actors, effectors, disturbances, and networks are drawn out and placed in context corresponding to their real inter-relation. The focus of this phase is in grappling with the overwhelming complexity by abstracting the main entities; it is not intended to construct a detailed hierarchical decomposition."
- **Highlight:** "Finally, the Implementation Phase instantiates all or part of the abstraction within a modeling and simulation environment."
- **Underline:** "It is in this final phase that specific hypotheses about the SoS can be proposed and tested."
- **Highlight:** "to 
better comprehend the complexity of the SoS in abstract, one must have first struggled with “α- level issues” initially."

**Page 9**
- **Highlight:** "to develop insights on smaller, more manageable levels, a capability and awareness of the larger issues is more likely to emerge (if one is looking)."
- **Underline:** "(if one is looking)"
- **Highlight:** "Table 5. Transportation SoS- Lexicon Matrix with Order Estimates"
- **Highlight:** "An abstraction for transportation that builds from the levels and categories has been carefully developed and 
18 reported."
- **Highlight:** "Two pairs of entity descriptors emerge from the abstraction process: explicit-implicit and endogenous-exogenous."
- **Highlight:** "he role of the descriptors is not to facilitate break-down of the entities into separate pieces. Instead, it is only to organize them by articulating their inherent natures"
- **Highlight:** "T"
- **Highlight:** "resources, stakeholders, drivers, and disruptors"

**Page 10**
- **Highlight:** "For 
example, 
an individual 
values 
doorstep- destination (D-D) speed, cost per mph, 
mobility 
flexibility, 
etc."
- **Highlight:** "from a societal perspective, there may be desires to minimize total energy expended, maximize the robustness 
of 
the 
system 
to disturbance, etc."
- **Highlight:** "Ch"
- **Highlight:** "harter, fractional ownership, and personally owned options exist, but they remain at least one order of magnitude higher in cost than the scheduled service."
- **Highlight:** "Demand, which theoretically drives schedules"
- **Highlight:** "A very insightful encapsulation of these possible networks as well as the various layers within the
19 resource networks has been presented by Holmes.1"
- **Highlight:** "Crossley et al. studied the problem of a simplified airline as a system-of-systems, employing a combination of MDO techniques with integer programming to determine how a new aircraft design can be optimized for the greater good 
20 of the existing airline operation.20 I
21"
- **Highlight:** "measures of merit were profitability of a service provider attempting to operate this system in a competitive commercial environment."

**Page 11**
- **Highlight:** "The simulation must properly characterize the salient SoS traits"
- **Highlight:** "consider the variety of possible “system views”, especially since such views are tightly tied with
22 subsequent modeling and simulation approaches.22 T"

**Page 12**
- **Highlight:** "The chosen system views, associated methods, and data from the α, β, γ, δ- levels must be combined to test a myriad of possible hypotheses"
- **Highlight:** "Objects are constructs that are responsible for themselves. When a specific problem is at hand, objects are specific methods that can be called by other objects."
- **Highlight:** "The central role of abstraction in properly building a mental model of the problem is at the heart of this connection."
- **Highlight:** "he hope is that the use of the generalized and abstract objects with certain attributes and methods that modify those attributes can generate the holistic views required for system-of-systems"

**Page 13**
- **Highlight:** "While the ultimate fruits of a system-of-systems field of study are still a ways off, even conceiving of a larger frame of reference provides increased understanding for our seemingly complex pursuit of better aerospace vehicles"
- **Highlight:** "In this larger frame, the ill-advised practice of individual system (e.g. aircraft, air traffic rule, infrastructure, etc) optimization may become more clear as the role of other systems and their connectivity becomes evident."
- **Highlight:** "The success of future aerospace vehicles will depend on how well they harmonize with the dynamics of the system-of-systems of which they may have membership. The success of future systems-of-systems will depend on the extent to which design methods can properly pose and solve problems in this context."

## Processing metadata

- **Read depth:** skimmed (pages 1-2, abstract + intro)
- **Date processed:** 2026-08-29
