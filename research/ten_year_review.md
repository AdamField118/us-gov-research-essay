# Review and validation — 5 October 2026

Base commit: 4bb4d87a0a6a9f7a2daa595469fc8feb66ecb6ce.

An independent simulated professor reviewer read the current main.typ, the narrowing options, methods and generated metrics. This is distinct from the actual professor's A and brief breadth comment.

Recommendation: Option 1 is the strongest immediately supported case, with one agency and three separate benchmarks. Option 3 best preserves the current institutional concern; Option 2 best serves a NASA-focused interest. The author should choose before the central essay argument is rewritten.

Implemented review corrections:
- Replaced the binary 'preserve funding or purchasing power' question with a question about the benchmarks for evaluating congressional protection.
- Clarified that grant-level data are necessary for quantifying losses, not for every institutional argument about oversight.

Retain during the next writing pass:
- Endpoint decline does not mean uninterrupted decline.
- The FY2026 GDP price index is an estimate; also report FY2025 comparisons.
- The 94.0% congressional offset uses FY2025 enacted authority, including unavailable emergency funding.
- The CHIPS gap is a gap from an authorized goal, not missing money or proof of illegal withholding.
- NASA comparisons retain the BPS account transfer and exclude separately provided multiyear mandatory money.
- Historical panels have not yet been made the centerpiece of the existing manuscript's argument; selecting the thesis determines which panel needs sustained interpretation.

Verification:
- Fetched origin/main and created a separate worktree; previous uncommitted work preserved.
- Added FY2017–FY2022 NSF rows checked programmatically against the downloaded CRS PDF table.
- NASA FY2017–FY2024 account values checked programmatically against both downloaded CRS PDF tables.
- OMB fiscal-year GDP indices extracted from the actual downloaded workbook, preserving estimate labels.
- All eight pinned raw documents match recorded SHA-256 hashes.
- Coverage, duplicate, positivity, NASA division sum and overlapping-year checks pass in the figure script.
- Both figures rendered and visually inspected, including their placement and captions in the actual Typst paper.
- The main Typst document compiles without warnings. The submitted proposal and template settings are unchanged.

The current PDF is a working figure preview in the existing essay, not a completed rewrite around a newly chosen thesis. No changes were pushed to GitHub.
