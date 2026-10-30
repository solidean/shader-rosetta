diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_norm_mtx : mat4x4<f32>,
  u_light_pos : vec4<f32>,
  u_viewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec2<f32>;

var<private> v_3 : vec3<f32>;

var<private> v_4 : vec3<f32>;

var<private> v_5 : vec3<f32>;

fn main_inner(a_bitangent : vec3<f32>, a_position : vec3<f32>, a_tangent : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_6 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_model[0i]));
  let v_7 = (vec4<f32>(v_6.x, v_6.y, v_6.z, 1.0f) * transpose(v.u_viewProj));
  let v_8 = ((a_tangent * 2.0f) - vec3<f32>(1.0f));
  let v_9 = ((a_bitangent * 2.0f) - vec3<f32>(1.0f));
  let v_10 = cross(v_8, v_9);
  let v_11 = transpose(v.u_norm_mtx);
  let v_12 = transpose(mat3x3<f32>(normalize(((vec4<f32>(v_8.x, v_8.y, v_8.z, 0.0f) * v_11)).xyz), normalize(((vec4<f32>(v_9.x, v_9.y, v_9.z, 0.0f) * v_11)).xyz), normalize(((vec4<f32>(v_10.x, v_10.y, v_10.z, 0.0f) * v_11)).xyz)));
  let v_13 = (v_12 * v.u_light_pos.xyz);
  v_1 = v_7;
  v_2 = a_texcoord0;
  v_3 = (v_12 * v_6.xyz);
  v_4 = v_13;
  v_5 = (v_12 * vec3<f32>());
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec2<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec3<f32>,
  @location(3u)
  m_4 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_bitangent : vec3<f32>, @location(1u) a_position : vec3<f32>, @location(2u) a_tangent : vec3<f32>, @location(3u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_bitangent, a_position, a_tangent, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5);
}
