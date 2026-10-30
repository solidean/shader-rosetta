diagnostic(off, derivative_uniformity);
diagnostic(off, subgroup_uniformity);

@group(0u) @binding(18u) var s_viewspaceDepthSourceSampler : sampler;

@group(0u) @binding(2u) var s_viewspaceDepthSourceTexture : texture_2d<f32>;

@group(0u) @binding(19u) var s_viewspaceDepthSourceMirrorSampler : sampler;

@group(0u) @binding(3u) var s_viewspaceDepthSourceMirrorTexture : texture_2d<f32>;

@group(0u) @binding(22u) var s_importanceMapSampler : sampler;

@group(0u) @binding(6u) var s_importanceMapTexture : texture_2d<f32>;

struct UniformBlock {
  u_params : array<vec4<f32>, 19u>,
  u_rect : vec4<f32>,
}

@group(0u) @binding(0u) var<uniform> v : UniformBlock;

@group(0u) @binding(4u) var s_normalmapSource : texture_2d<f32>;

@group(0u) @binding(7u) var s_baseSSAO : texture_2d_array<f32>;

struct s_loadCounter {
  m : array<u32>,
}

@group(0u) @binding(5u) var<storage, read> s_loadCounter_1 : s_loadCounter;

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
    let v_7 = vec2<u32>(v_6);
    let v_8 = (v_6 * v.u_params[0i].zw);
    let v_9 = textureGather(0i, s_viewspaceDepthSourceMirrorTexture, s_viewspaceDepthSourceMirrorSampler, v_8);
    let v_10 = textureGather(0i, s_viewspaceDepthSourceMirrorTexture, s_viewspaceDepthSourceMirrorSampler, v_8, vec2<i32>(1i));
    let v_11 = v_9.y;
    let v_12 = v_9.x;
    let v_13 = v_9.z;
    let v_14 = v_10.z;
    let v_15 = v_10.x;
    let v_16 = v.u_params[4i];
    let v_17 = v_16.xy;
    let v_18 = ((v_6 * v_17) + v_16.zw);
    let v_19 = v.u_params[2i];
    let v_20 = v_19.xy;
    let v_21 = v_19.zw;
    let v_22 = (((v_20 * v_18) + v_21) * v_11);
    let v_23 = vec3<f32>(v_22.x, v_22.y, v_11);
    let v_24 = v.u_params[3i];
    let v_25 = bitcast<vec2<i32>>(vec2<u32>((vec2<f32>((v_7 * vec2<u32>(2u))) + v_24.xy)));
    let v_26 = textureLoad(s_normalmapSource, v_25, 0i).xyz;
    let v_27 = v.u_params[14i].x;
    let v_28 = vec3<f32>(v_27, v_27, v_27);
    let v_29 = v.u_params[14i].y;
    let v_30 = vec3<f32>(v_29, v_29, v_29);
    let v_31 = ((v_26 * v_28) + v_30);
    let v_32 = v.u_params[15i].xyz;
    let v_33 = dot(v_31, v_32);
    let v_34 = v.u_params[16i].xyz;
    let v_35 = dot(v_31, v_34);
    let v_36 = v.u_params[17i].xyz;
    let v_37 = vec3<f32>(v_33, v_35, dot(v_31, v_36));
    let v_38 = ((v_20 * v_11) * v_17);
    let v_39 = length(v_23);
    let v_40 = (v.u_params[5i].x * ((clamp((v_39 * v.u_params[6i].w), 0.0f, 1.0f) * 0.80000001192092895508f) + 0.20000000298023223877f));
    let v_41 = v_38.x;
    let v_42 = ((0.85000002384185791016f * v_40) / v_41);
    let v_43 = (v_40 * v_40);
    let v_44 = (-1.0f / v_43);
    let v_45 = v.u_params[(9u + (u32(((v_6.y * 2.0f) + v_6.x)) % 5u))];
    let v_46 = (v_23 * v.u_params[7i].x);
    let v_47 = (vec4<f32>(v_12, v_14, v_13, v_15) - vec4<f32>(v_11, v_11, v_11, v_11));
    let v_48 = (v_11 * 0.03999999910593032837f);
    let v_49 = clamp((vec4<f32>(1.29999995231628417969f) - (min(abs(v_47), abs((v_47 + v_47.yxwz))) / vec4<f32>(v_48, v_48, v_48, v_48))), vec4<f32>(), vec4<f32>(1.0f));
    let v_50 = (v_46.xy / v_46.zz);
    let v_51 = vec3<f32>(v_50.x, v_50.y, 1.0f);
    let v_52 = v_46.z;
    let v_53 = (vec3<f32>(-(v_41), 0.0f, 0.0f) + (v_51 * (v_12 - v_52)));
    let v_54 = (vec3<f32>(v_41, 0.0f, 0.0f) + (v_51 * (v_14 - v_52)));
    let v_55 = v_38.y;
    let v_56 = (vec3<f32>(0.0f, -(v_55), 0.0f) + (v_51 * (v_13 - v_52)));
    let v_57 = (vec3<f32>(0.0f, v_55, 0.0f) + (v_51 * (v_15 - v_52)));
    let v_58 = (-4.0f / v_43);
    let v_59 = dot(v_53, v_53);
    let v_60 = (dot(v_37, v_53) / sqrt(v_59));
    let v_61 = max(0.0f, ((v_59 * v_58) + 1.0f));
    let v_62 = v.u_params[6i].z;
    let v_63 = (max(0.0f, (v_60 - v_62)) * v_61);
    let v_64 = dot(v_54, v_54);
    let v_65 = (dot(v_37, v_54) / sqrt(v_64));
    let v_66 = max(0.0f, ((v_64 * v_58) + 1.0f));
    let v_67 = (max(0.0f, (v_65 - v_62)) * v_66);
    let v_68 = dot(v_56, v_56);
    let v_69 = (dot(v_37, v_56) / sqrt(v_68));
    let v_70 = max(0.0f, ((v_68 * v_58) + 1.0f));
    let v_71 = (max(0.0f, (v_69 - v_62)) * v_70);
    let v_72 = dot(v_57, v_57);
    let v_73 = (dot(v_37, v_57) / sqrt(v_72));
    let v_74 = max(0.0f, ((v_72 * v_58) + 1.0f));
    let v_75 = vec4<f32>(v_63, v_67, v_71, (max(0.0f, (v_73 - v_62)) * v_74));
    let v_76 = (v.u_params[14i].z * dot(v_75, v_49));
    let v_77 = ((textureLoad(s_normalmapSource, (v_25 + vec2<i32>(-2i, 0i)), 0i).xyz * v_28) + v_30);
    let v_78 = vec3<f32>(dot(v_77, v_32), dot(v_77, v_34), dot(v_77, v_36));
    let v_79 = ((textureLoad(s_normalmapSource, (v_25 + vec2<i32>(2i, 0i)), 0i).xyz * v_28) + v_30);
    let v_80 = vec3<f32>(dot(v_79, v_32), dot(v_79, v_34), dot(v_79, v_36));
    let v_81 = ((textureLoad(s_normalmapSource, (v_25 + vec2<i32>(0i, -2i)), 0i).xyz * v_28) + v_30);
    let v_82 = vec3<f32>(dot(v_81, v_32), dot(v_81, v_34), dot(v_81, v_36));
    let v_83 = ((textureLoad(s_normalmapSource, (v_25 + vec2<i32>(0i, 2i)), 0i).xyz * v_28) + v_30);
    let v_84 = vec3<f32>(dot(v_83, v_32), dot(v_83, v_34), dot(v_83, v_36));
    let v_85 = (v_49 * vec4<f32>(clamp((dot(v_37, v_78) + 0.5f), 0.0f, 1.0f), clamp((dot(v_37, v_80) + 0.5f), 0.0f, 1.0f), clamp((dot(v_37, v_82) + 0.5f), 0.0f, 1.0f), clamp((dot(v_37, v_84) + 0.5f), 0.0f, 1.0f)));
    let v_86 = (log2(v_42) + -4.30000019073486328125f);
    let v_87 = textureSampleLevel(s_importanceMapTexture, s_importanceMapSampler, (v_18 + v_24.zw), 0.0f).x;
    let v_88 = bitcast<vec2<i32>>(v_7);
    let v_89 = vec3<i32>(v_88.x, v_88.y, i32(v.u_params[8i].y));
    let v_90 = textureLoad(s_baseSSAO, v_89.xy, v_89.z, 0i);
    let v_91 = (v_90.y * 20.0f);
    let v_92 = (f32(s_loadCounter_1.m[0i]) * v.u_params[7i].z);
    let v_93 = ((27.0f * (v_87 * clamp((v.u_params[7i].w / v_92), 0.0f, 1.0f))) + 0.5f);
    let v_94 = min(32u, (u32(v_93) + 5u));
    var v_95 : f32;
    var v_96 : f32;
    {
      var v_97 : f32;
      v_97 = v_91;
      var v_98 : f32;
      v_98 = ((v_76 * (0.15625f + (v_87 * 0.84375f))) + (v_90.x * v_91));
      var v_99 : f32;
      v_99 = v_93;
      var v_100 : u32;
      v_100 = 5u;
      loop {
        let v_101 = v_100;
        let v_102 = v_99;
        let v_103 = v_98;
        let v_104 = v_97;
        if ((v_101 < v_94)) {
          continue;
        } else {
          v_95 = v_103;
          v_96 = v_104;
          break;
        }

        continuing {
          let v_105 = (v_102 - 1.0f);
          let v_106 = clamp((v_105 * 0.3333333432674407959f), 0.0f, 1.0f);
          let v_107 = bitcast<i32>(v_101);
          v_1 = array<vec4<f32>, 32u>(vec4<f32>(0.78488063812255859375f, 0.5666167140007019043f, 1.5f, -0.12608300149440765381f), vec4<f32>(0.26022231578826904297f, -0.29575172066688537598f, 1.5f, -1.06403005123138427734f), vec4<f32>(0.10459356755018234253f, 0.08372527360916137695f, 1.11000001430511474609f, -2.73056292533874511719f), vec4<f32>(-0.68286800384521484375f, 0.04963044822216033936f, 1.09000003337860107422f, -0.4988270103931427002f), vec4<f32>(-0.13570161163806915283f, -0.64190155267715454102f, 1.25f, -0.53276497125625610352f), vec4<f32>(-0.26193794608116149902f, -0.08205118030309677124f, 0.67000001668930053711f, -1.78324496746063232422f), vec4<f32>(-0.61177456378936767578f, 0.66664218902587890625f, 0.70999997854232788086f, -0.04423400014638900757f), vec4<f32>(0.43675562739372253418f, 0.25119024515151977539f, 0.61000001430511474609f, -1.16728305816650390625f), vec4<f32>(0.07884444296360015869f, 0.86618667840957641602f, 0.63999998569488525391f, -0.45900198817253112793f), vec4<f32>(-0.12790934741497039795f, -0.29869005084037780762f, 0.60000002384185791016f, -1.72942399978637695312f), vec4<f32>(-0.04031125083565711975f, 0.02413621917366981506f, 0.60000002384185791016f, -4.792041778564453125f), vec4<f32>(0.162012442946434021f, -0.52851414680480957031f, 0.79000002145767211914f, -1.06705498695373535156f), vec4<f32>(-0.70991218090057373047f, 0.47301071882247924805f, 0.63999998569488525391f, -0.33523601293563842773f), vec4<f32>(0.03277707099914550781f, -0.22349689900875091553f, 0.60000002384185791016f, -1.98238396644592285156f), vec4<f32>(0.6892172694206237793f, 0.36800742149353027344f, 0.62999999523162841797f, -0.26671800017356872559f), vec4<f32>(0.29251813888549804688f, 0.37775412201881408691f, 0.61000001430511474609f, -1.42252004146575927734f), vec4<f32>(-0.12224089354276657104f, 0.96582591533660888672f, 0.60000002384185791016f, -0.42614200711250305176f), vec4<f32>(0.11071456968784332275f, -0.16131058335304260254f, 0.60000002384185791016f, -2.16594696044921875f), vec4<f32>(0.46562141180038452148f, -0.597476959228515625f, 0.60000002384185791016f, -0.18975999951362609863f), vec4<f32>(-0.51548796892166137695f, 0.11804193258285522461f, 0.60000002384185791016f, -1.24679994583129882812f), vec4<f32>(0.89141309261322021484f, -0.42090442776679992676f, 0.60000002384185791016f, 0.02819200046360492706f), vec4<f32>(-0.32402530312538146973f, -0.01591528952121734619f, 0.60000002384185791016f, -1.54301798343658447266f), vec4<f32>(0.6077124476432800293f, 0.41635221242904663086f, 0.60000002384185791016f, -0.60541099309921264648f), vec4<f32>(0.02379564940929412842f, -0.08239821344614028931f, 0.60000002384185791016f, -3.80904603004455566406f), vec4<f32>(0.4895115196704864502f, -0.23657044768333435059f, 0.60000002384185791016f, -1.18901097774505615234f), vec4<f32>(-0.17611564695835113525f, -0.8169689178466796875f, 0.60000002384185791016f, -0.5137240290641784668f), vec4<f32>(-0.33930185437202453613f, -0.20732204616069793701f, 0.60000002384185791016f, -1.69804704189300537109f), vec4<f32>(-0.91974425315856933594f, 0.05403209105134010315f, 0.60000002384185791016f, 0.06224599853157997131f), vec4<f32>(-0.15064626932144165039f, -0.14949332177639007568f, 0.60000002384185791016f, -1.89606201648712158203f), vec4<f32>(0.53180974721908569336f, -0.35210400819778442383f, 0.60000002384185791016f, -0.7588379979133605957f), vec4<f32>(0.41487166285514831543f, 0.81442588567733764648f, 0.60000002384185791016f, -0.50564801692962646484f), vec4<f32>(-0.24106961488723754883f, -0.3272151648998260498f, 0.60000002384185791016f, -1.66524398326873779297f));
          let v_108 = v_1[v_107];
          let v_109 = (v_106 * v_108.z);
          let v_110 = round((v_108.xy * mat2x2<f32>(vec2<f32>((v_45.x * v_42), (v_45.y * v_42)), vec2<f32>((v_45.z * v_42), (v_45.w * v_42)))));
          let v_111 = (v_108.w + v_86);
          let v_112 = ((v_110 * v_17) + v_18);
          let v_113 = textureSampleLevel(s_viewspaceDepthSourceTexture, s_viewspaceDepthSourceSampler, v_112, v_111).x;
          let v_114 = (((v_20 * v_112) + v_21) * v_113);
          let v_115 = (vec3<f32>(v_114.x, v_114.y, v_113) - v_46);
          let v_116 = dot(v_115, v_115);
          let v_117 = (dot(v_37, v_115) / sqrt(v_116));
          let v_118 = max(0.0f, ((v_116 * v_44) + 1.0f));
          let v_119 = (max(0.0f, (v_117 - v_62)) * v_118);
          let v_120 = max(0.0f, -(v_115.z));
          let v_121 = v.u_params[7i].y;
          let v_122 = (((0.60000002384185791016f * clamp(((v_120 * v_121) + 2.0f), 0.0f, 1.0f)) + 0.40000000596046447754f) * v_109);
          let v_123 = ((-(v_110) * v_17) + v_18);
          let v_124 = textureSampleLevel(s_viewspaceDepthSourceTexture, s_viewspaceDepthSourceSampler, v_123, v_111).x;
          let v_125 = (((v_20 * v_123) + v_21) * v_124);
          let v_126 = (vec3<f32>(v_125.x, v_125.y, v_124) - v_46);
          let v_127 = dot(v_126, v_126);
          let v_128 = (dot(v_37, v_126) / sqrt(v_127));
          let v_129 = max(0.0f, ((v_127 * v_44) + 1.0f));
          let v_130 = (max(0.0f, (v_128 - v_62)) * v_129);
          let v_131 = (((0.60000002384185791016f * clamp(((max(0.0f, -(v_126.z)) * v_121) + 2.0f), 0.0f, 1.0f)) + 0.40000000596046447754f) * v_109);
          let v_132 = (v_101 + bitcast<u32>(1i));
          v_97 = ((v_104 + v_122) + v_131);
          v_98 = ((v_103 + (v_119 * v_122)) + (v_130 * v_131));
          v_99 = v_105;
          v_100 = v_132;
        }
      }
    }
    let v_133 = v_96;
    let v_134 = (v_95 / v_133);
    let v_135 = (clamp(((v_52 * v.u_params[6i].x) + v.u_params[6i].y), 0.0f, 1.0f) * clamp((1.0f - (clamp((((1.0f - v_85.x) - v_85.y) * 0.34999999403953552246f), 0.0f, 1.0f) + clamp((((1.0f - v_85.z) - v_85.w) * 0.34999999403953552246f), 0.0f, 1.0f))), 0.0f, 1.0f));
    let v_136 = vec2<f32>(pow(clamp((1.0f - (min((v.u_params[5i].y * v_134), v.u_params[5i].w) * v_135)), 0.0f, 1.0f), v.u_params[5i].z), dot(round((clamp(v_85, vec4<f32>(), vec4<f32>(1.0f)) * 3.04999995231628417969f)), vec4<f32>(0.2509804069995880127f, 0.06274510174989700317f, 0.01568627543747425079f, 0.0039215688593685627f)));
    let v_137 = bitcast<vec2<i32>>(v_4);
    let v_138 = vec3<i32>(v_137.x, v_137.y, i32(v.u_params[14i].w));
    textureStore(s_target, v_138.xy, v_138.z, vec4<f32>(v_136.xy, vec2<f32>()));
  }
}
