diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(22u) var s_shadowMap0Sampler : sampler;

@group(0u) @binding(6u) var s_shadowMap0Texture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>) {
  let v = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord0) * 0.22421523928642272949f);
  let v_1 = vec2<f32>(dot(v.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v.zw, vec2<f32>(0.0039215688593685627f, 1.0f)));
  let v_2 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord1.xy) * 0.20179371535778045654f);
  let v_3 = (v_1 + vec2<f32>(dot(v_2.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_2.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_4 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord1.zw) * 0.20179371535778045654f);
  let v_5 = (v_3 + vec2<f32>(dot(v_4.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_4.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_6 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord2.xy) * 0.12331838905811309814f);
  let v_7 = (v_5 + vec2<f32>(dot(v_6.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_6.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_8 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord2.zw) * 0.12331838905811309814f);
  let v_9 = (v_7 + vec2<f32>(dot(v_8.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_8.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_10 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord3.xy) * 0.04035874456167221069f);
  let v_11 = (v_9 + vec2<f32>(dot(v_10.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_10.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_12 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord3.zw) * 0.04035874456167221069f);
  let v_13 = (v_11 + vec2<f32>(dot(v_12.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_12.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_14 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord4.xy) * 0.02242152392864227295f);
  let v_15 = (v_13 + vec2<f32>(dot(v_14.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_14.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_16 = (textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord4.zw) * 0.02242152392864227295f);
  let v_17 = (v_15 + vec2<f32>(dot(v_16.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_16.zw, vec2<f32>(0.0039215688593685627f, 1.0f))));
  let v_18 = fract((vec2<f32>(255.0f, 1.0f) * v_17.x));
  let v_19 = (v_18 - (v_18.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  let v_20 = fract((vec2<f32>(255.0f, 1.0f) * v_17.y));
  let v_21 = (v_20 - (v_20.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  bgfx_FragData0 = vec4<f32>(v_19.x, v_19.y, v_21.x, v_21.y);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>, @location(1u) v_texcoord1 : vec4<f32>, @location(2u) v_texcoord2 : vec4<f32>, @location(3u) v_texcoord3 : vec4<f32>, @location(4u) v_texcoord4 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4);
  return bgfx_FragData0;
}
