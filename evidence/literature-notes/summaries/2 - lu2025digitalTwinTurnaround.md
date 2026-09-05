# Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency

- **File:** `references/Harnessing Digital Twin Technology for Enhanced Aircraft Turnaround Efficiency.pdf`
- **Bib key:** `lu2025digitalTwinTurnaround`
- **Authors:** Lu, Jing; Pang, Tao; Lu, Xuheng; Ji, Jiaxin; Jiang, Changmin
- **Year:** 2025
- **Venue:** Transport Economics and Management, Vol. 3, pp. 334-345
- **DOI:** 10.1016/j.team.2025.09.001

## What it is

An empirical/technical paper (Nanjing University of Aeronautics and Astronautics / Hong
Kong Polytechnic University) building a physical scaled-down (15:1) "sandbox" apron
populated with smart devices (robotic cargo tugs, conveyor-belt vehicles, lift platforms,
tow tractors) paired with a digital-twin model to simulate and validate automated aircraft
turnaround. Uses a network-planning (CPM-style) technique to derive multi-device
coordination rules and timing. Reports the automated approach reduces average turnaround
time by 24.53% versus a manual/device-coordinated baseline (20 simulation runs, single
flight, single-line workflow).

## Why it's valuable — and to what

- Literature review section: §3 (turnaround/day-of-ops) — an example of
  automated/robotic ground-service turnaround research and digital-twin validation
  methodology.
- Decomposition / architecture (§6, §10): could inform a device/agent-level decomposition
  of the turnaround system (aircraft, ground support equipment, apron) if the model goes
  to that granularity — below the enterprise-to-trajectory intent chain the capstone
  centers on.
- Stakeholder / objective ontology (§7-9): not applicable — no stakeholder, objective, or
  cross-level conflict content; a bottom-up engineering demonstration.
- Optimization study (§11-13): tangential methodological parallel (digital-twin + sandbox
  validation) but not directly reusable at schedule/trajectory granularity.
- Glossary / terminology: digital twin (five-dimensional structure per Tao et al.),
  sandbox-based apron, twin rule module, network planning technique.

## Rating

**2/5** — Rigorous, well-documented engineering demonstration of turnaround automation,
but its scope (robotic ground-service devices on a physical sandbox apron) sits below and
adjacent to the capstone's core storyline (enterprise-objective-to-aircraft-trajectory
intent propagation). Useful only as §3 background and a "digital twin" terminology
source; could be bumped to 3 if the SysML decomposition later includes ground-service
equipment/automation as a modeled system.

## Flags

Topic-adjacent to `kontodimou2026turnaroundBuffer` (also new this batch) but methodologically
distinct — that paper is ML-based schedule-buffer optimization, this one is robotics/digital-twin
simulation of ground-service execution; complementary, both worth citing in §3 as different
angles on turnaround-duration research. All bib fields confirmed directly from the PDF.

## Processing metadata

- **Read depth:** Substantially read (abstract, intro, methodology in full; results
  appendix and conclusion reviewed; some mid-section prose skimmed)
- **Date processed:** 2026-09-04
