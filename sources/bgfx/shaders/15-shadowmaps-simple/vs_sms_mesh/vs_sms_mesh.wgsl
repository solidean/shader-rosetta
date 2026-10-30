diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_lightMtx : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

var<private> v_3 : vec4<f32>;

var<private> v_4 : vec3<f32>;

fn main_inner(a_normal : vec4<f32>, a_position : vec3<f32>) {
  let v_5 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_6 = (v_5 * transpose(v.u_modelViewProj));
  let v_7 = ((a_normal * 2.0f) - vec4<f32>(1.0f));
  let v_8 = transpose(v.u_modelView);
  let v_9 = normalize(((vec4<f32>(v_7.x, v_7.y, v_7.z, 0.0f) * v_8)).xyz);
  let v_10 = (a_position + (v_7.xyz * 0.00100000004749745131f));
  let v_11 = (vec4<f32>(v_10.x, v_10.y, v_10.z, 1.0f) * transpose(v.u_lightMtx));
  v_1 = v_6;
  v_2 = v_9;
  v_3 = v_11;
  v_4 = ((v_5 * v_8)).xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec4<f32>,
  @location(2u)
  m_3 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec4<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_normal, a_position);
  return tint_symbol(v_1, v_2, v_3, v_4);
}
