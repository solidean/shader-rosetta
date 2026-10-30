diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_normal : vec3<f32>) {
  let v = dot(normalize(v_normal), vec3<f32>(0.0f, 0.0f, -1.0f));
  let v_1 = pow(v, 30.0f);
  let v_2 = pow(((pow(v_color0.xyz, vec3<f32>(2.20000004768371582031f)) * v) + vec3<f32>(v_1, v_1, v_1)), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_normal : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_normal);
  return bgfx_FragData0;
}
