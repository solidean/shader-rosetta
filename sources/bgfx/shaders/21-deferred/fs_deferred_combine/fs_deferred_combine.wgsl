diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_lightSampler : sampler;

@group(0u) @binding(3u) var s_lightTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = textureSample(s_albedoTexture, s_albedoSampler, v_texcoord0);
  let v_1 = pow(abs(v.xyz), vec3<f32>(2.20000004768371582031f));
  let v_2 = textureSample(s_lightTexture, s_lightSampler, v_texcoord0);
  let v_3 = pow(abs(v_2.xyz), vec3<f32>(2.20000004768371582031f));
  let v_4 = (vec4<f32>(v_1.x, v_1.y, v_1.z, v.w) * vec4<f32>(v_3.x, v_3.y, v_3.z, v_2.w));
  let v_5 = pow(abs(v_4.xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_5.x, v_5.y, v_5.z, v_4.w);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
