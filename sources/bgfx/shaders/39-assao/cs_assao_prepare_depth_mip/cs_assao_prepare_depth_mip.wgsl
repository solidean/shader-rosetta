diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
  u_rect : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_viewspaceDepthSource0 : texture_2d<f32>;

@group(0u) @binding(3u) var s_viewspaceDepthSource1 : texture_2d<f32>;

@group(0u) @binding(4u) var s_viewspaceDepthSource2 : texture_2d<f32>;

@group(0u) @binding(5u) var s_viewspaceDepthSource3 : texture_2d<f32>;

@group(0u) @binding(6u) var s_target0 : texture_storage_2d<r16float, write>;

@group(0u) @binding(7u) var s_target1 : texture_storage_2d<r16float, write>;

@group(0u) @binding(8u) var s_target2 : texture_storage_2d<r16float, write>;

@group(0u) @binding(9u) var s_target3 : texture_storage_2d<r16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = bitcast<vec2<u32>>(v_1);
  if (all((vec2<f32>(v_2) < vec2<f32>(vec2<u32>(v.u_rect.zw))))) {
    let v_3 = (v_1 * vec2<i32>(2i));
    let v_4 = textureLoad(s_viewspaceDepthSource0, v_3, 0i).x;
    let v_5 = (v_3 + vec2<i32>(1i, 0i));
    let v_6 = textureLoad(s_viewspaceDepthSource0, v_5, 0i).x;
    let v_7 = (v_3 + vec2<i32>(0i, 1i));
    let v_8 = textureLoad(s_viewspaceDepthSource0, v_7, 0i).x;
    let v_9 = (v_3 + vec2<i32>(1i));
    let v_10 = textureLoad(s_viewspaceDepthSource0, v_9, 0i).x;
    let v_11 = vec4<f32>(v_4, v_6, v_8, v_10);
    let v_12 = textureLoad(s_viewspaceDepthSource1, v_3, 0i).x;
    let v_13 = textureLoad(s_viewspaceDepthSource1, v_5, 0i).x;
    let v_14 = textureLoad(s_viewspaceDepthSource1, v_7, 0i).x;
    let v_15 = textureLoad(s_viewspaceDepthSource1, v_9, 0i).x;
    let v_16 = vec4<f32>(v_12, v_13, v_14, v_15);
    let v_17 = textureLoad(s_viewspaceDepthSource2, v_3, 0i).x;
    let v_18 = textureLoad(s_viewspaceDepthSource2, v_5, 0i).x;
    let v_19 = textureLoad(s_viewspaceDepthSource2, v_7, 0i).x;
    let v_20 = textureLoad(s_viewspaceDepthSource2, v_9, 0i).x;
    let v_21 = vec4<f32>(v_17, v_18, v_19, v_20);
    let v_22 = textureLoad(s_viewspaceDepthSource3, v_3, 0i).x;
    let v_23 = textureLoad(s_viewspaceDepthSource3, v_5, 0i).x;
    let v_24 = textureLoad(s_viewspaceDepthSource3, v_7, 0i).x;
    let v_25 = textureLoad(s_viewspaceDepthSource3, v_9, 0i).x;
    let v_26 = vec4<f32>(v_22, v_23, v_24, v_25);
    let v_27 = min(min(v_4, v_6), min(v_8, v_10));
    let v_28 = abs(v_27);
    let v_29 = v.u_params[5i].x;
    let v_30 = v.u_params[6i].w;
    let v_31 = (v_29 * ((clamp((v_28 * v_30), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_32 = (v_11 - vec4<f32>(v_27, v_27, v_27, v_27));
    let v_33 = clamp((((v_32 * v_32) * (-1.0f / (v_31 * v_31))) + vec4<f32>(1.0f)), vec4<f32>(), vec4<f32>(1.0f));
    let v_34 = (dot(v_33, v_11) / dot(v_33, vec4<f32>(1.0f)));
    let v_35 = min(min(v_12, v_13), min(v_14, v_15));
    let v_36 = (v_29 * ((clamp((abs(v_35) * v_30), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_37 = (v_16 - vec4<f32>(v_35, v_35, v_35, v_35));
    let v_38 = clamp((((v_37 * v_37) * (-1.0f / (v_36 * v_36))) + vec4<f32>(1.0f)), vec4<f32>(), vec4<f32>(1.0f));
    let v_39 = (dot(v_38, v_16) / dot(v_38, vec4<f32>(1.0f)));
    let v_40 = min(min(v_17, v_18), min(v_19, v_20));
    let v_41 = (v_29 * ((clamp((abs(v_40) * v_30), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_42 = (v_21 - vec4<f32>(v_40, v_40, v_40, v_40));
    let v_43 = clamp((((v_42 * v_42) * (-1.0f / (v_41 * v_41))) + vec4<f32>(1.0f)), vec4<f32>(), vec4<f32>(1.0f));
    let v_44 = (dot(v_43, v_21) / dot(v_43, vec4<f32>(1.0f)));
    let v_45 = min(min(v_22, v_23), min(v_24, v_25));
    let v_46 = (v_29 * ((clamp((abs(v_45) * v_30), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_47 = (v_26 - vec4<f32>(v_45, v_45, v_45, v_45));
    let v_48 = clamp((((v_47 * v_47) * (-1.0f / (v_46 * v_46))) + vec4<f32>(1.0f)), vec4<f32>(), vec4<f32>(1.0f));
    let v_49 = (dot(v_48, v_26) / dot(v_48, vec4<f32>(1.0f)));
    textureStore(s_target0, v_1, vec4<f32>(v_34));
    textureStore(s_target1, v_1, vec4<f32>(v_39));
    textureStore(s_target2, v_1, vec4<f32>(v_44));
    textureStore(s_target3, v_1, vec4<f32>(v_49));
  }
}
