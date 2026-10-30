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
    let v_7 = bitcast<vec2<i32>>(v_3);
    let v_8 = v_7.x;
    let v_9 = v_7.y;
    let v_10 = vec3<i32>(v_8, v_9, i32(v.u_params[14i].w));
    let v_11 = vec4<i32>(v_8, v_9, 0i, 0i).xyz;
    let v_12 = textureLoad(s_blurInputTexture, v_11.xy, v_11.z, 0i).y;
    let v_13 = u32((v_12 * 255.5f));
    let v_14 = vec4<f32>((f32(((v_13 >> bitcast<u32>(6i)) & 3u)) * 0.3333333432674407959f), (f32(((v_13 >> bitcast<u32>(4i)) & 3u)) * 0.3333333432674407959f), (f32(((v_13 >> bitcast<u32>(2i)) & 3u)) * 0.3333333432674407959f), (f32((v_13 & 3u)) * 0.3333333432674407959f));
    let v_15 = v.u_params[8i].x;
    let v_16 = clamp((v_14 + vec4<f32>(v_15, v_15, v_15, v_15)), vec4<f32>(), vec4<f32>(1.0f));
    let v_17 = (v_5 * 0.5f);
    let v_18 = (v_6 - v_17);
    let v_19 = vec3<f32>(v_18.x, v_18.y, 0.0f);
    let v_20 = textureGather(0i, s_blurInputTexture, s_blurInputSampler, v_19.xy, i32(v_19.z));
    let v_21 = (v_6 + v_17);
    let v_22 = vec3<f32>(v_21.x, v_21.y, 0.0f);
    let v_23 = textureGather(0i, s_blurInputTexture, s_blurInputSampler, v_22.xy, i32(v_22.z));
    let v_24 = v_16.x;
    let v_25 = v_16.y;
    let v_26 = v_16.z;
    let v_27 = v_16.w;
    textureStore(s_target, v_10.xy, v_10.z, vec4<f32>(vec2<f32>(((((((v_20.y * 0.5f) + (v_24 * v_20.x)) + (v_25 * v_23.z)) + (v_26 * v_20.z)) + (v_27 * v_23.x)) / ((((0.5f + v_24) + v_25) + v_26) + v_27)), v_12).xy, vec2<f32>()));
  }
}
