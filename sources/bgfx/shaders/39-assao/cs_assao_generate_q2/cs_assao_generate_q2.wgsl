diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_viewspaceDepthSourceSampler : sampler;

@group(0u) @binding(2u) var s_viewspaceDepthSourceTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_viewspaceDepthSourceMirrorSampler : sampler;

@group(0u) @binding(3u) var s_viewspaceDepthSourceMirrorTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
  u_rect : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(4u) var s_normalmapSource : texture_2d<f32>;

@group(0u) @binding(8u) var s_target : texture_storage_2d_array<rg8unorm, write>;

@compute @workgroup_size(8u, 8u, 1u)
fn main(@builtin(global_invocation_id) gl_GlobalInvocationID : vec3<u32>) {
  var v_1 : array<vec4<f32>, 32u>;
  let v_2 = bitcast<vec2<u32>>(vec3<i32>(gl_GlobalInvocationID).xy);
  let v_3 = v.u_rect;
  let v_4 = (v_2 + vec2<u32>(v_3.xy));
  let v_5 = vec2<f32>(v_4);
  if (all((v_5 < v_3.zw))) {
    let v_6 = trunc(v_5);
    let v_7 = (v_6 * v.u_params[0i].zw);
    let v_8 = textureGather(0i, s_viewspaceDepthSourceMirrorTexture, s_viewspaceDepthSourceMirrorSampler, v_7);
    let v_9 = textureGather(0i, s_viewspaceDepthSourceMirrorTexture, s_viewspaceDepthSourceMirrorSampler, v_7, vec2<i32>(1i));
    let v_10 = v_8.y;
    let v_11 = v_8.x;
    let v_12 = v_8.z;
    let v_13 = v_9.z;
    let v_14 = v_9.x;
    let v_15 = v.u_params[4i];
    let v_16 = v_15.xy;
    let v_17 = ((v_6 * v_16) + v_15.zw);
    let v_18 = v.u_params[2i];
    let v_19 = v_18.xy;
    let v_20 = v_18.zw;
    let v_21 = (((v_19 * v_17) + v_20) * v_10);
    let v_22 = vec3<f32>(v_21.x, v_21.y, v_10);
    let v_23 = bitcast<vec2<i32>>(vec2<u32>((vec2<f32>((vec2<u32>(v_6) * vec2<u32>(2u))) + v.u_params[3i].xy)));
    let v_24 = textureLoad(s_normalmapSource, v_23, 0i).xyz;
    let v_25 = v.u_params[14i].x;
    let v_26 = vec3<f32>(v_25, v_25, v_25);
    let v_27 = v.u_params[14i].y;
    let v_28 = vec3<f32>(v_27, v_27, v_27);
    let v_29 = ((v_24 * v_26) + v_28);
    let v_30 = v.u_params[15i].xyz;
    let v_31 = dot(v_29, v_30);
    let v_32 = v.u_params[16i].xyz;
    let v_33 = dot(v_29, v_32);
    let v_34 = v.u_params[17i].xyz;
    let v_35 = vec3<f32>(v_31, v_33, dot(v_29, v_34));
    let v_36 = ((v_19 * v_10) * v_16);
    let v_37 = length(v_22);
    let v_38 = (v.u_params[5i].x * ((clamp((v_37 * v.u_params[6i].w), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_39 = v_36.x;
    let v_40 = ((0.85000002384185791016f * v_38) / v_39);
    let v_41 = (v_38 * v_38);
    let v_42 = (-1.0f / v_41);
    let v_43 = v.u_params[(9u + (u32(((v_6.y * 2.0f) + v_6.x)) % 5u))];
    let v_44 = (v_22 * v.u_params[7i].x);
    let v_45 = (vec4<f32>(v_11, v_13, v_12, v_14) - vec4<f32>(v_10, v_10, v_10, v_10));
    let v_46 = (v_10 * 0.03999999910593032837f);
    let v_47 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_45), abs((v_45 + v_45.yxwz))) / vec4<f32>(v_46, v_46, v_46, v_46))), vec4<f32>(), vec4<f32>(1.0f));
    let v_48 = (v_44.xy / v_44.zz);
    let v_49 = vec3<f32>(v_48.x, v_48.y, 1.0f);
    let v_50 = v_44.z;
    let v_51 = (vec3<f32>(-(v_39), 0.0f, 0.0f) + (v_49 * (v_11 - v_50)));
    let v_52 = (vec3<f32>(v_39, 0.0f, 0.0f) + (v_49 * (v_13 - v_50)));
    let v_53 = v_36.y;
    let v_54 = (vec3<f32>(0.0f, -(v_53), 0.0f) + (v_49 * (v_12 - v_50)));
    let v_55 = (vec3<f32>(0.0f, v_53, 0.0f) + (v_49 * (v_14 - v_50)));
    let v_56 = (-4.0f / v_41);
    let v_57 = dot(v_51, v_51);
    let v_58 = (dot(v_35, v_51) / sqrt(v_57));
    let v_59 = max(0.0f, ((v_57 * v_56) + 1.0f));
    let v_60 = v.u_params[6i].z;
    let v_61 = (max(0.0f, (v_58 - v_60)) * v_59);
    let v_62 = dot(v_52, v_52);
    let v_63 = (dot(v_35, v_52) / sqrt(v_62));
    let v_64 = max(0.0f, ((v_62 * v_56) + 1.0f));
    let v_65 = (max(0.0f, (v_63 - v_60)) * v_64);
    let v_66 = dot(v_54, v_54);
    let v_67 = (dot(v_35, v_54) / sqrt(v_66));
    let v_68 = max(0.0f, ((v_66 * v_56) + 1.0f));
    let v_69 = (max(0.0f, (v_67 - v_60)) * v_68);
    let v_70 = dot(v_55, v_55);
    let v_71 = (dot(v_35, v_55) / sqrt(v_70));
    let v_72 = max(0.0f, ((v_70 * v_56) + 1.0f));
    let v_73 = vec4<f32>(v_61, v_65, v_69, (max(0.0f, (v_71 - v_60)) * v_72));
    let v_74 = (v.u_params[14i].z * dot(v_73, v_47));
    let v_75 = ((textureLoad(s_normalmapSource, (v_23 + vec2<i32>(-2i, 0i)), 0i).xyz * v_26) + v_28);
    let v_76 = vec3<f32>(dot(v_75, v_30), dot(v_75, v_32), dot(v_75, v_34));
    let v_77 = ((textureLoad(s_normalmapSource, (v_23 + vec2<i32>(2i, 0i)), 0i).xyz * v_26) + v_28);
    let v_78 = vec3<f32>(dot(v_77, v_30), dot(v_77, v_32), dot(v_77, v_34));
    let v_79 = ((textureLoad(s_normalmapSource, (v_23 + vec2<i32>(0i, -2i)), 0i).xyz * v_26) + v_28);
    let v_80 = vec3<f32>(dot(v_79, v_30), dot(v_79, v_32), dot(v_79, v_34));
    let v_81 = ((textureLoad(s_normalmapSource, (v_23 + vec2<i32>(0i, 2i)), 0i).xyz * v_26) + v_28);
    let v_82 = vec3<f32>(dot(v_81, v_30), dot(v_81, v_32), dot(v_81, v_34));
    let v_83 = (v_47 * vec4<f32>(clamp((dot(v_35, v_76) + 0.5f), 0.0f, 1.0f), clamp((dot(v_35, v_78) + 0.5f), 0.0f, 1.0f), clamp((dot(v_35, v_80) + 0.5f), 0.0f, 1.0f), clamp((dot(v_35, v_82) + 0.5f), 0.0f, 1.0f)));
    let v_84 = (log2(v_40) + -4.30000019073486328125f);
    var v_85 : f32;
    var v_86 : f32;
    {
      var v_87 : f32;
      v_87 = 0.0f;
      var v_88 : f32;
      v_88 = v_74;
      var v_89 : u32;
      v_89 = 0u;
      loop {
        let v_90 = v_89;
        let v_91 = v_88;
        let v_92 = v_87;
        if ((v_90 < 12u)) {
          continue;
        } else {
          v_85 = v_91;
          v_86 = v_92;
          break;
        }

        continuing {
          let v_93 = bitcast<i32>(v_90);
          v_1 = array<vec4<f32>, 32u>(vec4<f32>(0.78488063812255859375f, 0.5666167140007019043f, 1.5f, -0.12608300149440765381f), vec4<f32>(0.26022231578826904297f, -0.29575172066688537598f, 1.5f, -1.06403005123138427734f), vec4<f32>(0.10459356755018234253f, 0.08372527360916137695f, 1.11000001430511474609f, -2.73056292533874511719f), vec4<f32>(-0.68286800384521484375f, 0.04963044822216033936f, 1.09000003337860107422f, -0.4988270103931427002f), vec4<f32>(-0.13570161163806915283f, -0.64190155267715454102f, 1.25f, -0.53276497125625610352f), vec4<f32>(-0.26193794608116149902f, -0.08205118030309677124f, 0.67000001668930053711f, -1.78324496746063232422f), vec4<f32>(-0.61177456378936767578f, 0.66664218902587890625f, 0.70999997854232788086f, -0.04423400014638900757f), vec4<f32>(0.43675562739372253418f, 0.25119024515151977539f, 0.61000001430511474609f, -1.16728305816650390625f), vec4<f32>(0.07884444296360015869f, 0.86618667840957641602f, 0.63999998569488525391f, -0.45900198817253112793f), vec4<f32>(-0.12790934741497039795f, -0.29869005084037780762f, 0.60000002384185791016f, -1.72942399978637695312f), vec4<f32>(-0.04031125083565711975f, 0.02413621917366981506f, 0.60000002384185791016f, -4.792041778564453125f), vec4<f32>(0.162012442946434021f, -0.52851414680480957031f, 0.79000002145767211914f, -1.06705498695373535156f), vec4<f32>(-0.70991218090057373047f, 0.47301071882247924805f, 0.63999998569488525391f, -0.33523601293563842773f), vec4<f32>(0.03277707099914550781f, -0.22349689900875091553f, 0.60000002384185791016f, -1.98238396644592285156f), vec4<f32>(0.6892172694206237793f, 0.36800742149353027344f, 0.62999999523162841797f, -0.26671800017356872559f), vec4<f32>(0.29251813888549804688f, 0.37775412201881408691f, 0.61000001430511474609f, -1.42252004146575927734f), vec4<f32>(-0.12224089354276657104f, 0.96582591533660888672f, 0.60000002384185791016f, -0.42614200711250305176f), vec4<f32>(0.11071456968784332275f, -0.16131058335304260254f, 0.60000002384185791016f, -2.16594696044921875f), vec4<f32>(0.46562141180038452148f, -0.597476959228515625f, 0.60000002384185791016f, -0.18975999951362609863f), vec4<f32>(-0.51548796892166137695f, 0.11804193258285522461f, 0.60000002384185791016f, -1.24679994583129882812f), vec4<f32>(0.89141309261322021484f, -0.42090442776679992676f, 0.60000002384185791016f, 0.02819200046360492706f), vec4<f32>(-0.32402530312538146973f, -0.01591528952121734619f, 0.60000002384185791016f, -1.54301798343658447266f), vec4<f32>(0.6077124476432800293f, 0.41635221242904663086f, 0.60000002384185791016f, -0.60541099309921264648f), vec4<f32>(0.02379564940929412842f, -0.08239821344614028931f, 0.60000002384185791016f, -3.80904603004455566406f), vec4<f32>(0.4895115196704864502f, -0.23657044768333435059f, 0.60000002384185791016f, -1.18901097774505615234f), vec4<f32>(-0.17611564695835113525f, -0.8169689178466796875f, 0.60000002384185791016f, -0.5137240290641784668f), vec4<f32>(-0.33930185437202453613f, -0.20732204616069793701f, 0.60000002384185791016f, -1.69804704189300537109f), vec4<f32>(-0.91974425315856933594f, 0.05403209105134010315f, 0.60000002384185791016f, 0.06224599853157997131f), vec4<f32>(-0.15064626932144165039f, -0.14949332177639007568f, 0.60000002384185791016f, -1.89606201648712158203f), vec4<f32>(0.53180974721908569336f, -0.35210400819778442383f, 0.60000002384185791016f, -0.7588379979133605957f), vec4<f32>(0.41487166285514831543f, 0.81442588567733764648f, 0.60000002384185791016f, -0.50564801692962646484f), vec4<f32>(-0.24106961488723754883f, -0.3272151648998260498f, 0.60000002384185791016f, -1.66524398326873779297f));
          let v_94 = v_1[v_93];
          let v_95 = v_94.z;
          let v_96 = round((v_94.xy * mat2x2<f32>(vec2<f32>((v_43.x * v_40), (v_43.y * v_40)), vec2<f32>((v_43.z * v_40), (v_43.w * v_40)))));
          let v_97 = (v_94.w + v_84);
          let v_98 = ((v_96 * v_16) + v_17);
          let v_99 = textureSampleLevel(s_viewspaceDepthSourceTexture, s_viewspaceDepthSourceSampler, v_98, v_97).x;
          let v_100 = (((v_19 * v_98) + v_20) * v_99);
          let v_101 = (vec3<f32>(v_100.x, v_100.y, v_99) - v_44);
          let v_102 = dot(v_101, v_101);
          let v_103 = (dot(v_35, v_101) / sqrt(v_102));
          let v_104 = max(0.0f, ((v_102 * v_42) + 1.0f));
          let v_105 = (max(0.0f, (v_103 - v_60)) * v_104);
          let v_106 = max(0.0f, -(v_101.z));
          let v_107 = v.u_params[7i].y;
          let v_108 = (((0.60000002384185791016f * clamp(((v_106 * v_107) + 2.0f), 0.0f, 1.0f)) + 0.40000000596046447754f) * v_95);
          let v_109 = ((-(v_96) * v_16) + v_17);
          let v_110 = textureSampleLevel(s_viewspaceDepthSourceTexture, s_viewspaceDepthSourceSampler, v_109, v_97).x;
          let v_111 = (((v_19 * v_109) + v_20) * v_110);
          let v_112 = (vec3<f32>(v_111.x, v_111.y, v_110) - v_44);
          let v_113 = dot(v_112, v_112);
          let v_114 = (dot(v_35, v_112) / sqrt(v_113));
          let v_115 = max(0.0f, ((v_113 * v_42) + 1.0f));
          let v_116 = (max(0.0f, (v_114 - v_60)) * v_115);
          let v_117 = (((0.60000002384185791016f * clamp(((max(0.0f, -(v_112.z)) * v_107) + 2.0f), 0.0f, 1.0f)) + 0.40000000596046447754f) * v_95);
          let v_118 = (v_90 + bitcast<u32>(1i));
          v_87 = ((v_92 + v_108) + v_117);
          v_88 = ((v_91 + (v_105 * v_108)) + (v_116 * v_117));
          v_89 = v_118;
        }
      }
    }
    let v_119 = v_86;
    let v_120 = (v_85 / v_119);
    let v_121 = (clamp(((v_50 * v.u_params[6i].x) + v.u_params[6i].y), 0.0f, 1.0f) * clamp((1.0f - (clamp((((1.0f - v_83.x) - v_83.y) * 0.34999999403953552246f), 0.0f, 1.0f) + clamp((((1.0f - v_83.z) - v_83.w) * 0.34999999403953552246f), 0.0f, 1.0f))), 0.0f, 1.0f));
    let v_122 = vec2<f32>(pow(clamp((1.0f - (min((v.u_params[5i].y * v_120), v.u_params[5i].w) * v_121)), 0.0f, 1.0f), v.u_params[5i].z), dot(round((clamp(v_83, vec4<f32>(), vec4<f32>(1.0f)) * 3.04999995231628417969f)), vec4<f32>(0.2509804069995880127f, 0.06274510174989700317f, 0.01568627543747425079f, 0.0039215688593685627f)));
    let v_123 = bitcast<vec2<i32>>(v_4);
    let v_124 = vec3<i32>(v_123.x, v_123.y, i32(v.u_params[14i].w));
    textureStore(s_target, v_124.xy, v_124.z, vec4<f32>(v_122.xy, vec2<f32>()));
  }
}
