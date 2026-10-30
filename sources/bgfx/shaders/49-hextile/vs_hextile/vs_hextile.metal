#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_viewProj;
    float4x4 u_model[1];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_position [[user(locn0)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn1)]];
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
    float4 _124 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_viewProj * float4(_124.xyz, 1.0);
    out._entryPointOutput_v_position = _124.xyz;
    out._entryPointOutput_v_texcoord0 = (_mtl_u.u_model[0] * float4(in.a_texcoord0, 1.0, 1.0)).xy;
    return out;
}

