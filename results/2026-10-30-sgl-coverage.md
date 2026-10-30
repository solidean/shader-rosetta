# SGL coverage

368 shaders in the corpus, 209 translated to SGL (37 compute, 102 fragment, 70 vertex).
204 of them compile on every target (hlsl-dx12, hlsl-vulkan, wgsl, msl).

## What blocks the rest

| gap | shaders |
|---|---|
| `unsupported-yet`: a let without a value | 3 |
| `invalid-entry-point`: a @pixel fun returns a @pixel struct | 2 |
| `unsupported-yet`: a for over a range that is not `..<` | 1 |

## What the spec has no spelling for

Each compiles through a stand-in its `// gap:` comment names.

| gap | shaders |
|---|---|
| SGL has no spelling for HLSL's [loop], the hint that keeps a loop from being unrolled | `cs_assao_generate_q0`, `cs_assao_generate_q1`, `cs_assao_generate_q2`, `cs_assao_generate_q3`, `cs_assao_generate_q3base` |
| SGL has no 3x4 matrix, so mul(xf, mtxFromRows(rows)) goes column by column, and mtxGetRow reads its rows back | `cs_terrain_lod`, `vs_terrain_render` |
| a pixel stage that writes only an image and no target has no spelling, since CHK-91 asks every @pixel fun to return a @p | `fs_deferred_clear_uav`, `fs_deferred_light_uav` |
| SGL has no vertex output that routes a primitive to a render-target array layer (gl_Layer, SV_RenderTargetArrayIndex), s | `vs_layered` |

## Failing shaders

- `bgfx/shaders/21-deferred/fs_deferred_clear_uav` (every target): `invalid-entry-point`
- `bgfx/shaders/21-deferred/fs_deferred_light_uav` (every target): `invalid-entry-point`
- `bgfx/shaders/53-sky2/cs_atmo_skyview` (every target): `unsupported-yet`
- `bgfx/shaders/53-sky2/fs_sky2` (every target): `unsupported-yet`
- `bgfx/shaders/53-sky2/fs_sky2_bg` (every target): `unsupported-yet`
