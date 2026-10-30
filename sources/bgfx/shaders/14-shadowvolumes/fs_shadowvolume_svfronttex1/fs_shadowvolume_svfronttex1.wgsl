diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FrontFacing : bool) {
  _ = select(-1.0f, 1.0f, gl_FrontFacing);
  let v = 0.0f;
  let v_1 = -2.0f;
  let v_2 = 2.0f;
  let v_3 = 0.0f;
  let v_4 = -1.0f;
  let v_5 = -3.0f;
  let v_6 = 3.0f;
  let v_7 = 1.0f;
  bgfx_FragData0 = vec4<f32>(select(0.0f, 0.0039215688593685627f, (abs(select(-2.0f, 0.0f, gl_FrontFacing)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs(select(0.0f, 2.0f, gl_FrontFacing)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs(select(-3.0f, -1.0f, gl_FrontFacing)) < 0.00009999999747378752f)), select(0.0f, 0.0039215688593685627f, (abs(select(1.0f, 3.0f, gl_FrontFacing)) < 0.00009999999747378752f)));
}

@fragment
fn main(@builtin(front_facing) gl_FrontFacing : bool) -> @location(0u) vec4<f32> {
  main_inner(gl_FrontFacing);
  return bgfx_FragData0;
}
