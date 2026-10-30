diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_quadPostColorSampler : sampler;

@group(0u) @binding(2u) var s_quadPostColorTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(gl_FragCoord : vec4<f32>) {
  let v_1 = (floor(gl_FragCoord.xy) - vec2<f32>(32.0f, 48.0f));
  let v_2 = v_1.x;
  let v_3 = v_1.y;
  var v_4 : vec3<f32>;
  if (((((v_2 >= 0.0f) & (v_3 >= 0.0f)) & (v_2 < 512.0f)) & (v_3 < 64.0f))) {
    let v_5 = (v_2 * 0.015625f);
    let v_6 = u32(v_5);
    let v_7 = floor(vec2<f32>(((v_2 * 0.125f) - (8.0f * floor(v_5))), (v_3 * 0.125f)));
    var v_8 : u32;
    switch(0u) {
      default: {
        if ((0u == v_6)) {
          v_8 = 85u;
          break;
        }
        if ((1u == v_6)) {
          v_8 = 115u;
          break;
        }
        if ((2u == v_6)) {
          v_8 = 101u;
          break;
        }
        if ((3u == v_6)) {
          v_8 = 114u;
          break;
        }
        if ((4u == v_6)) {
          v_8 = 70u;
          break;
        }
        if ((5u == v_6)) {
          v_8 = 111u;
          break;
        }
        if ((6u == v_6)) {
          v_8 = 110u;
          break;
        }
        v_8 = 116u;
      }
    }
    v_4 = textureSample(s_quadPostColorTexture, s_quadPostColorSampler, ((vec2<f32>(((f32((v_8 - 32u)) * 8.0f) + v_7.x), v_7.y) + vec2<f32>(0.5f)) / v.u_viewRect.zw)).xyz;
  } else {
    v_4 = vec3<f32>(0.01999999955296516418f, 0.01999999955296516418f, 0.02999999932944774628f);
  }
  let v_9 = v_4;
  bgfx_FragData0 = vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f);
}

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(gl_FragCoord);
  return bgfx_FragData0;
}
