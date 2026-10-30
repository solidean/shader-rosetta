#pragma clang diagnostic ignored "-Wunused-variable"

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_atomic>

using namespace metal;

struct _Global
{
    float4x4 u_viewProj;
    float4 u_inputRTSize;
    float4 u_cullingConfig;
};

struct instanceDataIn
{
    float4 _data[1];
};

struct drawcallInstanceCount
{
    uint _data[1];
};

struct instancePredicates
{
    uint _data[1];
};

constant float4 _1369 = {};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device instanceDataIn& instanceDataIn_1 [[buffer(2)]], device drawcallInstanceCount& drawcallInstanceCount_1 [[buffer(3)]], device instancePredicates& instancePredicates_1 [[buffer(4)]], texture2d<float> s_texOcclusionDepth [[texture(0)]], sampler s_texOcclusionDepthSampler [[sampler(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    bool _764;
    if (uint(int(gl_GlobalInvocationID.x)) < uint(_mtl_u.u_cullingConfig.x))
    {
        int _462 = 2 * int(gl_GlobalInvocationID.x);
        int _468 = _462 + 1;
        float3 _478 = instanceDataIn_1._data[_468].xyz - instanceDataIn_1._data[_462].xyz;
        float _484 = _478.x;
        float _490 = _478.y;
        float _496 = _478.z;
        float4 _542 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz, 1.0);
        float4 _1211 = _542;
        _1211.z = fast::max(_542.z, 0.0);
        float3 _552 = _1211.xyz / float3(_542.w);
        float4 _1214;
        _1214.x = _552.x;
        _1214.y = _552.y;
        float2 _561 = fast::clamp(_1214.xy, float2(-1.0), float2(1.0));
        float4 _1220;
        _1220.x = _561.x;
        _1220.y = _561.y;
        float2 _569 = (_1220.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1224;
        _1224.x = _569.x;
        _1224.y = _569.y;
        float4 _784 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(_484, 0.0, 0.0), 1.0);
        float4 _1230 = _784;
        _1230.z = fast::max(_784.z, 0.0);
        float3 _794 = _1230.xyz / float3(_784.w);
        float4 _1233;
        _1233.x = _794.x;
        _1233.y = _794.y;
        float2 _803 = fast::clamp(_1233.xy, float2(-1.0), float2(1.0));
        float4 _1239;
        _1239.x = _803.x;
        _1239.y = _803.y;
        float2 _811 = (_1239.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1243;
        _1243.x = _811.x;
        _1243.y = _811.y;
        float4 _843 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(0.0, _490, 0.0), 1.0);
        float4 _1249 = _843;
        _1249.z = fast::max(_843.z, 0.0);
        float3 _853 = _1249.xyz / float3(_843.w);
        float4 _1252;
        _1252.x = _853.x;
        _1252.y = _853.y;
        float2 _862 = fast::clamp(_1252.xy, float2(-1.0), float2(1.0));
        float4 _1258;
        _1258.x = _862.x;
        _1258.y = _862.y;
        float2 _870 = (_1258.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1262;
        _1262.x = _870.x;
        _1262.y = _870.y;
        float4 _902 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(0.0, 0.0, _496), 1.0);
        float4 _1268 = _902;
        _1268.z = fast::max(_902.z, 0.0);
        float3 _912 = _1268.xyz / float3(_902.w);
        float4 _1271;
        _1271.x = _912.x;
        _1271.y = _912.y;
        float2 _921 = fast::clamp(_1271.xy, float2(-1.0), float2(1.0));
        float4 _1277;
        _1277.x = _921.x;
        _1277.y = _921.y;
        float2 _929 = (_1277.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1281;
        _1281.x = _929.x;
        _1281.y = _929.y;
        float4 _961 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(_484, _490, 0.0), 1.0);
        float4 _1287 = _961;
        _1287.z = fast::max(_961.z, 0.0);
        float3 _971 = _1287.xyz / float3(_961.w);
        float4 _1290;
        _1290.x = _971.x;
        _1290.y = _971.y;
        float2 _980 = fast::clamp(_1290.xy, float2(-1.0), float2(1.0));
        float4 _1296;
        _1296.x = _980.x;
        _1296.y = _980.y;
        float2 _988 = (_1296.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1300;
        _1300.x = _988.x;
        _1300.y = _988.y;
        float4 _1020 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(0.0, _490, _496), 1.0);
        float4 _1306 = _1020;
        _1306.z = fast::max(_1020.z, 0.0);
        float3 _1030 = _1306.xyz / float3(_1020.w);
        float4 _1309;
        _1309.x = _1030.x;
        _1309.y = _1030.y;
        float2 _1039 = fast::clamp(_1309.xy, float2(-1.0), float2(1.0));
        float4 _1315;
        _1315.x = _1039.x;
        _1315.y = _1039.y;
        float2 _1047 = (_1315.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1319;
        _1319.x = _1047.x;
        _1319.y = _1047.y;
        float4 _1079 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_462].xyz + float3(_484, 0.0, _496), 1.0);
        float4 _1325 = _1079;
        _1325.z = fast::max(_1079.z, 0.0);
        float3 _1089 = _1325.xyz / float3(_1079.w);
        float4 _1328;
        _1328.x = _1089.x;
        _1328.y = _1089.y;
        float2 _1098 = fast::clamp(_1328.xy, float2(-1.0), float2(1.0));
        float4 _1334;
        _1334.x = _1098.x;
        _1334.y = _1098.y;
        float2 _1106 = (_1334.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1338;
        _1338.x = _1106.x;
        _1338.y = _1106.y;
        float4 _1138 = _mtl_u.u_viewProj * float4(instanceDataIn_1._data[_468].xyz, 1.0);
        float4 _1344 = _1138;
        _1344.z = fast::max(_1138.z, 0.0);
        float3 _1148 = _1344.xyz / float3(_1138.w);
        float4 _1347;
        _1347.x = _1148.x;
        _1347.y = _1148.y;
        float2 _1157 = fast::clamp(_1347.xy, float2(-1.0), float2(1.0));
        float4 _1353;
        _1353.x = _1157.x;
        _1353.y = _1157.y;
        float2 _1165 = (_1353.xy * float2(0.5, -0.5)) + float2(0.5);
        float4 _1357;
        _1357.x = _1165.x;
        _1357.y = _1165.y;
        float2 _1172 = fast::min(_1357.xy, fast::min(_1338.xy, fast::min(_1319.xy, fast::min(_1300.xy, fast::min(_1281.xy, fast::min(_1262.xy, fast::min(_1243.xy, fast::min(_1224.xy, float2(1.0)))))))));
        float2 _1174 = fast::max(_1357.xy, fast::max(_1338.xy, fast::max(_1319.xy, fast::max(_1300.xy, fast::max(_1281.xy, fast::max(_1262.xy, fast::max(_1243.xy, fast::max(_1224.xy, float2(0.0)))))))));
        float4 _597 = float4(_1172, _1174);
        int2 _605 = int2((_1174 - _1172) * _mtl_u.u_inputRTSize.xy);
        float _617 = fast::clamp(ceil(log2(float(max(_605.x, _605.y)))), 0.0, _mtl_u.u_cullingConfig.z);
        float _620 = fast::max(_617 - 1.0, 0.0);
        float2 _701 = float2(exp2(-_620));
        float2 _626 = _597.xy;
        float2 _631 = _597.zw;
        float2 _637 = ceil(_631 * _701) - floor(_626 * _701);
        float _1370 = ((_637.x <= 2.0) && (_637.y <= 2.0)) ? _620 : _617;
        bool _686 = fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(fast::clamp(fast::min(1.0, _552.z), 0.0, 1.0), _794.z), 0.0, 1.0), _853.z), 0.0, 1.0), _912.z), 0.0, 1.0), _971.z), 0.0, 1.0), _1030.z), 0.0, 1.0), _1089.z), 0.0, 1.0), _1148.z), 0.0, 1.0) <= fast::max(fast::max(s_texOcclusionDepth.sample(s_texOcclusionDepthSampler, _626, level(_1370)).x, s_texOcclusionDepth.sample(s_texOcclusionDepthSampler, _597.zy, level(_1370)).x), fast::max(s_texOcclusionDepth.sample(s_texOcclusionDepthSampler, _597.xw, level(_1370)).x, s_texOcclusionDepth.sample(s_texOcclusionDepthSampler, _631, level(_1370)).x));
        if (_686)
        {
            uint _690 = atomic_fetch_add_explicit((device atomic_uint*)&drawcallInstanceCount_1._data[int(instanceDataIn_1._data[_462].w)], 1u, memory_order_relaxed);
        }
        _764 = _686;
    }
    else
    {
        _764 = false;
    }
    instancePredicates_1._data[int(gl_GlobalInvocationID.x)] = uint(_764);
}

