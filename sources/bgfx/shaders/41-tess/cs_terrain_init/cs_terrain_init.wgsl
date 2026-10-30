diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  bgfx_indirectArgBase : vec4<f32>,
  u_params : array<vec4<f32>, 2u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct indirectBuffer {
  m : array<vec4<u32>>,
}

@group(0u) @binding(5u) var<storage, read_write> indirectBuffer_1 : indirectBuffer;

struct u_SubdBufferOut {
  m_1 : array<u32>,
}

@group(0u) @binding(3u) var<storage, read_write> u_SubdBufferOut_1 : u_SubdBufferOut;

@group(0u) @binding(4u) var<storage, read_write> u_CulledSubdBuffer : u_SubdBufferOut;

@group(0u) @binding(10u) var<storage, read_write> u_SubdBufferIn : u_SubdBufferOut;

struct u_SubdBufferOut_atomic {
  m_2 : array<atomic<u32>>,
}

@group(0u) @binding(6u) var<storage, read_write> atomicCounterBuffer : u_SubdBufferOut_atomic;

@compute @workgroup_size(1u, 1u, 1u)
fn main() {
  let v_1 = ((2i * i32(v.u_params[1i].x)) - 1i);
  indirectBuffer_1.m[0i] = vec4<u32>(select(bitcast<u32>((6i << bitcast<u32>(v_1))), 3u, (v_1 <= 0i)), 0u, bitcast<u32>(v.bgfx_indirectArgBase.x), 0u);
  indirectBuffer_1.m[1i] = vec4<u32>();
  indirectBuffer_1.m[2i] = vec4<u32>(1u, 1u, 1u, 0u);
  u_SubdBufferOut_1.m_1[0i] = 0u;
  u_SubdBufferOut_1.m_1[1i] = 1u;
  u_SubdBufferOut_1.m_1[2i] = 1u;
  u_SubdBufferOut_1.m_1[3i] = 1u;
  u_CulledSubdBuffer.m_1[0i] = 0u;
  u_CulledSubdBuffer.m_1[1i] = 1u;
  u_CulledSubdBuffer.m_1[2i] = 1u;
  u_CulledSubdBuffer.m_1[3i] = 1u;
  u_SubdBufferIn.m_1[0i] = 0u;
  u_SubdBufferIn.m_1[1i] = 1u;
  u_SubdBufferIn.m_1[2i] = 1u;
  u_SubdBufferIn.m_1[3i] = 1u;
  _ = atomicExchange(&(atomicCounterBuffer.m_2[0i]), 0u);
  _ = atomicExchange(&(atomicCounterBuffer.m_2[1i]), 0u);
  _ = atomicExchange(&(atomicCounterBuffer.m_2[2i]), 2u);
}
