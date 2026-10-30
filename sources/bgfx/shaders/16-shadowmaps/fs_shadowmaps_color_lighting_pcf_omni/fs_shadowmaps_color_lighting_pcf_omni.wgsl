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
  let v_35 = (fract((52.98291778564453125f * fract(dot(gl_FragCoord.xy, vec2<f32>(0.0671105608344078064f, 0.00583714991807937622f))))) * 6.28318500518798828125f);
  let v_36 = sin(v_35);
  let v_37 = cos(v_35);
  var v_38 : f32;
  {
    var v_39 : f32;
    v_39 = 0.0f;
    var v_40 : i32;
    v_40 = 0i;
    loop {
      var v_41 : f32;
      let v_42 = v_40;
      let v_43 = v_39;
      if ((v_42 < 16i)) {
        let v_44 = f32(v_42);
        let v_45 = sqrt(((v_44 + 0.5f) * 0.10000000149011611938f));
        let v_46 = (v_44 * 2.39996314048767089844f);
        let v_47 = (vec2<f32>(cos(v_46), sin(v_46)) * v_45);
        let v_48 = v_47.x;
        let v_49 = v_47.y;
        let v_50 = (vec2<f32>(((v_48 * v_37) - (v_49 * v_36)), ((v_48 * v_36) + (v_49 * v_37))) * (((vec2<f32>(2.0f) * v_34.zw) * vec2<f32>(v_1, v_1)) * v_32.w));
        let v_51 = (v_32 + vec4<f32>(v_50.x, v_50.y, 0.0f, 0.0f));
        var v_52 : f32;
        switch(0u) {
          default: {
            let v_53 = v_51.w;
            let v_54 = (v_51.xy / vec2<f32>(v_53, v_53));
            if ((any((v_54 > vec2<f32>(1.0f))) | any((v_54 < vec2<f32>())))) {
              v_52 = 1.0f;
              break;
            }
            v_52 = step(((v_51.z - v_33) / v_53), dot(textureSampleLevel(s_shadowMap0Texture, s_shadowMap0Sampler, v_54, 0.0f), vec4<f32>(0.0000000603086292017f, 0.00001537870048196055f, 0.0039215688593685627f, 1.0f)));
          }
        }
        v_41 = (v_43 + v_52);
        continue;
      } else {
        v_38 = v_43;
        break;
      }

      continuing {
        v_39 = v_41;
        v_40 = (v_42 + 1i);
      }
    }
  }
  let v_55 = (v_38 * 0.0625f);
  let v_56 = -(normalize(v_view));
  let v_57 = v.u_lightPosition;
  let v_58 = v.u_lightSpotDirectionInner.xyz;
  let v_59 = v.u_lightSpotDirectionInner.w;
  let v_60 = v.u_lightAttenuationSpotOuter.w;
  let v_61 = v.u_lightAttenuationSpotOuter;
  let v_62 = v_57.xyz;
  let v_63 = -(normalize(v_62));
  var v_64 : vec3<f32>;
  var v_65 : f32;
  if (!((0.0f == v_57.w))) {
    let v_66 = (v_62 - v_view);
    let v_67 = normalize(v_66);
    let v_68 = max(0.0f, dot(-(v_67), normalize(v_58)));
    let v_69 = cos(radians(v_60));
    let v_70 = clamp(((v_68 - v_69) / (cos(radians(min(v_59, (v_60 - 0.00100000004749745131f)))) - v_69)), 0.0f, 1.0f);
    let v_71 = length(v_66);
    let v_72 = ((1.0f / ((v_61.x + (v_61.y * v_71)) + ((v_61.z * v_71) * v_71))) * mix(v_70, 1.0f, step(90.0f, v_60)));
    v_64 = v_67;
    v_65 = v_72;
  } else {
    v_64 = v_63;
    v_65 = 1.0f;
  }
  let v_73 = v_65;
  let v_74 = v_64;
  let v_75 = v.u_materialKs.w;
  let v_76 = dot(v_normal, v_74);
  let v_77 = dot(((v_normal * (2.0f * v_76)) - v_74), v_56);
  let v_78 = (max(vec2<f32>(v_76, (((step(0.0f, v_76) * pow(max(0.0f, v_77), v_75)) * (2.0f + v_75)) * 0.125f)), vec2<f32>()) * v_73);
  let v_79 = ((v.u_lightAmbientPower.xyz * v.u_lightAmbientPower.w) * v.u_materialKa.xyz);
  let v_80 = (((v.u_lightDiffusePower.xyz * v.u_lightDiffusePower.w) * v.u_materialKd.xyz) * v_78.x);
  let v_81 = (((v.u_lightSpecularPower.xyz * v.u_lightSpecularPower.w) * v.u_materialKs.xyz) * v_78.y);
  let v_82 = length(v_view);
  let v_83 = clamp((1.0f / exp2((((0.0000122500005090842f * v_82) * v_82) * 1.44269502162933349609f))), 0.0f, 1.0f);
  let v_84 = v.u_color.xyz;
  let v_85 = mix(vec3<f32>(), (pow(abs(abs(((v_79 * v_84) + (((v_80 + v_81) * v_84) * v_55)))), vec3<f32>(0.45454546809196472168f)) + (v_31 * v.u_params2.y)), vec3<f32>(v_83, v_83, v_83));
  bgfx_FragData0 = vec4<f32>(v_85.x, v_85.y, v_85.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_normal : vec3<f32>, @location(1u) v_position : vec4<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>, @location(4u) v_texcoord3 : vec4<f32>, @location(5u) v_texcoord4 : vec4<f32>, @location(6u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_normal, v_position, v_texcoord1, v_texcoord2, v_texcoord3, v_texcoord4, v_view);
  return bgfx_FragData0;
}
