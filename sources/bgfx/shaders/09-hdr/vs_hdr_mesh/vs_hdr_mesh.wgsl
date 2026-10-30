diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec3<f32>;

var<private> v_4 : vec3<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec3<f32>) {
  let v_5 = ((a_normal * 2.0f) - vec3<f32>(1.0f));
  let v_6 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_7 = (v_6 * transpose(v.u_modelViewProj));
  let v_8 = transpose(v.u_modelView);
  v_1 = v_7;
  v_2 = ((vec4<f32>(v_5.x, v_5.y, v_5.z, 0.0f) * v_8)).xyz;
  v_3 = v_7.xyz;
  v_4 = ((v_6 * v_8)).xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_normal, a_position);
  return tint_symbol(v_1, v_2, v_3, v_4);
}
