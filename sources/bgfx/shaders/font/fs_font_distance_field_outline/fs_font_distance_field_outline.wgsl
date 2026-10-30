diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_color1 : vec4<f32>, v_texcoord0 : vec4<f32>) {
  var v_1 : array<f32, 4u>;
  let v_2 = v_texcoord0.xyz;
  let v_3 = textureSample(s_texColorTexture, s_texColorSampler, v_2);
  v_1[0i] = v_3.z;
  v_1[1i] = v_3.y;
  v_1[2i] = v_3.x;
  v_1[3i] = v_3.w;
  let v_4 = v_1[i32(((v_texcoord0.w * 4.0f) + 0.5f))];
  let v_5 = ((length(fwidth(v_2)) * 11.31370830535888671875f) * v.u_params.y);
  let v_6 = (0.5f - (v.u_params.w * v_5));
  let v_7 = smoothstep((v_6 - v_5), (v_6 + v_5), v_4);
  let v_8 = smoothstep((0.5f - v_5), (0.5f + v_5), v_4);
  let v_9 = mix(v_color1.xyz, v_color0.xyz, vec3<f32>(v_8, v_8, v_8));
  bgfx_FragData0 = vec4<f32>(v_9.x, v_9.y, v_9.z, (v_7 * v_color0.w));
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_color1 : vec4<f32>, @location(2u) v_texcoord0 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_color1, v_texcoord0);
  return bgfx_FragData0;
}
