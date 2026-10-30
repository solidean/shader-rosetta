diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_s2hScatterSize : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(2u) var s_scatterColor : texture_storage_2d<rgba8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID);
  if (((v_1.x < i32(v.u_s2hScatterSize.x)) & (v_1.y < i32(v.u_s2hScatterSize.y)))) {
    textureStore(s_scatterColor, v_1.xy, vec4<f32>(0.40000000596046447754f, 0.69999998807907104492f, 0.40000000596046447754f, 1.0f));
  }
}
