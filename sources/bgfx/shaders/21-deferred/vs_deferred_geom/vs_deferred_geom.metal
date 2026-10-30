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
    float4 _268 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    float _271 = _268.x;
    float4 _296 = (in.a_tangent * 2.0) - float4(1.0);
    float3 _316 = fast::normalize((_mtl_u.u_view * float4((_mtl_u.u_model[0] * float4(((in.a_normal * 2.0) - float4(1.0)).xyz, 0.0)).xyz, 0.0)).xyz);
    float3 _326 = fast::normalize((_mtl_u.u_view * float4((_mtl_u.u_model[0] * float4(_296.xyz, 0.0)).xyz, 0.0)).xyz);
    float3 _332 = cross(_316, _326) * _296.w;
    out.gl_Position = _mtl_u.u_viewProj * float4(_271, _268.yz, 1.0);
    out._entryPointOutput_v_bitangent = _332;
    out._entryPointOutput_v_normal = _316;
    out._entryPointOutput_v_tangent = _326;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_view = float3x3(_326, _332, _316) * (_mtl_u.u_view * float4(_271, _268.yz, 0.0)).xyz;
    out._entryPointOutput_v_wpos = _268.xyz;
    return out;
}

