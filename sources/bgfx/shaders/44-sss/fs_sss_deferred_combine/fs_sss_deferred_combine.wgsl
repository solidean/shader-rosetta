diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_depthSampler : sampler;

@group(0u) @binding(4u) var s_depthTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_shadowsSampler : sampler;

@group(0u) @binding(5u) var s_shadowsTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 12u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_2 = pow(abs(v_1.xyz), vec3<f32>(2.20000004768371582031f));
  var v_3 : vec3<f32>;
  if ((0.0f < v_1.w)) {
    let v_4 = textureSample(s_normalTexture, s_normalSampler, v_texcoord0);
    let v_5 = (v_4.xyz * 255.0f);
    let v_6 = (v_5.y * 0.0625f);
    let v_7 = min(max(((vec2<f32>(((v_5.x * 16.0f) + floor(v_6)), ((fract(v_6) * 4096.0f) + v_5.z)) * 0.00048851978499442339f) - vec2<f32>(1.0f)), vec2<f32>(-1.0f)), vec2<f32>(1.0f));
    let v_8 = v_7.x;
    let v_9 = v_7.y;
    let v_10 = ((1.0f - abs(v_8)) - abs(v_9));
    let v_11 = vec3<f32>(v_8, v_9, v_10);
    var v_12 : vec3<f32>;
    if ((v_10 < 0.0f)) {
      let v_13 = ((vec2<f32>(1.0f) - abs(v_11.yx)) * vec2<f32>(select(-1.0f, 1.0f, (v_8 >= 0.0f)), select(-1.0f, 1.0f, (v_9 >= 0.0f))));
      var v_14 : vec3<f32> = v_11;
      v_14.x = v_13.x;
      var v_15 : vec3<f32> = v_14;
      v_15.y = v_13.y;
      v_12 = v_15;
    } else {
      v_12 = v_11;
    }
    let v_16 = normalize(v_12);
    let v_17 = ((vec4<f32>(v_16.x, v_16.y, v_16.z, 0.0f) * transpose(mat4x4<f32>(v.u_params[4i], v.u_params[5i], v.u_params[6i], v.u_params[7i])))).xyz;
    let v_18 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
    let v_19 = v.u_params[2i];
    let v_20 = (((v_19.xy * v_texcoord0) + v_19.zw) * v_18);
    let v_21 = textureSample(s_shadowsTexture, s_shadowsSampler, v_texcoord0).x;
    let v_22 = (v.u_params[3i].xyz - vec3<f32>(v_20.x, v_20.y, v_18));
    let v_23 = (dot(v_22, v_22) + 0.00000999999974737875f);
    let v_24 = clamp(dot(v_17, normalize(v_22)), 0.0f, 1.0f);
    let v_25 = pow(abs((v_2 * (mix((v_24 * (1.0f / v_23)), (5.0f * pow(v_24, ((62.0f * (1.0f - v_4.w)) + 2.0f))), 0.03999999910593032837f) * v_21))), vec3<f32>(0.45454546809196472168f));
    var v_26 : vec3<f32>;
    if ((0.0f < v.u_params[3i].w)) {
      v_26 = vec3<f32>(v_21, v_21, v_21);
    } else {
      v_26 = v_25;
    }
    v_3 = v_26;
  } else {
    v_3 = v_2;
  }
  let v_27 = v_3;
  bgfx_FragData0 = vec4<f32>(v_27.x, v_27.y, v_27.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
