diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_id : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner() {
  let v_1 = v.u_id;
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, 1.0f);
}

@fragment
fn main() -> @location(0u) vec4<f32> {
  main_inner();
  return bgfx_FragData0;
}
