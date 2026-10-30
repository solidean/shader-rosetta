diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var InputTextureSampler : sampler;

@group(0u) @binding(2u) var InputTextureTexture : texture_2d<f32>;

@group(0u) @binding(3u) var OutputTexture : texture_storage_2d<rgba32float, write>;

struct UniformBlock {
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@compute @workgroup_size(64u, 1u, 1u)
fn main(@builtin(local_invocation_id) gl_LocalInvocationID : vec3<u32>, @builtin(workgroup_id) gl_WorkGroupID : vec3<u32>) {
  let v_1 = vec3<i32>(gl_WorkGroupID);
  let v_2 = v.u_params[0i].x;
  let v_3 = v.u_params[0i].y;
  let v_4 = v.u_params[1i].x;
  let v_5 = v.u_params[1i].y;
  let v_6 = v.u_params[2i].x;
  let v_7 = v.u_params[2i].y;
  let v_8 = vec4<u32>(bitcast<u32>((v_2 * (1.0f / v_6))), bitcast<u32>((v_3 * (1.0f / v_7))), bitcast<u32>(((0.5f * (v_2 / v_6)) - 0.5f)), bitcast<u32>(((0.5f * (v_3 / v_7)) - 0.5f)));
  let v_9 = bitcast<u32>((1.0f / v_4));
  let v_10 = vec4<u32>(v_9, bitcast<u32>((1.0f / v_5)), v_9, bitcast<u32>((-1.0f / v_5)));
  let v_11 = bitcast<u32>(vec3<i32>(gl_LocalInvocationID).x);
  let v_12 = (vec2<u32>(((v_11 >> 1u) & 7u), ((v_11 & 1u) | ((v_11 >> 3u) & 6u))) + vec2<u32>(bitcast<u32>((v_1.x << 4u)), bitcast<u32>((v_1.y << 4u))));
  let v_13 = bitcast<vec2<f32>>(v_8.xy);
  let v_14 = bitcast<vec2<f32>>(v_8.zw);
  let v_15 = bitcast<vec2<f32>>(v_10.xy);
  let v_16 = (vec2<f32>(0.5f, -0.5f) * bitcast<vec2<f32>>(v_10.zw));
  let v_17 = bitcast<vec2<i32>>(v_12);
  let v_18 = textureSampleLevel(InputTextureTexture, InputTextureSampler, ((((vec2<f32>(v_12) * v_13) + v_14) * v_15) + v_16), 0.0f);
  textureStore(OutputTexture, v_17, v_18);
  let v_19 = v_12.x;
  let v_20 = (v_19 + 8u);
  var v_21 : vec2<u32> = v_12;
  v_21.x = v_20;
  let v_22 = v_21;
  let v_23 = bitcast<vec2<i32>>(v_22);
  let v_24 = textureSampleLevel(InputTextureTexture, InputTextureSampler, ((((vec2<f32>(v_22) * v_13) + v_14) * v_15) + v_16), 0.0f);
  textureStore(OutputTexture, v_23, v_24);
  let v_25 = vec2<u32>(v_20, (v_12.y + 8u));
  let v_26 = bitcast<vec2<i32>>(v_25);
  let v_27 = textureSampleLevel(InputTextureTexture, InputTextureSampler, ((((vec2<f32>(v_25) * v_13) + v_14) * v_15) + v_16), 0.0f);
  textureStore(OutputTexture, v_26, v_27);
  var v_28 : vec2<u32> = v_25;
  v_28.x = v_19;
  let v_29 = v_28;
  let v_30 = bitcast<vec2<i32>>(v_29);
  let v_31 = textureSampleLevel(InputTextureTexture, InputTextureSampler, ((((vec2<f32>(v_29) * v_13) + v_14) * v_15) + v_16), 0.0f);
  textureStore(OutputTexture, v_30, v_31);
}
