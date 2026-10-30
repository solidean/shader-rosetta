#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
    float4 u_rect;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_target [[texture(0)]], texture2d_array<float> s_finalSSAO [[texture(1)]], sampler s_finalSSAOSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _256 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _258 = float2(_256);
    if (all(_258 < _mtl_u.u_rect.zw))
    {
        float2 _271 = (_258 + float2(0.5)) * _mtl_u.u_params[0].xy;
        float _273 = _271.x;
        float3 _275 = float3(_273, _271.y, 0.0);
        float3 _282 = float3(_273, _271.y, 1.0);
        float3 _289 = float3(_273, _271.y, 2.0);
        float3 _296 = float3(_273, _271.y, 3.0);
        s_target.write(float4(powr((((s_finalSSAO.sample(s_finalSSAOSampler, _275.xy, uint(rint(_275.z)), level(0.0)).x + s_finalSSAO.sample(s_finalSSAOSampler, _282.xy, uint(rint(_282.z)), level(0.0)).x) + s_finalSSAO.sample(s_finalSSAOSampler, _289.xy, uint(rint(_289.z)), level(0.0)).x) + s_finalSSAO.sample(s_finalSSAOSampler, _296.xy, uint(rint(_296.z)), level(0.0)).x) * 0.25, 0.4545454680919647216796875)), uint2(int2(_256)));
    }
}

