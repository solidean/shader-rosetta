diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(2u) var s_texOcclusionDepthTexture : texture_2d<f32>;

struct UniformBlock {
  u_inputRTSize : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(3u) var s_texOcclusionDepthOut : texture_storage_2d<r32float, write>;

@compute @workgroup_size(16u, 16u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  let v_2 = v_1.xy;
  if (all((vec2<f32>(v_2) < v.u_inputRTSize.xy))) {
    let v_3 = textureLoad(s_texOcclusionDepthTexture, vec3<i32>(v_1.x, v_1.y, 0i).xy, 0i).x;
    textureStore(s_texOcclusionDepthOut, v_2, vec4<f32>(v_3));
  }
}
