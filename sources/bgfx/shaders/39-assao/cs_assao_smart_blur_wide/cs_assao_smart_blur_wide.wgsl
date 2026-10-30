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
    let v_5 = ((v_4 + vec2<f32>(0.5f)) * v.u_params[0i].zw);
    let v_6 = bitcast<vec2<i32>>(v_3);
    let v_7 = vec3<i32>(v_6.x, v_6.y, i32(v.u_params[14i].w));
    let v_8 = vec3<f32>(v_5.x, v_5.y, 0.0f);
    let v_9 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f);
    let v_10 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f, vec2<i32>(-2i, 0i));
    let v_11 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f, vec2<i32>(0i, -2i));
    let v_12 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f, vec2<i32>(2i, 0i));
    let v_13 = textureSampleLevel(s_blurInputTexture, s_blurInputSampler, v_8.xy, i32(v_8.z), 0.0f, vec2<i32>(0i, 2i));
    let v_14 = v_9.y;
    let v_15 = u32((v_14 * 255.5f));
    let v_16 = vec4<f32>((f32(((v_15 >> bitcast<u32>(6i)) & 3u)) * 0.3333333432674407959f), (f32(((v_15 >> bitcast<u32>(4i)) & 3u)) * 0.3333333432674407959f), (f32(((v_15 >> bitcast<u32>(2i)) & 3u)) * 0.3333333432674407959f), (f32((v_15 & 3u)) * 0.3333333432674407959f));
    let v_17 = v.u_params[8i].x;
    let v_18 = vec4<f32>(v_17, v_17, v_17, v_17);
    let v_19 = clamp((v_16 + v_18), vec4<f32>(), vec4<f32>(1.0f));
    let v_20 = (v_19.x * clamp((vec4<f32>(0.0f, (f32(((u32((v_10.y * 255.5f)) >> bitcast<u32>(4i)) & 3u)) * 0.3333333432674407959f), 0.0f, 0.0f) + v_18), vec4<f32>(), vec4<f32>(1.0f)).y);
    let v_21 = (v_19.z * clamp((vec4<f32>(0.0f, 0.0f, 0.0f, (f32((u32((v_11.y * 255.5f)) & 3u)) * 0.3333333432674407959f)) + v_18), vec4<f32>(), vec4<f32>(1.0f)).w);
    let v_22 = (v_19.y * clamp((vec4<f32>((f32(((u32((v_12.y * 255.5f)) >> bitcast<u32>(6i)) & 3u)) * 0.3333333432674407959f), 0.0f, 0.0f, 0.0f) + v_18), vec4<f32>(), vec4<f32>(1.0f)).x);
    let v_23 = (v_19.w * clamp((vec4<f32>(0.0f, 0.0f, (f32(((u32((v_13.y * 255.5f)) >> bitcast<u32>(2i)) & 3u)) * 0.3333333432674407959f), 0.0f) + v_18), vec4<f32>(), vec4<f32>(1.0f)).z);
    textureStore(s_target, v_7.xy, v_7.z, vec4<f32>(vec2<f32>(((((((v_9.x * 0.80000001192092895508f) + (v_20 * v_10.x)) + (v_22 * v_12.x)) + (v_21 * v_11.x)) + (v_23 * v_13.x)) / ((((0.80000001192092895508f + v_20) + v_22) + v_21) + v_23)), v_14).xy, vec2<f32>()));
  }
}
