diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texNormalSampler : sampler;

@group(0u) @binding(3u) var s_texNormalTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_invView : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> bgfx_FragData1 : vec4<f32>;

fn main_inner(v_bitangent : vec3<f32>, v_normal : vec3<f32>, v_tangent : vec3<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = ((textureSample(s_texNormalTexture, s_texNormalSampler, v_texcoord0).xy * 2.0f) - vec2<f32>(1.0f));
  let v_2 = v_1.x;
  var v_3 : vec3<f32> = vec3<f32>();
  v_3.x = v_2;
  let v_4 = v_1.y;
  var v_5 : vec3<f32> = v_3;
  v_5.y = v_4;
  let v_6 = v_5.xy;
  let v_7 = normalize((vec3<f32>(v_2, v_4, sqrt((1.0f - dot(v_6, v_6)))) * mat3x3<f32>(normalize(v_tangent), normalize(v_bitangent), normalize(v_normal))));
  let v_8 = normalize(((vec4<f32>(v_7.x, v_7.y, v_7.z, 0.0f) * transpose(v.u_invView))).xyz);
  let v_9 = ((v_8 * 0.5f) + vec3<f32>(0.5f));
  bgfx_FragData0 = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0);
  bgfx_FragData1 = vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f);
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @location(1u)
  bgfx_FragData1 : vec4<f32>,
}

@fragment
fn main(@location(0u) v_bitangent : vec3<f32>, @location(1u) v_normal : vec3<f32>, @location(2u) v_tangent : vec3<f32>, @location(3u) v_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(v_bitangent, v_normal, v_tangent, v_texcoord0);
  return tint_symbol(bgfx_FragData0, bgfx_FragData1);
}
