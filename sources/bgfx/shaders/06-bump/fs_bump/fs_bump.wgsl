diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texNormalSampler : sampler;

@group(0u) @binding(3u) var s_texNormalTexture : texture_2d<f32>;

struct UniformBlock {
  u_lightPosRadius : array<vec4<f32>, 4u>,
  u_lightRgbInnerR : array<vec4<f32>, 4u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_bitangent : vec3<f32>, v_normal : vec3<f32>, v_tangent : vec3<f32>, v_texcoord0 : vec2<f32>, v_wpos : vec3<f32>) {
  let v_1 = transpose(mat3x3<f32>(v_tangent, v_bitangent, v_normal));
  let v_2 = ((textureSample(s_texNormalTexture, s_texNormalSampler, v_texcoord0).xy * 2.0f) - vec2<f32>(1.0f));
  let v_3 = v_2.x;
  var v_4 : vec3<f32> = vec3<f32>();
  v_4.x = v_3;
  let v_5 = v_2.y;
  var v_6 : vec3<f32> = v_4;
  v_6.y = v_5;
  let v_7 = v_6.xy;
  let v_8 = vec3<f32>(v_3, v_5, sqrt((1.0f - dot(v_7, v_7))));
  let v_9 = (v.u_lightPosRadius[0i].xyz - v_wpos);
  let v_10 = (1.0f - smoothstep(v.u_lightRgbInnerR[0i].w, 1.0f, (length(v_9) / v.u_lightPosRadius[0i].w)));
  let v_11 = max(0.0f, dot(v_8, (v_1 * normalize(v_9))));
  let v_12 = ((v.u_lightRgbInnerR[0i].xyz * clamp(v_11, 0.0f, 1.0f)) * v_10);
  let v_13 = (v.u_lightPosRadius[1i].xyz - v_wpos);
  let v_14 = (1.0f - smoothstep(v.u_lightRgbInnerR[1i].w, 1.0f, (length(v_13) / v.u_lightPosRadius[1i].w)));
  let v_15 = max(0.0f, dot(v_8, (v_1 * normalize(v_13))));
  let v_16 = (v_12 + ((v.u_lightRgbInnerR[1i].xyz * clamp(v_15, 0.0f, 1.0f)) * v_14));
  let v_17 = (v.u_lightPosRadius[2i].xyz - v_wpos);
  let v_18 = (1.0f - smoothstep(v.u_lightRgbInnerR[2i].w, 1.0f, (length(v_17) / v.u_lightPosRadius[2i].w)));
  let v_19 = max(0.0f, dot(v_8, (v_1 * normalize(v_17))));
  let v_20 = (v_16 + ((v.u_lightRgbInnerR[2i].xyz * clamp(v_19, 0.0f, 1.0f)) * v_18));
  let v_21 = (v.u_lightPosRadius[3i].xyz - v_wpos);
  let v_22 = (1.0f - smoothstep(v.u_lightRgbInnerR[3i].w, 1.0f, (length(v_21) / v.u_lightPosRadius[3i].w)));
  let v_23 = max(0.0f, dot(v_8, (v_1 * normalize(v_21))));
  let v_24 = (v_20 + ((v.u_lightRgbInnerR[3i].xyz * clamp(v_23, 0.0f, 1.0f)) * v_22));
  let v_25 = pow(abs(textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0).xyz), vec3<f32>(2.20000004768371582031f));
  let v_26 = (max(vec3<f32>(0.05000000074505805969f), v_24) * vec4<f32>(v_25.x, v_25.y, v_25.z, 0.0f).xyz);
  let v_27 = pow(abs(vec4<f32>(v_26.x, v_26.y, v_26.z, 1.0f).xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_27.x, v_27.y, v_27.z, 1.0f);
}

@fragment
fn main(@location(0u) v_bitangent : vec3<f32>, @location(1u) v_normal : vec3<f32>, @location(2u) v_tangent : vec3<f32>, @location(3u) v_texcoord0 : vec2<f32>, @location(5u) v_wpos : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_bitangent, v_normal, v_tangent, v_texcoord0, v_wpos);
  return bgfx_FragData0;
}
