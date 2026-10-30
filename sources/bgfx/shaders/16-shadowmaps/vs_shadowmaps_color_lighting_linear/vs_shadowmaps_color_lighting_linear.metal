#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4x4 u_lightMtx;
    float4 u_params1;
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_normal [[user(locn0)]];
    float4 _entryPointOutput_v_shadowcoord [[user(locn1)]];
    float3 _entryPointOutput_v_view [[user(locn2)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float4 a_normal [[attribute(0)]];
    float3 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _159 = float4(in.a_position, 1.0);
    float4 _167 = (in.a_normal * 2.0) - float4(1.0);
    float4 _204 = _mtl_u.u_lightMtx * float4(in.a_position + (_167.xyz * _mtl_u.u_params1.y), 1.0);
    _204.z = _204.z + 0.5;
    out.gl_Position = _mtl_u.u_modelViewProj * _159;
    out._entryPointOutput_v_normal = fast::normalize((_mtl_u.u_modelView * float4(_167.xyz, 0.0)).xyz);
    out._entryPointOutput_v_shadowcoord = _204;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _159).xyz;
    return out;
}

