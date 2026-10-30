#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_view;
    float4x4 u_viewProj;
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
    float4 i_data0 [[attribute(4)]];
    float4 i_data1 [[attribute(5)]];
    float4 i_data2 [[attribute(6)]];
    float4 i_data3 [[attribute(7)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4x4 _440 = transpose(float4x4(in.i_data0, in.i_data1, in.i_data2, in.i_data3));
    float4 _341 = float4(in.a_position, 1.0) * _440;
    float3 _342 = _341.xyz;
    float4 _363 = float4(((in.a_normal * 2.0) - float4(1.0)).xyz, 0.0) * _440;
    float3 _364 = _363.xyz;
    float4 _368 = (in.a_tangent * 2.0) - float4(1.0);
    float4 _376 = float4(_368.xyz, 0.0) * _440;
    float3 _377 = _376.xyz;
    float3 _389 = cross(_364, _377) * _368.w;
    out.gl_Position = _mtl_u.u_viewProj * float4(_341.xyz, 1.0);
    out._entryPointOutput_v_bitangent = _389;
    out._entryPointOutput_v_normal = _364;
    out._entryPointOutput_v_tangent = _377;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_view = transpose(float3x3(float3(_376.xyz), _389, float3(_363.xyz))) * ((float4(0.0, 0.0, 0.0, 1.0) * _mtl_u.u_view).xyz - _342);
    out._entryPointOutput_v_wpos = _342;
    return out;
}

