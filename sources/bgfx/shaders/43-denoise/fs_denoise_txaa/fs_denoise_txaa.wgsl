diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_previousColorSampler : sampler;

@group(0u) @binding(3u) var s_previousColorTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_velocitySampler : sampler;

@group(0u) @binding(4u) var s_velocityTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_depthSampler : sampler;

@group(0u) @binding(5u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewTexel : vec4<f32>,
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0).xyz;
  let v_2 = vec2<f32>(v.u_viewTexel.x, 0.0f);
  let v_3 = vec2<f32>(0.0f, v.u_viewTexel.y);
  let v_4 = (v_texcoord0 - v_2);
  let v_5 = (v_4 - v_3);
  let v_6 = textureSample(s_depthTexture, s_depthSampler, v_5).x;
  let v_7 = (v_texcoord0 - v_3);
  let v_8 = textureSample(s_depthTexture, s_depthSampler, v_7).x;
  let v_9 = (v_texcoord0 + v_2);
  let v_10 = (v_9 - v_3);
  let v_11 = textureSample(s_depthTexture, s_depthSampler, v_10).x;
  let v_12 = textureSample(s_depthTexture, s_depthSampler, v_9).x;
  let v_13 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_14 = textureSample(s_depthTexture, s_depthSampler, v_4).x;
  let v_15 = (v_4 + v_3);
  let v_16 = textureSample(s_depthTexture, s_depthSampler, v_15).x;
  let v_17 = (v_texcoord0 + v_3);
  let v_18 = textureSample(s_depthTexture, s_depthSampler, v_17).x;
  let v_19 = (v_9 + v_3);
  let v_20 = textureSample(s_depthTexture, s_depthSampler, v_19).x;
  let v_21 = (v_8 < v_6);
  let v_22 = select(vec3<f32>(v_5.x, v_5.y, v_6), vec3<f32>(v_7.x, v_7.y, v_8), vec3<bool>(v_21, v_21, v_21));
  let v_23 = (v_11 < v_22.z);
  let v_24 = select(v_22, vec3<f32>(v_10.x, v_10.y, v_11), vec3<bool>(v_23, v_23, v_23));
  let v_25 = (v_12 < v_24.z);
  let v_26 = select(v_24, vec3<f32>(v_9.x, v_9.y, v_12), vec3<bool>(v_25, v_25, v_25));
  let v_27 = (v_13 < v_26.z);
  let v_28 = select(v_26, vec3<f32>(v_texcoord0.x, v_texcoord0.y, v_13), vec3<bool>(v_27, v_27, v_27));
  let v_29 = (v_14 < v_28.z);
  let v_30 = select(v_28, vec3<f32>(v_4.x, v_4.y, v_14), vec3<bool>(v_29, v_29, v_29));
  let v_31 = (v_16 < v_30.z);
  let v_32 = select(v_30, vec3<f32>(v_15.x, v_15.y, v_16), vec3<bool>(v_31, v_31, v_31));
  let v_33 = (v_18 < v_32.z);
  let v_34 = select(v_32, vec3<f32>(v_17.x, v_17.y, v_18), vec3<bool>(v_33, v_33, v_33));
  let v_35 = (v_20 < v_34.z);
  let v_36 = (v_texcoord0 - textureSample(s_velocityTexture, s_velocitySampler, select(v_34, vec3<f32>(v_19.x, v_19.y, v_20), vec3<bool>(v_35, v_35, v_35)).xy).xy);
  let v_37 = v.u_params[0i];
  let v_38 = textureSample(s_previousColorTexture, s_previousColorSampler, (v_36 + ((v_37.xy - v_37.zw) * v.u_viewTexel.xy))).xyz;
  let v_39 = textureSample(s_colorTexture, s_colorSampler, v_5).xyz;
  let v_40 = textureSample(s_colorTexture, s_colorSampler, v_7).xyz;
  let v_41 = textureSample(s_colorTexture, s_colorSampler, v_10).xyz;
  let v_42 = textureSample(s_colorTexture, s_colorSampler, v_9).xyz;
  let v_43 = textureSample(s_colorTexture, s_colorSampler, v_4).xyz;
  let v_44 = textureSample(s_colorTexture, s_colorSampler, v_15).xyz;
  let v_45 = textureSample(s_colorTexture, s_colorSampler, v_17).xyz;
  let v_46 = textureSample(s_colorTexture, s_colorSampler, v_19).xyz;
  let v_47 = (((((((((v_39 + v_40) + v_41) + v_43) + v_1) + v_42) + v_44) + v_45) + v_46) * 0.11111111193895339966f);
  let v_48 = (v_38 - v_47);
  let v_49 = abs((v_48 / (sqrt(max(vec3<f32>(), (((((((((((v_39 * v_39) + (v_40 * v_40)) + (v_41 * v_41)) + (v_43 * v_43)) + (v_1 * v_1)) + (v_42 * v_42)) + (v_44 * v_44)) + (v_45 * v_45)) + (v_46 * v_46)) * 0.11111111193895339966f) - (v_47 * v_47)))) * 1.39999997615814208984f)));
  let v_50 = (v_47 + (v_48 * (1.0f / max(max(v_49.x, v_49.y), max(v_49.z, 1.0f)))));
  let v_51 = dot(v_1, vec3<f32>(0.30000001192092895508f, 0.60000002384185791016f, 0.10000000149011611938f));
  let v_52 = dot(v_50, vec3<f32>(0.30000001192092895508f, 0.60000002384185791016f, 0.10000000149011611938f));
  let v_53 = (1.0f - (abs((v_51 - v_52)) / max(max(v_51, v_52), 0.20000000298023223877f)));
  let v_54 = (v_53 * v_53);
  let v_55 = mix(v.u_params[1i].x, v.u_params[1i].y, v_54);
  let v_56 = vec3<f32>(v_55, v_55, v_55);
  let v_57 = mix(v_1, v_50, v_56);
  var v_58 : vec3<f32>;
  if ((v.u_params[2i].y > 0.0f)) {
    let v_59 = mix(1.5f, 0.3333333432674407959f, v_54);
    let v_60 = mix(-0.25f, 0.3333333432674407959f, v_54);
    let v_61 = abs(0.0f);
    let v_62 = (v_61 * v_61);
    let v_63 = (v_62 * v_61);
    var v_64 : f32;
    if ((v_61 < 1.0f)) {
      let v_65 = (6.0f * v_60);
      v_64 = (((((12.0f - (9.0f * v_59)) - v_65) * v_63) + (((-18.0f + (12.0f * v_59)) + v_65) * v_62)) + (6.0f - (2.0f * v_59)));
    } else {
      var v_66 : f32;
      if ((v_61 < 2.0f)) {
        v_66 = (((((-(v_59) - (6.0f * v_60)) * v_63) + (((6.0f * v_59) + (30.0f * v_60)) * v_62)) + (((-12.0f * v_59) - (48.0f * v_60)) * v_61)) + ((8.0f * v_59) + (24.0f * v_60)));
      } else {
        v_66 = 0.0f;
      }
      v_64 = v_66;
    }
    let v_67 = (v_64 * 0.16666667163372039795f);
    let v_68 = abs(1.0f);
    let v_69 = (v_68 * v_68);
    let v_70 = (v_69 * v_68);
    var v_71 : f32;
    if ((v_68 < 1.0f)) {
      let v_72 = (6.0f * v_60);
      v_71 = (((((12.0f - (9.0f * v_59)) - v_72) * v_70) + (((-18.0f + (12.0f * v_59)) + v_72) * v_69)) + (6.0f - (2.0f * v_59)));
    } else {
      var v_73 : f32;
      if ((v_68 < 2.0f)) {
        v_73 = (((((-(v_59) - (6.0f * v_60)) * v_70) + (((6.0f * v_59) + (30.0f * v_60)) * v_69)) + (((-12.0f * v_59) - (48.0f * v_60)) * v_68)) + ((8.0f * v_59) + (24.0f * v_60)));
      } else {
        v_73 = 0.0f;
      }
      v_71 = v_73;
    }
    let v_74 = v_71;
    let v_75 = (v_74 * 0.16666667163372039795f);
    let v_76 = abs(1.41421353816986083984f);
    let v_77 = (v_76 * v_76);
    let v_78 = (v_77 * v_76);
    var v_79 : f32;
    if ((v_76 < 1.0f)) {
      let v_80 = (6.0f * v_60);
      v_79 = (((((12.0f - (9.0f * v_59)) - v_80) * v_78) + (((-18.0f + (12.0f * v_59)) + v_80) * v_77)) + (6.0f - (2.0f * v_59)));
    } else {
      var v_81 : f32;
      if ((v_76 < 2.0f)) {
        v_81 = (((((-(v_59) - (6.0f * v_60)) * v_78) + (((6.0f * v_59) + (30.0f * v_60)) * v_77)) + (((-12.0f * v_59) - (48.0f * v_60)) * v_76)) + ((8.0f * v_59) + (24.0f * v_60)));
      } else {
        v_81 = 0.0f;
      }
      v_79 = v_81;
    }
    let v_82 = v_79;
    let v_83 = (v_82 * 0.16666667163372039795f);
    v_58 = mix(((((((((((v_1 * v_67) + (v_43 * v_75)) + (v_42 * v_75)) + (v_40 * v_75)) + (v_45 * v_75)) + (v_39 * v_83)) + (v_41 * v_83)) + (v_44 * v_83)) + (v_46 * v_83)) * (1.0f / ((v_67 + (v_74 * 0.6666666865348815918f)) + (v_82 * 0.6666666865348815918f)))), v_50, v_56);
  } else {
    v_58 = v_57;
  }
  let v_84 = v_58;
  bgfx_FragData0 = vec4<f32>(v_84.x, v_84.y, v_84.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
