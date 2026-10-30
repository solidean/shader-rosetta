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
    let v_15 = v_texcoord1.z;
    let v_16 = (v.u_params1.w * v.u_params1.z);
    var v_17 : f32;
    switch(0u) {
      default: {
        let v_18 = vec4<f32>(v_2.x, v_2.y, v_15, 1.0f).xy;
        if ((any((v_18 > vec2<f32>(1.0f))) | any((v_18 < vec2<f32>())))) {
          v_17 = 1.0f;
          break;
        }
        v_17 = clamp(exp((v_16 * (dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_18), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - (v_15 - v_14)))), 0.0f, 1.0f);
      }
    }
    let v_19 = v_17;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_19;
  } else {
    var v_20 : vec3<f32>;
    var v_21 : f32;
    if (v_8) {
      let v_22 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_23 = v.u_params1.x;
      let v_24 = v_texcoord2.z;
      let v_25 = (v.u_params1.w * v.u_params1.z);
      var v_26 : f32;
      switch(0u) {
        default: {
          let v_27 = vec4<f32>(v_4.x, v_4.y, v_24, 1.0f).xy;
          if ((any((v_27 > vec2<f32>(1.0f))) | any((v_27 < vec2<f32>())))) {
            v_26 = 1.0f;
            break;
          }
          v_26 = clamp(exp((v_25 * (dot(textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, v_27), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - (v_24 - v_23)))), 0.0f, 1.0f);
        }
      }
      let v_28 = v_26;
      v_20 = vec3<f32>(v_22, v_22, -(v_22));
      v_21 = v_28;
    } else {
      var v_29 : vec3<f32>;
      var v_30 : f32;
      if (v_9) {
        let v_31 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_32 = -(v_31);
        let v_33 = v.u_params1.x;
        let v_34 = v_texcoord3.z;
        let v_35 = (v.u_params1.w * v.u_params1.z);
        var v_36 : f32;
        switch(0u) {
          default: {
            let v_37 = vec4<f32>(v_6.x, v_6.y, v_34, 1.0f).xy;
            if ((any((v_37 > vec2<f32>(1.0f))) | any((v_37 < vec2<f32>())))) {
              v_36 = 1.0f;
              break;
            }
            v_36 = clamp(exp((v_35 * (dot(textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, v_37), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - (v_34 - v_33)))), 0.0f, 1.0f);
          }
        }
        let v_38 = v_36;
        v_29 = vec3<f32>(v_32, v_32, v_31);
        v_30 = v_38;
      } else {
        let v_39 = v_texcoord4.w;
        let v_40 = (v_texcoord4.xy / vec2<f32>(v_39, v_39));
        let v_41 = select(0.0f, 0.40000000596046447754f, (all((v_40 > vec2<f32>())) & all((v_40 < vec2<f32>(1.0f)))));
        let v_42 = -(v_41);
        let v_43 = v.u_params1.x;
        let v_44 = v_texcoord4.z;
        let v_45 = (v.u_params1.w * v.u_params1.z);
        var v_46 : f32;
        switch(0u) {
          default: {
            let v_47 = vec4<f32>(v_40.x, v_40.y, v_44, 1.0f).xy;
            if ((any((v_47 > vec2<f32>(1.0f))) | any((v_47 < vec2<f32>())))) {
              v_46 = 1.0f;
              break;
            }
            v_46 = clamp(exp((v_45 * (dot(textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, v_47), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - (v_44 - v_43)))), 0.0f, 1.0f);
          }
        }
        let v_48 = v_46;
        v_29 = vec3<f32>(v_41, v_42, v_42);
        v_30 = v_48;
      }
      let v_49 = v_30;
      v_20 = v_29;
      v_21 = v_49;
    }
    let v_50 = v_21;
    v_10 = v_20;
    v_11 = v_50;
  }
  let v_51 = v_11;
  let v_52 = v_10;
  let v_53 = -(normalize(v_view));
  let v_54 = v.u_lightPosition;
  let v_55 = v.u_lightSpotDirectionInner.xyz;
  let v_56 = v.u_lightSpotDirectionInner.w;
  let v_57 = v.u_lightAttenuationSpotOuter.w;
  let v_58 = v.u_lightAttenuationSpotOuter;
  let v_59 = v_54.xyz;
  let v_60 = -(normalize(v_59));
  var v_61 : vec3<f32>;
  var v_62 : f32;
  if (!((0.0f == v_54.w))) {
    let v_63 = (v_59 - v_view);
    let v_64 = normalize(v_63);
    let v_65 = max(0.0f, dot(-(v_64), normalize(v_55)));
    let v_66 = cos(radians(v_57));
    let v_67 = clamp(((v_65 - v_66) / (cos(radians(min(v_56, (v_57 - 0.00100000004749745131f)))) - v_66)), 0.0f, 1.0f);
    let v_68 = length(v_63);
    let v_69 = ((1.0f / ((v_58.x + (v_58.y * v_68)) + ((v_58.z * v_68) * v_68))) * mix(v_67, 1.0f, step(90.0f, v_57)));
    v_61 = v_64;
    v_62 = v_69;
  } else {
    v_61 = v_60;
    v_62 = 1.0f;
  }
  let v_70 = v_62;
  let v_71 = v_61;
  let v_72 = v.u_materialKs.w;
  let v_73 = dot(v_normal, v_71);
  let v_74 = dot(((v_normal * (2.0f * v_73)) - v_71), v_53);
  let v_75 = (max(vec2<f32>(v_73, (((step(0.0f, v_73) * pow(max(0.0f, v_74), v_72)) * (2.0f + v_72)) * 0.125f)), vec2<f32>()) * v_70);
  let v_76 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_77 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_75.x);
  let v_78 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_75.y);
  let v_79 = length(v_view);
  let v_80 = clamp((1.0f / exp2((((0.0000122500005090842f * v_79) * v_79) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_81 = v.u_color.xyz;
  let v_82 = mix(vec3<f32>(), (pow(abs(abs(((v_76 * v_81) + (((v_77 + v_78) * v_81) * v_51)))), vec3<f32>(0.45454546809196472168f)) + (v_52 * v.u_params2.y)), vec3<f32>(v_80, v_80, v_80));
  bgfx_FragData0 = vec4<f32>(v_82.x, v_82.y, v_82.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
