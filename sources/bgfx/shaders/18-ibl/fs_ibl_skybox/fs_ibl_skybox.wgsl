diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_texCubeSampler : sampler;

@group(0u) @binding(2u) var s_texCubeTexture : texture_cube<f32>;

@group(0u) @binding(19u) var s_texCubeIrrSampler : sampler;

@group(0u) @binding(3u) var s_texCubeIrrTexture : texture_cube<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 12u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_dir : vec3<f32>) {
  let v_1 = normalize(v_dir);
  let v_2 = v.u_params[4i].w;
  var v_3 : vec4<f32>;
  if ((v_2 == 7.0f)) {
    let v_4 = textureSample(s_texCubeIrrTexture, s_texCubeIrrSampler, v_1);
    let v_5 = pow(abs(v_4.xyz), vec3<f32>(2.20000004768371582031f));
    v_3 = vec4<f32>(v_5.x, v_5.y, v_5.z, v_4.w);
  } else {
    let v_6 = v_1.x;
    let v_7 = abs(v_6);
    let v_8 = abs(v_1.y);
    let v_9 = abs(v_1.z);
    let v_10 = max(max(v_7, v_8), v_9);
    let v_11 = (1.0f - (exp2(v_2) * 0.00390625f));
    var v_12 : vec3<f32>;
    if (!((v_7 == v_10))) {
      var v_13 : vec3<f32> = v_1;
      v_13.x = (v_6 * v_11);
      v_12 = v_13;
    } else {
      v_12 = v_1;
    }
    let v_14 = v_12;
    var v_15 : vec3<f32>;
    if (!((v_8 == v_10))) {
      var v_16 : vec3<f32> = v_14;
      v_16.y = (v_14.y * v_11);
      v_15 = v_16;
    } else {
      v_15 = v_14;
    }
    let v_17 = v_15;
    var v_18 : vec3<f32>;
    if (!((v_9 == v_10))) {
      var v_19 : vec3<f32> = v_17;
      v_19.z = (v_17.z * v_11);
      v_18 = v_19;
    } else {
      v_18 = v_17;
    }
    let v_20 = textureSampleLevel(s_texCubeTexture, s_texCubeSampler, v_18, v_2);
    let v_21 = pow(abs(v_20.xyz), vec3<f32>(2.20000004768371582031f));
    v_3 = vec4<f32>(v_21.x, v_21.y, v_21.z, v_20.w);
  }
  let v_22 = (v_3 * exp2(v.u_params[4i].z));
  let v_23 = max(vec3<f32>(), (v_22.xyz - vec3<f32>(0.00400000018998980522f)));
  let v_24 = (v_23 * 6.19999980926513671875f);
  let v_25 = ((v_23 * (v_24 + vec3<f32>(0.5f))) / ((v_23 * (v_24 + vec3<f32>(1.70000004768371582031f))) + vec3<f32>(0.05999999865889549255f)));
  bgfx_FragData0 = vec4<f32>(v_25.x, v_25.y, v_25.z, v_22.w);
}

@fragment
fn main(@location(0u) v_dir : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_dir);
  return bgfx_FragData0;
}
