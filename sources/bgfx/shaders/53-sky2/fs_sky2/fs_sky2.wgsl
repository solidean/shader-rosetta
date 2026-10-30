diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_atmo_transmittanceSampler : sampler;

@group(0u) @binding(2u) var s_atmo_transmittanceTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_atmo_multiscatterSampler : sampler;

@group(0u) @binding(3u) var s_atmo_multiscatterTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_sky_viewSampler : sampler;

@group(0u) @binding(4u) var s_sky_viewTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_grassSampler : sampler;

@group(0u) @binding(5u) var s_grassTexture : texture_2d<f32>;

@group(0u) @binding(22u) var s_rockSampler : sampler;

@group(0u) @binding(6u) var s_rockTexture : texture_2d<f32>;

@group(0u) @binding(23u) var s_shadowMapSampler : sampler;

@group(0u) @binding(7u) var s_shadowMapTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_atmoRayleigh : vec4<f32>,
  u_atmoMie : vec4<f32>,
  u_atmoOzone : vec4<f32>,
  u_atmoPlanet : vec4<f32>,
  u_sunDirection : vec4<f32>,
  u_sunRadiance : vec4<f32>,
  u_cameraPos : vec4<f32>,
  u_skyParams : vec4<f32>,
  u_aerialParams : vec4<f32>,
  u_shadowParams : vec4<f32>,
  u_lightMtx : mat4x4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_wpos : vec3<f32>) {
  let v_1 = normalize(v_normal);
  let v_2 = abs(v_1);
  let v_3 = ((v_2 * v_2) * v_2);
  let v_4 = max(((v_3.x + v_3.y) + v_3.z), 0.00009999999747378752f);
  let v_5 = (v_3 / vec3<f32>(v_4, v_4, v_4));
  let v_6 = (v_wpos * 0.5f);
  let v_7 = v_6.zy;
  let v_8 = dpdx(v_7);
  let v_9 = dpdy(-(v_7));
  let v_10 = ((v_7 * 3.46410155296325683594f) * mat2x2<f32>(vec2<f32>(1.0f, -0.57735025882720947266f), vec2<f32>(0.0f, 1.15470051765441894531f)));
  let v_11 = floor(v_10);
  let v_12 = fract(v_10);
  let v_13 = v_12.x;
  let v_14 = v_12.y;
  let v_15 = -(((1.0f - v_13) - v_14));
  let v_16 = step(0.0f, v_15);
  let v_17 = ((2.0f * v_16) - 1.0f);
  let v_18 = (v_11 + vec2<f32>(v_16, v_16));
  let v_19 = (1.0f - v_16);
  let v_20 = (v_11 + vec2<f32>(v_16, v_19));
  let v_21 = (v_11 + vec2<f32>(v_19, v_16));
  let v_22 = v_18.x;
  let v_23 = v_18.y;
  let v_24 = (abs((v_22 * v_23)) + abs((v_22 + v_23)));
  let v_25 = (v_24 + 3.14159274101257324219f);
  var v_26 : f32;
  if ((v_25 < 0.0f)) {
    v_26 = (v_24 + 9.424777984619140625f);
  } else {
    v_26 = v_25;
  }
  let v_27 = v_26;
  var v_28 : f32;
  if ((v_27 > 3.14159274101257324219f)) {
    v_28 = (v_27 - 6.28318548202514648438f);
  } else {
    v_28 = v_27;
  }
  let v_29 = (v_28 * 0.5f);
  let v_30 = cos(v_29);
  let v_31 = sin(v_29);
  let v_32 = mat2x2<f32>(vec2<f32>(v_30, -(v_31)), vec2<f32>(v_31, v_30));
  let v_33 = v_20.x;
  let v_34 = v_20.y;
  let v_35 = (abs((v_33 * v_34)) + abs((v_33 + v_34)));
  let v_36 = (v_35 + 3.14159274101257324219f);
  var v_37 : f32;
  if ((v_36 < 0.0f)) {
    v_37 = (v_35 + 9.424777984619140625f);
  } else {
    v_37 = v_36;
  }
  let v_38 = v_37;
  var v_39 : f32;
  if ((v_38 > 3.14159274101257324219f)) {
    v_39 = (v_38 - 6.28318548202514648438f);
  } else {
    v_39 = v_38;
  }
  let v_40 = (v_39 * 0.5f);
  let v_41 = cos(v_40);
  let v_42 = sin(v_40);
  let v_43 = mat2x2<f32>(vec2<f32>(v_41, -(v_42)), vec2<f32>(v_42, v_41));
  let v_44 = v_21.x;
  let v_45 = v_21.y;
  let v_46 = (abs((v_44 * v_45)) + abs((v_44 + v_45)));
  let v_47 = (v_46 + 3.14159274101257324219f);
  var v_48 : f32;
  if ((v_47 < 0.0f)) {
    v_48 = (v_46 + 9.424777984619140625f);
  } else {
    v_48 = v_47;
  }
  let v_49 = v_48;
  var v_50 : f32;
  if ((v_49 > 3.14159274101257324219f)) {
    v_50 = (v_49 - 6.28318548202514648438f);
  } else {
    v_50 = v_49;
  }
  let v_51 = (v_50 * 0.5f);
  let v_52 = cos(v_51);
  let v_53 = sin(v_51);
  let v_54 = mat2x2<f32>(vec2<f32>(v_52, -(v_53)), vec2<f32>(v_53, v_52));
  let v_55 = ((v_18 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_56 = ((v_20 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_57 = ((v_21 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_58 = (((v_32 * (v_7 - v_55)) + v_55) + fract((sin((v_18 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_59 = (((v_43 * (v_7 - v_56)) + v_56) + fract((sin((v_20 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_60 = (((v_54 * (v_7 - v_57)) + v_57) + fract((sin((v_21 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_61 = (v_32 * v_8);
  let v_62 = (v_32 * v_9);
  let v_63 = textureSampleGrad(s_grassTexture, s_grassSampler, v_58, v_61, v_62);
  let v_64 = (v_43 * v_8);
  let v_65 = (v_43 * v_9);
  let v_66 = textureSampleGrad(s_grassTexture, s_grassSampler, v_59, v_64, v_65);
  let v_67 = (v_54 * v_8);
  let v_68 = (v_54 * v_9);
  let v_69 = v_63.xyz;
  let v_70 = v_66.xyz;
  let v_71 = textureSampleGrad(s_grassTexture, s_grassSampler, v_60, v_67, v_68).xyz;
  let v_72 = mix(vec3<f32>(1.0f), vec3<f32>(dot(v_69, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_70, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_71, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f));
  let v_73 = pow(vec3<f32>((v_15 * v_17), (v_16 - (v_14 * v_17)), (v_16 - (v_13 * v_17))), vec3<f32>(7.0f));
  let v_74 = (v_72 * v_73);
  let v_75 = ((v_74.x + v_74.y) + v_74.z);
  let v_76 = (v_74 / vec3<f32>(v_75, v_75, v_75));
  let v_77 = (step(vec3<f32>(0.5f), v_76) * 2.0f);
  let v_78 = ((vec3<f32>(1.0f) - v_77) * 2.0f);
  let v_79 = ((v_77 * 0.5f) + ((v_78 * 0.25f) * pow(max(vec3<f32>(), (v_77 + (v_76 * v_78))), vec3<f32>(1.73696565628051757812f))));
  let v_80 = ((v_79.x + v_79.y) + v_79.z);
  let v_81 = (v_79 / vec3<f32>(v_80, v_80, v_80));
  let v_82 = textureSampleGrad(s_rockTexture, s_rockSampler, v_58, v_61, v_62);
  let v_83 = textureSampleGrad(s_rockTexture, s_rockSampler, v_59, v_64, v_65);
  let v_84 = v_82.xyz;
  let v_85 = v_83.xyz;
  let v_86 = textureSampleGrad(s_rockTexture, s_rockSampler, v_60, v_67, v_68).xyz;
  let v_87 = (mix(vec3<f32>(1.0f), vec3<f32>(dot(v_84, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_85, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_86, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f)) * v_73);
  let v_88 = ((v_87.x + v_87.y) + v_87.z);
  let v_89 = (v_87 / vec3<f32>(v_88, v_88, v_88));
  let v_90 = (step(vec3<f32>(0.5f), v_89) * 2.0f);
  let v_91 = ((vec3<f32>(1.0f) - v_90) * 2.0f);
  let v_92 = ((v_90 * 0.5f) + ((v_91 * 0.25f) * pow(max(vec3<f32>(), (v_90 + (v_89 * v_91))), vec3<f32>(1.73696565628051757812f))));
  let v_93 = ((v_92.x + v_92.y) + v_92.z);
  let v_94 = (v_92 / vec3<f32>(v_93, v_93, v_93));
  let v_95 = v_6.xz;
  let v_96 = dpdx(v_95);
  let v_97 = dpdy(-(v_95));
  let v_98 = ((v_95 * 3.46410155296325683594f) * mat2x2<f32>(vec2<f32>(1.0f, -0.57735025882720947266f), vec2<f32>(0.0f, 1.15470051765441894531f)));
  let v_99 = floor(v_98);
  let v_100 = fract(v_98);
  let v_101 = v_100.x;
  let v_102 = v_100.y;
  let v_103 = -(((1.0f - v_101) - v_102));
  let v_104 = step(0.0f, v_103);
  let v_105 = ((2.0f * v_104) - 1.0f);
  let v_106 = (v_99 + vec2<f32>(v_104, v_104));
  let v_107 = (1.0f - v_104);
  let v_108 = (v_99 + vec2<f32>(v_104, v_107));
  let v_109 = (v_99 + vec2<f32>(v_107, v_104));
  let v_110 = v_106.x;
  let v_111 = v_106.y;
  let v_112 = (abs((v_110 * v_111)) + abs((v_110 + v_111)));
  let v_113 = (v_112 + 3.14159274101257324219f);
  var v_114 : f32;
  if ((v_113 < 0.0f)) {
    v_114 = (v_112 + 9.424777984619140625f);
  } else {
    v_114 = v_113;
  }
  let v_115 = v_114;
  var v_116 : f32;
  if ((v_115 > 3.14159274101257324219f)) {
    v_116 = (v_115 - 6.28318548202514648438f);
  } else {
    v_116 = v_115;
  }
  let v_117 = (v_116 * 0.5f);
  let v_118 = cos(v_117);
  let v_119 = sin(v_117);
  let v_120 = mat2x2<f32>(vec2<f32>(v_118, -(v_119)), vec2<f32>(v_119, v_118));
  let v_121 = v_108.x;
  let v_122 = v_108.y;
  let v_123 = (abs((v_121 * v_122)) + abs((v_121 + v_122)));
  let v_124 = (v_123 + 3.14159274101257324219f);
  var v_125 : f32;
  if ((v_124 < 0.0f)) {
    v_125 = (v_123 + 9.424777984619140625f);
  } else {
    v_125 = v_124;
  }
  let v_126 = v_125;
  var v_127 : f32;
  if ((v_126 > 3.14159274101257324219f)) {
    v_127 = (v_126 - 6.28318548202514648438f);
  } else {
    v_127 = v_126;
  }
  let v_128 = (v_127 * 0.5f);
  let v_129 = cos(v_128);
  let v_130 = sin(v_128);
  let v_131 = mat2x2<f32>(vec2<f32>(v_129, -(v_130)), vec2<f32>(v_130, v_129));
  let v_132 = v_109.x;
  let v_133 = v_109.y;
  let v_134 = (abs((v_132 * v_133)) + abs((v_132 + v_133)));
  let v_135 = (v_134 + 3.14159274101257324219f);
  var v_136 : f32;
  if ((v_135 < 0.0f)) {
    v_136 = (v_134 + 9.424777984619140625f);
  } else {
    v_136 = v_135;
  }
  let v_137 = v_136;
  var v_138 : f32;
  if ((v_137 > 3.14159274101257324219f)) {
    v_138 = (v_137 - 6.28318548202514648438f);
  } else {
    v_138 = v_137;
  }
  let v_139 = (v_138 * 0.5f);
  let v_140 = cos(v_139);
  let v_141 = sin(v_139);
  let v_142 = mat2x2<f32>(vec2<f32>(v_140, -(v_141)), vec2<f32>(v_141, v_140));
  let v_143 = ((v_106 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_144 = ((v_108 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_145 = ((v_109 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_146 = (((v_120 * (v_95 - v_143)) + v_143) + fract((sin((v_106 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_147 = (((v_131 * (v_95 - v_144)) + v_144) + fract((sin((v_108 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_148 = (((v_142 * (v_95 - v_145)) + v_145) + fract((sin((v_109 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_149 = (v_120 * v_96);
  let v_150 = (v_120 * v_97);
  let v_151 = textureSampleGrad(s_grassTexture, s_grassSampler, v_146, v_149, v_150);
  let v_152 = (v_131 * v_96);
  let v_153 = (v_131 * v_97);
  let v_154 = textureSampleGrad(s_grassTexture, s_grassSampler, v_147, v_152, v_153);
  let v_155 = (v_142 * v_96);
  let v_156 = (v_142 * v_97);
  let v_157 = v_151.xyz;
  let v_158 = v_154.xyz;
  let v_159 = textureSampleGrad(s_grassTexture, s_grassSampler, v_148, v_155, v_156).xyz;
  let v_160 = mix(vec3<f32>(1.0f), vec3<f32>(dot(v_157, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_158, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_159, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f));
  let v_161 = pow(vec3<f32>((v_103 * v_105), (v_104 - (v_102 * v_105)), (v_104 - (v_101 * v_105))), vec3<f32>(7.0f));
  let v_162 = (v_160 * v_161);
  let v_163 = ((v_162.x + v_162.y) + v_162.z);
  let v_164 = (v_162 / vec3<f32>(v_163, v_163, v_163));
  let v_165 = (step(vec3<f32>(0.5f), v_164) * 2.0f);
  let v_166 = ((vec3<f32>(1.0f) - v_165) * 2.0f);
  let v_167 = ((v_165 * 0.5f) + ((v_166 * 0.25f) * pow(max(vec3<f32>(), (v_165 + (v_164 * v_166))), vec3<f32>(1.73696565628051757812f))));
  let v_168 = ((v_167.x + v_167.y) + v_167.z);
  let v_169 = (v_167 / vec3<f32>(v_168, v_168, v_168));
  let v_170 = textureSampleGrad(s_rockTexture, s_rockSampler, v_146, v_149, v_150);
  let v_171 = textureSampleGrad(s_rockTexture, s_rockSampler, v_147, v_152, v_153);
  let v_172 = v_170.xyz;
  let v_173 = v_171.xyz;
  let v_174 = textureSampleGrad(s_rockTexture, s_rockSampler, v_148, v_155, v_156).xyz;
  let v_175 = (mix(vec3<f32>(1.0f), vec3<f32>(dot(v_172, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_173, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_174, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f)) * v_161);
  let v_176 = ((v_175.x + v_175.y) + v_175.z);
  let v_177 = (v_175 / vec3<f32>(v_176, v_176, v_176));
  let v_178 = (step(vec3<f32>(0.5f), v_177) * 2.0f);
  let v_179 = ((vec3<f32>(1.0f) - v_178) * 2.0f);
  let v_180 = ((v_178 * 0.5f) + ((v_179 * 0.25f) * pow(max(vec3<f32>(), (v_178 + (v_177 * v_179))), vec3<f32>(1.73696565628051757812f))));
  let v_181 = ((v_180.x + v_180.y) + v_180.z);
  let v_182 = (v_180 / vec3<f32>(v_181, v_181, v_181));
  let v_183 = v_6.xy;
  let v_184 = dpdx(v_183);
  let v_185 = dpdy(-(v_183));
  let v_186 = ((v_183 * 3.46410155296325683594f) * mat2x2<f32>(vec2<f32>(1.0f, -0.57735025882720947266f), vec2<f32>(0.0f, 1.15470051765441894531f)));
  let v_187 = floor(v_186);
  let v_188 = fract(v_186);
  let v_189 = v_188.x;
  let v_190 = v_188.y;
  let v_191 = -(((1.0f - v_189) - v_190));
  let v_192 = step(0.0f, v_191);
  let v_193 = ((2.0f * v_192) - 1.0f);
  let v_194 = (v_187 + vec2<f32>(v_192, v_192));
  let v_195 = (1.0f - v_192);
  let v_196 = (v_187 + vec2<f32>(v_192, v_195));
  let v_197 = (v_187 + vec2<f32>(v_195, v_192));
  let v_198 = v_194.x;
  let v_199 = v_194.y;
  let v_200 = (abs((v_198 * v_199)) + abs((v_198 + v_199)));
  let v_201 = (v_200 + 3.14159274101257324219f);
  var v_202 : f32;
  if ((v_201 < 0.0f)) {
    v_202 = (v_200 + 9.424777984619140625f);
  } else {
    v_202 = v_201;
  }
  let v_203 = v_202;
  var v_204 : f32;
  if ((v_203 > 3.14159274101257324219f)) {
    v_204 = (v_203 - 6.28318548202514648438f);
  } else {
    v_204 = v_203;
  }
  let v_205 = (v_204 * 0.5f);
  let v_206 = cos(v_205);
  let v_207 = sin(v_205);
  let v_208 = mat2x2<f32>(vec2<f32>(v_206, -(v_207)), vec2<f32>(v_207, v_206));
  let v_209 = v_196.x;
  let v_210 = v_196.y;
  let v_211 = (abs((v_209 * v_210)) + abs((v_209 + v_210)));
  let v_212 = (v_211 + 3.14159274101257324219f);
  var v_213 : f32;
  if ((v_212 < 0.0f)) {
    v_213 = (v_211 + 9.424777984619140625f);
  } else {
    v_213 = v_212;
  }
  let v_214 = v_213;
  var v_215 : f32;
  if ((v_214 > 3.14159274101257324219f)) {
    v_215 = (v_214 - 6.28318548202514648438f);
  } else {
    v_215 = v_214;
  }
  let v_216 = (v_215 * 0.5f);
  let v_217 = cos(v_216);
  let v_218 = sin(v_216);
  let v_219 = mat2x2<f32>(vec2<f32>(v_217, -(v_218)), vec2<f32>(v_218, v_217));
  let v_220 = v_197.x;
  let v_221 = v_197.y;
  let v_222 = (abs((v_220 * v_221)) + abs((v_220 + v_221)));
  let v_223 = (v_222 + 3.14159274101257324219f);
  var v_224 : f32;
  if ((v_223 < 0.0f)) {
    v_224 = (v_222 + 9.424777984619140625f);
  } else {
    v_224 = v_223;
  }
  let v_225 = v_224;
  var v_226 : f32;
  if ((v_225 > 3.14159274101257324219f)) {
    v_226 = (v_225 - 6.28318548202514648438f);
  } else {
    v_226 = v_225;
  }
  let v_227 = (v_226 * 0.5f);
  let v_228 = cos(v_227);
  let v_229 = sin(v_227);
  let v_230 = mat2x2<f32>(vec2<f32>(v_228, -(v_229)), vec2<f32>(v_229, v_228));
  let v_231 = ((v_194 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_232 = ((v_196 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_233 = ((v_197 * mat2x2<f32>(vec2<f32>(1.0f, 0.5f), vec2<f32>(0.0f, 0.86602538824081420898f))) * vec2<f32>(0.28867512941360473633f));
  let v_234 = (((v_208 * (v_183 - v_231)) + v_231) + fract((sin((v_194 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_235 = (((v_219 * (v_183 - v_232)) + v_232) + fract((sin((v_196 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_236 = (((v_230 * (v_183 - v_233)) + v_233) + fract((sin((v_197 * mat2x2<f32>(vec2<f32>(127.09999847412109375f, 311.70001220703125f), vec2<f32>(269.5f, 183.3000030517578125f)))) * 43758.546875f)));
  let v_237 = (v_208 * v_184);
  let v_238 = (v_208 * v_185);
  let v_239 = textureSampleGrad(s_grassTexture, s_grassSampler, v_234, v_237, v_238);
  let v_240 = (v_219 * v_184);
  let v_241 = (v_219 * v_185);
  let v_242 = textureSampleGrad(s_grassTexture, s_grassSampler, v_235, v_240, v_241);
  let v_243 = (v_230 * v_184);
  let v_244 = (v_230 * v_185);
  let v_245 = v_239.xyz;
  let v_246 = v_242.xyz;
  let v_247 = textureSampleGrad(s_grassTexture, s_grassSampler, v_236, v_243, v_244).xyz;
  let v_248 = mix(vec3<f32>(1.0f), vec3<f32>(dot(v_245, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_246, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_247, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f));
  let v_249 = pow(vec3<f32>((v_191 * v_193), (v_192 - (v_190 * v_193)), (v_192 - (v_189 * v_193))), vec3<f32>(7.0f));
  let v_250 = (v_248 * v_249);
  let v_251 = ((v_250.x + v_250.y) + v_250.z);
  let v_252 = (v_250 / vec3<f32>(v_251, v_251, v_251));
  let v_253 = (step(vec3<f32>(0.5f), v_252) * 2.0f);
  let v_254 = ((vec3<f32>(1.0f) - v_253) * 2.0f);
  let v_255 = ((v_253 * 0.5f) + ((v_254 * 0.25f) * pow(max(vec3<f32>(), (v_253 + (v_252 * v_254))), vec3<f32>(1.73696565628051757812f))));
  let v_256 = ((v_255.x + v_255.y) + v_255.z);
  let v_257 = (v_255 / vec3<f32>(v_256, v_256, v_256));
  let v_258 = textureSampleGrad(s_rockTexture, s_rockSampler, v_234, v_237, v_238);
  let v_259 = textureSampleGrad(s_rockTexture, s_rockSampler, v_235, v_240, v_241);
  let v_260 = v_258.xyz;
  let v_261 = v_259.xyz;
  let v_262 = textureSampleGrad(s_rockTexture, s_rockSampler, v_236, v_243, v_244).xyz;
  let v_263 = (mix(vec3<f32>(1.0f), vec3<f32>(dot(v_260, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_261, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f)), dot(v_262, vec3<f32>(0.29899999499320983887f, 0.58700001239776611328f, 0.11400000005960464478f))), vec3<f32>(0.60000002384185791016f)) * v_249);
  let v_264 = ((v_263.x + v_263.y) + v_263.z);
  let v_265 = (v_263 / vec3<f32>(v_264, v_264, v_264));
  let v_266 = (step(vec3<f32>(0.5f), v_265) * 2.0f);
  let v_267 = ((vec3<f32>(1.0f) - v_266) * 2.0f);
  let v_268 = ((v_266 * 0.5f) + ((v_267 * 0.25f) * pow(max(vec3<f32>(), (v_266 + (v_265 * v_267))), vec3<f32>(1.73696565628051757812f))));
  let v_269 = ((v_268.x + v_268.y) + v_268.z);
  let v_270 = (v_268 / vec3<f32>(v_269, v_269, v_269));
  let v_271 = v_5.x;
  let v_272 = v_5.y;
  let v_273 = v_5.z;
  let v_274 = pow(((((((v_69 * v_81.x) + (v_70 * v_81.y)) + (v_71 * v_81.z)) * v_271) + ((((v_157 * v_169.x) + (v_158 * v_169.y)) + (v_159 * v_169.z)) * v_272)) + ((((v_245 * v_257.x) + (v_246 * v_257.y)) + (v_247 * v_257.z)) * v_273)), vec3<f32>(2.20000004768371582031f));
  let v_275 = pow(((((((v_84 * v_94.x) + (v_85 * v_94.y)) + (v_86 * v_94.z)) * v_271) + ((((v_172 * v_182.x) + (v_173 * v_182.y)) + (v_174 * v_182.z)) * v_272)) + ((((v_260 * v_270.x) + (v_261 * v_270.y)) + (v_262 * v_270.z)) * v_273)), vec3<f32>(2.20000004768371582031f));
  let v_276 = v_1.y;
  let v_277 = smoothstep(0.10000000149011611938f, 0.30000001192092895508f, (1.0f - v_276));
  let v_278 = mix(v_274, v_275, vec3<f32>(v_277, v_277, v_277));
  let v_279 = -(normalize(v.u_sunDirection.xyz));
  let v_280 = v_279.y;
  let v_281 = max(v_wpos.y, 0.0f);
  let v_282 = v.u_atmoPlanet.x;
  let v_283 = (v_282 + v_281);
  let v_284 = v.u_atmoPlanet.y;
  let v_285 = (v_284 * v_284);
  let v_286 = (v_282 * v_282);
  let v_287 = sqrt((v_285 - v_286));
  let v_288 = (v_283 * v_283);
  let v_289 = sqrt(max((v_288 - v_286), 0.0f));
  let v_290 = ((v_280 * v_280) - 1.0f);
  let v_291 = (v_284 - v_283);
  let v_292 = textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_283) * v_280) + sqrt(max(((v_288 * v_290) + v_285), 0.0f)))) - v_291) / ((v_289 + v_287) - v_291)), (v_289 / v_287)), 0.0f).xyz;
  let v_293 = max(dot(v_1, v_279), 0.0f);
  var v_294 : f32;
  switch(0u) {
    default: {
      if ((v.u_shadowParams.z < 0.5f)) {
        v_294 = 1.0f;
        break;
      }
      let v_295 = (1.0f - v_293);
      let v_296 = (v_wpos + (v_1 * (v.u_shadowParams.y * (2.0f + (6.0f * v_295)))));
      let v_297 = (vec4<f32>(v_296.x, v_296.y, v_296.z, 1.0f) * transpose(v.u_lightMtx));
      let v_298 = v_297.w;
      let v_299 = (v_297.xyz / vec3<f32>(v_298, v_298, v_298));
      let v_300 = v_299.x;
      let v_301 = v_299.y;
      let v_302 = v_299.z;
      if ((((((v_300 < 0.0f) | (v_300 > 1.0f)) | (v_301 < 0.0f)) | (v_301 > 1.0f)) | (v_302 > 1.0f))) {
        v_294 = 1.0f;
        break;
      }
      let v_303 = v.u_shadowParams.x;
      var v_304 : f32;
      {
        var v_305 : f32;
        v_305 = 0.0f;
        var v_306 : i32;
        v_306 = -1i;
        loop {
          var v_307 : f32;
          let v_308 = v_306;
          let v_309 = v_305;
          if ((v_308 <= 1i)) {
            var v_310 : f32;
            {
              var v_311 : f32;
              v_311 = v_309;
              var v_312 : i32;
              v_312 = -1i;
              loop {
                let v_313 = v_312;
                let v_314 = v_311;
                if ((v_313 <= 1i)) {
                  continue;
                } else {
                  v_310 = v_314;
                  break;
                }

                continuing {
                  v_311 = (v_314 + select(1.0f, 0.0f, ((v_302 - (0.00150000001303851604f * (1.0f + (3.0f * v_295)))) > textureSample(s_shadowMapTexture, s_shadowMapSampler, (v_299.xy + (vec2<f32>(f32(v_313), f32(v_308)) * v_303))).x)));
                  v_312 = (v_313 + 1i);
                }
              }
            }
            v_307 = v_310;
            continue;
          } else {
            v_304 = v_309;
            break;
          }

          continuing {
            v_305 = v_307;
            v_306 = (v_308 + 1i);
          }
        }
      }
      v_294 = (v_304 * 0.11111111193895339966f);
    }
  }
  let v_315 = v_294;
  let v_316 = v.u_sunRadiance.xyz;
  let v_317 = v.u_skyParams.x;
  let v_318 = acos(clamp((sqrt(max(((v_317 * v_317) - v_286), 0.0f)) / v_317), -1.0f, 1.0f));
  let v_319 = (3.14159274101257324219f - v_318);
  var v_320 : f32;
  if ((0.0f < v_319)) {
    v_320 = 0.0f;
  } else {
    v_320 = ((sqrt(clamp(((v_318 - 3.14159274101257324219f) / max(v_318, 0.00009999999747378752f)), 0.0f, 1.0f)) * 0.5f) + 0.5f);
  }
  let v_321 = textureSampleLevel(s_sky_viewTexture, s_sky_viewSampler, vec2<f32>(0.5f, v_320), 0.0f).xyz;
  let v_322 = (1.21322524547576904297f < v_319);
  var v_323 : f32;
  if (v_322) {
    v_323 = ((1.0f - sqrt((1.0f - (1.21322524547576904297f / v_319)))) * 0.5f);
  } else {
    v_323 = ((sqrt(clamp(((v_318 + -1.92836749553680419922f) / max(v_318, 0.00009999999747378752f)), 0.0f, 1.0f)) * 0.5f) + 0.5f);
  }
  let v_324 = (v_321 + textureSampleLevel(s_sky_viewTexture, s_sky_viewSampler, vec2<f32>(0.5f, v_323), 0.0f).xyz);
  var v_325 : f32;
  if (v_322) {
    v_325 = ((1.0f - sqrt((1.0f - (1.21322524547576904297f / v_319)))) * 0.5f);
  } else {
    v_325 = ((sqrt(clamp(((v_318 + -1.92836749553680419922f) / max(v_318, 0.00009999999747378752f)), 0.0f, 1.0f)) * 0.5f) + 0.5f);
  }
  let v_326 = ((((((v_278 * 0.31830987334251403809f) * v_316) * v_292) * v_293) * v_315) + (((v_278 * ((v_324 + textureSampleLevel(s_sky_viewTexture, s_sky_viewSampler, vec2<f32>(1.0f, v_325), 0.0f).xyz) * 0.3333333432674407959f)) * (0.40000000596046447754f + (0.60000002384185791016f * clamp(v_276, 0.0f, 1.0f)))) * v.u_aerialParams.z));
  let v_327 = v.u_cameraPos.xyz;
  let v_328 = (v_wpos - v_327);
  let v_329 = length(v_328);
  let v_330 = max(v_329, 0.00000099999999747524f);
  let v_331 = (v_328 / vec3<f32>(v_330, v_330, v_330));
  let v_332 = dot(v_331, v_279);
  let v_333 = (1.0f + (v_332 * v_332));
  let v_334 = v.u_atmoMie.w;
  let v_335 = (v_334 * v_334);
  let v_336 = ((1.0f + v_335) - ((2.0f * v_334) * v_332));
  let v_337 = ((0.11936620622873306274f * ((1.0f - v_335) * v_333)) / (((2.0f + v_335) * v_336) * sqrt(max(v_336, 0.00000099999999747524f))));
  let v_338 = v.u_aerialParams.y;
  let v_339 = (v_329 * 0.0625f);
  var v_340 : vec3<f32>;
  var v_341 : vec3<f32>;
  {
    var v_342 : vec3<f32>;
    v_342 = vec3<f32>();
    var v_343 : vec3<f32>;
    v_343 = vec3<f32>(1.0f);
    var v_344 : i32;
    v_344 = 0i;
    loop {
      let v_345 = v_344;
      let v_346 = v_343;
      let v_347 = v_342;
      if ((v_345 < 16i)) {
        continue;
      } else {
        v_340 = v_346;
        v_341 = v_347;
        break;
      }

      continuing {
        let v_348 = max(((v_327 + (v_331 * ((f32(v_345) + 0.5f) * v_339)))).y, 0.0f);
        let v_349 = (v_282 + v_348);
        let v_350 = -(v_348);
        let v_351 = exp((v_350 / v.u_atmoRayleigh.w));
        let v_352 = exp((v_350 / v.u_atmoMie.z));
        let v_353 = max(0.0f, (1.0f - (abs((v_348 - v.u_atmoPlanet.z)) / v.u_atmoPlanet.w)));
        let v_354 = (v.u_atmoRayleigh.xyz * v_351);
        let v_355 = (v.u_atmoMie.x * v_352);
        let v_356 = (v.u_atmoMie.y * v_352);
        let v_357 = (v_354 * v_338);
        let v_358 = (v_355 * v_338);
        let v_359 = (((v_354 + vec3<f32>(v_356, v_356, v_356)) + (v.u_atmoOzone.xyz * v_353)) * v_338);
        let v_360 = (v_349 * v_349);
        let v_361 = sqrt(max((v_360 - v_286), 0.0f));
        let v_362 = (v_284 - v_349);
        let v_363 = textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_349) * v_280) + sqrt(max(((v_360 * v_290) + v_285), 0.0f)))) - v_362) / ((v_361 + v_287) - v_362)), (v_361 / v_287)), 0.0f).xyz;
        let v_364 = (v_358 * v_337);
        let v_365 = (((((v_357 * (0.05968310311436653137f * v_333)) + vec3<f32>(v_364, v_364, v_364)) * v_363) + ((v_357 + vec3<f32>(v_358, v_358, v_358)) * (textureSampleLevel(s_atmo_multiscatterTexture, s_atmo_multiscatterSampler, vec2<f32>(((v_280 * 0.5f) + 0.5f), ((v_349 - v_282) / (v_284 - v_282))), 0.0f).xyz * v.u_atmoOzone.w))) * v_316);
        let v_366 = exp((-(v_359) * v_339));
        v_342 = (v_347 + ((v_346 * (v_365 - (v_365 * v_366))) / max(v_359, vec3<f32>(0.00000010000000116861f))));
        v_343 = (v_346 * v_366);
        v_344 = (v_345 + 1i);
      }
    }
  }
  let v_367 = v_341;
  let v_368 = (((v_326 * v_340) + (v_367 * v.u_aerialParams.x)) * 1.60000002384185791016f);
  let v_369 = clamp(((v_368 * ((v_368 * 2.50999999046325683594f) + vec3<f32>(0.02999999932944774628f))) / ((v_368 * ((v_368 * 2.43000006675720214844f) + vec3<f32>(0.58999997377395629883f))) + vec3<f32>(0.14000000059604644775f))), vec3<f32>(), vec3<f32>(1.0f));
  bgfx_FragData0 = vec4<f32>(v_369.x, v_369.y, v_369.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_wpos : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_wpos);
  return bgfx_FragData0;
}
