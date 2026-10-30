diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_viewProj : mat4x4<f32>,
  u_model : array<mat4x4<f32>, 1u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

fn main_inner(a_position : vec3<f32>) {
  let v_3 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_model[0i]));
  let v_4 = vec4<f32>(v_3.x, v_3.y, v_3.z, 1.0f);
  let v_5 = (v_4 * transpose(v.u_viewProj));
  var v_6 : vec4<f32> = v_5;
  v_6.x = ((v_4 * transpose(v.u_view))).z;
  let v_7 = v_6;
  v_1 = v_5;
  v_2 = v_7;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_position);
  return tint_symbol(v_1, v_2);
}
