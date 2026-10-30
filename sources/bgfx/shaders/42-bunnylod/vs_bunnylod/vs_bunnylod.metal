#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
    float4x4 u_model[1];
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float3 _entryPointOutput_v_world [[user(locn1)]];
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
    float4 _111 = float4(in.a_position, 1.0);
    out.gl_Position = _mtl_u.u_modelViewProj * _111;
    out._entryPointOutput_v_color0 = float4(in.a_normal, 1.0);
    out._entryPointOutput_v_world = (_mtl_u.u_model[0] * _111).xyz;
    return out;
}

