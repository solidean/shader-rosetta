diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(22u) var s_shadowMap0Sampler : sampler;

@group(0u) @binding(6u) var s_shadowMap0Texture : texture_2d<f32>;

struct UniformBlock {
  u_params2 : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_texcoord0).xy, vec2<f32>(0.0039215688593685627f, 1.0f));
  let v_2 = v.u_params2.x;
  let v_3 = pow(vec3<f32>(v_1, v_1, v_1), vec3<f32>(v_2, v_2, v_2));
  bgfx_FragData0 = vec4<f32>(v_3.x, v_3.y, v_3.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
