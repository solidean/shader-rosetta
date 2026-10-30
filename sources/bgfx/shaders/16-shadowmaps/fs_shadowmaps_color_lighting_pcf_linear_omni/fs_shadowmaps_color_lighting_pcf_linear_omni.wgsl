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

fn main_inner(gl_FragCoord : vec4<f32>, v_normal : vec3<f32>, v_position : vec4<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>, v_texcoord3 : vec4<f32>, v_texcoord4 : vec4<f32>, v_view : vec3<f32>) {
  let v_1 = (v.u_params2.z * 0.25f);
  let v_2 = v_position.xyz;
  let v_3 = dot(v.u_tetraNormalGreen.xyz, v_2);
  let v_4 = dot(v.u_tetraNormalYellow.xyz, v_2);
  let v_5 = dot(v.u_tetraNormalBlue.xyz, v_2);
  let v_6 = dot(v.u_tetraNormalRed.xyz, v_2);
  let v_7 = max(max(v_3, v_4), max(v_5, v_6));
  var v_8 : vec4<f32>;
  var v_9 : vec3<f32>;
  if ((v_3 == v_7)) {
    let v_10 = v_texcoord1.w;
    let v_11 = (v_texcoord1.xy / vec2<f32>(v_10, v_10));
    let v_12 = select(0.0f, 0.30000001192092895508f, (all((v_11 > vec2<f32>())) & all((v_11 < vec2<f32>(1.0f)))));
    let v_13 = -(v_12);
    v_8 = v_texcoord1;
    v_9 = vec3<f32>(v_13, v_12, v_13);
  } else {
    var v_14 : vec4<f32>;
    var v_15 : vec3<f32>;
    if ((v_4 == v_7)) {
      let v_16 = v_texcoord2.w;
      let v_17 = (v_texcoord2.xy / vec2<f32>(v_16, v_16));
      let v_18 = select(0.0f, 0.30000001192092895508f, (all((v_17 > vec2<f32>())) & all((v_17 < vec2<f32>(1.0f)))));
      v_14 = v_texcoord2;
      v_15 = vec3<f32>(v_18, v_18, -(v_18));
    } else {
      let v_19 = (v_5 == v_7);
      var v_20 : vec3<f32>;
      if (v_19) {
        let v_21 = v_texcoord3.w;
        let v_22 = (v_texcoord3.xy / vec2<f32>(v_21, v_21));
        let v_23 = select(0.0f, 0.30000001192092895508f, (all((v_22 > vec2<f32>())) & all((v_22 < vec2<f32>(1.0f)))));
        let v_24 = -(v_23);
        v_20 = vec3<f32>(v_24, v_24, v_23);
      } else {
        let v_25 = v_texcoord4.w;
        let v_26 = (v_texcoord4.xy / vec2<f32>(v_25, v_25));
        let v_27 = select(0.0f, 0.30000001192092895508f, (all((v_26 > vec2<f32>())) & all((v_26 < vec2<f32>(1.0f)))));
        let v_28 = -(v_27);
        v_20 = vec3<f32>(v_27, v_28, v_28);
      }
      let v_29 = v_20;
      v_14 = select(v_texcoord4, v_texcoord3, vec4<bool>(v_19, v_19, v_19, v_19));
      v_15 = v_29;
    }
    let v_30 = v_15;
    v_8 = v_14;
    v_9 = v_30;
  }
  let v_31 = v_9;
  let v_32 = v_8;
  let v_33 = v.u_params1.x;
  let v_34 = v.u_smSamplingParams;
  let v_35 = v_32.w;
  let v_36 = (v_32.xy / vec2<f32>(v_35, v_35));
  let v_37 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
  let v_38 = sin(v_37);
  let v_39 = cos(v_37);
  var v_40 : f32;
  {
    var v_41 : f32;
    v_41 = 0.0f;
    var v_42 : i32;
    v_42 = 0i;
    loop {
      var v_43 : f32;
      let v_44 = v_42;
      let v_45 = v_41;
      if ((v_44 < 16i)) {
        let v_46 = f32(v_44);
        let v_47 = sqrt(((v_46 + 0.5f) * 0.10000000149011611938f));
        let v_48 = (v_46 * 2.39996314048767089844f);
        let v_49 = (vec2<f32>(cos(v_48), sin(v_48)) * v_47);
        let v_50 = v_49.x;
        let v_51 = v_49.y;
        let v_52 = (vec2<f32>(((v_50 * v_39) - (v_51 * v_38)), ((v_50 * v_38) + (v_51 * v_39))) * (((vec2<f32>(2.0f) * v_34.zw) * vec2<f32>(v_1, v_1)) * 1.0f));
        let v_53 = (vec4<f32>(v_36.x, v_36.y, v_32.z, 1.0f) + vec4<f32>(v_52.x, v_52.y, 0.0f, 0.0f));
        var v_54 : f32;
        switch(0u) {
          default: {
            let v_55 = v_53.w;
            let v_56 = (v_53.xy / vec2<f32>(v_55, v_55));
            if ((any((v_56 > vec2<f32>(1.0f))) | any((v_56 < vec2<f32>())))) {
              v_54 = 1.0f;
              break;
            }
            v_54 = step(((v_53.z - v_33) / v_55), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_56, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        v_43 = (v_45 + v_54);
        continue;
      } else {
        v_40 = v_45;
        break;
      }

      continuing {
        v_41 = v_43;
        v_42 = (v_44 + 1i);
      }
    }
  }
  let v_57 = (v_40 * 0.0625f);
  let v_58 = -(normalize(v_view));
  let v_59 = v.u_lightPosition;
  let v_60 = v.u_lightSpotDirectionInner.xyz;
  let v_61 = v.u_lightSpotDirectionInner.w;
  let v_62 = v.u_lightAttenuationSpotOuter.w;
  let v_63 = v.u_lightAttenuationSpotOuter;
  let v_64 = v_59.xyz;
  let v_65 = -(normalize(v_64));
  var v_66 : vec3<f32>;
  var v_67 : f32;
  if (!((0.0f == v_59.w))) {
    let v_68 = (v_64 - v_view);
    let v_69 = normalize(v_68);
    let v_70 = max(0.0f, dot(-(v_69), normalize(v_60)));
    let v_71 = cos(radians(v_62));
    let v_72 = clamp(((v_70 - v_71) / (cos(radians(min(v_61, (v_62 - 0.00100000004749745131f)))) - v_71)), 0.0f, 1.0f);
    let v_73 = length(v_68);
    let v_74 = ((1.0f / ((v_63.x + (v_63.y * v_73)) + ((v_63.z * v_73) * v_73))) * mix(v_72, 1.0f, step(90.0f, v_62)));
    v_66 = v_69;
    v_67 = v_74;
  } else {
    v_66 = v_65;
    v_67 = 1.0f;
  }
  let v_75 = v_67;
  let v_76 = v_66;
  let v_77 = v.u_materialKs.w;
  let v_78 = dot(v_normal, v_76);
  let v_79 = dot(((v_normal * (2.0f * v_78)) - v_76), v_58);
  let v_80 = (max(vec2<f32>(v_78, (((step(0.0f, v_78) * pow(max(0.0f, v_79), v_77)) * (2.0f + v_77)) * 0.125f)), vec2<f32>()) * v_75);
  let v_81 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_82 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_80.x);
  let v_83 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_80.y);
  let v_84 = length(v_view);
  let v_85 = clamp((1.0f / exp2((((0.0000122500005090842f * v_84) * v_84) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_86 = v.u_color.xyz;
  let v_87 = mix(vec3<f32>(), (pow(abs(abs(((v_81 * v_86) + (((v_82 + v_83) * v_86) * v_57)))), vec3<f32>(0.45454546809196472168f)) + (v_31 * v.u_params2.y)), vec3<f32>(v_85, v_85, v_85));
  bgfx_FragData0 = vec4<f32>(v_87.x, v_87.y, v_87.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_position : vec4<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_position, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
