diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct prevPositionBuffer {
  m : array<vec4<f32>>,
}

@group(0u) @binding(2u) var<storage, read> prevPositionBuffer_1 : prevPositionBuffer;

@group(0u) @binding(3u) var<storage, read> currPositionBuffer : prevPositionBuffer;

var<workgroup> otherEntries : array<vec3<f32>, 512u>;

struct outPrevPositionBuffer {
  m_1 : array<vec4<f32>>,
}

@group(0u) @binding(4u) var<storage, read_write> outPrevPositionBuffer_1 : outPrevPositionBuffer;

@group(0u) @binding(5u) var<storage, read_write> outCurrPositionBuffer : outPrevPositionBuffer;

@compute @workgroup_size(512u, 1u, 1u)
fn main(@builtin(local_invocation_index) gl_LocalInvocationIndex : u32, @builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = i32(gl_LocalInvocationIndex);
  let v_2 = vec3<i32>(gl_GlobalInvocationID).x;
  let v_3 = prevPositionBuffer_1.m[v_2].xyz;
  let v_4 = currPositionBuffer.m[v_2];
  let v_5 = v_4.xyz;
  var v_6 : vec3<f32>;
  {
    var v_7 : vec3<f32>;
    v_7 = vec3<f32>();
    var v_8 : i32;
    v_8 = 0i;
    loop {
      var v_9 : vec3<f32>;
      let v_10 = v_8;
      let v_11 = v_7;
      if ((v_10 < bitcast<i32>(v.u_params[0i].y))) {
        otherEntries[v_1] = currPositionBuffer.m[((v_10 * 512i) + v_1)].xyz;
        workgroupBarrier();
        var v_12 : vec3<f32>;
        {
          var v_13 : vec3<f32>;
          v_13 = v_11;
          var v_14 : i32;
          v_14 = 0i;
          loop {
            let v_15 = v_14;
            let v_16 = v_13;
            if ((v_15 < 512i)) {
              continue;
            } else {
              v_12 = v_16;
              break;
            }

            continuing {
              let v_17 = (otherEntries[v_15] - v_5);
              let v_18 = dot(v_17, v_17);
              let v_19 = (1.0f / (sqrt(((v_18 * v_18) * v_18)) + 0.10000000149011611938f));
              let v_20 = v.u_params[0i].z;
              v_13 = (v_16 + (v_17 * ((v_20 * v_20) * v_19)));
              v_14 = (v_15 + 1i);
            }
          }
        }
        v_9 = v_12;
        continue;
      } else {
        v_6 = v_11;
        break;
      }

      continuing {
        v_7 = v_9;
        v_8 = (v_10 + 1i);
      }
    }
  }
  let v_21 = (v_6 + ((v_3 - v_5) * v.u_params[0i].w));
  let v_22 = length(v_21);
  let v_23 = pow(min((v_22 * 0.3333333432674407959f), 1.0f), 0.25f);
  var v_24 : vec3<f32>;
  if ((v_22 > 0.0f)) {
    v_24 = (normalize(v_21) * min(v_22, v.u_params[2i].z));
  } else {
    v_24 = v_21;
  }
  let v_25 = (((v_5 * 2.0f) - v_3) + (v_24 * v.u_params[0i].x));
  outPrevPositionBuffer_1.m_1[v_2] = vec4<f32>(v_4.x, v_4.y, v_4.z, 0.0f);
  outCurrPositionBuffer.m_1[v_2] = vec4<f32>(v_25.x, v_25.y, v_25.z, v_23);
}
