#!/usr/bin/env -S uv run
# /// script
# requires-python = ">=3.11"
# ///

"""Generate the HLSL, GLSL, WGSL, MSL and SPIR-V of every bgfx shader with bgfx's own shaderc, from `sources/bgfx/upstream/`.

    uv run tools/generate-bgfx.py --shaderc <path/to/shaderc.exe>

shaderc must be built from the commit `sources/bgfx/source.json` pins, so the output matches the sources; the readme says how.
Each shader's directory under `sources/bgfx/shaders/` is rewritten: its generated files and its `shader.json`.
A target that fails leaves no file, and `shader.json` keeps the first lines of the error instead.

Where the text comes from, per target:
- HLSL is what shaderc hands FXC, which `--debug` writes next to the output; it is also the input of bgfx's SPIR-V path, through glslang's HLSL front end.
- GLSL is OpenGL GLSL 4.30, which `--raw` writes as is.
- WGSL, MSL and SPIR-V are cut out of bgfx's shader container, since `--raw` does not reach them.
"""

from __future__ import annotations

import argparse
import concurrent.futures
import json
import os
import struct
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SOURCE = ROOT / "sources" / "bgfx"

STAGES = {"vs_": ("vertex", "vertex"), "fs_": ("fragment", "fragment"), "cs_": ("compute", "compute")}

# language -> (file suffix, --platform, -p profile, how the text is obtained)
TARGETS = {
    "hlsl": (".hlsl", "windows", "s_5_0", "debug-dump"),
    "glsl": (".glsl", "linux", "430", "raw"),
    "wgsl": (".wgsl", "linux", "wgsl", "container"),
    "msl": (".metal", "osx", "metal", "container"),
    "spirv": (".spv", "linux", "spirv", "container"),
}


def _code_from_container(data: bytes, *, profile: str, compute: bool) -> bytes:
    """The shader code inside a shaderc output file: magic, two hashes, raw bindings, uniforms, then the sized code."""
    at = 4 + 4 + 4 + 8
    (count,) = struct.unpack_from("<H", data, at)
    at += 2
    for _ in range(count):
        name_size = data[at]
        # name, type u8, num u16, regIndex u16, regCount u16, texComponent u8, texDimension u8, texFormat u16
        at += 1 + name_size + 1 + 2 + 2 + 2 + 1 + 1 + 2
    if compute and profile == "metal":
        at += 3 * 2  # the thread-group size, which only the Metal writer stores
    (size,) = struct.unpack_from("<I", data, at)
    at += 4
    code = data[at:at + size]
    if len(code) != size:
        raise ValueError("container ends inside its code")
    return code


def _additional_includes(directory: Path) -> list[str]:
    """The `ADDITIONAL_INCLUDES` an example's makefile hands scripts/shader.mk, as shaderc arguments."""
    makefile = directory / "makefile"
    if not makefile.is_file():
        return []
    for line in makefile.read_text(encoding="utf-8").splitlines():
        key, sep, value = line.partition("=")
        if sep and key.strip().rstrip("?") == "ADDITIONAL_INCLUDES":
            return value.split()
    return []


def _compile(sc: Path, shaderc: Path, language: str) -> tuple[bytes | None, list[str], str]:
    suffix, platform, profile, how = TARGETS[language]
    kind = STAGES[sc.name[:3]][1]
    with tempfile.TemporaryDirectory() as tmp:
        out = Path(tmp) / "out.bin"
        # The arguments shader.json records: everything but the input and output files, which it names itself.
        args = ["--type", kind, "--platform", platform, "-p", profile,
                "-i", Path(os.path.relpath(SOURCE / "upstream" / "src", sc.parent)).as_posix(), *_additional_includes(sc.parent)]
        if how == "debug-dump":
            args.append("--debug")
        if how == "raw":
            args.append("--raw")
        # bgfx's makefiles run shaderc from the example's directory, and glslang resolves includes against it.
        proc = subprocess.run([str(shaderc), "-f", sc.name, "-o", str(out), *args], cwd=sc.parent, capture_output=True)
        if proc.returncode != 0:
            lines = [l for l in proc.stdout.decode(errors="replace").splitlines() + proc.stderr.decode(errors="replace").splitlines()
                     if l.strip() and not l.lstrip()[:1].isdigit() and not l.startswith(">>>")]
            return None, args, "\n".join(l for l in lines if "ERROR" in l or "error" in l)[:2000] or "shaderc failed"
        if how == "debug-dump":
            return _strip_command_line(Path(f"{out}.hlsl").read_bytes()), args, ""
        if how == "raw":
            return out.read_bytes(), args, ""
        return _code_from_container(out.read_bytes(), profile=profile, compute=kind == "compute"), args, ""


def _strip_command_line(hlsl: bytes) -> bytes:
    """Drop the two-line `// shaderc command line:` header, which holds this machine's paths."""
    if hlsl.startswith(b"// shaderc command line:"):
        return hlsl.split(b"\n", 2)[2]
    return hlsl


def _generate(sc: Path, shaderc: Path, tool: str) -> tuple[str, dict[str, str]]:
    rel = sc.relative_to(SOURCE / "upstream").as_posix()
    example = sc.parent.name
    name = sc.stem
    target_dir = SOURCE / "shaders" / example / name
    target_dir.mkdir(parents=True, exist_ok=True)

    languages: dict[str, dict] = {}
    outcome: dict[str, str] = {}
    for language, (suffix, _platform, _profile, _how) in TARGETS.items():
        path = target_dir / f"{name}{suffix}"
        code, args, error = _compile(sc, shaderc, language)
        if code is None:
            path.unlink(missing_ok=True)
            languages[language] = {"status": "failed", "by": tool, "args": " ".join(args), "error": error}
            outcome[language] = "failed"
            continue
        path.write_bytes(code)
        languages[language] = {"status": "generated", "file": path.name, "by": tool, "args": " ".join(args)}
        outcome[language] = "generated"

    meta = {
        "origin": f"upstream/{rel}",
        "stage": STAGES[name[:3]][0],
        "languages": languages,
    }
    (target_dir / "shader.json").write_text(json.dumps(meta, indent=4) + "\n", encoding="utf-8", newline="\n")
    return f"{example}/{name}", outcome


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--shaderc", required=True, type=Path, help="bgfx's shaderc, built at the pinned commit")
    parser.add_argument("--jobs", type=int, default=os.cpu_count())
    args = parser.parse_args()

    manifest = json.loads((SOURCE / "source.json").read_text(encoding="utf-8"))
    tool = f"bgfx shaderc {manifest['commit'][:10]}"
    shaders = sorted(p for p in (SOURCE / "upstream" / "examples").rglob("*.sc") if p.name[:3] in STAGES)

    totals: dict[str, dict[str, int]] = {language: {} for language in TARGETS}
    failures: list[str] = []
    with concurrent.futures.ThreadPoolExecutor(max_workers=args.jobs) as pool:
        for shader, outcome in pool.map(lambda sc: _generate(sc, args.shaderc.resolve(), tool), shaders):
            for language, status in outcome.items():
                totals[language][status] = totals[language].get(status, 0) + 1
                if status == "failed":
                    failures.append(f"{shader} {language}")

    print(f"{len(shaders)} shaders")
    for language, counts in totals.items():
        print(f"  {language:<6} " + ", ".join(f"{n} {status}" for status, n in sorted(counts.items())))
    for f in failures:
        print(f"  failed: {f}", file=sys.stderr)


if __name__ == "__main__":
    main()
