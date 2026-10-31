# SGL coverage

368 shaders in the corpus, 368 translated to SGL (45 compute, 203 fragment, 120 vertex).
368 of them compile on every target (hlsl-dx12, hlsl-vulkan, wgsl, msl).

## What the spec has no spelling for

Each compiles through a stand-in its `// gap:` comment names.

| gap | shaders |
|---|---|
| SGL has no 3x4 matrix, so mul(xf, mtxFromRows(rows)) goes column by column, and mtxGetRow reads its rows back | `cs_terrain_lod`, `vs_terrain_render` |
| SGL has no vertex output that routes a primitive to a render-target array layer (gl_Layer, SV_RenderTargetArrayIndex), s | `vs_layered` |
| a binding cannot hold a mat3 (CHK-397), so three float4 columns stand in for u_scissorMat | `fs_nanovg_fill` |
| the same stand-in for u_paintMat | `fs_nanovg_fill` |

## Failing shaders

