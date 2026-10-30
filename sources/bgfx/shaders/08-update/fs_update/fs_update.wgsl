diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texCubeSampler : sampler;

@group(0u) @binding(2u) var s_texCubeTexture : texture_cube<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec3<f32>) {
  bgfx_FragData0 = textureSample(s_texCubeTexture, s_texCubeSampler, v_texcoord0);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
