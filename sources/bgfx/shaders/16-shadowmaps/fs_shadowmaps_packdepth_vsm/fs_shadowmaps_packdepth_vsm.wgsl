diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec4<f32>) {
  let v = (((v_position.z / v_position.w) * 0.5f) + 0.5f);
  let v_1 = fract((vec2<f32>(255.0f, 1.0f) * v));
  let v_2 = (v_1 - (v_1.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  let v_3 = fract((vec2<f32>(255.0f, 1.0f) * (v * v)));
  let v_4 = (v_3 - (v_3.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_4.x, v_4.y);
}

@fragment
fn main(@location(0u) v_position : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position);
  return bgfx_FragData0;
}
