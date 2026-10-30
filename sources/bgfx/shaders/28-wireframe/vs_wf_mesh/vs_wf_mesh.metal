#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4x4 u_model[1];
    float4 u_params[3];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_bc [[user(locn0)]];
    float3 _entryPointOutput_v_normal [[user(locn1)]];
    float3 _entryPointOutput_v_view [[user(locn2)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_color1 [[attribute(0)]];
    float3 a_normal [[attribute(1)]];
    float3 a_position [[attribute(2)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _143 = float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_modelViewProj * _143;
    out._entryPointOutput_v_bc = in.a_color1;
    out._entryPointOutput_v_normal = (_mtl_u.u_model[0] * float4((in.a_normal * 2.0) - float3(1.0), 0.0)).xyz;
    out._entryPointOutput_v_view = _mtl_u.u_params[0].xyz - (_mtl_u.u_model[0] * _143).xyz;
    return out;
}

