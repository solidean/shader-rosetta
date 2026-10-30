diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_params1 : vec4<f32>,
  u_lightMtx : mat4x4<f32>,
  u_shadowMapMtx0 : mat4x4<f32>,
  u_shadowMapMtx1 : mat4x4<f32>,
  u_shadowMapMtx2 : mat4x4<f32>,
  u_shadowMapMtx3 : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec4<f32>;

var<private> v_4 : vec4<f32>;

var<private> v_5 : vec4<f32>;

var<private> v_6 : vec4<f32>;

var<private> v_7 : vec4<f32>;

var<private> v_8 : vec3<f32>;

fn main_inner(a_normal : vec4<f32>, a_position : vec3<f32>) {
  let v_9 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_10 = (v_9 * transpose(v.u_modelViewProj));
  let v_11 = ((a_normal * 2.0f) - vec4<f32>(1.0f));
  let v_12 = transpose(v.u_modelView);
  let v_13 = normalize(((vec4<f32>(v_11.x, v_11.y, v_11.z, 0.0f) * v_12)).xyz);
  let v_14 = (a_position + (v_11.xyz * v.u_params1.y));
  let v_15 = (vec4<f32>(v_14.x, v_14.y, v_14.z, 1.0f) * transpose(v.u_lightMtx));
  let v_16 = (v_15 * transpose(v.u_shadowMapMtx0));
  let v_17 = (v_15 * transpose(v.u_shadowMapMtx1));
  let v_18 = (v_15 * transpose(v.u_shadowMapMtx2));
  let v_19 = (v_15 * transpose(v.u_shadowMapMtx3));
  v_1 = v_10;
  v_2 = v_13;
  v_3 = v_15;
  v_4 = v_16;
  v_5 = v_17;
  v_6 = v_18;
  v_7 = v_19;
  v_8 = ((v_9 * v_12)).xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec4<f32>,
  @location(2u)
  m_3 : vec4<f32>,
  @location(3u)
  m_4 : vec4<f32>,
  @location(4u)
  m_5 : vec4<f32>,
  @location(5u)
  m_6 : vec4<f32>,
  @location(6u)
  m_7 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec4<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_normal, a_position);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5, v_6, v_7, v_8);
}
