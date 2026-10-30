diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(22u) var s_shadowMap0Sampler : sampler;

@group(0u) @binding(6u) var s_shadowMap0Texture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>) {
  let v = fract((vec4<f32>(16581375.0f, 65025.0f, 255.0f, 1.0f) * ((((((((dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord0) * 0.22421523928642272949f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord1.xy) * 0.20179371535778045654f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord1.zw) * 0.20179371535778045654f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord2.xy) * 0.12331838905811309814f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord2.zw) * 0.12331838905811309814f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord3.xy) * 0.04035874456167221069f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord3.zw) * 0.04035874456167221069f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord4.xy) * 0.02242152392864227295f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + dot((textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord4.zw) * 0.02242152392864227295f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))));
  bgfx_FragData0 = (v - (v.xxyz * vec4<f32>(0.0f, 0.0039215688593685627f, 0.0039215688593685627f, 0.0039215688593685627f)));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>, @location(1u) v_texcoord1 : vec4<f32>, @location(2u) v_texcoord2 : vec4<f32>, @location(3u) v_texcoord3 : vec4<f32>, @location(4u) v_texcoord4 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4);
  return bgfx_FragData0;
}
