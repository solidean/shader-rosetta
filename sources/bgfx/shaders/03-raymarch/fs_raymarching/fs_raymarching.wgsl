diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_mtx : mat4x4<f32>,
  u_lightDirTime : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

var<private> gl_FragDepth : f32;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec2<f32>) {
  let v_1 = v_texcoord0.x;
  let v_2 = v_texcoord0.y;
  let v_3 = transpose(v.u_mtx);
  let v_4 = (vec4<f32>(v_1, v_2, 0.0f, 1.0f) * v_3);
  let v_5 = v_4.w;
  let v_6 = (v_4.xyz / vec3<f32>(v_5, v_5, v_5));
  let v_7 = (vec4<f32>(v_1, v_2, 1.0f, 1.0f) * v_3);
  let v_8 = v_7.w;
  let v_9 = ((v_7.xyz / vec3<f32>(v_8, v_8, v_8)) - v_6);
  let v_10 = length(v_9);
  let v_11 = normalize(v_9);
  var v_12 : f32;
  {
    var v_13 : f32;
    v_13 = 0.0f;
    var v_14 : i32;
    v_14 = 0i;
    loop {
      var v_15 : f32;
      let v_16 = v_14;
      let v_17 = v_13;
      if ((v_16 < 64i)) {
        let v_18 = (v_6 + (v_11 * v_17));
        let v_19 = (length(max((abs(v_18) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
        let v_20 = (length((v_18 + vec3<f32>(4.0f, 0.0f, 0.0f))) - 1.0f);
        let v_21 = (length((v_18 + vec3<f32>(-4.0f, 0.0f, 0.0f))) - 1.0f);
        let v_22 = (length((v_18 + vec3<f32>(0.0f, 4.0f, 0.0f))) - 1.0f);
        let v_23 = (length((v_18 + vec3<f32>(0.0f, -4.0f, 0.0f))) - 1.0f);
        let v_24 = (length((v_18 + vec3<f32>(0.0f, 0.0f, 4.0f))) - 1.0f);
        let v_25 = (length((v_18 + vec3<f32>(0.0f, 0.0f, -4.0f))) - 1.0f);
        let v_26 = min(min(min(min(min(min(v_19, v_20), v_21), v_22), v_23), v_24), v_25);
        var v_27 : f32;
        if ((v_26 > 0.00100000004749745131f)) {
          v_27 = (v_17 + v_26);
        } else {
          v_27 = v_17;
        }
        v_15 = v_27;
        continue;
      } else {
        v_12 = v_17;
        break;
      }

      continuing {
        v_13 = v_15;
        v_14 = (v_16 + 1i);
      }
    }
  }
  let v_28 = v_12;
  let v_29 = select(0.0f, v_28, (v_28 < v_10));
  var v_30 : f32;
  var v_31 : vec4<f32>;
  if ((v_29 > 0.5f)) {
    let v_32 = (v_6 + (v_11 * v_29));
    let v_33 = (length(max((abs((v_32 + vec3<f32>(0.00200000009499490261f, 0.0f, 0.0f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_34 = (length((v_32 + vec3<f32>(4.00199985504150390625f, 0.0f, 0.0f))) - 1.0f);
    let v_35 = (length((v_32 + vec3<f32>(-3.99799990653991699219f, 0.0f, 0.0f))) - 1.0f);
    let v_36 = (length((v_32 + vec3<f32>(0.00200000009499490261f, 4.0f, 0.0f))) - 1.0f);
    let v_37 = (length((v_32 + vec3<f32>(0.00200000009499490261f, -4.0f, 0.0f))) - 1.0f);
    let v_38 = (length((v_32 + vec3<f32>(0.00200000009499490261f, 0.0f, 4.0f))) - 1.0f);
    let v_39 = (length((v_32 + vec3<f32>(0.00200000009499490261f, 0.0f, -4.0f))) - 1.0f);
    let v_40 = min(min(min(min(min(min(v_33, v_34), v_35), v_36), v_37), v_38), v_39);
    let v_41 = (length(max((abs((v_32 - vec3<f32>(0.00200000009499490261f, 0.0f, 0.0f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_42 = (length((v_32 + vec3<f32>(3.99799990653991699219f, 0.0f, 0.0f))) - 1.0f);
    let v_43 = (length((v_32 + vec3<f32>(-4.00199985504150390625f, 0.0f, 0.0f))) - 1.0f);
    let v_44 = (length((v_32 + vec3<f32>(-0.00200000009499490261f, 4.0f, 0.0f))) - 1.0f);
    let v_45 = (length((v_32 + vec3<f32>(-0.00200000009499490261f, -4.0f, 0.0f))) - 1.0f);
    let v_46 = (length((v_32 + vec3<f32>(-0.00200000009499490261f, 0.0f, 4.0f))) - 1.0f);
    let v_47 = (length((v_32 + vec3<f32>(-0.00200000009499490261f, 0.0f, -4.0f))) - 1.0f);
    let v_48 = (v_40 - min(min(min(min(min(min(v_41, v_42), v_43), v_44), v_45), v_46), v_47));
    let v_49 = (length(max((abs((v_32 + vec3<f32>(0.0f, 0.00200000009499490261f, 0.0f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_50 = (length((v_32 + vec3<f32>(4.0f, 0.00200000009499490261f, 0.0f))) - 1.0f);
    let v_51 = (length((v_32 + vec3<f32>(-4.0f, 0.00200000009499490261f, 0.0f))) - 1.0f);
    let v_52 = (length((v_32 + vec3<f32>(0.0f, 4.00199985504150390625f, 0.0f))) - 1.0f);
    let v_53 = (length((v_32 + vec3<f32>(0.0f, -3.99799990653991699219f, 0.0f))) - 1.0f);
    let v_54 = (length((v_32 + vec3<f32>(0.0f, 0.00200000009499490261f, 4.0f))) - 1.0f);
    let v_55 = (length((v_32 + vec3<f32>(0.0f, 0.00200000009499490261f, -4.0f))) - 1.0f);
    let v_56 = min(min(min(min(min(min(v_49, v_50), v_51), v_52), v_53), v_54), v_55);
    let v_57 = (length(max((abs((v_32 - vec3<f32>(0.0f, 0.00200000009499490261f, 0.0f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_58 = (length((v_32 + vec3<f32>(4.0f, -0.00200000009499490261f, 0.0f))) - 1.0f);
    let v_59 = (length((v_32 + vec3<f32>(-4.0f, -0.00200000009499490261f, 0.0f))) - 1.0f);
    let v_60 = (length((v_32 + vec3<f32>(0.0f, 3.99799990653991699219f, 0.0f))) - 1.0f);
    let v_61 = (length((v_32 + vec3<f32>(0.0f, -4.00199985504150390625f, 0.0f))) - 1.0f);
    let v_62 = (length((v_32 + vec3<f32>(0.0f, -0.00200000009499490261f, 4.0f))) - 1.0f);
    let v_63 = (length((v_32 + vec3<f32>(0.0f, -0.00200000009499490261f, -4.0f))) - 1.0f);
    let v_64 = (v_56 - min(min(min(min(min(min(v_57, v_58), v_59), v_60), v_61), v_62), v_63));
    let v_65 = (length(max((abs((v_32 + vec3<f32>(0.0f, 0.0f, 0.00200000009499490261f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_66 = (length((v_32 + vec3<f32>(4.0f, 0.0f, 0.00200000009499490261f))) - 1.0f);
    let v_67 = (length((v_32 + vec3<f32>(-4.0f, 0.0f, 0.00200000009499490261f))) - 1.0f);
    let v_68 = (length((v_32 + vec3<f32>(0.0f, 4.0f, 0.00200000009499490261f))) - 1.0f);
    let v_69 = (length((v_32 + vec3<f32>(0.0f, -4.0f, 0.00200000009499490261f))) - 1.0f);
    let v_70 = (length((v_32 + vec3<f32>(0.0f, 0.0f, 4.00199985504150390625f))) - 1.0f);
    let v_71 = (length((v_32 + vec3<f32>(0.0f, 0.0f, -3.99799990653991699219f))) - 1.0f);
    let v_72 = min(min(min(min(min(min(v_65, v_66), v_67), v_68), v_69), v_70), v_71);
    let v_73 = (length(max((abs((v_32 - vec3<f32>(0.0f, 0.0f, 0.00200000009499490261f))) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
    let v_74 = (length((v_32 + vec3<f32>(4.0f, 0.0f, -0.00200000009499490261f))) - 1.0f);
    let v_75 = (length((v_32 + vec3<f32>(-4.0f, 0.0f, -0.00200000009499490261f))) - 1.0f);
    let v_76 = (length((v_32 + vec3<f32>(0.0f, 4.0f, -0.00200000009499490261f))) - 1.0f);
    let v_77 = (length((v_32 + vec3<f32>(0.0f, -4.0f, -0.00200000009499490261f))) - 1.0f);
    let v_78 = (length((v_32 + vec3<f32>(0.0f, 0.0f, 3.99799990653991699219f))) - 1.0f);
    let v_79 = (length((v_32 + vec3<f32>(0.0f, 0.0f, -4.00199985504150390625f))) - 1.0f);
    let v_80 = normalize(vec3<f32>(v_48, v_64, (v_72 - min(min(min(min(min(min(v_73, v_74), v_75), v_76), v_77), v_78), v_79))));
    let v_81 = v.u_lightDirTime.xyz;
    let v_82 = dot(v_80, v_81);
    let v_83 = dot((v_81 - (v_80 * (2.0f * v_82))), v_11);
    let v_84 = max(0.0f, v_82);
    let v_85 = (step(0.0f, v_82) * max(0.0f, v_83));
    let v_86 = max((0.20000000298023223877f + (0.80000001192092895508f * pow((1.0f - v_82), 5.0f))), 0.0f);
    let v_87 = ((0.89999997615814208984f * v_84) + (pow(v_85, 128.0f) * v_86));
    var v_88 : f32;
    {
      var v_89 : f32;
      v_89 = 0.0f;
      var v_90 : i32;
      v_90 = 1i;
      loop {
        let v_91 = v_90;
        let v_92 = v_89;
        if ((v_91 < 4i)) {
          continue;
        } else {
          v_88 = v_92;
          break;
        }

        continuing {
          let v_93 = f32(v_91);
          let v_94 = (v_32 + ((v_80 * v_93) * 0.20000000298023223877f));
          let v_95 = (length(max((abs(v_94) - vec3<f32>(2.5f)), vec3<f32>())) - 0.5f);
          let v_96 = (length((v_94 + vec3<f32>(4.0f, 0.0f, 0.0f))) - 1.0f);
          let v_97 = (length((v_94 + vec3<f32>(-4.0f, 0.0f, 0.0f))) - 1.0f);
          let v_98 = (length((v_94 + vec3<f32>(0.0f, 4.0f, 0.0f))) - 1.0f);
          let v_99 = (length((v_94 + vec3<f32>(0.0f, -4.0f, 0.0f))) - 1.0f);
          let v_100 = (length((v_94 + vec3<f32>(0.0f, 0.0f, 4.0f))) - 1.0f);
          let v_101 = (length((v_94 + vec3<f32>(0.0f, 0.0f, -4.0f))) - 1.0f);
          v_89 = (v_92 + (((v_93 * 0.20000000298023223877f) - min(min(min(min(min(min(v_95, v_96), v_97), v_98), v_99), v_100), v_101)) / pow(2.0f, v_93)));
          v_90 = (v_91 + 1i);
        }
      }
    }
    let v_102 = pow((v_87 * (1.0f - v_88)), 0.45454546809196472168f);
    v_30 = (v_29 / v_10);
    v_31 = vec4<f32>(v_102, v_102, v_102, 1.0f);
  } else {
    v_30 = 1.0f;
    v_31 = v_color0;
  }
  let v_103 = v_31;
  let v_104 = v_30;
  bgfx_FragData0 = v_103;
  gl_FragDepth = v_104;
}

struct tint_symbol {
  @location(0u)
  bgfx_FragData0 : vec4<f32>,
  @builtin(frag_depth)
  gl_FragDepth : f32,
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_texcoord0 : vec2<f32>) -> tint_symbol {
  main_inner(v_color0, v_texcoord0);
  return tint_symbol(bgfx_FragData0, gl_FragDepth);
}
