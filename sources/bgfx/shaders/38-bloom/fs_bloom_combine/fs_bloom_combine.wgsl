diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_lightSampler : sampler;

@group(0u) @binding(3u) var s_lightTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = pow(clamp((textureSample(s_albedoTexture, s_albedoSampler, v_texcoord0).xyz + textureSample(s_lightTexture, s_lightSampler, v_texcoord0).xyz), vec3<f32>(), vec3<f32>(1.0f)), vec3<f32>(0.45454543828964233398f));
  bgfx_FragData0 = vec4<f32>(v.x, v.y, v.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
