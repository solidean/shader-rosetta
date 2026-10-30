diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
  u_viewTexel : vec4<f32>,
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v.u_params[3i].y;
  let v_2 = v.u_params[3i].z;
  let v_3 = textureSampleLevel(s_colorTexture, s_colorSampler, v_texcoord0, 0.0f).xyz;
  let v_4 = (1.0f / v_1);
  let v_5 = clamp(((v_4 - (1.0f / textureSampleLevel(s_depthTexture, s_depthSampler, v_texcoord0, 0.0f).x)) * v_2), -1.0f, 1.0f);
  let v_6 = v.u_params[3i].x;
  let v_7 = (v_5 * v_6);
  let v_8 = abs(v_7);
  let v_9 = (fract((sin(dot(((v_texcoord0 * v.u_viewRect.zw) + (vec2<f32>(314.0f, 159.0f) * v.u_params[0i].z)), vec2<f32>(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f)) * 6.28318548202514648438f);
  let v_10 = v.u_params[3i].w;
  var v_11 : f32;
  var v_12 : vec3<f32>;
  {
    var v_13 : f32;
    v_13 = v_9;
    var v_14 : vec3<f32>;
    v_14 = v_3;
    var v_15 : f32;
    v_15 = 1.0f;
    var v_16 : f32;
    v_16 = v_10;
    loop {
      var v_17 : f32;
      var v_18 : vec3<f32>;
      var v_19 : f32;
      var v_20 : f32;
      let v_21 = v_16;
      let v_22 = v_15;
      let v_23 = v_14;
      let v_24 = v_13;
      if ((v_21 < v_6)) {
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
        let v_31 = (v_texcoord0 + ((vec2<f32>(cos(v_24), sin(v_24)) * v.u_viewTexel.xy) * (v_21 * v_30)));
        let v_32 = textureSampleLevel(s_colorTexture, s_colorSampler, v_31, 0.0f).xyz;
        let v_33 = (clamp(((v_4 - (1.0f / textureSampleLevel(s_depthTexture, s_depthSampler, v_31, 0.0f).x)) * v_2), -1.0f, 1.0f) * v_6);
        let v_34 = abs(v_33);
        var v_35 : f32;
        if ((v_33 > v_7)) {
          v_35 = clamp(v_34, 0.0f, (v_8 * 2.0f));
        } else {
          v_35 = v_34;
        }
        let v_36 = smoothstep((v_21 - 0.5f), (v_21 + 0.5f), v_35);
        let v_37 = (v_23 + mix((v_23 / vec3<f32>(v_22, v_22, v_22)), v_32, vec3<f32>(v_36, v_36, v_36)));
        v_17 = (v_24 + 2.39996314048767089844f);
        v_18 = v_37;
        v_19 = (v_22 + 1.0f);
        v_20 = (v_21 + (v_10 / v_21));
        continue;
      } else {
        v_11 = v_22;
        v_12 = v_23;
        break;
      }

      continuing {
        let v_38 = v_20;
        let v_39 = v_19;
        let v_40 = v_18;
        v_13 = v_17;
        v_14 = v_40;
        v_15 = v_39;
        v_16 = v_38;
      }
    }
  }
  let v_41 = (v_12 * (1.0f / v_11));
  let v_42 = pow(abs(vec4<f32>(v_41.x, v_41.y, v_41.z, 0.0f).xyz), vec3<f32>(0.45454546809196472168f));
  bgfx_FragData0 = vec4<f32>(v_42.x, v_42.y, v_42.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
