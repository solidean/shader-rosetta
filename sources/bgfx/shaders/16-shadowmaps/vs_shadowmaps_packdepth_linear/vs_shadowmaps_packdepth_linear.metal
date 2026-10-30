#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelViewProj;
};

struct xlatMtlMain_out
{
    float _entryPointOutput_v_depth [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _94 = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    out.gl_Position = _94;
    out._entryPointOutput_v_depth = (_94.z * 0.5) + 0.5;
    return out;
}

