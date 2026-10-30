diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texLightmapSampler : sampler;

@group(0u) @binding(2u) var s_texLightmapTexture : texture_2d<f32>;

struct UniformBlock {
  u_sunDirection : vec4<f32>,
  u_sunLuminance : vec4<f32>,
  u_skyLuminance : vec4<f32>,
  u_parameters : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = normalize(v_normal);
  let v_2 = pow(abs(textureSample(s_texLightmapTexture, s_texLightmapSampler, v_texcoord0).x), 2.20000004768371582031f);
  let v_3 = max(0.0f, dot(v_1, normalize(v.u_sunDirection.xyz)));
  let v_4 = ((((v.u_sunLuminance.xyz * v_3) + (((v.u_skyLuminance.xyz * (1.0f + (0.5f * v_1.z))) + vec3<f32>(0.00999999977648258209f)) * v_2)) * 0.5f) * v.u_parameters.z);
  let v_5 = vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f);
  let v_6 = ((fract((52.98291778564453125f * fract(dot((gl_FragCoord.xy + (vec2<f32>(13.0f) * fract(v.u_parameters.w))), vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) - 0.5f) * 0.0039215688593685627f);
  let v_7 = (pow(abs(v_5.xyz), vec3<f32>(0.45454546809196472168f)) + vec3<f32>(v_6, v_6, v_6));
  var v_8 : vec4<f32> = v_5;
  v_8.x = v_7.x;
  var v_9 : vec4<f32> = v_8;
  v_9.y = v_7.y;
  var v_10 : vec4<f32> = v_9;
  v_10.z = v_7.z;
  bgfx_FragData0 = v_10;
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_texcoord0);
  return bgfx_FragData0;
}
