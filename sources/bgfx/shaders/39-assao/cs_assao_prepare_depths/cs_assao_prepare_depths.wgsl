diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(2u) var s_depthSourceTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(3u) var s_target0 : texture_storage_2d<r16float, write>;

@group(0u) @binding(4u) var s_target1 : texture_storage_2d<r16float, write>;

@group(0u) @binding(5u) var s_target2 : texture_storage_2d<r16float, write>;

@group(0u) @binding(6u) var s_target3 : texture_storage_2d<r16float, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_GlobalInvocationID).xy;
  let v_2 = bitcast<vec2<u32>>(v_1);
  if (all((vec2<f32>(v_2) < vec2<f32>(textureDimensions(s_target0))))) {
    let v_3 = (v_1 * vec2<i32>(2i));
    let v_4 = textureLoad(s_depthSourceTexture, vec3<i32>(v_3.x, v_3.y, 0i).xy, 0i).x;
    let v_5 = (v_3 + vec2<i32>(1i, 0i));
    let v_6 = textureLoad(s_depthSourceTexture, vec3<i32>(v_5.x, v_5.y, 0i).xy, 0i).x;
    let v_7 = (v_3 + vec2<i32>(0i, 1i));
    let v_8 = textureLoad(s_depthSourceTexture, vec3<i32>(v_7.x, v_7.y, 0i).xy, 0i).x;
    let v_9 = (v_3 + vec2<i32>(1i));
    let v_10 = textureLoad(s_depthSourceTexture, vec3<i32>(v_9.x, v_9.y, 0i).xy, 0i).x;
    let v_11 = v.u_params[1i].x;
    let v_12 = v.u_params[1i].y;
    textureStore(s_target0, v_1, vec4<f32>((v_11 / (v_12 - v_4))));
    textureStore(s_target1, v_1, vec4<f32>((v_11 / (v_12 - v_6))));
    textureStore(s_target2, v_1, vec4<f32>((v_11 / (v_12 - v_8))));
    textureStore(s_target3, v_1, vec4<f32>((v_11 / (v_12 - v_10))));
  }
}
