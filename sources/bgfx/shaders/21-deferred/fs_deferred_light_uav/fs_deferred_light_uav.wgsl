diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_normalSampler : sampler;

@group(0u) @binding(2u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_lightPosRadius : array<vec4<f32>, 1u>,
  u_lightRgbInnerR : array<vec4<f32>, 1u>,
  u_mtx : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

@group(0u) @binding(5u) var i_light : texture_storage_2d<rgba8unorm, read_write>;

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_texcoord0 : vec2<f32>) {
  let v_1 = ((textureSample(s_normalTexture, s_normalSampler, v_texcoord0).xyz * 2.0f) - vec3<f32>(1.0f));
  let v_2 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_3 = ((v_texcoord0 * 2.0f) - vec2<f32>(1.0f));
  let v_4 = (vec4<f32>(v_3.x, -(v_3.y), v_2, 1.0f) * transpose(v.u_mtx));
  let v_5 = v_4.w;
  let v_6 = vec2<i32>(gl_FragCoord.xy);
  let v_7 = v.u_lightPosRadius[0i].xyz;
  let v_8 = v.u_lightPosRadius[0i].w;
  let v_9 = v.u_lightRgbInnerR[0i].xyz;
  let v_10 = (v_7 - (v_4.xyz / vec3<f32>(v_5, v_5, v_5)));
  let v_11 = (1.0f - smoothstep(v.u_lightRgbInnerR[0i].w, 1.0f, (length(v_10) / v_8)));
  let v_12 = ((v_9 * clamp(max(0.0f, dot(v_1, normalize(v_10))), 0.0f, 1.0f)) * v_11);
  let v_13 = textureLoad(i_light, v_6);
  let v_14 = pow(abs(v_12), vec3<f32>(0.45454546809196472168f));
  textureStore(i_light, v_6, (v_13 + vec4<f32>(v_14.x, v_14.y, v_14.z, 1.0f)));
}
