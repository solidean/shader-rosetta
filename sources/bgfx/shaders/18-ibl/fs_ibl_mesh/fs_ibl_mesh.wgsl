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

fn main_inner(v_normal : vec3<f32>, v_view : vec3<f32>) {
  let v_1 = normalize(v.u_params[10i].xyz);
  let v_2 = v.u_params[11i].xyz;
  let v_3 = normalize(v_normal);
  let v_4 = normalize(v_view);
  let v_5 = normalize((v_4 + v_1));
  let v_6 = clamp(dot(v_3, v_4), 0.0f, 1.0f);
  let v_7 = clamp(dot(v_3, v_1), 0.0f, 1.0f);
  let v_8 = clamp(dot(v_3, v_5), 0.0f, 1.0f);
  let v_9 = clamp(dot(v_5, v_4), 0.0f, 1.0f);
  let v_10 = v.u_params[8i].xyz;
  let v_11 = v.u_params[4i].y;
  let v_12 = v.u_params[4i].x;
  var v_13 : vec3<f32>;
  if ((0.0f == v.u_params[5i].x)) {
    v_13 = mix(vec3<f32>(0.03999999910593032837f), v_10, vec3<f32>(v_11, v_11, v_11));
  } else {
    v_13 = (v.u_params[9i].xyz * vec3<f32>(v_11, v_11, v_11));
  }
  let v_14 = v_13;
  let v_15 = (v_10 * (1.0f - v_11));
  let v_16 = (vec3<f32>(1.0f) - v_14);
  let v_17 = (v_14 + ((v_16 * pow((1.0f - v_9), 5.0f)) * v_12));
  let v_18 = (v_14 + ((v_16 * pow((1.0f - v_6), 5.0f)) * v_12));
  let v_19 = (((v_15 * (vec3<f32>(1.0f) - v_17)) * v_7) * v.u_params[6i].x);
  let v_20 = v.u_params[6i].y;
  let v_21 = exp2(((10.0f * v_12) + 2.0f));
  let v_22 = ((v_19 + ((v_17 * ((pow(v_8, v_21) * v_7) * ((v_21 + 8.0f) * 0.125f))) * v_20)) * v_2);
  let v_23 = (1.0f + (5.0f * (1.0f - v_12)));
  let v_24 = transpose(mat4x4<f32>(v.u_params[0i], v.u_params[1i], v.u_params[2i], v.u_params[3i]));
  let v_25 = ((v_3 * (2.0f * v_6)) - v_4);
  let v_26 = normalize(((vec4<f32>(v_25.x, v_25.y, v_25.z, 0.0f) * v_24)).xyz);
  let v_27 = normalize(((vec4<f32>(v_3.x, v_3.y, v_3.z, 0.0f) * v_24)).xyz);
  let v_28 = v_26.x;
  let v_29 = abs(v_28);
  let v_30 = abs(v_26.y);
  let v_31 = abs(v_26.z);
  let v_32 = max(max(v_29, v_30), v_31);
  let v_33 = (1.0f - (exp2(v_23) * 0.00390625f));
  var v_34 : vec3<f32>;
  if (!((v_29 == v_32))) {
    var v_35 : vec3<f32> = v_26;
    v_35.x = (v_28 * v_33);
    v_34 = v_35;
  } else {
    v_34 = v_26;
  }
  let v_36 = v_34;
  var v_37 : vec3<f32>;
  if (!((v_30 == v_32))) {
    var v_38 : vec3<f32> = v_36;
    v_38.y = (v_36.y * v_33);
    v_37 = v_38;
  } else {
    v_37 = v_36;
  }
  let v_39 = v_37;
  var v_40 : vec3<f32>;
  if (!((v_31 == v_32))) {
    var v_41 : vec3<f32> = v_39;
    v_41.z = (v_39.z * v_33);
    v_40 = v_41;
  } else {
    v_40 = v_39;
  }
  let v_42 = pow(abs(textureSampleLevel(s_texCubeTexture, s_texCubeSampler, v_40, v_23).xyz), vec3<f32>(2.20000004768371582031f));
  let v_43 = max(vec3<f32>(), (((v_22 + (((v_15 * pow(abs(textureSample(s_texCubeIrrTexture, s_texCubeIrrSampler, v_27).xyz), vec3<f32>(2.20000004768371582031f))) * v.u_params[6i].z) + ((v_18 * v_42) * v.u_params[6i].w))) * exp2(v.u_params[4i].z)) - vec3<f32>(0.00400000018998980522f)));
  let v_44 = (v_43 * 6.19999980926513671875f);
  let v_45 = ((v_43 * (v_44 + vec3<f32>(0.5f))) / ((v_43 * (v_44 + vec3<f32>(1.70000004768371582031f))) + vec3<f32>(0.05999999865889549255f)));
  bgfx_FragData0 = vec4<f32>(v_45.x, v_45.y, v_45.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_view);
  return bgfx_FragData0;
}
