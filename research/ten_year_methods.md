# Ten-year data and figure revision — 5 October 2026

## Scope and reproducibility

Base: origin/main, `4bb4d87a0a6a9f7a2daa595469fc8feb66ecb6ce` ("almost done").
Work occurs in a separate worktree, preserving earlier uncommitted edits.
The window is FY2017–FY2026: ten annual observations, nine annual changes.
FY2027 requests remain a separate cross-section. No proposal is treated as an enacted budget.
The essay's thesis and the submitted proposal are not rewritten in this pass.

- `python analysis/make_figures.py`: regenerate both PDF/PNG figures, transformed CSV and metrics offline.
- `python analysis/download_sources.py`: download/hash-check the exact source documents.
- `research/ten_year_sources.json`: URLs, retrieval dates, byte counts and SHA-256.
- `research/source_tables/*.txt`: extracted table pages for checking transcriptions.
- `data/gdp_deflators.csv`: GDP chained price index, column C of OMB's downloaded FY2027 Table 10.1. FY2017=1.000; `estimate` preserves the workbook's explicit flag.

The current NASA request PDFs and NSF report were already downloaded on September 24 and are reused with their original retrieval dates. The two historical NASA reports and OMB workbook were downloaded October 5. Full documents are cached under `research/raw/` and can be restored using the downloader. They are excluded from git; the small CSVs, manifests and table extracts are committed inputs.

## NSF

FY2017–FY2025 requested/appropriated values come from Harris (2026), R48783 version 2, Table A-1 (printed p.25/PDF p.29). Its appropriation column incorporates adjustments and most closely aligns with approved current plans, rather than measuring expenditures. FY2026 enacted funding is the six-account sum in P.L.119-74. FY2026 request retains Table 1's $3,903.2 million precision. Earlier years are rounded millions.

The authorization line begins in FY2023. Blank earlier authorizations mean unavailable/not part of this CHIPS series, never zero. FY2024 request excludes the additional proposed mandatory funding, as in the existing series.

FY2023's $9,877 million includes the supplement. Table A-1 gives a baseline of $8,837 million and a $1,038 million supplement but reports $9,877 million for the combined amount. Preserve each reported number rather than silently forcing rounded components to sum. The separate `baseline_musd` value records the $8,837 million sensitivity point.

FY2025's $9,060 million enacted amount includes $234 million emergency MREFC funding that was not made available. The sensitivity point is $8,826 million. Do not subtract this adjustment from other fiscal years. A decline from FY2023's temporary supplemented peak must not be described as a recurring-base cut of the same size.

## NASA

`data/nasa_history.csv` includes Science and Exploration only:

- FY2017–FY2018: Morgan (2019), R43419 version 68, Table 1.
- FY2019–FY2024: Morgan and Lindbergh (2024), R43419 version 104, Table 1. Historical values incorporate appropriations, transfers, reprogramming and other adjustments as reported; FY2024 is enacted.
- FY2025–FY2026: NASA FY2027 request, BUD-1, columns explicitly labelled enacted. They are not FY2027 projections.

These are budget-authority measures, not outlays or grant obligations. Historical adjusted authority and newly enacted amounts have different finality; the series preserves source definitions rather than labelling everything final expenditure. The ten-year comparison is descriptive, not a constant-program basket.

CRS leaves FY2020 Science unadjusted for a $70 million rescission of prior-year unobligated balances. Biological and Physical Sciences moved from Space Operations into Science around FY2021 (the 2024 table shows a $5 million transitional entry in FY2020 and $79 million in FY2021). This adds activities to Science; it is not all organic growth. Webb was separately reported through FY2022 and included in Astrophysics from FY2023. We therefore do not splice the raw Astrophysics rows into a misleading ten-year trend.

Separate multiyear mandatory funding is excluded from the FY2025–FY2027 comparisons. Within the FY2027 cross-section, division baselines come from the joint explanatory statement; total Science includes its five divisions, so the rows must not be added together.

## Inflation, calculations and inference

Constant FY2025 amount = nominal amount × GDP price index(FY2025) / GDP price index(year).
Use the current downloaded OMB FY2027 index consistently across NSF and NASA; do not mix in CRS's earlier FY2025-vintage deflator. The OMB workbook explicitly marks FY2026 and later values as estimates. Open final markers and dotted final segments retain that uncertainty visually, and the captions explain it. Real FY2017–FY2025 comparisons are also exported so the result can be assessed without that estimate.

GDP deflation measures broad purchasing power, not a laboratory-specific cost basket. Budget authority can support equipment, facilities, staffing, operations and research; an 11.5% real-budget decline is not a measurement of 11.5% fewer scientists or discoveries. These ten observations justify descriptive comparisons. No regression p-values, causal estimates of presidential effects, or invented statistical error bars are supplied.

FY2026 congressional offset = (enacted − requested)/(FY2025 enacted − requested). NSF is 94.0%; NASA Science 97.5%. This measures how much of a proposed reduction was offset against a specified baseline. It is not a causal attribution to a party, committee, senator or lobbying group.

## Visual choices

Palette follows Adam's `shearnet-paper-plots/results/paper_colors.py`, tree `2c088255eb8397fd4e5e4ef988899d084032ba90`: navy #003F5C and gold #C88700, plus gray. Distinct lines/markers support grayscale and color-vision accessibility. No text paragraphs, numeric mini-tables or repeated value annotations inside the axes. Captions supply sources, units, policy status, account boundaries and adjustments. Fonts use a portable Matplotlib fallback; there is no new TeX or superbit_lensing dependency.
