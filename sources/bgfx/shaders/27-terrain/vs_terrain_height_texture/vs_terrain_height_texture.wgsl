diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_heightTextureSampler : sampler;

@group(0u) @binding(2u) var s_heightTextureTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec2<f32>;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_4 = (textureSampleLevel(s_heightTextureTexture, s_heightTextureSampler, a_texcoord0, 0.0f).x * 255.0f);
  var v_5 : vec3<f32> = a_position;
  v_5.y = v_4;
  let v_6 = v_5;
  v_1 = (vec4<f32>(a_position.x, v_4, a_position.z, 1.0f) * transpose(v.u_modelViewProj));
  v_2 = v_6;
  v_3 = a_texcoord0;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3);
}
