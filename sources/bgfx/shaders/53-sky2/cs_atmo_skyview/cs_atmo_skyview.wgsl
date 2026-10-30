diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_atmo_transmittanceSampler : sampler;

@group(0u) @binding(2u) var s_atmo_transmittanceTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_atmo_multiscatterSampler : sampler;

@group(0u) @binding(4u) var s_atmo_multiscatterTexture : texture_2d<f32>;

struct UniformBlock {
  u_atmoRayleigh : vec4<f32>,
  u_atmoMie : vec4<f32>,
  u_atmoOzone : vec4<f32>,
  u_atmoPlanet : vec4<f32>,
  u_atmoGround : vec4<f32>,
  u_atmo_params : vec4<f32>,
  u_atmo_params2 : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(3u) var s_skyview_out : texture_storage_2d<rgba16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  switch(0u) {
    default: {
      let v_2 = v_1.xy;
      let v_3 = vec2<i32>(v.u_atmo_params2.zw);
      if (((v_1.x >= v_3.x) | (v_1.y >= v_3.y))) {
        break;
      }
      let v_4 = ((vec2<f32>(v_2) + vec2<f32>(0.5f)) / vec2<f32>(v_3));
      let v_5 = v.u_atmo_params2.y;
      let v_6 = (v_5 * v_5);
      let v_7 = v.u_atmoPlanet.x;
      let v_8 = (v_7 * v_7);
      let v_9 = acos(clamp((sqrt(max((v_6 - v_8), 0.0f)) / v_5), -1.0f, 1.0f));
      let v_10 = (3.14159274101257324219f - v_9);
      let v_11 = v_4.y;
      var v_12 : f32;
      if ((v_11 < 0.5f)) {
        let v_13 = (1.0f - (v_11 * 2.0f));
        v_12 = (v_10 * (1.0f - (v_13 * v_13)));
      } else {
        let v_14 = ((v_11 * 2.0f) - 1.0f);
        v_12 = (v_10 + ((v_9 * v_14) * v_14));
      }
      let v_15 = cos(v_12);
      let v_16 = ((v_4.x - 0.5f) * 6.28318548202514648438f);
      let v_17 = v.u_atmo_params2.x;
      let v_18 = vec3<f32>(sqrt(max((1.0f - (v_17 * v_17)), 0.0f)), 0.0f, v_17);
      let v_19 = (v_15 * v_15);
      let v_20 = sqrt(max((1.0f - v_19), 0.0f));
      let v_21 = vec3<f32>((v_20 * cos(v_16)), (v_20 * sin(v_16)), v_15);
      let v_22 = (v_6 * (v_19 - 1.0f));
      let v_23 = (v_22 + v_8);
      let v_24 = ((v_15 < 0.0f) & (v_23 >= 0.0f));
      var v_25 : f32;
      if (v_24) {
        v_25 = max(0.0f, ((-(v_5) * v_15) - sqrt(max(v_23, 0.0f))));
      } else {
        let v_26 = v.u_atmoPlanet.y;
        v_25 = max(0.0f, ((-(v_5) * v_15) + sqrt(max((v_22 + (v_26 * v_26)), 0.0f))));
      }
      let v_27 = v_25;
      let v_28 = (v_27 * 0.0625f);
      let v_29 = dot(v_21, v_18);
      let v_30 = (1.0f + (v_29 * v_29));
      let v_31 = v.u_atmoMie.w;
      let v_32 = (v_31 * v_31);
      let v_33 = ((1.0f + v_32) - ((2.0f * v_31) * v_29));
      let v_34 = ((0.11936620622873306274f * ((1.0f - v_32) * v_30)) / (((2.0f + v_32) * v_33) * sqrt(max(v_33, 0.00000099999999747524f))));
      var v_35 : vec3<f32>;
      var v_36 : vec3<f32>;
      {
        var v_37 : vec3<f32>;
        v_37 = vec3<f32>();
        var v_38 : vec3<f32>;
        v_38 = vec3<f32>(1.0f);
        var v_39 : i32;
        v_39 = 0i;
        loop {
          let v_40 = v_39;
          let v_41 = v_38;
          let v_42 = v_37;
          if ((v_40 < 16i)) {
            continue;
          } else {
            v_35 = v_41;
            v_36 = v_42;
            break;
          }

          continuing {
            let v_43 = (vec3<f32>(0.0f, 0.0f, v_5) + (v_21 * ((f32(v_40) + 0.5f) * v_28)));
            let v_44 = length(v_43);
            let v_45 = (v_44 - v_7);
            let v_46 = (dot(v_43, v_18) / v_44);
            let v_47 = max(v_45, 0.0f);
            let v_48 = -(v_47);
            let v_49 = exp((v_48 / v.u_atmoRayleigh.w));
            let v_50 = exp((v_48 / v.u_atmoMie.z));
            let v_51 = max(0.0f, (1.0f - (abs((v_47 - v.u_atmoPlanet.z)) / v.u_atmoPlanet.w)));
            let v_52 = (v.u_atmoRayleigh.xyz * v_49);
            let v_53 = (v.u_atmoMie.x * v_50);
            let v_54 = (v.u_atmoMie.y * v_50);
            let v_55 = ((v_52 + vec3<f32>(v_54, v_54, v_54)) + (v.u_atmoOzone.xyz * v_51));
            let v_56 = v.u_atmoPlanet.y;
            let v_57 = (v_56 * v_56);
            let v_58 = sqrt((v_57 - v_8));
            let v_59 = (v_44 * v_44);
            let v_60 = sqrt(max((v_59 - v_8), 0.0f));
            let v_61 = (v_59 * ((v_46 * v_46) - 1.0f));
            let v_62 = (v_56 - v_44);
            let v_63 = textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_44) * v_46) + sqrt(max((v_61 + v_57), 0.0f)))) - v_62) / ((v_60 + v_58) - v_62)), (v_60 / v_58)), 0.0f).xyz;
            let v_64 = textureSampleLevel(s_atmo_multiscatterTexture, s_atmo_multiscatterSampler, vec2<f32>(((v_46 * 0.5f) + 0.5f), (v_45 / (v_56 - v_7))), 0.0f).xyz;
            let v_65 = (v_53 * v_34);
            let v_66 = (((((v_52 * (0.05968310311436653137f * v_30)) + vec3<f32>(v_65, v_65, v_65)) * v_63) * select(1.0f, 0.0f, ((v_46 < 0.0f) & ((v_61 + v_8) >= 0.0f)))) + (((v_52 + vec3<f32>(v_53, v_53, v_53)) * v_64) * v.u_atmoOzone.w));
            let v_67 = exp((-(v_55) * v_28));
            v_37 = (v_42 + ((v_41 * (v_66 - (v_66 * v_67))) / max(v_55, vec3<f32>(0.00000010000000116861f))));
            v_38 = (v_41 * v_67);
            v_39 = (v_40 + 1i);
          }
        }
      }
      let v_68 = v_36;
      let v_69 = v_35;
      var v_70 : vec3<f32>;
      if (v_24) {
        let v_71 = clamp((dot((vec3<f32>(0.0f, 0.0f, v_5) + (v_21 * v_27)), v_18) / v_7), -1.0f, 1.0f);
        let v_72 = v.u_atmoPlanet.y;
        let v_73 = (v_72 * v_72);
        let v_74 = sqrt((v_73 - v_8));
        let v_75 = (v_72 - v_7);
        v_70 = (v_68 + ((((v_69 * textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_7) * v_71) + sqrt(max(((v_8 * ((v_71 * v_71) - 1.0f)) + v_73), 0.0f)))) - v_75) / (v_74 - v_75)), 0.0f), 0.0f).xyz) * max(v_71, 0.0f)) * v.u_atmoGround.xyz) * vec3<f32>(0.31830987334251403809f)));
      } else {
        v_70 = v_68;
      }
      let v_76 = (v_70 * v.u_atmo_params.xyz);
      textureStore(s_skyview_out, v_2, vec4<f32>(v_76.x, v_76.y, v_76.z, 1.0f));
    }
  }
}
