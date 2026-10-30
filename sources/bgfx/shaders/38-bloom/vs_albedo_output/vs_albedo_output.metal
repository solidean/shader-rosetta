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
    float3 _entryPointOutput_v_bitangent [[user(locn0)]];
    float3 _entryPointOutput_v_normal [[user(locn1)]];
    float3 _entryPointOutput_v_tangent [[user(locn2)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn3)]];
    float3 _entryPointOutput_v_view [[user(locn4)]];
    float3 _entryPointOutput_v_wpos [[user(locn5)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(1)]];
    float2 a_texcoord0 [[attribute(3)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_viewProj * float4((_mtl_u.u_model[0] * float4(in.a_position, 1.0)).xyz, 1.0);
    out._entryPointOutput_v_bitangent = float3(0.0, 1.0, 0.0);
    out._entryPointOutput_v_normal = float3(0.0, 0.0, 1.0);
    out._entryPointOutput_v_tangent = float3(1.0, 0.0, 0.0);
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_view = float3(0.0);
    out._entryPointOutput_v_wpos = float3(0.0);
    return out;
}

