#import "style.typ": paper, references
#show: paper.with()

// Start the essay at Section 0
#set heading(numbering: n => str(n - 1))

= What makes this a funding crisis?
Federal support paid for approximately 56% of academic basic research in the United States in 2023 @nsb2025. This dependence makes the reliability of government funding a scientific as well as a political question. Here, a funding crisis means disruption of support on which ongoing research and training depend, compounded by uncertainty about whether public commitments will be maintained. Rejected applications or disagreement over an agency's budget are not sufficient evidence of such a crisis.

The 2025 record establishes actual interruptions. The Government Accountability Office (GAO) reports that the National Science Foundation (NSF) listed more than 1,600 terminated awards across its directorates and offices as of June 5, citing misalignment with agency priorities @gaonsf2025[appendix IV, table 31 discussion]. In a peer-reviewed analysis of public records, #cite(<oliveira2026>, form: "prose") identify 2,291 National Institutes of Health (NIH) grants terminated between February 28 and August 22, representing approximately \$2.45 billion in remaining funding out of \$5.08 billion originally awarded. These are dated records of cancellations, not a current net total after reinstatements. The NIH study describes affected projects; it does not measure their subsequent scientific losses. Together, the records establish disruption across two major research agencies without showing that every field experienced equal harm.

Peer-reviewed research helps explain why interruptions warrant concern beyond their dollar value. Using linked grant, payroll, tax, Census, and publication records, #cite(<tham2026>, form: "prose") study delayed NIH grant renewals with a difference-in-differences design. They estimate that interruptions of at least 30 days increased nonemployment by three percentage points among personnel in laboratories supported by a single R01 research grant. This evidence concerns earlier funding gaps and U.S. employment, not the effects of the 2025 terminations. It nevertheless indicates that temporary interruptions can affect research careers. Applying that mechanism to astrophysics is an inference; neither study estimates the number of cosmological discoveries lost.

The crisis therefore requires assessing continuity alongside funding levels. The budget comparisons below distinguish enacted reductions, proposals for future cuts, and the shortfall from Congress's authorized NSF growth path. None alone measures the condition of every laboratory. Ending an unsuccessful project can be responsible policy; the critical question is whether decisions use scientific evidence, account for commitments already made, and follow the authority Congress has provided. This framing connects the funding dispute to the course's themes of separation of powers, bureaucratic discretion, and democratic accountability. The essay evaluates whether congressional control of appropriations is sufficient to protect dependable research under changing executive priorities.

= Science as a public commitment
These disruptions raise a question about American government: who can make a research commitment dependable? Congress can reject a president's proposed cuts, but an appropriation does not by itself guarantee continuity for laboratories, students, or observatories. The fiscal year (FY) 2026 funding settlement illustrates both the strength and the limits of congressional intervention. My argument is that protecting basic research requires Congress to sustain appropriations and oversee their implementation, while leaving scientific judgments to accountable expert review. The evidence supports this institutional position more clearly than a general claim that American science has simply run out of money.

The distinction matters for physics and cosmology. Roman's planned wide-area survey uses weak gravitational lensing and galaxy clustering to investigate dark matter and cosmic acceleration @balzer2026. A telescope creates scientific opportunities, but extracting reliable measurements also requires researchers, simulations, and sustained analysis. From my perspective as a physics student working in cosmology, protecting the instrument while destabilizing the people who interpret its data is an incomplete research policy.

This tension predates the current administration. After World War II, Vannevar Bush advocated continuing federal support for basic research, while Senator Harley Kilgore emphasized political accountability and the distribution of opportunities. President Truman vetoed an early NSF bill in 1947 because its proposed governance gave scientists excessive independence from elected authority. NSF's eventual creation in 1950, followed by Cold War expansion, reflected a negotiated relationship between scientific expertise and national priorities @mazuzan. The historical lesson is that public funding and political accountability developed together; complete insulation from government was never the settled arrangement.

= Promises, appropriations, and the size of the rescue
Article I's Appropriations Clause places control of Treasury withdrawals under laws enacted by Congress @constitution. Within that system, an authorization establishes or supports a program and can specify intended funding levels; an appropriation supplies budget authority. A presidential request is a proposal. Obligations are commitments against available funds, and outlays are payments. Treating these stages as interchangeable exaggerates both proposed cuts and legislative victories.

The CHIPS and Science Act authorized a rising NSF funding path for FY2023–FY2027 @chips2022[sec.~10303]. @fig-gap compares that path with appropriations and requests. By FY2026, Congress appropriated \$8.750 billion against an authorization of approximately \$17.832 billion: 49.1% of the authorized amount. The \$9.082 billion difference is an unfulfilled funding benchmark, not money removed from an existing bank account. The widening gap also began before Trump's second administration. Congress therefore shares responsibility for the difference between its science commitments and the resources it supplies.

#figure(
  image(
    "figures/funding_gap.pdf",
    width: 100%,
    alt: "NSF authorizations rise while appropriations remain lower; Congress offsets most proposed FY2026 cuts to NSF and NASA Science.",
  ),
  placement: auto,
  caption: [
    Author's calculations from #cite(<harris2026>, form: "prose"), #cite(<chips2022>, form: "prose"), #cite(<congress2026>, form: "prose"), and #cite(<nasa2025>, form: "prose"), #cite(<nasa2026>, form: "prose"). All dollars are nominal budget authority. FY2023 NSF includes supplemental funding. Panel B uses FY2025 enacted funding as its denominator; the open point and note show the effect of unavailable FY2025 emergency funding. These are administrative amounts, not statistical estimates.
  ],
) <fig-gap>


Nevertheless, the FY2026 intervention was substantial. Relative to FY2025 enacted amounts, the president requested a 56.9% NSF reduction and a 46.7% NASA Science reduction. The final amounts were only 3.4% and 1.1% lower, respectively. Congress offset approximately 94.0% of the proposed NSF reduction and 97.5% of the NASA Science reduction, calculated as the increase from request to enactment divided by the initially proposed reduction. President Trump signed the resulting appropriations law on January 23, 2026 @congress2026. These outcomes demonstrate functioning checks and balances, even though preventing a much larger cut did not restore the authorized growth path.

Accounting choices affect the comparison. NSF's FY2025 enacted \$9.060 billion included \$234 million in emergency construction funding that the president did not make available. Using the adjusted \$8.826 billion baseline makes the FY2026 decline 0.9%, rather than 3.4% @harris2026[pp.~2–4]. Neither calculation measures inflation-adjusted purchasing power. The figures use nominal amounts consistently and do not equate agency budgets with grants received by individual scientists.

= Which science do political institutions protect?
Support for the FY2026 settlement crossed party lines. Republican Senators Susan Collins and Jerry Moran defended research funding in terms of competitiveness, national priorities, and benefits to their constituents; Democratic Senator Patty Murray emphasized resisting the administration's reductions and restoring congressional direction @senate2026 @murray2026. Their statements suggest overlapping reasons for cooperation, not agreement on every research program. The American Astronomical Society urged members to thank Congress and seek sustained support, illustrating how scientific organizations translate professional interests into political participation @aas2026. These public appeals establish advocacy, but cannot identify how much lobbying changed the vote.

The administration's alternative also deserves accurate characterization. Its FY2027 budget argues for fiscal restraint, commercial approaches, and concentrating NASA resources on selected missions. It identifies cost escalation in Mars Sample Return as a justification for ending the existing approach @omb2026[pp.~67–69]. Budget constraints and failed projects are legitimate concerns. They do not, by themselves, establish that broad reductions across unrelated research fields are the best response.

#figure(
  image(
    "figures/nasa_priorities.pdf",
    width: 100%,
    alt: "FY2027 NASA budget requests increase Exploration while reducing Science and its divisions, including Astrophysics.",
  ),
  placement: auto,
  caption: [
    FY2027 presidential requests compared with FY2026 funding. Author's calculations from #cite(<nasa2026>, form: "prose", supplement: [p.~BUD-1]) and the FY2026 joint explanatory statement @appropriators2026[pp.~52–53]. Division baselines are congressional allocations, not reported cash expenditures. Science divisions are nested within Science, which is nested within NASA; rows must not be summed. Separate multiyear mandatory funding is excluded.
  ],
) <fig-nasa>


@fig-nasa reveals a choice among priorities. The FY2027 request reduces NASA's regular agency budget by 23.0%, but Science by 46.3% and Astrophysics by 65.4%, while increasing Exploration by 9.4%. These are proposed changes, not FY2027 enacted outcomes. Comparing percentage changes across consistent categories exposes a redistribution that the agency total obscures. Because the figure excludes separate mandatory funding, it describes the regular budget proposal rather than all resources available for human spaceflight.

Congress is not a uniform counterweight. The House Appropriations Committee's May 2026 draft report recommended \$7 billion for NSF and \$6 billion for NASA Science in FY2027, reductions of 20.0% and 17.2% from FY2026 @house2026[pp.~91, 107]. This proposal resisted the administration's full reductions while still supporting substantial contraction. It is evidence about a committee's position at that stage, not a final legislative outcome.

For cosmology, the relevant objective is a working research system rather than a protected headline total. The FY2026 congressional statement allocated \$300 million to Roman and \$80.5 million to LISA, alongside \$1.595 billion for Astrophysics overall @appropriators2026[p.~53]. Such allocations make legislative priorities concrete. However, a project's annual funding can fall as construction ends; a smaller mission line is not automatically a scientific retreat. Sustained analysis capacity and the project's life-cycle needs must also be examined.

= Why an appropriation is not enough
Executive administration can affect research before the next budget becomes law. NSF's April 2025 priorities statement changed how the agency interpreted acceptable broader impacts. Its subsequent guidance describes award terminations and the reinstatement of 114 awards to 45 institutions following a June 2025 preliminary injunction @nsfpriorities2025. This record establishes that administrative decisions can interrupt individual projects and that judicial intervention can constrain them. It does not establish the legality of every termination or quantify harm to astrophysics specifically.

The Government Accountability Office reached a related conclusion in a different agency: NIH's withholding of appropriated grant funds violated the Impoundment Control Act. GAO emphasized that an administration seeking to cancel appropriations should pursue rescission or other legislation @gao2025. This is a GAO decision about NIH, not a court judgment about NSF. Its relevance is the institutional distinction between revising policy through law and obstructing implementation of existing funding commitments.

Evidence about researchers strengthens the case for continuity, but also limits what can be claimed. #cite(<tham2023>, form: "prose") uses a difference-in-differences design to compare interrupted and uninterrupted NIH grant renewals. Laboratories with one R01 grant experienced pronounced spending disruptions, while additional grants provided a buffer. Yet the study's publication estimates were not statistically distinguishable from zero. This supports concern about laboratory operations and staff support; it cannot supply a numerical estimate of discoveries lost to NSF cuts. Applying the mechanism to cosmology is a reasoned inference, not a result measured in that study.

= A defensible policy response
Given the federal share of academic basic research established above, replacing public support would require decisions about which questions private sponsors are willing to finance. #cite(<azoulay2019>, form: "prose") find that additional NIH funding increases private-sector patenting, providing evidence that public and private research can complement each other. Their biomedical result does not establish a corresponding financial return for cosmology, whose value also includes fundamental knowledge and shared observational capabilities.

I favor a combination of dependable funding and enforceable review. First, Congress should pair realistic multiyear research plans with appropriations that can sustain them. Aspirational authorizations alone invite commitments that laboratories cannot safely make. Where appropriate, multiyear budget authority or limited bridge funding could reduce interruptions; neither should guarantee indefinite support for an unsuccessful project.

Second, oversight should follow the money beyond enactment. Congress should require accessible reporting of obligations, terminations, reinstatements, and material deviations from spending plans, with explanations that distinguish scientific review from changes in political priorities. The FY2026 statement already specifies spending plans, reprogramming procedures, and advance notification of workforce reductions @appropriators2026[pp.~1–3]. These mechanisms provide a starting point, although their effectiveness depends on compliance and congressional follow-through.

Third, evaluation should protect both research quality and democratic choice. Independent scientific assessments should inform decisions about continuing or ending missions, while elected officials remain responsible for the overall public commitment and opportunity costs. Agencies should explain how proposed reductions affect facilities, analysis grants, and training together. This would make restraint assessable without treating immediate commercial usefulness as the sole measure of basic research.

= Conclusion
Congress can protect federal science from presidential retrenchment, as the FY2026 settlement demonstrates. The evidence also shows why that protection is incomplete: appropriations fell far short of authorized ambitions, committees differed over acceptable reductions, and administrative decisions affected existing awards. My position is that the United States should preserve dependable support for basic research through funded commitments, transparent implementation, and scientific review. For astrophysics and cosmology, a successful policy must sustain the full path from an instrument to a credible measurement. Defending that path requires accountability for how public money is chosen, provided, and actually used.


#pagebreak()
#references()
