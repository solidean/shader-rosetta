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

var<private> v_4 : vec2<f32>;

var<private> v_5 : vec3<f32>;

fn main_inner(a_normal : vec3<f32>, a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  let v_6 = ((a_normal * 2.0f) - vec3<f32>(1.0f));
  let v_7 = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  let v_8 = (v_7 * transpose(v.u_modelViewProj));
  let v_9 = v_8.w;
  let v_10 = transpose(v.u_modelView);
  v_1 = v_8;
  v_2 = ((vec4<f32>(v_6.x, v_6.y, v_6.z, 0.0f) * v_10)).xyz;
  v_3 = (v_8.xyz / vec3<f32>(v_9, v_9, v_9));
  v_4 = a_texcoord0;
  v_5 = ((v_7 * v_10)).xyz;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec3<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec2<f32>,
  @location(3u)
  m_4 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_normal : vec3<f32>, @location(1u) a_position : vec3<f32>, @location(2u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_normal, a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3, v_4, v_5);
}
