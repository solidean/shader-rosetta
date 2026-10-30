diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec4<f32>) {
  let v = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0.xy);
  let v_1 = v.x;
  let v_2 = v_color0.w;
  let v_3 = (((v.xxx * v_color0.xyz) * v_1) * v_2);
  bgfx_FragData0 = vec4<f32>(v_3.x, v_3.y, v_3.z, ((v_1 * v_2) * (1.0f - v_texcoord0.z)));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
