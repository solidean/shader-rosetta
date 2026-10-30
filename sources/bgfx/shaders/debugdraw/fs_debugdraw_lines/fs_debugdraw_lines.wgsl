diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>) {
  bgfx_FragData0 = v_color0;
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0);
  return bgfx_FragData0;
}
