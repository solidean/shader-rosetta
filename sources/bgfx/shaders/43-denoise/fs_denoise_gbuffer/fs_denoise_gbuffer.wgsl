diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewTexel : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

var<private> bgfx_FragData2 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>) {
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
  let v_12 = sqrt((1.0f - dot(v_11, v_11)));
  var v_13 : vec3<f32> = vec3<f32>(v_7, v_9, v_12);
  v_13.x = v_9;
  var v_14 : vec3<f32> = v_13;
  v_14.y = v_7;
  let v_15 = v_14;
  let v_16 = v_texcoord2.xyz;
  let v_17 = dpdx(v_16);
  let v_18 = dpdy(-(v_16));
  let v_19 = dpdx(v_texcoord0);
  let v_20 = dpdy(-(v_texcoord0));
  let v_21 = cross(v_18, v_2);
  let v_22 = cross(v_2, v_17);
  let v_23 = ((v_21 * v_19.x) + (v_22 * v_20.x));
  let v_24 = ((v_21 * v_19.y) + (v_22 * v_20.y));
  let v_25 = inverseSqrt(max(dot(v_23, v_23), dot(v_24, v_24)));
  let v_26 = normalize((v_15 * transpose(mat3x3<f32>((v_23 * v_25), (v_24 * v_25), v_2))));
  let v_27 = (((v_12 * mix(0.89999997615814208984f, 1.0f, v_1.y)) * 0.60000002384185791016f) + 0.20000000298023223877f);
  let v_28 = (v_texcoord1.xy * (1.0f / v_texcoord1.w));
  var v_29 : vec2<f32> = v_28;
  v_29.y = (v_28.y * -1.0f);
  let v_30 = ((v_29 * 0.5f) + vec2<f32>(0.5f));
  let v_31 = ((gl_FragCoord.xy * v.u_viewTexel.xy) - v_30);
  let v_32 = ((v_26 * 0.5f) + vec3<f32>(0.5f));
  let v_33 = pow(abs(v_1), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_33.x, v_33.y, v_33.z, 1.0f);
  bgfx_FragData1 = vec4<f32>(v_32.x, v_32.y, v_32.z, v_27);
  bgfx_FragData2 = vec4<f32>(v_31.x, v_31.y, 0.0f, 0.0f);
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
  @location(2u)
  bgfx_FragData2 : vec4<f32>,
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>) -> tint_symbol {
  main_inner(gl_FragCoord, v_normal, v_texcoord0, v_texcoord1, v_texcoord2);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1, bgfx_FragData2);
}
