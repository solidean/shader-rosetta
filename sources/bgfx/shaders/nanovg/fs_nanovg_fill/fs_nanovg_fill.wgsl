diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texSampler : sampler;

@group(0u) @binding(2u) var s_texTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_scissorMat : mat3x3<f32>,
  u_paintMat : mat3x3<f32>,
  u_innerCol : vec4<f32>,
  u_outerCol : vec4<f32>,
  u_scissorExtScale : vec4<f32>,
  u_extentRadius : vec4<f32>,
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_position : vec2<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = vec3<f32>(v_position.x, v_position.y, 1.0f);
  let v_2 = abs(((v_1 * transpose(v.u_scissorMat))).xy);
  let v_3 = v.u_scissorExtScale;
  let v_4 = (vec2<f32>(0.5f) - ((v_2 - v_3.xy) * v_3.zw));
  let v_5 = (clamp(v_4.x, 0.0f, 1.0f) * clamp(v_4.y, 0.0f, 1.0f));
  let v_6 = (min(1.0f, ((1.0f - abs(((v_texcoord0.x * 2.0f) - 1.0f))) * v.u_params.y)) * min(1.0f, v_texcoord0.y));
  let v_7 = v.u_params.w;
  var v_8 : vec4<f32>;
  if ((v_7 == 0.0f)) {
    let v_9 = ((v_1 * transpose(v.u_paintMat))).xy;
    let v_10 = v.u_extentRadius.xy;
    let v_11 = v.u_extentRadius.z;
    let v_12 = (abs(v_9) - (v_10 - vec2<f32>(v_11, v_11)));
    let v_13 = ((min(max(v_12.x, v_12.y), 0.0f) + length(max(v_12, vec2<f32>()))) - v_11);
    let v_14 = v.u_params.x;
    let v_15 = clamp(((v_13 + (v_14 * 0.5f)) / v_14), 0.0f, 1.0f);
    v_8 = (mix(v.u_innerCol, v.u_outerCol, vec4<f32>(v_15, v_15, v_15, v_15)) * (v_6 * v_5));
  } else {
    var v_16 : vec4<f32>;
    if ((v_7 == 1.0f)) {
      let v_17 = textureSample(s_texTexture, s_texSampler, (((v_1 * transpose(v.u_paintMat))).xy / v.u_extentRadius.xy));
      let v_18 = v.u_params.z;
      var v_19 : vec4<f32>;
      if ((v_18 == 1.0f)) {
        let v_20 = v_17.w;
        let v_21 = (v_17.xyz * v_20);
        v_19 = vec4<f32>(v_21.x, v_21.y, v_21.z, v_20);
      } else {
        v_19 = v_17;
      }
      let v_22 = v_19;
      var v_23 : vec4<f32>;
      if ((v_18 == 2.0f)) {
        v_23 = v_22.xxxx;
      } else {
        v_23 = v_22;
      }
      v_16 = ((v_23 * v.u_innerCol) * (v_6 * v_5));
    } else {
      var v_24 : vec4<f32>;
      if ((v_7 == 2.0f)) {
        v_24 = vec4<f32>(1.0f);
      } else {
        var v_25 : vec4<f32>;
        if ((v_7 == 3.0f)) {
          let v_26 = textureSample(s_texTexture, s_texSampler, v_texcoord0);
          let v_27 = v.u_params.z;
          var v_28 : vec4<f32>;
          if ((v_27 == 1.0f)) {
            let v_29 = v_26.w;
            let v_30 = (v_26.xyz * v_29);
            v_28 = vec4<f32>(v_30.x, v_30.y, v_30.z, v_29);
          } else {
            v_28 = v_26;
          }
          let v_31 = v_28;
          var v_32 : vec4<f32>;
          if ((v_27 == 2.0f)) {
            v_32 = v_31.xxxx;
          } else {
            v_32 = v_31;
          }
          v_25 = ((v_32 * v_5) * v.u_innerCol);
        } else {
          v_25 = vec4<f32>();
        }
        v_24 = v_25;
      }
      v_16 = v_24;
    }
    v_8 = v_16;
  }
  bgfx_FragData0 = v_8;
}

@fragment
fn main(@location(0u) v_position : vec2<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_position, v_texcoord0);
  return bgfx_FragData0;
}
