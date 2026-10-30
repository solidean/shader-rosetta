diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var u_SmapSamplerSampler : sampler;

@group(0u) @binding(3u) var u_SmapSamplerTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 2u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = -((textureSample(u_SmapSamplerTexture, u_SmapSamplerSampler, v_texcoord0).xy * v.u_params[0i].x));
  let v_2 = abs(normalize(vec3<f32>(v_1.x, v_1.y, 1.0f)));
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
