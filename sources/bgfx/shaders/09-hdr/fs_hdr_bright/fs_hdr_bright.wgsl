diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texLumSampler : sampler;

@group(0u) @binding(3u) var s_texLumTexture : texture_2d<f32>;

struct UniformBlock {
  u_offset : array<vec4<f32>, 16u>,
  u_tonemap : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_texLumTexture, s_texLumSampler, v_texcoord0);
  let v_2 = clamp((v_1.x * exp2(((v_1.w * 255.0f) - 128.0f))), 0.10000000149011611938f, 0.69999998807907104492f);
  let v_3 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[0i].xy));
  let v_4 = (v_3.xyz * exp2(((v_3.w * 255.0f) - 128.0f)));
  let v_5 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[1i].xy));
  let v_6 = (v_4 + (v_5.xyz * exp2(((v_5.w * 255.0f) - 128.0f))));
  let v_7 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[2i].xy));
  let v_8 = (v_6 + (v_7.xyz * exp2(((v_7.w * 255.0f) - 128.0f))));
  let v_9 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[3i].xy));
  let v_10 = (v_8 + (v_9.xyz * exp2(((v_9.w * 255.0f) - 128.0f))));
  let v_11 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[4i].xy));
  let v_12 = (v_10 + (v_11.xyz * exp2(((v_11.w * 255.0f) - 128.0f))));
  let v_13 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[5i].xy));
  let v_14 = (v_12 + (v_13.xyz * exp2(((v_13.w * 255.0f) - 128.0f))));
  let v_15 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[6i].xy));
  let v_16 = (v_14 + (v_15.xyz * exp2(((v_15.w * 255.0f) - 128.0f))));
  let v_17 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[7i].xy));
  let v_18 = (v_16 + (v_17.xyz * exp2(((v_17.w * 255.0f) - 128.0f))));
  let v_19 = textureSample(s_texColorTexture, s_texColorSampler, (v_texcoord0 + v.u_offset[8i].xy));
  let v_20 = ((v_18 + (v_19.xyz * exp2(((v_19.w * 255.0f) - 128.0f)))) * 0.11111111193895339966f);
  let v_21 = v.u_tonemap.x;
  let v_22 = v.u_tonemap.y;
  let v_23 = v.u_tonemap.z;
  let v_24 = (v_2 + 0.00009999999747378752f);
  let v_25 = ((max(vec3<f32>(), (v_20 - vec3<f32>(v_23, v_23, v_23))) * v_21) / vec3<f32>(v_24, v_24, v_24));
  let v_26 = ((v_25 * (vec3<f32>(1.0f) + (v_25 / vec3<f32>(v_22, v_22, v_22)))) / (vec3<f32>(1.0f) + v_25));
  let v_27 = pow(abs(vec4<f32>(v_26.x, v_26.y, v_26.z, 1.0f).xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_27.x, v_27.y, v_27.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
