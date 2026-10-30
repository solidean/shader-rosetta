diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_colorSampler : sampler;

@group(0u) @binding(2u) var s_colorTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_depthSampler : sampler;

@group(0u) @binding(3u) var s_depthTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 13u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_texcoord0 : vec2<f32>) {
  let v_1 = dot(pow(abs(textureSample(s_colorTexture, s_colorSampler, v_texcoord0).xyz), vec3<f32>(0.45454546809196472168f)), vec3<f32>(0.33000001311302185059f, 0.34000000357627868652f, 0.33000001311302185059f));
  let v_2 = vec3<f32>(v_1, v_1, v_1);
  let v_3 = textureSample(s_depthTexture, s_depthSampler, v_texcoord0).x;
  let v_4 = v.u_params[3i].y;
  let v_5 = clamp((((1.0f / v_4) - (1.0f / v_3)) * v.u_params[3i].z), -1.0f, 1.0f);
  let v_6 = (v_5 < 0.0f);
  let v_7 = (select(vec3<f32>(0.04313725605607032776f, 0.34901961684226989746f, 0.5411764979362487793f), vec3<f32>(0.73333334922790527344f, 0.23921568691730499268f, 0.02745098061859607697f), vec3<bool>(v_6, v_6, v_6)) * v_2);
  let v_8 = abs(v_5);
  let v_9 = mix(v_2, v_7, vec3<f32>(v_8, v_8, v_8));
  bgfx_FragData0 = vec4<f32>(v_9.x, v_9.y, v_9.z, 1.0f);
}

@fragment
fn main(@location(0u) v_texcoord0 : vec2<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_texcoord0);
  return bgfx_FragData0;
}
