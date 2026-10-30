diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_depthSampler : sampler;

@group(0u) @binding(4u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewTexel : vec4<f32>,
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  var v_1 : array<f32, 3u>;
  let v_2 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_3 = ((textureSample(s_normalTexture, s_normalSampler, v_texcoord0).xyz * 2.0f) - vec3<f32>(1.0f));
  let v_4 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_5 = v.u_params[12i].x;
  let v_6 = (v_5 * v.u_viewTexel.x);
  let v_7 = (v_5 * v.u_viewTexel.y);
  v_1[0i] = 0.25f;
  let v_8 = &(v_1[1i]);
  *(v_8) = 0.5f;
  v_1[2i] = 0.25f;
  let v_9 = (*(v_8) * *(v_8));
  var v_10 : f32;
  var v_11 : vec4<f32>;
  {
    var v_12 : vec4<f32>;
    v_12 = (v_2 * v_9);
    var v_13 : f32;
    v_13 = v_9;
    var v_14 : i32;
    v_14 = 0i;
    loop {
      var v_15 : vec4<f32>;
      var v_16 : f32;
      let v_17 = v_14;
      let v_18 = v_13;
      let v_19 = v_12;
      if ((v_17 < 3i)) {
        var v_20 : vec4<f32>;
        var v_21 : f32;
        {
          var v_22 : f32;
          v_22 = v_18;
          var v_23 : vec4<f32>;
          v_23 = v_19;
          var v_24 : i32;
          v_24 = 0i;
          loop {
            var v_25 : f32;
            var v_26 : vec4<f32>;
            let v_27 = v_24;
            let v_28 = v_23;
            let v_29 = v_22;
            if ((v_27 < 3i)) {
              if (((1i == v_27) & (1i == v_17))) {
                v_25 = v_29;
                v_26 = v_28;
                continue;
              }
              let v_30 = vec2<f32>((v_texcoord0.x + ((f32(v_27) - 1.0f) * v_6)), (v_texcoord0.y + ((f32(v_17) - 1.0f) * v_7)));
              let v_31 = textureSample(s_colorTexture, s_colorSampler, v_30);
              let v_32 = pow(clamp(dot(v_3, ((textureSample(s_normalTexture, s_normalSampler, v_30).xyz * 2.0f) - vec3<f32>(1.0f))), 0.0f, 1.0f), v.u_params[12i].z);
              let v_33 = -(abs((v_4 - textureSample(s_depthTexture, s_depthSampler, v_30).x)));
              let v_34 = v.u_params[12i].y;
              let v_35 = ((exp((v_33 / max(0.00000999999974737875f, (v_34 * v_34)))) * v_32) * (v_1[v_27] * v_1[v_17]));
              v_25 = (v_29 + v_35);
              v_26 = (v_28 + (v_31 * v_35));
              continue;
            } else {
              v_20 = v_28;
              v_21 = v_29;
              break;
            }

            continuing {
              let v_36 = v_26;
              v_22 = v_25;
              v_23 = v_36;
              v_24 = (v_27 + 1i);
            }
          }
        }
        let v_37 = v_21;
        v_15 = v_20;
        v_16 = v_37;
        continue;
      } else {
        v_10 = v_18;
        v_11 = v_19;
        break;
      }

      continuing {
        let v_38 = v_16;
        v_12 = v_15;
        v_13 = v_38;
        v_14 = (v_17 + 1i);
      }
    }
  }
  let v_39 = v_11;
  let v_40 = max(v_10, 0.00000999999974737875f);
  bgfx_FragData0 = (v_39 / vec4<f32>(v_40, v_40, v_40, v_40));
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
