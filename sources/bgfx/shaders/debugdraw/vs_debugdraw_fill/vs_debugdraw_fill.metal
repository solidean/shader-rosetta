#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_viewProj;
    float4x4 u_model[2];
};

struct xlatMtlMain_out
{
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    uint4 a_indices [[attribute(0)]];
    float3 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    out.gl_Position = _mtl_u.u_viewProj * (_mtl_u.u_model[int(in.a_indices.x)] * float4(in.a_position, 1.0));
    return out;
}

