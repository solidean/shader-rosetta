diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_depthSampler : sampler;

@group(0u) @binding(2u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 12u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_2 = (v.u_params[1i].x / (v.u_params[1i].y - v_1));
  bgfx_FragData0 = vec4<f32>(v_2, v_2, v_2, v_2);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
