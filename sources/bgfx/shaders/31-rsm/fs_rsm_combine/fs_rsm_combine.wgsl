diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_normalSampler : sampler;

@group(0u) @binding(2u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_colorSampler : sampler;

@group(0u) @binding(3u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_lightSampler : sampler;

@group(0u) @binding(4u) var s_lightTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_depthSampler : sampler;

@group(0u) @binding(5u) var s_depthTexture : texture_2d<f32>;

@group(0u) @binding(22u) var s_shadowMapSamplerComparison : sampler_comparison;

@group(0u) @binding(6u) var s_shadowMapTexture : texture_depth_2d;

struct UniformBlock_1_1 {
  u_lightDir : vec4<f32>,
  u_invMvp : mat4x4<f32>,
  u_lightMtx : mat4x4<f32>,
  u_shadowDimsInv : vec4<f32>,
  u_rsmAmount : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = ((textureSample(s_normalTexture, s_normalSampler, v_texcoord0).xyz * 2.0f) + vec3<f32>(-1.0f));
  let v_2 = max(0.0f, dot(v_1, v.u_lightDir.xyz));
  let v_3 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_4 = ((v_texcoord0 * 2.0f) - vec2<f32>(1.0f));
  let v_5 = (vec4<f32>(v_4.x, -(v_4.y), v_3, 1.0f) * transpose(v.u_invMvp));
  let v_6 = v_5.w;
  let v_7 = ((v_5.xyz / vec3<f32>(v_6, v_6, v_6)) + (v_1 * 0.00300000002607703209f));
  let v_8 = (vec4<f32>(v_7.x, v_7.y, v_7.z, 1.0f) * transpose(v.u_lightMtx));
  var v_9 : vec4<f32> = v_8;
  v_9.y = -(v_8.y);
  let v_10 = v_9;
  let v_11 = v.u_shadowDimsInv.x;
  let v_12 = v_8.w;
  let v_13 = (v_10.xy / vec2<f32>(v_12, v_12));
  var v_14 : vec4<f32> = vec4<f32>();
  v_14.x = v_13.x;
  var v_15 : vec4<f32> = v_14;
  v_15.y = v_13.y;
  let v_16 = ((v_15.xy * 0.5f) + vec2<f32>(0.5f));
  var v_17 : vec4<f32> = vec4<f32>();
  v_17.x = v_16.x;
  var v_18 : vec4<f32> = v_17;
  v_18.y = v_16.y;
  var v_19 : vec4<f32> = v_18;
  v_19.z = v_8.z;
  let v_20 = v_19;
  var v_21 : f32;
  switch(0u) {
    default: {
      let v_22 = v_20.xy;
      if ((any((v_22 > vec2<f32>(1.0f))) | any((v_22 < vec2<f32>())))) {
        v_21 = 1.0f;
        break;
      }
      let v_23 = (vec2<f32>(v_11, v_11) * v_12);
      let v_24 = (vec2<f32>(-1.5f) * v_23);
      let v_25 = (v_20 + vec4<f32>(v_24.x, v_24.y, 0.0f, 0.0f));
      let v_26 = (v_25.z - 0.00100000004749745131f);
      let v_27 = (vec2<f32>(-1.5f, -0.5f) * v_23);
      let v_28 = (v_20 + vec4<f32>(v_27.x, v_27.y, 0.0f, 0.0f));
      let v_29 = (v_28.z - 0.00100000004749745131f);
      let v_30 = (vec2<f32>(-1.5f, 0.5f) * v_23);
      let v_31 = (v_20 + vec4<f32>(v_30.x, v_30.y, 0.0f, 0.0f));
      let v_32 = (v_31.z - 0.00100000004749745131f);
      let v_33 = (vec2<f32>(-1.5f, 1.5f) * v_23);
      let v_34 = (v_20 + vec4<f32>(v_33.x, v_33.y, 0.0f, 0.0f));
      let v_35 = (v_34.z - 0.00100000004749745131f);
      let v_36 = (vec2<f32>(-0.5f, -1.5f) * v_23);
      let v_37 = (v_20 + vec4<f32>(v_36.x, v_36.y, 0.0f, 0.0f));
      let v_38 = (v_37.z - 0.00100000004749745131f);
      let v_39 = (vec2<f32>(-0.5f) * v_23);
      let v_40 = (v_20 + vec4<f32>(v_39.x, v_39.y, 0.0f, 0.0f));
      let v_41 = (v_40.z - 0.00100000004749745131f);
      let v_42 = (vec2<f32>(-0.5f, 0.5f) * v_23);
      let v_43 = (v_20 + vec4<f32>(v_42.x, v_42.y, 0.0f, 0.0f));
      let v_44 = (v_43.z - 0.00100000004749745131f);
      let v_45 = (vec2<f32>(-0.5f, 1.5f) * v_23);
      let v_46 = (v_20 + vec4<f32>(v_45.x, v_45.y, 0.0f, 0.0f));
      let v_47 = (v_46.z - 0.00100000004749745131f);
      let v_48 = (vec2<f32>(0.5f, -1.5f) * v_23);
      let v_49 = (v_20 + vec4<f32>(v_48.x, v_48.y, 0.0f, 0.0f));
      let v_50 = (v_49.z - 0.00100000004749745131f);
      let v_51 = (vec2<f32>(0.5f, -0.5f) * v_23);
      let v_52 = (v_20 + vec4<f32>(v_51.x, v_51.y, 0.0f, 0.0f));
      let v_53 = (v_52.z - 0.00100000004749745131f);
      let v_54 = (vec2<f32>(0.5f) * v_23);
      let v_55 = (v_20 + vec4<f32>(v_54.x, v_54.y, 0.0f, 0.0f));
      let v_56 = (v_55.z - 0.00100000004749745131f);
      let v_57 = (vec2<f32>(0.5f, 1.5f) * v_23);
      let v_58 = (v_20 + vec4<f32>(v_57.x, v_57.y, 0.0f, 0.0f));
      let v_59 = (v_58.z - 0.00100000004749745131f);
      let v_60 = (vec2<f32>(1.5f, -1.5f) * v_23);
      let v_61 = (v_20 + vec4<f32>(v_60.x, v_60.y, 0.0f, 0.0f));
      let v_62 = (v_61.z - 0.00100000004749745131f);
      let v_63 = (vec2<f32>(1.5f, -0.5f) * v_23);
      let v_64 = (v_20 + vec4<f32>(v_63.x, v_63.y, 0.0f, 0.0f));
      let v_65 = (v_64.z - 0.00100000004749745131f);
      let v_66 = (vec2<f32>(1.5f, 0.5f) * v_23);
      let v_67 = (v_20 + vec4<f32>(v_66.x, v_66.y, 0.0f, 0.0f));
      let v_68 = (v_67.z - 0.00100000004749745131f);
      let v_69 = (vec2<f32>(1.5f) * v_23);
      let v_70 = (v_20 + vec4<f32>(v_69.x, v_69.y, 0.0f, 0.0f));
      let v_71 = (v_70.z - 0.00100000004749745131f);
      v_21 = ((((((((((((((((textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_25.x, v_25.y, v_26).xy, v_26) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_28.x, v_28.y, v_29).xy, v_29)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_31.x, v_31.y, v_32).xy, v_32)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_34.x, v_34.y, v_35).xy, v_35)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_37.x, v_37.y, v_38).xy, v_38)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_40.x, v_40.y, v_41).xy, v_41)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_43.x, v_43.y, v_44).xy, v_44)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_46.x, v_46.y, v_47).xy, v_47)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_49.x, v_49.y, v_50).xy, v_50)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_52.x, v_52.y, v_53).xy, v_53)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_55.x, v_55.y, v_56).xy, v_56)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_58.x, v_58.y, v_59).xy, v_59)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_61.x, v_61.y, v_62).xy, v_62)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_64.x, v_64.y, v_65).xy, v_65)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_67.x, v_67.y, v_68).xy, v_68)) + textureSampleCompareLevel(s_shadowMapTexture, s_shadowMapSamplerComparison, vec3<f32>(v_70.x, v_70.y, v_71).xy, v_71)) * 0.0625f);
    }
  }
  let v_72 = (v_2 * v_21);
  let v_73 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0).xyz;
  let v_74 = (textureSample(s_lightTexture, s_lightSampler, v_texcoord0).xyz * v_73);
  let v_75 = v.u_rsmAmount.x;
  let v_76 = mix((v_73 * v_72), v_74, vec3<f32>(v_75, v_75, v_75));
  bgfx_FragData0 = vec4<f32>(v_76.x, v_76.y, v_76.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
