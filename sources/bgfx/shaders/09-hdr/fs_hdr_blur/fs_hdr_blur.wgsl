diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>) {
  bgfx_FragData0 = (((((((((textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0) * 0.22421523928642272949f) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord1.xy) * 0.20179371535778045654f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord1.zw) * 0.20179371535778045654f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord2.xy) * 0.12331838905811309814f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord2.zw) * 0.12331838905811309814f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord3.xy) * 0.04035874456167221069f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord3.zw) * 0.04035874456167221069f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord4.xy) * 0.02242152392864227295f)) + (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord4.zw) * 0.02242152392864227295f));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>, @location(1u) v_texcoord1 : vec4<f32>, @location(2u) v_texcoord2 : vec4<f32>, @location(3u) v_texcoord3 : vec4<f32>, @location(4u) v_texcoord4 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4);
  return bgfx_FragData0;
}
