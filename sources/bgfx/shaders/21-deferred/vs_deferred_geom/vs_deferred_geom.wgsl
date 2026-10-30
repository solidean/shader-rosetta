diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_viewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec3<f32>;

var<private> v_4 : vec3<f32>;

var<private> v_5 : vec2<f32>;

var<private> v_6 : vec3<f32>;

var<private> v_7 : vec3<f32>;

fn main_inner(a_normal : vec4<f32>, a_position : vec3<f32>, a_tangent : vec4<f32>, a_texcoord0 : vec2<f32>) {
  let v_8 = transpose(v.u_model[0i]);
  let v_9 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * v_8);
  let v_10 = v_9.x;
  let v_11 = v_9.y;
  let v_12 = v_9.z;
  let v_13 = (vec4<f32>(v_10, v_11, v_12, 1.0f) * transpose(v.u_viewProj));
  let v_14 = ((a_normal * 2.0f) - vec4<f32>(1.0f));
  let v_15 = (vec4<f32>(v_14.x, v_14.y, v_14.z, 0.0f) * v_8);
  let v_16 = ((a_tangent * 2.0f) - vec4<f32>(1.0f));
  let v_17 = (vec4<f32>(v_16.x, v_16.y, v_16.z, 0.0f) * v_8);
  let v_18 = transpose(v.u_view);
  let v_19 = normalize(((vec4<f32>(v_15.x, v_15.y, v_15.z, 0.0f) * v_18)).xyz);
  let v_20 = normalize(((vec4<f32>(v_17.x, v_17.y, v_17.z, 0.0f) * v_18)).xyz);
  let v_21 = (cross(v_19, v_20) * v_16.w);
  v_1 = v_13;
  v_2 = v_21;
  v_3 = v_19;
  v_4 = v_20;
  v_5 = a_texcoord0;
  v_6 = (mat3x3<f32>(v_20, v_21, v_19) * ((vec4<f32>(v_10, v_11, v_12, 0.0f) * v_18)).xyz);
  v_7 = v_9.xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec3<f32>,
  @location(3u)
  m_4 : vec2<f32>,
  @location(4u)
  m_5 : vec3<f32>,
  @location(5u)
  m_6 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec4<f32>, @location(1u) a_position : vec3<f32>, @location(2u) a_tangent : vec4<f32>, @location(3u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_normal, a_position, a_tangent, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5, v_6, v_7);
}
