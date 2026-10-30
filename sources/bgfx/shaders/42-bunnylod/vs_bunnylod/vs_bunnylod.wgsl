diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

var<private> v_3 : vec3<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec3<f32>) {
  let v_4 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_5 = (v_4 * transpose(v.u_modelViewProj));
  let v_6 = ((v_4 * transpose(v.u_model[0i]))).xyz;
  v_1 = v_5;
  v_2 = vec4<f32>(a_normal.x, a_normal.y, a_normal.z, 1.0f);
  v_3 = v_6;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
  @location(1u)
  m_2 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_normal, a_position);
  return tint_symbol(v_1, v_2, v_3);
}
