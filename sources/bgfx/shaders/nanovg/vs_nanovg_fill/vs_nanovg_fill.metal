#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewSize;
    float4 u_halfTexel;
};

struct xlatMtlMain_out
{
    float2 _entryPointOutput_v_position [[user(locn0)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float2 a_position [[attribute(0)]];
    float2 a_texcoord0 [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = float4(((2.0 * in.a_position.x) / _mtl_u.u_viewSize.x) - 1.0, 1.0 - ((2.0 * in.a_position.y) / _mtl_u.u_viewSize.y), 0.0, 1.0);
    out._entryPointOutput_v_position = in.a_position;
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0 + _mtl_u.u_halfTexel.xy;
    return out;
}

