diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_color1 : vec4<f32>, v_texcoord0 : vec4<f32>, v_texcoord1 : vec4<f32>) {
  var v_1 : array<f32, 4u>;
  var v_2 : vec4<f32>;
  switch(0u) {
    default: {
      let v_3 = v_texcoord0.xyz;
      if (any((v_3 == vec3<f32>()))) {
        let v_4 = textureSample(s_texColorTexture, s_texColorSampler, v_texcoord1.xyz);
        v_2 = vec4<f32>(v_4.x, v_4.y, v_4.z, (v_4.w * v_color0.w));
        break;
      }
      let v_5 = textureSample(s_texColorTexture, s_texColorSampler, v_3);
      v_1[0i] = v_5.z;
      v_1[1i] = v_5.y;
      v_1[2i] = v_5.x;
      v_1[3i] = v_5.w;
      let v_6 = v_1[i32(((v_texcoord0.w * 4.0f) + 0.5f))];
      let v_7 = ((length(fwidth(v_3)) * 11.31370830535888671875f) * v.u_params.y);
      let v_8 = (0.5f - (v.u_params.w * v_7));
      let v_9 = smoothstep((v_8 - v_7), (v_8 + v_7), v_6);
      let v_10 = smoothstep((0.5f - v_7), (0.5f + v_7), v_6);
      let v_11 = mix(v_color1.xyz, v_color0.xyz, vec3<f32>(v_10, v_10, v_10));
      v_2 = vec4<f32>(v_11.x, v_11.y, v_11.z, (v_9 * v_color0.w));
    }
  }
  bgfx_FragData0 = v_2;
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_color1 : vec4<f32>, @location(2u) v_texcoord0 : vec4<f32>, @location(3u) v_texcoord1 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_color1, v_texcoord0, v_texcoord1);
  return bgfx_FragData0;
}
