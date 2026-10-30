#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
    float4x4 u_modelViewProj;
};

struct xlatMtlMain_out
{
    float2 _entryPointOutput_v_texcoord0 [[user(locn0)]];
    float4 _entryPointOutput_v_texcoord1 [[user(locn1)]];
    float4 _entryPointOutput_v_texcoord2 [[user(locn2)]];
    float4 _entryPointOutput_v_texcoord3 [[user(locn3)]];
    float4 _entryPointOutput_v_texcoord4 [[user(locn4)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float _193 = _mtl_u.u_viewTexel.x * 8.0;
    float _224 = _mtl_u.u_viewTexel.x * 16.0;
    float _240 = _mtl_u.u_viewTexel.x * 24.0;
    float _256 = _mtl_u.u_viewTexel.x * 32.0;
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_texcoord1 = float4(in.a_texcoord0.x - _193, in.a_texcoord0.y, in.a_texcoord0.x + _193, in.a_texcoord0.y);
    out._entryPointOutput_v_texcoord2 = float4(in.a_texcoord0.x - _224, in.a_texcoord0.y, in.a_texcoord0.x + _224, in.a_texcoord0.y);
    out._entryPointOutput_v_texcoord3 = float4(in.a_texcoord0.x - _240, in.a_texcoord0.y, in.a_texcoord0.x + _240, in.a_texcoord0.y);
    out._entryPointOutput_v_texcoord4 = float4(in.a_texcoord0.x - _256, in.a_texcoord0.y, in.a_texcoord0.x + _256, in.a_texcoord0.y);
    return out;
}

