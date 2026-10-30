diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec4<f32>) {
  let v = i32(((v_texcoord0.w * 4.0f) + 0.5f));
  let v_1 = v_texcoord0.xyz;
  let v_2 = dpdx(v_1);
  let v_3 = dpdy(-(v_1));
  let v_4 = (v_2 * 0.1666669994592666626f);
  let v_5 = textureSample(s_texColorTexture, s_texColorSampler, (v_1 - v_4)).zyxw[v];
  let v_6 = textureSample(s_texColorTexture, s_texColorSampler, (v_1 + v_4)).zyxw[v];
  let v_7 = (0.5f * (v_5 + v_6));
  let v_8 = (8.0f * (length(v_2) + length(v_3)));
  let v_9 = (0.5f - v_8);
  let v_10 = (0.5f + v_8);
  let v_11 = v_color0.w;
  let v_12 = (smoothstep(vec3<f32>(v_9, v_9, v_9), vec3<f32>(v_10, v_10, v_10), vec3<f32>(v_5, v_7, v_6)) * v_11);
  bgfx_FragData0 = vec4<f32>(v_12.x, v_12.y, v_12.z, (v_7 * v_11));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
