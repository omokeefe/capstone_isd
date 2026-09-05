You are helping me redesign and reorganize this existing VS Code workspace into a durable personal knowledge management system.

The workspace contains Markdown notes and may also contain code, data, attachments, configuration files, project materials, and AI instruction files such as `CLAUDE.md`. It is already in use. Treat all existing content as potentially valuable.

Your job is not merely to tidy folders. Design a system that improves:

1. My ability to resume active work quickly.
2. My ability to retrieve known information.
3. My ability to develop ideas across projects and sources.
4. My understanding and long-term memory.
5. AI retrieval accuracy and contextual efficiency.
6. Traceability from claims and decisions back to evidence.
7. Long-term maintainability with minimal organizational overhead.

## Governing principles

Use a hybrid architecture rather than applying one named PKM method universally:

* Use PARA-like organization for commitments and operational context: projects, ongoing areas, resources, and inactive material.
* Use concept-, claim-, and relationship-oriented notes for durable knowledge.
* Keep evidence and source provenance distinct from my interpretations.
* Use folders for lifecycle, operational state, or ownership.
* Use links for meaningful relationships between specific notes.
* Use properties or frontmatter for attributes that should be queried or processed.
* Use tags sparingly for genuinely cross-cutting states or facets.
* Use search and generated indexes for discovery rather than trying to encode every possible relationship in a folder hierarchy.
* Favor plain Markdown, transparent conventions, stable filenames, relative portability, and limited tool dependence.
* Do not create structure merely because it is theoretically elegant. Every structural element must have a clear retrieval, reasoning, learning, or operational purpose.

The workspace must support both human cognition and AI access. It must not become a repository that the AI understands better than I do.

## Critical safety constraints

Do not begin by moving or rewriting files.

First:

1. Inspect the workspace.
2. Read all applicable `CLAUDE.md` files and other workspace instructions.
3. Determine whether Git is active and inspect its status.
4. Identify uncommitted work, generated files, attachments, scripts, external dependencies, and path-sensitive links.
5. Identify existing organizational conventions before proposing new ones.
6. Detect Markdown links, relative paths, embeds, code references, and scripts that could break if files move.
7. Do not overwrite substantive content.
8. Do not delete files merely because they appear redundant, obsolete, empty, or low-value.
9. Preserve dates, source information, authorship, and provenance.
10. Never silently merge two notes that make materially different claims.
11. Use Git-aware moves when practical.
12. Keep a machine-readable migration map from every old path to every new path.
13. Make the reorganization reversible.

Before making material changes, present the audit and proposed architecture to me and wait for approval.

## Desired conceptual architecture

Do not impose this exact folder layout without evaluating the workspace, but use it as the default conceptual model:

```text
/
├── CLAUDE.md
├── _system/
│   ├── workspace-map.md
│   ├── conventions.md
│   ├── note-types.md
│   ├── metadata-schema.md
│   ├── retrieval-policy.md
│   ├── maintenance.md
│   └── migrations/
├── projects/
├── areas/
├── knowledge/
│   ├── concepts/
│   ├── claims/
│   ├── models/
│   └── questions/
├── evidence/
│   ├── sources/
│   ├── literature-notes/
│   └── datasets/
├── decisions/
├── inbox/
├── archive/
└── assets/
```

Keep code repositories or existing software packages intact when moving them would harm tooling, imports, version control, builds, or deployment. The PKM architecture may index a code project without physically absorbing or reorganizing its internal structure.

The architectural distinction matters more than the exact folder names:

* **Control layer:** instructions governing how AI agents interact with the workspace.
* **Operational layer:** active projects, ongoing responsibilities, status, decisions, deliverables, and next actions.
* **Knowledge layer:** durable concepts, claims, models, questions, and relationships that can apply across projects.
* **Evidence layer:** papers, standards, datasets, quotations, observations, and other sources supporting or challenging knowledge.
* **Archive layer:** inactive material preserved without occupying the active working surface.

## Redesigning `CLAUDE.md`

The root `CLAUDE.md` should be a short control document, not a comprehensive index of everything I know.

It should tell an AI agent:

* How to orient itself.
* Which workspace map or registry to consult.
* How to select context relevant to a task.
* How to distinguish my writing from AI-generated material.
* How to distinguish evidence, interpretation, claims, and decisions.
* How to report uncertainty.
* How to preserve citations and provenance.
* When it must ask me rather than infer.
* Which changes require approval.
* How to avoid loading the entire workspace unnecessarily.
* How to update indexes after authorized changes.
* How to respect more specific instruction files lower in the directory tree.

Prefer progressive, query-driven context retrieval over a long mandatory chain of documents. An AI should begin with concise operating rules and a lightweight workspace map, determine the task context, and then load only the relevant project, knowledge, decision, and evidence notes.

Separate:

* Behavioral instructions for the AI
* Descriptions of the workspace
* Domain knowledge
* Project status
* Personal preferences
* Reusable workflows

Do not embed large amounts of volatile project information in the root `CLAUDE.md`.

## Note types

Infer useful note types from the existing material. Use the smallest set that creates real value. Candidate types include:

### Project index

A project index should answer:

* What outcome is being pursued?
* Why does it matter?
* What is in and out of scope?
* What is the current state?
* What decisions have been made?
* What remains uncertain?
* What are the next actions?
* Which knowledge, evidence, people, systems, and artifacts are relevant?
* What would allow me to resume the project after several months?

### Concept note

A concept note should define an enduring idea in my own words and distinguish it from neighboring ideas.

### Claim note

A claim note should contain:

* The claim
* Scope and qualifications
* Supporting evidence
* Contradicting evidence
* My confidence
* My interpretation
* Related claims
* Practical implications
* Open questions

Not every sentence needs its own claim note. Create one only when the claim is important, contestable, reusable, or dependent on evidence.

### Source or literature note

A source note should clearly separate:

* Bibliographic information
* Source type
* Verbatim quotations
* Objective summary
* Methods
* Findings
* Limitations
* My interpretation
* Relevance to projects or claims
* Questions or disagreements

Do not represent an AI summary as though I had personally read and evaluated the source.

### Decision note

A decision note should contain:

* Decision
* Date and status
* Context
* Alternatives considered
* Criteria
* Rationale
* Evidence used
* Assumptions
* Consequences
* Conditions that would justify revisiting it

### Question note

Use question notes for important unresolved issues, especially those spanning multiple projects or sources.

## Protecting the cognitive value of note-making

A central design requirement is that AI assistance must not replace the intellectual work through which I learn.

Classify proposed note work by cognitive importance.

### AI may usually handle

* Mechanical formatting
* Filename normalization
* Link repair
* Metadata normalization
* Duplicate detection
* Bibliographic extraction
* Literal quotation extraction
* Index generation
* Proposed links
* Proposed classifications
* Identification of missing fields
* Identification of apparent contradictions
* Drafting routine summaries clearly labeled as AI-generated

### I should personally contribute to non-trivial knowledge

For important, contestable, surprising, reusable, decision-relevant, or conceptually difficult material, do not finalize the substantive note entirely on my behalf.

Instead, ask me to make an intellectual contribution. Choose one or more prompts appropriate to the situation:

* “Before I show you the source again, state the central claim from memory.”
* “Explain this concept in your own words.”
* “What do you think this means?”
* “Why does this matter to your work?”
* “Predict how this principle would apply in a new case.”
* “What result would you expect before examining the evidence?”
* “What assumptions does this claim depend on?”
* “What evidence would cause you to reject or revise it?”
* “How does this relate to something you already know?”
* “Where does this conflict with another note or belief?”
* “What decision follows from this information?”
* “Rationalize the choice between these alternatives.”
* “Give an example and a counterexample.”
* “What are you least certain about?”
* “Reconstruct the reasoning behind this decision without opening the old note.”

Use my response as the nucleus of the note. You may then help clarify, structure, critique, and connect it, but preserve my wording or clearly distinguish my contribution from AI additions.

Do not interrupt me for trivial metadata or low-value content. Apply this requirement selectively where the act of generating an explanation will materially improve understanding, memory, judgment, or ownership.

If many notes require my input, create a review queue rather than asking dozens of questions at once. Prioritize the most consequential notes.

## Authorship and epistemic status

Design a lightweight convention that allows a reader or AI to distinguish:

* My original writing
* My later interpretation
* Direct quotations
* Objective source summaries
* AI-generated drafts
* AI-suggested relationships
* Verified facts
* Tentative hypotheses
* Open questions
* Superseded conclusions

Avoid excessive metadata. Prefer a few consistently applied properties over a large schema that will decay.

Consider properties such as:

```yaml
---
type:
status:
created:
updated:
source:
source_status:
confidence:
projects:
concepts:
authorship:
review_after:
---
```

Do not add every property to every note. Define which fields apply to which note types.

## Meaningful connections

Do not maximize backlink count. Maximize meaningful, explainable relationships.

When proposing or creating a connection:

1. State why the notes are related.
2. Prefer a sentence expressing the relationship over an unexplained “Related” list.
3. Identify the relationship type when useful, such as:

   * supports
   * contradicts
   * qualifies
   * depends on
   * instantiates
   * generalizes
   * applies to
   * derived from
   * supersedes
   * motivates
4. Link concepts across projects when the knowledge is genuinely reusable.
5. Connect decisions to the claims and evidence that justified them.
6. Connect source notes to the claims they support or challenge.
7. Preserve unresolved tensions rather than synthesizing them away.

For example, prefer:

```markdown
[[Individual trajectory optimization]] can conflict with
[[Sector throughput]] when a locally fuel-optimal path increases
controller workload or reduces sequencing flexibility.
```

over:

```markdown
Related: [[Individual trajectory optimization]], [[Sector throughput]]
```

Create curated maps of content only where they materially improve orientation or synthesis. Do not build a second manual folder hierarchy out of index notes.

## Retrieval design

Design for at least four retrieval modes:

1. **Known-item retrieval:** I know roughly what I want.
2. **Contextual retrieval:** I want everything relevant to a project or decision.
3. **Associative retrieval:** I want adjacent, conflicting, or analogous ideas.
4. **Exploratory retrieval:** I do not yet know what I am looking for.

Support these with an appropriate combination of:

* Predictable filenames
* Shallow operational folders
* Full-text search
* Links
* Properties
* Generated indexes
* Maps of content
* Optional semantic or vector retrieval
* Optional relationship-aware retrieval

Do not assume embeddings or semantic search eliminate the need for good source boundaries, provenance, titles, and explicit relationships. AI retrieval must be able to cite the exact notes used.

## Memory and learning workflow

Create a lightweight workflow for active learning rather than turning every note into a flashcard.

Identify a small subset of material that merits personal retrieval practice:

* Foundational concepts
* Important technical relationships
* Decision rationales
* Frequently used models
* Information I repeatedly fail to recall
* Claims where fluent recall improves professional judgment

For those items, support periodic prompts such as:

* State
* Explain
* Predict
* Apply
* Compare
* Rationalize
* Identify assumptions
* Produce an example
* Produce a counterexample
* Recall supporting evidence
* Recall contradicting evidence

When reviewing a note, prompt me before revealing its contents. After my answer, compare it against the note and identify:

* Correctly recalled elements
* Important omissions
* Possible misconceptions
* Changes in my understanding
* Whether the note itself needs revision

Do not optimize solely for verbatim recall. Emphasize explanation, transfer, discrimination among similar concepts, and reconstruction of reasoning.

## Measures of success

Establish a baseline before reorganizing where reasonably possible. Do not use note count, backlink count, tag count, or graph density as primary success measures.

Propose a small, sustainable scorecard including measures such as:

### Operational effectiveness

* Median time to resume an active project after an interruption
* Time required to identify the next meaningful action
* Percentage of active projects with a usable project index
* Percentage of important decisions with recorded rationale
* Number of broken links or unresolved path references

### Retrieval

* Success rate for a sample of known-item retrieval tasks
* Time to locate evidence supporting an important claim
* Time to reconstruct the context of an older decision
* Percentage of AI answers that cite the correct workspace sources
* Rate of irrelevant context retrieved by the AI

### Knowledge quality

* Percentage of consequential claims with identifiable evidence
* Number of material contradictions surfaced rather than hidden
* Percentage of source notes distinguishing quotation, summary, and interpretation
* Number of reusable concepts connected across multiple projects
* Percentage of AI-generated substantive notes reviewed by me

### Learning and ownership

* Ability to explain selected concepts without opening the note
* Ability to predict an application or consequence in a new case
* Ability to reconstruct the rationale for selected decisions
* Frequency with which my understanding changes after review
* Percentage of high-value notes containing a substantive contribution written by me

### Maintenance burden

* Time spent per week filing and maintaining notes
* Number of items stranded in the inbox
* Number of unused or inconsistently applied tags/properties
* Number of indexes requiring manual synchronization
* Number of AI instruction files containing duplicated or conflicting rules

Use a modest representative test set rather than attempting to quantify everything. Define how each measure will be collected without making the measurement system burdensome.

## Required process

### Phase 1: Audit

Inspect the workspace and report:

* Current directory structure
* Existing note types and conventions
* Existing AI instruction hierarchy
* Major content domains
* Active versus inactive material
* Link and path dependencies
* Duplicate or near-duplicate content
* Fragmentation across directories
* Mixed concerns within notes
* Evidence/provenance gaps
* Existing strengths worth preserving
* Risks of reorganization
* Git status and rollback options

Do not change substantive files during this phase.

### Phase 2: Representative retrieval test

Help me define approximately 8–12 realistic questions I expect the workspace to answer, covering known-item, project-context, associative, and exploratory retrieval.

Run or document a baseline evaluation where practical:

* Was the correct material found?
* How long or how many steps did it take?
* Was its authority or provenance clear?
* Did the AI retrieve irrelevant material?
* Could I explain the answer without simply rereading it?

### Phase 3: Proposed architecture

Present:

* Recommended architecture
* Rationale for each top-level component
* Proposed note types
* Minimal metadata schema
* Naming and linking conventions
* Revised AI instruction architecture
* Proposed migration mapping
* Items requiring my judgment
* What you deliberately recommend leaving unchanged
* Expected benefits and tradeoffs
* A rollback plan

Show examples using actual representative workspace material, but do not expose sensitive content unnecessarily.

Wait for my approval before proceeding.

### Phase 4: Pilot migration

After approval, migrate only a representative pilot slice, preferably:

* One active project
* Its related sources
* Several durable concepts or claims
* At least one decision
* Relevant AI instructions

Update links safely and record every move.

Then test:

* Human navigation
* AI orientation
* Retrieval quality
* Provenance
* Project resumption
* Maintenance effort

Ask me to complete at least one meaningful state, explain, predict, or rationalize exercise using the pilot material.

Summarize the pilot results and wait for approval before full migration.

### Phase 5: Full migration

After approval:

* Apply the validated conventions incrementally.
* Preserve a migration manifest.
* Repair and validate internal links.
* Keep uncertain classifications in a review queue.
* Do not invent missing provenance.
* Do not silently resolve contradictions.
* Label AI-generated substantive material.
* Avoid mass rewriting merely for stylistic consistency.
* Update indexes and workspace maps.
* Preserve original content until the migration is verified.

### Phase 6: Verification and handoff

Verify:

* No substantive files were lost.
* Links and embeds still work.
* Path-sensitive scripts and code still work.
* Git clearly represents the changes.
* The root AI instructions remain concise.
* Project indexes provide sufficient resumption context.
* Important claims trace to evidence.
* AI-generated material is identifiable.
* The review queue is manageable.
* The success measures can actually be collected.

Provide:

* A concise workspace map
* Conventions guide
* Note-type guide
* Retrieval guide
* Maintenance routine
* Migration manifest
* Human review queue
* Baseline and post-pilot results
* Recommended next review date

## Maintenance philosophy

Prefer a system that tolerates imperfect behavior.

The system should not depend on:

* Perfect inbox processing
* Exhaustive tagging
* Manually maintaining every backlink
* Assigning every note to exactly one topic
* Reading every captured source
* Keeping every index continuously current
* AI access to the entire workspace
* A proprietary database that obscures the Markdown

Recommend the minimum recurring maintenance necessary. Automate mechanical validation where useful, but preserve human judgment for meaning, confidence, interpretation, and decisions.

## How to work with me

Be willing to challenge my existing architecture and your own proposed architecture.

When you encounter ambiguity, distinguish among:

* A reversible mechanical choice you can safely make
* A substantive classification you should propose
* An epistemic judgment that requires my input
* A destructive or disruptive change requiring explicit approval

Ask focused questions in manageable batches. Explain important tradeoffs with concrete examples from the workspace.

Most importantly: optimize the system for better thinking and useful output, not for the appearance of organization.

Begin with Phase 1 only. Audit the workspace, perform no reorganization yet, and present your findings and recommended next step.
