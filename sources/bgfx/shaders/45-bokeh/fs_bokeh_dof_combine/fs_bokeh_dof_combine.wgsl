diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_blurredColorSampler : sampler;

@group(0u) @binding(3u) var s_blurredColorTexture : texture_2d<f32>;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_1 = textureSample(s_blurredColorTexture, s_blurredColorSampler, v_texcoord0);
  let v_2 = clamp((v_1.w - 1.0f), 0.0f, 1.0f);
  let v_3 = mix(v.xyz, v_1.xyz, vec3<f32>(v_2, v_2, v_2));
  var v_4 : vec4<f32> = v;
  v_4.x = v_3.x;
  var v_5 : vec4<f32> = v_4;
  v_5.y = v_3.y;
  var v_6 : vec4<f32> = v_5;
  v_6.z = v_3.z;
  let v_7 = v_6;
  let v_8 = pow(abs(v_7.xyz), vec3<f32>(0.45454546809196472168f));
  var v_9 : vec4<f32> = v_7;
  v_9.x = v_8.x;
  var v_10 : vec4<f32> = v_9;
  v_10.y = v_8.y;
  var v_11 : vec4<f32> = v_10;
  v_11.z = v_8.z;
  bgfx_FragData0 = v_11;
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
