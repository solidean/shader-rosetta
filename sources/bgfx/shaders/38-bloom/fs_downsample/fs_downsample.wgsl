diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texSampler : sampler;

@group(0u) @binding(2u) var s_texTexture : texture_2d<f32>;

struct UniformBlock {
  u_pixelSize : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = vec2<f32>(v.u_pixelSize.x, v.u_pixelSize.y);
  let v_2 = (v_1 * 0.5f);
  let v_3 = (v_1 * 1.0f);
  let v_4 = v_2.x;
  let v_5 = -(v_4);
  let v_6 = v_2.y;
  let v_7 = -(v_6);
  let v_8 = v_3.x;
  let v_9 = -(v_8);
  let v_10 = v_3.y;
  let v_11 = -(v_10);
  bgfx_FragData0 = (((((((((((((textureSample(s_texTexture, s_texSampler, v_texcoord0) * 0.125f) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_5, v_7))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + v_2)) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_4, v_7))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_5, v_6))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_8, 0.0f))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_9, 0.0f))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(0.0f, v_10))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(0.0f, v_11))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + v_3)) * 0.03125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_9, v_10))) * 0.03125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_8, v_11))) * 0.03125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_9, v_11))) * 0.03125f));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
