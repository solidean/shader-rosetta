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
    var v_17 : f32;
    switch(0u) {
      default: {
        let v_18 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
        let v_19 = sin(v_18);
        let v_20 = cos(v_18);
        let v_21 = ((v_texcoord1.z / v_2) - v_15);
        var v_22 : i32;
        var v_23 : f32;
        {
          var v_24 : f32;
          v_24 = 0.0f;
          var v_25 : i32;
          v_25 = 0i;
          var v_26 : i32;
          v_26 = 0i;
          loop {
            var v_27 : f32;
            var v_28 : i32;
            let v_29 = v_26;
            let v_30 = v_25;
            let v_31 = v_24;
            if ((v_29 < 16i)) {
              let v_32 = f32(v_29);
              let v_33 = sqrt(((v_32 + 0.5f) * 0.10000000149011611938f));
              let v_34 = (v_32 * 2.39996314048767089844f);
              let v_35 = (vec2<f32>(cos(v_34), sin(v_34)) * v_33);
              let v_36 = v_35.x;
              let v_37 = v_35.y;
              let v_38 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, (v_3 + (vec2<f32>(((v_36 * v_20) - (v_37 * v_19)), ((v_36 * v_19) + (v_37 * v_20))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
              var v_39 : f32;
              var v_40 : i32;
              if ((v_38 < v_21)) {
                v_39 = (v_31 + v_38);
                v_40 = (v_30 + 1i);
              } else {
                v_39 = v_31;
                v_40 = v_30;
              }
              let v_41 = v_40;
              v_27 = v_39;
              v_28 = v_41;
              continue;
            } else {
              v_22 = v_30;
              v_23 = v_31;
              break;
            }

            continuing {
              let v_42 = v_28;
              v_24 = v_27;
              v_25 = v_42;
              v_26 = (v_29 + 1i);
            }
          }
        }
        let v_43 = v_23;
        let v_44 = v_22;
        var v_45 : f32;
        if ((v_44 > 0i)) {
          v_45 = (v_43 / f32(v_44));
        } else {
          v_45 = -1.0f;
        }
        let v_46 = v_45;
        if ((v_46 < -0.99000000953674316406f)) {
          v_17 = 1.0f;
          break;
        }
        let v_47 = max(0.0f, (v_21 - v_46));
        let v_48 = vec2<f32>(clamp(((v_16.z * v_47) / v_46), 0.0f, 0.25f), clamp(((v_16.w * v_47) / v_46), 0.0f, 0.25f));
        var v_49 : f32;
        {
          var v_50 : f32;
          v_50 = 0.0f;
          var v_51 : i32;
          v_51 = 0i;
          loop {
            var v_52 : f32;
            let v_53 = v_51;
            let v_54 = v_50;
            if ((v_53 < 16i)) {
              let v_55 = f32(v_53);
              let v_56 = sqrt(((v_55 + 0.5f) * 0.10000000149011611938f));
              let v_57 = (v_55 * 2.39996314048767089844f);
              let v_58 = (vec2<f32>(cos(v_57), sin(v_57)) * v_56);
              let v_59 = v_58.x;
              let v_60 = v_58.y;
              let v_61 = (vec2<f32>(((v_59 * v_20) - (v_60 * v_19)), ((v_59 * v_19) + (v_60 * v_20))) * v_48);
              let v_62 = (v_texcoord1 + vec4<f32>(v_61.x, v_61.y, 0.0f, 0.0f));
              var v_63 : f32;
              switch(0u) {
                default: {
                  let v_64 = v_62.w;
                  let v_65 = (v_62.xy / vec2<f32>(v_64, v_64));
                  if ((any((v_65 > vec2<f32>(1.0f))) | any((v_65 < vec2<f32>())))) {
                    v_63 = 1.0f;
                    break;
                  }
                  v_63 = step(((v_62.z - v_15) / v_64), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_65, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                }
              }
              v_52 = (v_54 + v_63);
              continue;
            } else {
              v_49 = v_54;
              break;
            }

            continuing {
              v_50 = v_52;
              v_51 = (v_53 + 1i);
            }
          }
        }
        v_17 = mix(1.0f, (v_49 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_44) * 0.0625f)));
      }
    }
    let v_66 = v_17;
    v_11 = vec3<f32>(v_14, v_13, v_14);
    v_12 = v_66;
  } else {
    var v_67 : vec3<f32>;
    var v_68 : f32;
    if (v_9) {
      let v_69 = select(0.0f, 0.40000000596046447754f, (all((v_5 > vec2<f32>())) & all((v_5 < vec2<f32>(1.0f)))));
      let v_70 = v.u_params1.x;
      let v_71 = v.u_smSamplingParams;
      var v_72 : f32;
      switch(0u) {
        default: {
          let v_73 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
          let v_74 = sin(v_73);
          let v_75 = cos(v_73);
          let v_76 = ((v_texcoord2.z / v_4) - v_70);
          var v_77 : i32;
          var v_78 : f32;
          {
            var v_79 : f32;
            v_79 = 0.0f;
            var v_80 : i32;
            v_80 = 0i;
            var v_81 : i32;
            v_81 = 0i;
            loop {
              var v_82 : f32;
              var v_83 : i32;
              let v_84 = v_81;
              let v_85 = v_80;
              let v_86 = v_79;
              if ((v_84 < 16i)) {
                let v_87 = f32(v_84);
                let v_88 = sqrt(((v_87 + 0.5f) * 0.10000000149011611938f));
                let v_89 = (v_87 * 2.39996314048767089844f);
                let v_90 = (vec2<f32>(cos(v_89), sin(v_89)) * v_88);
                let v_91 = v_90.x;
                let v_92 = v_90.y;
                let v_93 = dot(textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, (v_5 + (vec2<f32>(((v_91 * v_75) - (v_92 * v_74)), ((v_91 * v_74) + (v_92 * v_75))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                var v_94 : f32;
                var v_95 : i32;
                if ((v_93 < v_76)) {
                  v_94 = (v_86 + v_93);
                  v_95 = (v_85 + 1i);
                } else {
                  v_94 = v_86;
                  v_95 = v_85;
                }
                let v_96 = v_95;
                v_82 = v_94;
                v_83 = v_96;
                continue;
              } else {
                v_77 = v_85;
                v_78 = v_86;
                break;
              }

              continuing {
                let v_97 = v_83;
                v_79 = v_82;
                v_80 = v_97;
                v_81 = (v_84 + 1i);
              }
            }
          }
          let v_98 = v_78;
          let v_99 = v_77;
          var v_100 : f32;
          if ((v_99 > 0i)) {
            v_100 = (v_98 / f32(v_99));
          } else {
            v_100 = -1.0f;
          }
          let v_101 = v_100;
          if ((v_101 < -0.99000000953674316406f)) {
            v_72 = 1.0f;
            break;
          }
          let v_102 = max(0.0f, (v_76 - v_101));
          let v_103 = vec2<f32>(clamp(((v_71.z * v_102) / v_101), 0.0f, 0.25f), clamp(((v_71.w * v_102) / v_101), 0.0f, 0.25f));
          var v_104 : f32;
          {
            var v_105 : f32;
            v_105 = 0.0f;
            var v_106 : i32;
            v_106 = 0i;
            loop {
              var v_107 : f32;
              let v_108 = v_106;
              let v_109 = v_105;
              if ((v_108 < 16i)) {
                let v_110 = f32(v_108);
                let v_111 = sqrt(((v_110 + 0.5f) * 0.10000000149011611938f));
                let v_112 = (v_110 * 2.39996314048767089844f);
                let v_113 = (vec2<f32>(cos(v_112), sin(v_112)) * v_111);
                let v_114 = v_113.x;
                let v_115 = v_113.y;
                let v_116 = (vec2<f32>(((v_114 * v_75) - (v_115 * v_74)), ((v_114 * v_74) + (v_115 * v_75))) * v_103);
                let v_117 = (v_texcoord2 + vec4<f32>(v_116.x, v_116.y, 0.0f, 0.0f));
                var v_118 : f32;
                switch(0u) {
                  default: {
                    let v_119 = v_117.w;
                    let v_120 = (v_117.xy / vec2<f32>(v_119, v_119));
                    if ((any((v_120 > vec2<f32>(1.0f))) | any((v_120 < vec2<f32>())))) {
                      v_118 = 1.0f;
                      break;
                    }
                    v_118 = step(((v_117.z - v_70) / v_119), dot(textureSampleLevel(s_shadowMap1Texture, s_shadowMap1Sampler, v_120, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                  }
                }
                v_107 = (v_109 + v_118);
                continue;
              } else {
                v_104 = v_109;
                break;
              }

              continuing {
                v_105 = v_107;
                v_106 = (v_108 + 1i);
              }
            }
          }
          v_72 = mix(1.0f, (v_104 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_99) * 0.0625f)));
        }
      }
      let v_121 = v_72;
      v_67 = vec3<f32>(v_69, v_69, -(v_69));
      v_68 = v_121;
    } else {
      var v_122 : vec3<f32>;
      var v_123 : f32;
      if (v_10) {
        let v_124 = select(0.0f, 0.40000000596046447754f, (all((v_7 > vec2<f32>())) & all((v_7 < vec2<f32>(1.0f)))));
        let v_125 = -(v_124);
        let v_126 = v.u_params1.x;
        let v_127 = v.u_smSamplingParams;
        var v_128 : f32;
        switch(0u) {
          default: {
            let v_129 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
            let v_130 = sin(v_129);
            let v_131 = cos(v_129);
            let v_132 = ((v_texcoord3.z / v_6) - v_126);
            var v_133 : i32;
            var v_134 : f32;
            {
              var v_135 : f32;
              v_135 = 0.0f;
              var v_136 : i32;
              v_136 = 0i;
              var v_137 : i32;
              v_137 = 0i;
              loop {
                var v_138 : f32;
                var v_139 : i32;
                let v_140 = v_137;
                let v_141 = v_136;
                let v_142 = v_135;
                if ((v_140 < 16i)) {
                  let v_143 = f32(v_140);
                  let v_144 = sqrt(((v_143 + 0.5f) * 0.10000000149011611938f));
                  let v_145 = (v_143 * 2.39996314048767089844f);
                  let v_146 = (vec2<f32>(cos(v_145), sin(v_145)) * v_144);
                  let v_147 = v_146.x;
                  let v_148 = v_146.y;
                  let v_149 = dot(textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, (v_7 + (vec2<f32>(((v_147 * v_131) - (v_148 * v_130)), ((v_147 * v_130) + (v_148 * v_131))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                  var v_150 : f32;
                  var v_151 : i32;
                  if ((v_149 < v_132)) {
                    v_150 = (v_142 + v_149);
                    v_151 = (v_141 + 1i);
                  } else {
                    v_150 = v_142;
                    v_151 = v_141;
                  }
                  let v_152 = v_151;
                  v_138 = v_150;
                  v_139 = v_152;
                  continue;
                } else {
                  v_133 = v_141;
                  v_134 = v_142;
                  break;
                }

                continuing {
                  let v_153 = v_139;
                  v_135 = v_138;
                  v_136 = v_153;
                  v_137 = (v_140 + 1i);
                }
              }
            }
            let v_154 = v_134;
            let v_155 = v_133;
            var v_156 : f32;
            if ((v_155 > 0i)) {
              v_156 = (v_154 / f32(v_155));
            } else {
              v_156 = -1.0f;
            }
            let v_157 = v_156;
            if ((v_157 < -0.99000000953674316406f)) {
              v_128 = 1.0f;
              break;
            }
            let v_158 = max(0.0f, (v_132 - v_157));
            let v_159 = vec2<f32>(clamp(((v_127.z * v_158) / v_157), 0.0f, 0.25f), clamp(((v_127.w * v_158) / v_157), 0.0f, 0.25f));
            var v_160 : f32;
            {
              var v_161 : f32;
              v_161 = 0.0f;
              var v_162 : i32;
              v_162 = 0i;
              loop {
                var v_163 : f32;
                let v_164 = v_162;
                let v_165 = v_161;
                if ((v_164 < 16i)) {
                  let v_166 = f32(v_164);
                  let v_167 = sqrt(((v_166 + 0.5f) * 0.10000000149011611938f));
                  let v_168 = (v_166 * 2.39996314048767089844f);
                  let v_169 = (vec2<f32>(cos(v_168), sin(v_168)) * v_167);
                  let v_170 = v_169.x;
                  let v_171 = v_169.y;
                  let v_172 = (vec2<f32>(((v_170 * v_131) - (v_171 * v_130)), ((v_170 * v_130) + (v_171 * v_131))) * v_159);
                  let v_173 = (v_texcoord3 + vec4<f32>(v_172.x, v_172.y, 0.0f, 0.0f));
                  var v_174 : f32;
                  switch(0u) {
                    default: {
                      let v_175 = v_173.w;
                      let v_176 = (v_173.xy / vec2<f32>(v_175, v_175));
                      if ((any((v_176 > vec2<f32>(1.0f))) | any((v_176 < vec2<f32>())))) {
                        v_174 = 1.0f;
                        break;
                      }
                      v_174 = step(((v_173.z - v_126) / v_175), dot(textureSampleLevel(s_shadowMap2Texture, s_shadowMap2Sampler, v_176, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                    }
                  }
                  v_163 = (v_165 + v_174);
                  continue;
                } else {
                  v_160 = v_165;
                  break;
                }

                continuing {
                  v_161 = v_163;
                  v_162 = (v_164 + 1i);
                }
              }
            }
            v_128 = mix(1.0f, (v_160 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_155) * 0.0625f)));
          }
        }
        let v_177 = v_128;
        v_122 = vec3<f32>(v_125, v_125, v_124);
        v_123 = v_177;
      } else {
        let v_178 = v_texcoord4.w;
        let v_179 = (v_texcoord4.xy / vec2<f32>(v_178, v_178));
        let v_180 = select(0.0f, 0.40000000596046447754f, (all((v_179 > vec2<f32>())) & all((v_179 < vec2<f32>(1.0f)))));
        let v_181 = -(v_180);
        let v_182 = v.u_params1.x;
        let v_183 = v.u_smSamplingParams;
        var v_184 : f32;
        switch(0u) {
          default: {
            let v_185 = (fract((52.98291778564453125f * fract(dot(v_1, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
            let v_186 = sin(v_185);
            let v_187 = cos(v_185);
            let v_188 = ((v_texcoord4.z / v_178) - v_182);
            var v_189 : i32;
            var v_190 : f32;
            {
              var v_191 : f32;
              v_191 = 0.0f;
              var v_192 : i32;
              v_192 = 0i;
              var v_193 : i32;
              v_193 = 0i;
              loop {
                var v_194 : f32;
                var v_195 : i32;
                let v_196 = v_193;
                let v_197 = v_192;
                let v_198 = v_191;
                if ((v_196 < 16i)) {
                  let v_199 = f32(v_196);
                  let v_200 = sqrt(((v_199 + 0.5f) * 0.10000000149011611938f));
                  let v_201 = (v_199 * 2.39996314048767089844f);
                  let v_202 = (vec2<f32>(cos(v_201), sin(v_201)) * v_200);
                  let v_203 = v_202.x;
                  let v_204 = v_202.y;
                  let v_205 = dot(textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, (v_179 + (vec2<f32>(((v_203 * v_187) - (v_204 * v_186)), ((v_203 * v_186) + (v_204 * v_187))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
                  var v_206 : f32;
                  var v_207 : i32;
                  if ((v_205 < v_188)) {
                    v_206 = (v_198 + v_205);
                    v_207 = (v_197 + 1i);
                  } else {
                    v_206 = v_198;
                    v_207 = v_197;
                  }
                  let v_208 = v_207;
                  v_194 = v_206;
                  v_195 = v_208;
                  continue;
                } else {
                  v_189 = v_197;
                  v_190 = v_198;
                  break;
                }

                continuing {
                  let v_209 = v_195;
                  v_191 = v_194;
                  v_192 = v_209;
                  v_193 = (v_196 + 1i);
                }
              }
            }
            let v_210 = v_190;
            let v_211 = v_189;
            var v_212 : f32;
            if ((v_211 > 0i)) {
              v_212 = (v_210 / f32(v_211));
            } else {
              v_212 = -1.0f;
            }
            let v_213 = v_212;
            if ((v_213 < -0.99000000953674316406f)) {
              v_184 = 1.0f;
              break;
            }
            let v_214 = max(0.0f, (v_188 - v_213));
            let v_215 = vec2<f32>(clamp(((v_183.z * v_214) / v_213), 0.0f, 0.25f), clamp(((v_183.w * v_214) / v_213), 0.0f, 0.25f));
            var v_216 : f32;
            {
              var v_217 : f32;
              v_217 = 0.0f;
              var v_218 : i32;
              v_218 = 0i;
              loop {
                var v_219 : f32;
                let v_220 = v_218;
                let v_221 = v_217;
                if ((v_220 < 16i)) {
                  let v_222 = f32(v_220);
                  let v_223 = sqrt(((v_222 + 0.5f) * 0.10000000149011611938f));
                  let v_224 = (v_222 * 2.39996314048767089844f);
                  let v_225 = (vec2<f32>(cos(v_224), sin(v_224)) * v_223);
                  let v_226 = v_225.x;
                  let v_227 = v_225.y;
                  let v_228 = (vec2<f32>(((v_226 * v_187) - (v_227 * v_186)), ((v_226 * v_186) + (v_227 * v_187))) * v_215);
                  let v_229 = (v_texcoord4 + vec4<f32>(v_228.x, v_228.y, 0.0f, 0.0f));
                  var v_230 : f32;
                  switch(0u) {
                    default: {
                      let v_231 = v_229.w;
                      let v_232 = (v_229.xy / vec2<f32>(v_231, v_231));
                      if ((any((v_232 > vec2<f32>(1.0f))) | any((v_232 < vec2<f32>())))) {
                        v_230 = 1.0f;
                        break;
                      }
                      v_230 = step(((v_229.z - v_182) / v_231), dot(textureSampleLevel(s_shadowMap3Texture, s_shadowMap3Sampler, v_232, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
                    }
                  }
                  v_219 = (v_221 + v_230);
                  continue;
                } else {
                  v_216 = v_221;
                  break;
                }

                continuing {
                  v_217 = v_219;
                  v_218 = (v_220 + 1i);
                }
              }
            }
            v_184 = mix(1.0f, (v_216 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_211) * 0.0625f)));
          }
        }
        let v_233 = v_184;
        v_122 = vec3<f32>(v_180, v_181, v_181);
        v_123 = v_233;
      }
      let v_234 = v_123;
      v_67 = v_122;
      v_68 = v_234;
    }
    let v_235 = v_68;
    v_11 = v_67;
    v_12 = v_235;
  }
  let v_236 = v_12;
  let v_237 = v_11;
  let v_238 = -(normalize(v_view));
  let v_239 = v.u_lightPosition;
  let v_240 = v.u_lightSpotDirectionInner.xyz;
  let v_241 = v.u_lightSpotDirectionInner.w;
  let v_242 = v.u_lightAttenuationSpotOuter.w;
  let v_243 = v.u_lightAttenuationSpotOuter;
  let v_244 = v_239.xyz;
  let v_245 = -(normalize(v_244));
  var v_246 : vec3<f32>;
  var v_247 : f32;
  if (!((0.0f == v_239.w))) {
    let v_248 = (v_244 - v_view);
    let v_249 = normalize(v_248);
    let v_250 = max(0.0f, dot(-(v_249), normalize(v_240)));
    let v_251 = cos(radians(v_242));
    let v_252 = clamp(((v_250 - v_251) / (cos(radians(min(v_241, (v_242 - 0.00100000004749745131f)))) - v_251)), 0.0f, 1.0f);
    let v_253 = length(v_248);
    let v_254 = ((1.0f / ((v_243.x + (v_243.y * v_253)) + ((v_243.z * v_253) * v_253))) * mix(v_252, 1.0f, step(90.0f, v_242)));
    v_246 = v_249;
    v_247 = v_254;
  } else {
    v_246 = v_245;
    v_247 = 1.0f;
  }
  let v_255 = v_247;
  let v_256 = v_246;
  let v_257 = v.u_materialKs.w;
  let v_258 = dot(v_normal, v_256);
  let v_259 = dot(((v_normal * (2.0f * v_258)) - v_256), v_238);
  let v_260 = (max(vec2<f32>(v_258, (((step(0.0f, v_258) * pow(max(0.0f, v_259), v_257)) * (2.0f + v_257)) * 0.125f)), vec2<f32>()) * v_255);
  let v_261 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_262 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_260.x);
  let v_263 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_260.y);
  let v_264 = length(v_view);
  let v_265 = clamp((1.0f / exp2((((0.0000122500005090842f * v_264) * v_264) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_266 = v.u_color.xyz;
  let v_267 = mix(vec3<f32>(), (pow(abs(abs(((v_261 * v_266) + (((v_262 + v_263) * v_266) * v_236)))), vec3<f32>(0.45454546809196472168f)) + (v_237 * v.u_params2.y)), vec3<f32>(v_265, v_265, v_265));
  bgfx_FragData0 = vec4<f32>(v_267.x, v_267.y, v_267.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
