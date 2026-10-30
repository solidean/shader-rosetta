diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_depthScaleOffset : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec4<f32>) {
  let v_1 = fract((vec4<f32>(16581375.0f, 65025.0f, 255.0f, 1.0f) * (((v_position.z / v_position.w) * v.u_depthScaleOffset.x) + v.u_depthScaleOffset.y)));
  bgfx_FragData0 = (v_1 - (v_1.xxyz * vec4<f32>(0.0f, 0.0039215688593685627f, 0.0039215688593685627f, 0.0039215688593685627f)));
}

@fragment
fn main(@location(0u) v_position : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position);
  return bgfx_FragData0;
}
