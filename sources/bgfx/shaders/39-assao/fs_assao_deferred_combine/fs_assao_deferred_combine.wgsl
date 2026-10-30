diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_aoSampler : sampler;

@group(0u) @binding(4u) var s_aoTexture : texture_2d<f32>;

struct UniformBlock {
  u_combineParams : array<vec4<f32>, 2u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_combineParams[1i];
  let v_2 = ((v_texcoord0 * v_1.xy) + v_1.zw);
  let v_3 = (v.u_combineParams[0i].x > 0.0f);
  var v_4 : vec3<f32>;
  if (v_3) {
    v_4 = textureSample(s_colorTexture, s_colorSampler, v_2).xyz;
  } else {
    v_4 = vec3<f32>(1.0f);
  }
  let v_5 = v_4;
  var v_6 : f32;
  if (v_3) {
    v_6 = ((max(0.0f, dot(((textureSample(s_normalTexture, s_normalSampler, v_2).xyz * 2.0f) - vec3<f32>(1.0f)), vec3<f32>(-0.53905367851257324219f, 0.50536286830902099609f, -0.67381709814071655273f))) * 1.20000004768371582031f) + 0.30000001192092895508f);
  } else {
    v_6 = 1.0f;
  }
  let v_7 = v_6;
  var v_8 : f32;
  if ((v.u_combineParams[0i].y > 0.0f)) {
    v_8 = textureSample(s_aoTexture, s_aoSampler, v_2).x;
  } else {
    v_8 = 1.0f;
  }
  let v_9 = ((v_5 * v_7) * v_8);
  bgfx_FragData0 = vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
