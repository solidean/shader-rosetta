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
    float _228 = _mtl_u.u_viewTexel.y * 2.0;
    float _246 = _mtl_u.u_viewTexel.y * 3.0;
    float _264 = _mtl_u.u_viewTexel.y * 4.0;
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_texcoord1 = float4(in.a_texcoord0.x, in.a_texcoord0.y - _mtl_u.u_viewTexel.y, in.a_texcoord0.x, in.a_texcoord0.y + _mtl_u.u_viewTexel.y);
    out._entryPointOutput_v_texcoord2 = float4(in.a_texcoord0.x, in.a_texcoord0.y - _228, in.a_texcoord0.x, in.a_texcoord0.y + _228);
    out._entryPointOutput_v_texcoord3 = float4(in.a_texcoord0.x, in.a_texcoord0.y - _246, in.a_texcoord0.x, in.a_texcoord0.y + _246);
    out._entryPointOutput_v_texcoord4 = float4(in.a_texcoord0.x, in.a_texcoord0.y - _264, in.a_texcoord0.x, in.a_texcoord0.y + _264);
    return out;
}

