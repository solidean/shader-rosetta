diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewTexel : vec4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_smSamplingParams : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec2<f32>;

var<private> v_3 : vec4<f32>;

var<private> v_4 : vec4<f32>;

var<private> v_5 : vec4<f32>;

var<private> v_6 : vec4<f32>;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_7 = (v.u_viewTexel.y * v.u_smSamplingParams.w);
  let v_8 = a_texcoord0.x;
  let v_9 = a_texcoord0.y;
  let v_10 = (v_7 * 2.0f);
  let v_11 = (v_7 * 3.0f);
  let v_12 = (v_7 * 4.0f);
  v_1 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_modelViewProj));
  v_2 = a_texcoord0;
  v_3 = vec4<f32>(v_8, (v_9 - v_7), v_8, (v_9 + v_7));
  v_4 = vec4<f32>(v_8, (v_9 - v_10), v_8, (v_9 + v_10));
  v_5 = vec4<f32>(v_8, (v_9 - v_11), v_8, (v_9 + v_11));
  v_6 = vec4<f32>(v_8, (v_9 - v_12), v_8, (v_9 + v_12));
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec2<f32>,
  @location(1u)
  m_2 : vec4<f32>,
  @location(2u)
  m_3 : vec4<f32>,
  @location(3u)
  m_4 : vec4<f32>,
  @location(4u)
  m_5 : vec4<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5, v_6);
}
