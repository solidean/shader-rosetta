diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> v : vec4<f32>;

var<private> v_1 : vec2<f32>;

fn main_inner(a_position : vec3<f32>, a_texcoord0 : vec2<f32>) {
  v = vec4<f32>(a_position.x, a_position.y, a_position.z, 1.0f);
  v_1 = a_texcoord0;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v, v_1);
}
