diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_eyeParams : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

var<private> v_3 : f32;

fn main_inner(a_color0 : vec4<f32>, a_position : vec3<f32>) {
  let v_4 = (vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f) * transpose(v.u_modelViewProj));
  var v_5 : vec4<f32> = v_4;
  v_5.x = (v_4.x + ((-1.0f * v.u_eyeParams.x) * v_4.w));
  v_1 = v_5;
  v_2 = a_color0;
  v_3 = 0.0f;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec4<f32>,
  @location(1u)
  m_2 : f32,
}

@vertex
fn main(@location(0u) a_color0 : vec4<f32>, @location(1u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_color0, a_position);
  return tint_symbol(v_1, v_2, v_3);
}
