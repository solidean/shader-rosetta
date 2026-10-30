#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_viewProj;
};

struct xlatMtlMain_out
{
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
    float4 i_data0 [[attribute(1)]];
    float4 i_data1 [[attribute(2)]];
    float4 i_data2 [[attribute(3)]];
    float4 i_data3 [[attribute(4)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_viewProj * (float4(in.a_position, 1.0) * transpose(float4x4(in.i_data0, in.i_data1, in.i_data2, in.i_data3)));
    return out;
}

