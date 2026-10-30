diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  bgfx_indirectArgBase : vec4<f32>,
  u_drawParams : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct instanceBufferOut {
  m : array<vec4<f32>>,
}

@group(0u) @binding(4u) var<storage, read_write> instanceBufferOut_1 : instanceBufferOut;

struct indirectBuffer {
  m_1 : array<vec4<u32>>,
}

@group(0u) @binding(3u) var<storage, read_write> indirectBuffer_1 : indirectBuffer;

struct instanceDataIn {
  m_2 : array<vec4<f32>>,
}

@group(0u) @binding(2u) var<storage, read> instanceDataIn_1 : instanceDataIn;

@compute @workgroup_size(64u, 1u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).x;
  let v_2 = i32(v.u_drawParams.x);
  let v_3 = i32(v.u_drawParams.y);
  let v_4 = v.u_drawParams.z;
  let v_5 = min((v_3 * v_3), v_2);
  let v_6 = ((v_5 / 64i) + 1i);
  let v_7 = (v_1 * v_6);
  let v_8 = min(v_5, ((v_1 + 1i) * v_6));
  {
    var v_9 : i32;
    v_9 = v_7;
    loop {
      let v_10 = v_9;
      if ((v_10 < v_8)) {
        continue;
      } else {
        break;
      }

      continuing {
        let v_11 = f32((v_10 % v_3));
        let v_12 = (v_4 + (v_11 * 0.20999999344348907471f));
        let v_13 = f32((v_10 / v_3));
        let v_14 = (v_4 + (v_13 * 0.37000000476837158203f));
        let v_15 = sin(v_12);
        let v_16 = cos(v_12);
        let v_17 = sin(v_14);
        let v_18 = cos(v_14);
        let v_19 = f32((v_3 - 11i));
        let v_20 = vec4<f32>(((-15.0f - (v_19 * 1.20000004768371582031f)) + (v_11 * 3.0f)), ((-15.0f - (v_19 * 1.39999997615814208984f)) + (v_13 * 3.0f)), max(0.0f, ((f32(v_3) - 11.0f) * 3.0f)), 1.0f);
        let v_21 = vec4<f32>(((sin((v_4 + (v_11 * 0.09090909361839294434f))) * 0.5f) + 0.5f), ((cos((v_4 + (v_13 * 0.09090909361839294434f))) * 0.5f) + 0.5f), ((sin((v_4 * 3.0f)) * 0.5f) + 0.5f), 1.0f);
        let v_22 = (v_10 * 5i);
        instanceBufferOut_1.m[v_22] = vec4<f32>(v_18, 0.0f, v_17, 0.0f);
        instanceBufferOut_1.m[(v_22 + 1i)] = vec4<f32>((v_15 * v_17), v_16, (-(v_15) * v_18), 0.0f);
        instanceBufferOut_1.m[(v_22 + 2i)] = vec4<f32>((-(v_16) * v_17), v_15, (v_16 * v_18), 0.0f);
        instanceBufferOut_1.m[(v_22 + 3i)] = v_20;
        instanceBufferOut_1.m[(v_22 + 4i)] = v_21;
        v_9 = (v_10 + 1i);
      }
    }
  }
  {
    var v_23 : i32;
    v_23 = v_7;
    loop {
      let v_24 = v_23;
      if ((v_24 < v_8)) {
        continue;
      } else {
        break;
      }

      continuing {
        let v_25 = (v_24 * 2i);
        indirectBuffer_1.m_1[v_25] = vec4<u32>(u32(instanceDataIn_1.m_2[v_24].w), 1u, (bitcast<u32>(v.bgfx_indirectArgBase.x) + u32(instanceDataIn_1.m_2[v_24].z)), u32(instanceDataIn_1.m_2[v_24].x));
        indirectBuffer_1.m_1[(v_25 + 1i)] = vec4<u32>(bitcast<u32>(v_24), 0u, 0u, 0u);
        v_23 = (v_24 + 1i);
      }
    }
  }
}
