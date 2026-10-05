.DEFAULT_GOAL := paper
PYTHON ?= python
TYPST ?= typst
export SOURCE_DATE_EPOCH := 1791158400

.PHONY: paper plots prepare proposal clean distclean

# Always revalidate inputs; downloads are cached.
paper: plots
	$(TYPST) compile --ignore-system-fonts --font-path .cache/fonts main.typ

plots:
	$(PYTHON) analysis/make_figures.py

prepare:
	$(PYTHON) analysis/download_sources.py

proposal: prepare
	$(TYPST) compile --ignore-system-fonts --font-path .cache/fonts proposal.typ

clean:
	rm -rf figures .cache/data .cache/analysis .cache/matplotlib
	rm -f main.pdf proposal.pdf

# Only disposable generated directories are removed. Git history is untouched.
distclean: clean
	rm -rf .cache
