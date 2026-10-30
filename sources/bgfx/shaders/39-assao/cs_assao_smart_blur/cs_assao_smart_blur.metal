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
    uint2 _415 = uint2(int3(gl_GlobalInvocationID).xy) + uint2(_mtl_u.u_rect.xy);
    float2 _417 = float2(_415);
    if (all(_417 < _mtl_u.u_rect.zw))
    {
        float2 _430 = (_417 + float2(0.5)) * _mtl_u.u_params[0].zw;
        int2 _432 = int2(_415);
        int _436 = _432.x;
        int3 _438 = int3(_436, _432.y, int(_mtl_u.u_params[14].w));
        int3 _584 = int4(_436, _432.y, 0, 0).xyz;
        float4 _592 = s_blurInput.read(uint2(_584.xy), uint(_584.z), 0);
        float _497 = _592.y;
        uint _599 = uint(_497 * 255.5);
        float4 _631 = fast::clamp(float4(float((_599 >> uint(6)) & 3u) * 0.3333333432674407958984375, float((_599 >> uint(4)) & 3u) * 0.3333333432674407958984375, float((_599 >> uint(2)) & 3u) * 0.3333333432674407958984375, float(_599 & 3u) * 0.3333333432674407958984375) + float4(_mtl_u.u_params[8].x), float4(0.0), float4(1.0));
        float2 _504 = _mtl_u.u_params[0].zw * 0.5;
        float3 _508 = float3(_430 - _504, 0.0);
        float4 _640 = s_blurInput.gather(s_blurInputSampler, _508.xy, uint(rint(_508.z)), int2(0), component::x);
        float3 _519 = float3(_430 + _504, 0.0);
        float4 _649 = s_blurInput.gather(s_blurInputSampler, _519.xy, uint(rint(_519.z)), int2(0), component::x);
        float _537 = _631.x;
        float _545 = _631.y;
        float _553 = _631.z;
        float _561 = _631.w;
        s_target.write(float2((((((_640.y * 0.5) + (_537 * _640.x)) + (_545 * _649.z)) + (_553 * _640.z)) + (_561 * _649.x)) / ((((0.5 + _537) + _545) + _553) + _561), _497).xy.xyyy, uint2(_438.xy), uint(_438.z));
    }
}

