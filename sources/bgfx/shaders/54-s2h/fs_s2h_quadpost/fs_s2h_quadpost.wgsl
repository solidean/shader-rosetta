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

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_quadPostColorTexture, s_quadPostColorSampler, v_texcoord0).xyz;
  let v_2 = (1.0f - smoothstep(0.01999999955296516418f, 0.02500000037252902985f, length((v_texcoord0 - (v.u_s2hMouse.xy / v.u_viewRect.zw)))));
  let v_3 = mix(v_1, vec3<f32>(1.0f, 1.0f, 0.0f), vec3<f32>(v_2, v_2, v_2));
  bgfx_FragData0 = vec4<f32>(v_3.x, v_3.y, v_3.z, 1.0f);
}

@fragment
fn main(@location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
