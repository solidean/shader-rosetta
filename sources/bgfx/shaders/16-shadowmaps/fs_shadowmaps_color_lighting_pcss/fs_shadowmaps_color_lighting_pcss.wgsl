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
  var v_7 : f32;
  switch(0u) {
    default: {
      let v_8 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
      let v_9 = sin(v_8);
      let v_10 = cos(v_8);
      let v_11 = ((v_shadowcoord.z / v_1) - v_5);
      var v_12 : i32;
      var v_13 : f32;
      {
        var v_14 : f32;
        v_14 = 0.0f;
        var v_15 : i32;
        v_15 = 0i;
        var v_16 : i32;
        v_16 = 0i;
        loop {
          var v_17 : f32;
          var v_18 : i32;
          let v_19 = v_16;
          let v_20 = v_15;
          let v_21 = v_14;
          if ((v_19 < 16i)) {
            let v_22 = f32(v_19);
            let v_23 = sqrt(((v_22 + 0.5f) * 0.10000000149011611938f));
            let v_24 = (v_22 * 2.39996314048767089844f);
            let v_25 = (vec2<f32>(cos(v_24), sin(v_24)) * v_23);
            let v_26 = v_25.x;
            let v_27 = v_25.y;
            let v_28 = dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, (v_2 + (vec2<f32>(((v_26 * v_10) - (v_27 * v_9)), ((v_26 * v_9) + (v_27 * v_10))) * vec2<f32>(0.00999999977648258209f)))), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f));
            var v_29 : f32;
            var v_30 : i32;
            if ((v_28 < v_11)) {
              v_29 = (v_21 + v_28);
              v_30 = (v_20 + 1i);
            } else {
              v_29 = v_21;
              v_30 = v_20;
            }
            let v_31 = v_30;
            v_17 = v_29;
            v_18 = v_31;
            continue;
          } else {
            v_12 = v_20;
            v_13 = v_21;
            break;
          }

          continuing {
            let v_32 = v_18;
            v_14 = v_17;
            v_15 = v_32;
            v_16 = (v_19 + 1i);
          }
        }
      }
      let v_33 = v_13;
      let v_34 = v_12;
      var v_35 : f32;
      if ((v_34 > 0i)) {
        v_35 = (v_33 / f32(v_34));
      } else {
        v_35 = -1.0f;
      }
      let v_36 = v_35;
      if ((v_36 < -0.99000000953674316406f)) {
        v_7 = 1.0f;
        break;
      }
      let v_37 = max(0.0f, (v_11 - v_36));
      let v_38 = vec2<f32>(clamp(((v_6.z * v_37) / v_36), 0.0f, 0.25f), clamp(((v_6.w * v_37) / v_36), 0.0f, 0.25f));
      var v_39 : f32;
      {
        var v_40 : f32;
        v_40 = 0.0f;
        var v_41 : i32;
        v_41 = 0i;
        loop {
          var v_42 : f32;
          let v_43 = v_41;
          let v_44 = v_40;
          if ((v_43 < 16i)) {
            let v_45 = f32(v_43);
            let v_46 = sqrt(((v_45 + 0.5f) * 0.10000000149011611938f));
            let v_47 = (v_45 * 2.39996314048767089844f);
            let v_48 = (vec2<f32>(cos(v_47), sin(v_47)) * v_46);
            let v_49 = v_48.x;
            let v_50 = v_48.y;
            let v_51 = (vec2<f32>(((v_49 * v_10) - (v_50 * v_9)), ((v_49 * v_9) + (v_50 * v_10))) * v_38);
            let v_52 = (v_shadowcoord + vec4<f32>(v_51.x, v_51.y, 0.0f, 0.0f));
            var v_53 : f32;
            switch(0u) {
              default: {
                let v_54 = v_52.w;
                let v_55 = (v_52.xy / vec2<f32>(v_54, v_54));
                if ((any((v_55 > vec2<f32>(1.0f))) | any((v_55 < vec2<f32>())))) {
                  v_53 = 1.0f;
                  break;
                }
                v_53 = step(((v_52.z - v_5) / v_54), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_55, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
              }
            }
            v_42 = (v_44 + v_53);
            continue;
          } else {
            v_39 = v_44;
            break;
          }

          continuing {
            v_40 = v_42;
            v_41 = (v_43 + 1i);
          }
        }
      }
      v_7 = mix(1.0f, (v_39 * 0.0625f), smoothstep(0.0f, 0.25f, (f32(v_34) * 0.0625f)));
    }
  }
  let v_56 = v_7;
  let v_57 = -(normalize(v_view));
  let v_58 = v.u_lightPosition;
  let v_59 = v.u_lightSpotDirectionInner.xyz;
  let v_60 = v.u_lightSpotDirectionInner.w;
  let v_61 = v.u_lightAttenuationSpotOuter.w;
  let v_62 = v.u_lightAttenuationSpotOuter;
  let v_63 = v_58.xyz;
  let v_64 = -(normalize(v_63));
  var v_65 : vec3<f32>;
  var v_66 : f32;
  if (!((0.0f == v_58.w))) {
    let v_67 = (v_63 - v_view);
    let v_68 = normalize(v_67);
    let v_69 = max(0.0f, dot(-(v_68), normalize(v_59)));
    let v_70 = cos(radians(v_61));
    let v_71 = clamp(((v_69 - v_70) / (cos(radians(min(v_60, (v_61 - 0.00100000004749745131f)))) - v_70)), 0.0f, 1.0f);
    let v_72 = length(v_67);
    let v_73 = ((1.0f / ((v_62.x + (v_62.y * v_72)) + ((v_62.z * v_72) * v_72))) * mix(v_71, 1.0f, step(90.0f, v_61)));
    v_65 = v_68;
    v_66 = v_73;
  } else {
    v_65 = v_64;
    v_66 = 1.0f;
  }
  let v_74 = v_66;
  let v_75 = v_65;
  let v_76 = v.u_materialKs.w;
  let v_77 = dot(v_normal, v_75);
  let v_78 = dot(((v_normal * (2.0f * v_77)) - v_75), v_57);
  let v_79 = (max(vec2<f32>(v_77, (((step(0.0f, v_77) * pow(max(0.0f, v_78), v_76)) * (2.0f + v_76)) * 0.125f)), vec2<f32>()) * v_74);
  let v_80 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_81 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_79.x);
  let v_82 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_79.y);
  let v_83 = length(v_view);
  let v_84 = clamp((1.0f / exp2((((0.0000122500005090842f * v_83) * v_83) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_85 = v.u_color.xyz;
  let v_86 = mix(vec3<f32>(), (pow(abs(abs(((v_80 * v_85) + (((v_81 + v_82) * v_85) * v_56)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_84, v_84, v_84));
  bgfx_FragData0 = vec4<f32>(v_86.x, v_86.y, v_86.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
