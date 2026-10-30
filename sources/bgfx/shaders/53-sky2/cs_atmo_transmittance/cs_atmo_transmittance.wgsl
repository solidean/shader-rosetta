diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_atmoRayleigh : vec4<f32>,
  u_atmoMie : vec4<f32>,
  u_atmoOzone : vec4<f32>,
  u_atmoPlanet : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_transmittance_out : texture_storage_2d<rgba16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  switch(0u) {
    default: {
      let v_2 = v_1.xy;
      if (((v_1.x >= 256i) | (v_1.y >= 64i))) {
        break;
      }
      let v_3 = ((vec2<f32>(v_2) + vec2<f32>(0.5f)) * vec2<f32>(0.00390625f, 0.015625f));
      let v_4 = v.u_atmoPlanet.y;
      let v_5 = (v_4 * v_4);
      let v_6 = v.u_atmoPlanet.x;
      let v_7 = (v_6 * v_6);
      let v_8 = sqrt((v_5 - v_7));
      let v_9 = (v_3.y * v_8);
      let v_10 = (v_9 * v_9);
      let v_11 = sqrt((v_10 + v_7));
      let v_12 = (v_4 - v_11);
      let v_13 = (v_12 + (v_3.x * ((v_9 + v_8) - v_12)));
      let v_14 = (2.0f * v_11);
      let v_15 = select(clamp(((((v_8 * v_8) - v_10) - (v_13 * v_13)) / (v_14 * v_13)), -1.0f, 1.0f), 1.0f, (v_13 <= 0.0f));
      let v_16 = (v_11 * v_11);
      let v_17 = (max(0.0f, ((-(v_11) * v_15) + sqrt(max(((v_16 * ((v_15 * v_15) - 1.0f)) + v_5), 0.0f)))) * 0.02500000037252902985f);
      var v_18 : vec3<f32>;
      {
        var v_19 : vec3<f32>;
        v_19 = vec3<f32>();
        var v_20 : i32;
        v_20 = 0i;
        loop {
          let v_21 = v_20;
          let v_22 = v_19;
          if ((v_21 < 40i)) {
            continue;
          } else {
            v_18 = v_22;
            break;
          }

          continuing {
            let v_23 = ((f32(v_21) + 0.5f) * v_17);
            let v_24 = max((sqrt(((v_16 + (v_23 * v_23)) + ((v_14 * v_15) * v_23))) - v_6), 0.0f);
            let v_25 = -(v_24);
            let v_26 = exp((v_25 / v.u_atmoRayleigh.w));
            let v_27 = exp((v_25 / v.u_atmoMie.z));
            let v_28 = max(0.0f, (1.0f - (abs((v_24 - v.u_atmoPlanet.z)) / v.u_atmoPlanet.w)));
            let v_29 = (v.u_atmoRayleigh.xyz * v_26);
            let v_30 = (v.u_atmoMie.y * v_27);
            v_19 = (v_22 + (((v_29 + vec3<f32>(v_30, v_30, v_30)) + (v.u_atmoOzone.xyz * v_28)) * v_17));
            v_20 = (v_21 + 1i);
          }
        }
      }
      let v_31 = exp(-(v_18));
      textureStore(s_transmittance_out, v_2, vec4<f32>(v_31.x, v_31.y, v_31.z, 1.0f));
    }
  }
}
