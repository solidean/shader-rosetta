diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec2<f32>;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_4 = transpose(v.u_model[0i]);
  let v_5 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * v_4);
  v_1 = (vec4<f32>(v_5.x, v_5.y, v_5.z, 1.0f) * transpose(v.u_viewProj));
  v_2 = v_5.xyz;
  v_3 = ((vec4<f32>(a_texcoord0.x, a_texcoord0.y, 1.0f, 1.0f) * v_4)).xy;
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
