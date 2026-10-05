# Who Controls American Science? — Typst project

Both the GOV 1301 research essay and its submitted proposal are now native Typst documents, using Adam Field's [WPI paper template](https://codeberg.org/AdamField118/wpi-paper-template).

## Start here

- `main.typ`: full research essay, revised through two professor-style review rounds.
- `proposal.typ`: submitted proposal, with its original prose.
- `style.typ`: shared course configuration.
- `structure.typ` and `theme.typ`: the adapted WPI template.
- `references.bib`: shared bibliography; each document prints only its cited sources.

The essay now begins with Section 0, which establishes the funding crisis through documented award terminations and peer-reviewed research on funding interruptions. It is seven pages plus three pages of references, matching the syllabus’s approximate seven-page body requirement. The proposal is two pages, including preliminary references. Both use 12-point Iosevka, one column, and double-spaced body text. The template's uppercase headings, Iosevka Extended title, running headers, unindented paragraphs, and page numbering are retained. Captions and bibliographies are single spaced.

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

The two figures, budget inputs, and Python analysis are unchanged from the LaTeX draft. The research notes record the evidence, its limitations, and the editorial review:

- `figures/`: vector PDF figures plus PNG previews.
- `data/`: source CSVs and source identifiers.
- `analysis/`: figure-generation code and derived results.
- `research/evidence.md`: source-by-source findings, limitations, and calculations.
- `research/editorial_review.md`: reviewer findings, revisions, and stopping criteria.
- `research/source_manifest.csv` and `research/source_tables/`: source provenance and selected table images.

To regenerate figures, install the original analysis dependencies and run:

```bash
python -m pip install -r requirements.txt
python analysis/make_figures.py
```

The next document compilation picks up the updated figure PDFs. Monetary amounts remain nominal; the conversion does not alter the paper's research claims or update its budget data.

## Fonts, citation style, and validation

`fonts/` includes the template's actual Iosevka and Iosevka Extended fonts, with their license. Always pass `--font-path fonts` when using the CLI. The native bibliography uses the local `harvard-notes.csl` style, which preserves the original source notes and report locators.

See `VALIDATION.md` for the compilation, proposal regression check, and all-page visual review.
