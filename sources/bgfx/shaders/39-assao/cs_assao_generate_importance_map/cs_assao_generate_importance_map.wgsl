diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var s_finalSSAOSampler : sampler;

@group(0u) @binding(3u) var s_finalSSAOTexture : texture_2d_array<f32>;

@group(0u) @binding(2u) var s_target : texture_storage_2d<r8unorm, write>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = bitcast<vec2<u32>>(v_1);
  if (all((vec2<f32>(v_2) < vec2<f32>(textureDimensions(s_target))))) {
    let v_3 = ((vec2<f32>((v_2 * vec2<u32>(2u))) + vec2<f32>(1.0f)) * v.u_params[0i].zw);
    let v_4 = v_3.x;
    let v_5 = v_3.y;
    let v_6 = vec3<f32>(v_4, v_5, 0.0f);
    let v_7 = textureGather(0i, s_finalSSAOTexture, s_finalSSAOSampler, v_6.xy, i32(v_6.z));
    let v_8 = v.u_params[5i].y;
    let v_9 = clamp((vec4<f32>(1.0f) - (v_7 * v_8)), vec4<f32>(), vec4<f32>(1.0f));
    let v_10 = v.u_params[5i].z;
    let v_11 = vec4<f32>(v_10, v_10, v_10, v_10);
    let v_12 = pow(v_9, v_11);
    let v_13 = v_12.x;
    let v_14 = v_12.y;
    let v_15 = v_12.z;
    let v_16 = v_12.w;
    let v_17 = max(0.0f, max(max(v_13, v_14), max(v_15, v_16)));
    let v_18 = min(1.0f, min(min(v_13, v_14), min(v_15, v_16)));
    let v_19 = vec3<f32>(v_4, v_5, 1.0f);
    let v_20 = pow(clamp((vec4<f32>(1.0f) - (textureGather(0i, s_finalSSAOTexture, s_finalSSAOSampler, v_19.xy, i32(v_19.z)) * v_8)), vec4<f32>(), vec4<f32>(1.0f)), v_11);
    let v_21 = v_20.x;
    let v_22 = v_20.y;
    let v_23 = v_20.z;
    let v_24 = v_20.w;
    let v_25 = max(v_17, max(max(v_21, v_22), max(v_23, v_24)));
    let v_26 = min(v_18, min(min(v_21, v_22), min(v_23, v_24)));
    let v_27 = vec3<f32>(v_4, v_5, 2.0f);
    let v_28 = pow(clamp((vec4<f32>(1.0f) - (textureGather(0i, s_finalSSAOTexture, s_finalSSAOSampler, v_27.xy, i32(v_27.z)) * v_8)), vec4<f32>(), vec4<f32>(1.0f)), v_11);
    let v_29 = v_28.x;
    let v_30 = v_28.y;
    let v_31 = v_28.z;
    let v_32 = v_28.w;
    let v_33 = max(v_25, max(max(v_29, v_30), max(v_31, v_32)));
    let v_34 = min(v_26, min(min(v_29, v_30), min(v_31, v_32)));
    let v_35 = vec3<f32>(v_4, v_5, 3.0f);
    let v_36 = pow(clamp((vec4<f32>(1.0f) - (textureGather(0i, s_finalSSAOTexture, s_finalSSAOSampler, v_35.xy, i32(v_35.z)) * v_8)), vec4<f32>(), vec4<f32>(1.0f)), v_11);
    let v_37 = v_36.x;
    let v_38 = v_36.y;
    let v_39 = v_36.z;
    let v_40 = v_36.w;
    let v_41 = pow(clamp(((max(v_33, max(max(v_37, v_38), max(v_39, v_40))) - min(v_34, min(min(v_37, v_38), min(v_39, v_40)))) * 2.0f), 0.0f, 1.0f), 0.80000001192092895508f);
    textureStore(s_target, v_1, vec4<f32>(v_41));
  }
}
