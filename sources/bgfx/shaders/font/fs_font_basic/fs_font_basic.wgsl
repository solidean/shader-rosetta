diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec4<f32>) {
  let v = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0.xyz);
  let v_1 = i32(((v_texcoord0.w * 4.0f) + 0.5f));
  bgfx_FragData0 = vec4<f32>(v_color0.x, v_color0.y, v_color0.z, (v_color0.w * select(select(select(v.w, v.x, (v_1 < 3i)), v.y, (v_1 < 2i)), v.z, (v_1 < 1i))));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
