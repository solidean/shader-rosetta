diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_offset : array<vec4<f32>, 16u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[0i].xy));
  let v_2 = (v_1.x * exp2(((v_1.w * 255.0f) - 128.0f)));
  let v_3 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[1i].xy));
  let v_4 = (v_2 + (v_3.x * exp2(((v_3.w * 255.0f) - 128.0f))));
  let v_5 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[2i].xy));
  let v_6 = (v_4 + (v_5.x * exp2(((v_5.w * 255.0f) - 128.0f))));
  let v_7 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[3i].xy));
  let v_8 = (v_6 + (v_7.x * exp2(((v_7.w * 255.0f) - 128.0f))));
  let v_9 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[4i].xy));
  let v_10 = (v_8 + (v_9.x * exp2(((v_9.w * 255.0f) - 128.0f))));
  let v_11 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[5i].xy));
  let v_12 = (v_10 + (v_11.x * exp2(((v_11.w * 255.0f) - 128.0f))));
  let v_13 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[6i].xy));
  let v_14 = (v_12 + (v_13.x * exp2(((v_13.w * 255.0f) - 128.0f))));
  let v_15 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[7i].xy));
  let v_16 = (v_14 + (v_15.x * exp2(((v_15.w * 255.0f) - 128.0f))));
  let v_17 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[8i].xy));
  let v_18 = (v_16 + (v_17.x * exp2(((v_17.w * 255.0f) - 128.0f))));
  let v_19 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[9i].xy));
  let v_20 = (v_18 + (v_19.x * exp2(((v_19.w * 255.0f) - 128.0f))));
  let v_21 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[10i].xy));
  let v_22 = (v_20 + (v_21.x * exp2(((v_21.w * 255.0f) - 128.0f))));
  let v_23 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[11i].xy));
  let v_24 = (v_22 + (v_23.x * exp2(((v_23.w * 255.0f) - 128.0f))));
  let v_25 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[12i].xy));
  let v_26 = (v_24 + (v_25.x * exp2(((v_25.w * 255.0f) - 128.0f))));
  let v_27 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[13i].xy));
  let v_28 = (v_26 + (v_27.x * exp2(((v_27.w * 255.0f) - 128.0f))));
  let v_29 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[14i].xy));
  let v_30 = (v_28 + (v_29.x * exp2(((v_29.w * 255.0f) - 128.0f))));
  let v_31 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[15i].xy));
  let v_32 = ((v_30 + (v_31.x * exp2(((v_31.w * 255.0f) - 128.0f)))) * 0.0625f);
  let v_33 = ceil(log2(v_32));
  bgfx_FragData0 = vec4<f32>((v_32 / exp2(v_33)), 0.0f, 0.0f, ((v_33 + 128.0f) * 0.0039215688593685627f));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
