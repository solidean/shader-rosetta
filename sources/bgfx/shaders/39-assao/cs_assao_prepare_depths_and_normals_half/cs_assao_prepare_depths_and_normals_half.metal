#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_depthSource [[texture(0)]], texture2d<float, access::write> s_target0 [[texture(1)]], texture2d<float, access::write> s_target1 [[texture(2)]], texture2d<float, access::write> s_normalsOutputUAV [[texture(5)]], sampler s_depthSourceSampler [[sampler(0)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    float2 _909 = float2(uint2(int3(gl_GlobalInvocationID).xy));
    if (all(_909 < float2(uint2(s_target0.get_width(), s_target0.get_height()))))
    {
        int2 _918 = int3(gl_GlobalInvocationID).xy * int2(2);
        float2 _925 = (_909 + float2(0.25)) * _mtl_u.u_params[4].xy;
        int2 _1207 = int3(_918, 0).xy;
        float _1228 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1207), 0).x);
        float _1259 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1207) + uint2(int2(1, 0)), 0).x);
        float _1290 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1207) + uint2(int2(0, 1)), 0).x);
        float _1321 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.read(uint2(_1207) + uint2(int2(1)), 0).x);
        s_target0.write(float4(_1228), uint2(int3(gl_GlobalInvocationID).xy));
        s_target1.write(float4(_1321), uint2(int3(gl_GlobalInvocationID).xy));
        float _1359 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _925, level(0.0), int2(-1, 0)).x);
        float _1431 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _925, level(0.0), int2(2, 1)).x);
        float _1455 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _925, level(0.0), int2(0, -1)).x);
        float _1527 = _mtl_u.u_params[1].x / (_mtl_u.u_params[1].y - s_depthSource.sample(s_depthSourceSampler, _925, level(0.0), int2(1, 2)).x);
        float4 _1534 = float4(_1359, _1259, _1455, _1290) - float4(_1228);
        float4 _1552 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1534), abs(_1534 + _1534.yxwz)) / float4(_1228 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float4 _1609 = float4(_1290, _1431, _1259, _1527) - float4(_1321);
        float4 _1627 = fast::clamp(float4(1.2999999523162841796875) - (fast::min(abs(_1609), abs(_1609 + _1609.yxwz)) / float4(_1321 * 0.039999999105930328369140625)), float4(0.0), float4(1.0));
        float3 _2137 = float3(((_mtl_u.u_params[2].xy * _925) + _mtl_u.u_params[2].zw) * _1228, _1228);
        float3 _2138 = float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(1.0, 0.0)))) + _mtl_u.u_params[2].zw) * _1259, _1259);
        float3 _2139 = float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(0.0, 1.0)))) + _mtl_u.u_params[2].zw) * _1290, _1290);
        float3 _2140 = float3(((_mtl_u.u_params[2].xy * (_925 + _mtl_u.u_params[0].xy)) + _mtl_u.u_params[2].zw) * _1321, _1321);
        float _1800 = _1552.x;
        float _1801 = _1552.z;
        float _1804 = _1552.y;
        float _1807 = _1552.w;
        float3 _1816 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(-1.0, 0.0)))) + _mtl_u.u_params[2].zw) * _1359, _1359) - _2137);
        float3 _1820 = fast::normalize(_2138 - _2137);
        float3 _1824 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(0.0, -1.0)))) + _mtl_u.u_params[2].zw) * _1455, _1455) - _2137);
        float3 _1828 = fast::normalize(_2139 - _2137);
        float _1868 = _1627.x;
        float _1869 = _1627.z;
        float _1872 = _1627.y;
        float _1875 = _1627.w;
        float3 _1884 = fast::normalize(_2139 - _2140);
        float3 _1888 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(2.0, 1.0)))) + _mtl_u.u_params[2].zw) * _1431, _1431) - _2140);
        float3 _1892 = fast::normalize(_2138 - _2140);
        float3 _1896 = fast::normalize(float3(((_mtl_u.u_params[2].xy * (_925 + (_mtl_u.u_params[0].xy * float2(1.0, 2.0)))) + _mtl_u.u_params[2].zw) * _1527, _1527) - _2140);
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_1816, _1824) * (_1800 * _1801))) + (cross(_1824, _1820) * (_1801 * _1804))) + (cross(_1820, _1828) * (_1804 * _1807))) + (cross(_1828, _1816) * (_1807 * _1800))) * 0.5) + float3(0.5), 0.0), uint2(_918));
        s_normalsOutputUAV.write(float4((fast::normalize((((float3(0.0, 0.0, -0.0005000000237487256526947021484375) + (cross(_1884, _1892) * (_1868 * _1869))) + (cross(_1892, _1888) * (_1869 * _1872))) + (cross(_1888, _1896) * (_1872 * _1875))) + (cross(_1896, _1884) * (_1875 * _1868))) * 0.5) + float3(0.5), 0.0), uint2((_918 + int2(1))));
    }
}

