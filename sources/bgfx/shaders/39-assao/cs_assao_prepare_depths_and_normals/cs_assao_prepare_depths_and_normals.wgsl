diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_depthSourceSampler : sampler;

@group(0u) @binding(2u) var s_depthSourceTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(3u) var s_target0 : texture_storage_2d<r16float, write>;

@group(0u) @binding(4u) var s_target1 : texture_storage_2d<r16float, write>;

@group(0u) @binding(5u) var s_target2 : texture_storage_2d<r16float, write>;

@group(0u) @binding(6u) var s_target3 : texture_storage_2d<r16float, write>;

@group(0u) @binding(7u) var s_normalsOutputUAV : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = bitcast<vec2<u32>>(v_1);
  let v_3 = vec2<f32>(v_2);
  if (all((v_3 < vec2<f32>(textureDimensions(s_target0))))) {
    let v_4 = (v_1 * vec2<i32>(2i));
    let v_5 = ((v_3 + vec2<f32>(0.25f)) * v.u_params[4i].xy);
    let v_6 = vec3<i32>(v_4.x, v_4.y, 0i).xy;
    let v_7 = textureLoad(s_depthSourceTexture, v_6, 0i).x;
    let v_8 = v.u_params[1i].x;
    let v_9 = v.u_params[1i].y;
    let v_10 = (v_8 / (v_9 - v_7));
    let v_11 = (v_8 / (v_9 - textureLoad(s_depthSourceTexture, v_6, 0i).x));
    let v_12 = (v_8 / (v_9 - textureLoad(s_depthSourceTexture, v_6, 0i).x));
    let v_13 = (v_8 / (v_9 - textureLoad(s_depthSourceTexture, v_6, 0i).x));
    textureStore(s_target0, v_1, vec4<f32>(v_10));
    textureStore(s_target1, v_1, vec4<f32>(v_11));
    textureStore(s_target2, v_1, vec4<f32>(v_12));
    textureStore(s_target3, v_1, vec4<f32>(v_13));
    let v_14 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(-1i, 0i)).x));
    let v_15 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(-1i, 1i)).x));
    let v_16 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(2i, 0i)).x));
    let v_17 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(2i, 1i)).x));
    let v_18 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(0i, -1i)).x));
    let v_19 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(1i, -1i)).x));
    let v_20 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(0i, 2i)).x));
    let v_21 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(1i, 2i)).x));
    let v_22 = (vec4<f32>(v_14, v_11, v_18, v_12) - vec4<f32>(v_10, v_10, v_10, v_10));
    let v_23 = (v_10 * 0.03999999910593032837f);
    let v_24 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_22), abs((v_22 + v_22.yxwz))) / vec4<f32>(v_23, v_23, v_23, v_23))), vec4<f32>(), vec4<f32>(1.0f));
    let v_25 = (vec4<f32>(v_10, v_16, v_19, v_13) - vec4<f32>(v_11, v_11, v_11, v_11));
    let v_26 = (v_11 * 0.03999999910593032837f);
    let v_27 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_25), abs((v_25 + v_25.yxwz))) / vec4<f32>(v_26, v_26, v_26, v_26))), vec4<f32>(), vec4<f32>(1.0f));
    let v_28 = (vec4<f32>(v_15, v_13, v_10, v_20) - vec4<f32>(v_12, v_12, v_12, v_12));
    let v_29 = (v_12 * 0.03999999910593032837f);
    let v_30 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_28), abs((v_28 + v_28.yxwz))) / vec4<f32>(v_29, v_29, v_29, v_29))), vec4<f32>(), vec4<f32>(1.0f));
    let v_31 = (vec4<f32>(v_12, v_17, v_11, v_21) - vec4<f32>(v_13, v_13, v_13, v_13));
    let v_32 = (v_13 * 0.03999999910593032837f);
    let v_33 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_31), abs((v_31 + v_31.yxwz))) / vec4<f32>(v_32, v_32, v_32, v_32))), vec4<f32>(), vec4<f32>(1.0f));
    let v_34 = v.u_params[0i].xy;
    let v_35 = v.u_params[2i];
    let v_36 = v_35.xy;
    let v_37 = v_35.zw;
    let v_38 = (((v_36 * v_5) + v_37) * v_10);
    let v_39 = vec3<f32>(v_38.x, v_38.y, v_10);
    let v_40 = (((v_36 * (v_5 + (v_34 * vec2<f32>(1.0f, 0.0f)))) + v_37) * v_11);
    let v_41 = vec3<f32>(v_40.x, v_40.y, v_11);
    let v_42 = (((v_36 * (v_5 + (v_34 * vec2<f32>(0.0f, 1.0f)))) + v_37) * v_12);
    let v_43 = vec3<f32>(v_42.x, v_42.y, v_12);
    let v_44 = (((v_36 * (v_5 + v_34)) + v_37) * v_13);
    let v_45 = vec3<f32>(v_44.x, v_44.y, v_13);
    let v_46 = (((v_36 * (v_5 + (v_34 * vec2<f32>(-1.0f, 0.0f)))) + v_37) * v_14);
    let v_47 = (((v_36 * (v_5 + (v_34 * vec2<f32>(-1.0f, 1.0f)))) + v_37) * v_15);
    let v_48 = (((v_36 * (v_5 + (v_34 * vec2<f32>(2.0f, 0.0f)))) + v_37) * v_16);
    let v_49 = (((v_36 * (v_5 + (v_34 * vec2<f32>(2.0f, 1.0f)))) + v_37) * v_17);
    let v_50 = (((v_36 * (v_5 + (v_34 * vec2<f32>(0.0f, -1.0f)))) + v_37) * v_18);
    let v_51 = (((v_36 * (v_5 + (v_34 * vec2<f32>(1.0f, -1.0f)))) + v_37) * v_19);
    let v_52 = (((v_36 * (v_5 + (v_34 * vec2<f32>(0.0f, 2.0f)))) + v_37) * v_20);
    let v_53 = (((v_36 * (v_5 + (v_34 * vec2<f32>(1.0f, 2.0f)))) + v_37) * v_21);
    let v_54 = v_24.x;
    let v_55 = v_24.z;
    let v_56 = v_24.y;
    let v_57 = v_24.w;
    let v_58 = normalize((vec3<f32>(v_46.x, v_46.y, v_14) - v_39));
    let v_59 = normalize((v_41 - v_39));
    let v_60 = normalize((vec3<f32>(v_50.x, v_50.y, v_18) - v_39));
    let v_61 = normalize((v_43 - v_39));
    let v_62 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_58, v_60) * (v_54 * v_55))) + (cross(v_60, v_59) * (v_55 * v_56))) + (cross(v_59, v_61) * (v_56 * v_57))) + (cross(v_61, v_58) * (v_57 * v_54))));
    let v_63 = v_27.x;
    let v_64 = v_27.z;
    let v_65 = v_27.y;
    let v_66 = v_27.w;
    let v_67 = normalize((v_39 - v_41));
    let v_68 = normalize((vec3<f32>(v_48.x, v_48.y, v_16) - v_41));
    let v_69 = normalize((vec3<f32>(v_51.x, v_51.y, v_19) - v_41));
    let v_70 = normalize((v_45 - v_41));
    let v_71 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_67, v_69) * (v_63 * v_64))) + (cross(v_69, v_68) * (v_64 * v_65))) + (cross(v_68, v_70) * (v_65 * v_66))) + (cross(v_70, v_67) * (v_66 * v_63))));
    let v_72 = v_30.x;
    let v_73 = v_30.z;
    let v_74 = v_30.y;
    let v_75 = v_30.w;
    let v_76 = normalize((vec3<f32>(v_47.x, v_47.y, v_15) - v_43));
    let v_77 = normalize((v_45 - v_43));
    let v_78 = normalize((v_39 - v_43));
    let v_79 = normalize((vec3<f32>(v_52.x, v_52.y, v_20) - v_43));
    let v_80 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_76, v_78) * (v_72 * v_73))) + (cross(v_78, v_77) * (v_73 * v_74))) + (cross(v_77, v_79) * (v_74 * v_75))) + (cross(v_79, v_76) * (v_75 * v_72))));
    let v_81 = v_33.x;
    let v_82 = v_33.z;
    let v_83 = v_33.y;
    let v_84 = v_33.w;
    let v_85 = normalize((v_43 - v_45));
    let v_86 = normalize((vec3<f32>(v_49.x, v_49.y, v_17) - v_45));
    let v_87 = normalize((v_41 - v_45));
    let v_88 = normalize((vec3<f32>(v_53.x, v_53.y, v_21) - v_45));
    let v_89 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_85, v_87) * (v_81 * v_82))) + (cross(v_87, v_86) * (v_82 * v_83))) + (cross(v_86, v_88) * (v_83 * v_84))) + (cross(v_88, v_85) * (v_84 * v_81))));
    let v_90 = ((v_62 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, v_4, vec4<f32>(v_90.x, v_90.y, v_90.z, 0.0f));
    let v_91 = ((v_71 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, (v_4 + vec2<i32>(1i, 0i)), vec4<f32>(v_91.x, v_91.y, v_91.z, 0.0f));
    let v_92 = ((v_80 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, (v_4 + vec2<i32>(0i, 1i)), vec4<f32>(v_92.x, v_92.y, v_92.z, 0.0f));
    let v_93 = ((v_89 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, (v_4 + vec2<i32>(1i)), vec4<f32>(v_93.x, v_93.y, v_93.z, 0.0f));
  }
}
