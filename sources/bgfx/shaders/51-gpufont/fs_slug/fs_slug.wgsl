diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(2u) var s_curveDataTexture : texture_2d<f32>;

@group(0u) @binding(3u) var s_bandDataTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_banding : vec4<f32>, v_glyph : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = vec2<i32>(v_glyph.xy);
  let v_2 = vec2<i32>(v_glyph.zw);
  let v_3 = (v_2.y & 255i);
  var v_4 : vec2<i32> = v_2;
  v_4.y = v_3;
  let v_5 = v_4;
  let v_6 = (vec2<f32>(1.0f) / fwidth(v_texcoord0));
  let v_7 = clamp(vec2<i32>(((v_texcoord0 * v_banding.xy) + v_banding.zw)), vec2<i32>(), v_5);
  let v_8 = v_1.x;
  let v_9 = v_1.y;
  let v_10 = textureLoad(s_bandDataTexture, vec3<i32>((v_8 + v_7.y), v_9, 0i).xy, 0i);
  let v_11 = (v_8 + i32((v_10.y + 0.5f)));
  let v_12 = (v_9 + (v_11 >> bitcast<u32>(12i)));
  var v_13 : f32;
  var v_14 : f32;
  {
    var v_15 : f32;
    v_15 = 0.0f;
    var v_16 : f32;
    v_16 = 0.0f;
    var v_17 : i32;
    v_17 = 0i;
    loop {
      var v_18 : f32;
      var v_19 : f32;
      let v_20 = v_17;
      let v_21 = v_16;
      let v_22 = v_15;
      if ((v_20 < i32((v_10.x + 0.5f)))) {
        let v_23 = textureLoad(s_bandDataTexture, vec3<i32>(((v_11 & 4095i) + v_20), v_12, 0i).xy, 0i);
        let v_24 = i32((v_23.x + 0.5f));
        let v_25 = i32((v_23.y + 0.5f));
        let v_26 = v_texcoord0.x;
        let v_27 = v_texcoord0.y;
        let v_28 = (textureLoad(s_curveDataTexture, vec3<i32>(v_24, v_25, 0i).xy, 0i) - vec4<f32>(v_26, v_27, v_26, v_27));
        let v_29 = (textureLoad(s_curveDataTexture, vec3<i32>((v_24 + 1i), v_25, 0i).xy, 0i).xy - v_texcoord0);
        let v_30 = v_28.x;
        let v_31 = v_6.x;
        if (((max(max(v_30, v_28.z), v_29.x) * v_31) < -0.5f)) {
          v_13 = v_21;
          v_14 = v_22;
          break;
        }
        let v_32 = v_28.y;
        let v_33 = select(0i, 1i, (v_32 < 0.0f));
        let v_34 = select(0i, 2i, (v_28.w < 0.0f));
        let v_35 = (11892i >> bitcast<u32>(((v_33 + v_34) + select(0i, 4i, (v_29.y < 0.0f)))));
        let v_36 = (v_35 & 257i);
        var v_37 : f32;
        var v_38 : f32;
        if ((v_36 != 0i)) {
          let v_39 = v_28.xy;
          let v_40 = v_28.zw;
          let v_41 = ((v_39 - (v_40 * 2.0f)) + v_29);
          let v_42 = (v_39 - v_40);
          let v_43 = v_41.y;
          let v_44 = (1.0f / v_43);
          let v_45 = v_42.y;
          let v_46 = sqrt(max(((v_45 * v_45) - (v_43 * v_32)), 0.0f));
          var v_47 : f32;
          var v_48 : f32;
          if ((abs(v_43) < 0.0000152587890625f)) {
            let v_49 = (v_32 * (0.5f / v_45));
            v_47 = v_49;
            v_48 = v_49;
          } else {
            v_47 = ((v_45 + v_46) * v_44);
            v_48 = ((v_45 - v_46) * v_44);
          }
          let v_50 = v_48;
          let v_51 = v_47;
          let v_52 = v_41.x;
          let v_53 = (v_42.x * 2.0f);
          let v_54 = (vec2<f32>(((((v_52 * v_50) - v_53) * v_50) + v_30), ((((v_52 * v_51) - v_53) * v_51) + v_30)) * v_31);
          var v_55 : f32;
          var v_56 : f32;
          if (((v_35 & 1i) != 0i)) {
            let v_57 = v_54.x;
            let v_58 = (v_21 + clamp((v_57 + 0.5f), 0.0f, 1.0f));
            v_55 = max(v_22, clamp((1.0f - (abs(v_57) * 2.0f)), 0.0f, 1.0f));
            v_56 = v_58;
          } else {
            v_55 = v_22;
            v_56 = v_21;
          }
          let v_59 = v_56;
          let v_60 = v_55;
          var v_61 : f32;
          var v_62 : f32;
          if ((v_36 > 1i)) {
            let v_63 = v_54.y;
            let v_64 = (v_59 - clamp((v_63 + 0.5f), 0.0f, 1.0f));
            v_61 = max(v_60, clamp((1.0f - (abs(v_63) * 2.0f)), 0.0f, 1.0f));
            v_62 = v_64;
          } else {
            v_61 = v_60;
            v_62 = v_59;
          }
          let v_65 = v_62;
          v_37 = v_61;
          v_38 = v_65;
        } else {
          v_37 = v_22;
          v_38 = v_21;
        }
        let v_66 = v_38;
        v_18 = v_37;
        v_19 = v_66;
        continue;
      } else {
        v_13 = v_21;
        v_14 = v_22;
        break;
      }

      continuing {
        let v_67 = v_19;
        v_15 = v_18;
        v_16 = v_67;
        v_17 = (v_20 + 1i);
      }
    }
  }
  let v_68 = v_14;
  let v_69 = v_13;
  let v_70 = textureLoad(s_bandDataTexture, vec3<i32>((((v_8 + v_3) + 1i) + v_7.x), v_9, 0i).xy, 0i);
  let v_71 = (v_8 + i32((v_70.y + 0.5f)));
  let v_72 = (v_9 + (v_71 >> bitcast<u32>(12i)));
  var v_73 : f32;
  var v_74 : f32;
  {
    var v_75 : f32;
    v_75 = 0.0f;
    var v_76 : f32;
    v_76 = 0.0f;
    var v_77 : i32;
    v_77 = 0i;
    loop {
      var v_78 : f32;
      var v_79 : f32;
      let v_80 = v_77;
      let v_81 = v_76;
      let v_82 = v_75;
      if ((v_80 < i32((v_70.x + 0.5f)))) {
        let v_83 = textureLoad(s_bandDataTexture, vec3<i32>(((v_71 & 4095i) + v_80), v_72, 0i).xy, 0i);
        let v_84 = i32((v_83.x + 0.5f));
        let v_85 = i32((v_83.y + 0.5f));
        let v_86 = v_texcoord0.x;
        let v_87 = v_texcoord0.y;
        let v_88 = (textureLoad(s_curveDataTexture, vec3<i32>(v_84, v_85, 0i).xy, 0i) - vec4<f32>(v_86, v_87, v_86, v_87));
        let v_89 = (textureLoad(s_curveDataTexture, vec3<i32>((v_84 + 1i), v_85, 0i).xy, 0i).xy - v_texcoord0);
        let v_90 = v_88.y;
        let v_91 = v_6.y;
        if (((max(max(v_90, v_88.w), v_89.y) * v_91) < -0.5f)) {
          v_73 = v_81;
          v_74 = v_82;
          break;
        }
        let v_92 = v_88.x;
        let v_93 = select(0i, 1i, (v_92 < 0.0f));
        let v_94 = select(0i, 2i, (v_88.z < 0.0f));
        let v_95 = (11892i >> bitcast<u32>(((v_93 + v_94) + select(0i, 4i, (v_89.x < 0.0f)))));
        let v_96 = (v_95 & 257i);
        var v_97 : f32;
        var v_98 : f32;
        if ((v_96 != 0i)) {
          let v_99 = v_88.xy;
          let v_100 = v_88.zw;
          let v_101 = ((v_99 - (v_100 * 2.0f)) + v_89);
          let v_102 = (v_99 - v_100);
          let v_103 = v_101.x;
          let v_104 = (1.0f / v_103);
          let v_105 = v_102.x;
          let v_106 = sqrt(max(((v_105 * v_105) - (v_103 * v_92)), 0.0f));
          var v_107 : f32;
          var v_108 : f32;
          if ((abs(v_103) < 0.0000152587890625f)) {
            let v_109 = (v_92 * (0.5f / v_105));
            v_107 = v_109;
            v_108 = v_109;
          } else {
            v_107 = ((v_105 + v_106) * v_104);
            v_108 = ((v_105 - v_106) * v_104);
          }
          let v_110 = v_108;
          let v_111 = v_107;
          let v_112 = v_101.y;
          let v_113 = (v_102.y * 2.0f);
          let v_114 = (vec2<f32>(((((v_112 * v_110) - v_113) * v_110) + v_90), ((((v_112 * v_111) - v_113) * v_111) + v_90)) * v_91);
          var v_115 : f32;
          var v_116 : f32;
          if (((v_95 & 1i) != 0i)) {
            let v_117 = v_114.x;
            let v_118 = (v_81 - clamp((v_117 + 0.5f), 0.0f, 1.0f));
            v_115 = max(v_82, clamp((1.0f - (abs(v_117) * 2.0f)), 0.0f, 1.0f));
            v_116 = v_118;
          } else {
            v_115 = v_82;
            v_116 = v_81;
          }
          let v_119 = v_116;
          let v_120 = v_115;
          var v_121 : f32;
          var v_122 : f32;
          if ((v_96 > 1i)) {
            let v_123 = v_114.y;
            let v_124 = (v_119 + clamp((v_123 + 0.5f), 0.0f, 1.0f));
            v_121 = max(v_120, clamp((1.0f - (abs(v_123) * 2.0f)), 0.0f, 1.0f));
            v_122 = v_124;
          } else {
            v_121 = v_120;
            v_122 = v_119;
          }
          let v_125 = v_122;
          v_97 = v_121;
          v_98 = v_125;
        } else {
          v_97 = v_82;
          v_98 = v_81;
        }
        let v_126 = v_98;
        v_78 = v_97;
        v_79 = v_126;
        continue;
      } else {
        v_73 = v_81;
        v_74 = v_82;
        break;
      }

      continuing {
        let v_127 = v_79;
        v_75 = v_78;
        v_76 = v_127;
        v_77 = (v_80 + 1i);
      }
    }
  }
  let v_128 = v_74;
  let v_129 = v_73;
  let v_130 = clamp(max((abs(((v_69 * v_68) + (v_129 * v_128))) / max((v_68 + v_128), 0.0000152587890625f)), min(abs(v_69), abs(v_129))), 0.0f, 1.0f);
  let v_131 = bitcast<u32>(v.u_params.x);
  let v_132 = (vec4<f32>(f32(((v_131 >> bitcast<u32>(24i)) & 255u)), f32(((v_131 >> bitcast<u32>(16i)) & 255u)), f32(((v_131 >> bitcast<u32>(8i)) & 255u)), f32((v_131 & 255u))) * vec4<f32>(0.0039215688593685627f));
  let v_133 = bitcast<u32>(v.u_params.y);
  bgfx_FragData0 = mix((vec4<f32>(f32(((v_133 >> bitcast<u32>(24i)) & 255u)), f32(((v_133 >> bitcast<u32>(16i)) & 255u)), f32(((v_133 >> bitcast<u32>(8i)) & 255u)), f32((v_133 & 255u))) * vec4<f32>(0.0039215688593685627f)), v_132, vec4<f32>(v_130, v_130, v_130, v_130));
}

@fragment
fn main(@location(0u) @interpolate(flat) v_banding : vec4<f32>, @location(1u) @interpolate(flat) v_glyph : vec4<f32>, @location(2u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_banding, v_glyph, v_texcoord0);
  return bgfx_FragData0;
}
