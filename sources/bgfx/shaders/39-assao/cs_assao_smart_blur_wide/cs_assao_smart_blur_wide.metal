#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
    float4 u_rect;
};

constant float _1045 = {};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d_array<float, access::write> s_target [[texture(0)]], texture2d_array<float> s_blurInput [[texture(1)]], sampler s_blurInputSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _442 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _444 = float2(_442);
    if (all(_444 < _mtl_u.u_rect.zw))
    {
        int3 _465 = int3(int2(_442), int(_mtl_u.u_params[14].w));
        float3 _469 = float3((_444 + float2(0.5)) * _mtl_u.u_params[0].zw, 0.0);
        float4 _657 = s_blurInput.sample(s_blurInputSampler, _469.xy, uint(rint(_469.z)), level(0.0));
        float4 _668 = s_blurInput.sample(s_blurInputSampler, _469.xy, uint(rint(_469.z)), level(0.0), int2(-2, 0));
        float4 _679 = s_blurInput.sample(s_blurInputSampler, _469.xy, uint(rint(_469.z)), level(0.0), int2(0, -2));
        float4 _690 = s_blurInput.sample(s_blurInputSampler, _469.xy, uint(rint(_469.z)), level(0.0), int2(2, 0));
        float4 _701 = s_blurInput.sample(s_blurInputSampler, _469.xy, uint(rint(_469.z)), level(0.0), int2(0, 2));
        float _560 = _657.y;
        uint _708 = uint(_560 * 255.5);
        float4 _736 = float4(_mtl_u.u_params[8].x);
        float4 _740 = fast::clamp(float4(float((_708 >> uint(6)) & 3u) * 0.3333333432674407958984375, float((_708 >> uint(4)) & 3u) * 0.3333333432674407958984375, float((_708 >> uint(2)) & 3u) * 0.3333333432674407958984375, float(_708 & 3u) * 0.3333333432674407958984375) + _736, float4(0.0), float4(1.0));
        float _569 = _740.x * fast::clamp(float4(_1045, float((uint(_668.y * 255.5) >> uint(4)) & 3u) * 0.3333333432674407958984375, _1045, _1045) + _736, float4(0.0), float4(1.0)).y;
        float _577 = _740.z * fast::clamp(float4(_1045, _1045, _1045, float(uint(_679.y * 255.5) & 3u) * 0.3333333432674407958984375) + _736, float4(0.0), float4(1.0)).w;
        float _585 = _740.y * fast::clamp(float4(float((uint(_690.y * 255.5) >> uint(6)) & 3u) * 0.3333333432674407958984375, _1045, _1045, _1045) + _736, float4(0.0), float4(1.0)).x;
        float _593 = _740.w * fast::clamp(float4(_1045, _1045, float((uint(_701.y * 255.5) >> uint(2)) & 3u) * 0.3333333432674407958984375, _1045) + _736, float4(0.0), float4(1.0)).z;
        s_target.write(float2((((((_657.x * 0.800000011920928955078125) + (_569 * _668.x)) + (_585 * _690.x)) + (_577 * _679.x)) + (_593 * _701.x)) / ((((0.800000011920928955078125 + _569) + _585) + _577) + _593), _560).xy.xyyy, uint2(_465.xy), uint(_465.z));
    }
}

