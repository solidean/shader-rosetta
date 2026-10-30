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
  let v_7 = (v.u_params1.w * v.u_params1.z);
  var v_8 : f32;
  switch(0u) {
    default: {
      let v_9 = vec4<f32>(v_2.x, v_2.y, v_6, 1.0f).xy;
      if ((any((v_9 > vec2<f32>(1.0f))) | any((v_9 < vec2<f32>())))) {
        v_8 = 1.0f;
        break;
      }
      v_8 = clamp(exp((v_7 * (dot(textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_9), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)) - (v_6 - v_5)))), 0.0f, 1.0f);
    }
  }
  let v_10 = v_8;
  let v_11 = -(normalize(v_view));
  let v_12 = v.u_lightPosition;
  let v_13 = v.u_lightSpotDirectionInner.xyz;
  let v_14 = v.u_lightSpotDirectionInner.w;
  let v_15 = v.u_lightAttenuationSpotOuter.w;
  let v_16 = v.u_lightAttenuationSpotOuter;
  let v_17 = v_12.xyz;
  let v_18 = -(normalize(v_17));
  var v_19 : vec3<f32>;
  var v_20 : f32;
  if (!((0.0f == v_12.w))) {
    let v_21 = (v_17 - v_view);
    let v_22 = normalize(v_21);
    let v_23 = max(0.0f, dot(-(v_22), normalize(v_13)));
    let v_24 = cos(radians(v_15));
    let v_25 = clamp(((v_23 - v_24) / (cos(radians(min(v_14, (v_15 - 0.00100000004749745131f)))) - v_24)), 0.0f, 1.0f);
    let v_26 = length(v_21);
    let v_27 = ((1.0f / ((v_16.x + (v_16.y * v_26)) + ((v_16.z * v_26) * v_26))) * mix(v_25, 1.0f, step(90.0f, v_15)));
    v_19 = v_22;
    v_20 = v_27;
  } else {
    v_19 = v_18;
    v_20 = 1.0f;
  }
  let v_28 = v_20;
  let v_29 = v_19;
  let v_30 = v.u_materialKs.w;
  let v_31 = dot(v_normal, v_29);
  let v_32 = dot(((v_normal * (2.0f * v_31)) - v_29), v_11);
  let v_33 = (max(vec2<f32>(v_31, (((step(0.0f, v_31) * pow(max(0.0f, v_32), v_30)) * (2.0f + v_30)) * 0.125f)), vec2<f32>()) * v_28);
  let v_34 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_35 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_33.x);
  let v_36 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_33.y);
  let v_37 = length(v_view);
  let v_38 = clamp((1.0f / exp2((((0.0000122500005090842f * v_37) * v_37) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_39 = v.u_color.xyz;
  let v_40 = mix(vec3<f32>(), (pow(abs(abs(((v_34 * v_39) + (((v_35 + v_36) * v_39) * v_10)))), vec3<f32>(0.45454546809196472168f)) + (vec3<f32>(v_3, v_4, v_4) * v.u_params2.y)), vec3<f32>(v_38, v_38, v_38));
  bgfx_FragData0 = vec4<f32>(v_40.x, v_40.y, v_40.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
