diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texCoord : vec3<f32>) {
  let v_1 = v_texCoord.z;
  let v_2 = (mix(vec3<f32>(0.10000000149011611938f, 0.80000001192092895508f, 0.20000000298023223877f), vec3<f32>(0.15000000596046447754f, 0.125f, 0.02500000037252902985f), vec3<f32>(v_1, v_1, v_1)) * (v.u_params[1i].x * pow(max((1.0f - length(v_texCoord.xy)), 0.0f), v.u_params[1i].w)));
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_2.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texCoord : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texCoord);
  return bgfx_FragData0;
}
