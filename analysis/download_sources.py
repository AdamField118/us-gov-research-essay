"""Download and hash-check pinned source documents. Existing files are checked too.
Run: python analysis/download_sources.py
Plots use checked-in CSVs and require no network or PDF/Excel libraries.
"""
from pathlib import Path
import hashlib
import json
import urllib.request
ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'research/raw'
OUT.mkdir(exist_ok=True)
for row in json.loads((ROOT/'research/ten_year_sources.json').read_text()):
    dest=OUT/row['file']
    if dest.exists():
        payload=dest.read_bytes()
    else:
        request=urllib.request.Request(row['url'],headers={'User-Agent':'Academic budget research'})
        with urllib.request.urlopen(request,timeout=90) as response:
            payload=response.read()
    if hashlib.sha256(payload).hexdigest()!=row['sha256']:
        raise ValueError(f"Source changed: {row['file']}; inspect before updating the pinned dataset")
    if not dest.exists():
        dest.write_bytes(payload)
    print(f"Verified {row['file']}")
