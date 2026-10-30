diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_depth : f32) {
  let v = fract((vec2<f32>(255.0f, 1.0f) * v_depth));
  let v_1 = (v - (v.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  let v_2 = fract((vec2<f32>(255.0f, 1.0f) * (v_depth * v_depth)));
  let v_3 = (v_2 - (v_2.xx * vec2<f32>(0.0f, 0.0039215688593685627f)));
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_3.x, v_3.y);
}

@fragment
fn main(@location(0u) v_depth : f32) -> @location(0u) vec4<f32> {
  main_inner(v_depth);
  return bgfx_FragData0;
}
