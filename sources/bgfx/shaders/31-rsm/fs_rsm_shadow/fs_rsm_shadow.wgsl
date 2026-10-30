diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_viewTexel : vec4<f32>,
  u_tint : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>) {
  let v_1 = v.u_tint;
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, -(v_normal.z));
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal);
  return bgfx_FragData0;
}
