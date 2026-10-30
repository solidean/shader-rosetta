diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColor0Sampler : sampler;

@group(0u) @binding(2u) var s_texColor0Texture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texColor1Sampler : sampler;

@group(0u) @binding(3u) var s_texColor1Texture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = textureSample(s_texColor0Texture, s_texColor0Sampler, v_texcoord0);
  let v_1 = clamp(textureSample(s_texColor1Texture, s_texColor1Sampler, v_texcoord0).x, 0.00009999999747378752f, 50000.0f);
  let v_2 = (v.xyz / vec3<f32>(v_1, v_1, v_1));
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_2.z, v.w);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
