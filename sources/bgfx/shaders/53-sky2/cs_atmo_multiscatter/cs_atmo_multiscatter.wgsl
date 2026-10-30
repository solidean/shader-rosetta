diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_atmo_transmittanceSampler : sampler;

@group(0u) @binding(2u) var s_atmo_transmittanceTexture : texture_2d<f32>;

struct UniformBlock {
  u_atmoRayleigh : vec4<f32>,
  u_atmoMie : vec4<f32>,
  u_atmoOzone : vec4<f32>,
  u_atmoPlanet : vec4<f32>,
  u_atmoGround : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(3u) var s_multiscatter_out : texture_storage_2d<rgba16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  switch(0u) {
    default: {
      let v_2 = v_1.xy;
      if (((v_1.x >= 32i) | (v_1.y >= 32i))) {
        break;
      }
      let v_3 = ((vec2<f32>(v_2) + vec2<f32>(0.5f)) * vec2<f32>(0.03125f));
      let v_4 = ((v_3.x * 2.0f) - 1.0f);
      let v_5 = v.u_atmoPlanet.x;
      let v_6 = v.u_atmoPlanet.y;
      let v_7 = (v_6 - v_5);
      let v_8 = (v_5 + (v_3.y * v_7));
      let v_9 = (v_8 + 0.00999999977648258209f);
      let v_10 = vec3<f32>(sqrt(max((1.0f - (v_4 * v_4)), 0.0f)), 0.0f, v_4);
      var v_11 : vec3<f32>;
      var v_12 : vec3<f32>;
      {
        var v_13 : vec3<f32>;
        v_13 = vec3<f32>();
        var v_14 : vec3<f32>;
        v_14 = vec3<f32>();
        var v_15 : i32;
        v_15 = 0i;
        loop {
          var v_16 : vec3<f32>;
          var v_17 : vec3<f32>;
          let v_18 = v_15;
          let v_19 = v_14;
          let v_20 = v_13;
          if ((v_18 < 8i)) {
            var v_21 : vec3<f32>;
            var v_22 : vec3<f32>;
            {
              var v_23 : vec3<f32>;
              v_23 = v_20;
              var v_24 : vec3<f32>;
              v_24 = v_19;
              var v_25 : i32;
              v_25 = 0i;
              loop {
                var v_26 : vec3<f32>;
                var v_27 : vec3<f32>;
                let v_28 = v_25;
                let v_29 = v_24;
                let v_30 = v_23;
                if ((v_28 < 8i)) {
                  let v_31 = (1.0f - ((f32(v_18) + 0.5f) * 0.25f));
                  let v_32 = (v_31 * v_31);
                  let v_33 = sqrt(max((1.0f - v_32), 0.0f));
                  let v_34 = ((f32(v_28) + 0.5f) * 0.78539818525314331055f);
                  let v_35 = vec3<f32>((v_33 * cos(v_34)), (v_33 * sin(v_34)), v_31);
                  let v_36 = ((v_9 * v_9) * (v_32 - 1.0f));
                  let v_37 = (v_5 * v_5);
                  let v_38 = (v_36 + v_37);
                  let v_39 = ((v_31 < 0.0f) & (v_38 >= 0.0f));
                  var v_40 : f32;
                  if (v_39) {
                    v_40 = max(0.0f, (((-0.00999999977648258209f - v_8) * v_31) - sqrt(max(v_38, 0.0f))));
                  } else {
                    v_40 = max(0.0f, (((-0.00999999977648258209f - v_8) * v_31) + sqrt(max((v_36 + (v_6 * v_6)), 0.0f))));
                  }
                  let v_41 = v_40;
                  let v_42 = (v_41 * 0.05000000074505805969f);
                  let v_43 = dot(v_35, v_10);
                  let v_44 = (1.0f + (v_43 * v_43));
                  let v_45 = v.u_atmoMie.w;
                  let v_46 = (v_45 * v_45);
                  let v_47 = ((1.0f + v_46) - ((2.0f * v_45) * v_43));
                  let v_48 = ((0.11936620622873306274f * ((1.0f - v_46) * v_44)) / (((2.0f + v_46) * v_47) * sqrt(max(v_47, 0.00000099999999747524f))));
                  var v_49 : vec3<f32>;
                  var v_50 : vec3<f32>;
                  var v_51 : vec3<f32>;
                  {
                    var v_52 : vec3<f32>;
                    v_52 = vec3<f32>();
                    var v_53 : vec3<f32>;
                    v_53 = vec3<f32>();
                    var v_54 : vec3<f32>;
                    v_54 = vec3<f32>(1.0f);
                    var v_55 : i32;
                    v_55 = 0i;
                    loop {
                      let v_56 = v_55;
                      let v_57 = v_54;
                      let v_58 = v_53;
                      let v_59 = v_52;
                      if ((v_56 < 20i)) {
                        continue;
                      } else {
                        v_49 = v_57;
                        v_50 = v_58;
                        v_51 = v_59;
                        break;
                      }

                      continuing {
                        let v_60 = (vec3<f32>(0.0f, 0.0f, v_9) + (v_35 * ((f32(v_56) + 0.5f) * v_42)));
                        let v_61 = length(v_60);
                        let v_62 = (dot(v_60, v_10) / v_61);
                        let v_63 = max((v_61 - v_5), 0.0f);
                        let v_64 = -(v_63);
                        let v_65 = exp((v_64 / v.u_atmoRayleigh.w));
                        let v_66 = exp((v_64 / v.u_atmoMie.z));
                        let v_67 = max(0.0f, (1.0f - (abs((v_63 - v.u_atmoPlanet.z)) / v.u_atmoPlanet.w)));
                        let v_68 = (v.u_atmoRayleigh.xyz * v_65);
                        let v_69 = (v.u_atmoMie.x * v_66);
                        let v_70 = (v.u_atmoMie.y * v_66);
                        let v_71 = ((v_68 + vec3<f32>(v_70, v_70, v_70)) + (v.u_atmoOzone.xyz * v_67));
                        let v_72 = (v_68 + vec3<f32>(v_69, v_69, v_69));
                        let v_73 = (v_6 * v_6);
                        let v_74 = sqrt((v_73 - v_37));
                        let v_75 = (v_61 * v_61);
                        let v_76 = sqrt(max((v_75 - v_37), 0.0f));
                        let v_77 = (v_75 * ((v_62 * v_62) - 1.0f));
                        let v_78 = (v_6 - v_61);
                        let v_79 = (v_69 * v_48);
                        let v_80 = ((((v_68 * (0.05968310311436653137f * v_44)) + vec3<f32>(v_79, v_79, v_79)) * textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_61) * v_62) + sqrt(max((v_77 + v_73), 0.0f)))) - v_78) / ((v_76 + v_74) - v_78)), (v_76 / v_74)), 0.0f).xyz) * select(1.0f, 0.0f, ((v_62 < 0.0f) & ((v_77 + v_37) >= 0.0f))));
                        let v_81 = exp((-(v_71) * v_42));
                        let v_82 = max(v_71, vec3<f32>(0.00000010000000116861f));
                        v_52 = (v_59 + ((v_57 * (v_72 - (v_72 * v_81))) / v_82));
                        v_53 = (v_58 + ((v_57 * (v_80 - (v_80 * v_81))) / v_82));
                        v_54 = (v_57 * v_81);
                        v_55 = (v_56 + 1i);
                      }
                    }
                  }
                  let v_83 = v_51;
                  let v_84 = v_50;
                  let v_85 = v_49;
                  var v_86 : vec3<f32>;
                  if (v_39) {
                    let v_87 = clamp((dot((vec3<f32>(0.0f, 0.0f, v_9) + (v_35 * v_41)), v_10) / v_5), -1.0f, 1.0f);
                    let v_88 = (v_6 * v_6);
                    let v_89 = sqrt((v_88 - v_37));
                    v_86 = (v_84 + ((((v_85 * textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_5) * v_87) + sqrt(max(((v_37 * ((v_87 * v_87) - 1.0f)) + v_88), 0.0f)))) - v_7) / (v_89 - v_7)), 0.0f), 0.0f).xyz) * max(v_87, 0.0f)) * v.u_atmoGround.xyz) * vec3<f32>(0.31830987334251403809f)));
                  } else {
                    v_86 = v_84;
                  }
                  let v_90 = (v_29 + (((v_86 * 0.07957746833562850952f) * 12.56637096405029296875f) * 0.015625f));
                  v_26 = (v_30 + (((v_83 * 0.07957746833562850952f) * 12.56637096405029296875f) * 0.015625f));
                  v_27 = v_90;
                  continue;
                } else {
                  v_21 = v_30;
                  v_22 = v_29;
                  break;
                }

                continuing {
                  let v_91 = v_27;
                  v_23 = v_26;
                  v_24 = v_91;
                  v_25 = (v_28 + 1i);
                }
              }
            }
            let v_92 = v_22;
            v_16 = v_21;
            v_17 = v_92;
            continue;
          } else {
            v_11 = v_20;
            v_12 = v_19;
            break;
          }

          continuing {
            let v_93 = v_17;
            v_13 = v_16;
            v_14 = v_93;
            v_15 = (v_18 + 1i);
          }
        }
      }
      let v_94 = (v_12 / max((vec3<f32>(1.0f) - v_11), vec3<f32>(0.00009999999747378752f)));
      textureStore(s_multiscatter_out, v_2, vec4<f32>(v_94.x, v_94.y, v_94.z, 1.0f));
    }
  }
}
