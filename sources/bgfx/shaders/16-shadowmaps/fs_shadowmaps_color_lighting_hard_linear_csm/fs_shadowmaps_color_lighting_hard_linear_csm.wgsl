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
    var v_16 : f32;
    switch(0u) {
      default: {
        let v_17 = vec4<f32>(v_2.x, v_2.y, v_15, 1.0f).xy;
        if ((any((v_17 > vec2<f32>(1.0f))) | any((v_17 < vec2<f32>())))) {
          v_16 = 1.0f;
          break;
        }
        v_16 = step((v_15 - v_14), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_17, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
      }
    }
    let v_18 = v_16;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_18;
  } else {
    var v_19 : vec3<f32>;
    var v_20 : f32;
    if (v_8) {
      let v_21 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_22 = v.u_params1.x;
      let v_23 = v_texcoord2.z;
      var v_24 : f32;
      switch(0u) {
        default: {
          let v_25 = vec4<f32>(v_4.x, v_4.y, v_23, 1.0f).xy;
          if ((any((v_25 > vec2<f32>(1.0f))) | any((v_25 < vec2<f32>())))) {
            v_24 = 1.0f;
            break;
          }
          v_24 = step((v_23 - v_22), dot(textureSampleLevel(s_shadowMap1Texture, s_shadowMap1Sampler, v_25, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
        }
      }
      let v_26 = v_24;
      v_19 = vec3<f32>(v_21, v_21, -(v_21));
      v_20 = v_26;
    } else {
      var v_27 : vec3<f32>;
      var v_28 : f32;
      if (v_9) {
        let v_29 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_30 = -(v_29);
        let v_31 = v.u_params1.x;
        let v_32 = v_texcoord3.z;
        var v_33 : f32;
        switch(0u) {
          default: {
            let v_34 = vec4<f32>(v_6.x, v_6.y, v_32, 1.0f).xy;
            if ((any((v_34 > vec2<f32>(1.0f))) | any((v_34 < vec2<f32>())))) {
              v_33 = 1.0f;
              break;
            }
            v_33 = step((v_32 - v_31), dot(textureSampleLevel(s_shadowMap2Texture, s_shadowMap2Sampler, v_34, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        let v_35 = v_33;
        v_27 = vec3<f32>(v_30, v_30, v_29);
        v_28 = v_35;
      } else {
        let v_36 = v_texcoord4.w;
        let v_37 = (v_texcoord4.xy / vec2<f32>(v_36, v_36));
        let v_38 = select(0.0f, 0.40000000596046447754f, (all((v_37 > vec2<f32>())) & all((v_37 < vec2<f32>(1.0f)))));
        let v_39 = -(v_38);
        let v_40 = v.u_params1.x;
        let v_41 = v_texcoord4.z;
        var v_42 : f32;
        switch(0u) {
          default: {
            let v_43 = vec4<f32>(v_37.x, v_37.y, v_41, 1.0f).xy;
            if ((any((v_43 > vec2<f32>(1.0f))) | any((v_43 < vec2<f32>())))) {
              v_42 = 1.0f;
              break;
            }
            v_42 = step((v_41 - v_40), dot(textureSampleLevel(s_shadowMap3Texture, s_shadowMap3Sampler, v_43, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        let v_44 = v_42;
        v_27 = vec3<f32>(v_38, v_39, v_39);
        v_28 = v_44;
      }
      let v_45 = v_28;
      v_19 = v_27;
      v_20 = v_45;
    }
    let v_46 = v_20;
    v_10 = v_19;
    v_11 = v_46;
  }
  let v_47 = v_11;
  let v_48 = v_10;
  let v_49 = -(normalize(v_view));
  let v_50 = v.u_lightPosition;
  let v_51 = v.u_lightSpotDirectionInner.xyz;
  let v_52 = v.u_lightSpotDirectionInner.w;
  let v_53 = v.u_lightAttenuationSpotOuter.w;
  let v_54 = v.u_lightAttenuationSpotOuter;
  let v_55 = v_50.xyz;
  let v_56 = -(normalize(v_55));
  var v_57 : vec3<f32>;
  var v_58 : f32;
  if (!((0.0f == v_50.w))) {
    let v_59 = (v_55 - v_view);
    let v_60 = normalize(v_59);
    let v_61 = max(0.0f, dot(-(v_60), normalize(v_51)));
    let v_62 = cos(radians(v_53));
    let v_63 = clamp(((v_61 - v_62) / (cos(radians(min(v_52, (v_53 - 0.00100000004749745131f)))) - v_62)), 0.0f, 1.0f);
    let v_64 = length(v_59);
    let v_65 = ((1.0f / ((v_54.x + (v_54.y * v_64)) + ((v_54.z * v_64) * v_64))) * mix(v_63, 1.0f, step(90.0f, v_53)));
    v_57 = v_60;
    v_58 = v_65;
  } else {
    v_57 = v_56;
    v_58 = 1.0f;
  }
  let v_66 = v_58;
  let v_67 = v_57;
  let v_68 = v.u_materialKs.w;
  let v_69 = dot(v_normal, v_67);
  let v_70 = dot(((v_normal * (2.0f * v_69)) - v_67), v_49);
  let v_71 = (max(vec2<f32>(v_69, (((step(0.0f, v_69) * pow(max(0.0f, v_70), v_68)) * (2.0f + v_68)) * 0.125f)), vec2<f32>()) * v_66);
  let v_72 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_73 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_71.x);
  let v_74 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_71.y);
  let v_75 = length(v_view);
  let v_76 = clamp((1.0f / exp2((((0.0000122500005090842f * v_75) * v_75) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_77 = v.u_color.xyz;
  let v_78 = mix(vec3<f32>(), (pow(abs(abs(((v_72 * v_77) + (((v_73 + v_74) * v_77) * v_47)))), vec3<f32>(0.45454546809196472168f)) + (v_48 * v.u_params2.y)), vec3<f32>(v_76, v_76, v_76));
  bgfx_FragData0 = vec4<f32>(v_78.x, v_78.y, v_78.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
