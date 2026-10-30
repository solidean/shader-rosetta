diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

fn main_inner(a_color0 : vec4<f32>, a_position : vec3<f32>, i_data0 : vec4<f32>, i_data1 : vec4<f32>, i_data2 : vec4<f32>, i_data3 : vec4<f32>, i_data4 : vec4<f32>) {
  v_1 = ((vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(mat4x4<f32>(i_data0, i_data1, i_data2, i_data3))) * transpose(v.u_viewProj));
  v_2 = (a_color0 * i_data4);
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
}

@vertex
fn main(@location(0u) a_color0 : vec4<f32>, @location(1u) a_position : vec3<f32>, @location(2u) i_data0 : vec4<f32>, @location(3u) i_data1 : vec4<f32>, @location(4u) i_data2 : vec4<f32>, @location(5u) i_data3 : vec4<f32>, @location(6u) i_data4 : vec4<f32>) -> tint_symbol {
  main_inner(a_color0, a_position, i_data0, i_data1, i_data2, i_data3, i_data4);
  return tint_symbol(v_1, v_2);
}
