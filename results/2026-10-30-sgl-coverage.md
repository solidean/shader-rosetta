# SGL coverage
Compiled by shaped-core `38b9c28f67` on 2026-10-30.

368 shaders in the corpus, 104 translated to SGL (14 compute, 48 fragment, 42 vertex).
89 of them compile on every target (hlsl-dx12, hlsl-vulkan, wgsl, msl).

## What blocks the rest

| gap | shaders |
|---|---|
| `unsupported-yet`: an array in a constant block, whose layout no rule settles yet | 8 |
| `unknown-name`: transpose | 5 |
| `unsupported-yet`: a const whose value is no literal, no enum case and no const | 2 |
| `unknown-name`: mat2 | 1 |
| `unsupported-yet`: main: its body reaches a construct the flat tree cannot hold yet | 1 |

## What the spec has no spelling for

Each compiles through a stand-in its `// gap:` comment names.

| gap | shaders |
|---|---|
| SGL has no 3x4 matrix, so mul(xf, mtxFromRows(rows)) goes column by column, and mtxGetRow reads its rows back | `cs_terrain_lod`, `vs_terrain_render` |
| SGL has no mat2; it is written as mat3 is. | `fs_hextile` |
| a matrix has no subscript, so a column is read back as the matrix times its axis | `cs_terrain_lod` |

## Failing shaders

- `bgfx/shaders/06-bump/fs_bump` (every target): `unknown-name`, `unsupported-yet`
- `bgfx/shaders/06-bump/vs_bump` (every target): `unknown-name`
- `bgfx/shaders/06-bump/vs_bump_instanced` (every target): `unknown-name`
- `bgfx/shaders/09-hdr/fs_hdr_blur` (every target): `unsupported-yet`
- `bgfx/shaders/09-hdr/fs_hdr_bright` (every target): `unsupported-yet`
- `bgfx/shaders/09-hdr/fs_hdr_lum` (every target): `unsupported-yet`
- `bgfx/shaders/09-hdr/fs_hdr_lumavg` (every target): `unsupported-yet`
- `bgfx/shaders/09-hdr/fs_hdr_tonemap` (every target): `unsupported-yet`
- `bgfx/shaders/13-stencil/fs_stencil_color_lighting` (every target): `unsupported-yet`
- `bgfx/shaders/13-stencil/fs_stencil_texture_lighting` (every target): `unsupported-yet`
- `bgfx/shaders/33-pom/vs_pom` (every target): `unknown-name`
- `bgfx/shaders/36-sky/vs_sky` (every target): `unsupported-yet`
- `bgfx/shaders/37-gpudrivenrendering/cs_gdr_stream_compaction` (every target): `unsupported-yet`
- `bgfx/shaders/37-gpudrivenrendering/fs_gdr_instanced_indirect_rendering` (every target): `unsupported-yet`
- `bgfx/shaders/49-hextile/fs_hextile` (every target): `unknown-name`
