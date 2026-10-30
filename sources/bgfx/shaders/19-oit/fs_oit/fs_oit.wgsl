diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_color : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner() {
  bgfx_FragData0 = v.u_color;
}

@fragment
fn main() -> @location(0u) vec4<f32> {
  main_inner();
  return bgfx_FragData0;
}
