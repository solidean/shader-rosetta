diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 4u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_world : vec3<f32>) {
  let v_1 = ((dot(normalize(cross(dpdx(v_world), dpdy(-(v_world)))), v.u_params[0i].xyz) * 0.5f) + 0.5f);
  let v_2 = (mix(v.u_params[2i].xyz, v.u_params[1i].xyz, vec3<f32>(v_1, v_1, v_1)) * v.u_params[3i].xyz);
  bgfx_FragData0 = vec4<f32>(v_2.x, v_2.y, v_2.z, v.u_params[3i].w);
}

@fragment
fn main(@location(1u) v_world : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_world);
  return bgfx_FragData0;
}
