diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_trx_dSampler : sampler;

@group(0u) @binding(2u) var s_trx_dTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec3<f32>) {
  let v_1 = (v_position * (0.05000000074505805969f * v.u_params.y));
  let v_2 = vec2<f32>(v_1.x, v_1.z);
  var v_3 : vec4<f32>;
  if ((v.u_params.w > 0.0f)) {
    v_3 = textureSample(s_trx_dTexture, s_trx_dSampler, v_2);
  } else {
    let v_4 = v.u_params.z;
    let v_5 = dpdx(v_2);
    let v_6 = dpdy(-(v_2));
    let v_7 = ((v_2 * 3.46410155296325683594f) * mat2x2<f32>(vec2<f32>(1.0f, -0.57735025882720947266f), vec2<f32>(0.0f, 1.15470051765441894531f)));
    let v_8 = floor(v_7);
    let v_9 = fract(v_7);
    let v_10 = v_9.x;
    let v_11 = v_9.y;
    let v_12 = -(((1.0f - v_10) - v_11));
    let v_13 = step(0.0f, v_12);
    let v_14 = ((2.0f * v_13) - 1.0f);
    let v_15 = (v_8 + vec2<f32>(v_13, v_13));
    let v_16 = (1.0f - v_13);
    let v_17 = (v_8 + vec2<f32>(v_13, v_16));
    let v_18 = (v_8 + vec2<f32>(v_16, v_13));
    let v_19 = v_15.x;
    let v_20 = v_15.y;
    let v_21 = (abs((v_19 * v_20)) + abs((v_19 + v_20)));
    let v_22 = (v_21 + 3.14159274101257324219f);
    var v_23 : f32;
    if ((v_22 < 0.0f)) {
      v_23 = (v_21 + 9.424777984619140625f);
    } else {
      v_23 = v_22;
    }
    let v_24 = v_23;
    var v_25 : f32;
    if ((v_24 > 3.14159274101257324219f)) {
      v_25 = (v_24 - 6.28318548202514648438f);
    } else {
      v_25 = v_24;
    }
    let v_26 = (v_25 * v_4);
    let v_27 = cos(v_26);
    let v_28 = sin(v_26);
    let v_29 = mat2x2<f32>(vec2<f32>(v_27, -(v_28)), vec2<f32>(v_28, v_27));
    let v_30 = v_17.x;
    let v_31 = v_17.y;
    let v_32 = (abs((v_30 * v_31)) + abs((v_30 + v_31)));
    let v_33 = (v_32 + 3.14159274101257324219f);
    var v_34 : f32;
    if ((v_33 < 0.0f)) {
      v_34 = (v_32 + 9.424777984619140625f);
    } else {
      v_34 = v_33;
    }
    let v_35 = v_34;
    var v_36 : f32;
    if ((v_35 > 3.14159274101257324219f)) {
      v_36 = (v_35 - 6.28318548202514648438f);
    } else {
      v_36 = v_35;
    }
    let v_37 = (v_36 * v_4);
    let v_38 = cos(v_37);
    let v_39 = sin(v_37);
    let v_40 = mat2x2<f32>(vec2<f32>(v_38, -(v_39)), vec2<f32>(v_39, v_38));
    let v_41 = v_18.x;
    let v_42 = v_18.y;
    let v_43 = (abs((v_41 * v_42)) + abs((v_41 + v_42)));
    let v_44 = (v_43 + 3.14159274101257324219f);
    var v_45 : f32;
    if ((v_44 < 0.0f)) {
      v_45 = (v_43 + 9.424777984619140625f);
    } else {
      v_45 = v_44;
    }
    let v_46 = v_45;
    var v_47 : f32;
    if ((v_46 > 3.14159274101257324219f)) {
      v_47 = (v_46 - 6.28318548202514648438f);
    } else {
      v_47 = v_46;
    }
    let v_48 = (v_47 * v_4);
    let v_49 = cos(v_48);
    let v_50 = sin(v_48);
    let v_51 = mat2x2<f32>(vec2<f32>(v_49, -(v_50)), vec2<f32>(v_50, v_49));
    let v_52 = ((v_15 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
    let v_53 = ((v_17 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
    let v_54 = ((v_18 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
    let v_55 = (((v_29 * (v_2 - v_52)) + v_52) + fract((sin((v_15 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
    let v_56 = (((v_40 * (v_2 - v_53)) + v_53) + fract((sin((v_17 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
    let v_57 = (((v_51 * (v_2 - v_54)) + v_54) + fract((sin((v_18 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
    let v_58 = textureSampleGrad(s_trx_dTexture, s_trx_dSampler, v_55, (v_29 * v_5), (v_29 * v_6));
    let v_59 = textureSampleGrad(s_trx_dTexture, s_trx_dSampler, v_56, (v_40 * v_5), (v_40 * v_6));
    let v_60 = textureSampleGrad(s_trx_dTexture, s_trx_dSampler, v_57, (v_51 * v_5), (v_51 * v_6));
    let v_61 = (mix(vec3<f32>(1.0f), vec3<f32>(dot(v_58.xyz, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_59.xyz, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_60.xyz, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f)) * pow(vec3<f32>((v_12 * v_14), (v_13 - (v_11 * v_14)), (v_13 - (v_10 * v_14))), vec3<f32>(7.0f)));
    let v_62 = ((v_61.x + v_61.y) + v_61.z);
    let v_63 = (v_61 / vec3<f32>(v_62, v_62, v_62));
    let v_64 = (step(vec3<f32>(0.5f), v_63) * 2.0f);
    let v_65 = ((vec3<f32>(1.0f) - v_64) * 2.0f);
    let v_66 = ((v_64 * 0.5f) + ((v_65 * 0.25f) * pow(max(vec3<f32>(), (v_64 + (v_63 * v_65))), vec3<f32>(1.73696565628051757812f))));
    let v_67 = ((v_66.x + v_66.y) + v_66.z);
    let v_68 = (v_66 / vec3<f32>(v_67, v_67, v_67));
    let v_69 = v_68.x;
    let v_70 = v_68.y;
    let v_71 = v_68.z;
    let v_72 = (((v_58 * v_69) + (v_59 * v_70)) + (v_60 * v_71));
    let v_73 = (v_19 - v_20);
    let v_74 = (v_73 - (3.0f * floor((v_73 * 0.3333333432674407959f))));
    var v_75 : f32;
    if ((v_74 < 0.0f)) {
      v_75 = (v_74 + 3.0f);
    } else {
      v_75 = v_74;
    }
    let v_76 = v_75;
    let v_77 = select(0.0f, (v_76 + 1.0f), (v_76 < 2.0f));
    let v_78 = select(2.0f, (v_76 - 1.0f), (v_76 > 0.0f));
    let v_79 = (v_19 < v_41);
    let v_80 = select(v_77, v_78, v_79);
    let v_81 = select(v_78, v_77, v_79);
    let v_82 = select(select(v_69, v_70, (v_80 == 0.0f)), v_71, (v_81 == 0.0f));
    let v_83 = select(select(v_69, v_70, (v_80 == 1.0f)), v_71, (v_81 == 1.0f));
    let v_84 = select(select(v_69, v_70, (v_80 == 2.0f)), v_71, (v_81 == 2.0f));
    var v_85 : vec4<f32>;
    if ((v.u_params.x > 0.0f)) {
      v_85 = vec4<f32>(v_82, v_83, v_84, 1.0f);
    } else {
      v_85 = vec4<f32>(v_72.x, v_72.y, v_72.z, 1.0f);
    }
    v_3 = v_85;
  }
  bgfx_FragData0 = v_3;
}

@fragment
fn main(@location(0u) v_position : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position);
  return bgfx_FragData0;
}
