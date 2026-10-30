diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var s_finalSSAOSampler : sampler;

@group(0u) @binding(3u) var s_finalSSAOTexture : texture_2d_array<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
  u_rect : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_target : texture_storage_2d<r8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(vec3<i32>(gl_GlobalInvocationID).xy);
  let v_2 = v.u_rect;
  let v_3 = (v_1 + vec2<u32>(v_2.xy));
  let v_4 = vec2<f32>(v_3);
  if (all((v_4 < v_2.zw))) {
    let v_5 = ((v_4 + vec2<f32>(0.5f)) * v.u_params[0i].xy);
    let v_6 = v_5.x;
    let v_7 = v_5.y;
    let v_8 = vec3<f32>(v_6, v_7, 0.0f);
    let v_9 = vec3<f32>(v_6, v_7, 3.0f);
    let v_10 = pow(((textureSampleLevel(s_finalSSAOTexture, s_finalSSAOSampler, v_8.xy, i32(v_8.z), 0.0f).x + textureSampleLevel(s_finalSSAOTexture, s_finalSSAOSampler, v_9.xy, i32(v_9.z), 0.0f).x) * 0.5f), 0.45454546809196472168f);
    let v_11 = bitcast<vec2<i32>>(v_3);
    textureStore(s_target, v_11, vec4<f32>(v_10));
  }
}
