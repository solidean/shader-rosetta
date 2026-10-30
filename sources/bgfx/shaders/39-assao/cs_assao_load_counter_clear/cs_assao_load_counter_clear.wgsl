diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct s_loadCounter {
  m : array<u32>,
}

@group(0u) @binding(2u) var<storage, read_write> s_loadCounter_1 : s_loadCounter;

@compute @workgroup_size(1u, 1u, 1u)
fn main() {
  s_loadCounter_1.m[0i] = 0u;
}
