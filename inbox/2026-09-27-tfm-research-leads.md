# TFM and context-diagram research leads (captured 2026-09-27)

Untriaged. These are leads from the context-diagram review, not registered sources. Nothing here should be cited until it goes through `/process-references`.

## FAA SMART

SMART = **Strategic Management of Airspace, Routes and Trajectories**. From news coverage (not yet an FAA primary source):

- It centralizes about 200 data streams (weather, flight paths, traffic flow, controller staffing) into one platform, with an AI-supported engine that predicts where congestion or weather will cause problems so specialists can act early.
- Limited-mode use began 2026-09-21 in the Washington, D.C. airspace (DCA, IAD, BWI), with a planned gradual national expansion.
- Contract: 12 years, $875M, with Air Space Intelligence. Coverage says it supports both the FAA and airlines (operations, schedules, delays and cancellations).

Why it matters here: it is a TFM decision-support capability (Decision Support, absorbed per D-007) that sits on exactly the AOC ↔ ATCSCC link the context diagram now grades A. If airlines see the same predictions, it changes the information side of the §9 airline-vs-system conflict: both parties may be working from the same forecast. Questions to answer:

1. Who operates it (ATCSCC only, TMUs, airlines)? Is it a replacement for or an addition to FSM/TFMS tools?
2. Does it produce TMI recommendations (GDP/CTOP/reroute), or only situational prediction?
3. Is there an FAA ConOps or fact sheet to register as a primary source?

Where it would land in the model: a part under `AirspaceManagement::AirTrafficFlowManagementSystem` (already mentioned in that def's doc as a candidate), cited as a medium, not a party.

Sources (news, 2026-09-21/22): [FAA newsroom](https://www.faa.gov/newsroom/trumps-transportation-secretary-sean-p-duffy-delivers-state-art-air-traffic-control), [NPR](https://www.npr.org/2026/09/21/nx-s1-5976816/faa-ai-manage-airspace), [General Aviation News](https://generalaviationnews.com/2026/09/22/faa-launches-new-ai-air-traffic-control-tool/), [Spectrum News](https://spectrumlocalnews.com/us/snplus/transportation/2026/09/21/faa-ai-smart-system), [The AI Insider](https://theaiinsider.tech/2026/09/21/faa-to-deploy-875m-ai-system-to-address-air-traffic-control-shortage/).

## CTOP

Registered and grade A today: JO 7210.3EE §18-12 (definitions, ATCSCC and ARTCC procedures). ¶18-12-3b: the TOS is "a message sent by the NAS user to TFMS" with routes/altitudes/speeds "weighted through the use of flight operator submitted preferences." Missing: what those preferences are (delay tolerances per option), how the allocation picks an option, and how often CTOP is actually used. Leads: FAA CDM website CTOP pages, FSM/CTOP user documentation, and FAA/MITRE CTOP concept papers. Keep the modeling at the interface level (TOS out, assignment in); the allocation algorithm is a Decision Support capability, and modeling its internals would drift toward an optimization deep-dive.

## GDP slot substitution / diversion recovery

Primary text is registered (7210.3EE ¶18-10-12, ¶18-4-5). For the scenario, a CDM/GDP background source would help (ration-by-schedule, compression, slot credit substitution). Classic CDM literature from the late 1990s and 2000s (e.g. Wambsganss on CDM; Ball, Hoffman and colleagues on GDP allocation) is the place to look. Verify titles before registering.

## Gate-assignment authority (US)

Needed for credibility of the AOC ↔ Airport link: who assigns gates when gates are airline-leased (exclusive/preferential) vs common-use. Leads: FAA AC 150/5360-13 (airport terminal planning), and ACRP reports on airport–airline use and lease agreements. Verify report numbers before citing. **2026-09-28:** FAA Order 5190.6C Ch. 9 registered (`faa2026order51906cCh9`). It covers the sponsor's authority and accommodation duty (A) but not the preferential/common-use split. Still needed: an airport use and lease agreement or an ACRP report for that split.

## Crew ↔ aircraft (FMS)

The owner has 16 years in industry on FMS technologies. Either cite a source or state that in the write-up. Candidates: ARINC 702A (Advanced Flight Management Computer System characteristic), an aircraft type's FCOM, FAA AC 120-71B (standard operating procedures and pilot monitoring duties; also the source for retiring "PNF" in favor of "PM").
