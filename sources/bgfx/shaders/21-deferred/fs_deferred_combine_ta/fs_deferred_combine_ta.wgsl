diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_albedoSampler : sampler;

@group(0u) @binding(2u) var s_albedoTexture : texture_2d_array<f32>;

@group(0u) @binding(19u) var s_lightSampler : sampler;

@group(0u) @binding(3u) var s_lightTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = vec3<f32>(v_texcoord0.x, v_texcoord0.y, 0.0f);
  let v_1 = textureSample(s_albedoTexture, s_albedoSampler, v.xy, i32(v.z));
  let v_2 = pow(abs(v_1.xyz), vec3<f32>(2.20000004768371582031f));
  let v_3 = textureSample(s_lightTexture, s_lightSampler, v_texcoord0);
  let v_4 = pow(abs(v_3.xyz), vec3<f32>(2.20000004768371582031f));
  let v_5 = (vec4<f32>(v_2.x, v_2.y, v_2.z, v_1.w) * vec4<f32>(v_4.x, v_4.y, v_4.z, v_3.w));
  let v_6 = pow(abs(v_5.xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_6.x, v_6.y, v_6.z, v_5.w);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
