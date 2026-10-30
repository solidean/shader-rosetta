diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewRect : vec4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_params : array<vec4<f32>, 12u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_3 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_modelViewProj));
  let v_4 = (((a_texcoord0 * 2.0f) - vec2<f32>(1.0f)) * vec2<f32>((0.41421356797218322754f * (v.u_viewRect.z / v.u_viewRect.w)), 0.41421356797218322754f));
  let v_5 = ((vec4<f32>(v_4.x, v_4.y, 1.0f, 0.0f) * transpose(mat4x4<f32>(v.u_params[0i], v.u_params[1i], v.u_params[2i], v.u_params[3i])))).xyz;
  v_1 = v_3;
  v_2 = v_5;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v_1, v_2);
}
