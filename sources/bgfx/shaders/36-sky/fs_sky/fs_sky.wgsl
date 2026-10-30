diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_parameters : vec4<f32>,
  u_sunDirection : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_skyColor : vec3<f32>, v_viewDir : vec3<f32>) {
  let v_1 = v.u_parameters.x;
  let v_2 = (v_1 * v_1);
  let v_3 = normalize(v.u_sunDirection.xyz);
  let v_4 = (1.0f - dot(normalize(v_viewDir), v_3));
  let v_5 = (exp((((v_4 * -2.0f) / v.u_parameters.y) / v_2)) + step((2.0f * v_4), v_2));
  let v_6 = min((v_5 * v_5), 1.0f);
  let v_7 = pow(abs((v_skyColor + vec3<f32>(v_6, v_6, v_6))), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_7.x, v_7.y, v_7.z, 1.0f);
}

@fragment
fn main(@location(1u) v_skyColor : vec3<f32>, @location(2u) v_viewDir : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_skyColor, v_viewDir);
  return bgfx_FragData0;
}
