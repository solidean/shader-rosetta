#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of signed integer mod accurate to SPIR-V specification
template<typename Tx, typename Ty>
inline Tx spvSMod(Tx x, Ty y)
{
    Tx remainder = x - y * (x / y);
    return select(Tx(remainder + y), remainder, remainder == 0 || (x >= 0) == (y >= 0));
}

struct _Global
{
    float4 u_params[19];
    float4 u_rect;
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_target [[texture(0)]], texture2d_array<float> s_finalSSAO [[texture(1)]], sampler s_finalSSAOSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _493 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _495 = float2(_493);
    if (all(_495 < _mtl_u.u_rect.zw))
    {
        int _508 = spvSMod(int(_493.x), 2);
        int _512 = spvSMod(int(_493.y), 2);
        int _515 = _512 * 2;
        int _518 = 1 - _508;
        int _525 = (1 - _512) * 2;
        int3 _693 = int4(int2(_493 / uint2(2u)), _508 + _515, 0).xyz;
        float4 _701 = s_finalSSAO.read(uint2(_693.xy), uint(_693.z), 0);
        uint _708 = uint(_701.y * 255.5);
        float4 _740 = fast::clamp(float4(float((_708 >> uint(6)) & 3u) * 0.3333333432674407958984375, float((_708 >> uint(4)) & 3u) * 0.3333333432674407958984375, float((_708 >> uint(2)) & 3u) * 0.3333333432674407958984375, float(_708 & 3u) * 0.3333333432674407958984375) + float4(_mtl_u.u_params[8].x), float4(0.0), float4(1.0));
        float _548 = float(_508);
        float _550 = float(_512);
        float _552 = _740.y;
        float _554 = _740.x;
        float _555 = _552 - _554;
        float _557 = _740.w;
        float _559 = _740.z;
        float3 _581 = float3(((_495 + float2((_548 + _555) - 0.5, 0.5 - _550)) * 0.5) * _mtl_u.u_params[0].zw, float(_518 + _515));
        float _592 = (_550 - 0.5) + (_557 - _559);
        float3 _605 = float3(((_495 + float2(0.5 - _548, _592)) * 0.5) * _mtl_u.u_params[0].zw, float(_508 + _525));
        float2 _625 = ((_495 + float2((_548 - 0.5) + _555, _592)) * 0.5) * _mtl_u.u_params[0].zw;
        float3 _631 = float3(_625, float(_518 + _525));
        float _641 = (_554 + _552) * 0.5;
        float _648 = (_559 + _557) * 0.5;
        float4 _828 = float4(1.0, _641, _648, (_641 + _648) * 0.5);
        s_target.write(float4(powr(dot(float4(_701.x, s_finalSSAO.sample(s_finalSSAOSampler, _581.xy, uint(rint(_581.z)), level(0.0)).x, s_finalSSAO.sample(s_finalSSAOSampler, _605.xy, uint(rint(_605.z)), level(0.0)).x, s_finalSSAO.sample(s_finalSSAOSampler, _631.xy, uint(rint(_631.z)), level(0.0)).x), _828) / dot(_828, float4(1.0)), 0.4545454680919647216796875)), uint2(int2(_493)));
    }
}

