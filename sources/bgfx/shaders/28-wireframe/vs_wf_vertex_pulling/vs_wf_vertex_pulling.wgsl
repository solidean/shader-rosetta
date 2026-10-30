diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct indices {
  m : array<u32>,
}

@group(0u) @binding(3u) var<storage, read> indices_1 : indices;

struct UniformBlock_1_1 {
  u_viewRect : vec4<f32>,
  u_modelViewProj : mat4x4<f32>,
  u_params : array<vec4<f32>, 3u>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock_1_1;

@group(0u) @binding(2u) var<storage, read> positions : indices;

var<private> v_1 : vec4<f32>;

var<private> v_2 : vec4<f32>;

fn main_inner(gl_VertexID : u32) {
  var v_3 : array<vec2<f32>, 6u>;
  let v_4 = (gl_VertexID / 6u);
  let v_5 = (v_4 % 3u);
  let v_6 = ((v_4 - v_5) + ((v_5 + 1u) % 3u));
  var v_7 : u32;
  switch(0u) {
    default: {
      let v_8 = indices_1.m[(v_4 / 2u)];
      if (((v_4 % 2u) == 0u)) {
        v_7 = (v_8 & 65535u);
        break;
      } else {
        v_7 = (v_8 >> 16u);
        break;
      }
    }
  }
  let v_9 = v_7;
  var v_10 : u32;
  switch(0u) {
    default: {
      let v_11 = indices_1.m[(v_6 / 2u)];
      if (((v_6 % 2u) == 0u)) {
        v_10 = (v_11 & 65535u);
        break;
      } else {
        v_10 = (v_11 >> 16u);
        break;
      }
    }
  }
  let v_12 = v_10;
  let v_13 = u32(v.u_params[2i].z);
  let v_14 = (v_9 * v_13);
  let v_15 = bitcast<f32>(positions.m[v_14]);
  let v_16 = bitcast<f32>(positions.m[(v_14 + 1u)]);
  let v_17 = bitcast<f32>(positions.m[(v_14 + 2u)]);
  let v_18 = (v_12 * v_13);
  let v_19 = bitcast<f32>(positions.m[v_18]);
  let v_20 = bitcast<f32>(positions.m[(v_18 + 1u)]);
  let v_21 = bitcast<f32>(positions.m[(v_18 + 2u)]);
  let v_22 = transpose(v.u_modelViewProj);
  let v_23 = (vec4<f32>(v_15, v_16, v_17, 1.0f) * v_22);
  let v_24 = (vec4<f32>(v_19, v_20, v_21, 1.0f) * v_22);
  let v_25 = v.u_params[1i];
  let v_26 = vec4<f32>(v_25.x, v_25.y, v_25.z, v.u_params[1i].w);
  let v_27 = v_23.w;
  var v_28 : vec4<f32>;
  var v_29 : vec4<f32>;
  if ((v_27 < 0.00100000004749745131f)) {
    let v_30 = ((0.00100000004749745131f - v_27) / (v_24.w - v_27));
    let v_31 = vec4<f32>(v_30, v_30, v_30, v_30);
    let v_32 = mix(v_23, v_24, v_31);
    let v_33 = mix(v_26, v_26, v_31);
    v_28 = v_32;
    v_29 = v_33;
  } else {
    v_28 = v_23;
    v_29 = v_26;
  }
  let v_34 = v_29;
  let v_35 = v_28;
  let v_36 = v_24.w;
  var v_37 : vec4<f32>;
  var v_38 : vec4<f32>;
  if ((v_36 < 0.00100000004749745131f)) {
    let v_39 = ((0.00100000004749745131f - v_36) / (v_27 - v_36));
    let v_40 = vec4<f32>(v_39, v_39, v_39, v_39);
    let v_41 = mix(v_24, v_23, v_40);
    let v_42 = mix(v_26, v_26, v_40);
    v_37 = v_41;
    v_38 = v_42;
  } else {
    v_37 = v_24;
    v_38 = v_26;
  }
  let v_43 = v_38;
  let v_44 = v_37;
  v_3 = array<vec2<f32>, 6u>(vec2<f32>(-1.0f), vec2<f32>(-1.0f, 1.0f), vec2<f32>(1.0f, -1.0f), vec2<f32>(1.0f, -1.0f), vec2<f32>(-1.0f, 1.0f), vec2<f32>(1.0f));
  let v_45 = ((v_3[(gl_VertexID % 6u)] * 0.5f) + vec2<f32>(0.5f));
  let v_46 = v_45.x;
  let v_47 = vec4<f32>(v_46, v_46, v_46, v_46);
  let v_48 = mix(v_35, v_44, v_47);
  let v_49 = mix(v_34, v_43, v_47);
  let v_50 = v_35.w;
  let v_51 = v_44.w;
  let v_52 = ((v_44.xy / vec2<f32>(v_51, v_51)) - (v_35.xy / vec2<f32>(v_50, v_50)));
  let v_53 = length(v_52);
  var v_54 : vec4<f32>;
  if ((v_53 > 0.00009999999747378752f)) {
    let v_55 = (v_52 / vec2<f32>(v_53, v_53));
    let v_56 = (2.0f / v.u_viewRect.z);
    let v_57 = (2.0f / v.u_viewRect.w);
    let v_58 = (v_48.xy + ((((vec2<f32>(-(v_55.y), v_55.x) * (0.5f * v.u_params[2i].y)) * ((2.0f * v_45.y) - 1.0f)) * vec2<f32>(v_56, v_57)) * v_48.w));
    var v_59 : vec4<f32> = v_48;
    v_59.x = v_58.x;
    var v_60 : vec4<f32> = v_59;
    v_60.y = v_58.y;
    v_54 = v_60;
  } else {
    v_54 = v_48;
  }
  v_1 = v_54;
  v_2 = v_49;
}

struct tint_symbol {
  @builtin(position)
  m_1 : vec4<f32>,
  @location(0u)
  m_2 : vec4<f32>,
}

@vertex
fn main(@builtin(vertex_index) gl_VertexID : u32) -> tint_symbol {
  main_inner(gl_VertexID);
  return tint_symbol(v_1, v_2);
}
