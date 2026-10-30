diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texColorSampler : sampler;

@group(0u) @binding(2u) var s_texColorTexture : texture_cube<f32>;

struct UniformBlock {
  u_params : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_color0 : vec4<f32>, v_color1 : vec4<f32>, v_texcoord0 : vec4<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>) {
  var v_1 : array<f32, 4u>;
  var v_2 : array<f32, 4u>;
  var v_3 : vec4<f32>;
  switch(0u) {
    default: {
      let v_4 = v_texcoord1.xyz;
      if (!(any((v_4 == vec3<f32>())))) {
        let v_5 = textureSample(s_texColorTexture, s_texColorSampler, v_4);
        v_3 = vec4<f32>(v_5.x, v_5.y, v_5.z, (v_5.w * v_color0.w));
        break;
      }
      let v_6 = v_texcoord2.xyz;
      if (!(any((v_6 == vec3<f32>())))) {
        let v_7 = textureSample(s_texColorTexture, s_texColorSampler, v_6);
        v_1[0i] = v_7.z;
        v_1[1i] = v_7.y;
        v_1[2i] = v_7.x;
        v_1[3i] = v_7.w;
        let v_8 = v_1[i32(((v_texcoord2.w * 4.0f) + 0.5f))];
        let v_9 = ((length(fwidth(v_6)) * 11.31370830535888671875f) * v.u_params.y);
        let v_10 = (0.5f - (v.u_params.w * v_9));
        let v_11 = (v_9 * v.u_params.z);
        v_3 = vec4<f32>(v_color0.x, v_color0.y, v_color0.z, (smoothstep((v_10 - v_11), (v_10 + v_11), v_8) * v_color0.w));
        break;
      }
      let v_12 = v_texcoord0.xyz;
      let v_13 = textureSample(s_texColorTexture, s_texColorSampler, v_12);
      v_2[0i] = v_13.z;
      v_2[1i] = v_13.y;
      v_2[2i] = v_13.x;
      v_2[3i] = v_13.w;
      let v_14 = v_2[i32(((v_texcoord0.w * 4.0f) + 0.5f))];
      let v_15 = ((length(fwidth(v_12)) * 11.31370830535888671875f) * v.u_params.y);
      let v_16 = (0.5f - (v.u_params.w * v_15));
      let v_17 = smoothstep((v_16 - v_15), (v_16 + v_15), v_14);
      let v_18 = smoothstep((0.5f - v_15), (0.5f + v_15), v_14);
      let v_19 = mix(v_color1.xyz, v_color0.xyz, vec3<f32>(v_18, v_18, v_18));
      v_3 = vec4<f32>(v_19.x, v_19.y, v_19.z, (v_17 * v_color0.w));
    }
  }
  bgfx_FragData0 = v_3;
}

@fragment
fn main(@location(0u) v_color0 : vec4<f32>, @location(1u) v_color1 : vec4<f32>, @location(2u) v_texcoord0 : vec4<f32>, @location(3u) v_texcoord1 : vec4<f32>, @location(4u) v_texcoord2 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_color0, v_color1, v_texcoord0, v_texcoord1, v_texcoord2);
  return bgfx_FragData0;
}
