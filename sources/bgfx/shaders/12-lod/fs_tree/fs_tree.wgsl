diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texStippleSampler : sampler;

@group(0u) @binding(3u) var s_texStippleTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
  u_stipple : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_pos : vec3<f32>, v_texcoord0 : vec2<f32>, v_view : vec3<f32>) {
  let v_1 = v.u_viewRect;
  let v_2 = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord0);
  let v_3 = v_2.w;
  if (((((v.u_stipple.x - textureSample(s_texStippleTexture, s_texStippleSampler, (((v_1.zw - v_1.xy) * vec2<f32>(0.125f, 0.25f)) * ((v_pos.xy * 0.5f) + vec2<f32>(0.5f)))).x) * v.u_stipple.y) > v.u_stipple.z) | (v_3 < 0.5f))) {
    discard;
    return;
  }
  let v_4 = normalize(v_normal);
  let v_5 = normalize(v_view);
  let v_6 = (clamp(dot((vec3<f32>(0.0f, 0.0f, -1.0f) - (v_4 * (2.0f * dot(v_4, vec3<f32>(0.0f, 0.0f, -1.0f))))), v_5), 0.0f, 1.0f) + 0.11999999731779098511f);
  let v_7 = (pow(abs(v_2.xyz), vec3<f32>(2.20000004768371582031f)) * v_6);
  var v_8 : vec4<f32> = vec4<f32>();
  v_8.x = v_7.x;
  var v_9 : vec4<f32> = v_8;
  v_9.y = v_7.y;
  var v_10 : vec4<f32> = v_9;
  v_10.z = v_7.z;
  let v_11 = pow(abs(v_10.xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_11.x, v_11.y, v_11.z, v_3);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_pos : vec3<f32>, @location(2u) v_texcoord0 : vec2<f32>, @location(3u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_pos, v_texcoord0, v_view);
  return bgfx_FragData0;
}
