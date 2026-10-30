#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_target [[texture(0)]], texture2d<float> s_importanceMap [[texture(1)]], sampler s_importanceMapSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    float2 _346 = float2(uint2(int3(gl_GlobalInvocationID).xy));
    if (all(_346 < float2(uint2(s_target.get_width(), s_target.get_height()))))
    {
        float2 _359 = (_346 + float2(0.5)) * _mtl_u.u_params[8].zw;
        float2 _367 = _mtl_u.u_params[8].zw * 0.5;
        float _370 = _367.x;
        float _374 = _367.y;
        s_target.write(float4(dot(float4(s_importanceMap.sample(s_importanceMapSampler, (_359 + float2(_370 * (-3.0), -_374)), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_359 + float2(_370, _374 * (-3.0))), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_359 + float2(_370 * 3.0, _374)), level(0.0)).x, s_importanceMap.sample(s_importanceMapSampler, (_359 + float2(-_370, _374 * 3.0)), level(0.0)).x), float4(0.25))), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

