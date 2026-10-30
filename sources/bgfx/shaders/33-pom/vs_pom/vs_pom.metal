#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_norm_mtx;
    float4 u_light_pos;
    float4x4 u_viewProj;
    float4x4 u_model[1];
};

struct xlatMtlMain_out
{
    float2 _entryPointOutput_v_texcoord0 [[user(locn0)]];
    float3 _entryPointOutput_v_ts_frag_pos [[user(locn1)]];
    float3 _entryPointOutput_v_ts_light_pos [[user(locn2)]];
    float3 _entryPointOutput_v_ts_view_pos [[user(locn3)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_bitangent [[attribute(0)]];
    float3 a_position [[attribute(1)]];
    float3 a_tangent [[attribute(2)]];
    float2 a_texcoord0 [[attribute(3)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _258 = _mtl_u.u_model[0] * float4(in.a_position, 1.0);
    float3 _272 = (in.a_tangent * 2.0) - float3(1.0);
    float3 _276 = (in.a_bitangent * 2.0) - float3(1.0);
    float3x3 _349 = transpose(float3x3(fast::normalize((_mtl_u.u_norm_mtx * float4(_272, 0.0)).xyz), fast::normalize((_mtl_u.u_norm_mtx * float4(_276, 0.0)).xyz), fast::normalize((_mtl_u.u_norm_mtx * float4(cross(_272, _276), 0.0)).xyz)));
    out.gl_Position = _mtl_u.u_viewProj * float4(_258.xyz, 1.0);
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_ts_frag_pos = _349 * _258.xyz;
    out._entryPointOutput_v_ts_light_pos = _349 * _mtl_u.u_light_pos.xyz;
    out._entryPointOutput_v_ts_view_pos = _349 * float3(0.0);
    return out;
}

