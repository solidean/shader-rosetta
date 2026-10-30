#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
    float4 u_rect;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d_array<float, access::write> s_target [[texture(0)]], texture2d_array<float> s_blurInput [[texture(1)]], sampler s_blurInputSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _309 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _311 = float2(_309);
    if (all(_311 < _mtl_u.u_rect.zw))
    {
        float2 _324 = (_311 + float2(0.5)) * _mtl_u.u_params[0].zw;
        float2 _328 = _mtl_u.u_params[0].zw * 0.5;
        float3 _332 = float3(_324, 0.0);
        float4 _435 = s_blurInput.sample(s_blurInputSampler, _332.xy, uint(rint(_332.z)), level(0.0));
        float _338 = _328.x;
        float _342 = _328.y;
        float3 _348 = float3(_324 + float2(_338 * (-3.0), -_342), 0.0);
        float3 _364 = float3(_324 + float2(_338, _342 * (-3.0)), 0.0);
        float3 _380 = float3(_324 + float2(-_338, _342 * 3.0), 0.0);
        float3 _395 = float3(_324 + float2(_338 * 3.0, _342), 0.0);
        int3 _407 = int3(int2(_309), int(_mtl_u.u_params[14].w));
        s_target.write(float4(dot(float4(s_blurInput.sample(s_blurInputSampler, _348.xy, uint(rint(_348.z)), level(0.0)).x, s_blurInput.sample(s_blurInputSampler, _364.xy, uint(rint(_364.z)), level(0.0)).x, s_blurInput.sample(s_blurInputSampler, _380.xy, uint(rint(_380.z)), level(0.0)).x, s_blurInput.sample(s_blurInputSampler, _395.xy, uint(rint(_395.z)), level(0.0)).x), float4(0.20000000298023223876953125)) + (_435.x * 0.20000000298023223876953125), _435.y, 0.0, 0.0).xy.xyyy, uint2(_407.xy), uint(_407.z));
    }
}

