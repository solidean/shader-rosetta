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
    float4 _219 = float4(in.a_position, 1.0);
    float4 _227 = (in.a_normal * 2.0) - float4(1.0);
    float4 _264 = _mtl_u.u_lightMtx * float4(in.a_position + (_227.xyz * _mtl_u.u_params1.y), 1.0);
    float4 _270 = _mtl_u.u_shadowMapMtx0 * _264;
    float4 _276 = _mtl_u.u_shadowMapMtx1 * _264;
    float4 _282 = _mtl_u.u_shadowMapMtx2 * _264;
    float4 _288 = _mtl_u.u_shadowMapMtx3 * _264;
    _270.z = _270.z + 0.5;
    _276.z = _276.z + 0.5;
    _282.z = _282.z + 0.5;
    _288.z = _288.z + 0.5;
    out.gl_Position = _mtl_u.u_modelViewProj * _219;
    out._entryPointOutput_v_normal = fast::normalize((_mtl_u.u_modelView * float4(_227.xyz, 0.0)).xyz);
    out._entryPointOutput_v_position = _264;
    out._entryPointOutput_v_texcoord1 = _270;
    out._entryPointOutput_v_texcoord2 = _276;
    out._entryPointOutput_v_texcoord3 = _282;
    out._entryPointOutput_v_texcoord4 = _288;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _219).xyz;
    return out;
}

