diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var s_blurInputSampler : sampler;

@group(0u) @binding(3u) var s_blurInputTexture : texture_2d_array<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
  u_rect : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_target : texture_storage_2d_array<rg8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = bitcast<vec2<u32>>(vec3<i32>(gl_GlobalInvocationID).xy);
  let v_2 = v.u_rect;
  let v_3 = (v_1 + vec2<u32>(v_2.xy));
  let v_4 = vec2<f32>(v_3);
  if (all((v_4 < v_2.zw))) {
    let v_5 = v.u_params[0i].zw;
    let v_6 = ((v_4 + vec2<f32>(0.5f)) * v_5);
    let v_7 = (v_5 * 0.5f);
    let v_8 = vec3<f32>(v_6.x, v_6.y, 0.0f);
    let v_9 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f);
    let v_10 = v_7.x;
    let v_11 = v_7.y;
    let v_12 = (v_6 + vec2<f32>((v_10 * -3.0f), -(v_11)));
    let v_13 = vec3<f32>(v_12.x, v_12.y, 0.0f);
    let v_14 = (v_6 + vec2<f32>(v_10, (v_11 * -3.0f)));
    let v_15 = vec3<f32>(v_14.x, v_14.y, 0.0f);
    let v_16 = (v_6 + vec2<f32>(-(v_10), (v_11 * 3.0f)));
    let v_17 = vec3<f32>(v_16.x, v_16.y, 0.0f);
    let v_18 = (v_6 + vec2<f32>((v_10 * 3.0f), v_11));
    let v_19 = vec3<f32>(v_18.x, v_18.y, 0.0f);
    let v_20 = vec4<f32>(textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_13.xy, i32(v_13.z), 0.0f).x, textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_15.xy, i32(v_15.z), 0.0f).x, textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_17.xy, i32(v_17.z), 0.0f).x, textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_19.xy, i32(v_19.z), 0.0f).x);
    let v_21 = bitcast<vec2<i32>>(v_3);
    let v_22 = vec3<i32>(v_21.x, v_21.y, i32(v.u_params[14i].w));
    let v_23 = vec4<f32>((dot(v_20, vec4<f32>(0.20000000298023223877f)) + (v_9.x * 0.20000000298023223877f)), v_9.y, 0.0f, 0.0f);
    textureStore(s_target, v_22.xy, v_22.z, vec4<f32>(v_23.xy, vec2<f32>()));
  }
}
