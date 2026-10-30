diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_sky_viewSampler : sampler;

@group(0u) @binding(2u) var s_sky_viewTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_atmo_transmittanceSampler : sampler;

@group(0u) @binding(3u) var s_atmo_transmittanceTexture : texture_2d<f32>;

struct UniformBlock_1_1 {
  u_atmoPlanet : vec4<f32>,
  u_skyInvViewProj : mat4x4<f32>,
  u_skyParams : vec4<f32>,
  u_sunDirection : vec4<f32>,
  u_sunRadiance : vec4<f32>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = v_texcoord0.x;
  let v_2 = v_texcoord0.y;
  let v_3 = transpose(v.u_skyInvViewProj);
  let v_4 = (vec4<f32>(v_1, v_2, 0.0f, 1.0f) * v_3);
  let v_5 = (vec4<f32>(v_1, v_2, 1.0f, 1.0f) * v_3);
  let v_6 = v_4.w;
  let v_7 = v_5.w;
  let v_8 = normalize(((v_5.xyz / vec3<f32>(v_7, v_7, v_7)) - (v_4.xyz / vec3<f32>(v_6, v_6, v_6))));
  let v_9 = v.u_skyParams.x;
  let v_10 = -(normalize(v.u_sunDirection.xyz));
  var v_11 : f32;
  switch(0u) {
    default: {
      let v_12 = vec2<f32>(v_8.x, v_8.z);
      let v_13 = vec2<f32>(v_10.x, v_10.z);
      let v_14 = length(v_12);
      let v_15 = length(v_13);
      if (((v_14 < 0.00000999999974737875f) | (v_15 < 0.00000999999974737875f))) {
        v_11 = 0.0f;
        break;
      }
      let v_16 = (v_12 / vec2<f32>(v_14, v_14));
      let v_17 = (v_13 / vec2<f32>(v_15, v_15));
      v_11 = atan2(((v_16.x * v_17.y) - (v_16.y * v_17.x)), dot(v_16, v_17));
    }
  }
  let v_18 = v_11;
  let v_19 = v_8.y;
  let v_20 = (v_9 * v_9);
  let v_21 = v.u_atmoPlanet.x;
  let v_22 = (v_21 * v_21);
  let v_23 = sqrt(max((v_20 - v_22), 0.0f));
  let v_24 = acos(clamp((v_23 / v_9), -1.0f, 1.0f));
  let v_25 = (3.14159274101257324219f - v_24);
  let v_26 = acos(clamp(v_19, -1.0f, 1.0f));
  var v_27 : f32;
  if ((v_26 < v_25)) {
    v_27 = ((1.0f - sqrt((1.0f - (v_26 / v_25)))) * 0.5f);
  } else {
    v_27 = ((sqrt(clamp(((v_26 - v_25) / max(v_24, 0.00009999999747378752f)), 0.0f, 1.0f)) * 0.5f) + 0.5f);
  }
  let v_28 = textureSampleLevel(s_sky_viewTexture, s_sky_viewSampler, vec2<f32>(((v_18 * 0.15915493667125701904f) + 0.5f), v_27), 0.0f).xyz;
  let v_29 = dot(v_8, v_10);
  let v_30 = (v_20 * ((v_19 * v_19) - 1.0f));
  var v_31 : vec3<f32>;
  if (!(((v_19 < 0.0f) & ((v_30 + v_22) >= 0.0f)))) {
    let v_32 = v.u_atmoPlanet.y;
    let v_33 = (v_32 * v_32);
    let v_34 = sqrt((v_33 - v_22));
    let v_35 = (v_32 - v_9);
    let v_36 = textureSampleLevel(s_atmo_transmittanceTexture, s_atmo_transmittanceSampler, vec2<f32>(((max(0.0f, ((-(v_9) * v_19) + sqrt(max((v_30 + v_33), 0.0f)))) - v_35) / ((v_23 + v_34) - v_35)), (v_23 / v_34)), 0.0f).xyz;
    let v_37 = exp2(((v_29 - 1.0f) * 12000.0f));
    let v_38 = v.u_sunRadiance.xyz;
    let v_39 = v.u_skyParams.z;
    let v_40 = (v_28 + (((v_38 * v_36) * (v_39 * 0.02999999932944774628f)) * v_37));
    let v_41 = v.u_skyParams.y;
    var v_42 : vec3<f32>;
    if ((v_29 >= v_41)) {
      v_42 = (v_40 + (((v_38 * v_39) * v_36) * pow(max((1.0f - clamp(((1.0f - v_29) / max((1.0f - v_41), 0.00000010000000116861f)), 0.0f, 1.0f)), 0.0f), 0.30000001192092895508f)));
    } else {
      v_42 = v_40;
    }
    v_31 = v_42;
  } else {
    v_31 = v_28;
  }
  let v_43 = (v_31 * 1.60000002384185791016f);
  let v_44 = clamp(((v_43 * ((v_43 * 2.50999999046325683594f) + vec3<f32>(0.02999999932944774628f))) / ((v_43 * ((v_43 * 2.43000006675720214844f) + vec3<f32>(0.58999997377395629883f))) + vec3<f32>(0.14000000059604644775f))), vec3<f32>(), vec3<f32>(1.0f));
  bgfx_FragData0 = vec4<f32>(v_44.x, v_44.y, v_44.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
