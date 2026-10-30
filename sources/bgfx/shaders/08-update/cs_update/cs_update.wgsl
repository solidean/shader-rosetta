diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_time : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_texColor : texture_storage_2d_array<rgba8unorm, write>;

@compute @workgroup_size(16u, 16u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  var v_2 : array<vec3<f32>, 6u>;
  v_2 = array<vec3<f32>, 6u>(vec3<f32>(1.0f, 0.0f, 0.0f), vec3<f32>(1.0f, 1.0f, 0.0f), vec3<f32>(1.0f, 0.0f, 1.0f), vec3<f32>(0.0f, 1.0f, 0.0f), vec3<f32>(0.0f, 1.0f, 1.0f), vec3<f32>(0.0f, 0.0f, 1.0f));
  {
    var v_3 : i32;
    v_3 = 0i;
    loop {
      let v_4 = v_3;
      if ((v_4 < 6i)) {
        continue;
      } else {
        break;
      }

      continuing {
        let v_5 = (v_2[v_4] * 0.75f);
        let v_6 = (sin((v.u_time.x * 4.0f)) * 0.25f);
        let v_7 = (v_5 + vec3<f32>(v_6, v_6, v_6));
        let v_8 = vec3<i32>(v_1.x, v_1.y, v_4);
        textureStore(s_texColor, v_8.xy, v_8.z, vec4<f32>(v_7.x, v_7.y, v_7.z, 1.0f));
        v_3 = (v_4 + 1i);
      }
    }
  }
}
