diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_virtualLightPos_extrusionDist : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : f32;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  var v_3 : vec3<f32>;
  if ((a_texcoord0.x == 1.0f)) {
    v_3 = (a_position + (normalize((a_position - v.u_virtualLightPos_extrusionDist.xyz)) * v.u_virtualLightPos_extrusionDist.w));
  } else {
    v_3 = a_position;
  }
  let v_4 = v_3;
  v_1 = (vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f) * transpose(v.u_modelViewProj));
  v_2 = a_texcoord0.y;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : f32,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v_1, v_2);
}
