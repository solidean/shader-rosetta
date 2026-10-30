diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_shadowMapSampler : sampler;

@group(0u) @binding(2u) var s_shadowMapTexture : texture_2d<f32>;

struct UniformBlock {
  u_lightPos : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_shadowcoord : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = -(normalize(v_view));
  let v_2 = normalize(v.u_lightPos.xyz);
  let v_3 = dot(v_normal, -(v_2));
  let v_4 = dot(((v_normal * (2.0f * v_3)) + v_2), v_1);
  let v_5 = max(vec2<f32>(v_3, ((step(0.0f, v_3) * pow(max(0.0f, v_4), 1.0f)) * 0.375f)), vec2<f32>());
  var v_6 : f32;
  switch(0u) {
    default: {
      let v_7 = v_shadowcoord.w;
      let v_8 = (v_shadowcoord.xy / vec2<f32>(v_7, v_7));
      if ((any((v_8 > vec2<f32>(1.0f))) | any((v_8 < vec2<f32>())))) {
        v_6 = 1.0f;
        break;
      }
      let v_9 = (vec2<f32>(0.001953125f) * v_7);
      let v_10 = (vec2<f32>(-1.5f) * v_9);
      let v_11 = (v_shadowcoord + vec4<f32>(v_10.x, v_10.y, 0.0f, 0.0f));
      let v_12 = v_11.w;
      let v_13 = (v_11.xyz / vec3<f32>(v_12, v_12, v_12));
      let v_14 = (vec2<f32>(-1.5f, -0.5f) * v_9);
      let v_15 = (v_shadowcoord + vec4<f32>(v_14.x, v_14.y, 0.0f, 0.0f));
      let v_16 = v_15.w;
      let v_17 = (v_15.xyz / vec3<f32>(v_16, v_16, v_16));
      let v_18 = (vec2<f32>(-1.5f, 0.5f) * v_9);
      let v_19 = (v_shadowcoord + vec4<f32>(v_18.x, v_18.y, 0.0f, 0.0f));
      let v_20 = v_19.w;
      let v_21 = (v_19.xyz / vec3<f32>(v_20, v_20, v_20));
      let v_22 = (vec2<f32>(-1.5f, 1.5f) * v_9);
      let v_23 = (v_shadowcoord + vec4<f32>(v_22.x, v_22.y, 0.0f, 0.0f));
      let v_24 = v_23.w;
      let v_25 = (v_23.xyz / vec3<f32>(v_24, v_24, v_24));
      let v_26 = (vec2<f32>(-0.5f, -1.5f) * v_9);
      let v_27 = (v_shadowcoord + vec4<f32>(v_26.x, v_26.y, 0.0f, 0.0f));
      let v_28 = v_27.w;
      let v_29 = (v_27.xyz / vec3<f32>(v_28, v_28, v_28));
      let v_30 = (vec2<f32>(-0.5f) * v_9);
      let v_31 = (v_shadowcoord + vec4<f32>(v_30.x, v_30.y, 0.0f, 0.0f));
      let v_32 = v_31.w;
      let v_33 = (v_31.xyz / vec3<f32>(v_32, v_32, v_32));
      let v_34 = (vec2<f32>(-0.5f, 0.5f) * v_9);
      let v_35 = (v_shadowcoord + vec4<f32>(v_34.x, v_34.y, 0.0f, 0.0f));
      let v_36 = v_35.w;
      let v_37 = (v_35.xyz / vec3<f32>(v_36, v_36, v_36));
      let v_38 = (vec2<f32>(-0.5f, 1.5f) * v_9);
      let v_39 = (v_shadowcoord + vec4<f32>(v_38.x, v_38.y, 0.0f, 0.0f));
      let v_40 = v_39.w;
      let v_41 = (v_39.xyz / vec3<f32>(v_40, v_40, v_40));
      let v_42 = (vec2<f32>(0.5f, -1.5f) * v_9);
      let v_43 = (v_shadowcoord + vec4<f32>(v_42.x, v_42.y, 0.0f, 0.0f));
      let v_44 = v_43.w;
      let v_45 = (v_43.xyz / vec3<f32>(v_44, v_44, v_44));
      let v_46 = (vec2<f32>(0.5f, -0.5f) * v_9);
      let v_47 = (v_shadowcoord + vec4<f32>(v_46.x, v_46.y, 0.0f, 0.0f));
      let v_48 = v_47.w;
      let v_49 = (v_47.xyz / vec3<f32>(v_48, v_48, v_48));
      let v_50 = (vec2<f32>(0.5f) * v_9);
      let v_51 = (v_shadowcoord + vec4<f32>(v_50.x, v_50.y, 0.0f, 0.0f));
      let v_52 = v_51.w;
      let v_53 = (v_51.xyz / vec3<f32>(v_52, v_52, v_52));
      let v_54 = (vec2<f32>(0.5f, 1.5f) * v_9);
      let v_55 = (v_shadowcoord + vec4<f32>(v_54.x, v_54.y, 0.0f, 0.0f));
      let v_56 = v_55.w;
      let v_57 = (v_55.xyz / vec3<f32>(v_56, v_56, v_56));
      let v_58 = (vec2<f32>(1.5f, -1.5f) * v_9);
      let v_59 = (v_shadowcoord + vec4<f32>(v_58.x, v_58.y, 0.0f, 0.0f));
      let v_60 = v_59.w;
      let v_61 = (v_59.xyz / vec3<f32>(v_60, v_60, v_60));
      let v_62 = (vec2<f32>(1.5f, -0.5f) * v_9);
      let v_63 = (v_shadowcoord + vec4<f32>(v_62.x, v_62.y, 0.0f, 0.0f));
      let v_64 = v_63.w;
      let v_65 = (v_63.xyz / vec3<f32>(v_64, v_64, v_64));
      let v_66 = (vec2<f32>(1.5f, 0.5f) * v_9);
      let v_67 = (v_shadowcoord + vec4<f32>(v_66.x, v_66.y, 0.0f, 0.0f));
      let v_68 = v_67.w;
      let v_69 = (v_67.xyz / vec3<f32>(v_68, v_68, v_68));
      let v_70 = (vec2<f32>(1.5f) * v_9);
      let v_71 = (v_shadowcoord + vec4<f32>(v_70.x, v_70.y, 0.0f, 0.0f));
      let v_72 = v_71.w;
      let v_73 = (v_71.xyz / vec3<f32>(v_72, v_72, v_72));
      v_6 = ((((((((((((((((step((v_13.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_13.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f))) + step((v_17.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_17.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_21.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_21.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_25.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_25.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_29.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_29.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_33.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_33.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_37.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_37.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_41.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_41.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_45.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_45.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_49.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_49.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_53.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_53.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_57.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_57.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_61.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_61.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_65.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_65.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_69.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_69.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) + step((v_73.z - 0.00499999988824129105f), dot(textureSample(s_shadowMapTexture, s_shadowMapSampler, v_73.xy), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)))) * 0.0625f);
    }
  }
  let v_74 = pow(abs(abs((vec3<f32>(0.10000000149011611938f) + ((vec3<f32>(1.0f) * (v_5.x + v_5.y)) * v_6)))), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_74.x, v_74.y, v_74.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_shadowcoord : vec4<f32>, @location(2u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_shadowcoord, v_view);
  return bgfx_FragData0;
}
