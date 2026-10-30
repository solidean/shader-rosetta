diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_invView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec2<f32>;

var<private> v_4 : vec4<f32>;

var<private> v_5 : vec4<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec4<f32>, a_texcoord0 : vec2<f32>) {
  let v_6 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_7 = (v_6 * transpose(v.u_modelViewProj));
  let v_8 = transpose(v.u_model[0i]);
  let v_9 = (v_6 * v_8);
  let v_10 = ((a_normal * 2.0f) - vec3<f32>(1.0f));
  let v_11 = normalize(((vec4<f32>(v_10.x, v_10.y, v_10.z, 0.0f) * v_8)).xyz);
  let v_12 = normalize((((vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f) * transpose(v.u_invView))).xyz - v_9.xyz));
  v_1 = v_7;
  v_2 = v_11;
  v_3 = a_texcoord0;
  v_4 = vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f);
  v_5 = vec4<f32>(v_12.x, v_12.y, v_12.z, 1.0f);
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
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec4<f32>, @location(2u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_normal, a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5);
}
