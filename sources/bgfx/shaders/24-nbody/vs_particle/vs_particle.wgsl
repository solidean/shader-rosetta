diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_proj : mat4x4<f32>,
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec3<f32>;

fn main_inner(a_position : vec2<f32>, i_data0 : vec4<f32>) {
  let v_3 = ((vec4<f32>(i_data0.x, i_data0.y, i_data0.z, 1.0f) * transpose(v.u_view))).xyz;
  let v_4 = normalize(cross(v_3, vec3<f32>(1.0f, 0.0f, 0.0f)));
  let v_5 = normalize(cross(v_4, v_3));
  let v_6 = v.u_params[1i].y;
  let v_7 = ((v_3 + ((v_5 * v_6) * a_position.x)) + ((v_4 * v_6) * a_position.y));
  v_1 = (vec4<f32>(v_7.x, v_7.y, v_7.z, 1.0f) * transpose(v.u_proj));
  v_2 = vec3<f32>(a_position.x, a_position.y, i_data0.w);
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_position : vec2<f32>, @location(1u) i_data0 : vec4<f32>) -> tint_symbol {
  main_inner(a_position, i_data0);
  return tint_symbol(v_1, v_2);
}
