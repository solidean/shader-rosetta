diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_vt_settings_1 : vec4<f32>,
  u_vt_settings_2 : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_vt_settings_2.y;
  let v_2 = log2(v_1);
  let v_3 = (v_texcoord0 * v.u_vt_settings_1.x);
  let v_4 = dpdx(v_3);
  let v_5 = dpdy(-(v_3));
  let v_6 = clamp(floor((max((0.5f * log2(max(dot(v_4, v_4), dot(v_5, v_5)))), 0.0f) - v.u_vt_settings_2.x)), 0.0f, v_2);
  let v_7 = floor((v_texcoord0 * v_1));
  let v_8 = exp2(v_6);
  let v_9 = (v_7 / vec2<f32>(v_8, v_8));
  let v_10 = (floor(vec3<f32>(v_9.x, v_9.y, v_6)) * vec3<f32>(0.0039215688593685627f));
  bgfx_FragData0 = vec4<f32>(v_10.x, v_10.y, v_10.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
