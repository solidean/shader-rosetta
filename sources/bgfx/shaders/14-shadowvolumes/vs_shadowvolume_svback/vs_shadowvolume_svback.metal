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
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position + (fast::normalize(in.a_position - _mtl_u.u_virtualLightPos_extrusionDist.xyz) * _mtl_u.u_virtualLightPos_extrusionDist.w), 1.0);
    return out;
}

