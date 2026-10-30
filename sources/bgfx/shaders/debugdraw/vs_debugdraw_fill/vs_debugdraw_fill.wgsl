diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 2u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

fn main_inner(a_indices : vec4<u32>, a_position : vec3<f32>) {
  v_1 = ((vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_model[bitcast<i32>(a_indices.x)])) * transpose(v.u_viewProj));
}

@vertex
fn main(@location(0u) a_indices : vec4<u32>, @location(1u) a_position : vec3<f32>) -> @builtin(position) vec4<f32> {
  main_inner(a_indices, a_position);
  return v_1;
}
