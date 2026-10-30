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
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_shadowcoord : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = v_shadowcoord.w;
  let v_2 = (v_shadowcoord.xy / vec2<f32>(v_1, v_1));
  let v_3 = select(0.0f, 0.30000001192092895508f, (all((v_2 > vec2<f32>())) & all((v_2 < vec2<f32>(1.0f)))));
  let v_4 = -(v_3);
  let v_5 = v.u_params1.x;
  let v_6 = v.u_smSamplingParams;
  let v_7 = v_shadowcoord.z;
  let v_8 = vec4<f32>(v_2.x, v_2.y, v_7, 1.0f);
  var v_9 : f32;
  switch(0u) {
    default: {
      let v_10 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
      let v_11 = sin(v_10);
      let v_12 = cos(v_10);
      let v_13 = (v_7 - v_5);
      var v_14 : i32;
      var v_15 : f32;
      {
        var v_16 : f32;
        v_16 = 0.0f;
        var v_17 : i32;
        v_17 = 0i;
        var v_18 : i32;
        v_18 = 0i;
        loop {
          var v_19 : f32;
          var v_20 : i32;
          let v_21 = v_18;
          let v_22 = v_17;
          let v_23 = v_16;
          if ((v_21 < 16i)) {
            let v_24 = f32(v_21);
            let v_25 = sqrt(((v_24 + 0.5f) * 0.10000000149011611938f));
            let v_26 = (v_24 * 2.39996314048767089844f);
            let v_27 = (vec2<f32>(cos(v_26), sin(v_26)) * v_25);
            let v_28 = v_27.x;
            let v_29 = v_27.y;
            let v_30 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, (v_8.xy + (vec2<f32>(((v_28 * v_12) - (v_29 * v_11)), ((v_28 * v_11) + (v_29 * v_12))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
            var v_31 : f32;
            var v_32 : i32;
            if ((v_30 < v_13)) {
              v_31 = (v_23 + v_30);
              v_32 = (v_22 + 1i);
            } else {
              v_31 = v_23;
              v_32 = v_22;
            }
            let v_33 = v_32;
            v_19 = v_31;
            v_20 = v_33;
            continue;
          } else {
            v_14 = v_22;
            v_15 = v_23;
            break;
          }

          continuing {
            let v_34 = v_20;
            v_16 = v_19;
            v_17 = v_34;
            v_18 = (v_21 + 1i);
          }
        }
      }
      let v_35 = v_15;
      let v_36 = v_14;
      var v_37 : f32;
      if ((v_36 > 0i)) {
        v_37 = (v_35 / f32(v_36));
      } else {
        v_37 = -1.0f;
      }
      let v_38 = v_37;
      if ((v_38 < -0.99000000953674316406f)) {
        v_9 = 1.0f;
        break;
      }
      let v_39 = max(0.0f, (v_13 - v_38));
      let v_40 = vec2<f32>(clamp(((v_6.z * v_39) / v_38), 0.0f, 0.25f), clamp(((v_6.w * v_39) / v_38), 0.0f, 0.25f));
      var v_41 : f32;
      {
        var v_42 : f32;
        v_42 = 0.0f;
        var v_43 : i32;
        v_43 = 0i;
        loop {
          var v_44 : f32;
          let v_45 = v_43;
          let v_46 = v_42;
          if ((v_45 < 16i)) {
            let v_47 = f32(v_45);
            let v_48 = sqrt(((v_47 + 0.5f) * 0.10000000149011611938f));
            let v_49 = (v_47 * 2.39996314048767089844f);
            let v_50 = (vec2<f32>(cos(v_49), sin(v_49)) * v_48);
            let v_51 = v_50.x;
            let v_52 = v_50.y;
            let v_53 = (vec2<f32>(((v_51 * v_12) - (v_52 * v_11)), ((v_51 * v_11) + (v_52 * v_12))) * v_40);
            let v_54 = (v_8 + vec4<f32>(v_53.x, v_53.y, 0.0f, 0.0f));
            var v_55 : f32;
            switch(0u) {
              default: {
                let v_56 = v_54.w;
                let v_57 = (v_54.xy / vec2<f32>(v_56, v_56));
                if ((any((v_57 > vec2<f32>(1.0f))) | any((v_57 < vec2<f32>())))) {
                  v_55 = 1.0f;
                  break;
                }
                v_55 = step(((v_54.z - v_5) / v_56), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_57, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
              }
            }
            v_44 = (v_46 + v_55);
            continue;
          } else {
            v_41 = v_46;
            break;
          }

          continuing {
            v_42 = v_44;
            v_43 = (v_45 + 1i);
          }
        }
      }
      v_9 = mix(1.0f, (v_41 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_36) * 0.0625f)));
    }
  }
  let v_58 = v_9;
  let v_59 = -(normalize(v_view));
  let v_60 = v.u_lightPosition;
  let v_61 = v.u_lightSpotDirectionInner.xyz;
  let v_62 = v.u_lightSpotDirectionInner.w;
  let v_63 = v.u_lightAttenuationSpotOuter.w;
  let v_64 = v.u_lightAttenuationSpotOuter;
  let v_65 = v_60.xyz;
  let v_66 = -(normalize(v_65));
  var v_67 : vec3<f32>;
  var v_68 : f32;
  if (!((0.0f == v_60.w))) {
    let v_69 = (v_65 - v_view);
    let v_70 = normalize(v_69);
    let v_71 = max(0.0f, dot(-(v_70), normalize(v_61)));
    let v_72 = cos(radians(v_63));
    let v_73 = clamp(((v_71 - v_72) / (cos(radians(min(v_62, (v_63 - 0.00100000004749745131f)))) - v_72)), 0.0f, 1.0f);
    let v_74 = length(v_69);
    let v_75 = ((1.0f / ((v_64.x + (v_64.y * v_74)) + ((v_64.z * v_74) * v_74))) * mix(v_73, 1.0f, step(90.0f, v_63)));
    v_67 = v_70;
    v_68 = v_75;
  } else {
    v_67 = v_66;
    v_68 = 1.0f;
  }
  let v_76 = v_68;
  let v_77 = v_67;
  let v_78 = v.u_materialKs.w;
  let v_79 = dot(v_normal, v_77);
  let v_80 = dot(((v_normal * (2.0f * v_79)) - v_77), v_59);
  let v_81 = (max(vec2<f32>(v_79, (((step(0.0f, v_79) * pow(max(0.0f, v_80), v_78)) * (2.0f + v_78)) * 0.125f)), vec2<f32>()) * v_76);
  let v_82 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_83 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_81.x);
  let v_84 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_81.y);
  let v_85 = length(v_view);
  let v_86 = clamp((1.0f / exp2((((0.0000122500005090842f * v_85) * v_85) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_87 = v.u_color.xyz;
  let v_88 = mix(vec3<f32>(), (pow(abs(abs(((v_82 * v_87) + (((v_83 + v_84) * v_87) * v_58)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_86, v_86, v_86));
  bgfx_FragData0 = vec4<f32>(v_88.x, v_88.y, v_88.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
