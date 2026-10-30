diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_invView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec2<f32>;

var<private> v_4 : vec4<f32>;

var<private> v_5 : vec4<f32>;

var<private> v_6 : vec4<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec4<f32>, a_texcoord0 : vec2<f32>) {
  let v_7 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_8 = (v_7 * transpose(v.u_modelViewProj));
  let v_9 = transpose(mat4x4<f32>(v.u_params[3i], v.u_params[4i], v.u_params[5i], v.u_params[6i]));
  let v_10 = transpose(mat4x4<f32>(v.u_params[7i], v.u_params[8i], v.u_params[9i], v.u_params[10i]));
  let v_11 = transpose(v.u_model[0i]);
  let v_12 = (v_7 * v_11);
  let v_13 = vec4<f32>(v_12.x, v_12.y, v_12.z, 1.0f);
  let v_14 = (v_13 * v_9);
  let v_15 = ((a_normal * 2.0f) - vec3<f32>(1.0f));
  let v_16 = normalize(((vec4<f32>(v_15.x, v_15.y, v_15.z, 0.0f) * v_11)).xyz);
  let v_17 = (vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f) * transpose(v.u_invView));
  v_1 = v_8;
  v_2 = v_16;
  v_3 = a_texcoord0;
  v_4 = (vec4<f32>(v_14.x, v_14.y, v_14.z, 1.0f) * v_10);
  v_5 = v_13;
  v_6 = vec4<f32>(v_17.x, v_17.y, v_17.z, 1.0f);
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec2<f32>,
  @location(2u)
  m_3 : vec4<f32>,
  @location(3u)
  m_4 : vec4<f32>,
  @location(4u)
  m_5 : vec4<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec4<f32>, @location(2u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_normal, a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5, v_6);
}
