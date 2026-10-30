#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# ///

"""Refresh a source's `upstream/` from the commit its `source.json` pins.

    uv run tools/import.py bgfx                 # re-import at the pinned commit
    uv run tools/import.py bgfx --commit <sha>  # move the pin, then re-import

`upstream/` is replaced wholesale, so nothing of ours may live in it: translations go in `shaders/`, extra license texts in `licenses/`.
The files are copied byte for byte; `include` and `exclude` are globs relative to the upstream root, where `**` spans directories.
"""

from __future__ import annotations

import argparse
import fnmatch
import json
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def _git_bytes(cwd: Path, *argv: str) -> bytes:
    proc = subprocess.run(["git", *argv], cwd=cwd, capture_output=True)
    if proc.returncode != 0:
        sys.exit(f"git {' '.join(argv)}: {proc.stderr.decode(errors='replace').strip()}")
    return proc.stdout


def _git(cwd: Path, *argv: str) -> str:
    return _git_bytes(cwd, *argv).decode("utf-8", errors="replace").strip()


def _matches(rel: str, globs: list[str]) -> bool:
    # fnmatch's `*` already crosses `/`, so `**/` only needs to also match zero directories.
    return any(fnmatch.fnmatchcase(rel, g) or fnmatch.fnmatchcase(rel, g.replace("**/", "")) for g in globs)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("source", help="a directory name under sources/")
    parser.add_argument("--commit", help="move the pin to this upstream commit first")
    args = parser.parse_args()

    src = ROOT / "sources" / args.source
    manifest_path = src / "source.json"
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    commit = args.commit or manifest["commit"]

    # Blobs are read straight from the object store, never through a checkout:
    # a checkout applies core.autocrlf and upstream's .gitattributes, and the copy would no longer be the bytes upstream committed.
    with tempfile.TemporaryDirectory() as tmp:
        repo = Path(tmp)
        _git(repo, "init", "-q", "--bare")
        _git(repo, "fetch", "-q", "--depth", "1", manifest["upstream"], commit)
        resolved = _git(repo, "rev-parse", "FETCH_HEAD")
        date = _git(repo, "log", "-1", "--format=%cs", resolved)

        blobs = {}
        for entry in _git_bytes(repo, "ls-tree", "-r", "-z", resolved).split(b"\0"):
            if not entry:
                continue
            meta, rel = entry.decode("utf-8").split("\t", 1)
            _mode, kind, sha = meta.split()
            if kind == "blob":
                blobs[rel] = sha
        files = sorted(rel for rel in blobs
                       if _matches(rel, manifest["include"]) and not _matches(rel, manifest.get("exclude", [])))
        if not files:
            sys.exit("no upstream file matches `include`")

        upstream = src / "upstream"
        shutil.rmtree(upstream, ignore_errors=True)
        for rel in files:
            (upstream / rel).parent.mkdir(parents=True, exist_ok=True)
            (upstream / rel).write_bytes(_git_bytes(repo, "cat-file", "blob", blobs[rel]))
        (src / "LICENSE").write_bytes(_git_bytes(repo, "cat-file", "blob", blobs[manifest["license_file"]]))

    manifest["commit"] = resolved
    manifest["date"] = date
    manifest_path.write_text(json.dumps(manifest, indent=4, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
    print(f"{args.source}: {len(files)} files at {resolved[:10]} ({date})")


if __name__ == "__main__":
    main()
