diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct atomicCounterBuffer {
  m : array<u32>,
}

@group(0u) @binding(6u) var<storage, read_write> atomicCounterBuffer_1 : atomicCounterBuffer;

struct UniformBlock {
  bgfx_indirectArgBase : vec4<f32>,
  u_params : array<vec4<f32>, 2u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct indirectBuffer {
  m_1 : array<vec4<u32>>,
}

@group(0u) @binding(5u) var<storage, read_write> indirectBuffer_1 : indirectBuffer;

@compute @workgroup_size(1u, 1u, 1u)
fn main() {
  let v_1 = atomicCounterBuffer_1.m[1i];
  let v_2 = ((2i * i32(v.u_params[1i].x)) - 1i);
  indirectBuffer_1.m_1[0i] = vec4<u32>(select(bitcast<u32>((6i << bitcast<u32>(v_2))), 3u, (v_2 <= 0i)), (v_1 / 2u), bitcast<u32>(v.bgfx_indirectArgBase.x), 0u);
  indirectBuffer_1.m_1[1i] = vec4<u32>();
}
