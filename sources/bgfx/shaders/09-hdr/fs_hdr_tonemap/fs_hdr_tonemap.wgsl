diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texLumSampler : sampler;

@group(0u) @binding(3u) var s_texLumTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_texBlurSampler : sampler;

@group(0u) @binding(4u) var s_texBlurTexture : texture_2d<f32>;

struct UniformBlock {
  u_tonemap : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>) {
  let v_1 = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0);
  let v_2 = (v_1.xyz * exp2(((v_1.w * 255.0f) - 128.0f)));
  let v_3 = textureSample(s_texLumTexture, s_texLumSampler, v_texcoord0);
  let v_4 = clamp((v_3.x * exp2(((v_3.w * 255.0f) - 128.0f))), 0.10000000149011611938f, 0.69999998807907104492f);
  let v_5 = dot(vec3<f32>(0.41245639324188232422f, 0.35757610201835632324f, 0.18043750524520874023f), v_2);
  let v_6 = dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_2);
  let v_7 = (1.0f / dot(vec3<f32>(v_5, v_6, dot(vec3<f32>(0.01933390088379383087f, 0.11919199675321578979f, 0.95030409097671508789f), v_2)), vec3<f32>(1.0f)));
  let v_8 = (v_5 * v_7);
  let v_9 = (v_6 * v_7);
  let v_10 = v.u_tonemap.x;
  let v_11 = ((v_6 * v_10) / (v_4 + 0.00009999999747378752f));
  let v_12 = ((v_11 * (1.0f + (v_11 / v.u_tonemap.y))) / (1.0f + v_11));
  let v_13 = vec3<f32>(((v_12 * v_8) / v_9), v_12, ((v_12 * ((1.0f - v_8) - v_9)) / v_9));
  let v_14 = (vec3<f32>(dot(vec3<f32>(3.24045419692993164062f, -1.53713846206665039062f, -0.49853140115737915039f), v_13), dot(vec3<f32>(-0.96926599740982055664f, 1.87601077556610107422f, 0.04155600070953369141f), v_13), dot(vec3<f32>(0.05564339831471443176f, -0.2040258944034576416f, 1.05722522735595703125f), v_13)) + (((((((((((textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord0) * 0.22421523928642272949f) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord1.xy) * 0.20179371535778045654f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord1.zw) * 0.20179371535778045654f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord2.xy) * 0.12331838905811309814f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord2.zw) * 0.12331838905811309814f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord3.xy) * 0.04035874456167221069f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord3.zw) * 0.04035874456167221069f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord4.xy) * 0.02242152392864227295f)) + (textureSample(s_texBlurTexture, s_texBlurSampler, v_texcoord4.zw) * 0.02242152392864227295f))).xyz * 0.60000002384185791016f));
  let v_15 = pow(abs(vec4<f32>(v_14.x, v_14.y, v_14.z, 1.0f).xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_15.x, v_15.y, v_15.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>, @location(1u) v_texcoord1 : vec4<f32>, @location(2u) v_texcoord2 : vec4<f32>, @location(3u) v_texcoord3 : vec4<f32>, @location(4u) v_texcoord4 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4);
  return bgfx_FragData0;
}
