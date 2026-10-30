diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_params[11i].y;
  var v_2 : f32;
  if ((1.5f < v_1)) {
    v_2 = select(1.0f, 0.0f, (fract((sin(dot((gl_FragCoord.xy + (vec2<f32>(314.0f, 159.0f) * v.u_params[11i].x)), vec2<f32>(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f)) < 0.5f));
  } else {
    var v_3 : f32;
    if ((0.5f < v_1)) {
      let v_4 = gl_FragCoord.x;
      let v_5 = i32((v_4 - (2.0f * floor((v_4 * 0.5f)))));
      let v_6 = gl_FragCoord.y;
      let v_7 = ((i32((v_6 - (2.0f * floor((v_6 * 0.5f))))) * 2i) + v_5);
      let v_8 = v.u_params[11i].x;
      v_3 = select(0.0f, 1.0f, (v_7 == i32((v_8 - (4.0f * floor((v_8 * 0.25f)))))));
    } else {
      v_3 = 1.0f;
    }
    v_2 = v_3;
  }
  let v_9 = v_2;
  let v_10 = clamp(dot(((textureSample(s_normalTexture, s_normalSampler, v_texcoord0).xyz * 2.0f) - vec3<f32>(1.0f)), vec3<f32>(-0.19245009124279022217f, 0.96225047111511230469f, -0.19245009124279022217f)), 0.0f, 1.0f);
  let v_11 = ((((v_10 * 0.99000000953674316406f) + 0.00999999977648258209f) + (5.0f * pow(v_10, 513.0f))) * v_9);
  bgfx_FragData0 = vec4<f32>(v_11, v_11, v_11, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_texcoord0);
  return bgfx_FragData0;
}
