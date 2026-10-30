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
| (none yet) | | | |

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
2. Copy the files unmodified and record the upstream commit they came from.
3. Put the upstream LICENSE file next to them and add the source to the table above.
