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
    float3 _entryPointOutput_v_normal [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float4 a_color0 [[attribute(0)]];
    float3 a_normal [[attribute(1)]];
    float3 a_position [[attribute(2)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    out._entryPointOutput_v_color0 = in.a_color0;
    out._entryPointOutput_v_normal = (_mtl_u.u_model[0] * float4(in.a_normal, 0.0)).xyz;
    return out;
}

