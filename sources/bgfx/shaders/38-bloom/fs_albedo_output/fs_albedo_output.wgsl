diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_color : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner() {
  let v_1 = v.u_color;
  bgfx_FragData0 = v_1;
  bgfx_FragData1 = v_1;
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main() -> tint_symbol {
  main_inner();
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
