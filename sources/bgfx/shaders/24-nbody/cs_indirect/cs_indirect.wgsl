diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct indirectBuffer {
  m : array<vec4<u32>>,
}

@group(0u) @binding(2u) var<storage, read_write> indirectBuffer_1 : indirectBuffer;

struct UniformBlock {
  bgfx_indirectArgBase : vec4<f32>,
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@compute @workgroup_size(1u, 1u, 1u)
fn main() {
  let v_1 = bitcast<u32>(v.u_params[0i].y);
  indirectBuffer_1.m[0i] = vec4<u32>(6u, (v_1 * 512u), bitcast<u32>(v.bgfx_indirectArgBase.x), 0u);
  indirectBuffer_1.m[1i] = vec4<u32>();
  indirectBuffer_1.m[2i] = vec4<u32>(v_1, 1u, 1u, 0u);
}
