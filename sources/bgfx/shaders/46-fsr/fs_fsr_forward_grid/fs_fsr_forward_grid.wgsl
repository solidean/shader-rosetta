diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  u_modelParams : array<vec4<f32>, 2u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_texcoord1 : vec4<f32>, v_texcoord2 : vec4<f32>) {
  let v_1 = v.u_modelParams[0i].xyz;
  let v_2 = abs(floor((v_texcoord1.xz + vec2<f32>(-0.00200000009499490261f))));
  let v_3 = v_2.x;
  let v_4 = v_2.y;
  let v_5 = select(1.25f, 0.75f, (i32((v_3 - (2.0f * floor((v_3 * 0.5f))))) == i32((v_4 - (2.0f * floor((v_4 * 0.5f)))))));
  let v_6 = (pow(abs(v_1), vec3<f32>(2.20000004768371582031f)) * v_5);
  let v_7 = normalize(v_normal);
  let v_8 = normalize((v.u_modelParams[1i].xyz - v_texcoord1.xyz));
  let v_9 = clamp(dot(v_7, v_8), 0.0f, 1.0f);
  let v_10 = (5.0f * pow(clamp(dot(v_7, normalize((v_texcoord2.xyz + v_8))), 0.0f, 1.0f), 256.0f));
  let v_11 = ((v_6 * (0.10000000149011611938f + v_9)) + vec3<f32>(v_10, v_10, v_10));
  bgfx_FragData0 = vec4<f32>(v_11.x, v_11.y, v_11.z, 1.0f);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(2u) v_texcoord1 : vec4<f32>, @location(3u) v_texcoord2 : vec4<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_texcoord1, v_texcoord2);
  return bgfx_FragData0;
}
