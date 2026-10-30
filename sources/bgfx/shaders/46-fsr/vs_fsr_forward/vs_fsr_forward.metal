#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_invView;
    float4x4 u_modelViewProj;
    float4x4 u_model[1];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_normal [[user(locn0)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn1)]];
    float4 _entryPointOutput_v_texcoord1 [[user(locn2)]];
    float4 _entryPointOutput_v_texcoord2 [[user(locn3)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_normal [[attribute(0)]];
    float4 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _183 = float4(in.a_position.xyz, 1.0);
    float4 _195 = _mtl_u.u_model[0] * _183;
    out.gl_Position = _mtl_u.u_modelViewProj * _183;
    out._entryPointOutput_v_normal = fast::normalize((_mtl_u.u_model[0] * float4((in.a_normal * 2.0) - float3(1.0), 0.0)).xyz);
    out._entryPointOutput_v_texcoord0 = in.a_position.xy * float2(0.5);
    out._entryPointOutput_v_texcoord1 = float4(_195.xyz, 1.0);
    out._entryPointOutput_v_texcoord2 = float4(fast::normalize((_mtl_u.u_invView * float4(0.0, 0.0, 0.0, 1.0)).xyz - _195.xyz), 1.0);
    return out;
}

