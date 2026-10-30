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
  let v_2 = v_texcoord1.w;
  let v_3 = (v_texcoord1.xy / vec2<f32>(v_2, v_2));
  let v_4 = v_texcoord2.w;
  let v_5 = (v_texcoord2.xy / vec2<f32>(v_4, v_4));
  let v_6 = v_texcoord3.w;
  let v_7 = (v_texcoord3.xy / vec2<f32>(v_6, v_6));
  let v_8 = (all((v_3 < vec2<f32>(0.99000000953674316406f))) & all((v_3 > vec2<f32>(0.00999999977648258209f))));
  let v_9 = (all((v_5 < vec2<f32>(0.99000000953674316406f))) & all((v_5 > vec2<f32>(0.00999999977648258209f))));
  let v_10 = (all((v_7 < vec2<f32>(0.99000000953674316406f))) & all((v_7 > vec2<f32>(0.00999999977648258209f))));
  var v_11 : vec3<f32>;
  var v_12 : f32;
  if (v_8) {
    let v_13 = select(0.0f, 0.40000000596046447754f, (all((v_3 > vec2<f32>())) & all((v_3 < vec2<f32>(1.0f)))));
    let v_14 = -(v_13);
    let v_15 = v.u_params1.x;
    let v_16 = v.u_smSamplingParams;
    let v_17 = v_texcoord1.z;
    let v_18 = vec4<f32>(v_3.x, v_3.y, v_17, 1.0f);
    var v_19 : f32;
    switch(0u) {
      default: {
        let v_20 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
        let v_21 = sin(v_20);
        let v_22 = cos(v_20);
        let v_23 = (v_17 - v_15);
        var v_24 : i32;
        var v_25 : f32;
        {
          var v_26 : f32;
          v_26 = 0.0f;
          var v_27 : i32;
          v_27 = 0i;
          var v_28 : i32;
          v_28 = 0i;
          loop {
            var v_29 : f32;
            var v_30 : i32;
            let v_31 = v_28;
            let v_32 = v_27;
            let v_33 = v_26;
            if ((v_31 < 16i)) {
              let v_34 = f32(v_31);
              let v_35 = sqrt(((v_34 + 0.5f) * 0.10000000149011611938f));
              let v_36 = (v_34 * 2.39996314048767089844f);
              let v_37 = (vec2<f32>(cos(v_36), sin(v_36)) * v_35);
              let v_38 = v_37.x;
              let v_39 = v_37.y;
              let v_40 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, (v_18.xy + (vec2<f32>(((v_38 * v_22) - (v_39 * v_21)), ((v_38 * v_21) + (v_39 * v_22))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
              var v_41 : f32;
              var v_42 : i32;
              if ((v_40 < v_23)) {
                v_41 = (v_33 + v_40);
                v_42 = (v_32 + 1i);
              } else {
                v_41 = v_33;
                v_42 = v_32;
              }
              let v_43 = v_42;
              v_29 = v_41;
              v_30 = v_43;
              continue;
            } else {
              v_24 = v_32;
              v_25 = v_33;
              break;
            }

            continuing {
              let v_44 = v_30;
              v_26 = v_29;
              v_27 = v_44;
              v_28 = (v_31 + 1i);
            }
          }
        }
        let v_45 = v_25;
        let v_46 = v_24;
        var v_47 : f32;
        if ((v_46 > 0i)) {
          v_47 = (v_45 / f32(v_46));
        } else {
          v_47 = -1.0f;
        }
        let v_48 = v_47;
        if ((v_48 < -0.99000000953674316406f)) {
          v_19 = 1.0f;
          break;
        }
        let v_49 = max(0.0f, (v_23 - v_48));
        let v_50 = vec2<f32>(clamp(((v_16.z * v_49) / v_48), 0.0f, 0.25f), clamp(((v_16.w * v_49) / v_48), 0.0f, 0.25f));
        var v_51 : f32;
        {
          var v_52 : f32;
          v_52 = 0.0f;
          var v_53 : i32;
          v_53 = 0i;
          loop {
            var v_54 : f32;
            let v_55 = v_53;
            let v_56 = v_52;
            if ((v_55 < 16i)) {
              let v_57 = f32(v_55);
              let v_58 = sqrt(((v_57 + 0.5f) * 0.10000000149011611938f));
              let v_59 = (v_57 * 2.39996314048767089844f);
              let v_60 = (vec2<f32>(cos(v_59), sin(v_59)) * v_58);
              let v_61 = v_60.x;
              let v_62 = v_60.y;
              let v_63 = (vec2<f32>(((v_61 * v_22) - (v_62 * v_21)), ((v_61 * v_21) + (v_62 * v_22))) * v_50);
              let v_64 = (v_18 + vec4<f32>(v_63.x, v_63.y, 0.0f, 0.0f));
              var v_65 : f32;
              switch(0u) {
                default: {
                  let v_66 = v_64.w;
                  let v_67 = (v_64.xy / vec2<f32>(v_66, v_66));
                  if ((any((v_67 > vec2<f32>(1.0f))) | any((v_67 < vec2<f32>())))) {
                    v_65 = 1.0f;
                    break;
                  }
                  v_65 = step(((v_64.z - v_15) / v_66), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_67, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                }
              }
              v_54 = (v_56 + v_65);
              continue;
            } else {
              v_51 = v_56;
              break;
            }

            continuing {
              v_52 = v_54;
              v_53 = (v_55 + 1i);
            }
          }
        }
        v_19 = mix(1.0f, (v_51 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_46) * 0.0625f)));
      }
    }
    let v_68 = v_19;
    v_11 = vec3<f32>(v_14, v_13, v_14);
    v_12 = v_68;
  } else {
    var v_69 : vec3<f32>;
    var v_70 : f32;
    if (v_9) {
      let v_71 = select(0.0f, 0.40000000596046447754f, (all((v_5 > vec2<f32>())) & all((v_5 < vec2<f32>(1.0f)))));
      let v_72 = v.u_params1.x;
      let v_73 = v.u_smSamplingParams;
      let v_74 = v_texcoord2.z;
      let v_75 = vec4<f32>(v_5.x, v_5.y, v_74, 1.0f);
      var v_76 : f32;
      switch(0u) {
        default: {
          let v_77 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
          let v_78 = sin(v_77);
          let v_79 = cos(v_77);
          let v_80 = (v_74 - v_72);
          var v_81 : i32;
          var v_82 : f32;
          {
            var v_83 : f32;
            v_83 = 0.0f;
            var v_84 : i32;
            v_84 = 0i;
            var v_85 : i32;
            v_85 = 0i;
            loop {
              var v_86 : f32;
              var v_87 : i32;
              let v_88 = v_85;
              let v_89 = v_84;
              let v_90 = v_83;
              if ((v_88 < 16i)) {
                let v_91 = f32(v_88);
                let v_92 = sqrt(((v_91 + 0.5f) * 0.10000000149011611938f));
                let v_93 = (v_91 * 2.39996314048767089844f);
                let v_94 = (vec2<f32>(cos(v_93), sin(v_93)) * v_92);
                let v_95 = v_94.x;
                let v_96 = v_94.y;
                let v_97 = dot(textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, (v_75.xy + (vec2<f32>(((v_95 * v_79) - (v_96 * v_78)), ((v_95 * v_78) + (v_96 * v_79))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                var v_98 : f32;
                var v_99 : i32;
                if ((v_97 < v_80)) {
                  v_98 = (v_90 + v_97);
                  v_99 = (v_89 + 1i);
                } else {
                  v_98 = v_90;
                  v_99 = v_89;
                }
                let v_100 = v_99;
                v_86 = v_98;
                v_87 = v_100;
                continue;
              } else {
                v_81 = v_89;
                v_82 = v_90;
                break;
              }

              continuing {
                let v_101 = v_87;
                v_83 = v_86;
                v_84 = v_101;
                v_85 = (v_88 + 1i);
              }
            }
          }
          let v_102 = v_82;
          let v_103 = v_81;
          var v_104 : f32;
          if ((v_103 > 0i)) {
            v_104 = (v_102 / f32(v_103));
          } else {
            v_104 = -1.0f;
          }
          let v_105 = v_104;
          if ((v_105 < -0.99000000953674316406f)) {
            v_76 = 1.0f;
            break;
          }
          let v_106 = max(0.0f, (v_80 - v_105));
          let v_107 = vec2<f32>(clamp(((v_73.z * v_106) / v_105), 0.0f, 0.25f), clamp(((v_73.w * v_106) / v_105), 0.0f, 0.25f));
          var v_108 : f32;
          {
            var v_109 : f32;
            v_109 = 0.0f;
            var v_110 : i32;
            v_110 = 0i;
            loop {
              var v_111 : f32;
              let v_112 = v_110;
              let v_113 = v_109;
              if ((v_112 < 16i)) {
                let v_114 = f32(v_112);
                let v_115 = sqrt(((v_114 + 0.5f) * 0.10000000149011611938f));
                let v_116 = (v_114 * 2.39996314048767089844f);
                let v_117 = (vec2<f32>(cos(v_116), sin(v_116)) * v_115);
                let v_118 = v_117.x;
                let v_119 = v_117.y;
                let v_120 = (vec2<f32>(((v_118 * v_79) - (v_119 * v_78)), ((v_118 * v_78) + (v_119 * v_79))) * v_107);
                let v_121 = (v_75 + vec4<f32>(v_120.x, v_120.y, 0.0f, 0.0f));
                var v_122 : f32;
                switch(0u) {
                  default: {
                    let v_123 = v_121.w;
                    let v_124 = (v_121.xy / vec2<f32>(v_123, v_123));
                    if ((any((v_124 > vec2<f32>(1.0f))) | any((v_124 < vec2<f32>())))) {
                      v_122 = 1.0f;
                      break;
                    }
                    v_122 = step(((v_121.z - v_72) / v_123), dot(textureSampleLevel(s_shadowMap1Texture, s_shadowMap1Sampler, v_124, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                  }
                }
                v_111 = (v_113 + v_122);
                continue;
              } else {
                v_108 = v_113;
                break;
              }

              continuing {
                v_109 = v_111;
                v_110 = (v_112 + 1i);
              }
            }
          }
          v_76 = mix(1.0f, (v_108 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_103) * 0.0625f)));
        }
      }
      let v_125 = v_76;
      v_69 = vec3<f32>(v_71, v_71, -(v_71));
      v_70 = v_125;
    } else {
      var v_126 : vec3<f32>;
      var v_127 : f32;
      if (v_10) {
        let v_128 = select(0.0f, 0.40000000596046447754f, (all((v_7 > vec2<f32>())) & all((v_7 < vec2<f32>(1.0f)))));
        let v_129 = -(v_128);
        let v_130 = v.u_params1.x;
        let v_131 = v.u_smSamplingParams;
        let v_132 = v_texcoord3.z;
        let v_133 = vec4<f32>(v_7.x, v_7.y, v_132, 1.0f);
        var v_134 : f32;
        switch(0u) {
          default: {
            let v_135 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
            let v_136 = sin(v_135);
            let v_137 = cos(v_135);
            let v_138 = (v_132 - v_130);
            var v_139 : i32;
            var v_140 : f32;
            {
              var v_141 : f32;
              v_141 = 0.0f;
              var v_142 : i32;
              v_142 = 0i;
              var v_143 : i32;
              v_143 = 0i;
              loop {
                var v_144 : f32;
                var v_145 : i32;
                let v_146 = v_143;
                let v_147 = v_142;
                let v_148 = v_141;
                if ((v_146 < 16i)) {
                  let v_149 = f32(v_146);
                  let v_150 = sqrt(((v_149 + 0.5f) * 0.10000000149011611938f));
                  let v_151 = (v_149 * 2.39996314048767089844f);
                  let v_152 = (vec2<f32>(cos(v_151), sin(v_151)) * v_150);
                  let v_153 = v_152.x;
                  let v_154 = v_152.y;
                  let v_155 = dot(textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, (v_133.xy + (vec2<f32>(((v_153 * v_137) - (v_154 * v_136)), ((v_153 * v_136) + (v_154 * v_137))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                  var v_156 : f32;
                  var v_157 : i32;
                  if ((v_155 < v_138)) {
                    v_156 = (v_148 + v_155);
                    v_157 = (v_147 + 1i);
                  } else {
                    v_156 = v_148;
                    v_157 = v_147;
                  }
                  let v_158 = v_157;
                  v_144 = v_156;
                  v_145 = v_158;
                  continue;
                } else {
                  v_139 = v_147;
                  v_140 = v_148;
                  break;
                }

                continuing {
                  let v_159 = v_145;
                  v_141 = v_144;
                  v_142 = v_159;
                  v_143 = (v_146 + 1i);
                }
              }
            }
            let v_160 = v_140;
            let v_161 = v_139;
            var v_162 : f32;
            if ((v_161 > 0i)) {
              v_162 = (v_160 / f32(v_161));
            } else {
              v_162 = -1.0f;
            }
            let v_163 = v_162;
            if ((v_163 < -0.99000000953674316406f)) {
              v_134 = 1.0f;
              break;
            }
            let v_164 = max(0.0f, (v_138 - v_163));
            let v_165 = vec2<f32>(clamp(((v_131.z * v_164) / v_163), 0.0f, 0.25f), clamp(((v_131.w * v_164) / v_163), 0.0f, 0.25f));
            var v_166 : f32;
            {
              var v_167 : f32;
              v_167 = 0.0f;
              var v_168 : i32;
              v_168 = 0i;
              loop {
                var v_169 : f32;
                let v_170 = v_168;
                let v_171 = v_167;
                if ((v_170 < 16i)) {
                  let v_172 = f32(v_170);
                  let v_173 = sqrt(((v_172 + 0.5f) * 0.10000000149011611938f));
                  let v_174 = (v_172 * 2.39996314048767089844f);
                  let v_175 = (vec2<f32>(cos(v_174), sin(v_174)) * v_173);
                  let v_176 = v_175.x;
                  let v_177 = v_175.y;
                  let v_178 = (vec2<f32>(((v_176 * v_137) - (v_177 * v_136)), ((v_176 * v_136) + (v_177 * v_137))) * v_165);
                  let v_179 = (v_133 + vec4<f32>(v_178.x, v_178.y, 0.0f, 0.0f));
                  var v_180 : f32;
                  switch(0u) {
                    default: {
                      let v_181 = v_179.w;
                      let v_182 = (v_179.xy / vec2<f32>(v_181, v_181));
                      if ((any((v_182 > vec2<f32>(1.0f))) | any((v_182 < vec2<f32>())))) {
                        v_180 = 1.0f;
                        break;
                      }
                      v_180 = step(((v_179.z - v_130) / v_181), dot(textureSampleLevel(s_shadowMap2Texture, s_shadowMap2Sampler, v_182, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                    }
                  }
                  v_169 = (v_171 + v_180);
                  continue;
                } else {
                  v_166 = v_171;
                  break;
                }

                continuing {
                  v_167 = v_169;
                  v_168 = (v_170 + 1i);
                }
              }
            }
            v_134 = mix(1.0f, (v_166 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_161) * 0.0625f)));
          }
        }
        let v_183 = v_134;
        v_126 = vec3<f32>(v_129, v_129, v_128);
        v_127 = v_183;
      } else {
        let v_184 = v_texcoord4.w;
        let v_185 = (v_texcoord4.xy / vec2<f32>(v_184, v_184));
        let v_186 = select(0.0f, 0.40000000596046447754f, (all((v_185 > vec2<f32>())) & all((v_185 < vec2<f32>(1.0f)))));
        let v_187 = -(v_186);
        let v_188 = v.u_params1.x;
        let v_189 = v.u_smSamplingParams;
        let v_190 = v_texcoord4.z;
        let v_191 = vec4<f32>(v_185.x, v_185.y, v_190, 1.0f);
        var v_192 : f32;
        switch(0u) {
          default: {
            let v_193 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
            let v_194 = sin(v_193);
            let v_195 = cos(v_193);
            let v_196 = (v_190 - v_188);
            var v_197 : i32;
            var v_198 : f32;
            {
              var v_199 : f32;
              v_199 = 0.0f;
              var v_200 : i32;
              v_200 = 0i;
              var v_201 : i32;
              v_201 = 0i;
              loop {
                var v_202 : f32;
                var v_203 : i32;
                let v_204 = v_201;
                let v_205 = v_200;
                let v_206 = v_199;
                if ((v_204 < 16i)) {
                  let v_207 = f32(v_204);
                  let v_208 = sqrt(((v_207 + 0.5f) * 0.10000000149011611938f));
                  let v_209 = (v_207 * 2.39996314048767089844f);
                  let v_210 = (vec2<f32>(cos(v_209), sin(v_209)) * v_208);
                  let v_211 = v_210.x;
                  let v_212 = v_210.y;
                  let v_213 = dot(textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, (v_191.xy + (vec2<f32>(((v_211 * v_195) - (v_212 * v_194)), ((v_211 * v_194) + (v_212 * v_195))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                  var v_214 : f32;
                  var v_215 : i32;
                  if ((v_213 < v_196)) {
                    v_214 = (v_206 + v_213);
                    v_215 = (v_205 + 1i);
                  } else {
                    v_214 = v_206;
                    v_215 = v_205;
                  }
                  let v_216 = v_215;
                  v_202 = v_214;
                  v_203 = v_216;
                  continue;
                } else {
                  v_197 = v_205;
                  v_198 = v_206;
                  break;
                }

                continuing {
                  let v_217 = v_203;
                  v_199 = v_202;
                  v_200 = v_217;
                  v_201 = (v_204 + 1i);
                }
              }
            }
            let v_218 = v_198;
            let v_219 = v_197;
            var v_220 : f32;
            if ((v_219 > 0i)) {
              v_220 = (v_218 / f32(v_219));
            } else {
              v_220 = -1.0f;
            }
            let v_221 = v_220;
            if ((v_221 < -0.99000000953674316406f)) {
              v_192 = 1.0f;
              break;
            }
            let v_222 = max(0.0f, (v_196 - v_221));
            let v_223 = vec2<f32>(clamp(((v_189.z * v_222) / v_221), 0.0f, 0.25f), clamp(((v_189.w * v_222) / v_221), 0.0f, 0.25f));
            var v_224 : f32;
            {
              var v_225 : f32;
              v_225 = 0.0f;
              var v_226 : i32;
              v_226 = 0i;
              loop {
                var v_227 : f32;
                let v_228 = v_226;
                let v_229 = v_225;
                if ((v_228 < 16i)) {
                  let v_230 = f32(v_228);
                  let v_231 = sqrt(((v_230 + 0.5f) * 0.10000000149011611938f));
                  let v_232 = (v_230 * 2.39996314048767089844f);
                  let v_233 = (vec2<f32>(cos(v_232), sin(v_232)) * v_231);
                  let v_234 = v_233.x;
                  let v_235 = v_233.y;
                  let v_236 = (vec2<f32>(((v_234 * v_195) - (v_235 * v_194)), ((v_234 * v_194) + (v_235 * v_195))) * v_223);
                  let v_237 = (v_191 + vec4<f32>(v_236.x, v_236.y, 0.0f, 0.0f));
                  var v_238 : f32;
                  switch(0u) {
                    default: {
                      let v_239 = v_237.w;
                      let v_240 = (v_237.xy / vec2<f32>(v_239, v_239));
                      if ((any((v_240 > vec2<f32>(1.0f))) | any((v_240 < vec2<f32>())))) {
                        v_238 = 1.0f;
                        break;
                      }
                      v_238 = step(((v_237.z - v_188) / v_239), dot(textureSampleLevel(s_shadowMap3Texture, s_shadowMap3Sampler, v_240, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                    }
                  }
                  v_227 = (v_229 + v_238);
                  continue;
                } else {
                  v_224 = v_229;
                  break;
                }

                continuing {
                  v_225 = v_227;
                  v_226 = (v_228 + 1i);
                }
              }
            }
            v_192 = mix(1.0f, (v_224 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_219) * 0.0625f)));
          }
        }
        let v_241 = v_192;
        v_126 = vec3<f32>(v_186, v_187, v_187);
        v_127 = v_241;
      }
      let v_242 = v_127;
      v_69 = v_126;
      v_70 = v_242;
    }
    let v_243 = v_70;
    v_11 = v_69;
    v_12 = v_243;
  }
  let v_244 = v_12;
  let v_245 = v_11;
  let v_246 = -(normalize(v_view));
  let v_247 = v.u_lightPosition;
  let v_248 = v.u_lightSpotDirectionInner.xyz;
  let v_249 = v.u_lightSpotDirectionInner.w;
  let v_250 = v.u_lightAttenuationSpotOuter.w;
  let v_251 = v.u_lightAttenuationSpotOuter;
  let v_252 = v_247.xyz;
  let v_253 = -(normalize(v_252));
  var v_254 : vec3<f32>;
  var v_255 : f32;
  if (!((0.0f == v_247.w))) {
    let v_256 = (v_252 - v_view);
    let v_257 = normalize(v_256);
    let v_258 = max(0.0f, dot(-(v_257), normalize(v_248)));
    let v_259 = cos(radians(v_250));
    let v_260 = clamp(((v_258 - v_259) / (cos(radians(min(v_249, (v_250 - 0.00100000004749745131f)))) - v_259)), 0.0f, 1.0f);
    let v_261 = length(v_256);
    let v_262 = ((1.0f / ((v_251.x + (v_251.y * v_261)) + ((v_251.z * v_261) * v_261))) * mix(v_260, 1.0f, step(90.0f, v_250)));
    v_254 = v_257;
    v_255 = v_262;
  } else {
    v_254 = v_253;
    v_255 = 1.0f;
  }
  let v_263 = v_255;
  let v_264 = v_254;
  let v_265 = v.u_materialKs.w;
  let v_266 = dot(v_normal, v_264);
  let v_267 = dot(((v_normal * (2.0f * v_266)) - v_264), v_246);
  let v_268 = (max(vec2<f32>(v_266, (((step(0.0f, v_266) * pow(max(0.0f, v_267), v_265)) * (2.0f + v_265)) * 0.125f)), vec2<f32>()) * v_263);
  let v_269 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_270 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_268.x);
  let v_271 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_268.y);
  let v_272 = length(v_view);
  let v_273 = clamp((1.0f / exp2((((0.0000122500005090842f * v_272) * v_272) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_274 = v.u_color.xyz;
  let v_275 = mix(vec3<f32>(), (pow(abs(abs(((v_269 * v_274) + (((v_270 + v_271) * v_274) * v_244)))), vec3<f32>(0.45454546809196472168f)) + (v_245 * v.u_params2.y)), vec3<f32>(v_273, v_273, v_273));
  bgfx_FragData0 = vec4<f32>(v_275.x, v_275.y, v_275.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
