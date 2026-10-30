#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_depthSource [[texture(0)]], texture2d<float, access::write> s_target0 [[texture(1)]], texture2d<float, access::write> s_target1 [[texture(2)]], texture2d<float, access::write> s_target2 [[texture(3)]], texture2d<float, access::write> s_target3 [[texture(4)]], texture2d<float, access::write> s_normalsOutputUAV [[texture(5)]], sampler s_depthSourceSampler [[sampler(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    float2 _1071 = float2(uint2(int3(gl_GlobalInvocationID).xy));
    if (all(_1071 < float2(uint2(s_target0.get_width(), s_target0.get_height()))))
    {
        int2 _1080 = int3(gl_GlobalInvocationID).xy * int2(2);
        float2 _1087 = (_1071 + float2(0.25)) * _mtl_u.u_params[4].xy;
        int2 _1461 = int3(_1080, 0).xy;
        float _1482 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1461), 0).x);
        float _1513 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1461) + uint2(int2(1, 0)), 0).x);
        float _1544 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1461) + uint2(int2(0, 1)), 0).x);
        float _1575 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1461) + uint2(int2(1)), 0).x);
        s_target0.write(float4(_1482), uint2(int3(gl_GlobalInvocationID).xy));
        s_target1.write(float4(_1513), uint2(int3(gl_GlobalInvocationID).xy));
        s_target2.write(float4(_1544), uint2(int3(gl_GlobalInvocationID).xy));
        s_target3.write(float4(_1575), uint2(int3(gl_GlobalInvocationID).xy));
        float _1627 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(-1, 0)).x);
        float _1651 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(-1, 1)).x);
        float _1675 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(2, 0)).x);
        float _1699 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(2, 1)).x);
        float _1723 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(0, -1)).x);
        float _1747 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(1, -1)).x);
        float _1771 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(0, 2)).x);
        float _1795 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _1087, level(0.0), int2(1, 2)).x);
        float4 _1802 = float4(_1627, _1513, _1723, _1544) - float4(_1482);
        float4 _1820 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1802), abs(_1802 + _1802.yxwz)) / float4(_1482 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float4 _1827 = float4(_1482, _1675, _1747, _1575) - float4(_1513);
        float4 _1845 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1827), abs(_1827 + _1827.yxwz)) / float4(_1513 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float4 _1852 = float4(_1651, _1575, _1482, _1771) - float4(_1544);
        float4 _1870 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1852), abs(_1852 + _1852.yxwz)) / float4(_1544 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float4 _1877 = float4(_1544, _1699, _1513, _1795) - float4(_1575);
        float4 _1895 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1877), abs(_1877 + _1877.yxwz)) / float4(_1575 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float3 _2703 = float3(((_mtl_u.u_params[2].xy * _1087) + _mtl_u.u_params[2].zw) * _1482, _1482);
        float3 _2704 = float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(1.0, 0.0)))) + _mtl_u.u_params[2].zw) * _1513, _1513);
        float3 _2705 = float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(0.0, 1.0)))) + _mtl_u.u_params[2].zw) * _1544, _1544);
        float3 _2706 = float3(((_mtl_u.u_params[2].xy * (_1087 + _mtl_u.u_params[0].xy)) + _mtl_u.u_params[2].zw) * _1575, _1575);
        float _2152 = _1820.x;
        float _2153 = _1820.z;
        float _2156 = _1820.y;
        float _2159 = _1820.w;
        float3 _2168 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(-1.0, 0.0)))) + _mtl_u.u_params[2].zw) * _1627, _1627) - _2703);
        float3 _2172 = fast::normalize(_2704 - _2703);
        float3 _2176 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(0.0, -1.0)))) + _mtl_u.u_params[2].zw) * _1723, _1723) - _2703);
        float3 _2180 = fast::normalize(_2705 - _2703);
        float _2220 = _1845.x;
        float _2221 = _1845.z;
        float _2224 = _1845.y;
        float _2227 = _1845.w;
        float3 _2236 = fast::normalize(_2703 - _2704);
        float3 _2240 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(2.0, 0.0)))) + _mtl_u.u_params[2].zw) * _1675, _1675) - _2704);
        float3 _2244 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(1.0, -1.0)))) + _mtl_u.u_params[2].zw) * _1747, _1747) - _2704);
        float3 _2248 = fast::normalize(_2706 - _2704);
        float _2288 = _1870.x;
        float _2289 = _1870.z;
        float _2292 = _1870.y;
        float _2295 = _1870.w;
        float3 _2304 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(-1.0, 1.0)))) + _mtl_u.u_params[2].zw) * _1651, _1651) - _2705);
        float3 _2308 = fast::normalize(_2706 - _2705);
        float3 _2312 = fast::normalize(_2703 - _2705);
        float3 _2316 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(0.0, 2.0)))) + _mtl_u.u_params[2].zw) * _1771, _1771) - _2705);
        float _2356 = _1895.x;
        float _2357 = _1895.z;
        float _2360 = _1895.y;
        float _2363 = _1895.w;
        float3 _2372 = fast::normalize(_2705 - _2706);
        float3 _2376 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(2.0, 1.0)))) + _mtl_u.u_params[2].zw) * _1699, _1699) - _2706);
        float3 _2380 = fast::normalize(_2704 - _2706);
        float3 _2384 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_1087 + (_mtl_u.u_params[0].xy * float2(1.0, 2.0)))) + _mtl_u.u_params[2].zw) * _1795, _1795) - _2706);
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_2168, _2176) * (_2152 * _2153))) + (cross(_2176, _2172) * (_2153 * _2156))) + (cross(_2172, _2180) * (_2156 * _2159))) + (cross(_2180, _2168) * (_2159 * _2152))) * 0.5) + float3(0.5), 0.0), uint2(_1080));
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_2236, _2244) * (_2220 * _2221))) + (cross(_2244, _2240) * (_2221 * _2224))) + (cross(_2240, _2248) * (_2224 * _2227))) + (cross(_2248, _2236) * (_2227 * _2220))) * 0.5) + float3(0.5), 0.0), uint2((_1080 + int2(1, 0))));
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_2304, _2312) * (_2288 * _2289))) + (cross(_2312, _2308) * (_2289 * _2292))) + (cross(_2308, _2316) * (_2292 * _2295))) + (cross(_2316, _2304) * (_2295 * _2288))) * 0.5) + float3(0.5), 0.0), uint2((_1080 + int2(0, 1))));
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_2372, _2380) * (_2356 * _2357))) + (cross(_2380, _2376) * (_2357 * _2360))) + (cross(_2376, _2384) * (_2360 * _2363))) + (cross(_2384, _2372) * (_2363 * _2356))) * 0.5) + float3(0.5), 0.0), uint2((_1080 + int2(1))));
    }
}

