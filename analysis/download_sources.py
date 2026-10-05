"""Fetch pinned sources and original template fonts into an ignored cache.

Existing bytes are checked too. Changed publisher bytes cause a hard failure.
Delete a corrupted cache entry to redownload; review before changing any pin.
"""
from concurrent.futures import ThreadPoolExecutor
import hashlib
from pathlib import Path
import tempfile
import time
import urllib.error
import urllib.request

from inputs import SOURCES, FONTS

ROOT = Path(__file__).resolve().parents[1]
CACHE = ROOT / ".cache"


def fetch(name, url, digest, directory):
    directory.mkdir(parents=True, exist_ok=True)
    dest = directory / name
    if dest.exists():
        payload = dest.read_bytes()
    else:
        for attempt in range(3):
            try:
                request = urllib.request.Request(url, headers={"User-Agent": "NSF-essay-reproducible-build/1.0"})
                with urllib.request.urlopen(request, timeout=60) as response:
                    payload = response.read()
                break
            except (urllib.error.URLError, TimeoutError):
                if attempt == 2:
                    raise
                time.sleep(attempt + 1)
    actual = hashlib.sha256(payload).hexdigest()
    if actual != digest:
        raise ValueError(f"SHA-256 mismatch for {name}: expected {digest}, got {actual}. "
                         "Build stopped; inspect the source before changing its pin.")
    if not dest.exists():
        with tempfile.NamedTemporaryFile(dir=directory, delete=False) as tmp:
            tmp.write(payload)
            pending = Path(tmp.name)
        pending.replace(dest)
        print(f"Downloaded and verified {name}")
    return dest


def prepare():
    tasks = [(name, url, digest, CACHE / kind)
             for kind, manifest in [("raw", SOURCES), ("fonts", FONTS)]
             for name, (url, digest) in manifest.items()]
    with ThreadPoolExecutor(max_workers=4) as pool:
        list(pool.map(lambda args: fetch(*args), tasks))


if __name__ == "__main__":
    prepare()
