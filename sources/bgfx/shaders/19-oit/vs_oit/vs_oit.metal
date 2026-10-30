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
    float4 _entryPointOutput_v_pos [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _120 = float4((_mtl_u.u_model[0] * float4(in.a_position, 1.0)).xyz, 1.0);
    float4 _123 = _mtl_u.u_viewProj * _120;
    float4 _147 = _123;
    _147.x = (_mtl_u.u_view * _120).z;
    out.gl_Position = _123;
    out._entryPointOutput_v_pos = _147;
    return out;
}

