#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4 u_virtualLightPos_extrusionDist;
};

struct xlatMtlMain_out
{
    float _entryPointOutput_v_k [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float3 _158;
    if (in.a_texcoord0.x == 1.0)
    {
        _158 = in.a_position + (fast::normalize(in.a_position - _mtl_u.u_virtualLightPos_extrusionDist.xyz) * _mtl_u.u_virtualLightPos_extrusionDist.w);
    }
    else
    {
        _158 = in.a_position;
    }
    out.gl_Position = _mtl_u.u_modelViewProj * float4(_158, 1.0);
    out._entryPointOutput_v_k = in.a_texcoord0.y;
    return out;
}

