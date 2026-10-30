#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4x4 u_model[1];
    float4 u_params1;
    float4x4 u_shadowMapMtx0;
    float4x4 u_shadowMapMtx1;
    float4x4 u_shadowMapMtx2;
    float4x4 u_shadowMapMtx3;
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_normal [[user(locn0)]];
    float4 _entryPointOutput_v_position [[user(locn1)]];
    float4 _entryPointOutput_v_texcoord1 [[user(locn2)]];
    float4 _entryPointOutput_v_texcoord2 [[user(locn3)]];
    float4 _entryPointOutput_v_texcoord3 [[user(locn4)]];
    float4 _entryPointOutput_v_texcoord4 [[user(locn5)]];
    float3 _entryPointOutput_v_view [[user(locn6)]];
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
    float4 _206 = float4(in.a_position, 1.0);
    float4 _214 = (in.a_normal * 2.0) - float4(1.0);
    float4 _247 = float4(in.a_position + (_214.xyz * _mtl_u.u_params1.y), 1.0);
    float4 _261 = float4((_mtl_u.u_model[0] * _247).xyz, 1.0);
    out.gl_Position = _mtl_u.u_modelViewProj * _206;
    out._entryPointOutput_v_normal = fast::normalize((_mtl_u.u_modelView * float4(_214.xyz, 0.0)).xyz);
    out._entryPointOutput_v_position = _mtl_u.u_modelView * _247;
    out._entryPointOutput_v_texcoord1 = _mtl_u.u_shadowMapMtx0 * _261;
    out._entryPointOutput_v_texcoord2 = _mtl_u.u_shadowMapMtx1 * _261;
    out._entryPointOutput_v_texcoord3 = _mtl_u.u_shadowMapMtx2 * _261;
    out._entryPointOutput_v_texcoord4 = _mtl_u.u_shadowMapMtx3 * _261;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _206).xyz;
    return out;
}

