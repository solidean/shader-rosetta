diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_svparams : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_k : f32, gl_FrontFacing : bool) {
  var v_1 : f32;
  if (!(gl_FrontFacing)) {
    v_1 = -(v_k);
  } else {
    v_1 = v_k;
  }
  let v_2 = v_1;
  var v_3 : f32;
  if ((v.u_svparams.y == 0.0f)) {
    v_3 = -(v_2);
  } else {
    v_3 = v_2;
  }
  let v_4 = v_3;
  bgfx_FragData0 = vec4<f32>(select(0.0f, 0.0039215688593685627f, (abs((v_4 - 1.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_4 + 1.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_4 - 2.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_4 + 2.0f)) < 0.00009999999747378752f)));
}

@fragment
fn main(@location(0u) v_k : f32, @builtin(front_facing) gl_FrontFacing : bool) -> @location(0u) vec4<f32> {
  main_inner(v_k, gl_FrontFacing);
  return bgfx_FragData0;
}
