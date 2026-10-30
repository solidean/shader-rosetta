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
    let v_15 = (v.u_params1.w * v.u_params1.z);
    var v_16 : f32;
    switch(0u) {
      default: {
        if ((any((v_2 > vec2<f32>(1.0f))) | any((v_2 < vec2<f32>())))) {
          v_16 = 1.0f;
          break;
        }
        v_16 = clamp(exp((v_15 * (dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_2), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - ((v_texcoord1.z - v_14) / v_1)))), 0.0f, 1.0f);
      }
    }
    let v_17 = v_16;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_17;
  } else {
    var v_18 : vec3<f32>;
    var v_19 : f32;
    if (v_8) {
      let v_20 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_21 = v.u_params1.x;
      let v_22 = (v.u_params1.w * v.u_params1.z);
      var v_23 : f32;
      switch(0u) {
        default: {
          if ((any((v_4 > vec2<f32>(1.0f))) | any((v_4 < vec2<f32>())))) {
            v_23 = 1.0f;
            break;
          }
          v_23 = clamp(exp((v_22 * (dot(textureSample(s_shadowMap1Texture, s_shadowMap1Sampler, v_4), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - ((v_texcoord2.z - v_21) / v_3)))), 0.0f, 1.0f);
        }
      }
      let v_24 = v_23;
      v_18 = vec3<f32>(v_20, v_20, -(v_20));
      v_19 = v_24;
    } else {
      var v_25 : vec3<f32>;
      var v_26 : f32;
      if (v_9) {
        let v_27 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_28 = -(v_27);
        let v_29 = v.u_params1.x;
        let v_30 = (v.u_params1.w * v.u_params1.z);
        var v_31 : f32;
        switch(0u) {
          default: {
            if ((any((v_6 > vec2<f32>(1.0f))) | any((v_6 < vec2<f32>())))) {
              v_31 = 1.0f;
              break;
            }
            v_31 = clamp(exp((v_30 * (dot(textureSample(s_shadowMap2Texture, s_shadowMap2Sampler, v_6), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - ((v_texcoord3.z - v_29) / v_5)))), 0.0f, 1.0f);
          }
        }
        let v_32 = v_31;
        v_25 = vec3<f32>(v_28, v_28, v_27);
        v_26 = v_32;
      } else {
        let v_33 = v_texcoord4.w;
        let v_34 = (v_texcoord4.xy / vec2<f32>(v_33, v_33));
        let v_35 = select(0.0f, 0.40000000596046447754f, (all((v_34 > vec2<f32>())) & all((v_34 < vec2<f32>(1.0f)))));
        let v_36 = -(v_35);
        let v_37 = v.u_params1.x;
        let v_38 = (v.u_params1.w * v.u_params1.z);
        var v_39 : f32;
        switch(0u) {
          default: {
            if ((any((v_34 > vec2<f32>(1.0f))) | any((v_34 < vec2<f32>())))) {
              v_39 = 1.0f;
              break;
            }
            v_39 = clamp(exp((v_38 * (dot(textureSample(s_shadowMap3Texture, s_shadowMap3Sampler, v_34), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - ((v_texcoord4.z - v_37) / v_33)))), 0.0f, 1.0f);
          }
        }
        let v_40 = v_39;
        v_25 = vec3<f32>(v_35, v_36, v_36);
        v_26 = v_40;
      }
      let v_41 = v_26;
      v_18 = v_25;
      v_19 = v_41;
    }
    let v_42 = v_19;
    v_10 = v_18;
    v_11 = v_42;
  }
  let v_43 = v_11;
  let v_44 = v_10;
  let v_45 = -(normalize(v_view));
  let v_46 = v.u_lightPosition;
  let v_47 = v.u_lightSpotDirectionInner.xyz;
  let v_48 = v.u_lightSpotDirectionInner.w;
  let v_49 = v.u_lightAttenuationSpotOuter.w;
  let v_50 = v.u_lightAttenuationSpotOuter;
  let v_51 = v_46.xyz;
  let v_52 = -(normalize(v_51));
  var v_53 : vec3<f32>;
  var v_54 : f32;
  if (!((0.0f == v_46.w))) {
    let v_55 = (v_51 - v_view);
    let v_56 = normalize(v_55);
    let v_57 = max(0.0f, dot(-(v_56), normalize(v_47)));
    let v_58 = cos(radians(v_49));
    let v_59 = clamp(((v_57 - v_58) / (cos(radians(min(v_48, (v_49 - 0.00100000004749745131f)))) - v_58)), 0.0f, 1.0f);
    let v_60 = length(v_55);
    let v_61 = ((1.0f / ((v_50.x + (v_50.y * v_60)) + ((v_50.z * v_60) * v_60))) * mix(v_59, 1.0f, step(90.0f, v_49)));
    v_53 = v_56;
    v_54 = v_61;
  } else {
    v_53 = v_52;
    v_54 = 1.0f;
  }
  let v_62 = v_54;
  let v_63 = v_53;
  let v_64 = v.u_materialKs.w;
  let v_65 = dot(v_normal, v_63);
  let v_66 = dot(((v_normal * (2.0f * v_65)) - v_63), v_45);
  let v_67 = (max(vec2<f32>(v_65, (((step(0.0f, v_65) * pow(max(0.0f, v_66), v_64)) * (2.0f + v_64)) * 0.125f)), vec2<f32>()) * v_62);
  let v_68 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_69 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_67.x);
  let v_70 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_67.y);
  let v_71 = length(v_view);
  let v_72 = clamp((1.0f / exp2((((0.0000122500005090842f * v_71) * v_71) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_73 = v.u_color.xyz;
  let v_74 = mix(vec3<f32>(), (pow(abs(abs(((v_68 * v_73) + (((v_69 + v_70) * v_73) * v_43)))), vec3<f32>(0.45454546809196472168f)) + (v_44 * v.u_params2.y)), vec3<f32>(v_72, v_72, v_72));
  bgfx_FragData0 = vec4<f32>(v_74.x, v_74.y, v_74.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
