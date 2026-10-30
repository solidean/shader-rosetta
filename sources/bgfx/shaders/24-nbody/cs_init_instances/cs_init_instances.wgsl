diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct prevPositionBuffer {
  m : array<vec4<f32>>,
}

@group(0u) @binding(2u) var<storage, read_write> prevPositionBuffer_1 : prevPositionBuffer;

@group(0u) @binding(3u) var<storage, read_write> currPositionBuffer : prevPositionBuffer;

@compute @workgroup_size(512u, 1u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  let v_2 = bitcast<u32>(v.u_params[2i].y);
  var v_3 : vec3<f32>;
  if ((v_2 == 0u)) {
    v_3 = vec3<f32>();
  } else {
    var v_4 : vec3<f32>;
    if ((v_2 == 1u)) {
      let v_5 = bitcast<u32>(v_1.x);
      let v_6 = (bitcast<u32>(v.u_params[1i].z) * 7u);
      let v_7 = (v_5 * 3432918353u);
      let v_8 = ((v_7 << 15u) | (v_7 >> 17u));
      let v_9 = (v_8 * 461845907u);
      let v_10 = (v_6 ^ v_9);
      let v_11 = (v_8 * 2934753923u);
      let v_12 = (((v_11 << 15u) | (v_11 >> 17u)) * 461845907u);
      let v_13 = (((((v_10 << 13u) | (v_10 >> 19u)) * 5u) + 3864292196u) ^ v_12);
      let v_14 = ((v_13 ^ (v_13 >> 16u)) * 2246822507u);
      let v_15 = ((v_14 ^ (v_14 >> 13u)) * 3266489909u);
      let v_16 = ((v_6 + 1u) ^ v_9);
      let v_17 = (((((v_16 << 13u) | (v_16 >> 19u)) * 5u) + 3864292196u) ^ v_12);
      let v_18 = ((v_17 ^ (v_17 >> 16u)) * 2246822507u);
      let v_19 = ((v_18 ^ (v_18 >> 13u)) * 3266489909u);
      let v_20 = (bitcast<vec2<f32>>(((vec2<u32>((v_15 ^ (v_15 >> 16u)), (v_19 ^ (v_19 >> 16u))) >> vec2<u32>(9u)) | vec2<u32>(1065353216u))) - vec2<f32>(1.0f));
      let v_21 = (v_20.x * 6.28318023681640625f);
      let v_22 = (acos(((2.0f * v_20.y) - 1.0f)) - 1.5707950592041015625f);
      let v_23 = cos(v_21);
      let v_24 = cos(v_22);
      v_4 = (vec3<f32>((v_23 * v_24), sin(v_22), (sin(v_21) * v_24)) * 20.0f);
    } else {
      var v_25 : vec3<f32>;
      if ((v_2 == 2u)) {
        let v_26 = bitcast<u32>(v_1.x);
        let v_27 = (bitcast<u32>(v.u_params[1i].z) * 7u);
        let v_28 = (v_26 * 3432918353u);
        let v_29 = ((v_28 << 15u) | (v_28 >> 17u));
        let v_30 = (v_29 * 461845907u);
        let v_31 = (v_27 ^ v_30);
        let v_32 = (v_29 * 2934753923u);
        let v_33 = (((v_32 << 15u) | (v_32 >> 17u)) * 461845907u);
        let v_34 = (((((v_31 << 13u) | (v_31 >> 19u)) * 5u) + 3864292196u) ^ v_33);
        let v_35 = ((v_34 ^ (v_34 >> 16u)) * 2246822507u);
        let v_36 = ((v_35 ^ (v_35 >> 13u)) * 3266489909u);
        let v_37 = ((v_27 + 1u) ^ v_30);
        let v_38 = (((((v_37 << 13u) | (v_37 >> 19u)) * 5u) + 3864292196u) ^ v_33);
        let v_39 = ((v_38 ^ (v_38 >> 16u)) * 2246822507u);
        let v_40 = ((v_39 ^ (v_39 >> 13u)) * 3266489909u);
        let v_41 = ((v_27 + 2u) ^ v_30);
        let v_42 = (((((v_41 << 13u) | (v_41 >> 19u)) * 5u) + 3864292196u) ^ v_33);
        let v_43 = ((v_42 ^ (v_42 >> 16u)) * 2246822507u);
        let v_44 = ((v_43 ^ (v_43 >> 13u)) * 3266489909u);
        v_25 = ((bitcast<vec3<f32>>(((vec3<u32>((v_36 ^ (v_36 >> 16u)), (v_40 ^ (v_40 >> 16u)), (v_44 ^ (v_44 >> 16u))) >> vec3<u32>(9u)) | vec3<u32>(1073741824u))) - vec3<f32>(3.0f)) * 20.0f);
      } else {
        let v_45 = bitcast<u32>(v_1.x);
        let v_46 = (bitcast<u32>(v.u_params[1i].z) * 7u);
        let v_47 = (v_45 * 3432918353u);
        let v_48 = ((v_47 << 15u) | (v_47 >> 17u));
        let v_49 = (v_48 * 461845907u);
        let v_50 = (v_46 ^ v_49);
        let v_51 = (v_48 * 2934753923u);
        let v_52 = (((v_51 << 15u) | (v_51 >> 17u)) * 461845907u);
        let v_53 = (((((v_50 << 13u) | (v_50 >> 19u)) * 5u) + 3864292196u) ^ v_52);
        let v_54 = ((v_53 ^ (v_53 >> 16u)) * 2246822507u);
        let v_55 = ((v_54 ^ (v_54 >> 13u)) * 3266489909u);
        let v_56 = ((v_46 + 1u) ^ v_49);
        let v_57 = (((((v_56 << 13u) | (v_56 >> 19u)) * 5u) + 3864292196u) ^ v_52);
        let v_58 = ((v_57 ^ (v_57 >> 16u)) * 2246822507u);
        let v_59 = ((v_58 ^ (v_58 >> 13u)) * 3266489909u);
        let v_60 = ((v_46 + 2u) ^ v_49);
        let v_61 = (((((v_60 << 13u) | (v_60 >> 19u)) * 5u) + 3864292196u) ^ v_52);
        let v_62 = ((v_61 ^ (v_61 >> 16u)) * 2246822507u);
        let v_63 = ((v_62 ^ (v_62 >> 13u)) * 3266489909u);
        let v_64 = ((bitcast<vec3<f32>>(((vec3<u32>((v_55 ^ (v_55 >> 16u)), (v_59 ^ (v_59 >> 16u)), (v_63 ^ (v_63 >> 16u))) >> vec3<u32>(9u)) | vec3<u32>(1065353216u))) - vec3<f32>(1.0f)) * 6.28318023681640625f);
        let v_65 = v_64.x;
        let v_66 = cos(v_65);
        let v_67 = v_64.y;
        let v_68 = (20.0f + (3.0f * cos(v_67)));
        v_25 = vec3<f32>((v_66 * v_68), (3.0f * sin(v_67)), (sin(v_65) * v_68));
      }
      v_4 = v_25;
    }
    v_3 = v_4;
  }
  let v_69 = v_3;
  let v_70 = v.u_params[2i].x;
  let v_71 = v_1.x;
  let v_72 = bitcast<u32>(v_71);
  let v_73 = (bitcast<u32>(v.u_params[1i].z) * 7u);
  let v_74 = (v_72 * 3432918353u);
  let v_75 = ((v_74 << 15u) | (v_74 >> 17u));
  let v_76 = (v_75 * 461845907u);
  let v_77 = ((v_73 + 3u) ^ v_76);
  let v_78 = (v_75 * 2934753923u);
  let v_79 = (((v_78 << 15u) | (v_78 >> 17u)) * 461845907u);
  let v_80 = (((((v_77 << 13u) | (v_77 >> 19u)) * 5u) + 3864292196u) ^ v_79);
  let v_81 = ((v_80 ^ (v_80 >> 16u)) * 2246822507u);
  let v_82 = ((v_81 ^ (v_81 >> 13u)) * 3266489909u);
  let v_83 = ((v_73 + 4u) ^ v_76);
  let v_84 = (((((v_83 << 13u) | (v_83 >> 19u)) * 5u) + 3864292196u) ^ v_79);
  let v_85 = ((v_84 ^ (v_84 >> 16u)) * 2246822507u);
  let v_86 = ((v_85 ^ (v_85 >> 13u)) * 3266489909u);
  let v_87 = (bitcast<vec2<f32>>(((vec2<u32>((v_82 ^ (v_82 >> 16u)), (v_86 ^ (v_86 >> 16u))) >> vec2<u32>(9u)) | vec2<u32>(1065353216u))) - vec2<f32>(1.0f));
  let v_88 = (v_87.x * 6.28318023681640625f);
  let v_89 = (acos(((2.0f * v_87.y) - 1.0f)) - 1.5707950592041015625f);
  let v_90 = cos(v_88);
  let v_91 = cos(v_89);
  let v_92 = (v_69 - ((vec3<f32>((v_90 * v_91), sin(v_89), (sin(v_88) * v_91)) * v_70) * v.u_params[0i].x));
  prevPositionBuffer_1.m[v_71] = vec4<f32>(v_92.x, v_92.y, v_92.z, 0.0f);
  currPositionBuffer.m[v_71] = vec4<f32>(v_69.x, v_69.y, v_69.z, 0.0f);
}
