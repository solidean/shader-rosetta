diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>) {
  let v = normalize(v_normal);
  let v_1 = v.z;
  let v_2 = (v.xy * (1.0f / ((abs(v.x) + abs(v.y)) + abs(v_1))));
  let v_3 = (v_1 <= 0.0f);
  let v_4 = floor(((clamp(select(v_2, ((vec2<f32>(1.0f) - abs(v_2.yx)) * vec2<f32>(select(-1.0f, 1.0f, (v_2.x >= 0.0f)), select(-1.0f, 1.0f, (v_2.y >= 0.0f)))), vec2<bool>(v_3, v_3)), vec2<f32>(-1.0f), vec2<f32>(1.0f)) * 2047.0f) + vec2<f32>(2047.5f)));
  let v_5 = v_4.y;
  let v_6 = floor((v_5 * 0.00390625f));
  let v_7 = (v_4.x * 0.0625f);
  let v_8 = (vec3<f32>(floor(v_7), ((fract(v_7) * 256.0f) + v_6), (v_5 - (v_6 * 256.0f))) * vec3<f32>(0.0039215688593685627f));
  let v_9 = pow(abs(vec3<f32>(1.0f)), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_9.x, v_9.y, v_9.z, 0.0f);
  bgfx_FragData1 = vec4<f32>(v_8.x, v_8.y, v_8.z, 1.0f);
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>) -> tint_symbol {
  main_inner(v_normal);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
