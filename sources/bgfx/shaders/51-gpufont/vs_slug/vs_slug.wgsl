diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_viewRect : vec4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_params : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

var<private> v_3 : vec4<f32>;

var<private> v_4 : vec2<f32>;

fn main_inner(a_position : vec4<f32>, a_texcoord0 : vec4<f32>, a_texcoord1 : vec4<f32>) {
  let v_5 = v.u_params.w;
  let v_6 = vec4<f32>(v_5, 0.0f, 0.0f, v_5);
  let v_7 = a_position.zw;
  let v_8 = v.u_viewRect;
  let v_9 = normalize(v_7);
  let v_10 = transpose(v.u_modelViewProj);
  let v_11 = (vec4<f32>(a_position.x, a_position.y, 0.0f, 1.0f) * v_10);
  let v_12 = (vec4<f32>(v_9.x, v_9.y, 0.0f, 0.0f) * v_10);
  let v_13 = v_11.w;
  let v_14 = v_12.w;
  let v_15 = (((v_13 * v_12.x) - (v_14 * v_11.x)) * v_8.z);
  let v_16 = (((v_13 * v_12.y) - (v_14 * v_11.y)) * v_8.w);
  let v_17 = (v_13 * v_14);
  let v_18 = ((v_15 * v_15) + (v_16 * v_16));
  let v_19 = (v_7 * (((v_13 * v_13) * (v_17 + sqrt(v_18))) / (v_18 - (v_17 * v_17))));
  let v_20 = (a_position.xy + v_19);
  let v_21 = vec2<f32>((a_texcoord0.x + dot(v_19, v_6.xy)), (a_texcoord0.y + dot(v_19, v_6.zw)));
  let v_22 = bitcast<vec2<u32>>(a_texcoord0.zw);
  let v_23 = v_22.x;
  let v_24 = v_22.y;
  v_1 = (vec4<f32>(v_20.x, v_20.y, 0.0f, 1.0f) * v_10);
  v_2 = a_texcoord1;
  v_3 = vec4<f32>(f32((v_23 & 65535u)), f32((v_23 >> 16u)), f32((v_24 & 65535u)), f32((v_24 >> 16u)));
  v_4 = v_21;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u) @interpolate(flat)
  m_1 : vec4<f32>,
  @location(1u) @interpolate(flat)
  m_2 : vec4<f32>,
  @location(2u)
  m_3 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_position : vec4<f32>, @location(1u) a_texcoord0 : vec4<f32>, @location(2u) a_texcoord1 : vec4<f32>) -> tint_symbol {
  main_inner(a_position, a_texcoord0, a_texcoord1);
  return tint_symbol(v_1, v_2, v_3, v_4);
}
