diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct atomicCounterBuffer_atomic {
  m : array<atomic<u32>>,
}

@group(0u) @binding(6u) var<storage, read_write> atomicCounterBuffer_1 : atomicCounterBuffer_atomic;

struct indirectBuffer {
  m_1 : array<vec4<u32>>,
}

@group(0u) @binding(5u) var<storage, read_write> indirectBuffer_1 : indirectBuffer;

@compute @workgroup_size(1u, 1u, 1u)
fn main() {
  let v = atomicExchange(&(atomicCounterBuffer_1.m[0i]), 0u);
  _ = atomicExchange(&(atomicCounterBuffer_1.m[1i]), 0u);
  let v_1 = (v / 2u);
  _ = atomicExchange(&(atomicCounterBuffer_1.m[2i]), v_1);
  indirectBuffer_1.m_1[2i] = vec4<u32>(((v_1 / 32u) + 1u), 1u, 1u, 0u);
}
