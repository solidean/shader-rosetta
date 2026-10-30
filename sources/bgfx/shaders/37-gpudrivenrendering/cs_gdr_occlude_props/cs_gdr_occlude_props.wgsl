diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texOcclusionDepthSampler : sampler;

@group(0u) @binding(2u) var s_texOcclusionDepthTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_viewProj : mat4x4<f32>,
  u_inputRTSize : vec4<f32>,
  u_cullingConfig : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

struct instanceDataIn {
  m : array<vec4<f32>>,
}

@group(0u) @binding(3u) var<storage, read> instanceDataIn_1 : instanceDataIn;

struct drawcallInstanceCount_atomic {
  m_1 : array<atomic<u32>>,
}

@group(0u) @binding(4u) var<storage, read_write> drawcallInstanceCount_1 : drawcallInstanceCount_atomic;

struct instancePredicates {
  m_2 : array<u32>,
}

@group(0u) @binding(5u) var<storage, read_write> instancePredicates_1 : instancePredicates;

@compute @workgroup_size(64u, 1u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).x;
  var v_2 : bool;
  if ((bitcast<u32>(v_1) < u32(v.u_cullingConfig.x))) {
    let v_3 = (2i * v_1);
    let v_4 = instanceDataIn_1.m[v_3];
    let v_5 = instanceDataIn_1.m[(v_3 + 1i)];
    let v_6 = v_4.xyz;
    let v_7 = (v_5.xyz - v_6);
    let v_8 = v_7.x;
    let v_9 = (v_6 + vec3<f32>(v_8, 0.0f, 0.0f));
    let v_10 = v_7.y;
    let v_11 = (v_6 + vec3<f32>(0.0f, v_10, 0.0f));
    let v_12 = v_7.z;
    let v_13 = (v_6 + vec3<f32>(0.0f, 0.0f, v_12));
    let v_14 = (v_6 + vec3<f32>(v_8, v_10, 0.0f));
    let v_15 = (v_6 + vec3<f32>(0.0f, v_10, v_12));
    let v_16 = (v_6 + vec3<f32>(v_8, 0.0f, v_12));
    let v_17 = transpose(v.u_viewProj);
    let v_18 = (vec4<f32>(v_4.x, v_4.y, v_4.z, 1.0f) * v_17);
    var v_19 : vec4<f32> = v_18;
    v_19.z = max(v_18.z, 0.0f);
    let v_20 = v_18.w;
    let v_21 = (v_19.xyz / vec3<f32>(v_20, v_20, v_20));
    var v_22 : vec4<f32> = vec4<f32>();
    v_22.x = v_21.x;
    var v_23 : vec4<f32> = v_22;
    v_23.y = v_21.y;
    let v_24 = clamp(v_23.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_25 : vec4<f32> = vec4<f32>();
    v_25.x = v_24.x;
    var v_26 : vec4<f32> = v_25;
    v_26.y = v_24.y;
    let v_27 = ((v_26.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_28 : vec4<f32> = vec4<f32>();
    v_28.x = v_27.x;
    var v_29 : vec4<f32> = v_28;
    v_29.y = v_27.y;
    let v_30 = v_29.xy;
    let v_31 = min(v_30, vec2<f32>(1.0f));
    let v_32 = max(v_30, vec2<f32>());
    let v_33 = clamp(min(1.0f, v_21.z), 0.0f, 1.0f);
    let v_34 = (vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f) * v_17);
    var v_35 : vec4<f32> = v_34;
    v_35.z = max(v_34.z, 0.0f);
    let v_36 = v_34.w;
    let v_37 = (v_35.xyz / vec3<f32>(v_36, v_36, v_36));
    var v_38 : vec4<f32> = vec4<f32>();
    v_38.x = v_37.x;
    var v_39 : vec4<f32> = v_38;
    v_39.y = v_37.y;
    let v_40 = clamp(v_39.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_41 : vec4<f32> = vec4<f32>();
    v_41.x = v_40.x;
    var v_42 : vec4<f32> = v_41;
    v_42.y = v_40.y;
    let v_43 = ((v_42.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_44 : vec4<f32> = vec4<f32>();
    v_44.x = v_43.x;
    var v_45 : vec4<f32> = v_44;
    v_45.y = v_43.y;
    let v_46 = v_45.xy;
    let v_47 = min(v_46, v_31);
    let v_48 = max(v_46, v_32);
    let v_49 = clamp(min(v_33, v_37.z), 0.0f, 1.0f);
    let v_50 = (vec4<f32>(v_11.x, v_11.y, v_11.z, 1.0f) * v_17);
    var v_51 : vec4<f32> = v_50;
    v_51.z = max(v_50.z, 0.0f);
    let v_52 = v_50.w;
    let v_53 = (v_51.xyz / vec3<f32>(v_52, v_52, v_52));
    var v_54 : vec4<f32> = vec4<f32>();
    v_54.x = v_53.x;
    var v_55 : vec4<f32> = v_54;
    v_55.y = v_53.y;
    let v_56 = clamp(v_55.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_57 : vec4<f32> = vec4<f32>();
    v_57.x = v_56.x;
    var v_58 : vec4<f32> = v_57;
    v_58.y = v_56.y;
    let v_59 = ((v_58.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_60 : vec4<f32> = vec4<f32>();
    v_60.x = v_59.x;
    var v_61 : vec4<f32> = v_60;
    v_61.y = v_59.y;
    let v_62 = v_61.xy;
    let v_63 = min(v_62, v_47);
    let v_64 = max(v_62, v_48);
    let v_65 = clamp(min(v_49, v_53.z), 0.0f, 1.0f);
    let v_66 = (vec4<f32>(v_13.x, v_13.y, v_13.z, 1.0f) * v_17);
    var v_67 : vec4<f32> = v_66;
    v_67.z = max(v_66.z, 0.0f);
    let v_68 = v_66.w;
    let v_69 = (v_67.xyz / vec3<f32>(v_68, v_68, v_68));
    var v_70 : vec4<f32> = vec4<f32>();
    v_70.x = v_69.x;
    var v_71 : vec4<f32> = v_70;
    v_71.y = v_69.y;
    let v_72 = clamp(v_71.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_73 : vec4<f32> = vec4<f32>();
    v_73.x = v_72.x;
    var v_74 : vec4<f32> = v_73;
    v_74.y = v_72.y;
    let v_75 = ((v_74.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_76 : vec4<f32> = vec4<f32>();
    v_76.x = v_75.x;
    var v_77 : vec4<f32> = v_76;
    v_77.y = v_75.y;
    let v_78 = v_77.xy;
    let v_79 = min(v_78, v_63);
    let v_80 = max(v_78, v_64);
    let v_81 = clamp(min(v_65, v_69.z), 0.0f, 1.0f);
    let v_82 = (vec4<f32>(v_14.x, v_14.y, v_14.z, 1.0f) * v_17);
    var v_83 : vec4<f32> = v_82;
    v_83.z = max(v_82.z, 0.0f);
    let v_84 = v_82.w;
    let v_85 = (v_83.xyz / vec3<f32>(v_84, v_84, v_84));
    var v_86 : vec4<f32> = vec4<f32>();
    v_86.x = v_85.x;
    var v_87 : vec4<f32> = v_86;
    v_87.y = v_85.y;
    let v_88 = clamp(v_87.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_89 : vec4<f32> = vec4<f32>();
    v_89.x = v_88.x;
    var v_90 : vec4<f32> = v_89;
    v_90.y = v_88.y;
    let v_91 = ((v_90.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_92 : vec4<f32> = vec4<f32>();
    v_92.x = v_91.x;
    var v_93 : vec4<f32> = v_92;
    v_93.y = v_91.y;
    let v_94 = v_93.xy;
    let v_95 = min(v_94, v_79);
    let v_96 = max(v_94, v_80);
    let v_97 = clamp(min(v_81, v_85.z), 0.0f, 1.0f);
    let v_98 = (vec4<f32>(v_15.x, v_15.y, v_15.z, 1.0f) * v_17);
    var v_99 : vec4<f32> = v_98;
    v_99.z = max(v_98.z, 0.0f);
    let v_100 = v_98.w;
    let v_101 = (v_99.xyz / vec3<f32>(v_100, v_100, v_100));
    var v_102 : vec4<f32> = vec4<f32>();
    v_102.x = v_101.x;
    var v_103 : vec4<f32> = v_102;
    v_103.y = v_101.y;
    let v_104 = clamp(v_103.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_105 : vec4<f32> = vec4<f32>();
    v_105.x = v_104.x;
    var v_106 : vec4<f32> = v_105;
    v_106.y = v_104.y;
    let v_107 = ((v_106.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_108 : vec4<f32> = vec4<f32>();
    v_108.x = v_107.x;
    var v_109 : vec4<f32> = v_108;
    v_109.y = v_107.y;
    let v_110 = v_109.xy;
    let v_111 = min(v_110, v_95);
    let v_112 = max(v_110, v_96);
    let v_113 = clamp(min(v_97, v_101.z), 0.0f, 1.0f);
    let v_114 = (vec4<f32>(v_16.x, v_16.y, v_16.z, 1.0f) * v_17);
    var v_115 : vec4<f32> = v_114;
    v_115.z = max(v_114.z, 0.0f);
    let v_116 = v_114.w;
    let v_117 = (v_115.xyz / vec3<f32>(v_116, v_116, v_116));
    var v_118 : vec4<f32> = vec4<f32>();
    v_118.x = v_117.x;
    var v_119 : vec4<f32> = v_118;
    v_119.y = v_117.y;
    let v_120 = clamp(v_119.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_121 : vec4<f32> = vec4<f32>();
    v_121.x = v_120.x;
    var v_122 : vec4<f32> = v_121;
    v_122.y = v_120.y;
    let v_123 = ((v_122.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_124 : vec4<f32> = vec4<f32>();
    v_124.x = v_123.x;
    var v_125 : vec4<f32> = v_124;
    v_125.y = v_123.y;
    let v_126 = v_125.xy;
    let v_127 = min(v_126, v_111);
    let v_128 = max(v_126, v_112);
    let v_129 = clamp(min(v_113, v_117.z), 0.0f, 1.0f);
    let v_130 = (vec4<f32>(v_5.x, v_5.y, v_5.z, 1.0f) * v_17);
    var v_131 : vec4<f32> = v_130;
    v_131.z = max(v_130.z, 0.0f);
    let v_132 = v_130.w;
    let v_133 = (v_131.xyz / vec3<f32>(v_132, v_132, v_132));
    var v_134 : vec4<f32> = vec4<f32>();
    v_134.x = v_133.x;
    var v_135 : vec4<f32> = v_134;
    v_135.y = v_133.y;
    let v_136 = clamp(v_135.xy, vec2<f32>(-1.0f), vec2<f32>(1.0f));
    var v_137 : vec4<f32> = vec4<f32>();
    v_137.x = v_136.x;
    var v_138 : vec4<f32> = v_137;
    v_138.y = v_136.y;
    let v_139 = ((v_138.xy * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f));
    var v_140 : vec4<f32> = vec4<f32>();
    v_140.x = v_139.x;
    var v_141 : vec4<f32> = v_140;
    v_141.y = v_139.y;
    let v_142 = v_141.xy;
    let v_143 = min(v_142, v_127);
    let v_144 = max(v_142, v_128);
    let v_145 = clamp(min(v_129, v_133.z), 0.0f, 1.0f);
    let v_146 = vec4<f32>(v_143.x, v_143.y, v_144.x, v_144.y);
    let v_147 = vec2<i32>(((v_144 - v_143) * v.u_inputRTSize.xy));
    let v_148 = clamp(ceil(log2(f32(max(v_147.x, v_147.y)))), 0.0f, v.u_cullingConfig.z);
    let v_149 = max((v_148 - 1.0f), 0.0f);
    let v_150 = exp2(-(v_149));
    let v_151 = vec2<f32>(v_150, v_150);
    let v_152 = v_146.xy;
    let v_153 = floor((v_152 * v_151));
    let v_154 = v_146.zw;
    let v_155 = (ceil((v_154 * v_151)) - v_153);
    let v_156 = select(v_148, v_149, ((v_155.x <= 2.0f) & (v_155.y <= 2.0f)));
    let v_157 = textureSampleLevel(s_texOcclusionDepthTexture, s_texOcclusionDepthSampler, v_152, v_156).x;
    let v_158 = textureSampleLevel(s_texOcclusionDepthTexture, s_texOcclusionDepthSampler, v_146.zy, v_156).x;
    let v_159 = textureSampleLevel(s_texOcclusionDepthTexture, s_texOcclusionDepthSampler, v_146.xw, v_156).x;
    let v_160 = textureSampleLevel(s_texOcclusionDepthTexture, s_texOcclusionDepthSampler, v_154, v_156).x;
    let v_161 = (v_145 <= max(max(v_157, v_158), max(v_159, v_160)));
    if (v_161) {
      _ = atomicAdd(&(drawcallInstanceCount_1.m_1[i32(v_4.w)]), 1u);
    }
    v_2 = v_161;
  } else {
    v_2 = false;
  }
  instancePredicates_1.m_2[v_1] = select(0u, 1u, v_2);
}
