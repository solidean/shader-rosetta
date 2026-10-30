diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_texcoord0 : vec2<f32>) {
  let v = textureSample(s_albedoTexture, s_albedoSampler, v_texcoord0);
  bgfx_FragData0 = vec4<f32>(v_normal.x, v_normal.y, v_normal.z, 0.0f);
  bgfx_FragData1 = v;
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(v_normal, v_texcoord0);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
