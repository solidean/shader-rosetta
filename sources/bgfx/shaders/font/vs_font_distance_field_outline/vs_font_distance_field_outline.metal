#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float4 _entryPointOutput_v_color1 [[user(locn1)]];
    float4 _entryPointOutput_v_texcoord0 [[user(locn2)]];
    float4 _entryPointOutput_v_texcoord1 [[user(locn3)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float4 a_color0 [[attribute(0)]];
    float4 a_color1 [[attribute(1)]];
    float2 a_position [[attribute(2)]];
    float4 a_texcoord0 [[attribute(3)]];
    float4 a_texcoord1 [[attribute(4)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position, 0.0, 1.0);
    out._entryPointOutput_v_color0 = in.a_color0;
    out._entryPointOutput_v_color1 = in.a_color1;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_texcoord1 = in.a_texcoord1;
    return out;
}

