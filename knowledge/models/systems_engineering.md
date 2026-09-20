# Systems Engineering (SE)
Systems Engineering is a transdisciplinary and integrative approach to enable the successful realization, use, and retirement of engineered systems, using systems principles and concepts, and scientific, technological, and management methods.* 

![Systems Engineering Process](../../attachments/sys_eng_process.png)

According to (Honour, 2013), SE correlates to 40%+ shorter schedules, 30% lower development costs, and a return on investment of between 3.5- and 7-to-1, when applied at a level that amounts to approximately 15% of the project cost. 


## Model-Based Systems Engineering (MBSE)
Model Based Systems Engineering (MBSE) is a SE methodology that formalizes the practice of systems development through the use of models to support the requirements, design, analysis, verification, and validation. It provides a structured approach to system development, enabling better communication among stakeholders and facilitating the management of system complexity.


* INCOSE HANDBOOK (https://www.incose.org/about-systems-engineering/system-and-se-definition/systems-engineering-definition)

## SE in brief (ISD 520 / 521)

- **Purpose.** A system exists to help stakeholders achieve their objectives. The systems
  engineer's job is to build and keep a coalition of stakeholders supportive from
  development through end of life — "the politics of engineering." Solve the right problem
  before designing; potentially half of strategic failures come from ignoring key
  stakeholders' interests.
- **Technical and management.** Each step generates the information the next decision
  needs; control gates, traceability, and schedule are half the job.
- **Silos cause unintended consequences.** Decomposition creates specialists and
  interfaces. The systems engineer owns the interfaces, the requirement tree, and
  cross-cutting risk.
- **Zig-zag down, zig-zag up.** Alternate between decomposing requirements (vertical) and
  choosing the design that will satisfy them (horizontal), down to configured items. Then
  integrate and verify back up, one tier at a time, against that tier's requirements.
- **Verification is not validation.** *Verification* = objective evidence the design meets
  the stated requirements (bottom-up; don't repeat lower-tier tests; integration tests
  target interfaces; verify software as well as hardware). *Validation* = the system
  actually serves stakeholders in the intended, uncontrolled environment. A system can
  pass the first and fail the second (Coast Guard cutter, Expeditionary Fighting Vehicle).
- **What a requirement is.** A "shall" with a rationale, a parent, and a verification
  method chosen up front (inspection, demonstration, analysis/simulation, test).
  Threshold/objective values where quantifiable; interface requirements kept apart from
  design requirements. Set demanding targets with margin early — margin erodes.
- **Control gates** ask one question: is the risk of going forward acceptable? Outcomes:
  pass / pass with conditions / fail (freeze or go back). Risk = probability × severity; a
  detection only helps if controls exist and get used.

## MBSE in brief

- MBSE is SE using models, not documents, as the medium of exchange. Three parts:
  **language** (SysML v2), **tool** (Syside Modeler in VS Code; Cameo optional, per D-006),
  **method** (MagicGrid). SE is the goal;
  "model-based" is only how.
- **The model is the single source of truth.** Diagrams and slides are generated views. A
  change is made in the model, after agreement with affected parties, and propagates to
  every view — never made on a slide.
- **Four pillars:** structure (BDD, IBD, package), behavior (use case, activity, state
  machine, sequence), requirements (containment, derive, satisfy, verify), parametrics
  (equations tying design parameters to MOEs and requirements). MagicGrid v2 adds safety
  and reliability.
- **MagicGrid = rows × pillars.** *Problem domain*: opaque box (stakeholder needs, context
  block with actors and item flows, use cases + activity diagrams, MOEs), then clear box
  (functional decomposition and functional interfaces). *Solution domain*: system, then
  subsystem (logical architecture, system requirements, state machine, parametrics).
  *Implementation*: implementable specs handed to software/CAD with a bidirectional trace.
  Keep the problem domain implementation-neutral — many solutions can map to one problem.
- **Digital engineering** extends MBSE across the whole lifecycle: an authoritative source
  of truth per aspect, curated models, and a digital twin of each fielded instance feeding
  operational data back into design. (B-52: ~4 years of development, 75+ in
  operation/sustainment.)

## The M — stages, gates, and my project actions

The process diagram above is the M: the left leg rises through stakeholder context, drops
through System → Subsystem → Component (requirements, then design, at each tier), climbs
back through verify/integrate at each tier and validation, and ends in
Operate → Sustain → Evolve → Retire. Legend: green oval = map requirements to physical
system; green square = review by stakeholders/management; purple oval = pass / fail /
revise; purple square = test readiness review.

**Tier mapping (mine — confirm):** SLR = System tier (the NAS as SoS); HLR = Subsystem
tier (the nine D-002 domains); LLR = Component tier (constituent systems and their
interfaces). The lectures call the top tier "high-level requirements" — that is what this
repo calls SLR. Task checkboxes live in
[to-do-list.md](../../projects/nas-sos-capstone/to-do-list.md); the § numbers below only
point there.

**0. Define the system and its environment.**
*Lectures:* charter authorizes and bounds the project; draw the boundary; treat the SOI as
an opaque box first.
*Actions:* ratify the SOI boundary as a logged decision (§1, still provisional); produce
the NAS context diagram — actors, environment, item flows across the boundary (§10).

**1. Identify stakeholders and understand context.**
*Lectures:* stakeholders across the whole lifecycle (develop, produce, use, sustain,
dispose, regulate); power/interest grid; usage scenarios — normal, alternate, emergency
(observe under stress); use cases with actors, preconditions, flows, postconditions;
MOEs ("if you can't define goodness, you don't understand the customer").
*Actions:* finish the stakeholder register/model (§7, §10); use the ConOps scenarios as the
use cases, including off-nominal and emergency (§5); keep MOP/MOE per stakeholder (§8);
read scenarios back to the adviser and let them correct the record.

**2. Stakeholder requirements → translation** *(System Requirements Review: do
stakeholders understand and agree on the requirements?)*
*Lectures:* record needs in the stakeholder's own language; then de-duplicate and formalize.
*Actions:* replace the "shall…" stubs in `cameo_models/requirements_stakeholders.sysml`
with needs that name their source stakeholder; trace need → objective (§10).

**3. Concept generation and selection** *(System Concept Review: is the concept viable?
— nothing stronger yet)*
*Lectures:* brainstorm, morphological matrix, screen, dominance, even swaps / swing
weights; fix criteria before scoring; TRL 1–9 for novel technology.
*Actions:* treat the §6 comparison of alternative decompositions as the concept selection —
set criteria first, score each option, log the choice in
[decisions-log.md](../../decisions/decisions-log.md).

**4. SLR — the system spec.**
*Lectures:* four parts — mission capability statement (ConOps + scenarios), design
requirements, external interface requirements, verification requirements; approved as a
baseline.
*Actions:* rework `cameo_models/requirements_nas_system.sysml` so every SLR has an ID,
rationale, parent need, verification method, and threshold/objective where quantifiable;
split out external interface requirements (§10 requirements model).

**5. HLR — subsystem/domain level** *(Preliminary Design Review: expected performance
consistent with the spec, margins adequate?)*
*Lectures:* functional analysis; allocate requirements to elements with a matrix
(flow-down / simple / complex); FMEA at allocation; interface matrix; targets with margin.
*Actions:* allocate SLRs across the nine domains in a requirement × domain matrix; build
the domain × domain interface matrix as the seed for the interface/item-flow model and
ICD (§10); run an FMEA-style pass on cross-domain exchanges (late, wrong, missing).

**6. LLR — component level** *(Critical Design Review: is the design effort complete?)*
*Lectures:* decompose to configured items; a parent is satisfied when its children are;
number the tree (1, 1.1, 1.1.1); changing a parent orphans children.
*Actions:* proposed — write LLRs only for constituent systems on the intent-to-trajectory
chain, leave the rest as blocks, and record that as a known omission (§15).

**7. Implementation** *(Test Readiness Review: what are you testing for, is it worth the
cost and risk?)*
*Lectures:* SE ends at an implementable spec; hand off with a bidirectional trace; run only
tests whose result could change a decision.
*Actions:* the implementation is the executable artifacts — instance scenarios
(`cameo_models/scenarios/`) and the Python model (`simulation/`); finish the §13 traces;
state what decision each run informs before running it.

**8. Verify and integrate upward** *(Functional Config. Audit → System Verification
Review: verification matrix complete? does the whole meet the spec?)*
*Lectures:* bottom-up, tier by tier; integration tests target interfaces; objective
evidence, not subjective estimates.
*Actions:* build the verification matrix (requirement ↔ method ↔ evidence) and run §15 in
tier order: unit tests → interface coverage → nominal ConOps → off-nominal scenarios →
whole-model traceability. Cite check output, not judgment.

**9. Validate.**
*Lectures:* intended, uncontrolled environment; early validation with mockups and
scenarios; experts can't recall being novices.
*Actions:* run the §14 demonstration (change stakeholder weights, show the changed
behavior and cost to others) past the adviser and, if reachable, someone who works in
airline/ATC operations. Record what they correct; report validation separately from §15
verification.

**10. Operate, sustain, evolve, retire.**
*Lectures:* ConOps covers operation, support, and decommissioning — explicit for new
things; sustainment is often the longest phase; feed operational data back to design.
*Actions:* decide explicitly whether retirement of NAS constituents is in scope
(default: out, recorded as a limitation); map "evolve" to §15 future expansion; for the
capstone itself, "retire" = the final versioned baseline.

**Cross-cutting.** Maintain one trace chain: stakeholder → need → SLR → HLR → LLR →
system → activity → information exchange → verification evidence (§10, §13, §15). Route
every change through the model. Log architecture decisions.

**Open judgment calls.**
1. The lectures assume one organization designs and controls the system; NAS constituents
   are independently owned. "Allocate" may have to mean authority and responsibility, not
   design assignment — worth settling with the adviser.
2. "Implementation," "production," and "retire" have no literal analogue for a reference
   architecture; the mappings above are proposals.
3. The transcripts are raw speech-to-text; check terms and figures against the slides
   before citing.

*Sources (transcripts live outside the repo; not copied):* ISD 520 L11 (MBSE), L13–L16
(system spec), L25 (verification/validation), L26 (control gates), L27 (review), and
L02–L09 via the summaries; ISD 521 L05 (MagicGrid), L11, L16 (deliverables), L18–L19
(feasibility, TRL), L25, L27 (digital engineering).