diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texCubeSampler : sampler;

@group(0u) @binding(2u) var s_texCubeTexture : texture_cube<f32>;

struct UniformBlock_1_1 {
  u_mtx : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = ((v_texcoord0 * 2.0f) - vec2<f32>(1.0f));
  let v_2 = textureSample(s_texCubeTexture, s_texCubeSampler, normalize(((vec4<f32>(v_1.x, v_1.y, 1.0f, 0.0f) * transpose(v.u_mtx))).xyz));
  let v_3 = ceil(log2(max(max(v_2.x, v_2.y), v_2.z)));
  let v_4 = exp2(v_3);
  let v_5 = (v_2.xyz / vec3<f32>(v_4, v_4, v_4));
  bgfx_FragData0 = vec4<f32>(v_5.x, v_5.y, v_5.z, ((v_3 + 128.0f) * 0.0039215688593685627f));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
