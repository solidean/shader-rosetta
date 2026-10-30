diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_sunDirection : vec4<f32>,
  u_skyLuminanceXYZ : vec4<f32>,
  u_parameters : vec4<f32>,
  u_perezCoeff : array<vec4<f32>, 5u>,
  u_invViewProj : mat4x4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec2<f32>;

var<private> v_3 : vec3<f32>;

var<private> v_4 : vec3<f32>;

fn main_inner(a_position : vec3<f32>) {
  let v_5 = a_position.x;
  let v_6 = a_position.y;
  let v_7 = transpose(v.u_invViewProj);
  let v_8 = (vec4<f32>(v_5, v_6, -1.0f, 1.0f) * v_7);
  let v_9 = vec4<f32>(v_5, v_6, 1.0f, 1.0f);
  let v_10 = (v_9 * v_7);
  let v_11 = v_8.w;
  let v_12 = v_10.w;
  let v_13 = normalize((((v_10 / vec4<f32>(v_12, v_12, v_12, v_12))).xyz - ((v_8 / vec4<f32>(v_11, v_11, v_11, v_11))).xyz));
  let v_14 = abs(v_13.y);
  var v_15 : vec3<f32> = v_13;
  v_15.y = v_14;
  let v_16 = v_15;
  let v_17 = normalize(v.u_sunDirection.xyz);
  let v_18 = v.u_perezCoeff[0i].xyz;
  let v_19 = v.u_perezCoeff[1i].xyz;
  let v_20 = v.u_perezCoeff[2i].xyz;
  let v_21 = v.u_perezCoeff[3i].xyz;
  let v_22 = v.u_perezCoeff[4i].xyz;
  let v_23 = max(v_14, 0.00100000004749745131f);
  let v_24 = clamp(dot(v_16, v_17), -0.99989998340606689453f, 0.99989998340606689453f);
  let v_25 = v_17.y;
  let v_26 = acos(v_24);
  let v_27 = ((vec3<f32>(1.0f) + (v_18 * exp((v_19 * (1.0f / v_23))))) * ((vec3<f32>(1.0f) + (v_20 * exp((v_21 * v_26)))) + (v_22 * (v_24 * v_24))));
  let v_28 = acos(v_25);
  let v_29 = ((vec3<f32>(1.0f) + (v_18 * exp((v_19 * 1.0f)))) * ((vec3<f32>(1.0f) + (v_20 * exp((v_21 * v_28)))) + (v_22 * (v_25 * v_25))));
  let v_30 = v.u_skyLuminanceXYZ.x;
  let v_31 = v.u_skyLuminanceXYZ.y;
  let v_32 = ((v_30 + v_31) + v.u_skyLuminanceXYZ.z);
  let v_33 = ((vec3<f32>((v_30 / v_32), (v_31 / v_32), v_31) * v_27) / v_29);
  let v_34 = v_33.x;
  let v_35 = v_33.z;
  let v_36 = v_33.y;
  let v_37 = (vec3<f32>(((v_34 * v_35) / v_36), v_35, ((((1.0f - v_34) - v_36) * v_35) / v_36)) * v.u_parameters.z);
  let v_38 = vec3<f32>(dot(vec3<f32>(3.24045419692993164062f, -1.53713846206665039062f, -0.49853140115737915039f), v_37), dot(vec3<f32>(-0.96926599740982055664f, 1.87601077556610107422f, 0.04155600070953369141f), v_37), dot(vec3<f32>(0.05564339831471443176f, -0.2040258944034576416f, 1.05722522735595703125f), v_37));
  v_1 = v_9;
  v_2 = a_position.xy;
  v_3 = v_38;
  v_4 = v_16;
}

struct tint_symbol {
  @builtin(position)
  m : vec4<f32>,
  @location(0u)
  m_1 : vec2<f32>,
  @location(1u)
  m_2 : vec3<f32>,
  @location(2u)
  m_3 : vec3<f32>,
}

@vertex
fn main(@location(0u) a_position : vec3<f32>) -> tint_symbol {
  main_inner(a_position);
  return tint_symbol(v_1, v_2, v_3, v_4);
}
