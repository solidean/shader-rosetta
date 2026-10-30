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

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = gl_FragCoord.xy;
  let v_2 = v.u_params2.z;
  let v_3 = vec2<f32>(v_2, v_2);
  let v_4 = v_texcoord1.w;
  let v_5 = (v_texcoord1.xy / vec2<f32>(v_4, v_4));
  let v_6 = v_texcoord2.w;
  let v_7 = (v_texcoord2.xy / vec2<f32>(v_6, v_6));
  let v_8 = v_texcoord3.w;
  let v_9 = (v_texcoord3.xy / vec2<f32>(v_8, v_8));
  let v_10 = (all((v_5 < vec2<f32>(0.99000000953674316406f))) & all((v_5 > vec2<f32>(0.00999999977648258209f))));
  let v_11 = (all((v_7 < vec2<f32>(0.99000000953674316406f))) & all((v_7 > vec2<f32>(0.00999999977648258209f))));
  let v_12 = (all((v_9 < vec2<f32>(0.99000000953674316406f))) & all((v_9 > vec2<f32>(0.00999999977648258209f))));
  var v_13 : vec3<f32>;
  var v_14 : f32;
  if (v_10) {
    let v_15 = select(0.0f, 0.40000000596046447754f, (all((v_5 > vec2<f32>())) & all((v_5 < vec2<f32>(1.0f)))));
    let v_16 = -(v_15);
    let v_17 = v.u_params1.x;
    let v_18 = v.u_smSamplingParams;
    let v_19 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
    let v_20 = sin(v_19);
    let v_21 = cos(v_19);
    var v_22 : f32;
    {
      var v_23 : f32;
      v_23 = 0.0f;
      var v_24 : i32;
      v_24 = 0i;
      loop {
        var v_25 : f32;
        let v_26 = v_24;
        let v_27 = v_23;
        if ((v_26 < 16i)) {
          let v_28 = f32(v_26);
          let v_29 = sqrt(((v_28 + 0.5f) * 0.10000000149011611938f));
          let v_30 = (v_28 * 2.39996314048767089844f);
          let v_31 = (vec2<f32>(cos(v_30), sin(v_30)) * v_29);
          let v_32 = v_31.x;
          let v_33 = v_31.y;
          let v_34 = (vec2<f32>(((v_32 * v_21) - (v_33 * v_20)), ((v_32 * v_20) + (v_33 * v_21))) * (((vec2<f32>(2.0f) * v_18.zw) * v_3) * 1.0f));
          let v_35 = (vec4<f32>(v_5.x, v_5.y, v_texcoord1.z, 1.0f) + vec4<f32>(v_34.x, v_34.y, 0.0f, 0.0f));
          var v_36 : f32;
          switch(0u) {
            default: {
              let v_37 = v_35.w;
              let v_38 = (v_35.xy / vec2<f32>(v_37, v_37));
              if ((any((v_38 > vec2<f32>(1.0f))) | any((v_38 < vec2<f32>())))) {
                v_36 = 1.0f;
                break;
              }
              v_36 = step(((v_35.z - v_17) / v_37), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_38, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
            }
          }
          v_25 = (v_27 + v_36);
          continue;
        } else {
          v_22 = v_27;
          break;
        }

        continuing {
          v_23 = v_25;
          v_24 = (v_26 + 1i);
        }
      }
    }
    let v_39 = (v_22 * 0.0625f);
    v_13 = vec3<f32>(v_16, v_15, v_16);
    v_14 = v_39;
  } else {
    var v_40 : vec3<f32>;
    var v_41 : f32;
    if (v_11) {
      let v_42 = select(0.0f, 0.40000000596046447754f, (all((v_7 > vec2<f32>())) & all((v_7 < vec2<f32>(1.0f)))));
      let v_43 = v.u_params1.x;
      let v_44 = v.u_smSamplingParams;
      let v_45 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
      let v_46 = sin(v_45);
      let v_47 = cos(v_45);
      var v_48 : f32;
      {
        var v_49 : f32;
        v_49 = 0.0f;
        var v_50 : i32;
        v_50 = 0i;
        loop {
          var v_51 : f32;
          let v_52 = v_50;
          let v_53 = v_49;
          if ((v_52 < 16i)) {
            let v_54 = f32(v_52);
            let v_55 = sqrt(((v_54 + 0.5f) * 0.10000000149011611938f));
            let v_56 = (v_54 * 2.39996314048767089844f);
            let v_57 = (vec2<f32>(cos(v_56), sin(v_56)) * v_55);
            let v_58 = v_57.x;
            let v_59 = v_57.y;
            let v_60 = (vec2<f32>(((v_58 * v_47) - (v_59 * v_46)), ((v_58 * v_46) + (v_59 * v_47))) * ((v_44.zw * v_3) * 1.0f));
            let v_61 = (vec4<f32>(v_7.x, v_7.y, v_texcoord2.z, 1.0f) + vec4<f32>(v_60.x, v_60.y, 0.0f, 0.0f));
            var v_62 : f32;
            switch(0u) {
              default: {
                let v_63 = v_61.w;
                let v_64 = (v_61.xy / vec2<f32>(v_63, v_63));
                if ((any((v_64 > vec2<f32>(1.0f))) | any((v_64 < vec2<f32>())))) {
                  v_62 = 1.0f;
                  break;
                }
                v_62 = step(((v_61.z - v_43) / v_63), dot(textureSampleLevel(s_shadowMap1Texture, s_shadowMap1Sampler, v_64, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
              }
            }
            v_51 = (v_53 + v_62);
            continue;
          } else {
            v_48 = v_53;
            break;
          }

          continuing {
            v_49 = v_51;
            v_50 = (v_52 + 1i);
          }
        }
      }
      let v_65 = (v_48 * 0.0625f);
      v_40 = vec3<f32>(v_42, v_42, -(v_42));
      v_41 = v_65;
    } else {
      var v_66 : vec3<f32>;
      var v_67 : f32;
      if (v_12) {
        let v_68 = select(0.0f, 0.40000000596046447754f, (all((v_9 > vec2<f32>())) & all((v_9 < vec2<f32>(1.0f)))));
        let v_69 = -(v_68);
        let v_70 = v.u_params1.x;
        let v_71 = v.u_smSamplingParams;
        let v_72 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
        let v_73 = sin(v_72);
        let v_74 = cos(v_72);
        var v_75 : f32;
        {
          var v_76 : f32;
          v_76 = 0.0f;
          var v_77 : i32;
          v_77 = 0i;
          loop {
            var v_78 : f32;
            let v_79 = v_77;
            let v_80 = v_76;
            if ((v_79 < 16i)) {
              let v_81 = f32(v_79);
              let v_82 = sqrt(((v_81 + 0.5f) * 0.10000000149011611938f));
              let v_83 = (v_81 * 2.39996314048767089844f);
              let v_84 = (vec2<f32>(cos(v_83), sin(v_83)) * v_82);
              let v_85 = v_84.x;
              let v_86 = v_84.y;
              let v_87 = (vec2<f32>(((v_85 * v_74) - (v_86 * v_73)), ((v_85 * v_73) + (v_86 * v_74))) * ((vec2<f32>(0.6666666865348815918f) * (v_71.zw * v_3)) * 1.0f));
              let v_88 = (vec4<f32>(v_9.x, v_9.y, v_texcoord3.z, 1.0f) + vec4<f32>(v_87.x, v_87.y, 0.0f, 0.0f));
              var v_89 : f32;
              switch(0u) {
                default: {
                  let v_90 = v_88.w;
                  let v_91 = (v_88.xy / vec2<f32>(v_90, v_90));
                  if ((any((v_91 > vec2<f32>(1.0f))) | any((v_91 < vec2<f32>())))) {
                    v_89 = 1.0f;
                    break;
                  }
                  v_89 = step(((v_88.z - v_70) / v_90), dot(textureSampleLevel(s_shadowMap2Texture, s_shadowMap2Sampler, v_91, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                }
              }
              v_78 = (v_80 + v_89);
              continue;
            } else {
              v_75 = v_80;
              break;
            }

            continuing {
              v_76 = v_78;
              v_77 = (v_79 + 1i);
            }
          }
        }
        let v_92 = (v_75 * 0.0625f);
        v_66 = vec3<f32>(v_69, v_69, v_68);
        v_67 = v_92;
      } else {
        let v_93 = v_texcoord4.w;
        let v_94 = (v_texcoord4.xy / vec2<f32>(v_93, v_93));
        let v_95 = select(0.0f, 0.40000000596046447754f, (all((v_94 > vec2<f32>())) & all((v_94 < vec2<f32>(1.0f)))));
        let v_96 = -(v_95);
        let v_97 = v.u_params1.x;
        let v_98 = v.u_smSamplingParams;
        let v_99 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
        let v_100 = sin(v_99);
        let v_101 = cos(v_99);
        var v_102 : f32;
        {
          var v_103 : f32;
          v_103 = 0.0f;
          var v_104 : i32;
          v_104 = 0i;
          loop {
            var v_105 : f32;
            let v_106 = v_104;
            let v_107 = v_103;
            if ((v_106 < 16i)) {
              let v_108 = f32(v_106);
              let v_109 = sqrt(((v_108 + 0.5f) * 0.10000000149011611938f));
              let v_110 = (v_108 * 2.39996314048767089844f);
              let v_111 = (vec2<f32>(cos(v_110), sin(v_110)) * v_109);
              let v_112 = v_111.x;
              let v_113 = v_111.y;
              let v_114 = (vec2<f32>(((v_112 * v_101) - (v_113 * v_100)), ((v_112 * v_100) + (v_113 * v_101))) * ((vec2<f32>(0.5f) * (v_98.zw * v_3)) * 1.0f));
              let v_115 = (vec4<f32>(v_94.x, v_94.y, v_texcoord4.z, 1.0f) + vec4<f32>(v_114.x, v_114.y, 0.0f, 0.0f));
              var v_116 : f32;
              switch(0u) {
                default: {
                  let v_117 = v_115.w;
                  let v_118 = (v_115.xy / vec2<f32>(v_117, v_117));
                  if ((any((v_118 > vec2<f32>(1.0f))) | any((v_118 < vec2<f32>())))) {
                    v_116 = 1.0f;
                    break;
                  }
                  v_116 = step(((v_115.z - v_97) / v_117), dot(textureSampleLevel(s_shadowMap3Texture, s_shadowMap3Sampler, v_118, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                }
              }
              v_105 = (v_107 + v_116);
              continue;
            } else {
              v_102 = v_107;
              break;
            }

            continuing {
              v_103 = v_105;
              v_104 = (v_106 + 1i);
            }
          }
        }
        let v_119 = (v_102 * 0.0625f);
        v_66 = vec3<f32>(v_95, v_96, v_96);
        v_67 = v_119;
      }
      let v_120 = v_67;
      v_40 = v_66;
      v_41 = v_120;
    }
    let v_121 = v_41;
    v_13 = v_40;
    v_14 = v_121;
  }
  let v_122 = v_14;
  let v_123 = v_13;
  let v_124 = -(normalize(v_view));
  let v_125 = v.u_lightPosition;
  let v_126 = v.u_lightSpotDirectionInner.xyz;
  let v_127 = v.u_lightSpotDirectionInner.w;
  let v_128 = v.u_lightAttenuationSpotOuter.w;
  let v_129 = v.u_lightAttenuationSpotOuter;
  let v_130 = v_125.xyz;
  let v_131 = -(normalize(v_130));
  var v_132 : vec3<f32>;
  var v_133 : f32;
  if (!((0.0f == v_125.w))) {
    let v_134 = (v_130 - v_view);
    let v_135 = normalize(v_134);
    let v_136 = max(0.0f, dot(-(v_135), normalize(v_126)));
    let v_137 = cos(radians(v_128));
    let v_138 = clamp(((v_136 - v_137) / (cos(radians(min(v_127, (v_128 - 0.00100000004749745131f)))) - v_137)), 0.0f, 1.0f);
    let v_139 = length(v_134);
    let v_140 = ((1.0f / ((v_129.x + (v_129.y * v_139)) + ((v_129.z * v_139) * v_139))) * mix(v_138, 1.0f, step(90.0f, v_128)));
    v_132 = v_135;
    v_133 = v_140;
  } else {
    v_132 = v_131;
    v_133 = 1.0f;
  }
  let v_141 = v_133;
  let v_142 = v_132;
  let v_143 = v.u_materialKs.w;
  let v_144 = dot(v_normal, v_142);
  let v_145 = dot(((v_normal * (2.0f * v_144)) - v_142), v_124);
  let v_146 = (max(vec2<f32>(v_144, (((step(0.0f, v_144) * pow(max(0.0f, v_145), v_143)) * (2.0f + v_143)) * 0.125f)), vec2<f32>()) * v_141);
  let v_147 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_148 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_146.x);
  let v_149 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_146.y);
  let v_150 = length(v_view);
  let v_151 = clamp((1.0f / exp2((((0.0000122500005090842f * v_150) * v_150) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_152 = v.u_color.xyz;
  let v_153 = mix(vec3<f32>(), (pow(abs(abs(((v_147 * v_152) + (((v_148 + v_149) * v_152) * v_122)))), vec3<f32>(0.45454546809196472168f)) + (v_123 * v.u_params2.y)), vec3<f32>(v_151, v_151, v_151));
  bgfx_FragData0 = vec4<f32>(v_153.x, v_153.y, v_153.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
