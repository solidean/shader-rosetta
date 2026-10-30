#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[19];
};

kernel void xlatMtlMain(constant _Global& _mtl_u [[buffer(0)]], texture2d<float, access::write> s_target [[texture(0)]], texture2d_array<float> s_finalSSAO [[texture(1)]], sampler s_finalSSAOSampler [[sampler(1)]], uint3 gl_GlobalInvocationID [[thread_position_in_grid]])
{
    uint2 _311 = uint2(int3(gl_GlobalInvocationID).xy);
    if (all(float2(_311) < float2(uint2(s_target.get_width(), s_target.get_height()))))
    {
        float2 _338 = (float2(_311 * uint2(2u)) + float2(1.0)) * _mtl_u.u_params[0].zw;
        float _347 = _338.x;
        float3 _349 = float3(_347, _338.y, 0.0);
        float4 _365 = float4(_mtl_u.u_params[5].z);
        float4 _366 = powr(fast::clamp(float4(1.0) - (s_finalSSAO.gather(s_finalSSAOSampler, _349.xy, uint(rint(_349.z)), int2(0), component::x) * _mtl_u.u_params[5].y), float4(0.0), float4(1.0)), _365);
        float _381 = _366.x;
        float _383 = _366.y;
        float _386 = _366.z;
        float _388 = _366.w;
        float3 _479 = float3(_347, _338.y, 1.0);
        float4 _495 = powr(fast::clamp(float4(1.0) - (s_finalSSAO.gather(s_finalSSAOSampler, _479.xy, uint(rint(_479.z)), int2(0), component::x) * _mtl_u.u_params[5].y), float4(0.0), float4(1.0)), _365);
        float _497 = _495.x;
        float _499 = _495.y;
        float _502 = _495.z;
        float _504 = _495.w;
        float3 _532 = float3(_347, _338.y, 2.0);
        float4 _548 = powr(fast::clamp(float4(1.0) - (s_finalSSAO.gather(s_finalSSAOSampler, _532.xy, uint(rint(_532.z)), int2(0), component::x) * _mtl_u.u_params[5].y), float4(0.0), float4(1.0)), _365);
        float _550 = _548.x;
        float _552 = _548.y;
        float _555 = _548.z;
        float _557 = _548.w;
        float3 _585 = float3(_347, _338.y, 3.0);
        float4 _601 = powr(fast::clamp(float4(1.0) - (s_finalSSAO.gather(s_finalSSAOSampler, _585.xy, uint(rint(_585.z)), int2(0), component::x) * _mtl_u.u_params[5].y), float4(0.0), float4(1.0)), _365);
        float _603 = _601.x;
        float _605 = _601.y;
        float _608 = _601.z;
        float _610 = _601.w;
        s_target.write(float4(powr(fast::clamp((fast::max(fast::max(fast::max(fast::max(0.0, fast::max(fast::max(_381, _383), fast::max(_386, _388))), fast::max(fast::max(_497, _499), fast::max(_502, _504))), fast::max(fast::max(_550, _552), fast::max(_555, _557))), fast::max(fast::max(_603, _605), fast::max(_608, _610))) - fast::min(fast::min(fast::min(fast::min(1.0, fast::min(fast::min(_381, _383), fast::min(_386, _388))), fast::min(fast::min(_497, _499), fast::min(_502, _504))), fast::min(fast::min(_550, _552), fast::min(_555, _557))), fast::min(fast::min(_603, _605), fast::min(_608, _610)))) * 2.0, 0.0, 1.0), 0.800000011920928955078125)), uint2(int3(gl_GlobalInvocationID).xy));
    }
}

