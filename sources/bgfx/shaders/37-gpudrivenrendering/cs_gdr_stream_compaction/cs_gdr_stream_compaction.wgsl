diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

struct UniformBlock {
  bgfx_indirectArgBase : vec4<f32>,
  u_cullingConfig : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

struct instancePredicates {
  m : array<u32>,
}

@group(0u) @binding(4u) var<storage, read> instancePredicates_1 : instancePredicates;

var<workgroup> temp : array<u32, 2048u>;

struct instanceDataOut {
  m_1 : array<vec4<f32>>,
}

@group(0u) @binding(7u) var<storage, read_write> instanceDataOut_1 : instanceDataOut;

struct instanceDataIn {
  m_2 : array<vec4<f32>>,
}

@group(0u) @binding(3u) var<storage, read> instanceDataIn_1 : instanceDataIn;

struct drawcallData {
  m_3 : array<vec4<u32>>,
}

@group(0u) @binding(6u) var<storage, read_write> drawcallData_1 : drawcallData;

struct drawcallConstData {
  m_4 : array<u32>,
}

@group(0u) @binding(2u) var<storage, read> drawcallConstData_1 : drawcallConstData;

struct drawcallInstanceCount {
  m_5 : array<u32>,
}

@group(0u) @binding(5u) var<storage, read_write> drawcallInstanceCount_1 : drawcallInstanceCount;

@compute @workgroup_size(1024u, 1u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  let v_1 = bitcast<u32>(vec3<i32>(gl_GlobalInvocationID).x);
  let v_2 = i32(v.u_cullingConfig.y);
  let v_3 = i32(v.u_cullingConfig.w);
  let v_4 = (2u * v_1);
  temp[v_4] = bitcast<u32>(select(0i, 1i, (instancePredicates_1.m[v_4] != 0u)));
  let v_5 = (v_4 + 1u);
  temp[v_5] = bitcast<u32>(select(0i, 1i, (instancePredicates_1.m[v_5] != 0u)));
  let v_6 = (v_2 >> bitcast<u32>(1i));
  var v_7 : i32;
  {
    var v_8 : i32;
    v_8 = 1i;
    var v_9 : i32;
    v_9 = v_6;
    loop {
      var v_10 : i32;
      let v_11 = v_9;
      let v_12 = v_8;
      if ((v_11 > 0i)) {
        workgroupBarrier();
        if ((v_1 < bitcast<u32>(v_11))) {
          let v_13 = bitcast<u32>(v_12);
          let v_14 = bitcast<i32>(((v_13 * v_5) - 1u));
          let v_15 = bitcast<i32>(((v_13 * (v_4 + 2u)) - 1u));
          let v_16 = temp[v_14];
          let v_17 = &(temp[v_15]);
          *(v_17) = (*(v_17) + v_16);
        }
        v_10 = (v_12 * 2i);
        continue;
      } else {
        v_7 = v_12;
        break;
      }

      continuing {
        let v_18 = v_10;
        let v_19 = (v_11 >> bitcast<u32>(1i));
        v_8 = v_18;
        v_9 = v_19;
      }
    }
  }
  let v_20 = v_7;
  let v_21 = (v_1 == 0u);
  if (v_21) {
    temp[(v_2 - 1i)] = 0u;
  }
  {
    var v_22 : i32;
    v_22 = v_20;
    var v_23 : i32;
    v_23 = 1i;
    loop {
      var v_24 : i32;
      let v_25 = v_23;
      let v_26 = v_22;
      if ((v_25 < v_2)) {
        let v_27 = (v_26 >> bitcast<u32>(1i));
        workgroupBarrier();
        if ((v_1 < bitcast<u32>(v_25))) {
          let v_28 = bitcast<u32>(v_27);
          let v_29 = bitcast<i32>(((v_28 * v_5) - 1u));
          let v_30 = bitcast<i32>(((v_28 * (v_4 + 2u)) - 1u));
          let v_31 = &(temp[v_29]);
          let v_32 = *(v_31);
          let v_33 = &(temp[v_30]);
          *(v_31) = *(v_33);
          *(v_33) = (*(v_33) + v_32);
        }
        v_24 = v_27;
        continue;
      } else {
        break;
      }

      continuing {
        v_22 = v_24;
        v_23 = (v_25 * 2i);
      }
    }
  }
  workgroupBarrier();
  let v_34 = bitcast<i32>(v_4);
  if ((instancePredicates_1.m[v_34] != 0u)) {
    let v_35 = &(temp[v_34]);
    let v_36 = (4u * *(v_35));
    let v_37 = (4i * v_34);
    instanceDataOut_1.m_1[v_36] = instanceDataIn_1.m_2[v_37];
    let v_38 = ((4u * *(v_35)) + 1u);
    instanceDataOut_1.m_1[v_38] = instanceDataIn_1.m_2[(v_37 + 1i)];
    let v_39 = ((4u * *(v_35)) + 2u);
    instanceDataOut_1.m_1[v_39] = instanceDataIn_1.m_2[(v_37 + 2i)];
    let v_40 = ((4u * *(v_35)) + 3u);
    instanceDataOut_1.m_1[v_40] = instanceDataIn_1.m_2[(v_37 + 3i)];
  }
  let v_41 = bitcast<i32>(v_5);
  if ((instancePredicates_1.m[v_41] != 0u)) {
    let v_42 = &(temp[v_41]);
    let v_43 = (4u * *(v_42));
    let v_44 = (4i * v_41);
    instanceDataOut_1.m_1[v_43] = instanceDataIn_1.m_2[v_44];
    let v_45 = ((4u * *(v_42)) + 1u);
    instanceDataOut_1.m_1[v_45] = instanceDataIn_1.m_2[(v_44 + 1i)];
    let v_46 = ((4u * *(v_42)) + 2u);
    instanceDataOut_1.m_1[v_46] = instanceDataIn_1.m_2[(v_44 + 2i)];
    let v_47 = ((4u * *(v_42)) + 3u);
    instanceDataOut_1.m_1[v_47] = instanceDataIn_1.m_2[(v_44 + 3i)];
  }
  if (v_21) {
    {
      var v_48 : u32;
      v_48 = 0u;
      var v_49 : i32;
      v_49 = 0i;
      loop {
        let v_50 = v_49;
        let v_51 = v_48;
        if ((v_50 < v_3)) {
          continue;
        } else {
          break;
        }

        continuing {
          let v_52 = (v_50 * 2i);
          let v_53 = (v_50 * 3i);
          let v_54 = &(drawcallInstanceCount_1.m_5[v_50]);
          drawcallData_1.m_3[v_52] = vec4<u32>(drawcallConstData_1.m_4[v_53], *(v_54), (bitcast<u32>(v.bgfx_indirectArgBase.x) + drawcallConstData_1.m_4[(v_53 + 1i)]), drawcallConstData_1.m_4[(v_53 + 2i)]);
          drawcallData_1.m_3[(v_52 + 1i)] = vec4<u32>(v_51, 0u, 0u, 0u);
          let v_55 = (v_51 + *(v_54));
          *(v_54) = 0u;
          v_48 = v_55;
          v_49 = (v_50 + 1i);
        }
      }
    }
  }
}
