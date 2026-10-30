diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texCubeSampler : sampler;

@group(0u) @binding(2u) var s_texCubeTexture : texture_cube<f32>;

struct UniformBlock {
  u_tonemap : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_pos : vec3<f32>, v_view : vec3<f32>) {
  let v_1 = normalize(v_normal);
  let v_2 = normalize(v_view);
  let v_3 = dot(v_1, vec3<f32>(0.0f, 0.0f, -1.0f));
  let v_4 = dot((vec3<f32>(0.0f, 0.0f, -1.0f) - (v_1 * (2.0f * v_3))), v_2);
  let v_5 = max(0.0f, v_3);
  let v_6 = (step(0.0f, v_3) * max(0.0f, v_4));
  let v_7 = max((0.20000000298023223877f + (0.80000001192092895508f * pow((1.0f - v_3), 5.0f))), 0.0f);
  let v_8 = v.u_tonemap.w;
  let v_9 = (2.09999990463256835938f + (((sin(((v_pos.x * 3.0f) + v_8)) * 0.30000001192092895508f) + (cos(((v_pos.y * 3.0f) + v_8)) * 0.40000000596046447754f)) + (cos(((v_pos.z * 3.0f) + v_8)) * 0.20000000298023223877f)));
  let v_10 = ((vec3<f32>(((sin((v_9 * 25.1327419281005859375f)) * 0.40000000596046447754f) + 0.60000002384185791016f), ((sin((v_9 * 12.56637096405029296875f)) * 0.40000000596046447754f) + 0.60000002384185791016f), ((sin((v_9 * 6.28318548202514648438f)) * 0.40000000596046447754f) + 0.60000002384185791016f)) * textureSample(s_texCubeTexture, s_texCubeSampler, reflect(v_2, -(v_1))).xyz) * v_5);
  let v_11 = (v_7 * pow(v_6, 128.0f));
  let v_12 = (v_10 + vec3<f32>(v_11, v_11, v_11));
  let v_13 = ceil(log2(max(max(v_12.x, v_12.y), v_12.z)));
  let v_14 = exp2(v_13);
  let v_15 = (v_12 / vec3<f32>(v_14, v_14, v_14));
  bgfx_FragData0 = vec4<f32>(v_15.x, v_15.y, v_15.z, ((v_13 + 128.0f) * 0.0039215688593685627f));
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_pos : vec3<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_pos, v_view);
  return bgfx_FragData0;
}
