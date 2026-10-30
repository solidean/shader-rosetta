# shader-rosetta

Real-world shaders from open-source projects, each kept in its original language next to translations into the others.
A corpus for testing and benchmarking shader compilers.

The name is the Rosetta Stone's: one text, several languages, side by side.

## What it is for

- **Coverage.** Which real shaders a compiler accepts, and the features it is missing, ranked by how often real code needs them.
- **Correctness.** A translation is checked against its original by running both on the same inputs and comparing the results, not by reading it.
- **Speed.** The same corpus through every compiler, timed the same way, so the numbers can be compared.

The languages are HLSL, GLSL, WGSL, MSL and [SGL](https://github.com/solidean/shaped-core/tree/main/libs/graphics/shaped-graphics-language), the shading language of shaped-core.
SGL's compiler is what this corpus was started for, but nothing in it depends on SGL: any compiler can be run against it.

## Using it from shaped-core

shaped-core clones this repository on request, into a gitignored path inside its own tree:

```bash
uv run dev.py companions init shader-rosetta
uv run dev.py companions sync                   # fast-forward to main later
```

The clone is an ordinary repository, so commit and push in it with plain git.
Work happens on `main`.

## Sources

Every source is recorded with its upstream repository, the commit its files were taken from, and its license.

| Source | Upstream | Commit | License |
|---|---|---|---|
| [bgfx](sources/bgfx/source.json) | [bkaradzic/bgfx](https://github.com/bkaradzic/bgfx) | `b7d0751baa` (2026-10-29) | BSD-2-Clause, with BSD-3-Clause and MIT parts |

bgfx's 368 example shaders are the corpus of Branimir Karadzic's [shader compiler survey](https://bkaradzic.github.io/posts/ideal-shader-compiler/), which makes our numbers comparable with his.

## Layout

```
sources/<name>/
├── source.json            upstream, pinned commit, licenses, what is imported
├── LICENSE                the upstream license, verbatim
├── licenses/              the texts of third-party licenses that upstream carries no file for
├── upstream/              the imported files, byte for byte, at their upstream paths
└── shaders/<group>/<shader>/
    ├── shader.json        origin, stage, entry points, variants, status per language
    └── <shader>.hlsl  .glsl  .wgsl  .metal  .sgl
tools/                     the importer and the harness
results/                   published benchmark snapshots, one directory per run
```

- **`upstream/` is replaced wholesale** by `uv run tools/import.py <name>`, so nothing of ours lives in it.
  `--commit <sha>` moves the pin first.
- **A shader's directory holds every language side by side**, and is the unit coverage and benchmarks count.
  A file is named after its shader, so editor tabs stay apart.
- **`shader.json` says where each language came from**: `upstream`, `generated` (with the tool and its version), `translated`, or `verified` (with the backend the differential check ran on).
- **Permutations are `variants` in `shader.json`**: an entry point and a set of defines, each counted on its own.
- `.glsl` is Vulkan GLSL, `.metal` is MSL.

## Licensing

No single license covers the repository: every source keeps its own, and [LICENSE](LICENSE) says which applies where.

- **A source's files keep their upstream license**, which sits next to them, and so do our translations of them.
- **A translation names its original** in a header comment: the source, the file, and that it was translated.
  Apache-2.0 asks for the second part, and stating it everywhere keeps every source compliant at once.
- **Everything else is MIT**: the tooling, the manifests, this readme.

**Only permissive licenses are accepted**, so that the whole corpus stays usable by anyone, commercial compiler vendors included:
MIT, BSD-2-Clause, BSD-3-Clause, Apache-2.0, Zlib, BSL-1.0, CC0-1.0 and the Unlicense.

Not accepted:

- copyleft licenses (GPL, LGPL, MPL);
- non-commercial terms, such as CC BY-NC, the default for Shadertoy;
- vendor SDK licenses with use restrictions;
- code without a license at all, which is not the same as permissive.

## Adding a source

1. Check the license against the list above, for every file that is taken, not only the repository's top-level one.
2. Write `sources/<name>/source.json`: the upstream url and commit, its license, and the `include` globs.
   List every third-party part under `third_party`, with its license and where its text is.
3. Run `uv run tools/import.py <name>`, which copies the files unmodified and the upstream LICENSE next to them.
4. Add the source to the table above.
