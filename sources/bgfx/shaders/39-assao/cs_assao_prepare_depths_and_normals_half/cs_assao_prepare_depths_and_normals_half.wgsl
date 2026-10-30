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
    textureStore(s_target1, v_1, vec4<f32>(v_13));
    let v_14 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(-1i, 0i)).x));
    let v_15 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(2i, 1i)).x));
    let v_16 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(0i, -1i)).x));
    let v_17 = (v_8 / (v_9 - textureSampleLevel(s_depthSourceTexture, s_depthSourceSampler, v_5, 0.0f, vec2<i32>(1i, 2i)).x));
    let v_18 = (vec4<f32>(v_14, v_11, v_16, v_12) - vec4<f32>(v_10, v_10, v_10, v_10));
    let v_19 = (v_10 * 0.03999999910593032837f);
    let v_20 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_18), abs((v_18 + v_18.yxwz))) / vec4<f32>(v_19, v_19, v_19, v_19))), vec4<f32>(), vec4<f32>(1.0f));
    let v_21 = (vec4<f32>(v_12, v_15, v_11, v_17) - vec4<f32>(v_13, v_13, v_13, v_13));
    let v_22 = (v_13 * 0.03999999910593032837f);
    let v_23 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_21), abs((v_21 + v_21.yxwz))) / vec4<f32>(v_22, v_22, v_22, v_22))), vec4<f32>(), vec4<f32>(1.0f));
    let v_24 = v.u_params[0i].xy;
    let v_25 = v.u_params[2i];
    let v_26 = v_25.xy;
    let v_27 = v_25.zw;
    let v_28 = (((v_26 * v_5) + v_27) * v_10);
    let v_29 = vec3<f32>(v_28.x, v_28.y, v_10);
    let v_30 = (((v_26 * (v_5 + (v_24 * vec2<f32>(1.0f, 0.0f)))) + v_27) * v_11);
    let v_31 = vec3<f32>(v_30.x, v_30.y, v_11);
    let v_32 = (((v_26 * (v_5 + (v_24 * vec2<f32>(0.0f, 1.0f)))) + v_27) * v_12);
    let v_33 = vec3<f32>(v_32.x, v_32.y, v_12);
    let v_34 = (((v_26 * (v_5 + v_24)) + v_27) * v_13);
    let v_35 = vec3<f32>(v_34.x, v_34.y, v_13);
    let v_36 = (((v_26 * (v_5 + (v_24 * vec2<f32>(-1.0f, 0.0f)))) + v_27) * v_14);
    let v_37 = (((v_26 * (v_5 + (v_24 * vec2<f32>(2.0f, 1.0f)))) + v_27) * v_15);
    let v_38 = (((v_26 * (v_5 + (v_24 * vec2<f32>(0.0f, -1.0f)))) + v_27) * v_16);
    let v_39 = (((v_26 * (v_5 + (v_24 * vec2<f32>(1.0f, 2.0f)))) + v_27) * v_17);
    let v_40 = v_20.x;
    let v_41 = v_20.z;
    let v_42 = v_20.y;
    let v_43 = v_20.w;
    let v_44 = normalize((vec3<f32>(v_36.x, v_36.y, v_14) - v_29));
    let v_45 = normalize((v_31 - v_29));
    let v_46 = normalize((vec3<f32>(v_38.x, v_38.y, v_16) - v_29));
    let v_47 = normalize((v_33 - v_29));
    let v_48 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_44, v_46) * (v_40 * v_41))) + (cross(v_46, v_45) * (v_41 * v_42))) + (cross(v_45, v_47) * (v_42 * v_43))) + (cross(v_47, v_44) * (v_43 * v_40))));
    let v_49 = v_23.x;
    let v_50 = v_23.z;
    let v_51 = v_23.y;
    let v_52 = v_23.w;
    let v_53 = normalize((v_33 - v_35));
    let v_54 = normalize((vec3<f32>(v_37.x, v_37.y, v_15) - v_35));
    let v_55 = normalize((v_31 - v_35));
    let v_56 = normalize((vec3<f32>(v_39.x, v_39.y, v_17) - v_35));
    let v_57 = normalize(((((vec3<f32>(0.0f, 0.0f, -0.00050000002374872565f) + (cross(v_53, v_55) * (v_49 * v_50))) + (cross(v_55, v_54) * (v_50 * v_51))) + (cross(v_54, v_56) * (v_51 * v_52))) + (cross(v_56, v_53) * (v_52 * v_49))));
    let v_58 = ((v_48 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, v_4, vec4<f32>(v_58.x, v_58.y, v_58.z, 0.0f));
    let v_59 = ((v_57 * 0.5f) + vec3<f32>(0.5f));
    textureStore(s_normalsOutputUAV, (v_4 + vec2<i32>(1i)), vec4<f32>(v_59.x, v_59.y, v_59.z, 0.0f));
  }
}
