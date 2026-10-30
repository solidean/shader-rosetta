diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_bc : vec3<f32>, gl_FrontFacing : bool) {
  let v_1 = v.u_params[1i];
  let v_2 = v.u_params[1i].w;
  let v_3 = v.u_params[2i].y;
  var v_4 : f32;
  if (gl_FrontFacing) {
    v_4 = (v_2 * 0.5f);
  } else {
    v_4 = v_2;
  }
  let v_5 = v_4;
  let v_6 = smoothstep(vec3<f32>(), ((abs(dpdx(v_bc)) + abs(dpdy(-(v_bc)))) * v_3), v_bc);
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, ((1.0f - min(min(v_6.x, v_6.y), v_6.z)) * v_5));
}

@fragment
fn main(@location(0u) v_bc : vec3<f32>, @builtin(front_facing) gl_FrontFacing : bool) -> @location(0u) vec4<f32> {
  main_inner(v_bc, gl_FrontFacing);
  return bgfx_FragData0;
}
