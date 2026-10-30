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
  let v_6 = v.u_params1.w;
  let v_7 = v.u_params1.z;
  let v_8 = v_shadowcoord.z;
  var v_9 : f32;
  switch(0u) {
    default: {
      let v_10 = vec4<f32>(v_2.x, v_2.y, v_8, 1.0f).xy;
      if ((any((v_10 > vec2<f32>(1.0f))) | any((v_10 < vec2<f32>())))) {
        v_9 = 1.0f;
        break;
      }
      let v_11 = ((v_8 - v_5) * v_6);
      let v_12 = textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_10);
      let v_13 = (vec2<f32>(dot(v_12.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_12.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_6);
      let v_14 = v_13.x;
      if ((v_11 < v_14)) {
        v_9 = 1.0f;
        break;
      }
      let v_15 = max((v_13.y - (v_14 * v_14)), v_7);
      let v_16 = (v_11 - v_14);
      v_9 = (v_15 / (v_15 + (v_16 * v_16)));
    }
  }
  let v_17 = v_9;
  let v_18 = -(normalize(v_view));
  let v_19 = v.u_lightPosition;
  let v_20 = v.u_lightSpotDirectionInner.xyz;
  let v_21 = v.u_lightSpotDirectionInner.w;
  let v_22 = v.u_lightAttenuationSpotOuter.w;
  let v_23 = v.u_lightAttenuationSpotOuter;
  let v_24 = v_19.xyz;
  let v_25 = -(normalize(v_24));
  var v_26 : vec3<f32>;
  var v_27 : f32;
  if (!((0.0f == v_19.w))) {
    let v_28 = (v_24 - v_view);
    let v_29 = normalize(v_28);
    let v_30 = max(0.0f, dot(-(v_29), normalize(v_20)));
    let v_31 = cos(radians(v_22));
    let v_32 = clamp(((v_30 - v_31) / (cos(radians(min(v_21, (v_22 - 0.00100000004749745131f)))) - v_31)), 0.0f, 1.0f);
    let v_33 = length(v_28);
    let v_34 = ((1.0f / ((v_23.x + (v_23.y * v_33)) + ((v_23.z * v_33) * v_33))) * mix(v_32, 1.0f, step(90.0f, v_22)));
    v_26 = v_29;
    v_27 = v_34;
  } else {
    v_26 = v_25;
    v_27 = 1.0f;
  }
  let v_35 = v_27;
  let v_36 = v_26;
  let v_37 = v.u_materialKs.w;
  let v_38 = dot(v_normal, v_36);
  let v_39 = dot(((v_normal * (2.0f * v_38)) - v_36), v_18);
  let v_40 = (max(vec2<f32>(v_38, (((step(0.0f, v_38) * pow(max(0.0f, v_39), v_37)) * (2.0f + v_37)) * 0.125f)), vec2<f32>()) * v_35);
  let v_41 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_42 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_40.x);
  let v_43 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_40.y);
  let v_44 = length(v_view);
  let v_45 = clamp((1.0f / exp2((((0.0000122500005090842f * v_44) * v_44) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_46 = v.u_color.xyz;
  let v_47 = mix(vec3<f32>(), (pow(abs(abs(((v_41 * v_46) + (((v_42 + v_43) * v_46) * v_17)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_45, v_45, v_45));
  bgfx_FragData0 = vec4<f32>(v_47.x, v_47.y, v_47.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
