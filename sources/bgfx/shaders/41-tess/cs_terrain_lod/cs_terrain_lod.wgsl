diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var u_DmapSamplerSampler : sampler;

@group(0u) @binding(2u) var u_DmapSamplerTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_invView : mat4x4<f32>,
  u_modelView : mat4x4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_params : array<vec4<f32>, 2u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

struct u_AtomicCounterBuffer_atomic {
  m : array<atomic<u32>>,
}

@group(0u) @binding(6u) var<storage, read_write> u_AtomicCounterBuffer_1 : u_AtomicCounterBuffer_atomic;

struct u_AtomicCounterBuffer {
  m_1 : array<u32>,
}

@group(0u) @binding(3u) var<storage, read_write> u_SubdBufferOut : u_AtomicCounterBuffer;

struct u_SubdBufferIn {
  m_2 : array<u32>,
}

@group(0u) @binding(10u) var<storage, read> u_SubdBufferIn_1 : u_SubdBufferIn;

struct u_VertexBuffer {
  m_3 : array<vec4<f32>>,
}

@group(0u) @binding(8u) var<storage, read> u_VertexBuffer_1 : u_VertexBuffer;

@group(0u) @binding(9u) var<storage, read> u_IndexBuffer : u_SubdBufferIn;

@group(0u) @binding(4u) var<storage, read_write> u_CulledSubdBuffer : u_AtomicCounterBuffer;

@compute @workgroup_size(32u, 1u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  var v_1 : array<vec4<f32>, 6u>;
  var v_2 : array<vec4<f32>, 6u>;
  var v_3 : mat4x4<f32>;
  var v_4 : mat4x4<f32>;
  var v_5 : mat4x4<f32>;
  var v_6 : mat4x4<f32>;
  var v_7 : mat4x4<f32>;
  var v_8 : mat4x4<f32>;
  var v_9 : mat4x4<f32>;
  var v_10 : mat4x4<f32>;
  switch(0u) {
    default: {
      let v_11 = bitcast<u32>(vec3<i32>(gl_GlobalInvocationID).x);
      if ((v_11 >= atomicLoad(&(u_AtomicCounterBuffer_1.m[2i])))) {
        break;
      }
      let v_12 = (v_11 * 2u);
      let v_13 = u_SubdBufferIn_1.m_2[v_12];
      let v_14 = (v_13 * 3u);
      let v_15 = u_VertexBuffer_1.m_3[u_IndexBuffer.m_2[v_14]];
      let v_16 = u_VertexBuffer_1.m_3[u_IndexBuffer.m_2[(v_14 + 1u)]];
      let v_17 = u_VertexBuffer_1.m_3[u_IndexBuffer.m_2[(v_14 + 2u)]];
      let v_18 = u_SubdBufferIn_1.m_2[(v_12 + 1u)];
      let v_19 = (v_18 >> 1u);
      var v_20 : mat3x3<f32>;
      {
        var v_21 : mat3x3<f32>;
        v_21 = mat3x3<f32>(vec3<f32>(1.0f, 0.0f, 0.0f), vec3<f32>(0.0f, 1.0f, 0.0f), vec3<f32>(0.0f, 0.0f, 1.0f));
        var v_22 : u32;
        v_22 = v_19;
        loop {
          let v_23 = v_22;
          let v_24 = v_21;
          if ((v_23 > 1u)) {
            continue;
          } else {
            v_20 = v_24;
            break;
          }

          continuing {
            let v_25 = f32((v_23 & 1u));
            let v_26 = (1.0f - v_25);
            v_21 = (transpose(mat3x3<f32>(vec3<f32>(0.0f, v_26, v_25), vec3<f32>(0.5f, v_25, 0.0f), vec3<f32>(0.5f, 0.0f, v_26))) * v_24);
            v_22 = (v_23 >> 1u);
          }
        }
      }
      let v_27 = v_20;
      var v_28 : mat3x3<f32>;
      {
        var v_29 : mat3x3<f32>;
        v_29 = mat3x3<f32>(vec3<f32>(1.0f, 0.0f, 0.0f), vec3<f32>(0.0f, 1.0f, 0.0f), vec3<f32>(0.0f, 0.0f, 1.0f));
        var v_30 : u32;
        v_30 = v_18;
        loop {
          let v_31 = v_30;
          let v_32 = v_29;
          if ((v_31 > 1u)) {
            continue;
          } else {
            v_28 = v_32;
            break;
          }

          continuing {
            let v_33 = f32((v_31 & 1u));
            let v_34 = (1.0f - v_33);
            v_29 = (transpose(mat3x3<f32>(vec3<f32>(0.0f, v_34, v_33), vec3<f32>(0.5f, v_33, 0.0f), vec3<f32>(0.5f, 0.0f, v_34))) * v_32);
            v_30 = (v_31 >> 1u);
          }
        }
      }
      let v_35 = mat3x4<f32>(v_15, v_16, v_17);
      let v_36 = (v_35 * v_28);
      let v_37 = (v_35 * v_27);
      let v_38 = v_36[0u];
      let v_39 = v_36[1u];
      let v_40 = v_36[2u];
      var v_41 : u32;
      var v_42 : u32;
      if ((v.u_params[0i].w == 0.0f)) {
        let v_43 = ((v_39.xyz + v_40.xyz) * vec3<f32>(0.5f));
        let v_44 = transpose(v.u_invView);
        let v_45 = ((vec4<f32>(v_44[0u].w, v_44[1u].w, 0.0f, 0.0f).xy * 0.5f) + vec2<f32>(0.5f));
        let v_46 = textureSampleLevel(u_DmapSamplerTexture, u_DmapSamplerSampler, v_45, 0.0f).x;
        let v_47 = v.u_params[0i].x;
        let v_48 = transpose(v.u_modelView);
        let v_49 = length(((vec4<f32>(v_43.x, v_43.y, (v_43.z + (v_46 * v_47)), 1.0f) * v_48)).xyz);
        let v_50 = v.u_params[0i].y;
        let v_51 = u32((-2.0f * log2(clamp((v_49 * v_50), 0.0f, 1.0f))));
        let v_52 = ((v_37[1u].xyz + v_37[2u].xyz) * vec3<f32>(0.5f));
        v_41 = u32((-2.0f * log2(clamp((length(((vec4<f32>(v_52.x, v_52.y, (v_52.z + (textureSampleLevel(u_DmapSamplerTexture, u_DmapSamplerSampler, v_45, 0.0f).x * v_47)), 1.0f) * v_48)).xyz) * v_50), 0.0f, 1.0f))));
        v_42 = v_51;
      } else {
        var v_53 : u32;
        {
          var v_54 : u32;
          v_54 = 0u;
          loop {
            let v_55 = v_54;
            if ((v_55 < 32u)) {
              if (((v_18 & bitcast<u32>((i32(-2147483648) >> v_55))) != 0u)) {
                v_53 = (31u - v_55);
                break;
              }
              continue;
            } else {
              v_53 = 4294967295u;
              break;
            }

            continuing {
              v_54 = (v_55 + bitcast<u32>(1i));
            }
          }
        }
        let v_56 = v_53;
        v_41 = v_56;
        v_42 = v_56;
      }
      let v_57 = v_42;
      let v_58 = v_41;
      var v_59 : u32;
      {
        var v_60 : u32;
        v_60 = 0u;
        loop {
          let v_61 = v_60;
          if ((v_61 < 32u)) {
            if (((v_18 & bitcast<u32>((i32(-2147483648) >> v_61))) != 0u)) {
              v_59 = (31u - v_61);
              break;
            }
            continue;
          } else {
            v_59 = 4294967295u;
            break;
          }

          continuing {
            v_60 = (v_61 + bitcast<u32>(1i));
          }
        }
      }
      let v_62 = v_59;
      var v_63 : u32;
      {
        var v_64 : u32;
        v_64 = 0u;
        loop {
          let v_65 = v_64;
          if ((v_65 < 32u)) {
            if (((v_18 & bitcast<u32>((i32(-2147483648) >> v_65))) != 0u)) {
              v_63 = (31u - v_65);
              break;
            }
            continue;
          } else {
            v_63 = 4294967295u;
            break;
          }

          continuing {
            v_64 = (v_65 + bitcast<u32>(1i));
          }
        }
      }
      if (((v_62 < v_57) & (v_63 != 31u))) {
        let v_66 = (v_18 << 1u);
        let v_67 = &(u_AtomicCounterBuffer_1.m[0i]);
        let v_68 = atomicAdd(v_67, 2u);
        u_SubdBufferOut.m_1[v_68] = v_13;
        u_SubdBufferOut.m_1[(v_68 + 1u)] = v_66;
        let v_69 = atomicAdd(v_67, 2u);
        u_SubdBufferOut.m_1[v_69] = v_13;
        u_SubdBufferOut.m_1[(v_69 + 1u)] = (v_66 | 1u);
      } else if ((v_62 < (v_58 + 1u))) {
        let v_70 = atomicAdd(&(u_AtomicCounterBuffer_1.m[0i]), 2u);
        u_SubdBufferOut.m_1[v_70] = v_13;
        u_SubdBufferOut.m_1[(v_70 + 1u)] = v_18;
      } else if ((v_18 == 1u)) {
        let v_71 = atomicAdd(&(u_AtomicCounterBuffer_1.m[0i]), 2u);
        u_SubdBufferOut.m_1[v_71] = v_13;
        u_SubdBufferOut.m_1[(v_71 + 1u)] = v_18;
      } else if (((v_18 & 1u) == 0u)) {
        let v_72 = atomicAdd(&(u_AtomicCounterBuffer_1.m[0i]), 2u);
        u_SubdBufferOut.m_1[v_72] = v_13;
        u_SubdBufferOut.m_1[(v_72 + 1u)] = v_19;
      }
      let v_73 = transpose(v.u_modelViewProj);
      let v_74 = min(min(v_38, v_39), v_40);
      let v_75 = max(max(v_38, v_39), v_40);
      var v_76 : vec4<f32> = v_74;
      v_76.z = 0.0f;
      let v_77 = v_76;
      var v_78 : vec4<f32> = v_75;
      v_78.z = v.u_params[0i].x;
      let v_79 = v_78;
      let v_80 = (v.u_params[0i].z == 0.0f);
      {
        var v_81 : i32;
        v_81 = 0i;
        loop {
          let v_82 = v_81;
          if ((v_82 < 3i)) {
            {
              var v_83 : i32;
              v_83 = 0i;
              loop {
                let v_84 = v_83;
                if ((v_84 < 2i)) {
                  continue;
                } else {
                  break;
                }

                continuing {
                  let v_85 = ((v_82 * 2i) + v_84);
                  let v_86 = (v_84 == 0i);
                  v_3 = v_73;
                  let v_87 = v_3[v_82].x;
                  v_4 = v_73;
                  v_1[v_85].x = (v_73[3u].x + select(-(v_4[v_82].x), v_87, v_86));
                  v_5 = v_73;
                  let v_88 = v_5[v_82].y;
                  v_6 = v_73;
                  v_1[v_85].y = (v_73[3u].y + select(-(v_6[v_82].y), v_88, v_86));
                  v_7 = v_73;
                  let v_89 = v_7[v_82].z;
                  v_8 = v_73;
                  v_1[v_85].z = (v_73[3u].z + select(-(v_8[v_82].z), v_89, v_86));
                  v_9 = v_73;
                  let v_90 = v_9[v_82].w;
                  v_10 = v_73;
                  v_1[v_85].w = (v_73[3u].w + select(-(v_10[v_82].w), v_90, v_86));
                  let v_91 = &(v_1[v_85]);
                  let v_92 = length((*(v_91)).xyz);
                  *(v_91) = (*(v_91) * v_92);
                  v_83 = (v_84 + 1i);
                }
              }
            }
            continue;
          } else {
            break;
          }

          continuing {
            v_81 = (v_82 + 1i);
          }
        }
      }
      v_2 = v_1;
      var v_93 : bool;
      {
        var v_94 : f32;
        v_94 = 1.0f;
        var v_95 : i32;
        v_95 = 0i;
        loop {
          let v_96 = v_95;
          let v_97 = (v_94 >= 0.0f);
          if (((v_96 < 6i) & v_97)) {
            continue;
          } else {
            v_93 = v_97;
            break;
          }

          continuing {
            let v_98 = &(v_2[v_96]);
            let v_99 = mix(v_77.xyz, v_79.xyz, select(vec3<f32>(), vec3<f32>(1.0f), ((*(v_98)).xyz > vec3<f32>())));
            v_94 = dot(vec4<f32>(v_99.x, v_99.y, v_99.z, 1.0f), *(v_98));
            v_95 = (v_96 + 1i);
          }
        }
      }
      if ((v_80 | v_93)) {
        let v_100 = atomicAdd(&(u_AtomicCounterBuffer_1.m[1i]), 2u);
        u_CulledSubdBuffer.m_1[v_100] = v_13;
        u_CulledSubdBuffer.m_1[(v_100 + 1u)] = v_18;
      }
    }
  }
}
