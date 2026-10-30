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
| a uniform array indexed by a variable, or without defines | an array member, `light_pos_radius: float4[4]`; an element shorter than `vec4` is a gap today |
| a uniform the shader declares but never reads | kept, so the members after it keep their places |
| `i_data0` … (instance data) | `@per_instance` members of the `@vertex struct` |
| a varying a vertex shader never writes | returned as its `varying.def.sc` default |
| `flat` | `@interpolate(.flat)` |
| `gl_FragData[i]` | one `@pixel struct` member per target, named for what it holds |
| `gl_FragDepth` | an `@depth depth: float` member of the `@pixel struct` |
| `gl_FragCoord` | the pixel input's `@position` member |
| `gl_FrontFacing`, `gl_VertexID`, `gl_InstanceID` | `@is_front_facing`, `@vertex_index`, `@instance_index`, all `int` but the first |
| `SAMPLER2D(s_tex, 0)`, `texture2D(s_tex, uv)` | `tex: texture_2d[float4]` and a sampler in the binding; `tex.sample(uv, s)` |
| `BUFFER_RO(b, vec4, 0)` / `BUFFER_WO` / `BUFFER_RW` | `b: buffer[float4]` / `b: mut buffer[float4]` in a binding |
| `texture2DLod`, `texture2DGrad`, `texelFetch` | `.sample(uv, s, level = l)`, `.sample(uv, s, grad_x = a, grad_y = b)`, `.load(xy, level)` |
| `shadow2D` | a `texture_2d_depth` with a `compare =` sampler, and `.sample_compare(uv, s, reference = z, level = 0.0)` |
| `textureCube`, `texture3D` | `texture_cube`, `texture_3d` |
| `IMAGE2D_WO(x, r32f)`, `imageStore` | `out image_2d[.r32_float]`, and `img[xy] = v as texel[.r32_float]` |
| `BUFFER_RAW_RO`, `rawLoadUint(b, i)` | `bytes`, and `b.load(i * 4u)` |
| `atomicFetchAndAdd(m, d, o)` | `let o = m.add(d)` on a `mut buffer[atomic[uint]]`; a plain access is `.load()` / `.store()` |
| a `bool` in a buffer | `bool32`, converted with `as bool` / `as bool32` |
| `drawIndexedIndirect`, `dispatchIndirect` | helpers writing a `mut buffer[uint4]`, exactly as the macros expand |
| `SHARED vec3 x[N]` | `@workgroup binding shared:` with `x: float3[N]` |
| `NUM_THREADS(x, y, z)` | `@compute(x, y, z) fun main(...)` |
| `gl_GlobalInvocationID`, `gl_LocalInvocationIndex` | `@thread_id id: int3`, `@local_thread_index i: int` |
| `barrier()` | `workgroup_barrier()` |
| `mul(m, v)` | `m * v` |
| `mul(v, m)` | `transpose(m) * v`: bgfx's row vector times the matrix; `transpose` is a gap today |
| `mtxFromCols(a, b, c)` | `mat3(a, b, c)`, which takes `float3` columns |
| `mat4x3`, `m[i]` | no spelling yet: a stand-in, marked `// gap:` |
| `vec3_splat(x)`, `vec4_splat(x)` | `float3(x)`, `float4(x)` |
| `max(v, 0.0)`, `clamp(v, 0.0, 1.0)` on a vector | the same: `min`, `max` and `clamp` take a scalar bound |
| `cross`, `reflect`, `refract` | take `vec3`: type normals, tangents and light directions as `vec3`, and build a basis with `mat3(t, b, n)` of them |
| `.rgb`, `.r` | `.xyz`, `.x`: swizzles are `xyzw` alone |
| `float(b)` of a `bool` | `select(b, 1.0, 0.0)` |
| `c ? a : b` | `if c => a else b`, also after a jump: `return if c => a else b` |
| `discard` | `if c => discard` |
| `out` parameters | a returned struct |
| `M_PI` | the prelude's `pi`, or the shader's own `const pi`, which hides it |
| `floatBitsToUint(x)` | `x.bits` |
| `#define W (A + B)` over constants | `const w = a + b`; a gap today, since a const must be a literal |

A shader with no copyright line names the one in bgfx's LICENSE, and says so.
bgfx's sampler state is set by the host, and the host code is not in the corpus: a static `filter = .linear` sampler stands in, unless the data says otherwise.

A function names the bindings it reads in `{…}` after its parameters, and so does the entry point: `fun calc(x: float){lights} -> float3:`.

## Traps

- **A splat takes one operand.** `..max(a, b) * c` splats `max(a, b)` alone; write `..(max(a, b) * c)`.
- **`as` is looser than a range.** `0 ..< n as int` is `(0 ..< n) as int`; write `0 ..< (n as int)`.
- **Operator spacing is syntax.** `a - b` is a subtraction, `-b` a negation, `a -b` an error.
- **`not` takes a parenthesized operand inside a chain.** `a and not b` is `misplaced-not`; write `a and (not b)`.
- **A multi-line call closes on its own line.** One element per line, and the `)` or `]` at the parent's indent.
- **A long expression breaks before an operator.** A more indented line continues the statement, and inside parentheses a line starting with a spaced infix operator continues the element above; never keep a 200-character line.
- **A parameter named like a builtin hides it.** A parameter `pow` makes every later `pow(…)` in that function a call of the parameter.
- **An implicit-derivative `sample` must stay in uniform control flow.** After a data-dependent `return`, or inside a loop that breaks on a texel, it is `non-uniform-control-flow`.
  That is a rule of the spec, not a gap: take the gradients before the branch and pass them, or sample at `level = 0.0` where the original reads one texel.
- **sg binds at most three groups** besides the inline constants, or it is `too-many-groups`: merge bindings the way the shader's inputs group.
