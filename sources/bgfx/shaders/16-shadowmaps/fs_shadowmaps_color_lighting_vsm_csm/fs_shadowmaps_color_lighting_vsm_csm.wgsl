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
    var v_17 : f32;
    switch(0u) {
      default: {
        if ((any((v_2 > vec2<f32>(1.0f))) | any((v_2 < vec2<f32>())))) {
          v_17 = 1.0f;
          break;
        }
        let v_18 = (((v_texcoord1.z - v_14) / v_1) * v_15);
        let v_19 = textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_2);
        let v_20 = (vec2<f32>(dot(v_19.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_19.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_15);
        let v_21 = v_20.x;
        if ((v_18 < v_21)) {
          v_17 = 1.0f;
          break;
        }
        let v_22 = max((v_20.y - (v_21 * v_21)), v_16);
        let v_23 = (v_18 - v_21);
        v_17 = (v_22 / (v_22 + (v_23 * v_23)));
      }
    }
    let v_24 = v_17;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_24;
  } else {
    var v_25 : vec3<f32>;
    var v_26 : f32;
    if (v_8) {
      let v_27 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_28 = v.u_params1.x;
      let v_29 = v.u_params1.w;
      let v_30 = v.u_params1.z;
      var v_31 : f32;
      switch(0u) {
        default: {
          if ((any((v_4 > vec2<f32>(1.0f))) | any((v_4 < vec2<f32>())))) {
            v_31 = 1.0f;
            break;
          }
          let v_32 = (((v_texcoord2.z - v_28) / v_3) * v_29);
          let v_33 = textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, v_4);
          let v_34 = (vec2<f32>(dot(v_33.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_33.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_29);
          let v_35 = v_34.x;
          if ((v_32 < v_35)) {
            v_31 = 1.0f;
            break;
          }
          let v_36 = max((v_34.y - (v_35 * v_35)), v_30);
          let v_37 = (v_32 - v_35);
          v_31 = (v_36 / (v_36 + (v_37 * v_37)));
        }
      }
      let v_38 = v_31;
      v_25 = vec3<f32>(v_27, v_27, -(v_27));
      v_26 = v_38;
    } else {
      var v_39 : vec3<f32>;
      var v_40 : f32;
      if (v_9) {
        let v_41 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_42 = -(v_41);
        let v_43 = v.u_params1.x;
        let v_44 = v.u_params1.w;
        let v_45 = v.u_params1.z;
        var v_46 : f32;
        switch(0u) {
          default: {
            if ((any((v_6 > vec2<f32>(1.0f))) | any((v_6 < vec2<f32>())))) {
              v_46 = 1.0f;
              break;
            }
            let v_47 = (((v_texcoord3.z - v_43) / v_5) * v_44);
            let v_48 = textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, v_6);
            let v_49 = (vec2<f32>(dot(v_48.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_48.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_44);
            let v_50 = v_49.x;
            if ((v_47 < v_50)) {
              v_46 = 1.0f;
              break;
            }
            let v_51 = max((v_49.y - (v_50 * v_50)), v_45);
            let v_52 = (v_47 - v_50);
            v_46 = (v_51 / (v_51 + (v_52 * v_52)));
          }
        }
        let v_53 = v_46;
        v_39 = vec3<f32>(v_42, v_42, v_41);
        v_40 = v_53;
      } else {
        let v_54 = v_texcoord4.w;
        let v_55 = (v_texcoord4.xy / vec2<f32>(v_54, v_54));
        let v_56 = select(0.0f, 0.40000000596046447754f, (all((v_55 > vec2<f32>())) & all((v_55 < vec2<f32>(1.0f)))));
        let v_57 = -(v_56);
        let v_58 = v.u_params1.x;
        let v_59 = v.u_params1.w;
        let v_60 = v.u_params1.z;
        var v_61 : f32;
        switch(0u) {
          default: {
            if ((any((v_55 > vec2<f32>(1.0f))) | any((v_55 < vec2<f32>())))) {
              v_61 = 1.0f;
              break;
            }
            let v_62 = (((v_texcoord4.z - v_58) / v_54) * v_59);
            let v_63 = textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, v_55);
            let v_64 = (vec2<f32>(dot(v_63.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_63.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_59);
            let v_65 = v_64.x;
            if ((v_62 < v_65)) {
              v_61 = 1.0f;
              break;
            }
            let v_66 = max((v_64.y - (v_65 * v_65)), v_60);
            let v_67 = (v_62 - v_65);
            v_61 = (v_66 / (v_66 + (v_67 * v_67)));
          }
        }
        let v_68 = v_61;
        v_39 = vec3<f32>(v_56, v_57, v_57);
        v_40 = v_68;
      }
      let v_69 = v_40;
      v_25 = v_39;
      v_26 = v_69;
    }
    let v_70 = v_26;
    v_10 = v_25;
    v_11 = v_70;
  }
  let v_71 = v_11;
  let v_72 = v_10;
  let v_73 = -(normalize(v_view));
  let v_74 = v.u_lightPosition;
  let v_75 = v.u_lightSpotDirectionInner.xyz;
  let v_76 = v.u_lightSpotDirectionInner.w;
  let v_77 = v.u_lightAttenuationSpotOuter.w;
  let v_78 = v.u_lightAttenuationSpotOuter;
  let v_79 = v_74.xyz;
  let v_80 = -(normalize(v_79));
  var v_81 : vec3<f32>;
  var v_82 : f32;
  if (!((0.0f == v_74.w))) {
    let v_83 = (v_79 - v_view);
    let v_84 = normalize(v_83);
    let v_85 = max(0.0f, dot(-(v_84), normalize(v_75)));
    let v_86 = cos(radians(v_77));
    let v_87 = clamp(((v_85 - v_86) / (cos(radians(min(v_76, (v_77 - 0.00100000004749745131f)))) - v_86)), 0.0f, 1.0f);
    let v_88 = length(v_83);
    let v_89 = ((1.0f / ((v_78.x + (v_78.y * v_88)) + ((v_78.z * v_88) * v_88))) * mix(v_87, 1.0f, step(90.0f, v_77)));
    v_81 = v_84;
    v_82 = v_89;
  } else {
    v_81 = v_80;
    v_82 = 1.0f;
  }
  let v_90 = v_82;
  let v_91 = v_81;
  let v_92 = v.u_materialKs.w;
  let v_93 = dot(v_normal, v_91);
  let v_94 = dot(((v_normal * (2.0f * v_93)) - v_91), v_73);
  let v_95 = (max(vec2<f32>(v_93, (((step(0.0f, v_93) * pow(max(0.0f, v_94), v_92)) * (2.0f + v_92)) * 0.125f)), vec2<f32>()) * v_90);
  let v_96 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_97 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_95.x);
  let v_98 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_95.y);
  let v_99 = length(v_view);
  let v_100 = clamp((1.0f / exp2((((0.0000122500005090842f * v_99) * v_99) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_101 = v.u_color.xyz;
  let v_102 = mix(vec3<f32>(), (pow(abs(abs(((v_96 * v_101) + (((v_97 + v_98) * v_101) * v_71)))), vec3<f32>(0.45454546809196472168f)) + (v_72 * v.u_params2.y)), vec3<f32>(v_100, v_100, v_100));
  bgfx_FragData0 = vec4<f32>(v_102.x, v_102.y, v_102.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
