#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4 u_params1;
    float4x4 u_lightMtx;
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
    float4 _200 = float4(in.a_position, 1.0);
    float4 _208 = (in.a_normal * 2.0) - float4(1.0);
    float4 _245 = _mtl_u.u_lightMtx * float4(in.a_position + (_208.xyz * _mtl_u.u_params1.y), 1.0);
    out.gl_Position = _mtl_u.u_modelViewProj * _200;
    out._entryPointOutput_v_normal = fast::normalize((_mtl_u.u_modelView * float4(_208.xyz, 0.0)).xyz);
    out._entryPointOutput_v_position = _245;
    out._entryPointOutput_v_texcoord1 = _mtl_u.u_shadowMapMtx0 * _245;
    out._entryPointOutput_v_texcoord2 = _mtl_u.u_shadowMapMtx1 * _245;
    out._entryPointOutput_v_texcoord3 = _mtl_u.u_shadowMapMtx2 * _245;
    out._entryPointOutput_v_texcoord4 = _mtl_u.u_shadowMapMtx3 * _245;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _200).xyz;
    return out;
}

