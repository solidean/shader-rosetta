diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texSampler : sampler;

@group(0u) @binding(2u) var s_texTexture : texture_2d<f32>;

struct UniformBlock {
  u_pixelSize : vec4<f32>,
  u_intensity : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_pixelSize;
  let v_2 = v_1.x;
  let v_3 = -(v_2);
  let v_4 = v_1.y;
  let v_5 = -(v_4);
  bgfx_FragData0 = ((((((((((textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_3, 0.0f))) * 0.125f) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(0.0f, v_4))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_2, 0.0f))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(0.0f, v_5))) * 0.125f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_3, v_5))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_3, v_4))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_2, v_5))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, (v_texcoord0 + vec2<f32>(v_2, v_4))) * 0.0625f)) + (textureSample(s_texTexture, s_texSampler, v_texcoord0) * 0.25f)) * v.u_intensity.x);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
