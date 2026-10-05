# What Did Congress Protect?

## Build

```sh
git clone https://github.com/AdamField118/us-gov-research-essay.git
cd us-gov-research-essay
nix develop
make
```

Produces `main.pdf`. Or run the two steps yourself inside the shell:

```sh
python analysis/make_figures.py
typst compile main.typ
```

Noninteractive: `nix develop -c make`. Proposal: `make proposal`.
No pip, uv, virtual environment, system Python, or OS configuration change is
needed. The flake supplies Python and all five libraries, Typst, and Make.
`flake.lock` pins Nixpkgs to the revision in Adam's supplied NixOS lockfile.
Linux x86-64 and ARM64 shells are defined; validation was on x86-64.

## What is stored

Only Python, Typst, bibliography/citation-style source, and build configuration
are tracked. The first run downloads eight government PDFs/XLSX and the original
Iosevka font files (including their license). URLs and SHA-256 pins live in
`analysis/inputs.py`; fonts use an immutable historical template commit.
All cached bytes are checked on every run. Network or hash failures stop the
build instead of substituting newer data. Subsequent builds work offline once
the Nix environment and downloads are cached.

`analysis/extract_data.py` reads the financial observations from those sources.
It preserves the NSF FY2023 supplemental total, FY2025 emergency-funding
adjustment, and OMB's FY2026 estimate flag. The plots retain the existing
FY2017–FY2026 period, source account boundaries, and constant-FY2025 calculation.
No hand-entered CSV is needed. Publisher revisions require an explicit pin and
parser review; this is a reproducible snapshot, not a live budget feed.

Generated files go to `.cache/` (raw inputs, fonts, extracted CSVs, metrics),
`figures/` (PDF/PNG plots), and the root (compiled PDFs), all ignored by Git.
The short `references.bib` and `harvard-notes.csl` files are required citation
source, not downloaded research archives.

`make clean` removes generated results but keeps downloads. `make distclean`
also removes downloads. Neither removes source files or Git history.
Deleting tracked artifacts reduces the current tree, not historical Git objects;
use `git clone --depth 1` after committing/pushing this cleanup for a small fresh
checkout. This patch does not rewrite history or push changes.
