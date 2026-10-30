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

fn main_inner(v_normal : vec3<f32>, v_shadowcoord : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = v_shadowcoord.w;
  let v_2 = (v_shadowcoord.xy / vec2<f32>(v_1, v_1));
  let v_3 = select(0.0f, 0.30000001192092895508f, (all((v_2 > vec2<f32>())) & all((v_2 < vec2<f32>(1.0f)))));
  let v_4 = -(v_3);
  let v_5 = v.u_params1.x;
  let v_6 = v_shadowcoord.z;
  var v_7 : f32;
  switch(0u) {
    default: {
      let v_8 = vec4<f32>(v_2.x, v_2.y, v_6, 1.0f).xy;
      if ((any((v_8 > vec2<f32>(1.0f))) | any((v_8 < vec2<f32>())))) {
        v_7 = 1.0f;
        break;
      }
      v_7 = step((v_6 - v_5), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_8, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
    }
  }
  let v_9 = v_7;
  let v_10 = -(normalize(v_view));
  let v_11 = v.u_lightPosition;
  let v_12 = v.u_lightSpotDirectionInner.xyz;
  let v_13 = v.u_lightSpotDirectionInner.w;
  let v_14 = v.u_lightAttenuationSpotOuter.w;
  let v_15 = v.u_lightAttenuationSpotOuter;
  let v_16 = v_11.xyz;
  let v_17 = -(normalize(v_16));
  var v_18 : vec3<f32>;
  var v_19 : f32;
  if (!((0.0f == v_11.w))) {
    let v_20 = (v_16 - v_view);
    let v_21 = normalize(v_20);
    let v_22 = max(0.0f, dot(-(v_21), normalize(v_12)));
    let v_23 = cos(radians(v_14));
    let v_24 = clamp(((v_22 - v_23) / (cos(radians(min(v_13, (v_14 - 0.00100000004749745131f)))) - v_23)), 0.0f, 1.0f);
    let v_25 = length(v_20);
    let v_26 = ((1.0f / ((v_15.x + (v_15.y * v_25)) + ((v_15.z * v_25) * v_25))) * mix(v_24, 1.0f, step(90.0f, v_14)));
    v_18 = v_21;
    v_19 = v_26;
  } else {
    v_18 = v_17;
    v_19 = 1.0f;
  }
  let v_27 = v_19;
  let v_28 = v_18;
  let v_29 = v.u_materialKs.w;
  let v_30 = dot(v_normal, v_28);
  let v_31 = dot(((v_normal * (2.0f * v_30)) - v_28), v_10);
  let v_32 = (max(vec2<f32>(v_30, (((step(0.0f, v_30) * pow(max(0.0f, v_31), v_29)) * (2.0f + v_29)) * 0.125f)), vec2<f32>()) * v_27);
  let v_33 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_34 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_32.x);
  let v_35 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_32.y);
  let v_36 = length(v_view);
  let v_37 = clamp((1.0f / exp2((((0.0000122500005090842f * v_36) * v_36) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_38 = v.u_color.xyz;
  let v_39 = mix(vec3<f32>(), (pow(abs(abs(((v_33 * v_38) + (((v_34 + v_35) * v_38) * v_9)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_37, v_37, v_37));
  bgfx_FragData0 = vec4<f32>(v_39.x, v_39.y, v_39.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
