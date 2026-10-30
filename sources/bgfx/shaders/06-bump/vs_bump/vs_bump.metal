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
    float4 a_normal [[attribute(0)]];
    float3 a_position [[attribute(1)]];
    float4 a_tangent [[attribute(2)]];
    float2 a_texcoord0 [[attribute(3)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _265 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    float3 _266 = _265.xyz;
    float4 _285 = (in.a_tangent * 2.0) - float4(1.0);
    float3 _307 = fast::normalize((_mtl_u.u_model[0] * float4(((in.a_normal * 2.0) - float4(1.0)).xyz, 0.0)).xyz);
    float3 _310 = fast::normalize((_mtl_u.u_model[0] * float4(_285.xyz, 0.0)).xyz);
    float3 _319 = cross(_307, _310) * _285.w;
    out.gl_Position = _mtl_u.u_viewProj * float4(_265.xyz, 1.0);
    out._entryPointOutput_v_bitangent = _319;
    out._entryPointOutput_v_normal = _307;
    out._entryPointOutput_v_tangent = _310;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_view = transpose(float3x3(_310, _319, _307)) * ((float4(0.0, 0.0, 0.0, 1.0) * _mtl_u.u_view).xyz - _266);
    out._entryPointOutput_v_wpos = _266;
    return out;
}

