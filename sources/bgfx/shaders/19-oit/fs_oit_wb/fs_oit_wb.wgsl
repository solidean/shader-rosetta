diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_color : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_pos : vec4<f32>) {
  let v_1 = v.u_color;
  let v_2 = v_1.w;
  let v_3 = (v_1.xyz * v_2);
  var v_4 : vec4<f32> = v_1;
  v_4.x = v_3.x;
  var v_5 : vec4<f32> = v_4;
  v_5.y = v_3.y;
  var v_6 : vec4<f32> = v_5;
  v_6.z = v_3.z;
  let v_7 = v_6;
  bgfx_FragData0 = (v_7 * (v_2 * clamp((0.02999999932944774628f / (0.00000999999974737875f + pow(((v_pos.z / v_pos.w) * 0.00499999988824129105f), 5.0f))), 0.00999999977648258209f, 3000.0f)));
  bgfx_FragData1 = v_7.wwww;
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_pos : vec4<f32>) -> tint_symbol {
  main_inner(v_pos);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
