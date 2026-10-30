diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_3d<f32>;

struct UniformBlock {
  u_time : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec3<f32>) {
  let v_1 = ((v_texcoord0.xy * 0.5f) + vec2<f32>(0.5f));
  let v_2 = textureSample(s_texColorTexture, s_texColorSampler, vec3<f32>(v_1.x, v_1.y, ((sin(v.u_time.x) * 0.5f) + 0.5f))).x;
  bgfx_FragData0 = vec4<f32>(v_2, v_2, v_2, v_2);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
