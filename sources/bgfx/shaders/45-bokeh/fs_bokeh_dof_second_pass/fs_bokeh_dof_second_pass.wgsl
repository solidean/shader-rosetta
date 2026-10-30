diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
  u_viewTexel : vec4<f32>,
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSampleLevel(s_colorTexture, s_colorSampler, v_texcoord0, 0.0f);
  let v_2 = v_1.w;
  let v_3 = abs(v_2);
  let v_4 = (fract((sin(dot(((v_texcoord0 * v.u_viewRect.zw) + (vec2<f32>(314.0f, 159.0f) * v.u_params[0i].z)), vec2<f32>(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f)) * 6.28318548202514648438f);
  let v_5 = v.u_params[3i].w;
  let v_6 = v.u_params[3i].x;
  var v_7 : f32;
  var v_8 : vec3<f32>;
  var v_9 : f32;
  {
    var v_10 : f32;
    v_10 = v_4;
    var v_11 : f32;
    v_11 = 0.0f;
    var v_12 : vec3<f32>;
    v_12 = v_1.xyz;
    var v_13 : f32;
    v_13 = 1.0f;
    var v_14 : f32;
    v_14 = v_5;
    loop {
      var v_15 : f32;
      var v_16 : f32;
      var v_17 : vec3<f32>;
      var v_18 : f32;
      var v_19 : f32;
      let v_20 = v_14;
      let v_21 = v_13;
      let v_22 = v_12;
      let v_23 = v_11;
      let v_24 = v_10;
      if ((v_20 < v_6)) {
        let v_25 = v.u_params[2i].y;
        let v_26 = v.u_params[2i].z;
        let v_27 = v.u_params[2i].w;
        let v_28 = v.u_params[0i].w;
        var v_29 : f32;
        switch(0u) {
          default: {
            if ((v_25 <= 1.0f)) {
              v_29 = 1.0f;
              break;
            }
            v_29 = ((abs((fract(((v_24 * (v_25 * 0.15915495157241821289f)) + v_28)) - 0.5f)) * v_27) + v_26);
          }
        }
        let v_30 = v_29;
        let v_31 = textureSampleLevel(s_colorTexture, s_colorSampler, (v_texcoord0 + ((vec2<f32>(cos(v_24), sin(v_24)) * v.u_viewTexel.xy) * (v_20 * v_30))), 0.0f);
        let v_32 = v_31.w;
        let v_33 = abs(v_32);
        var v_34 : f32;
        if ((v_32 > v_2)) {
          v_34 = clamp(v_33, 0.0f, (v_3 * 2.0f));
        } else {
          v_34 = v_33;
        }
        let v_35 = v_34;
        let v_36 = smoothstep((v_20 - 0.5f), (v_20 + 0.5f), v_35);
        let v_37 = (v_22 + mix((v_22 / vec3<f32>(v_21, v_21, v_21)), v_31.xyz, vec3<f32>(v_36, v_36, v_36)));
        v_15 = (v_24 + 2.39996314048767089844f);
        v_16 = (v_23 + v_35);
        v_17 = v_37;
        v_18 = (v_21 + 1.0f);
        v_19 = (v_20 + (v_5 / v_20));
        continue;
      } else {
        v_7 = v_21;
        v_8 = v_22;
        v_9 = v_23;
        break;
      }

      continuing {
        let v_38 = v_19;
        let v_39 = v_18;
        let v_40 = v_17;
        let v_41 = v_16;
        v_10 = v_15;
        v_11 = v_41;
        v_12 = v_40;
        v_13 = v_39;
        v_14 = v_38;
      }
    }
  }
  let v_42 = v_9;
  let v_43 = v_8;
  let v_44 = v_7;
  let v_45 = (v_43 * (1.0f / v_44));
  bgfx_FragData0 = vec4<f32>(v_45.x, v_45.y, v_45.z, (v_42 / (v_44 - 1.0f)));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
