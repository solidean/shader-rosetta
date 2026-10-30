diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_texNormalSampler : sampler;

@group(0u) @binding(3u) var s_texNormalTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_texDepthSampler : sampler;

@group(0u) @binding(4u) var s_texDepthTexture : texture_2d<f32>;

struct UniformBlock {
  u_pomParam : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>, v_ts_frag_pos : vec3<f32>, v_ts_light_pos : vec3<f32>, v_ts_view_pos : vec3<f32>) {
  let v_1 = normalize((v_ts_light_pos - v_ts_frag_pos));
  let v_2 = normalize((v_ts_view_pos - v_ts_frag_pos));
  let v_3 = v.u_pomParam.x;
  let v_4 = (v_3 < 2.0f);
  var v_5 : vec2<f32>;
  switch(0u) {
    default: {
      let v_6 = (v.u_pomParam.z * 0.00100000004749745131f);
      if ((v_3 == 2.0f)) {
        let v_7 = v_2.z;
        v_5 = (v_texcoord0 - ((v_2.xy * (textureSample(s_texDepthTexture, s_texDepthSampler, v_texcoord0).x * v_6)) / vec2<f32>(v_7, v_7)));
        break;
      } else {
        let v_8 = v.u_pomParam.w;
        let v_9 = (1.0f / v_8);
        let v_10 = (v_2.z * v_8);
        let v_11 = ((v_2.xy * v_6) / vec2<f32>(v_10, v_10));
        let v_12 = textureSample(s_texDepthTexture, s_texDepthSampler, v_texcoord0).x;
        var v_13 : f32;
        var v_14 : f32;
        var v_15 : vec2<f32>;
        {
          var v_16 : vec2<f32>;
          v_16 = v_texcoord0;
          var v_17 : f32;
          v_17 = 0.0f;
          var v_18 : i32;
          v_18 = 0i;
          var v_19 : f32;
          v_19 = v_12;
          loop {
            var v_20 : vec2<f32>;
            var v_21 : f32;
            var v_22 : f32;
            let v_23 = v_19;
            let v_24 = v_18;
            let v_25 = v_17;
            let v_26 = v_16;
            if ((v_24 < 32i)) {
              let v_27 = (v_25 + v_9);
              let v_28 = (v_26 - v_11);
              let v_29 = textureSample(s_texDepthTexture, s_texDepthSampler, v_28).x;
              if ((v_29 < v_27)) {
                v_13 = v_27;
                v_14 = v_29;
                v_15 = v_28;
                break;
              }
              v_20 = v_28;
              v_21 = v_27;
              v_22 = v_29;
              continue;
            } else {
              v_13 = v_25;
              v_14 = v_23;
              v_15 = v_26;
              break;
            }

            continuing {
              let v_30 = v_22;
              let v_31 = v_21;
              v_16 = v_20;
              v_17 = v_31;
              v_18 = (v_24 + 1i);
              v_19 = v_30;
            }
          }
        }
        let v_32 = v_15;
        let v_33 = v_14;
        let v_34 = v_13;
        if ((v_3 == 3.0f)) {
          v_5 = v_32;
          break;
        } else {
          let v_35 = (v_32 + v_11);
          let v_36 = (v_33 - v_34);
          let v_37 = (v_36 / (v_36 - ((textureSample(s_texDepthTexture, s_texDepthSampler, v_35).x - v_34) + v_9)));
          v_5 = mix(v_32, v_35, vec2<f32>(v_37, v_37));
          break;
        }
      }
    }
  }
  let v_38 = select(v_5, v_texcoord0, vec2<bool>(v_4, v_4));
  var v_39 : vec3<f32>;
  if ((v.u_pomParam.y == 0.0f)) {
    v_39 = vec3<f32>(1.0f);
  } else {
    v_39 = textureSample(s_texColorTexture, s_texColorSampler, v_38).xyz;
  }
  let v_40 = v_39;
  var v_41 : vec3<f32>;
  if ((v_3 == 0.0f)) {
    v_41 = vec3<f32>(0.0f, 0.0f, 1.0f);
  } else {
    let v_42 = ((textureSample(s_texNormalTexture, s_texNormalSampler, v_38).xy * 2.0f) - vec2<f32>(1.0f));
    let v_43 = v_42.x;
    var v_44 : vec3<f32> = vec3<f32>();
    v_44.x = v_43;
    let v_45 = v_42.y;
    var v_46 : vec3<f32> = v_44;
    v_46.y = v_45;
    let v_47 = v_46.xy;
    v_41 = vec3<f32>(v_43, v_45, sqrt((1.0f - dot(v_47, v_47))));
  }
  let v_48 = ((v_40 * max(dot(v_1, v_41), 0.0f)) + (v_40 * 0.30000001192092895508f));
  bgfx_FragData0 = vec4<f32>(v_48.x, v_48.y, v_48.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>, @location(1u) v_ts_frag_pos : vec3<f32>, @location(2u) v_ts_light_pos : vec3<f32>, @location(3u) v_ts_view_pos : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0, v_ts_frag_pos, v_ts_light_pos, v_ts_view_pos);
  return bgfx_FragData0;
}
