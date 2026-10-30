#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_model[1];
    float4x4 u_lightViewProj;
    float4x4 u_lightMtx;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_shadowcoord [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _97 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_lightViewProj * _97;
    out._entryPointOutput_v_shadowcoord = _mtl_u.u_lightMtx * _97;
    return out;
}

