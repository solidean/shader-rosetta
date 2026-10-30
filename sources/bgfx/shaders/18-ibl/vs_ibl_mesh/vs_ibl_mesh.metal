#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4x4 u_model[1];
    float4 u_params[12];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_normal [[user(locn0)]];
    float3 _entryPointOutput_v_view [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_normal [[attribute(0)]];
    float3 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _130 = float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_modelViewProj * _130;
    out._entryPointOutput_v_normal = (_mtl_u.u_model[0] * float4((in.a_normal * 2.0) - float3(1.0), 0.0)).xyz;
    out._entryPointOutput_v_view = _mtl_u.u_params[7].xyz - (_mtl_u.u_model[0] * _130).xyz;
    return out;
}

