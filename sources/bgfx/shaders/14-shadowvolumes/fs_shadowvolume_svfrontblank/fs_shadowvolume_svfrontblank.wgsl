diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner() {
  bgfx_FragData0 = vec4<f32>(0.0f, 0.0f, 0.0f, 1.0f);
}

@fragment
fn main() -> @location(0u) vec4<f32> {
  main_inner();
  return bgfx_FragData0;
}
