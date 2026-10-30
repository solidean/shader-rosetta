diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_world : vec3<f32>) {
  let v = max(normalize(cross(dpdx(v_world), dpdy(-(v_world)))).z, 0.0f);
  let v_1 = pow(v, 30.0f);
  bgfx_FragData0 = pow(((pow(v_color0, vec4<f32>(2.20000004768371582031f)) * v) + vec4<f32>(v_1, v_1, v_1, v_1)), vec4<f32>(0.45454546809196472168f));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_world : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_world);
  return bgfx_FragData0;
}
