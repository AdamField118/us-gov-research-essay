# What Did Congress Protect? — Typst project

Both the GOV 1301 research essay and its submitted proposal are now native Typst documents, using Adam Field's [WPI paper template](https://codeberg.org/AdamField118/wpi-paper-template).

## Start here

- `main.typ`: full research essay, revised through two professor-style review rounds.
- `proposal.typ`: submitted proposal, with its original prose.
- `style.typ`: shared course configuration.
- `structure.typ` and `theme.typ`: the adapted WPI template.
- `references.bib`: shared bibliography; each document prints only its cited sources.

The essay now begins with Section 0, which establishes the funding crisis through documented award terminations and peer-reviewed research on funding interruptions. The revised draft is not constrained to a strict seven-page body. The proposal is two pages, including preliminary references. Both use 12-point Iosevka, one column, and double-spaced body text. The template's uppercase headings, Iosevka Extended title, running headers, unindented paragraphs, and page numbering are retained. Captions and bibliographies are single spaced.

## Build with the Typst CLI

Requires **Typst 0.15.0 or newer**, because the figures are embedded directly as vector PDFs. No LaTeX installation, BibTeX pass, external Typst package, or online font download is needed.

```bash
mkdir -p build
typst compile --font-path fonts main.typ build/main.pdf
typst compile --font-path fonts proposal.typ build/proposal.pdf
```

## Existing Git repository

Copy the changed files into the root of your existing repository, retaining its fonts, figures, data, and template files. No commit or push is required to compile. `references.bib` is shared by the essay and proposal; each prints only its cited sources.

## Figures, data, and evidence

The figures now cover FY2017–FY2026, using the ShearNet navy/gold palette and concise labels. Captions carry methodological explanations. FY2027 requests remain separate from enacted history. The research notes record the evidence and scope options:

- `figures/`: vector PDF figures plus PNG previews.
- `data/`: source CSVs and source identifiers.
- `analysis/`: figure-generation code and derived results.
- `research/evidence.md`: source-by-source findings, limitations, and calculations.
- `research/narrowing_options.md`: the options considered before selecting the NSF argument.
- `research/nsf_argument_loop.md`: the chosen argument, evidence checks, independent review findings, and stopping decision.
- `research/ten_year_methods.md`: series definitions, inflation adjustment and accounting caveats.
- `research/ten_year_sources.json`: pinned downloads and SHA-256 checksums.
- `analysis/ten_year_budget.csv`: nominal and constant-FY2025 values.
- `analysis/download_sources.py`: restore and verify the raw-source cache.
- `research/source_manifest.csv` and `research/source_tables/`: source provenance and selected table images.

To regenerate figures, install the original analysis dependencies and run:

```bash
python -m pip install -r requirements.txt
python analysis/make_figures.py
```

The next document compilation picks up the updated figure PDFs. Real values use OMB’s FY2027 GDP price index; FY2026 uses an estimated deflator, marked with open endpoints. The essay now centers on NSF funding protection: congressional resistance to proposed cuts, purchasing power over a decade, and the gap between authorization and appropriation. NASA priorities and grant continuity support that argument; a fiscal-discretion counterargument is addressed directly. The submitted proposal is unchanged.

To download the pinned source PDFs/workbook for auditing, run `python analysis/download_sources.py`. Figure generation uses the included CSVs and needs no network connection or Excel/PDF libraries.

## Fonts, citation style, and validation

`fonts/` includes the template's actual Iosevka and Iosevka Extended fonts, with their license. Always pass `--font-path fonts` when using the CLI. The native bibliography uses the local `harvard-notes.csl` style, which preserves the original source notes and report locators.

See `research/ten_year_review.md` for data/figure validation and `research/nsf_argument_loop.md` for the manuscript review. The final essay contains ten body pages and three reference pages. Both essay and proposal compile without warnings.
