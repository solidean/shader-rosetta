#pragma clang diagnostic ignored "-Wunused-variable"

#include <metal_stdlib>
#include <simd/simd.h>
#include <metal_atomic>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

struct s_loadCounter
{
    uint _data[1];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], device s_loadCounter& s_loadCounter_1 [[buffer(3)]], texture2d<float, access::write> s_target [[texture(0)]], texture2d<float> s_importanceMap [[texture(1)]], sampler s_importanceMapSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _367 = uint2(int3(gl_GlobalInvocationID).xy);
    float2 _372 = float2(_367);
    if (all(_372 < float2(uint2(s_target.get_width(), s_target.get_height()))))
    {
        float2 _384 = (_372 + float2(0.5)) * _mtl_u.u_params[8].zw;
        float2 _392 = _mtl_u.u_params[8].zw * 0.5;
        float _395 = _392.x;
        float _398 = _392.y;
        float _446 = dot(float4(s_importanceMap.sample(s_importanceMapSampler, (_384 + float2(-_395, _398 * (-3.0))), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_384 + float2(_395 * 3.0, -_398)), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_384 + float2(_395, _398 * 3.0)), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_384 + float2(_395 * (-3.0), _398)), level(0.0)).x), float4(0.25));
        if (((_367.x % 3u) + (_367.y % 3u)) == 0u)
        {
            uint _482 = atomic_fetch_add_explicit((device atomic_uint*)&s_loadCounter_1._data[0], uint((fast::clamp(_446, 0.0, 1.0) * 255.0) + 0.5), memory_order_relaxed);
        }
        s_target.write(float4(_446), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

