NSF funding protection revision — October 5, 2026

Apply these changed files to repository HEAD 4bb4d87a0a6a9f7a2daa595469fc8feb66ecb6ce. Preserve the existing fonts, template files, proposal.typ, and other unchanged files. This archive includes the ten-year data/plot changes and the focused manuscript revision. Nothing was pushed.

Compile: typst compile --font-path fonts main.typ build/main.pdf
Requires Typst 0.15.0 or newer for PDF figures.

Rebuild plots: python analysis/make_figures.py
Restore pinned primary-source PDFs/workbook: python analysis/download_sources.py

The checked essay is ten body pages plus three reference pages. The submitted proposal source was not edited. Review and methods notes are in research/.
