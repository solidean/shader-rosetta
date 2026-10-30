diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_k : f32, gl_FrontFacing : bool) {
  var v : f32;
  if (!(gl_FrontFacing)) {
    v = -(v_k);
  } else {
    v = v_k;
  }
  let v_1 = v;
  bgfx_FragData0 = vec4<f32>(select(0.0f, 0.0039215688593685627f, (abs((v_1 - 1.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_1 + 1.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_1 - 2.0f)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs((v_1 + 2.0f)) < 0.00009999999747378752f)));
}

@fragment
fn main(@location(0u) v_k : f32, @builtin(front_facing) gl_FrontFacing : bool) -> @location(0u) vec4<f32> {
  main_inner(v_k, gl_FrontFacing);
  return bgfx_FragData0;
}
