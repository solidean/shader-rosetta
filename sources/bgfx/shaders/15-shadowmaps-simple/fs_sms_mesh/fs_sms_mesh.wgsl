diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_shadowMapSamplerComparison : sampler_comparison;

@group(0u) @binding(2u) var s_shadowMapTexture : texture_depth_2d;

struct UniformBlock {
  u_lightPos : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_shadowcoord : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = -(normalize(v_view));
  let v_2 = normalize(v.u_lightPos.xyz);
  let v_3 = dot(v_normal, -(v_2));
  let v_4 = dot(((v_normal * (2.0f * v_3)) + v_2), v_1);
  let v_5 = max(vec2<f32>(v_3, ((step(0.0f, v_3) * pow(max(0.0f, v_4), 1.0f)) * 0.375f)), vec2<f32>());
  var v_6 : f32;
  switch(0u) {
    default: {
      let v_7 = v_shadowcoord.w;
      let v_8 = (v_shadowcoord.xy / vec2<f32>(v_7, v_7));
      if ((any((v_8 > vec2<f32>(1.0f))) | any((v_8 < vec2<f32>())))) {
        v_6 = 1.0f;
        break;
      }
      let v_9 = (vec2<f32>(0.001953125f) * v_7);
      let v_10 = (vec2<f32>(-1.5f) * v_9);
      let v_11 = (v_shadowcoord + vec4<f32>(v_10.x, v_10.y, 0.0f, 0.0f));
      let v_12 = v_11.w;
      let v_13 = (v_11.xyz / vec3<f32>(v_12, v_12, v_12));
      let v_14 = (v_13.z - 0.00499999988824129105f);
      let v_15 = (vec2<f32>(-1.5f, -0.5f) * v_9);
      let v_16 = (v_shadowcoord + vec4<f32>(v_15.x, v_15.y, 0.0f, 0.0f));
      let v_17 = v_16.w;
      let v_18 = (v_16.xyz / vec3<f32>(v_17, v_17, v_17));
      let v_19 = (v_18.z - 0.00499999988824129105f);
      let v_20 = (vec2<f32>(-1.5f, 0.5f) * v_9);
      let v_21 = (v_shadowcoord + vec4<f32>(v_20.x, v_20.y, 0.0f, 0.0f));
      let v_22 = v_21.w;
      let v_23 = (v_21.xyz / vec3<f32>(v_22, v_22, v_22));
      let v_24 = (v_23.z - 0.00499999988824129105f);
      let v_25 = (vec2<f32>(-1.5f, 1.5f) * v_9);
      let v_26 = (v_shadowcoord + vec4<f32>(v_25.x, v_25.y, 0.0f, 0.0f));
      let v_27 = v_26.w;
      let v_28 = (v_26.xyz / vec3<f32>(v_27, v_27, v_27));
      let v_29 = (v_28.z - 0.00499999988824129105f);
      let v_30 = (vec2<f32>(-0.5f, -1.5f) * v_9);
      let v_31 = (v_shadowcoord + vec4<f32>(v_30.x, v_30.y, 0.0f, 0.0f));
      let v_32 = v_31.w;
      let v_33 = (v_31.xyz / vec3<f32>(v_32, v_32, v_32));
      let v_34 = (v_33.z - 0.00499999988824129105f);
      let v_35 = (vec2<f32>(-0.5f) * v_9);
      let v_36 = (v_shadowcoord + vec4<f32>(v_35.x, v_35.y, 0.0f, 0.0f));
      let v_37 = v_36.w;
      let v_38 = (v_36.xyz / vec3<f32>(v_37, v_37, v_37));
      let v_39 = (v_38.z - 0.00499999988824129105f);
      let v_40 = (vec2<f32>(-0.5f, 0.5f) * v_9);
      let v_41 = (v_shadowcoord + vec4<f32>(v_40.x, v_40.y, 0.0f, 0.0f));
      let v_42 = v_41.w;
      let v_43 = (v_41.xyz / vec3<f32>(v_42, v_42, v_42));
      let v_44 = (v_43.z - 0.00499999988824129105f);
      let v_45 = (vec2<f32>(-0.5f, 1.5f) * v_9);
      let v_46 = (v_shadowcoord + vec4<f32>(v_45.x, v_45.y, 0.0f, 0.0f));
      let v_47 = v_46.w;
      let v_48 = (v_46.xyz / vec3<f32>(v_47, v_47, v_47));
      let v_49 = (v_48.z - 0.00499999988824129105f);
      let v_50 = (vec2<f32>(0.5f, -1.5f) * v_9);
      let v_51 = (v_shadowcoord + vec4<f32>(v_50.x, v_50.y, 0.0f, 0.0f));
      let v_52 = v_51.w;
      let v_53 = (v_51.xyz / vec3<f32>(v_52, v_52, v_52));
      let v_54 = (v_53.z - 0.00499999988824129105f);
      let v_55 = (vec2<f32>(0.5f, -0.5f) * v_9);
      let v_56 = (v_shadowcoord + vec4<f32>(v_55.x, v_55.y, 0.0f, 0.0f));
      let v_57 = v_56.w;
      let v_58 = (v_56.xyz / vec3<f32>(v_57, v_57, v_57));
      let v_59 = (v_58.z - 0.00499999988824129105f);
      let v_60 = (vec2<f32>(0.5f) * v_9);
      let v_61 = (v_shadowcoord + vec4<f32>(v_60.x, v_60.y, 0.0f, 0.0f));
      let v_62 = v_61.w;
      let v_63 = (v_61.xyz / vec3<f32>(v_62, v_62, v_62));
      let v_64 = (v_63.z - 0.00499999988824129105f);
      let v_65 = (vec2<f32>(0.5f, 1.5f) * v_9);
      let v_66 = (v_shadowcoord + vec4<f32>(v_65.x, v_65.y, 0.0f, 0.0f));
      let v_67 = v_66.w;
      let v_68 = (v_66.xyz / vec3<f32>(v_67, v_67, v_67));
      let v_69 = (v_68.z - 0.00499999988824129105f);
      let v_70 = (vec2<f32>(1.5f, -1.5f) * v_9);
      let v_71 = (v_shadowcoord + vec4<f32>(v_70.x, v_70.y, 0.0f, 0.0f));
      let v_72 = v_71.w;
      let v_73 = (v_71.xyz / vec3<f32>(v_72, v_72, v_72));
      let v_74 = (v_73.z - 0.00499999988824129105f);
      let v_75 = (vec2<f32>(1.5f, -0.5f) * v_9);
      let v_76 = (v_shadowcoord + vec4<f32>(v_75.x, v_75.y, 0.0f, 0.0f));
      let v_77 = v_76.w;
      let v_78 = (v_76.xyz / vec3<f32>(v_77, v_77, v_77));
      let v_79 = (v_78.z - 0.00499999988824129105f);
      let v_80 = (vec2<f32>(1.5f, 0.5f) * v_9);
      let v_81 = (v_shadowcoord + vec4<f32>(v_80.x, v_80.y, 0.0f, 0.0f));
      let v_82 = v_81.w;
      let v_83 = (v_81.xyz / vec3<f32>(v_82, v_82, v_82));
      let v_84 = (v_83.z - 0.00499999988824129105f);
      let v_85 = (vec2<f32>(1.5f) * v_9);
      let v_86 = (v_shadowcoord + vec4<f32>(v_85.x, v_85.y, 0.0f, 0.0f));
      let v_87 = v_86.w;
      let v_88 = (v_86.xyz / vec3<f32>(v_87, v_87, v_87));
      let v_89 = (v_88.z - 0.00499999988824129105f);
      v_6 = ((((((((((((((((textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_13.x, v_13.y, v_14).xy, v_14) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_18.x, v_18.y, v_19).xy, v_19)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_23.x, v_23.y, v_24).xy, v_24)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_28.x, v_28.y, v_29).xy, v_29)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_33.x, v_33.y, v_34).xy, v_34)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_38.x, v_38.y, v_39).xy, v_39)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_43.x, v_43.y, v_44).xy, v_44)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_48.x, v_48.y, v_49).xy, v_49)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_53.x, v_53.y, v_54).xy, v_54)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_58.x, v_58.y, v_59).xy, v_59)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_63.x, v_63.y, v_64).xy, v_64)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_68.x, v_68.y, v_69).xy, v_69)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_73.x, v_73.y, v_74).xy, v_74)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_78.x, v_78.y, v_79).xy, v_79)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_83.x, v_83.y, v_84).xy, v_84)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_88.x, v_88.y, v_89).xy, v_89)) * 0.0625f);
    }
  }
  let v_90 = pow(abs(abs((vec3<f32>(0.10000000149011611938f) + ((vec3<f32>(1.0f) * (v_5.x + v_5.y)) * v_6)))), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_90.x, v_90.y, v_90.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
