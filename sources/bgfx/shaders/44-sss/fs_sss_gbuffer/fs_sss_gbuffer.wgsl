diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>) {
  let v = pow(abs(textureSample(s_albedoTexture, s_albedoSampler, v_texcoord0).xyz), vec3<f32>(2.20000004768371582031f));
  let v_1 = normalize(v_normal);
  let v_2 = textureSample(s_normalTexture, s_normalSampler, v_texcoord0);
  var v_3 : vec3<f32> = vec3<f32>();
  v_3.x = v_2.x;
  var v_4 : vec3<f32> = v_3;
  v_4.y = v_2.y;
  let v_5 = ((v_4.xy * 2.0f) - vec2<f32>(1.0f));
  let v_6 = v_5.x;
  var v_7 : vec3<f32> = vec3<f32>();
  v_7.x = v_6;
  let v_8 = v_5.y;
  var v_9 : vec3<f32> = v_7;
  v_9.y = v_8;
  let v_10 = v_9.xy;
  let v_11 = sqrt((1.0f - dot(v_10, v_10)));
  var v_12 : vec3<f32> = vec3<f32>(v_6, v_8, v_11);
  v_12.x = v_8;
  var v_13 : vec3<f32> = v_12;
  v_13.y = v_6;
  let v_14 = v_13;
  let v_15 = v_texcoord1.xyz;
  let v_16 = dpdx(v_15);
  let v_17 = dpdy(-(v_15));
  let v_18 = dpdx(v_texcoord0);
  let v_19 = dpdy(-(v_texcoord0));
  let v_20 = cross(v_17, v_1);
  let v_21 = cross(v_1, v_16);
  let v_22 = ((v_20 * v_18.x) + (v_21 * v_19.x));
  let v_23 = ((v_20 * v_18.y) + (v_21 * v_19.y));
  let v_24 = inverseSqrt(max(dot(v_22, v_22), dot(v_23, v_23)));
  let v_25 = normalize((v_14 * transpose(mat3x3<f32>((v_22 * v_24), (v_23 * v_24), v_1))));
  let v_26 = (((v_11 * mix(0.89999997615814208984f, 1.0f, v.y)) * 0.60000002384185791016f) + 0.20000000298023223877f);
  let v_27 = v_25.z;
  let v_28 = (v_25.xy * (1.0f / ((abs(v_25.x) + abs(v_25.y)) + abs(v_27))));
  let v_29 = (v_27 <= 0.0f);
  let v_30 = floor(((clamp(select(v_28, ((vec2<f32>(1.0f) - abs(v_28.yx)) * vec2<f32>(select(-1.0f, 1.0f, (v_28.x >= 0.0f)), select(-1.0f, 1.0f, (v_28.y >= 0.0f)))), vec2<bool>(v_29, v_29)), vec2<f32>(-1.0f), vec2<f32>(1.0f)) * 2047.0f) + vec2<f32>(2047.5f)));
  let v_31 = v_30.y;
  let v_32 = floor((v_31 * 0.00390625f));
  let v_33 = (v_30.x * 0.0625f);
  let v_34 = (vec3<f32>(floor(v_33), ((fract(v_33) * 256.0f) + v_32), (v_31 - (v_32 * 256.0f))) * vec3<f32>(0.0039215688593685627f));
  let v_35 = pow(abs(v), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_35.x, v_35.y, v_35.z, 1.0f);
  bgfx_FragData1 = vec4<f32>(v_34.x, v_34.y, v_34.z, v_26);
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>, @location(2u) v_texcoord1 : vec4<f32>) -> tint_symbol {
  main_inner(v_normal, v_texcoord0, v_texcoord1);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
