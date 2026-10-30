diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec3<f32>, v_texcoord0 : vec2<f32>) {
  bgfx_FragData0 = vec4<f32>(v_texcoord0.x, v_texcoord0.y, (v_position.y * 0.01999999955296516418f), 1.0f);
}

@fragment
fn main(@location(0u) v_position : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position, v_texcoord0);
  return bgfx_FragData0;
}
