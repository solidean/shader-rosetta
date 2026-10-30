diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec2<f32>) {
  bgfx_FragData0 = (textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0) * v_color0);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
