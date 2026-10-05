"""Read observations from pinned government PDFs and the OMB workbook.

No budget arrays are embedded. PDF page numbers are one-based. Hash-checked
sources and table-specific parsers fail closed when a document changes.
NSF: R48783 v2 tables A-1/1/6; P.L.119-74 pp.41-42.
NASA: R43419 v68/v104 table 1; FY26/FY27 BUD-1; FY26 JES p.52.
GDP: FY27 OMB table 10.1, column C, fiscal-year chained price index.
"""
import re
import warnings

import numpy as np
import pandas as pd
import pymupdf
import openpyxl

from download_sources import CACHE, prepare


def page(name, number):
    with pymupdf.open(CACHE / "raw" / name) as pdf:
        return pdf[number - 1].get_text(sort=True)


def number(token):
    if token in {"n/a", "--", "—"}:
        return np.nan
    return float(re.sub(r"[a-z$]", "", token.replace(",", "")))


def table_row(text, label, count):
    rows = re.findall(r"^[ \t]*" + re.escape(label) + r"[ \t]+((?=[$\d—-]|n/a).+)$", text, re.M)
    if not rows:
        raise ValueError(f"Missing table row {label!r}")
    values = [[number(v) for v in row.split()] for row in rows]
    if any(len(v) != count for v in values):
        raise ValueError(f"Unexpected columns: {label!r}")
    for value in values[1:]:
        np.testing.assert_allclose(value, values[0], equal_nan=True)
    return values[0]


def extract_nsf():
    history = page("crs_nsf.pdf", 29)
    rows = []
    for year in range(2017, 2027):
        auth, request, baseline, *_ = table_row(history, str(year), 6)
        rows.append(dict(fiscal_year=year, request_musd=request,
                         appropriation_musd=baseline, baseline_musd=baseline,
                         authorization_musd=auth, unavailable_emergency_musd=0.0))
    df = pd.DataFrame(rows).set_index("fiscal_year")
    # Preserve the reported total, not the sum of rounded components.
    match = re.search(r"total FY2023\s+appropriations to NSF were \$([\d.]+) billion", history)
    if not match:
        raise ValueError("Missing FY2023 supplemental-total footnote")
    df.loc[2023, "appropriation_musd"] = float(match[1]) * 1000
    current = page("crs_nsf.pdf", 8)
    row = re.search(r"NSF,\s+Total\w*\s+([\d,.]+)\s+([\d,.]+)\s+([\d,.]+)", current)
    if not row:
        raise ValueError("Missing NSF table 1 total")
    df.loc[2026, "request_musd"] = number(row[3])
    unavailable = re.search(r"Congress appropriated \$([\d,.]+) million for MREFC in FY2025", current)
    if not unavailable:
        raise ValueError("Missing FY2025 unavailable-emergency appropriation note")
    df.loc[2025, "unavailable_emergency_musd"] = number(unavailable[1])
    # First dollar amount per account is its appropriation; later provisos
    # partition it. Do not sum all dollar figures in the law.
    law = page("pl11974.pdf", 41) + "\n" + page("pl11974.pdf", 42)
    law = law.split("NATIONAL SCIENCE FOUNDATION", 1)[1]
    accounts = ["RESEARCH AND RELATED ACTIVITIES",
                "MAJOR RESEARCH EQUIPMENT AND FACILITIES CONSTRUCTION",
                "STEM EDUCATION", "AGENCY OPERATIONS AND AWARD MANAGEMENT",
                "OFFICE OF THE NATIONAL SCIENCE BOARD", "OFFICE OF INSPECTOR GENERAL"]
    amounts = []
    for i, label in enumerate(accounts):
        section = law.split(label, 1)[1].split(accounts[i + 1] if i < 5 else "ADMINISTRATIVE PROVISIONS", 1)[0]
        value = re.search(r"\$([\d,]+)", section)
        if not value:
            raise ValueError(f"Missing appropriation for {label}")
        amounts.append(number(value[1]) / 1e6)
    df.loc[2026, ["appropriation_musd", "baseline_musd"]] = sum(amounts)
    authorized = table_row(page("crs_nsf.pdf", 21), "NSF, Total", 5)
    np.testing.assert_allclose(df.loc[2023:2026, "authorization_musd"], authorized[:4])
    return df.reset_index()


def extract_nasa():
    old, new = page("nasa_fy2026.pdf", 2), page("nasa_fy2027.pdf", 2)
    jes = page("jes2026.pdf", 52)
    accounts = {"NASA total": "NASA Total", "Science": "Science",
                "Earth science": "Earth Science", "Planetary science": "Planetary Science",
                "Astrophysics": "Astrophysics", "Heliophysics": "Heliophysics",
                "Biological and physical sciences": "Biological and Physical Sciences",
                "Exploration": "Exploration"}
    rows = []
    for account, label in accounts.items():
        before, after = table_row(old, label, 7), table_row(new, label, 7)
        division = account not in {"NASA total", "Science", "Exploration"}
        enacted = after[1]
        if division:
            # OCR spaces inside amounts, e.g. '2,54 1,200', are removed.
            jes_label = label.removesuffix("s") if label.endswith("Sciences") else label
            line = re.search(r"^\s*" + re.escape(jes_label) + r"[^\n]*?([\d][\d, ]+)\s*$", jes, re.M)
            if not line:
                raise ValueError(f"Missing NASA JES row {label}")
            enacted = float(re.sub(r"[, ]", "", line[1])) / 1000
        rows.append(dict(account=account, level="division" if division else "agency" if account == "NASA total" else "account",
                         fy2025_enacted_musd=after[0], fy2026_request_musd=before[2],
                         fy2026_enacted_musd=enacted, fy2027_request_musd=after[2]))
    nasa = pd.DataFrame(rows)
    history = []
    for account in ["Science", "Exploration"]:
        early = table_row(page("nasa_history_2019.pdf", 4), account, 6)
        later = table_row(page("nasa_history_2024.pdf", 4), account, 6)
        recent = nasa.set_index("account").loc[account]
        values = early[3:5] + later + [recent.fy2025_enacted_musd, recent.fy2026_enacted_musd]
        history.extend(dict(fiscal_year=year, account=account, budget_authority_musd=value)
                       for year, value in zip(range(2017, 2027), values, strict=True))
    # Preserve published account boundaries/adjusted authority, not outlays
    # or a constant-program basket. Separate mandatory funding is excluded.
    return nasa, pd.DataFrame(history).sort_values(["fiscal_year", "account"])


def extract_deflators():
    with warnings.catch_warnings():
        warnings.filterwarnings("ignore", message="Workbook contains no default style")
        book = openpyxl.load_workbook(CACHE / "raw" / "omb_deflators_fy2027.xlsx", data_only=True)
    rows = []
    for row in book.active.values:
        match = re.fullmatch(r"(20\d\d)( estimate)?", str(row[0]))
        if match and 2017 <= int(match[1]) <= 2027:
            rows.append(dict(fiscal_year=int(match[1]), gdp_price_index_fy2017_1=float(row[2]),
                             estimate=bool(match[2])))
    book.close()
    df = pd.DataFrame(rows)
    if df.fiscal_year.tolist() != list(range(2017, 2028)):
        raise ValueError("Incomplete or reordered GDP deflator table")
    return df


def extract():
    prepare()
    out = CACHE / "data"
    out.mkdir(parents=True, exist_ok=True)
    nasa, history = extract_nasa()
    tables = {"nsf_budget": extract_nsf(), "nasa_budget": nasa,
              "nasa_history": history, "gdp_deflators": extract_deflators()}
    for name, df in tables.items():
        df.to_csv(out / f"{name}.csv", index=False)
    print("Extracted source tables into .cache/data")
    return tables


if __name__ == "__main__":
    extract()
