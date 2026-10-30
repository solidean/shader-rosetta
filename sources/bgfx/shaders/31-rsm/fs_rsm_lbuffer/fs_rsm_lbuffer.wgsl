diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_normalSampler : sampler;

@group(0u) @binding(2u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_viewTexel : vec4<f32>,
  u_invMvp : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_color0 : vec4<f32>, v_lightCenterScale : vec4<f32>) {
  let v_1 = (gl_FragCoord.xy * v.u_viewTexel.xy);
  let v_2 = textureSample(s_depthTexture, s_depthSampler, v_1).x;
  let v_3 = ((v_1 * 2.0f) - vec2<f32>(1.0f));
  let v_4 = (vec4<f32>(v_3.x, -(v_3.y), v_2, 1.0f) * transpose(v.u_invMvp));
  let v_5 = v_4.w;
  let v_6 = ((textureSample(s_normalTexture, s_normalSampler, v_1).xyz * 2.0f) - vec3<f32>(1.0f));
  let v_7 = (v_lightCenterScale.xyz - (v_4.xyz / vec3<f32>(v_5, v_5, v_5)));
  let v_8 = sqrt(dot(v_7, v_7));
  let v_9 = v_lightCenterScale.w;
  var v_10 : f32;
  if ((v_8 > v_9)) {
    v_10 = 0.0f;
  } else {
    v_10 = (1.0f - (v_8 / v_9));
  }
  let v_11 = v_10;
  let v_12 = (v_color0.xyz * max(0.0f, dot(v_6, (normalize(v_7) * v_11))));
  bgfx_FragData0 = vec4<f32>(v_12.x, v_12.y, v_12.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_color0 : vec4<f32>, @location(1u) v_lightCenterScale : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_color0, v_lightCenterScale);
  return bgfx_FragData0;
}
