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
    var v_15 : f32;
    switch(0u) {
      default: {
        if ((any((v_2 > vec2<f32>(1.0f))) | any((v_2 < vec2<f32>())))) {
          v_15 = 1.0f;
          break;
        }
        v_15 = step(((v_texcoord1.z - v_14) / v_1), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_2, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
      }
    }
    let v_16 = v_15;
    v_10 = vec3<f32>(v_13, v_12, v_13);
    v_11 = v_16;
  } else {
    var v_17 : vec3<f32>;
    var v_18 : f32;
    if (v_8) {
      let v_19 = select(0.0f, 0.40000000596046447754f, (all((v_4 > vec2<f32>())) & all((v_4 < vec2<f32>(1.0f)))));
      let v_20 = v.u_params1.x;
      var v_21 : f32;
      switch(0u) {
        default: {
          if ((any((v_4 > vec2<f32>(1.0f))) | any((v_4 < vec2<f32>())))) {
            v_21 = 1.0f;
            break;
          }
          v_21 = step(((v_texcoord2.z - v_20) / v_3), dot(textureSampleLevel(s_shadowMap1Texture, s_shadowMap1Sampler, v_4, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
        }
      }
      let v_22 = v_21;
      v_17 = vec3<f32>(v_19, v_19, -(v_19));
      v_18 = v_22;
    } else {
      var v_23 : vec3<f32>;
      var v_24 : f32;
      if (v_9) {
        let v_25 = select(0.0f, 0.40000000596046447754f, (all((v_6 > vec2<f32>())) & all((v_6 < vec2<f32>(1.0f)))));
        let v_26 = -(v_25);
        let v_27 = v.u_params1.x;
        var v_28 : f32;
        switch(0u) {
          default: {
            if ((any((v_6 > vec2<f32>(1.0f))) | any((v_6 < vec2<f32>())))) {
              v_28 = 1.0f;
              break;
            }
            v_28 = step(((v_texcoord3.z - v_27) / v_5), dot(textureSampleLevel(s_shadowMap2Texture, s_shadowMap2Sampler, v_6, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        let v_29 = v_28;
        v_23 = vec3<f32>(v_26, v_26, v_25);
        v_24 = v_29;
      } else {
        let v_30 = v_texcoord4.w;
        let v_31 = (v_texcoord4.xy / vec2<f32>(v_30, v_30));
        let v_32 = select(0.0f, 0.40000000596046447754f, (all((v_31 > vec2<f32>())) & all((v_31 < vec2<f32>(1.0f)))));
        let v_33 = -(v_32);
        let v_34 = v.u_params1.x;
        var v_35 : f32;
        switch(0u) {
          default: {
            if ((any((v_31 > vec2<f32>(1.0f))) | any((v_31 < vec2<f32>())))) {
              v_35 = 1.0f;
              break;
            }
            v_35 = step(((v_texcoord4.z - v_34) / v_30), dot(textureSampleLevel(s_shadowMap3Texture, s_shadowMap3Sampler, v_31, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        let v_36 = v_35;
        v_23 = vec3<f32>(v_32, v_33, v_33);
        v_24 = v_36;
      }
      let v_37 = v_24;
      v_17 = v_23;
      v_18 = v_37;
    }
    let v_38 = v_18;
    v_10 = v_17;
    v_11 = v_38;
  }
  let v_39 = v_11;
  let v_40 = v_10;
  let v_41 = -(normalize(v_view));
  let v_42 = v.u_lightPosition;
  let v_43 = v.u_lightSpotDirectionInner.xyz;
  let v_44 = v.u_lightSpotDirectionInner.w;
  let v_45 = v.u_lightAttenuationSpotOuter.w;
  let v_46 = v.u_lightAttenuationSpotOuter;
  let v_47 = v_42.xyz;
  let v_48 = -(normalize(v_47));
  var v_49 : vec3<f32>;
  var v_50 : f32;
  if (!((0.0f == v_42.w))) {
    let v_51 = (v_47 - v_view);
    let v_52 = normalize(v_51);
    let v_53 = max(0.0f, dot(-(v_52), normalize(v_43)));
    let v_54 = cos(radians(v_45));
    let v_55 = clamp(((v_53 - v_54) / (cos(radians(min(v_44, (v_45 - 0.00100000004749745131f)))) - v_54)), 0.0f, 1.0f);
    let v_56 = length(v_51);
    let v_57 = ((1.0f / ((v_46.x + (v_46.y * v_56)) + ((v_46.z * v_56) * v_56))) * mix(v_55, 1.0f, step(90.0f, v_45)));
    v_49 = v_52;
    v_50 = v_57;
  } else {
    v_49 = v_48;
    v_50 = 1.0f;
  }
  let v_58 = v_50;
  let v_59 = v_49;
  let v_60 = v.u_materialKs.w;
  let v_61 = dot(v_normal, v_59);
  let v_62 = dot(((v_normal * (2.0f * v_61)) - v_59), v_41);
  let v_63 = (max(vec2<f32>(v_61, (((step(0.0f, v_61) * pow(max(0.0f, v_62), v_60)) * (2.0f + v_60)) * 0.125f)), vec2<f32>()) * v_58);
  let v_64 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_65 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_63.x);
  let v_66 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_63.y);
  let v_67 = length(v_view);
  let v_68 = clamp((1.0f / exp2((((0.0000122500005090842f * v_67) * v_67) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_69 = v.u_color.xyz;
  let v_70 = mix(vec3<f32>(), (pow(abs(abs(((v_64 * v_69) + (((v_65 + v_66) * v_69) * v_39)))), vec3<f32>(0.45454546809196472168f)) + (v_40 * v.u_params2.y)), vec3<f32>(v_68, v_68, v_68));
  bgfx_FragData0 = vec4<f32>(v_70.x, v_70.y, v_70.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
