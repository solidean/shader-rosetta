diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var u_DmapSamplerSampler : sampler;

@group(0u) @binding(2u) var u_DmapSamplerTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_modelViewProj : mat4x4<f32>,
  u_params : array<vec4<f32>, 2u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

struct u_CulledSubdBuffer {
  m : array<u32>,
}

@group(0u) @binding(4u) var<storage, read> u_CulledSubdBuffer_1 : u_CulledSubdBuffer;

struct u_VertexBuffer {
  m_1 : array<vec4<f32>>,
}

@group(0u) @binding(5u) var<storage, read> u_VertexBuffer_1 : u_VertexBuffer;

@group(0u) @binding(6u) var<storage, read> u_IndexBuffer : u_CulledSubdBuffer;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec2<f32>;

fn main_inner(a_texcoord0 : vec2<f32>, gl_InstanceID : u32) {
  let v_3 = (bitcast<i32>(gl_InstanceID) * 2i);
  let v_4 = (u_CulledSubdBuffer_1.m[v_3] * 3u);
  let v_5 = u_VertexBuffer_1.m_1[u_IndexBuffer.m[v_4]];
  let v_6 = u_VertexBuffer_1.m_1[u_IndexBuffer.m[(v_4 + 1u)]];
  let v_7 = u_VertexBuffer_1.m_1[u_IndexBuffer.m[(v_4 + 2u)]];
  let v_8 = u_CulledSubdBuffer_1.m[(v_3 + 1i)];
  var v_9 : mat3x3<f32>;
  {
    var v_10 : mat3x3<f32>;
    v_10 = mat3x3<f32>(vec3<f32>(1.0f, 0.0f, 0.0f), vec3<f32>(0.0f, 1.0f, 0.0f), vec3<f32>(0.0f, 0.0f, 1.0f));
    var v_11 : u32;
    v_11 = v_8;
    loop {
      let v_12 = v_11;
      let v_13 = v_10;
      if ((v_12 > 1u)) {
        continue;
      } else {
        v_9 = v_13;
        break;
      }

      continuing {
        let v_14 = f32((v_12 & 1u));
        let v_15 = (1.0f - v_14);
        v_10 = (transpose(mat3x3<f32>(vec3<f32>(0.0f, v_15, v_14), vec3<f32>(0.5f, v_14, 0.0f), vec3<f32>(0.5f, 0.0f, v_15))) * v_13);
        v_11 = (v_12 >> 1u);
      }
    }
  }
  let v_16 = (mat3x4<f32>(v_5, v_6, v_7) * v_9);
  let v_17 = v_16[0u];
  let v_18 = ((v_17 + ((v_16[1u] - v_17) * a_texcoord0.x)) + ((v_16[2u] - v_17) * a_texcoord0.y));
  var v_19 : vec4<f32> = v_18;
  v_19.z = (v_18.z + (textureSampleLevel(u_DmapSamplerTexture, u_DmapSamplerSampler, ((v_18.xy * 0.5f) + vec2<f32>(0.5f)), 0.0f).x * v.u_params[0i].x));
  let v_20 = v_19;
  v_1 = (v_20 * transpose(v.u_modelViewProj));
  v_2 = ((v_20.xy * 0.5f) + vec2<f32>(0.5f));
}

struct tint_symbol {
  @builtin(position)
  m_2 : vec4<f32>,
  @location(0u)
  m_3 : vec2<f32>,
}

@vertex
fn main(@location(0u) a_texcoord0 : vec2<f32>, @builtin(instance_index) gl_InstanceID : u32) -> tint_symbol {
  main_inner(a_texcoord0, gl_InstanceID);
  return tint_symbol(v_1, v_2);
}
