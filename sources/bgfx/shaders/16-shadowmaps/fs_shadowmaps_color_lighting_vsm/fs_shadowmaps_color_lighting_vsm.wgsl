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
  var v_8 : f32;
  switch(0u) {
    default: {
      if ((any((v_2 > vec2<f32>(1.0f))) | any((v_2 < vec2<f32>())))) {
        v_8 = 1.0f;
        break;
      }
      let v_9 = (((v_shadowcoord.z - v_5) / v_1) * v_6);
      let v_10 = textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_2);
      let v_11 = (vec2<f32>(dot(v_10.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_10.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_6);
      let v_12 = v_11.x;
      if ((v_9 < v_12)) {
        v_8 = 1.0f;
        break;
      }
      let v_13 = max((v_11.y - (v_12 * v_12)), v_7);
      let v_14 = (v_9 - v_12);
      v_8 = (v_13 / (v_13 + (v_14 * v_14)));
    }
  }
  let v_15 = v_8;
  let v_16 = -(normalize(v_view));
  let v_17 = v.u_lightPosition;
  let v_18 = v.u_lightSpotDirectionInner.xyz;
  let v_19 = v.u_lightSpotDirectionInner.w;
  let v_20 = v.u_lightAttenuationSpotOuter.w;
  let v_21 = v.u_lightAttenuationSpotOuter;
  let v_22 = v_17.xyz;
  let v_23 = -(normalize(v_22));
  var v_24 : vec3<f32>;
  var v_25 : f32;
  if (!((0.0f == v_17.w))) {
    let v_26 = (v_22 - v_view);
    let v_27 = normalize(v_26);
    let v_28 = max(0.0f, dot(-(v_27), normalize(v_18)));
    let v_29 = cos(radians(v_20));
    let v_30 = clamp(((v_28 - v_29) / (cos(radians(min(v_19, (v_20 - 0.00100000004749745131f)))) - v_29)), 0.0f, 1.0f);
    let v_31 = length(v_26);
    let v_32 = ((1.0f / ((v_21.x + (v_21.y * v_31)) + ((v_21.z * v_31) * v_31))) * mix(v_30, 1.0f, step(90.0f, v_20)));
    v_24 = v_27;
    v_25 = v_32;
  } else {
    v_24 = v_23;
    v_25 = 1.0f;
  }
  let v_33 = v_25;
  let v_34 = v_24;
  let v_35 = v.u_materialKs.w;
  let v_36 = dot(v_normal, v_34);
  let v_37 = dot(((v_normal * (2.0f * v_36)) - v_34), v_16);
  let v_38 = (max(vec2<f32>(v_36, (((step(0.0f, v_36) * pow(max(0.0f, v_37), v_35)) * (2.0f + v_35)) * 0.125f)), vec2<f32>()) * v_33);
  let v_39 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_40 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_38.x);
  let v_41 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_38.y);
  let v_42 = length(v_view);
  let v_43 = clamp((1.0f / exp2((((0.0000122500005090842f * v_42) * v_42) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_44 = v.u_color.xyz;
  let v_45 = mix(vec3<f32>(), (pow(abs(abs(((v_39 * v_44) + (((v_40 + v_41) * v_44) * v_15)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_43, v_43, v_43));
  bgfx_FragData0 = vec4<f32>(v_45.x, v_45.y, v_45.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
