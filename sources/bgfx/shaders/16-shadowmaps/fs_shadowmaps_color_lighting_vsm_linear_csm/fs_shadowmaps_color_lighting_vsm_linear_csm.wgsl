diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(22u) var s_shadowMap0Sampler : sampler;

@group(0u) @binding(6u) var s_shadowMap0Texture : texture_2d<f32>;

@group(0u) @binding(23u) var s_shadowMap1Sampler : sampler;

@group(0u) @binding(7u) var s_shadowMap1Texture : texture_2d<f32>;

@group(0u) @binding(24u) var s_shadowMap2Sampler : sampler;

@group(0u) @binding(8u) var s_shadowMap2Texture : texture_2d<f32>;

@group(0u) @binding(25u) var s_shadowMap3Sampler : sampler;

@group(0u) @binding(9u) var s_shadowMap3Texture : texture_2d<f32>;

struct UniformBlock {
  u_params1 : vec4<f32>,
  u_params2 : vec4<f32>,
  u_color : vec4<f32>,
  u_materialKa : vec4<f32>,
  u_materialKd : vec4<f32>,
  u_materialKs : vec4<f32>,
  u_lightPosition : vec4<f32>,
  u_lightAmbientPower : vec4<f32>,
  u_lightDiffusePower : vec4<f32>,
  u_lightSpecularPower : vec4<f32>,
  u_lightSpotDirectionInner : vec4<f32>,
  u_lightAttenuationSpotOuter : vec4<f32>,
  u_smSamplingParams : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = v_texcoord1.w;
  let v_2 = (v_texcoord1.xy / vec2<f32>(v_1, v_1));
  let v_3 = v_texcoord2.w;
  let v_4 = (v_texcoord2.xy / vec2<f32>(v_3, v_3));
  let v_5 = v_texcoord3.w;
  let v_6 = (v_texcoord3.xy / vec2<f32>(v_5, v_5));
  let v_7 = (all((v_2 < vec2<f32>(0.99000000953674316406f))) & all((v_2 > vec2<f32>(0.00999999977648258209f))));
  let v_8 = (all((v_4 < vec2<f32>(0.99000000953674316406f))) & all((v_4 > vec2<f32>(0.00999999977648258209f))));
  let v_9 = (all((v_6 < vec2<f32>(0.99000000953674316406f))) & all((v_6 > vec2<f32>(0.00999999977648258209f))));
  var v_10 : vec3<f32>;
  var v_11 : f32;
  if (v_7) {
    let v_12 = select(0.0f, 0.40000000596046447754f, (all((v_2 > vec2<f32>())) & all((v_2 < vec2<f32>(1.0f)))));
    let v_13 = -(v_12);
    let v_14 = v.u_params1.x;
    let v_15 = v.u_params1.w;
    let v_16 = v.u_params1.z;
    let v_17 = v_texcoord1.z;
    var v_18 : f32;
    switch(0u) {
      default: {
        let v_19 = vec4<f32>(v_2.x, v_2.y, v_17, 1.0f).xy;
        if ((any((v_19 > vec2<f32>(1.0f))) | any((v_19 < vec2<f32>())))) {
          v_18 = 1.0f;
          break;
        }
        let v_20 = ((v_17 - v_14) * v_15);
        let v_21 = textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_19);
        let v_22 = (vec2<f32>(dot(v_21.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_21.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_15);
        let v_23 = v_22.x;
        if ((v_20 < v_23)) {
          v_18 = 1.0f;
          break;
        }
        let v_24 = max((v_22.y - (v_23 * v_23)), v_16);
        let v_25 = (v_20 - v_23);
        v_18 = (v_24 / (v_24 + (v_25 * v_25)));
      }
    }
    let v_26 = v_18;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_26;
  } else {
    var v_27 : vec3<f32>;
    var v_28 : f32;
    if (v_8) {
      let v_29 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_30 = v.u_params1.x;
      let v_31 = v.u_params1.w;
      let v_32 = v.u_params1.z;
      let v_33 = v_texcoord2.z;
      var v_34 : f32;
      switch(0u) {
        default: {
          let v_35 = vec4<f32>(v_4.x, v_4.y, v_33, 1.0f).xy;
          if ((any((v_35 > vec2<f32>(1.0f))) | any((v_35 < vec2<f32>())))) {
            v_34 = 1.0f;
            break;
          }
          let v_36 = ((v_33 - v_30) * v_31);
          let v_37 = textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, v_35);
          let v_38 = (vec2<f32>(dot(v_37.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_37.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_31);
          let v_39 = v_38.x;
          if ((v_36 < v_39)) {
            v_34 = 1.0f;
            break;
          }
          let v_40 = max((v_38.y - (v_39 * v_39)), v_32);
          let v_41 = (v_36 - v_39);
          v_34 = (v_40 / (v_40 + (v_41 * v_41)));
        }
      }
      let v_42 = v_34;
      v_27 = vec3<f32>(v_29, v_29, -(v_29));
      v_28 = v_42;
    } else {
      var v_43 : vec3<f32>;
      var v_44 : f32;
      if (v_9) {
        let v_45 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_46 = -(v_45);
        let v_47 = v.u_params1.x;
        let v_48 = v.u_params1.w;
        let v_49 = v.u_params1.z;
        let v_50 = v_texcoord3.z;
        var v_51 : f32;
        switch(0u) {
          default: {
            let v_52 = vec4<f32>(v_6.x, v_6.y, v_50, 1.0f).xy;
            if ((any((v_52 > vec2<f32>(1.0f))) | any((v_52 < vec2<f32>())))) {
              v_51 = 1.0f;
              break;
            }
            let v_53 = ((v_50 - v_47) * v_48);
            let v_54 = textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, v_52);
            let v_55 = (vec2<f32>(dot(v_54.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_54.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_48);
            let v_56 = v_55.x;
            if ((v_53 < v_56)) {
              v_51 = 1.0f;
              break;
            }
            let v_57 = max((v_55.y - (v_56 * v_56)), v_49);
            let v_58 = (v_53 - v_56);
            v_51 = (v_57 / (v_57 + (v_58 * v_58)));
          }
        }
        let v_59 = v_51;
        v_43 = vec3<f32>(v_46, v_46, v_45);
        v_44 = v_59;
      } else {
        let v_60 = v_texcoord4.w;
        let v_61 = (v_texcoord4.xy / vec2<f32>(v_60, v_60));
        let v_62 = select(0.0f, 0.40000000596046447754f, (all((v_61 > vec2<f32>())) & all((v_61 < vec2<f32>(1.0f)))));
        let v_63 = -(v_62);
        let v_64 = v.u_params1.x;
        let v_65 = v.u_params1.w;
        let v_66 = v.u_params1.z;
        let v_67 = v_texcoord4.z;
        var v_68 : f32;
        switch(0u) {
          default: {
            let v_69 = vec4<f32>(v_61.x, v_61.y, v_67, 1.0f).xy;
            if ((any((v_69 > vec2<f32>(1.0f))) | any((v_69 < vec2<f32>())))) {
              v_68 = 1.0f;
              break;
            }
            let v_70 = ((v_67 - v_64) * v_65);
            let v_71 = textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, v_69);
            let v_72 = (vec2<f32>(dot(v_71.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_71.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_65);
            let v_73 = v_72.x;
            if ((v_70 < v_73)) {
              v_68 = 1.0f;
              break;
            }
            let v_74 = max((v_72.y - (v_73 * v_73)), v_66);
            let v_75 = (v_70 - v_73);
            v_68 = (v_74 / (v_74 + (v_75 * v_75)));
          }
        }
        let v_76 = v_68;
        v_43 = vec3<f32>(v_62, v_63, v_63);
        v_44 = v_76;
      }
      let v_77 = v_44;
      v_27 = v_43;
      v_28 = v_77;
    }
    let v_78 = v_28;
    v_10 = v_27;
    v_11 = v_78;
  }
  let v_79 = v_11;
  let v_80 = v_10;
  let v_81 = -(normalize(v_view));
  let v_82 = v.u_lightPosition;
  let v_83 = v.u_lightSpotDirectionInner.xyz;
  let v_84 = v.u_lightSpotDirectionInner.w;
  let v_85 = v.u_lightAttenuationSpotOuter.w;
  let v_86 = v.u_lightAttenuationSpotOuter;
  let v_87 = v_82.xyz;
  let v_88 = -(normalize(v_87));
  var v_89 : vec3<f32>;
  var v_90 : f32;
  if (!((0.0f == v_82.w))) {
    let v_91 = (v_87 - v_view);
    let v_92 = normalize(v_91);
    let v_93 = max(0.0f, dot(-(v_92), normalize(v_83)));
    let v_94 = cos(radians(v_85));
    let v_95 = clamp(((v_93 - v_94) / (cos(radians(min(v_84, (v_85 - 0.00100000004749745131f)))) - v_94)), 0.0f, 1.0f);
    let v_96 = length(v_91);
    let v_97 = ((1.0f / ((v_86.x + (v_86.y * v_96)) + ((v_86.z * v_96) * v_96))) * mix(v_95, 1.0f, step(90.0f, v_85)));
    v_89 = v_92;
    v_90 = v_97;
  } else {
    v_89 = v_88;
    v_90 = 1.0f;
  }
  let v_98 = v_90;
  let v_99 = v_89;
  let v_100 = v.u_materialKs.w;
  let v_101 = dot(v_normal, v_99);
  let v_102 = dot(((v_normal * (2.0f * v_101)) - v_99), v_81);
  let v_103 = (max(vec2<f32>(v_101, (((step(0.0f, v_101) * pow(max(0.0f, v_102), v_100)) * (2.0f + v_100)) * 0.125f)), vec2<f32>()) * v_98);
  let v_104 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_105 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_103.x);
  let v_106 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_103.y);
  let v_107 = length(v_view);
  let v_108 = clamp((1.0f / exp2((((0.0000122500005090842f * v_107) * v_107) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_109 = v.u_color.xyz;
  let v_110 = mix(vec3<f32>(), (pow(abs(abs(((v_104 * v_109) + (((v_105 + v_106) * v_109) * v_79)))), vec3<f32>(0.45454546809196472168f)) + (v_80 * v.u_params2.y)), vec3<f32>(v_108, v_108, v_108));
  bgfx_FragData0 = vec4<f32>(v_110.x, v_110.y, v_110.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
