diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_normal : vec3<f32>, v_view : vec3<f32>) {
  let v = normalize(v_normal);
  let v_1 = normalize(v_view);
  let v_2 = dot(v, vec3<f32>(0.0f, 0.0f, -1.0f));
  let v_3 = dot((vec3<f32>(0.0f, 0.0f, -1.0f) - (v * (2.0f * v_2))), v_1);
  let v_4 = max(0.0f, v_2);
  let v_5 = (step(0.0f, v_2) * max(0.0f, v_3));
  let v_6 = (max((0.20000000298023223877f + (0.80000001192092895508f * pow((1.0f - v_2), 5.0f))), 0.0f) * pow(v_5, 128.0f));
  let v_7 = pow(((vec3<f32>(0.07000000029802322388f, 0.05999999865889549255f, 0.07999999821186065674f) + (v_color0.xyz * v_4)) + vec3<f32>(v_6, v_6, v_6)), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_7.x, v_7.y, v_7.z, 1.0f);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_normal : vec3<f32>, @location(3u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_normal, v_view);
  return bgfx_FragData0;
}
