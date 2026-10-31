#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# ///

"""Compile every SGL translation in the corpus on every SGL target, and rank what fails by diagnostic kind.

    uv run tools/sgl-coverage.py --sgl <path/to/sgl.exe>          # the report, as markdown on stdout
    uv run tools/sgl-coverage.py --sgl <exe> --json coverage.json  # every diagnostic too, for a tool

A translation is written as the SGL spec says the shader is written, whatever the compiler carries yet.
So a translation that fails names a feature the compiler is missing, and the ranking says how often real shaders need it.
The entry point is `main` unless the shader's `shader.json` names another under `languages.sgl.entry`.
"""

from __future__ import annotations

import argparse
import collections
import concurrent.futures
import json
import os
import re
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TARGETS = ("hlsl-dx12", "hlsl-vulkan", "wgsl", "msl")

# `vs_cubes.sgl:12:5: error: unknown-name: foo`; a note or a source line between them is skipped
# A diagnostic of a whole entry point, such as `target-lacks-feature`, names the file alone.
DIAGNOSTIC = re.compile(
    r"^(?P<file>.+?):(?:(?P<line>\d+):(?P<column>\d+):)? error: (?P<kind>[a-z0-9-]+)(?:: (?P<detail>.*))?$")
# What a target lacks by design: the shader requires a device feature that target has on no device.
UNPORTABLE = "target-lacks-feature"


def _emit(sgl: Path, source: Path, entry: str, target: str) -> list[dict]:
    proc = subprocess.run([str(sgl), "emit", source.name, "--entry", entry, "--target", target],
                          cwd=source.parent, capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode == 0:
        return []
    found = [m.groupdict() for m in map(DIAGNOSTIC.match, proc.stderr.splitlines()) if m]
    return found or [{"kind": "tool-failure", "detail": proc.stderr.strip()[:500], "line": "0", "column": "0"}]


def _check(sgl: Path, shader_dir: Path) -> dict | None:
    meta = json.loads((shader_dir / "shader.json").read_text(encoding="utf-8"))
    source = shader_dir / f"{shader_dir.name}.sgl"
    if not source.is_file():
        return None
    entry = meta.get("languages", {}).get("sgl", {}).get("entry", "main")
    per_target = {t: _emit(sgl, source, entry, t) for t in TARGETS}
    return {"shader": shader_dir.relative_to(ROOT / "sources").as_posix(), "stage": meta["stage"], "targets": per_target}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--sgl", required=True, type=Path, help="shaped-core's sgl tool")
    parser.add_argument("--json", type=Path, help="also write every result here")
    parser.add_argument("--jobs", type=int, default=os.cpu_count())
    args = parser.parse_args()

    shader_dirs = sorted(p.parent for p in (ROOT / "sources").glob("*/shaders/*/*/shader.json"))
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        results = [r for r in pool.map(lambda d: _check(args.sgl.resolve(), d), shader_dirs) if r]

    clean = [r for r in results if not any(r["targets"].values())]

    # a target that lacks a feature the shader requires is no failure, so such a shader counts where the feature exists
    def is_unportable(ds: list[dict]) -> bool:
        return bool(ds) and all(d["kind"] == UNPORTABLE for d in ds)

    gated = [r for r in results if any(r["targets"].values())
             and all(not ds or is_unportable(ds) for ds in r["targets"].values())]
    # A gap counts once per shader however many targets and lines report it: the question is how many shaders it blocks.
    # `unsupported-yet` alone says little, so a gap is its kind and its detail.
    blocking: dict[str, set[str]] = collections.defaultdict(set)
    for r in results:
        for diagnostics in r["targets"].values():
            for d in diagnostics:
                if d["kind"] == UNPORTABLE:
                    continue
                blocking[f"`{d['kind']}`: {(d.get('detail') or '').strip()[:120]}"].add(r["shader"])
    # A shader the spec has no spelling for compiles through a stand-in, which a `// gap:` comment marks.
    workarounds: dict[str, set[str]] = collections.defaultdict(set)
    for r in results:
        source = ROOT / "sources" / r["shader"] / f"{Path(r['shader']).name}.sgl"
        for line in source.read_text(encoding="utf-8").splitlines():
            _, sep, note = line.partition("// gap:")
            if sep:
                workarounds[note.strip()[:120]].add(r["shader"])

    by_stage = collections.Counter(r["stage"] for r in results)
    print("# SGL coverage\n")
    print(f"{len(shader_dirs)} shaders in the corpus, {len(results)} translated to SGL "
          f"({', '.join(f'{n} {s}' for s, n in sorted(by_stage.items()))}).")
    print(f"{len(clean)} of them compile on every target ({', '.join(TARGETS)}).")
    if gated:
        names = ", ".join(f"`{r['shader'].split('/')[-1]}`" for r in gated)
        print(f"{len(gated)} more compile on every target that has the device features they require: {names}.")
    print()
    if blocking:
        print("## What blocks the rest\n")
        print("| gap | shaders |")
        print("|---|---|")
        for gap, shaders in sorted(blocking.items(), key=lambda kv: (-len(kv[1]), kv[0])):
            print(f"| {gap} | {len(shaders)} |")
        print()
    if workarounds:
        print("## What the spec has no spelling for\n")
        print("Each compiles through a stand-in its `// gap:` comment names.\n")
        print("| gap | shaders |")
        print("|---|---|")
        for gap, shaders in sorted(workarounds.items(), key=lambda kv: (-len(kv[1]), kv[0])):
            print(f"| {gap} | {', '.join(f'`{s.split('/')[-1]}`' for s in sorted(shaders))} |")
        print()
        print("## Failing shaders\n")
        for r in results:
            failing = {t: ds for t, ds in r["targets"].items() if ds and not is_unportable(ds)}
            if not failing:
                continue
            kinds = sorted({d["kind"] for ds in failing.values() for d in ds})
            where = "every target" if len(failing) == len(TARGETS) else ", ".join(failing)
            print(f"- `{r['shader']}` ({where}): {', '.join(f'`{k}`' for k in kinds)}")
    if args.json:
        args.json.write_text(json.dumps(results, indent=2) + "\n", encoding="utf-8", newline="\n")


if __name__ == "__main__":
    main()
