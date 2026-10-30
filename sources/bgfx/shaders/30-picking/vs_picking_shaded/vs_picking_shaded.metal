#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4 u_tint;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float3 _entryPointOutput_v_normal [[user(locn1)]];
    float3 _entryPointOutput_v_pos [[user(locn2)]];
    float3 _entryPointOutput_v_view [[user(locn3)]];
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
    float4 _155 = float4(in.a_position, 1.0);
    float4 _158 = _mtl_u.u_modelViewProj * _155;
    out.gl_Position = _158;
    out._entryPointOutput_v_color0 = _mtl_u.u_tint * float4(0.800000011920928955078125, 0.800000011920928955078125, 0.800000011920928955078125, 1.0);
    out._entryPointOutput_v_normal = (_mtl_u.u_modelView * float4((in.a_normal * 2.0) - float3(1.0), 0.0)).xyz;
    out._entryPointOutput_v_pos = _158.xyz;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _155).xyz;
    return out;
}

