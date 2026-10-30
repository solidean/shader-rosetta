diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_quadPostColorSampler : sampler;

@group(0u) @binding(2u) var s_quadPostColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
  u_s2hMouse : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_viewRect.zw;
  let v_2 = v.u_s2hMouse;
  let v_3 = v_2.xy;
  let v_4 = textureSample(s_quadPostColorTexture, s_quadPostColorSampler, v_texcoord0).xyz;
  let v_5 = ((gl_FragCoord.xy - v_3) - vec2<f32>(24.0f));
  let v_6 = v_5.x;
  let v_7 = v_5.y;
  var v_8 : vec3<f32>;
  if (((((v_6 >= 0.0f) & (v_7 >= 0.0f)) & (v_6 < 160.0f)) & (v_7 < 160.0f))) {
    let v_9 = (v_5 * vec2<f32>(0.10000000149011611938f));
    let v_10 = textureSample(s_quadPostColorTexture, s_quadPostColorSampler, ((floor(((v_3 - vec2<f32>(8.0f)) + v_9)) + vec2<f32>(0.5f)) / v_1)).xyz;
    let v_11 = fract(v_9);
    let v_12 = ((v_11.x < 0.07999999821186065674f) | (v_11.y < 0.07999999821186065674f));
    v_8 = select(v_10, vec3<f32>(), vec3<bool>(v_12, v_12, v_12));
  } else {
    v_8 = v_4;
  }
  let v_13 = v_8;
  let v_14 = (1.0f - smoothstep(0.0f, 1.0f, min(abs((gl_FragCoord.x - v_2.x)), abs((gl_FragCoord.y - v_2.y)))));
  let v_15 = mix(v_13, vec3<f32>(1.0f), vec3<f32>(v_14, v_14, v_14));
  bgfx_FragData0 = vec4<f32>(v_15.x, v_15.y, v_15.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_texcoord0);
  return bgfx_FragData0;
}
