diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(19u) var s_importanceMapSampler : sampler;

@group(0u) @binding(3u) var s_importanceMapTexture : texture_2d<f32>;

@group(0u) @binding(2u) var s_target : texture_storage_2d<r8unorm, write>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct s_loadCounter_atomic {
  m : array<atomic<u32>>,
}

@group(0u) @binding(4u) var<storage, read_write> s_loadCounter_1 : s_loadCounter_atomic;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = bitcast<vec2<u32>>(v_1);
  let v_3 = vec2<f32>(v_2);
  if (all((v_3 < vec2<f32>(textureDimensions(s_target))))) {
    let v_4 = v.u_params[8i].zw;
    let v_5 = ((v_3 + vec2<f32>(0.5f)) * v_4);
    let v_6 = (v_4 * 0.5f);
    let v_7 = v_6.x;
    let v_8 = v_6.y;
    let v_9 = dot(vec4<f32>(textureSampleLevel(s_importanceMapTexture, s_importanceMapSampler, (v_5 + vec2<f32>(-(v_7), (v_8 * -3.0f))), 0.0f).x, textureSampleLevel(s_importanceMapTexture, s_importanceMapSampler, (v_5 + vec2<f32>((v_7 * 3.0f), -(v_8))), 0.0f).x, textureSampleLevel(s_importanceMapTexture, s_importanceMapSampler, (v_5 + vec2<f32>(v_7, (v_8 * 3.0f))), 0.0f).x, textureSampleLevel(s_importanceMapTexture, s_importanceMapSampler, (v_5 + vec2<f32>((v_7 * -3.0f), v_8)), 0.0f).x), vec4<f32>(0.25f));
    let v_10 = u32(((clamp(v_9, 0.0f, 1.0f) * 255.0f) + 0.5f));
    if ((((v_2.x % 3u) + (v_2.y % 3u)) == 0u)) {
      _ = atomicAdd(&(s_loadCounter_1.m[0i]), v_10);
    }
    textureStore(s_target, v_1, vec4<f32>(v_9));
  }
}
