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
    let v_5 = (bitcast<i32>(v_3.x) % 2i);
    let v_6 = (bitcast<i32>(v_3.y) % 2i);
    let v_7 = (v_6 * 2i);
    let v_8 = (1i - v_5);
    let v_9 = ((1i - v_6) * 2i);
    let v_10 = bitcast<vec2<i32>>((v_3 / vec2<u32>(2u)));
    let v_11 = vec4<i32>(v_10.x, v_10.y, (v_5 + v_7), 0i).xyz;
    let v_12 = textureLoad(s_finalSSAOTexture, v_11.xy, v_11.z, 0i);
    let v_13 = u32((v_12.y * 255.5f));
    let v_14 = vec4<f32>((f32(((v_13 >> bitcast<u32>(6i)) & 3u)) * 0.3333333432674407959f), (f32(((v_13 >> bitcast<u32>(4i)) & 3u)) * 0.3333333432674407959f), (f32(((v_13 >> bitcast<u32>(2i)) & 3u)) * 0.3333333432674407959f), (f32((v_13 & 3u)) * 0.3333333432674407959f));
    let v_15 = v.u_params[8i].x;
    let v_16 = clamp((v_14 + vec4<f32>(v_15, v_15, v_15, v_15)), vec4<f32>(), vec4<f32>(1.0f));
    let v_17 = f32(v_5);
    let v_18 = f32(v_6);
    let v_19 = v_16.y;
    let v_20 = v_16.x;
    let v_21 = (v_19 - v_20);
    let v_22 = v_16.w;
    let v_23 = v_16.z;
    let v_24 = v.u_params[0i].zw;
    let v_25 = (((v_4 + vec2<f32>(((v_17 + v_21) - 0.5f), (0.5f - v_18))) * 0.5f) * v_24);
    let v_26 = vec3<f32>(v_25.x, v_25.y, f32((v_8 + v_7)));
    let v_27 = textureSampleLevel(s_finalSSAOTexture, s_finalSSAOSampler, v_26.xy, i32(v_26.z), 0.0f).x;
    let v_28 = ((v_18 - 0.5f) + (v_22 - v_23));
    let v_29 = (((v_4 + vec2<f32>((0.5f - v_17), v_28)) * 0.5f) * v_24);
    let v_30 = vec3<f32>(v_29.x, v_29.y, f32((v_5 + v_9)));
    let v_31 = textureSampleLevel(s_finalSSAOTexture, s_finalSSAOSampler, v_30.xy, i32(v_30.z), 0.0f).x;
    let v_32 = (((v_4 + vec2<f32>(((v_17 - 0.5f) + v_21), v_28)) * 0.5f) * v_24);
    let v_33 = vec3<f32>(v_32.x, v_32.y, f32((v_8 + v_9)));
    let v_34 = textureSampleLevel(s_finalSSAOTexture, s_finalSSAOSampler, v_33.xy, i32(v_33.z), 0.0f).x;
    let v_35 = ((v_20 + v_19) * 0.5f);
    let v_36 = ((v_23 + v_22) * 0.5f);
    let v_37 = vec4<f32>(1.0f, v_35, v_36, ((v_35 + v_36) * 0.5f));
    let v_38 = dot(v_37, vec4<f32>(1.0f));
    let v_39 = pow((dot(vec4<f32>(v_12.x, v_27, v_31, v_34), v_37) / v_38), 0.45454546809196472168f);
    let v_40 = bitcast<vec2<i32>>(v_3);
    textureStore(s_target, v_40, vec4<f32>(v_39));
  }
}
