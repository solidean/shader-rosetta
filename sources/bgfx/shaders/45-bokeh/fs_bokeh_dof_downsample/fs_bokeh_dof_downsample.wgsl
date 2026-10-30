diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_2 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_3 = v.u_params[3i].y;
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, (clamp((((1.0f / v_3) - (1.0f / v_2)) * v.u_params[3i].z), -1.0f, 1.0f) * v.u_params[3i].x));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
