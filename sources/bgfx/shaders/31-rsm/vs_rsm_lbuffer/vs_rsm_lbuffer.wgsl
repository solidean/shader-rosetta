diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(20u) var s_shadowMapSampler : sampler;

@group(0u) @binding(4u) var s_shadowMapTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_rsmSampler : sampler;

@group(0u) @binding(5u) var s_rsmTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
  u_sphereInfo : vec4<f32>,
  u_invMvpShadow : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

var<private> v_3 : vec4<f32>;

fn main_inner(a_position : vec3<f32>) {
  let v_4 = v.u_sphereInfo.xy;
  let v_5 = textureSampleLevel(s_shadowMapTexture, s_shadowMapSampler, v_4, 0.0f).x;
  let v_6 = ((v_4 * 2.0f) - vec2<f32>(1.0f));
  let v_7 = (vec4<f32>(v_6.x, -(v_6.y), v_5, 1.0f) * transpose(v.u_invMvpShadow));
  let v_8 = v_7.w;
  let v_9 = (v_7.xyz / vec3<f32>(v_8, v_8, v_8));
  let v_10 = (v_9.y - 0.00100000004749745131f);
  var v_11 : vec3<f32> = v_9;
  v_11.y = v_10;
  let v_12 = v_11;
  let v_13 = textureSampleLevel(s_rsmTexture, s_rsmSampler, v_4, 0.0f);
  let v_14 = (v_13.w * v.u_sphereInfo.z);
  let v_15 = (v_12 + (a_position * v_14));
  let v_16 = (vec4<f32>(v_15.x, v_15.y, v_15.z, 1.0f) * transpose(v.u_viewProj));
  var v_17 : vec4<f32> = vec4<f32>(1.0f, 0.0f, 0.0f, 1.0f);
  v_17.x = v_13.x;
  var v_18 : vec4<f32> = v_17;
  v_18.y = v_13.y;
  var v_19 : vec4<f32> = v_18;
  v_19.z = v_13.z;
  let v_20 = v_19;
  v_1 = v_16;
  v_2 = v_20;
  v_3 = vec4<f32>(v_9.x, v_10, v_9.z, v_14);
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
  @location(1u)
  m_2 : vec4<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_position);
  return tint_symbol(v_1, v_2, v_3);
}
