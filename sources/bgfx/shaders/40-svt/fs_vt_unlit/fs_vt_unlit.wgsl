diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_vt_page_tableSampler : sampler;

@group(0u) @binding(2u) var s_vt_page_tableTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_vt_texture_atlasSampler : sampler;

@group(0u) @binding(3u) var s_vt_texture_atlasTexture : texture_2d<f32>;

struct UniformBlock {
  u_vt_settings_1 : vec4<f32>,
  u_vt_settings_2 : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = (v_texcoord0 * v.u_vt_settings_1.x);
  let v_2 = dpdx(v_1);
  let v_3 = dpdy(-(v_1));
  let v_4 = floor(max((0.5f * log2(max(dot(v_2, v_2), dot(v_3, v_3)))), 0.0f));
  let v_5 = v.u_vt_settings_2.y;
  let v_6 = clamp(v_4, 0.0f, log2(v_5));
  let v_7 = (v_texcoord0 * v_5);
  let v_8 = textureSampleLevel(s_vt_page_tableTexture, s_vt_page_tableSampler, (v_texcoord0 - (fract(v_7) / vec2<f32>(v_5, v_5))), v_6);
  let v_9 = exp2(floor(((v_8.z * 255.0f) + 0.5f)));
  let v_10 = (fract((v_7 / vec2<f32>(v_9, v_9))) * v.u_vt_settings_1.z);
  let v_11 = v.u_vt_settings_1.w;
  bgfx_FragData0 = textureSample(s_vt_texture_atlasTexture, s_vt_texture_atlasSampler, ((floor(((v_8.xy * 255.0f) + vec2<f32>(0.5f))) + (v_10 + vec2<f32>(v_11, v_11))) * v.u_vt_settings_1.y));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
