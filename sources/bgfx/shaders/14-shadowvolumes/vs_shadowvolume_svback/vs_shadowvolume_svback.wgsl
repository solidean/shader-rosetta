diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_virtualLightPos_extrusionDist : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

fn main_inner(a_position : vec3<f32>) {
  let v_2 = (a_position + (normalize((a_position - v.u_virtualLightPos_extrusionDist.xyz)) * v.u_virtualLightPos_extrusionDist.w));
  v_1 = (vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f) * transpose(v.u_modelViewProj));
}

@vertex
fn main(@location(0u) a_position : vec3<f32>) -> @builtin(position) vec4<f32> {
  main_inner(a_position);
  return v_1;
}
