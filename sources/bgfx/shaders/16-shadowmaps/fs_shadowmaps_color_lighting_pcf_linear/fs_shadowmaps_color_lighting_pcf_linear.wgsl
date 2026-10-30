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
  let v_1 = v.u_params2.z;
  let v_2 = v_shadowcoord.w;
  let v_3 = (v_shadowcoord.xy / vec2<f32>(v_2, v_2));
  let v_4 = select(0.0f, 0.30000001192092895508f, (all((v_3 > vec2<f32>())) & all((v_3 < vec2<f32>(1.0f)))));
  let v_5 = -(v_4);
  let v_6 = v.u_params1.x;
  let v_7 = v.u_smSamplingParams;
  let v_8 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
  let v_9 = sin(v_8);
  let v_10 = cos(v_8);
  var v_11 : f32;
  {
    var v_12 : f32;
    v_12 = 0.0f;
    var v_13 : i32;
    v_13 = 0i;
    loop {
      var v_14 : f32;
      let v_15 = v_13;
      let v_16 = v_12;
      if ((v_15 < 16i)) {
        let v_17 = f32(v_15);
        let v_18 = sqrt(((v_17 + 0.5f) * 0.10000000149011611938f));
        let v_19 = (v_17 * 2.39996314048767089844f);
        let v_20 = (vec2<f32>(cos(v_19), sin(v_19)) * v_18);
        let v_21 = v_20.x;
        let v_22 = v_20.y;
        let v_23 = (vec2<f32>(((v_21 * v_10) - (v_22 * v_9)), ((v_21 * v_9) + (v_22 * v_10))) * (((vec2<f32>(2.0f) * v_7.zw) * vec2<f32>(v_1, v_1)) * 1.0f));
        let v_24 = (vec4<f32>(v_3.x, v_3.y, v_shadowcoord.z, 1.0f) + vec4<f32>(v_23.x, v_23.y, 0.0f, 0.0f));
        var v_25 : f32;
        switch(0u) {
          default: {
            let v_26 = v_24.w;
            let v_27 = (v_24.xy / vec2<f32>(v_26, v_26));
            if ((any((v_27 > vec2<f32>(1.0f))) | any((v_27 < vec2<f32>())))) {
              v_25 = 1.0f;
              break;
            }
            v_25 = step(((v_24.z - v_6) / v_26), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_27, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        v_14 = (v_16 + v_25);
        continue;
      } else {
        v_11 = v_16;
        break;
      }

      continuing {
        v_12 = v_14;
        v_13 = (v_15 + 1i);
      }
    }
  }
  let v_28 = (v_11 * 0.0625f);
  let v_29 = -(normalize(v_view));
  let v_30 = v.u_lightPosition;
  let v_31 = v.u_lightSpotDirectionInner.xyz;
  let v_32 = v.u_lightSpotDirectionInner.w;
  let v_33 = v.u_lightAttenuationSpotOuter.w;
  let v_34 = v.u_lightAttenuationSpotOuter;
  let v_35 = v_30.xyz;
  let v_36 = -(normalize(v_35));
  var v_37 : vec3<f32>;
  var v_38 : f32;
  if (!((0.0f == v_30.w))) {
    let v_39 = (v_35 - v_view);
    let v_40 = normalize(v_39);
    let v_41 = max(0.0f, dot(-(v_40), normalize(v_31)));
    let v_42 = cos(radians(v_33));
    let v_43 = clamp(((v_41 - v_42) / (cos(radians(min(v_32, (v_33 - 0.00100000004749745131f)))) - v_42)), 0.0f, 1.0f);
    let v_44 = length(v_39);
    let v_45 = ((1.0f / ((v_34.x + (v_34.y * v_44)) + ((v_34.z * v_44) * v_44))) * mix(v_43, 1.0f, step(90.0f, v_33)));
    v_37 = v_40;
    v_38 = v_45;
  } else {
    v_37 = v_36;
    v_38 = 1.0f;
  }
  let v_46 = v_38;
  let v_47 = v_37;
  let v_48 = v.u_materialKs.w;
  let v_49 = dot(v_normal, v_47);
  let v_50 = dot(((v_normal * (2.0f * v_49)) - v_47), v_29);
  let v_51 = (max(vec2<f32>(v_49, (((step(0.0f, v_49) * pow(max(0.0f, v_50), v_48)) * (2.0f + v_48)) * 0.125f)), vec2<f32>()) * v_46);
  let v_52 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_53 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_51.x);
  let v_54 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_51.y);
  let v_55 = length(v_view);
  let v_56 = clamp((1.0f / exp2((((0.0000122500005090842f * v_55) * v_55) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_57 = v.u_color.xyz;
  let v_58 = mix(vec3<f32>(), (pow(abs(abs(((v_52 * v_57) + (((v_53 + v_54) * v_57) * v_28)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_4, v_5, v_5) * v.u_params2.y)), vec3<f32>(v_56, v_56, v_56));
  bgfx_FragData0 = vec4<f32>(v_58.x, v_58.y, v_58.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
