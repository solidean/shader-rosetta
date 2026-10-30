diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_color : array<vec4<f32>, 32u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_materialID : f32) {
  let v_1 = v.u_color[u32(v_materialID)];
  if ((v_1.w < 1.0f)) {
    if (((i32(gl_FragCoord.x) % 2i) == (i32(gl_FragCoord.y) % 2i))) {
      discard;
      return;
    }
  }
  bgfx_FragData0 = vec4<f32>(v_1.x, v_1.y, v_1.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) @interpolate(flat) v_materialID : f32) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_materialID);
  return bgfx_FragData0;
}
