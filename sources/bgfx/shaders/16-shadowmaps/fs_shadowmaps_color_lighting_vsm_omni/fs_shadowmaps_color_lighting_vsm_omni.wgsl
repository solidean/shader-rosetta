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
  u_tetraNormalGreen : vec4<f32>,
  u_tetraNormalYellow : vec4<f32>,
  u_tetraNormalBlue : vec4<f32>,
  u_tetraNormalRed : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_position : vec4<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = v_position.xyz;
  let v_2 = dot(v.u_tetraNormalGreen.xyz, v_1);
  let v_3 = dot(v.u_tetraNormalYellow.xyz, v_1);
  let v_4 = dot(v.u_tetraNormalBlue.xyz, v_1);
  let v_5 = dot(v.u_tetraNormalRed.xyz, v_1);
  let v_6 = max(max(v_2, v_3), max(v_4, v_5));
  var v_7 : vec4<f32>;
  var v_8 : vec3<f32>;
  if ((v_2 == v_6)) {
    let v_9 = v_texcoord1.w;
    let v_10 = (v_texcoord1.xy / vec2<f32>(v_9, v_9));
    let v_11 = select(0.0f, 0.30000001192092895508f, (all((v_10 > vec2<f32>())) & all((v_10 < vec2<f32>(1.0f)))));
    let v_12 = -(v_11);
    v_7 = v_texcoord1;
    v_8 = vec3<f32>(v_12, v_11, v_12);
  } else {
    var v_13 : vec4<f32>;
    var v_14 : vec3<f32>;
    if ((v_3 == v_6)) {
      let v_15 = v_texcoord2.w;
      let v_16 = (v_texcoord2.xy / vec2<f32>(v_15, v_15));
      let v_17 = select(0.0f, 0.30000001192092895508f, (all((v_16 > vec2<f32>())) & all((v_16 < vec2<f32>(1.0f)))));
      v_13 = v_texcoord2;
      v_14 = vec3<f32>(v_17, v_17, -(v_17));
    } else {
      let v_18 = (v_4 == v_6);
      var v_19 : vec3<f32>;
      if (v_18) {
        let v_20 = v_texcoord3.w;
        let v_21 = (v_texcoord3.xy / vec2<f32>(v_20, v_20));
        let v_22 = select(0.0f, 0.30000001192092895508f, (all((v_21 > vec2<f32>())) & all((v_21 < vec2<f32>(1.0f)))));
        let v_23 = -(v_22);
        v_19 = vec3<f32>(v_23, v_23, v_22);
      } else {
        let v_24 = v_texcoord4.w;
        let v_25 = (v_texcoord4.xy / vec2<f32>(v_24, v_24));
        let v_26 = select(0.0f, 0.30000001192092895508f, (all((v_25 > vec2<f32>())) & all((v_25 < vec2<f32>(1.0f)))));
        let v_27 = -(v_26);
        v_19 = vec3<f32>(v_26, v_27, v_27);
      }
      let v_28 = v_19;
      v_13 = select(v_texcoord4, v_texcoord3, vec4<bool>(v_18, v_18, v_18, v_18));
      v_14 = v_28;
    }
    let v_29 = v_14;
    v_7 = v_13;
    v_8 = v_29;
  }
  let v_30 = v_8;
  let v_31 = v_7;
  let v_32 = v.u_params1.x;
  let v_33 = v.u_params1.w;
  let v_34 = v.u_params1.z;
  var v_35 : f32;
  switch(0u) {
    default: {
      let v_36 = v_31.w;
      let v_37 = (v_31.xy / vec2<f32>(v_36, v_36));
      if ((any((v_37 > vec2<f32>(1.0f))) | any((v_37 < vec2<f32>())))) {
        v_35 = 1.0f;
        break;
      }
      let v_38 = (((v_31.z - v_32) / v_36) * v_33);
      let v_39 = textureSample(s_shadowMap0Texture, s_shadowMap0Sampler, v_37);
      let v_40 = (vec2<f32>(dot(v_39.xy, vec2<f32>(0.0039215688593685627f, 1.0f)), dot(v_39.zw, vec2<f32>(0.0039215688593685627f, 1.0f))) * v_33);
      let v_41 = v_40.x;
      if ((v_38 < v_41)) {
        v_35 = 1.0f;
        break;
      }
      let v_42 = max((v_40.y - (v_41 * v_41)), v_34);
      let v_43 = (v_38 - v_41);
      v_35 = (v_42 / (v_42 + (v_43 * v_43)));
    }
  }
  let v_44 = v_35;
  let v_45 = -(normalize(v_view));
  let v_46 = v.u_lightPosition;
  let v_47 = v.u_lightSpotDirectionInner.xyz;
  let v_48 = v.u_lightSpotDirectionInner.w;
  let v_49 = v.u_lightAttenuationSpotOuter.w;
  let v_50 = v.u_lightAttenuationSpotOuter;
  let v_51 = v_46.xyz;
  let v_52 = -(normalize(v_51));
  var v_53 : vec3<f32>;
  var v_54 : f32;
  if (!((0.0f == v_46.w))) {
    let v_55 = (v_51 - v_view);
    let v_56 = normalize(v_55);
    let v_57 = max(0.0f, dot(-(v_56), normalize(v_47)));
    let v_58 = cos(radians(v_49));
    let v_59 = clamp(((v_57 - v_58) / (cos(radians(min(v_48, (v_49 - 0.00100000004749745131f)))) - v_58)), 0.0f, 1.0f);
    let v_60 = length(v_55);
    let v_61 = ((1.0f / ((v_50.x + (v_50.y * v_60)) + ((v_50.z * v_60) * v_60))) * mix(v_59, 1.0f, step(90.0f, v_49)));
    v_53 = v_56;
    v_54 = v_61;
  } else {
    v_53 = v_52;
    v_54 = 1.0f;
  }
  let v_62 = v_54;
  let v_63 = v_53;
  let v_64 = v.u_materialKs.w;
  let v_65 = dot(v_normal, v_63);
  let v_66 = dot(((v_normal * (2.0f * v_65)) - v_63), v_45);
  let v_67 = (max(vec2<f32>(v_65, (((step(0.0f, v_65) * pow(max(0.0f, v_66), v_64)) * (2.0f + v_64)) * 0.125f)), vec2<f32>()) * v_62);
  let v_68 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_69 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_67.x);
  let v_70 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_67.y);
  let v_71 = length(v_view);
  let v_72 = clamp((1.0f / exp2((((0.0000122500005090842f * v_71) * v_71) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_73 = v.u_color.xyz;
  let v_74 = mix(vec3<f32>(), (pow(abs(abs(((v_68 * v_73) + (((v_69 + v_70) * v_73) * v_44)))), vec3<f32>(0.45454546809196472168f)) + (v_30 * v.u_params2.y)), vec3<f32>(v_72, v_72, v_72));
  bgfx_FragData0 = vec4<f32>(v_74.x, v_74.y, v_74.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_position : vec4<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_position, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
