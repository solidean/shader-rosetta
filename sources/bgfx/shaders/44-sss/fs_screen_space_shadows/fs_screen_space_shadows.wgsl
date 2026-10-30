diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_depthSampler : sampler;

@group(0u) @binding(2u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewTexel : vec4<f32>,
  u_params : array<vec4<f32>, 12u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_2 = v.u_params[2i];
  let v_3 = (((v_2.xy * v_texcoord0) + v_2.zw) * v_1);
  let v_4 = v_3.x;
  let v_5 = vec3<f32>(v_4, v_3.y, v_1);
  let v_6 = normalize((v.u_params[3i].xyz - v_5));
  let v_7 = v.u_params[0i].y;
  var v_8 : f32;
  if ((0.0f < v.u_params[1i].w)) {
    let v_9 = ((v_7 * v.u_viewTexel.x) + v_texcoord0.x);
    v_8 = abs(((((v.u_params[2i].x * v_9) + v.u_params[2i].z) * v_1) - v_4));
  } else {
    v_8 = v_7;
  }
  let v_10 = v_8;
  let v_11 = v.u_params[0i].z;
  let v_12 = (v_6 * (v_10 / v_11));
  let v_13 = fract((sin(dot((gl_FragCoord.xy + (vec2<f32>(314.0f, 159.0f) * v.u_params[0i].x)), vec2<f32>(12.98980045318603515625f, 78.233001708984375f))) * 43758.546875f));
  let v_14 = (v_5 + (v_12 * select(1.0f, (0.5f + v_13), (0.0f < v.u_params[0i].w))));
  let v_15 = transpose(mat4x4<f32>(v.u_params[8i], v.u_params[9i], v.u_params[10i], v.u_params[11i]));
  var v_16 : f32;
  var v_17 : f32;
  var v_18 : f32;
  {
    var v_19 : vec3<f32>;
    v_19 = v_14;
    var v_20 : f32;
    v_20 = 0.0f;
    var v_21 : f32;
    v_21 = v_11;
    var v_22 : f32;
    v_22 = 0.0f;
    var v_23 : i32;
    v_23 = 0i;
    loop {
      var v_24 : f32;
      var v_25 : f32;
      var v_26 : f32;
      let v_27 = v_23;
      let v_28 = v_22;
      let v_29 = v_21;
      let v_30 = v_20;
      let v_31 = v_19;
      if ((v_27 < i32(v_11))) {
        let v_32 = v_31.z;
        let v_33 = (vec4<f32>(v_31.x, v_31.y, v_32, 1.0f) * v_15);
        let v_34 = (v_33.xy * (1.0f / v_33.w));
        var v_35 : vec3<f32> = vec3<f32>();
        v_35.x = v_34.x;
        var v_36 : vec3<f32> = v_35;
        v_36.y = v_34.y;
        let v_37 = ((v_36.xy * 0.5f) + vec2<f32>(0.5f));
        var v_38 : vec2<f32> = v_37;
        v_38.y = (1.0f - v_37.y);
        let v_39 = (v_32 - textureSampleLevel(s_depthTexture, s_depthSampler, v_38, 0.0f).x);
        var v_40 : f32;
        var v_41 : f32;
        var v_42 : f32;
        if (((0.00009999999747378752f < v_39) & (v_39 < v_10))) {
          let v_43 = min(v_29, f32(v_27));
          v_40 = (v_30 + clamp((v_10 - v_39), 0.0f, 1.0f));
          v_41 = v_43;
          v_42 = (v_28 + 1.0f);
        } else {
          v_40 = v_30;
          v_41 = v_29;
          v_42 = v_28;
        }
        let v_44 = v_42;
        let v_45 = v_41;
        v_24 = v_40;
        v_25 = v_45;
        v_26 = v_44;
        continue;
      } else {
        v_16 = v_29;
        v_17 = v_30;
        v_18 = v_28;
        break;
      }

      continuing {
        let v_46 = v_26;
        let v_47 = v_25;
        let v_48 = v_24;
        v_19 = (v_31 + v_12);
        v_20 = v_48;
        v_21 = v_47;
        v_22 = v_46;
        v_23 = (v_27 + 1i);
      }
    }
  }
  let v_49 = v_18;
  let v_50 = v_17;
  let v_51 = v_16;
  let v_52 = v.u_params[1i].z;
  var v_53 : f32;
  if ((1.5f < v_52)) {
    let v_54 = (1.0f - clamp((v_50 * (1.0f - (v_51 / v_11))), 0.0f, 1.0f));
    v_53 = (v_54 * v_54);
  } else {
    var v_55 : f32;
    if ((0.5f < v_52)) {
      let v_56 = (1.0f - clamp((v_49 * (1.0f - (v_51 / v_11))), 0.0f, 1.0f));
      v_55 = (v_56 * v_56);
    } else {
      v_55 = select(1.0f, 0.0f, (0.0f < v_49));
    }
    v_53 = v_55;
  }
  let v_57 = v_53;
  bgfx_FragData0 = vec4<f32>(v_57, v_57, v_57, v_57);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>, @location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord, v_texcoord0);
  return bgfx_FragData0;
}
