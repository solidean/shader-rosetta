#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4x4 u_modelViewProj;
    float4 u_params[12];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_dir [[user(locn0)]];
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
    out.gl_Position = _mtl_u.u_modelViewProj * float4(in.a_position, 1.0);
    out._entryPointOutput_v_dir = (float4(((in.a_texcoord0 * 2.0) - float2(1.0)) * float2(0.4142135679721832275390625 * (_mtl_u.u_viewRect.z / _mtl_u.u_viewRect.w), 0.4142135679721832275390625), 1.0, 0.0) * transpose(float4x4(_mtl_u.u_params[0], _mtl_u.u_params[1], _mtl_u.u_params[2], _mtl_u.u_params[3]))).xyz;
    return out;
}

