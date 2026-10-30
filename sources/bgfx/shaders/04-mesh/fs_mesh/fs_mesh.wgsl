diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_time : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_normal : vec3<f32>, v_pos : vec3<f32>, v_view : vec3<f32>) {
  let v_1 = normalize(v_normal);
  let v_2 = normalize(v_view);
  let v_3 = dot(v_1, vec3<f32>(0.0f, 0.0f, -1.0f));
  let v_4 = dot((vec3<f32>(0.0f, 0.0f, -1.0f) - (v_1 * (2.0f * v_3))), v_2);
  let v_5 = max(0.0f, v_3);
  let v_6 = (step(0.0f, v_3) * max(0.0f, v_4));
  let v_7 = max((0.20000000298023223877f + (0.80000001192092895508f * pow((1.0f - v_3), 5.0f))), 0.0f);
  let v_8 = v.u_time.x;
  let v_9 = (2.09999990463256835938f + (((sin(((v_pos.x * 3.0f) + v_8)) * 0.30000001192092895508f) + (cos(((v_pos.y * 3.0f) + v_8)) * 0.40000000596046447754f)) + (cos(((v_pos.z * 3.0f) + v_8)) * 0.20000000298023223877f)));
  let v_10 = (vec3<f32>(0.07000000029802322388f, 0.05999999865889549255f, 0.07999999821186065674f) + ((vec3<f32>(((sin((v_9 * 25.1327419281005859375f)) * 0.40000000596046447754f) + 0.60000002384185791016f), ((sin((v_9 * 12.56637096405029296875f)) * 0.40000000596046447754f) + 0.60000002384185791016f), ((sin((v_9 * 6.28318548202514648438f)) * 0.40000000596046447754f) + 0.60000002384185791016f)) * v_color0.xyz) * v_5));
  let v_11 = (v_7 * pow(v_6, 128.0f));
  let v_12 = pow((v_10 + vec3<f32>(v_11, v_11, v_11)), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_12.x, v_12.y, v_12.z, 1.0f);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_normal : vec3<f32>, @location(2u) v_pos : vec3<f32>, @location(3u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_normal, v_pos, v_view);
  return bgfx_FragData0;
}
