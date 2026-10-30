diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(22u) var s_shadowMap0Sampler : sampler;

@group(0u) @binding(6u) var s_shadowMap0Texture : texture_2d<f32>;

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
  u_tetraNormalGreen : vec4<f32>,
  u_tetraNormalYellow : vec4<f32>,
  u_tetraNormalBlue : vec4<f32>,
  u_tetraNormalRed : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_position : vec4<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = v_position.xyz;
  let v_2 = dot(v.u_tetraNormalGreen.xyz, v_1);
  let v_3 = dot(v.u_tetraNormalYellow.xyz, v_1);
  let v_4 = dot(v.u_tetraNormalBlue.xyz, v_1);
  let v_5 = dot(v.u_tetraNormalRed.xyz, v_1);
  let v_6 = max(max(v_2, v_3), max(v_4, v_5));
  var v_7 : vec4<f32>;
  var v_8 : vec3<f32>;
  if ((v_2 == v_6)) {
    let v_9 = v_texcoord1.w;
    let v_10 = (v_texcoord1.xy / vec2<f32>(v_9, v_9));
    let v_11 = select(0.0f, 0.30000001192092895508f, (all((v_10 > vec2<f32>())) & all((v_10 < vec2<f32>(1.0f)))));
    let v_12 = -(v_11);
    v_7 = v_texcoord1;
    v_8 = vec3<f32>(v_12, v_11, v_12);
  } else {
    var v_13 : vec4<f32>;
    var v_14 : vec3<f32>;
    if ((v_3 == v_6)) {
      let v_15 = v_texcoord2.w;
      let v_16 = (v_texcoord2.xy / vec2<f32>(v_15, v_15));
      let v_17 = select(0.0f, 0.30000001192092895508f, (all((v_16 > vec2<f32>())) & all((v_16 < vec2<f32>(1.0f)))));
      v_13 = v_texcoord2;
      v_14 = vec3<f32>(v_17, v_17, -(v_17));
    } else {
      let v_18 = (v_4 == v_6);
      var v_19 : vec3<f32>;
      if (v_18) {
        let v_20 = v_texcoord3.w;
        let v_21 = (v_texcoord3.xy / vec2<f32>(v_20, v_20));
        let v_22 = select(0.0f, 0.30000001192092895508f, (all((v_21 > vec2<f32>())) & all((v_21 < vec2<f32>(1.0f)))));
        let v_23 = -(v_22);
        v_19 = vec3<f32>(v_23, v_23, v_22);
      } else {
        let v_24 = v_texcoord4.w;
        let v_25 = (v_texcoord4.xy / vec2<f32>(v_24, v_24));
        let v_26 = select(0.0f, 0.30000001192092895508f, (all((v_25 > vec2<f32>())) & all((v_25 < vec2<f32>(1.0f)))));
        let v_27 = -(v_26);
        v_19 = vec3<f32>(v_26, v_27, v_27);
      }
      let v_28 = v_19;
      v_13 = select(v_texcoord4, v_texcoord3, vec4<bool>(v_18, v_18, v_18, v_18));
      v_14 = v_28;
    }
    let v_29 = v_14;
    v_7 = v_13;
    v_8 = v_29;
  }
  let v_30 = v_8;
  let v_31 = v_7;
  let v_32 = v.u_params1.x;
  let v_33 = v.u_smSamplingParams;
  let v_34 = v_31.w;
  let v_35 = (v_31.xy / vec2<f32>(v_34, v_34));
  let v_36 = v_31.z;
  let v_37 = vec4<f32>(v_35.x, v_35.y, v_36, 1.0f);
  var v_38 : f32;
  switch(0u) {
    default: {
      let v_39 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
      let v_40 = sin(v_39);
      let v_41 = cos(v_39);
      let v_42 = (v_36 - v_32);
      var v_43 : i32;
      var v_44 : f32;
      {
        var v_45 : f32;
        v_45 = 0.0f;
        var v_46 : i32;
        v_46 = 0i;
        var v_47 : i32;
        v_47 = 0i;
        loop {
          var v_48 : f32;
          var v_49 : i32;
          let v_50 = v_47;
          let v_51 = v_46;
          let v_52 = v_45;
          if ((v_50 < 16i)) {
            let v_53 = f32(v_50);
            let v_54 = sqrt(((v_53 + 0.5f) * 0.10000000149011611938f));
            let v_55 = (v_53 * 2.39996314048767089844f);
            let v_56 = (vec2<f32>(cos(v_55), sin(v_55)) * v_54);
            let v_57 = v_56.x;
            let v_58 = v_56.y;
            let v_59 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, (v_37.xy + (vec2<f32>(((v_57 * v_41) - (v_58 * v_40)), ((v_57 * v_40) + (v_58 * v_41))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
            var v_60 : f32;
            var v_61 : i32;
            if ((v_59 < v_42)) {
              v_60 = (v_52 + v_59);
              v_61 = (v_51 + 1i);
            } else {
              v_60 = v_52;
              v_61 = v_51;
            }
            let v_62 = v_61;
            v_48 = v_60;
            v_49 = v_62;
            continue;
          } else {
            v_43 = v_51;
            v_44 = v_52;
            break;
          }

          continuing {
            let v_63 = v_49;
            v_45 = v_48;
            v_46 = v_63;
            v_47 = (v_50 + 1i);
          }
        }
      }
      let v_64 = v_44;
      let v_65 = v_43;
      var v_66 : f32;
      if ((v_65 > 0i)) {
        v_66 = (v_64 / f32(v_65));
      } else {
        v_66 = -1.0f;
      }
      let v_67 = v_66;
      if ((v_67 < -0.99000000953674316406f)) {
        v_38 = 1.0f;
        break;
      }
      let v_68 = max(0.0f, (v_42 - v_67));
      let v_69 = vec2<f32>(clamp(((v_33.z * v_68) / v_67), 0.0f, 0.25f), clamp(((v_33.w * v_68) / v_67), 0.0f, 0.25f));
      var v_70 : f32;
      {
        var v_71 : f32;
        v_71 = 0.0f;
        var v_72 : i32;
        v_72 = 0i;
        loop {
          var v_73 : f32;
          let v_74 = v_72;
          let v_75 = v_71;
          if ((v_74 < 16i)) {
            let v_76 = f32(v_74);
            let v_77 = sqrt(((v_76 + 0.5f) * 0.10000000149011611938f));
            let v_78 = (v_76 * 2.39996314048767089844f);
            let v_79 = (vec2<f32>(cos(v_78), sin(v_78)) * v_77);
            let v_80 = v_79.x;
            let v_81 = v_79.y;
            let v_82 = (vec2<f32>(((v_80 * v_41) - (v_81 * v_40)), ((v_80 * v_40) + (v_81 * v_41))) * v_69);
            let v_83 = (v_37 + vec4<f32>(v_82.x, v_82.y, 0.0f, 0.0f));
            var v_84 : f32;
            switch(0u) {
              default: {
                let v_85 = v_83.w;
                let v_86 = (v_83.xy / vec2<f32>(v_85, v_85));
                if ((any((v_86 > vec2<f32>(1.0f))) | any((v_86 < vec2<f32>())))) {
                  v_84 = 1.0f;
                  break;
                }
                v_84 = step(((v_83.z - v_32) / v_85), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_86, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
              }
            }
            v_73 = (v_75 + v_84);
            continue;
          } else {
            v_70 = v_75;
            break;
          }

          continuing {
            v_71 = v_73;
            v_72 = (v_74 + 1i);
          }
        }
      }
      v_38 = mix(1.0f, (v_70 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_65) * 0.0625f)));
    }
  }
  let v_87 = v_38;
  let v_88 = -(normalize(v_view));
  let v_89 = v.u_lightPosition;
  let v_90 = v.u_lightSpotDirectionInner.xyz;
  let v_91 = v.u_lightSpotDirectionInner.w;
  let v_92 = v.u_lightAttenuationSpotOuter.w;
  let v_93 = v.u_lightAttenuationSpotOuter;
  let v_94 = v_89.xyz;
  let v_95 = -(normalize(v_94));
  var v_96 : vec3<f32>;
  var v_97 : f32;
  if (!((0.0f == v_89.w))) {
    let v_98 = (v_94 - v_view);
    let v_99 = normalize(v_98);
    let v_100 = max(0.0f, dot(-(v_99), normalize(v_90)));
    let v_101 = cos(radians(v_92));
    let v_102 = clamp(((v_100 - v_101) / (cos(radians(min(v_91, (v_92 - 0.00100000004749745131f)))) - v_101)), 0.0f, 1.0f);
    let v_103 = length(v_98);
    let v_104 = ((1.0f / ((v_93.x + (v_93.y * v_103)) + ((v_93.z * v_103) * v_103))) * mix(v_102, 1.0f, step(90.0f, v_92)));
    v_96 = v_99;
    v_97 = v_104;
  } else {
    v_96 = v_95;
    v_97 = 1.0f;
  }
  let v_105 = v_97;
  let v_106 = v_96;
  let v_107 = v.u_materialKs.w;
  let v_108 = dot(v_normal, v_106);
  let v_109 = dot(((v_normal * (2.0f * v_108)) - v_106), v_88);
  let v_110 = (max(vec2<f32>(v_108, (((step(0.0f, v_108) * pow(max(0.0f, v_109), v_107)) * (2.0f + v_107)) * 0.125f)), vec2<f32>()) * v_105);
  let v_111 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_112 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_110.x);
  let v_113 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_110.y);
  let v_114 = length(v_view);
  let v_115 = clamp((1.0f / exp2((((0.0000122500005090842f * v_114) * v_114) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_116 = v.u_color.xyz;
  let v_117 = mix(vec3<f32>(), (pow(abs(abs(((v_111 * v_116) + (((v_112 + v_113) * v_116) * v_87)))), vec3<f32>(0.45454546809196472168f)) + (v_30 * v.u_params2.y)), vec3<f32>(v_115, v_115, v_115));
  bgfx_FragData0 = vec4<f32>(v_117.x, v_117.y, v_117.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_position : vec4<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_position, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
