diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_normalSampler : sampler;

@group(0u) @binding(3u) var s_normalTexture : texture_2d<f32>;

@group(0u) @binding(20u) var s_velocitySampler : sampler;

@group(0u) @binding(4u) var s_velocityTexture : texture_2d<f32>;

@group(0u) @binding(21u) var s_previousColorSampler : sampler;

@group(0u) @binding(5u) var s_previousColorTexture : texture_2d<f32>;

@group(0u) @binding(22u) var s_previousNormalSampler : sampler;

@group(0u) @binding(6u) var s_previousNormalTexture : texture_2d<f32>;

struct UniformBlock {
  u_viewRect : vec4<f32>,
  u_viewTexel : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  var v_1 : array<f32, 4u>;
  var v_2 : array<vec2<f32>, 4u>;
  let v_3 = textureSample(s_colorTexture, s_colorSampler, v_texcoord0);
  let v_4 = ((textureSample(s_normalTexture, s_normalSampler, v_texcoord0).xyz * 2.0f) - vec3<f32>(1.0f));
  let v_5 = (((v_texcoord0 - textureSample(s_velocityTexture, s_velocitySampler, v_texcoord0).xy) * v.u_viewRect.zw) - vec2<f32>(0.5f));
  let v_6 = floor(v_5);
  let v_7 = fract(v_5);
  let v_8 = v_7.x;
  let v_9 = (1.0f - v_8);
  let v_10 = v_7.y;
  let v_11 = (1.0f - v_10);
  v_1[0i] = (v_9 * v_11);
  v_1[1i] = (v_8 * v_11);
  v_1[2i] = (v_9 * v_10);
  v_1[3i] = (v_8 * v_10);
  let v_12 = v.u_viewTexel.xy;
  v_2[0i] = ((v_6 + vec2<f32>(0.5f)) * v_12);
  v_2[1i] = ((v_6 + vec2<f32>(1.5f, 0.5f)) * v_12);
  v_2[2i] = ((v_6 + vec2<f32>(0.5f, 1.5f)) * v_12);
  v_2[3i] = ((v_6 + vec2<f32>(1.5f)) * v_12);
  var v_13 : f32;
  var v_14 : vec4<f32>;
  {
    var v_15 : vec4<f32>;
    v_15 = vec4<f32>();
    var v_16 : f32;
    v_16 = 0.0f;
    var v_17 : i32;
    v_17 = 0i;
    loop {
      let v_18 = v_17;
      let v_19 = v_16;
      let v_20 = v_15;
      if ((v_18 < 4i)) {
        continue;
      } else {
        v_13 = v_19;
        v_14 = v_20;
        break;
      }

      continuing {
        let v_21 = &(v_2[v_18]);
        let v_22 = select(1.0f, 0.0f, (dot(v_4, ((textureSample(s_previousNormalTexture, s_previousNormalSampler, *(v_21)).xyz * 2.0f) - vec3<f32>(1.0f))) < 0.70710676908493041992f));
        let v_23 = textureSample(s_previousColorTexture, s_previousColorSampler, *(v_21));
        let v_24 = (v_22 * v_1[v_18]);
        v_15 = (v_20 + (v_23 * v_24));
        v_16 = (v_19 + v_24);
        v_17 = (v_18 + 1i);
      }
    }
  }
  let v_25 = v_14;
  let v_26 = v_13;
  var v_27 : vec4<f32>;
  if ((0.0f < v_26)) {
    v_27 = mix(v_3, (v_25 * (1.0f / v_26)), vec4<f32>(0.80000001192092895508f));
  } else {
    v_27 = v_3;
  }
  bgfx_FragData0 = v_27;
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
