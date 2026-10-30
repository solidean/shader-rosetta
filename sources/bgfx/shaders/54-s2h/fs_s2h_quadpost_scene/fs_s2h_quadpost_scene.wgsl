diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_s2hTime : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v_texcoord0.x;
  let v_2 = v_texcoord0.y;
  let v_3 = (step(0.95999997854232788086f, fract((v_1 * 10.0f))) + step(0.95999997854232788086f, fract((v_2 * 10.0f))));
  let v_4 = (0.5f + (0.5f * sin(((v.u_s2hTime.x + (v_1 * 8.0f)) + (v_2 * 5.0f)))));
  let v_5 = mix(mix(vec3<f32>(0.05999999865889549255f, 0.10000000149011611938f, 0.25f), vec3<f32>(0.89999997615814208984f, 0.25f, 0.10000000149011611938f), vec3<f32>(v_4, v_4, v_4)), vec3<f32>(1.0f), vec3<f32>(v_3, v_3, v_3));
  bgfx_FragData0 = vec4<f32>(v_5.x, v_5.y, v_5.z, 1.0f);
}

@fragment
fn main(@location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
