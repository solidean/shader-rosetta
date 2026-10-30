diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec2<f32>) {
  bgfx_FragData0 = ((v_color0 * textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0)) * vec4<f32>(1.0f, 1.0f, 1.0f, v.u_params.w));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
