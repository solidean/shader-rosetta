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
    uint2 _219 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _221 = float2(_219);
    if (all(_221 < _mtl_u.u_rect.zw))
    {
        float2 _234 = (_221 + float2(0.5)) * _mtl_u.u_params[0].xy;
        float _236 = _234.x;
        float3 _238 = float3(_236, _234.y, 0.0);
        float3 _245 = float3(_236, _234.y, 3.0);
        s_target.write(float4(powr((s_finalSSAO.sample(s_finalSSAOSampler, _238.xy, uint(rint(_238.z)), level(0.0)).x + s_finalSSAO.sample(s_finalSSAOSampler, _245.xy, uint(rint(_245.z)), level(0.0)).x) * 0.5, 0.4545454680919647216796875)), uint2(int2(_219)));
    }
}

