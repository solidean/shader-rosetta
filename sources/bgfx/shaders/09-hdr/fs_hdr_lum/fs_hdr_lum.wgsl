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
  let v_2 = (v_1.xyz * exp2(((v_1.w * 255.0f) - 128.0f)));
  let v_3 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[1i].xy));
  let v_4 = (v_3.xyz * exp2(((v_3.w * 255.0f) - 128.0f)));
  let v_5 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[2i].xy));
  let v_6 = (v_5.xyz * exp2(((v_5.w * 255.0f) - 128.0f)));
  let v_7 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[3i].xy));
  let v_8 = (v_7.xyz * exp2(((v_7.w * 255.0f) - 128.0f)));
  let v_9 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[4i].xy));
  let v_10 = (v_9.xyz * exp2(((v_9.w * 255.0f) - 128.0f)));
  let v_11 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[5i].xy));
  let v_12 = (v_11.xyz * exp2(((v_11.w * 255.0f) - 128.0f)));
  let v_13 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[6i].xy));
  let v_14 = (v_13.xyz * exp2(((v_13.w * 255.0f) - 128.0f)));
  let v_15 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[7i].xy));
  let v_16 = (v_15.xyz * exp2(((v_15.w * 255.0f) - 128.0f)));
  let v_17 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[8i].xy));
  let v_18 = (v_17.xyz * exp2(((v_17.w * 255.0f) - 128.0f)));
  let v_19 = (((((((((dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_2) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_4)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_6)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_8)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_10)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_12)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_14)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_16)) + dot(vec3<f32>(0.21267290413379669189f, 0.71515220403671264648f, 0.07217500358819961548f), v_18)) * 0.11111111193895339966f);
  let v_20 = ceil(log2(v_19));
  bgfx_FragData0 = vec4<f32>((v_19 / exp2(v_20)), 0.0f, 0.0f, ((v_20 + 128.0f) * 0.0039215688593685627f));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
