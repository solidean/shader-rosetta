diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec2<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec4<f32>, a_texcoord0 : vec2<f32>) {
  let v_4 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_modelViewProj));
  let v_5 = ((a_normal * 2.0f) + vec3<f32>(-1.0f));
  let v_6 = ((normalize(((vec4<f32>(v_5.x, v_5.y, v_5.z, 0.0f) * transpose(v.u_model[0i]))).xyz) * 0.5f) + vec3<f32>(0.5f));
  v_1 = v_4;
  v_2 = v_6;
  v_3 = (a_texcoord0 * 16.0f);
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec4<f32>, @location(2u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_normal, a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3);
}
