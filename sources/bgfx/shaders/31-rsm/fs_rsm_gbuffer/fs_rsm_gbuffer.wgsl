diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_tint : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>) {
  let v_1 = v.u_tint;
  bgfx_FragData0 = vec4<f32>(v_normal.x, v_normal.y, v_normal.z, 0.0f);
  bgfx_FragData1 = v_1;
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>) -> tint_symbol {
  main_inner(v_normal);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
