diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

fn main_inner(a_position : vec3<f32>, i_data0 : vec4<f32>, i_data1 : vec4<f32>, i_data2 : vec4<f32>, i_data3 : vec4<f32>) {
  v_1 = ((vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(mat4x4<f32>(i_data0, i_data1, i_data2, i_data3))) * transpose(v.u_viewProj));
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) i_data0 : vec4<f32>, @location(2u) i_data1 : vec4<f32>, @location(3u) i_data2 : vec4<f32>, @location(4u) i_data3 : vec4<f32>) -> @builtin(position) vec4<f32> {
  main_inner(a_position, i_data0, i_data1, i_data2, i_data3);
  return v_1;
}
