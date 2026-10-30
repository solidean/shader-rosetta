diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_normalSampler : sampler;

@group(0u) @binding(2u) var s_normalTexture : texture_2d_array<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_lightPosRadius : array<vec4<f32>, 1u>,
  u_lightRgbInnerR : array<vec4<f32>, 1u>,
  u_mtx : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = vec3<f32>(v_texcoord0.x, v_texcoord0.y, 1.0f);
  let v_2 = ((textureSample(s_normalTexture, s_normalSampler, v_1.xy, i32(v_1.z)).xyz * 2.0f) - vec3<f32>(1.0f));
  let v_3 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_4 = ((v_texcoord0 * 2.0f) - vec2<f32>(1.0f));
  let v_5 = (vec4<f32>(v_4.x, -(v_4.y), v_3, 1.0f) * transpose(v.u_mtx));
  let v_6 = v_5.w;
  let v_7 = v.u_lightPosRadius[0i].xyz;
  let v_8 = v.u_lightPosRadius[0i].w;
  let v_9 = v.u_lightRgbInnerR[0i].xyz;
  let v_10 = (v_7 - (v_5.xyz / vec3<f32>(v_6, v_6, v_6)));
  let v_11 = (1.0f - smoothstep(v.u_lightRgbInnerR[0i].w, 1.0f, (length(v_10) / v_8)));
  let v_12 = pow(abs(((v_9 * clamp(max(0.0f, dot(v_2, normalize(v_10))), 0.0f, 1.0f)) * v_11)), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_12.x, v_12.y, v_12.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
