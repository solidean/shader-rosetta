#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# ///

"""Time every SGL translation in the corpus on every SGL target, the way the shader compiler survey times its compilers.

    uv run tools/sgl-benchmark.py --sgl <path/to/sgl.exe>                # the report, as markdown on stdout
    uv run tools/sgl-benchmark.py --sgl <exe> --json speed.json         # every shader's time too, for a tool

The survey (https://bkaradzic.github.io/posts/ideal-shader-compiler/) loads every source first, compiles each shader on
its own, in its process, on one thread, ten times, and sums the fastest run of each.
`sgl bench` does exactly that, so `sgl` must be a release build for the numbers to mean anything.
The prelude is checked once per process, on the first compile, and is reported apart from the shaders' sum.
"""

from __future__ import annotations

import argparse
import sys
import json
import platform
import statistics
import subprocess
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
TARGETS = ("hlsl-dx12", "hlsl-vulkan", "wgsl", "msl")


def _format_secs(secs: float) -> str:
    if secs >= 1:
        return f"{secs:.2f}s"
    if secs >= 1e-3:
        return f"{secs * 1e3:.1f}ms" if secs < 0.1 else f"{secs * 1e3:.0f}ms"
    return f"{secs * 1e6:.0f}µs"


def _cpu_name() -> str:
    try:
        if platform.system() == "Windows":
            out = subprocess.run(["powershell", "-NoProfile", "-Command", "(Get-CimInstance Win32_Processor).Name"],
                                 capture_output=True, text=True).stdout.strip()
            if out:
                return out
    except OSError:
        pass
    return platform.processor() or "unknown CPU"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--sgl", required=True, type=Path, help="shaped-core's sgl tool, a release build")
    parser.add_argument("--rounds", type=int, default=10)
    parser.add_argument("--json", type=Path, help="also write every shader's time here")
    args = parser.parse_args()
    sys.stdout.reconfigure(encoding="utf-8")

    shaders = []
    for meta_path in sorted((ROOT / "sources").glob("*/shaders/*/*/shader.json")):
        meta = json.loads(meta_path.read_text(encoding="utf-8"))
        source = meta_path.parent / f"{meta_path.parent.name}.sgl"
        if source.is_file():
            entry = meta.get("languages", {}).get("sgl", {}).get("entry", "main")
            shaders.append((source, entry))

    with tempfile.TemporaryDirectory() as scratch:
        listing = Path(scratch) / "shaders.txt"
        listing.write_text("".join(f"{s}\t{e}\n" for s, e in shaders), encoding="utf-8", newline="\n")
        proc = subprocess.run([str(args.sgl.resolve()), "bench", str(listing), "--rounds", str(args.rounds)],
                              capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        raise SystemExit(f"sgl bench failed:\n{proc.stderr}")

    prelude = 0.0
    times: dict[str, dict[str, float | None]] = {t: {} for t in TARGETS}
    for line in proc.stdout.splitlines():
        path, target, secs = line.split("\t")
        if path == "prelude":
            prelude = float(secs)
            continue
        name = Path(path).relative_to(ROOT / "sources").parent.as_posix()
        times[target][name] = None if secs == "failed" else float(secs)

    lines = sum(len([l for l in s.read_text(encoding="utf-8").splitlines() if l.strip()]) for s, _ in shaders)
    print("# SGL compile speed\n")
    print(f"{len(shaders)} SGL translations, {lines // 1000}K non-blank lines, each compiled on its own to target text, "
          f"in one process on one thread.")
    print(f"Every number is the fastest of {args.rounds} runs, summed over the corpus, the shader compiler survey's method.")
    print(f"Machine: {_cpu_name()}, {platform.system()} {platform.release()}.\n")
    print(f"The first compile in a process also checks the prelude, once: {_format_secs(prelude)} in all, which no row includes.\n")
    print("| path | compiled | total | median per shader | slowest shader |")
    print("|---|---|---|---|---|")
    for target in TARGETS:
        ok = {n: s for n, s in times[target].items() if s is not None}
        if not ok:
            continue
        slowest = max(ok, key=ok.get)
        print(f"| SGL → {target} | {len(ok)} | {_format_secs(sum(ok.values()))} | "
              f"{_format_secs(statistics.median(ok.values()))} | {_format_secs(ok[slowest])} `{slowest.split('/')[-1]}` |")
    failed = sorted({n for t in TARGETS for n, s in times[t].items() if s is None})
    if failed:
        print(f"\nNot compiled on every target: {', '.join(f'`{n}`' for n in failed)}; "
              "`sgl-coverage.py` says whether it failed or requires a device feature the target lacks.")
    if args.json:
        args.json.write_text(json.dumps({"prelude": prelude, "times": times}, indent=2) + "\n", encoding="utf-8",
                             newline="\n")


if __name__ == "__main__":
    main()
