diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_eye : f32) {
  let v = (v_color0.xyz * mix(vec3<f32>(1.0f, 0.15000000596046447754f, 0.15000000596046447754f), vec3<f32>(0.15000000596046447754f, 0.40000000596046447754f, 1.0f), vec3<f32>(v_eye, v_eye, v_eye)));
  bgfx_FragData0 = vec4<f32>(v.x, v.y, v.z, 1.0f);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_eye : f32) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_eye);
  return bgfx_FragData0;
}
