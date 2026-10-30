# SGL coverage

368 shaders in the corpus, 368 translated to SGL (45 compute, 203 fragment, 120 vertex).
366 of them compile on every target (hlsl-dx12, hlsl-vulkan, wgsl, msl).

## What blocks the rest

| gap | shaders |
|---|---|
| `invalid-entry-point`: a @pixel fun returns a @pixel struct | 2 |

## What the spec has no spelling for

Each compiles through a stand-in its `// gap:` comment names.

| gap | shaders |
|---|---|
| SGL's prelude has no radians, which HLSL, GLSL and WGSL each have | `fs_shadowmaps_color_lighting_esm`, `fs_shadowmaps_color_lighting_esm_csm`, `fs_shadowmaps_color_lighting_esm_linear`, `fs_shadowmaps_color_lighting_esm_linear_csm`, `fs_shadowmaps_color_lighting_esm_linear_omni`, `fs_shadowmaps_color_lighting_esm_omni`, `fs_shadowmaps_color_lighting_hard`, `fs_shadowmaps_color_lighting_hard_csm`, `fs_shadowmaps_color_lighting_hard_linear`, `fs_shadowmaps_color_lighting_hard_linear_csm`, `fs_shadowmaps_color_lighting_hard_linear_omni`, `fs_shadowmaps_color_lighting_hard_omni`, `fs_shadowmaps_color_lighting_pcf`, `fs_shadowmaps_color_lighting_pcf_csm`, `fs_shadowmaps_color_lighting_pcf_linear`, `fs_shadowmaps_color_lighting_pcf_linear_csm`, `fs_shadowmaps_color_lighting_pcf_linear_omni`, `fs_shadowmaps_color_lighting_pcf_omni`, `fs_shadowmaps_color_lighting_pcss`, `fs_shadowmaps_color_lighting_pcss_csm`, `fs_shadowmaps_color_lighting_pcss_linear`, `fs_shadowmaps_color_lighting_pcss_linear_csm`, `fs_shadowmaps_color_lighting_pcss_linear_omni`, `fs_shadowmaps_color_lighting_pcss_omni`, `fs_shadowmaps_color_lighting_vsm`, `fs_shadowmaps_color_lighting_vsm_csm`, `fs_shadowmaps_color_lighting_vsm_linear`, `fs_shadowmaps_color_lighting_vsm_linear_csm`, `fs_shadowmaps_color_lighting_vsm_linear_omni`, `fs_shadowmaps_color_lighting_vsm_omni` |
| SGL has no spelling for HLSL's [loop], the hint that keeps a loop from being unrolled | `cs_assao_generate_q0`, `cs_assao_generate_q1`, `cs_assao_generate_q2`, `cs_assao_generate_q3`, `cs_assao_generate_q3base` |
| SGL has no 3x4 matrix, so mul(xf, mtxFromRows(rows)) goes column by column, and mtxGetRow reads its rows back | `cs_terrain_lod`, `vs_terrain_render` |
| a half has no `.bits` and no `half.from_bits`, and no bit operator takes a ushort, so its bits travel in a uint | `cs_fsr_easu_16`, `cs_fsr_rcas_16` |
| a pixel stage that writes only an image and no target has no spelling, since CHK-91 asks every @pixel fun to return a @p | `fs_deferred_clear_uav`, `fs_deferred_light_uav` |
| the stand-in's way back, from the low 16 bits of a uint | `cs_fsr_easu_16`, `cs_fsr_rcas_16` |
| SGL has no vertex output that routes a primitive to a render-target array layer (gl_Layer, SV_RenderTargetArrayIndex), s | `vs_layered` |
| a binding cannot hold a mat3 (CHK-397), so three float4 columns stand in for u_scissorMat | `fs_nanovg_fill` |
| the same stand-in for u_paintMat | `fs_nanovg_fill` |

## Failing shaders

- `bgfx/shaders/21-deferred/fs_deferred_clear_uav` (every target): `invalid-entry-point`
- `bgfx/shaders/21-deferred/fs_deferred_light_uav` (every target): `invalid-entry-point`
