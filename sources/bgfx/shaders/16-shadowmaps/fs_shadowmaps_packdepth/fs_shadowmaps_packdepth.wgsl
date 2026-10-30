diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec4<f32>) {
  let v = fract((vec4<f32>(16581375.0f, 65025.0f, 255.0f, 1.0f) * (((v_position.z / v_position.w) * 0.5f) + 0.5f)));
  bgfx_FragData0 = (v - (v.xxyz * vec4<f32>(0.0f, 0.0039215688593685627f, 0.0039215688593685627f, 0.0039215688593685627f)));
}

@fragment
fn main(@location(0u) v_position : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position);
  return bgfx_FragData0;
}
