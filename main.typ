#import "style.typ": paper
#import "theme.typ": bibliography-style
#show: paper.with(kind: "Research Essay", date: "October 1, 2026")

// NSF identifies Mazuzan's history as a 1994 report: https://www.nsf.gov/about/history.
// Apply the date correction and add the Roman source here so only main.typ must be replaced.
#let essay-bib = read("references.bib").replace(
  "author={Mazuzan, George T.},",
  "author={Mazuzan, George T.}, year={1994},",
) + "
@misc{romanprogram2026,
 author={{NASA}}, year={2026},
 title={{General Investigator Program}},
 url={https://science.nasa.gov/mission/roman-space-telescope/general-observer-program/},
 note={Roman Space Telescope. Summer 2026 selections; accessed 1 October 2026}
}
"

// Start the essay at Section 0 while retaining Sections 1–6.
#set heading(numbering: n => str(n - 1))

= What makes this a funding crisis?
Federal support paid for approximately 56% of academic basic research in the United States in 2023 @nsb2025. I use "funding crisis" here to describe interruptions to ongoing research and training, together with uncertainty about whether the government will honor its commitments.

In 2025, already-funded projects lost support. The Government Accountability Office (GAO) reports that the National Science Foundation (NSF) listed more than 1,600 terminated awards as of June 5, citing misalignment with agency priorities @gaonsf2025[appendix IV]. #cite(<oliveira2026>, form: "prose") identify 2,291 National Institutes of Health (NIH) grants terminated between February 28 and August 22, with approximately \$2.45 billion in funding remaining. Some awards were later reinstated, but the terminations reached work that agencies had already agreed to support. The crisis concerns whether researchers can rely on commitments already made.

Even temporary gaps can affect research careers. Comparing earlier NIH renewal delays with uninterrupted funding, #cite(<tham2026>, form: "prose") estimate that gaps of at least 30 days increased nonemployment by three percentage points among personnel in laboratories supported by a single R01 grant. The employment cost gives Congress a reason to protect continuity: interruptions put the workforce it supports at risk.


= Science as a public commitment
How much protection does an appropriation offer when an administration changes its research priorities? Congress can reject proposed cuts without securing continuity for individual projects. I argue that Congress should make continuity for viable, already-funded research a priority in both budgeting and oversight. That means supporting teams through administrative delays and requiring agencies to defend decisions to terminate their work. Scientific review should inform those decisions, while elected officials remain accountable for the spending.

As a physics student working in cosmology, I have a particular stake in that distinction. Roman's planned survey uses weak gravitational lensing and galaxy clustering to investigate dark matter and cosmic acceleration @balzer2026. #cite(<romanprogram2026>, form: "prose") selected 118 proposals for Roman research funding in summer 2026. I want Congress to sustain that investment in the people who turn the telescope's data into measurements.

After World War II, Vannevar Bush favored scientific independence, while Senator Harley Kilgore emphasized public accountability. Truman vetoed an early NSF bill in 1947 over its independence from presidential control; agreement followed in 1950 @mazuzan. The disagreement concerned the authority that came with federal support. Researchers wanted room to judge scientific promise; Truman wanted an agency answerable to elected government. A funding policy still has to accommodate both. Scientific review can explain what a project is likely to contribute, while elected officials must decide whether that contribution warrants public spending and answer for the consequences of their choice.

= Promises, appropriations, and the size of the rescue
Article I's Appropriations Clause requires Treasury withdrawals to follow appropriations made by law @constitution. An authorization can specify intended funding levels; an appropriation supplies budget authority. A presidential request proposes what Congress should provide. Agencies then commit funds through obligations and pay them out as outlays. Their decisions determine which laboratories receive support.

The CHIPS and Science Act authorized NSF growth for fiscal years (FY) 2023–2027 @chips2022[sec.~10303]. For FY2026, Congress appropriated \$8.750 billion against an authorization of approximately \$17.832 billion, or 49.1% of that goal (@fig-gap). NSF never had the additional \$9.082 billion to spend. The gap began widening before Trump's second administration, so a defense of research funding must also confront Congress's record. Congress had endorsed expansion and then funded a substantially smaller program. Legislators owe researchers an explanation for that gap and a realistic account of what they are willing to fund.

#figure(
  image("figures/funding_gap.pdf", width: 100%, alt: "NSF authorizations rise while appropriations remain lower; Congress offsets most proposed FY2026 cuts to NSF and NASA Science."),
  placement: none,
  caption: [
    Author's calculations from #cite(<harris2026>, form: "prose"), #cite(<chips2022>, form: "prose"), #cite(<congress2026>, form: "prose"), #cite(<nasa2025>, form: "prose"), and #cite(<nasa2026>, form: "prose"). Nominal budget authority; FY2023 NSF includes supplements. Panel B compares FY2026 requests and enactments with FY2025 enacted amounts. The open point adjusts NSF's baseline for unavailable emergency funding.
  ],
) <fig-gap>


Congress nevertheless preserved substantial funding. Against FY2025 enacted amounts, the president requested a 56.9% NSF reduction and a 46.7% NASA Science reduction. Final FY2026 amounts were 3.4% and 1.1% lower, respectively; Trump signed the law on January 23, 2026 @congress2026. Congress checked the president's budget agenda without delivering its own authorized growth.

Excluding \$234 million in FY2025 emergency construction funding that the president did not make available reduces NSF's measured decline to 0.9% @harris2026[pp.~2–4]. Against the funding available the previous year, Congress kept NSF's nominal budget authority nearly steady. It preserved that capacity to fund research despite the proposed contraction.

= Which science do political institutions protect?
Republican Senators Susan Collins and Jerry Moran emphasized competitiveness and benefits to constituents; Democrat Patty Murray stressed resisting the administration's cuts @senate2026 @murray2026. The American Astronomical Society urged members to thank Congress and seek sustained support @aas2026. By mobilizing constituents @coursecongress2026[sec.~6.6.4], AAS seeks to make science funding a concern legislators hear from voters. The senators' positions give advocates different arguments to use across party lines. A researcher can ask a member to protect work in the member's state without first securing agreement on the administration's broader agenda. That is a practical reason for scientific organizations to organize around particular awards and institutions as well as national budget totals.

The administration argues for fiscal restraint and different research priorities, citing Mars Sample Return's cost escalation @omb2026[pp.~67–69]. Elected officials must be able to redirect spending. My objection is to changing course without accounting for work already funded: a defensible transition should weigh the costs of stopping against those of continuing, explain its scientific consequences, and remain within statutory authority. Continuity deserves weight without guaranteeing permanent funding.

#figure(
  image("figures/nasa_priorities.pdf", width: 100%, alt: "FY2027 NASA budget requests increase Exploration while reducing Science and its divisions, including Astrophysics."),
  placement: none,
  caption: [
    FY2027 requests versus FY2026 funding. Author's calculations from #cite(<nasa2026>, form: "prose", supplement: [p.~BUD-1]) and #cite(<appropriators2026>, form: "prose", supplement: [pp.~52–53]). Nominal budget amounts; division baselines are congressional allocations. Nested categories must not be summed. Separate multiyear mandatory funding is excluded.
  ],
) <fig-nasa>


@fig-nasa shows the administration's choices within a smaller NASA budget: its FY2027 request cuts Science by 46.3% and Astrophysics by 65.4%, while raising Exploration by 9.4%. This is a choice among NASA's activities. Before accepting such a shift, Congress should require NASA to explain which scientific commitments would be abandoned and why the gains in Exploration justify those losses.

Congressional proposals can also reduce research funding. The House Appropriations Committee's May 2026 draft for FY2027 recommended \$7 billion for NSF and \$6 billion for NASA Science, cuts of 20.0% and 17.2% from FY2026 @house2026[pp.~91, 107]. Resisting the president's full proposal did not mean rejecting contraction.

Congress can also direct support to particular missions: it allocated \$300 million to Roman and \$80.5 million to LISA in FY2026 @appropriators2026[p.~53]. Oversight should follow those allocations through construction into operations and research grants, asking what work each amount will support. A mission may need less money once construction ends, yet still need sustained support for the science that follows. For Roman, the research program already offers a concrete object of oversight: Congress can ask whether successive budgets support the investigators selected to use its data.

= Why an appropriation is not enough
The Congress slides distinguish budgeting from oversight @coursecongress2026[secs.~6.5.2–6.5.3]. Budgeting supplies an agency's resources; oversight holds it answerable for how it uses them. NSF's April 2025 priorities statement changed how it treated broader impacts, the expected benefits of research beyond new knowledge. Following a June preliminary injunction, NSF reinstated 114 awards to 45 institutions @nsfpriorities2025. Judicial intervention restored previously approved support. Congress must similarly scrutinize which projects agencies terminate when priorities change.

At NIH, the administration impeded the award process itself. A pause in publishing grant-review meeting notices restricted reviews and new awards; GAO found that NIH had improperly withheld appropriated funds from obligation and expenditure @gao2025. The money was available by law, but NIH was failing to commit it to research. GAO concluded that changing the appropriation required seeking congressional approval. Enforcing that requirement preserves Congress's decision over whether the funding should continue.

#cite(<tham2023>, form: "prose") finds that delayed NIH renewals disrupt spending and that laboratories with additional grants are better buffered. The study finds no statistically significant change in publications, but it does identify a difference in laboratories' ability to absorb delays. Alongside the employment findings of #cite(<tham2026>, form: "prose"), that result supports directing temporary assistance toward teams with little alternative funding. A uniform delay can impose very different burdens on a laboratory dependent on one award and a laboratory able to draw on several. Protecting continuity should begin with the teams least able to bridge the gap themselves.

= A defensible policy response
#cite(<azoulay2019>, form: "prose") find that NIH funding increases private-sector patenting: public support can contribute to private research. Cosmology has a different public rationale: knowledge about the universe and shared observations can benefit researchers beyond the institution paying for them. I favor public support for those questions because their scientific value reaches beyond what any one sponsor can profit from.

I would begin with limited bridge funding for viable projects awaiting renewal, directed toward retaining staff during administrative delays. Eligibility should depend on a pending renewal decision and a documented shortage of alternative support; assistance should end when renewed funding becomes available or the renewal is rejected. Those conditions would address the vulnerability identified in the NIH studies while preserving the agency's responsibility to assess the project.

For longer commitments, multiyear appropriations could reduce annual uncertainty, though they would also commit money future legislators might prefer to redirect. I would favor them where a credible scientific plan requires work across several years, with review at specified stages. Deliberate terminations need a different response: Congress must examine the agency's reasons and authority for ending work already approved.

Congress should require agencies to report award terminations and departures from spending plans, explaining their scientific and policy reasons. The FY2026 statement already requires spending plans and advance notice of workforce reductions @appropriators2026[pp.~1–3]. Committees should use those reports to question officials, seek GAO review of apparent withholding, and legislate clearer restrictions where existing directions prove inadequate. Public explanations would give constituents specific decisions to challenge when seeking congressional intervention. The same obligation should apply when legislators themselves propose reductions, as the House committee did for FY2027. Scientists should ask members to explain the research they are willing to give up, even when those members previously helped defeat a larger presidential cut.

Scientific review belongs in that process because the cost of a reduction includes the work it would end. Agencies should seek an assessment from independent scientific reviewers of a project's remaining value and the consequences of stopping it, then publish the reasons for any decision that departs from that assessment. Elected officials would retain the authority to choose other priorities. They would have to defend that choice against an account of what researchers expect the public to lose.


= Conclusion
Congress deserves credit for resisting the FY2026 cuts, but researchers need funding commitments they can plan around. I would judge congressional protection by whether agencies sustain viable funded work and justify decisions to end it. Passing an appropriation begins that responsibility; following the money into funded projects is how Congress can exercise it. For cosmology, that responsibility lasts through the analysis that turns an instrument's observations into knowledge.


#pagebreak()
#bibliography(bytes(essay-bib), title: "References", style: bibliography-style)
