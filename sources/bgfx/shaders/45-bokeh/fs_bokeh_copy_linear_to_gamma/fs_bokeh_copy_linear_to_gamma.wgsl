diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_1 = pow(abs(v.xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, v.w);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
