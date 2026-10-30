diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_time : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

var<private> v_3 : vec3<f32>;

var<private> v_4 : vec3<f32>;

var<private> v_5 : vec3<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec3<f32>) {
  let v_6 = (v.u_time.x * 4.0f);
  let v_7 = ((sin(((a_position.x * 32.0f) + v_6)) * 0.5f) + 0.5f);
  let v_8 = ((cos(((a_position.y * 32.0f) + v_6)) * 0.5f) + 0.5f);
  let v_9 = vec3<f32>(v_7, v_8, (v_7 * v_8));
  let v_10 = ((a_normal * 2.0f) - vec3<f32>(1.0f));
  let v_11 = (a_position + ((v_10 * v_9) * vec3<f32>(0.05999999865889549255f)));
  let v_12 = vec4<f32>(v_11.x, v_11.y, v_11.z, 1.0f);
  let v_13 = (v_12 * transpose(v.u_modelViewProj));
  let v_14 = transpose(v.u_modelView);
  let v_15 = ((length(v_9) * 0.40000000596046447754f) + 0.60000002384185791016f);
  v_1 = v_13;
  v_2 = vec4<f32>(v_15, v_15, v_15, 1.0f);
  v_3 = ((vec4<f32>(v_10.x, v_10.y, v_10.z, 0.0f) * v_14)).xyz;
  v_4 = v_13.xyz;
  v_5 = ((v_12 * v_14)).xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec3<f32>,
  @location(3u)
  m_4 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_normal, a_position);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5);
}
