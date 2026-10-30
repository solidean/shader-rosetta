# SGL coverage

368 shaders in the corpus, 104 translated to SGL (14 compute, 48 fragment, 42 vertex).
104 of them compile on every target (hlsl-dx12, hlsl-vulkan, wgsl, msl).

## What the spec has no spelling for

Each compiles through a stand-in its `// gap:` comment names.

| gap | shaders |
|---|---|
| SGL has no 3x4 matrix, so mul(xf, mtxFromRows(rows)) goes column by column, and mtxGetRow reads its rows back | `cs_terrain_lod`, `vs_terrain_render` |
| a matrix has no subscript, so a column is read back as the matrix times its axis | `cs_terrain_lod` |

## Failing shaders

