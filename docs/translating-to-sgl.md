# Translating a shader to SGL

A translation is the shader **as the SGL spec says it is written**, whatever the compiler carries yet.
That is what makes the corpus a coverage measure: a translation that fails names what the compiler is missing.
So a diagnostic is either our mistake, which we fix, or a gap, which we keep.

- **A mistake** is a translation the spec does not allow: a syntax error, a precedence trap, a type that does not match.
  Fix it.
- **A gap** is the spec's spelling refused anyway: `unsupported-yet`, or `unknown-name` for a builtin every target has.
  Keep it, and never contort the shader to dodge one: a dodge hides the gap from the ranking.
- When the spec itself has no spelling for something, write the closest one it has, and say so in a `// gap:` comment on that line.

## Where things are

- The language: shaped-core's `libs/graphics/shaped-graphics-language/docs/spec/_index.md`, and the language sections of its `cheat-sheet.md`.
- Worked SGL: that library's `tests/corpus/**/*.sgl` and `tests/samples/*.sgl`, and `examples/graphics/sgl-cube/shaders/cube.sgl`.
- A bgfx shader: its `.sc` under `sources/bgfx/upstream/examples/<example>/`, with the example's `varying.def.sc` beside it.
  The generated `.hlsl` next to the translation shows what every bgfx macro expands to.

## The file

One `.sgl` per shader, named after it, in the shader's own directory, with one entry point named `main`.
It starts with the original's copyright line and where its license is:

```sgl
// Translated to SGL from bgfx examples/06-bump/fs_bump.sc.
// Copyright 2011-2026 Branimir Karadzic. BSD-2-Clause: sources/bgfx/LICENSE.
```

Each file stands alone: it declares the structs and bindings it uses, so a vertex shader and its pixel shader each carry the varyings.

Check it from the shader's directory, on every target:

```bash
sgl emit vs_cubes.sgl --entry main --target hlsl-dx12   # and hlsl-vulkan, wgsl, msl
```

`uv run tools/sgl-coverage.py --sgl <exe>` runs that over the whole corpus.

## bgfx, spelled in SGL

| bgfx | SGL |
|---|---|
| `$input a_position, a_color0` (vertex) | an `@vertex struct` with those fields, in that order |
| `$output` / `$input v_*` | a plain `struct varyings` with `@position position: hpos4` first |
| `gl_Position` | the `@position` member of the returned struct |
| `gl_FragColor` | the `color` member of `@pixel struct target`; `gl_FragData[i]` is one member per target |
| `u_modelViewProj`, `u_viewProj`, `u_model[0]`, … | members of a `binding view:` holding the ones the shader reads |
| `uniform vec4 u_params[3]` with `#define u_x u_params[0].x` | named members, as the defines name them |
| a uniform array indexed by a variable | an array member, `light_pos_radius: float4[4]` |
| `SAMPLER2D(s_tex, 0)`, `texture2D(s_tex, uv)` | `tex: texture_2d[float4]` and a sampler in the binding; `tex.sample(uv, s)` |
| `BUFFER_RO(b, vec4, 0)` / `BUFFER_WO` / `BUFFER_RW` | `b: buffer[float4]` / `b: mut buffer[float4]` in a binding |
| `SHARED vec3 x[N]` | `@workgroup binding shared:` with `x: float3[N]` |
| `NUM_THREADS(x, y, z)` | `@compute(x, y, z) fun main(...)` |
| `gl_GlobalInvocationID`, `gl_LocalInvocationIndex` | `@thread_id id: int3`, `@local_thread_index i: int` |
| `barrier()` | `workgroup_barrier()` |
| `mul(m, v)` | `m * v` |
| `mul(v, m)` | `transpose(m) * v`: bgfx's row vector times the matrix |
| `mtxFromCols(a, b, c)` | `mat3(a, b, c)` |
| `vec3_splat(x)` | `float3(x)` |
| `floatBitsToUint(x)` | `x.bits` |

A function names the bindings it reads in `{…}` after its parameters, and so does the entry point: `fun calc(x: float){lights} -> float3:`.

## Traps

- **A splat takes one operand.** `..max(a, b) * c` splats `max(a, b)` alone; write `..(max(a, b) * c)`.
- **`as` is looser than a range.** `0 ..< n as int` is `(0 ..< n) as int`; write `0 ..< (n as int)`.
- **Operator spacing is syntax.** `a - b` is a subtraction, `-b` a negation, `a -b` an error.
