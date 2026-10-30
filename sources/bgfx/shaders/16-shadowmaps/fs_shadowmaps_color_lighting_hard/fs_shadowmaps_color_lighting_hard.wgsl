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
  var v_6 : f32;
  switch(0u) {
    default: {
      if ((any((v_2 > vec2<f32>(1.0f))) | any((v_2 < vec2<f32>())))) {
        v_6 = 1.0f;
        break;
      }
      v_6 = step(((v_shadowcoord.z - v_5) / v_1), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_2, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
    }
  }
  let v_7 = v_6;
  let v_8 = -(normalize(v_view));
  let v_9 = v.u_lightPosition;
  let v_10 = v.u_lightSpotDirectionInner.xyz;
  let v_11 = v.u_lightSpotDirectionInner.w;
  let v_12 = v.u_lightAttenuationSpotOuter.w;
  let v_13 = v.u_lightAttenuationSpotOuter;
  let v_14 = v_9.xyz;
  let v_15 = -(normalize(v_14));
  var v_16 : vec3<f32>;
  var v_17 : f32;
  if (!((0.0f == v_9.w))) {
    let v_18 = (v_14 - v_view);
    let v_19 = normalize(v_18);
    let v_20 = max(0.0f, dot(-(v_19), normalize(v_10)));
    let v_21 = cos(radians(v_12));
    let v_22 = clamp(((v_20 - v_21) / (cos(radians(min(v_11, (v_12 - 0.00100000004749745131f)))) - v_21)), 0.0f, 1.0f);
    let v_23 = length(v_18);
    let v_24 = ((1.0f / ((v_13.x + (v_13.y * v_23)) + ((v_13.z * v_23) * v_23))) * mix(v_22, 1.0f, step(90.0f, v_12)));
    v_16 = v_19;
    v_17 = v_24;
  } else {
    v_16 = v_15;
    v_17 = 1.0f;
  }
  let v_25 = v_17;
  let v_26 = v_16;
  let v_27 = v.u_materialKs.w;
  let v_28 = dot(v_normal, v_26);
  let v_29 = dot(((v_normal * (2.0f * v_28)) - v_26), v_8);
  let v_30 = (max(vec2<f32>(v_28, (((step(0.0f, v_28) * pow(max(0.0f, v_29), v_27)) * (2.0f + v_27)) * 0.125f)), vec2<f32>()) * v_25);
  let v_31 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_32 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_30.x);
  let v_33 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_30.y);
  let v_34 = length(v_view);
  let v_35 = clamp((1.0f / exp2((((0.0000122500005090842f * v_34) * v_34) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_36 = v.u_color.xyz;
  let v_37 = mix(vec3<f32>(), (pow(abs(abs(((v_31 * v_36) + (((v_32 + v_33) * v_36) * v_7)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_35, v_35, v_35));
  bgfx_FragData0 = vec4<f32>(v_37.x, v_37.y, v_37.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
