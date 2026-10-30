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
  var v_34 : f32;
  switch(0u) {
    default: {
      let v_35 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
      let v_36 = sin(v_35);
      let v_37 = cos(v_35);
      let v_38 = v_31.w;
      let v_39 = ((v_31.z / v_38) - v_32);
      var v_40 : i32;
      var v_41 : f32;
      {
        var v_42 : f32;
        v_42 = 0.0f;
        var v_43 : i32;
        v_43 = 0i;
        var v_44 : i32;
        v_44 = 0i;
        loop {
          var v_45 : f32;
          var v_46 : i32;
          let v_47 = v_44;
          let v_48 = v_43;
          let v_49 = v_42;
          if ((v_47 < 16i)) {
            let v_50 = f32(v_47);
            let v_51 = sqrt(((v_50 + 0.5f) * 0.10000000149011611938f));
            let v_52 = (v_50 * 2.39996314048767089844f);
            let v_53 = (vec2<f32>(cos(v_52), sin(v_52)) * v_51);
            let v_54 = v_53.x;
            let v_55 = v_53.y;
            let v_56 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, ((v_31.xy / vec2<f32>(v_38, v_38)) + (vec2<f32>(((v_54 * v_37) - (v_55 * v_36)), ((v_54 * v_36) + (v_55 * v_37))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
            var v_57 : f32;
            var v_58 : i32;
            if ((v_56 < v_39)) {
              v_57 = (v_49 + v_56);
              v_58 = (v_48 + 1i);
            } else {
              v_57 = v_49;
              v_58 = v_48;
            }
            let v_59 = v_58;
            v_45 = v_57;
            v_46 = v_59;
            continue;
          } else {
            v_40 = v_48;
            v_41 = v_49;
            break;
          }

          continuing {
            let v_60 = v_46;
            v_42 = v_45;
            v_43 = v_60;
            v_44 = (v_47 + 1i);
          }
        }
      }
      let v_61 = v_41;
      let v_62 = v_40;
      var v_63 : f32;
      if ((v_62 > 0i)) {
        v_63 = (v_61 / f32(v_62));
      } else {
        v_63 = -1.0f;
      }
      let v_64 = v_63;
      if ((v_64 < -0.99000000953674316406f)) {
        v_34 = 1.0f;
        break;
      }
      let v_65 = max(0.0f, (v_39 - v_64));
      let v_66 = vec2<f32>(clamp(((v_33.z * v_65) / v_64), 0.0f, 0.25f), clamp(((v_33.w * v_65) / v_64), 0.0f, 0.25f));
      var v_67 : f32;
      {
        var v_68 : f32;
        v_68 = 0.0f;
        var v_69 : i32;
        v_69 = 0i;
        loop {
          var v_70 : f32;
          let v_71 = v_69;
          let v_72 = v_68;
          if ((v_71 < 16i)) {
            let v_73 = f32(v_71);
            let v_74 = sqrt(((v_73 + 0.5f) * 0.10000000149011611938f));
            let v_75 = (v_73 * 2.39996314048767089844f);
            let v_76 = (vec2<f32>(cos(v_75), sin(v_75)) * v_74);
            let v_77 = v_76.x;
            let v_78 = v_76.y;
            let v_79 = (vec2<f32>(((v_77 * v_37) - (v_78 * v_36)), ((v_77 * v_36) + (v_78 * v_37))) * v_66);
            let v_80 = (v_31 + vec4<f32>(v_79.x, v_79.y, 0.0f, 0.0f));
            var v_81 : f32;
            switch(0u) {
              default: {
                let v_82 = v_80.w;
                let v_83 = (v_80.xy / vec2<f32>(v_82, v_82));
                if ((any((v_83 > vec2<f32>(1.0f))) | any((v_83 < vec2<f32>())))) {
                  v_81 = 1.0f;
                  break;
                }
                v_81 = step(((v_80.z - v_32) / v_82), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_83, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
              }
            }
            v_70 = (v_72 + v_81);
            continue;
          } else {
            v_67 = v_72;
            break;
          }

          continuing {
            v_68 = v_70;
            v_69 = (v_71 + 1i);
          }
        }
      }
      v_34 = mix(1.0f, (v_67 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_62) * 0.0625f)));
    }
  }
  let v_84 = v_34;
  let v_85 = -(normalize(v_view));
  let v_86 = v.u_lightPosition;
  let v_87 = v.u_lightSpotDirectionInner.xyz;
  let v_88 = v.u_lightSpotDirectionInner.w;
  let v_89 = v.u_lightAttenuationSpotOuter.w;
  let v_90 = v.u_lightAttenuationSpotOuter;
  let v_91 = v_86.xyz;
  let v_92 = -(normalize(v_91));
  var v_93 : vec3<f32>;
  var v_94 : f32;
  if (!((0.0f == v_86.w))) {
    let v_95 = (v_91 - v_view);
    let v_96 = normalize(v_95);
    let v_97 = max(0.0f, dot(-(v_96), normalize(v_87)));
    let v_98 = cos(radians(v_89));
    let v_99 = clamp(((v_97 - v_98) / (cos(radians(min(v_88, (v_89 - 0.00100000004749745131f)))) - v_98)), 0.0f, 1.0f);
    let v_100 = length(v_95);
    let v_101 = ((1.0f / ((v_90.x + (v_90.y * v_100)) + ((v_90.z * v_100) * v_100))) * mix(v_99, 1.0f, step(90.0f, v_89)));
    v_93 = v_96;
    v_94 = v_101;
  } else {
    v_93 = v_92;
    v_94 = 1.0f;
  }
  let v_102 = v_94;
  let v_103 = v_93;
  let v_104 = v.u_materialKs.w;
  let v_105 = dot(v_normal, v_103);
  let v_106 = dot(((v_normal * (2.0f * v_105)) - v_103), v_85);
  let v_107 = (max(vec2<f32>(v_105, (((step(0.0f, v_105) * pow(max(0.0f, v_106), v_104)) * (2.0f + v_104)) * 0.125f)), vec2<f32>()) * v_102);
  let v_108 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_109 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_107.x);
  let v_110 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_107.y);
  let v_111 = length(v_view);
  let v_112 = clamp((1.0f / exp2((((0.0000122500005090842f * v_111) * v_111) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_113 = v.u_color.xyz;
  let v_114 = mix(vec3<f32>(), (pow(abs(abs(((v_108 * v_113) + (((v_109 + v_110) * v_113) * v_84)))), vec3<f32>(0.45454546809196472168f)) + (v_30 * v.u_params2.y)), vec3<f32>(v_112, v_112, v_112));
  bgfx_FragData0 = vec4<f32>(v_114.x, v_114.y, v_114.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_position : vec4<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_position, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
