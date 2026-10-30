diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_inputRTSize : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_texOcclusionDepthIn : texture_2d<f32>;

@group(0u) @binding(3u) var s_texOcclusionDepthOut : texture_storage_2d<r32float, write>;

@compute @workgroup_size(16u, 16u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = vec2<f32>(v_1);
  let v_3 = v.u_inputRTSize;
  if (all((v_2 < v_3.xy))) {
    let v_4 = (v_3.zw * v_2);
    let v_5 = textureLoad(s_texOcclusionDepthIn, vec2<i32>(v_4), 0i).x;
    let v_6 = textureLoad(s_texOcclusionDepthIn, vec2<i32>((v_4 + vec2<f32>(1.0f, 0.0f))), 0i).x;
    let v_7 = textureLoad(s_texOcclusionDepthIn, vec2<i32>((v_4 + vec2<f32>(0.0f, 1.0f))), 0i).x;
    let v_8 = textureLoad(s_texOcclusionDepthIn, vec2<i32>((v_4 + vec2<f32>(1.0f))), 0i).x;
    let v_9 = max(max(v_5, v_6), max(v_7, v_8));
    textureStore(s_texOcclusionDepthOut, v_1, vec4<f32>(v_9));
  }
}
