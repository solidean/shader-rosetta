diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_viewSize : vec4<f32>,
  u_halfTexel : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec2<f32>;

var<private> v_3 : vec2<f32>;

fn main_inner(a_position : vec2<f32>, a_texcoord0 : vec2<f32>) {
  let v_4 = (a_texcoord0 + v.u_halfTexel.xy);
  v_1 = vec4<f32>((((2.0f * a_position.x) / v.u_viewSize.x) - 1.0f), (1.0f - ((2.0f * a_position.y) / v.u_viewSize.y)), 0.0f, 1.0f);
  v_2 = a_position;
  v_3 = v_4;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec2<f32>,
  @location(1u)
  m_2 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_position : vec2<f32>, @location(1u) a_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0);
  return tint_symbol(v_1, v_2, v_3);
}
