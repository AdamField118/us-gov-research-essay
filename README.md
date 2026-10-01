# Who Controls American Science? — Typst project

Both the GOV 1301 research essay and its submitted proposal are now native Typst documents, using Adam Field's [WPI paper template](https://codeberg.org/AdamField118/wpi-paper-template).

## Start here

- `main.typ`: full research essay, Draft 1.
- `proposal.typ`: submitted proposal, with its original prose.
- `style.typ`: shared course configuration.
- `structure.typ` and `theme.typ`: the adapted WPI template.
- `references.bib`: shared bibliography; each document prints only its cited sources.

The essay is eight pages plus two pages of references. The proposal is two pages, including preliminary references. Both use 12-point Iosevka, one column, and double-spaced body text. The template's uppercase headings, Iosevka Extended title, running headers, unindented paragraphs, and page numbering are retained. Captions and bibliographies are single spaced.

## Build with the Typst CLI

Requires **Typst 0.15.0 or newer**, because the figures are embedded directly as vector PDFs. No LaTeX installation, BibTeX pass, external Typst package, or online font download is needed.

```bash
make
```

This produces `build/main.pdf` and `build/proposal.pdf`. Equivalent commands:

```bash
mkdir -p build
typst compile --font-path fonts main.typ build/main.pdf
typst compile --font-path fonts proposal.typ build/proposal.pdf
```

For live previews, use `make watch-essay` or `make watch-proposal`.

## Optional Python build

If you prefer using a Python environment instead of installing the native Typst CLI:

```bash
python -m pip install -r requirements-build.txt
python scripts/build.py
```

This uses the pinned Typst 0.15.0 compiler, bundled fonts, and the same `.typ` files. It builds both documents and reports compiler warnings as failures. It was used for validation here.

## Existing Git repository

Copy this archive's contents into the root of your local repository, keeping your existing `.git` directory. No commit or push is required to compile.

The old root-level `main.tex`, `proposal.tex`, and `agsm.bst` are obsolete after conversion; their unchanged copies are included under `legacy/`, alongside the original bibliography. You can remove those three old root files after copying. The root-level `references.bib` is the active shared file and should be replaced by this version.

Use the included `.gitignore`. It ignores `build/` but deliberately **keeps `figures/*.pdf` tracked**, since those PDFs are source inputs. The template repository's blanket `*.pdf` rule would omit the paper's figures.

## Figures, data, and evidence

The two figures, all numerical inputs, Python analysis, and research notes are unchanged from the LaTeX draft:

- `figures/`: vector PDF figures plus PNG previews.
- `data/`: source CSVs and source identifiers.
- `analysis/`: figure-generation code and derived results.
- `research/evidence.md`: source-by-source findings, limitations, and calculations.
- `research/source_manifest.csv` and `research/source_tables/`: source provenance and selected table images.

To regenerate figures, install the original analysis dependencies and run:

```bash
python -m pip install -r requirements.txt
python analysis/make_figures.py
```

The next document compilation picks up the updated figure PDFs. Monetary amounts remain nominal; the conversion does not alter the paper's research claims or update its budget data.

## Fonts, citation style, and validation

`fonts/` includes the template's actual Iosevka and Iosevka Extended fonts, with their license. Always pass `--font-path fonts` when using the CLI. The native bibliography uses the local `harvard-notes.csl` style, which preserves the original source notes and report locators.

See `TEMPLATE.md` for the exact upstream template commit, modifications, and third-party licenses. See `VALIDATION.md` for the incremental compilation and content checks. `legacy/` is archival and is not used by the build.
