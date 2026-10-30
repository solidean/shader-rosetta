diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(4u) var i_light : texture_storage_2d<rgba8unorm, read_write>;

@fragment
fn main(@builtin(position) gl_FragCoord : vec4<f32>) {
  textureStore(i_light, vec2<i32>(gl_FragCoord.xy), vec4<f32>());
}
