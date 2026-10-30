diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

struct UniformBlock {
  u_modelParams : array<vec4<f32>, 2u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>) {
  let v_1 = pow(abs(textureSample(s_albedoTexture, s_albedoSampler, v_texcoord0).xyz), vec3<f32>(2.20000004768371582031f));
  let v_2 = normalize(v_normal);
  let v_3 = textureSample(s_normalTexture, s_normalSampler, v_texcoord0);
  var v_4 : vec3<f32> = vec3<f32>();
  v_4.x = v_3.x;
  var v_5 : vec3<f32> = v_4;
  v_5.y = v_3.y;
  let v_6 = ((v_5.xy * 2.0f) - vec2<f32>(1.0f));
  let v_7 = v_6.x;
  var v_8 : vec3<f32> = vec3<f32>();
  v_8.x = v_7;
  let v_9 = v_6.y;
  var v_10 : vec3<f32> = v_8;
  v_10.y = v_9;
  let v_11 = v_10.xy;
  let v_12 = vec3<f32>(v_7, v_9, sqrt((1.0f - dot(v_11, v_11))));
  let v_13 = -(v_12.yx);
  var v_14 : vec3<f32> = v_12;
  v_14.x = v_13.x;
  var v_15 : vec3<f32> = v_14;
  v_15.y = v_13.y;
  let v_16 = v_15;
  let v_17 = v_texcoord1.xyz;
  let v_18 = dpdx(v_17);
  let v_19 = dpdy(-(v_17));
  let v_20 = dpdx(v_texcoord0);
  let v_21 = dpdy(-(v_texcoord0));
  let v_22 = cross(v_19, v_2);
  let v_23 = cross(v_2, v_18);
  let v_24 = ((v_22 * v_20.x) + (v_23 * v_21.x));
  let v_25 = ((v_22 * v_20.y) + (v_23 * v_21.y));
  let v_26 = inverseSqrt(max(dot(v_24, v_24), dot(v_25, v_25)));
  let v_27 = normalize((v_16 * transpose(mat3x3<f32>((v_24 * v_26), (v_25 * v_26), v_2))));
  let v_28 = normalize((v.u_modelParams[1i].xyz - v_17));
  let v_29 = clamp(dot(v_27, v_28), 0.0f, 1.0f);
  let v_30 = (5.0f * pow(clamp(dot(v_27, normalize((v_texcoord2.xyz + v_28))), 0.0f, 1.0f), 256.0f));
  let v_31 = (((v.u_modelParams[0i].xyz * v_1) * (0.10000000149011611938f + v_29)) + vec3<f32>(v_30, v_30, v_30));
  bgfx_FragData0 = vec4<f32>(v_31.x, v_31.y, v_31.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord0, v_texcoord1, v_texcoord2);
  return bgfx_FragData0;
}
