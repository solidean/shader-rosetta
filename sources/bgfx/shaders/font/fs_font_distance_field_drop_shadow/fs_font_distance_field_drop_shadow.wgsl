diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_texcoord0 : vec4<f32>, v_texcoord2 : vec4<f32>) {
  var v_1 : array<f32, 4u>;
  var v_2 : array<f32, 4u>;
  var v_3 : vec4<f32>;
  switch(0u) {
    default: {
      let v_4 = v_texcoord2.xyz;
      if (!(any((v_4 == vec3<f32>())))) {
        let v_5 = textureSample(s_texColorTexture, s_texColorSampler, v_4);
        v_1[0i] = v_5.z;
        v_1[1i] = v_5.y;
        v_1[2i] = v_5.x;
        v_1[3i] = v_5.w;
        let v_6 = v_1[i32(((v_texcoord2.w * 4.0f) + 0.5f))];
        let v_7 = (((length(fwidth(v_4)) * 11.31370830535888671875f) * v.u_params.y) * v.u_params.z);
        v_3 = vec4<f32>(v_color0.x, v_color0.y, v_color0.z, (smoothstep((0.5f - v_7), (0.5f + v_7), v_6) * v_color0.w));
        break;
      }
      let v_8 = v_texcoord0.xyz;
      let v_9 = textureSample(s_texColorTexture, s_texColorSampler, v_8);
      v_2[0i] = v_9.z;
      v_2[1i] = v_9.y;
      v_2[2i] = v_9.x;
      v_2[3i] = v_9.w;
      let v_10 = v_2[i32(((v_texcoord0.w * 4.0f) + 0.5f))];
      let v_11 = ((length(fwidth(v_8)) * 11.31370830535888671875f) * v.u_params.y);
      v_3 = vec4<f32>(v_color0.x, v_color0.y, v_color0.z, (smoothstep((0.5f - v_11), (0.5f + v_11), v_10) * v_color0.w));
    }
  }
  bgfx_FragData0 = v_3;
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(2u) v_texcoord0 : vec4<f32>, @location(4u) v_texcoord2 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_texcoord0, v_texcoord2);
  return bgfx_FragData0;
}
