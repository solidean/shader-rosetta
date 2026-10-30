diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v_texcoord0.x;
  let v_2 = v.u_params.x;
  let v_3 = (4.0f * v_2);
  let v_4 = v_texcoord0.y;
  let v_5 = v.u_params.y;
  let v_6 = (4.0f * v_5);
  let v_7 = (3.0f * v_2);
  let v_8 = (3.0f * v_5);
  let v_9 = (2.0f * v_2);
  let v_10 = (2.0f * v_5);
  let v_11 = (((((((((textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 - v_3), (v_4 - v_6))) * 0.05000000074505805969f) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 - v_7), (v_4 - v_8))) * 0.09000000357627868652f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 - v_9), (v_4 - v_10))) * 0.11999999731779098511f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 - v_2), (v_4 - v_5))) * 0.15000000596046447754f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>(v_1, v_4)) * 0.15999999642372131348f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 + v_2), (v_4 + v_5))) * 0.15000000596046447754f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 + v_9), (v_4 + v_10))) * 0.11999999731779098511f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 + v_7), (v_4 + v_8))) * 0.09000000357627868652f)) + (textureSample(s_texColorTexture, s_texColorSampler, vec2<f32>((v_1 + v_3), (v_4 + v_6))) * 0.05000000074505805969f));
  let v_12 = v.u_params.z;
  bgfx_FragData0 = (v_11 * vec4<f32>(v_12, v_12, v_12, (v_12 * v.u_params.w)));
}

@fragment
fn main(@location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
