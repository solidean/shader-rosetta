#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_view;
    float4x4 u_viewProj;
    float4x4 u_model[1];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_view [[user(locn0)]];
    float3 _entryPointOutput_v_world [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _105 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_viewProj * _105;
    out._entryPointOutput_v_view = (_mtl_u.u_view * _105).xyz;
    out._entryPointOutput_v_world = _105.xyz;
    return out;
}

