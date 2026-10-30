diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_color : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0);
  let v_2 = pow(abs(v_1.xyz), vec3<f32>(2.20000004768371582031f));
  let v_3 = v_2.x;
  if ((v_3 < 0.10000000149011611938f)) {
    discard;
    return;
  }
  let v_4 = (vec4<f32>(v_3, v_2.y, v_2.z, v_1.w) + v.u_color);
  let v_5 = pow(abs(v_4.xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_5.x, v_5.y, v_5.z, v_4.w);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
