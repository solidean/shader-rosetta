diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_shadowcoord : vec4<f32>) {
  bgfx_FragData0 = vec4<f32>((v_shadowcoord.z / v_shadowcoord.w), 0.0f, 0.0f, 1.0f);
}

@fragment
fn main(@location(0u) v_shadowcoord : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_shadowcoord);
  return bgfx_FragData0;
}
