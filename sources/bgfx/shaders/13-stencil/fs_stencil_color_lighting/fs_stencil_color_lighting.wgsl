diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock_1_1 {
  u_view : mat4x4<f32>,
  u_params : vec4<f32>,
  u_ambient : vec4<f32>,
  u_diffuse : vec4<f32>,
  u_color : vec4<f32>,
  u_specular_shininess : vec4<f32>,
  u_lightPosRadius : array<vec4<f32>, 5u>,
  u_lightRgbInnerR : array<vec4<f32>, 5u>,
}

@group(0u) @binding(1u) var<uniform> v : UniformBlock_1_1;

var<private> bgfx_FragData0 : vec4<f32>;

fn main_inner(v_normal : vec3<f32>, v_view : vec3<f32>) {
  let v_1 = normalize(v_normal);
  let v_2 = -(normalize(v_view));
  let v_3 = (v.u_ambient.xyz * v.u_params.x);
  var v_4 : vec3<f32>;
  {
    var v_5 : vec3<f32>;
    v_5 = vec3<f32>();
    var v_6 : i32;
    v_6 = 0i;
    loop {
      var v_7 : vec3<f32>;
      let v_8 = v_6;
      let v_9 = v_5;
      if ((v_8 < 5i)) {
        let v_10 = v.u_params.z;
        var v_11 : f32;
        if ((v_10 > 1.0f)) {
          v_11 = (1.0f - step(v_10, f32(v_8)));
        } else {
          v_11 = select(0.0f, 1.0f, (f32(v_8) == v.u_params.w));
        }
        let v_12 = v_11;
        let v_13 = v.u_lightPosRadius[v_8];
        let v_14 = (((vec4<f32>(v_13.x, v_13.y, v_13.z, 1.0f) * transpose(v.u_view))).xyz - v_view);
        let v_15 = normalize(v_14);
        let v_16 = dot(v_1, v_15);
        let v_17 = dot(((v_1 * (2.0f * v_16)) - v_15), v_2);
        let v_18 = v.u_specular_shininess.w;
        let v_19 = max(0.0f, v_16);
        let v_20 = (step(0.0f, v_16) * pow(max(0.0f, v_17), v_18));
        let v_21 = (250.0f * pow(max(length(v_14), v.u_lightPosRadius[v_8].w), -2.0f));
        v_7 = (v_9 + (((((v.u_diffuse.xyz * v_19) + (v.u_specular_shininess.xyz * v_20)) * v.u_lightRgbInnerR[v_8].xyz) * v_21) * v_12));
        continue;
      } else {
        v_4 = v_9;
        break;
      }

      continuing {
        v_5 = v_7;
        v_6 = (v_8 + 1i);
      }
    }
  }
  let v_22 = (v_4 * v.u_params.y);
  let v_23 = v.u_color.xyz;
  let v_24 = clamp((pow(abs((v_3 * v_23)), vec3<f32>(0.45454546809196472168f)) + pow(abs((v_22 * v_23)), vec3<f32>(0.45454546809196472168f))), vec3<f32>(), vec3<f32>(1.0f));
  bgfx_FragData0 = vec4<f32>(v_24.x, v_24.y, v_24.z, v.u_color.w);
}

@fragment
fn main(@location(0u) v_normal : vec3<f32>, @location(1u) v_view : vec3<f32>) -> @location(0u) vec4<f32> {
  main_inner(v_normal, v_view);
  return bgfx_FragData0;
}
