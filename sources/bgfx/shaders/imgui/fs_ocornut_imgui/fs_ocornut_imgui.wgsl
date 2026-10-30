diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texSampler : sampler;

@group(0u) @binding(2u) var s_texTexture : texture_2d<f32>;

struct UniformBlock {
  u_imguiOutput : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = (textureSample(s_texTexture, s_texSampler, v_texcoord0) * v_color0);
  let v_2 = v_1.xyz;
  var v_3 : vec3<f32>;
  switch(0u) {
    default: {
      let v_4 = v.u_imguiOutput.x;
      if ((v_4 < 0.5f)) {
        v_3 = v_2;
        break;
      }
      let v_5 = (mix(pow(((v_2 + vec3<f32>(0.05499999970197677612f)) * vec3<f32>(0.94786733388900756836f)), vec3<f32>(2.40000009536743164062f)), (v_2 * vec3<f32>(0.07739938050508499146f)), select(vec3<f32>(), vec3<f32>(1.0f), (v_2 <= vec3<f32>(0.04044999927282333374f)))) * v.u_imguiOutput.y);
      if ((v_4 < 1.5f)) {
        v_3 = v_5;
        break;
      }
      let v_6 = pow(clamp(vec3<f32>(dot(vec3<f32>(0.62739998102188110352f, 0.32929998636245727539f, 0.04329999908804893494f), v_5), dot(vec3<f32>(0.06909999996423721313f, 0.91949999332427978516f, 0.0114000001922249794f), v_5), dot(vec3<f32>(0.01640000008046627045f, 0.0879999995231628418f, 0.8956000208854675293f), v_5)), vec3<f32>(), vec3<f32>(1.0f)), vec3<f32>(0.1593017578125f));
      v_3 = pow(((vec3<f32>(0.8359375f) + (v_6 * 18.8515625f)) / (vec3<f32>(1.0f) + (v_6 * 18.6875f))), vec3<f32>(78.84375f));
    }
  }
  let v_7 = v_3;
  bgfx_FragData0 = vec4<f32>(v_7.x, v_7.y, v_7.z, v_1.w);
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0);
  return bgfx_FragData0;
}
