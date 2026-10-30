diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texStencilSampler : sampler;

@group(0u) @binding(3u) var s_texStencilTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_viewTexel : vec4<f32>,
  u_view : mat4x4<f32>,
  u_params : vec4<f32>,
  u_svparams : vec4<f32>,
  u_ambient : vec4<f32>,
  u_diffuse : vec4<f32>,
  u_specular_shininess : vec4<f32>,
  u_fog : vec4<f32>,
  u_lightPosRadius : vec4<f32>,
  u_lightRgbInnerR : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_texcoord0 : vec2<f32>, v_view : vec3<f32>) {
  let v_1 = (v.u_ambient.xyz * v.u_params.x);
  let v_2 = normalize(v_normal);
  let v_3 = -(normalize(v_view));
  let v_4 = v.u_lightPosRadius;
  let v_5 = (((vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f) * transpose(v.u_view))).xyz - v_view);
  let v_6 = normalize(v_5);
  let v_7 = dot(v_2, v_6);
  let v_8 = dot(((v_2 * (2.0f * v_7)) - v_6), v_3);
  let v_9 = v.u_specular_shininess.w;
  let v_10 = max(0.0f, v_7);
  let v_11 = (step(0.0f, v_7) * pow(max(0.0f, v_8), v_9));
  let v_12 = (50.0f * pow(max(length(v_5), v.u_lightPosRadius.w), -2.0f));
  let v_13 = (((((v.u_diffuse.xyz * v_10) + (v.u_specular_shininess.xyz * v_11)) * v.u_lightRgbInnerR.xyz) * v_12) * v.u_params.y);
  let v_14 = v.u_viewTexel.xy;
  let v_15 = textureSample(s_texStencilTexture, s_texStencilSampler, ((gl_FragCoord.xy * v_14) + (v_14 * v.u_params.z)));
  let v_16 = (((v_15.x - v_15.y) + (2.0f * (v_15.z - v_15.w))) * v.u_svparams.x);
  let v_17 = length(v_view);
  let v_18 = v.u_fog.w;
  let v_19 = clamp((1.0f / exp2(((((v_18 * v_18) * v_17) * v_17) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_20 = pow(abs(textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0).xyz), vec3<f32>(2.20000004768371582031f));
  let v_21 = vec4<f32>(v_20.x, v_20.y, v_20.z, 0.0f).xyz;
  let v_22 = pow(abs((v_1 * v_21)), vec3<f32>(0.45454546809196472168f));
  let v_23 = (v_22 + pow(abs((v_13 * v_21)), vec3<f32>(0.45454546809196472168f)));
  let v_24 = select(0.0f, 1.0f, (abs(v_16) < 0.00009999999747378752f));
  let v_25 = mix(v_22, v_23, vec3<f32>(v_24, v_24, v_24));
  let v_26 = mix(v.u_fog.xyz, v_25, vec3<f32>(v_19, v_19, v_19));
  bgfx_FragData0 = vec4<f32>(v_26.x, v_26.y, v_26.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_texcoord0, v_view);
  return bgfx_FragData0;
}
