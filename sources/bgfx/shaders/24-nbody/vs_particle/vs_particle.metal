#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_view;
    float4x4 u_proj;
    float4 u_params[3];
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_texCoord [[user(locn0)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float2 a_position [[attribute(0)]];
    float4 i_data0 [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float3 _157 = (_mtl_u.u_view * float4(in.i_data0.xyz, 1.0)).xyz;
    float3 _160 = fast::normalize(cross(_157, float3(1.0, 0.0, 0.0)));
    out.gl_Position = _mtl_u.u_proj * float4((_157 + ((fast::normalize(cross(_160, _157)) * _mtl_u.u_params[1].y) * in.a_position.x)) + ((_160 * _mtl_u.u_params[1].y) * in.a_position.y), 1.0);
    out._entryPointOutput_v_texCoord = float3(in.a_position, in.i_data0.w);
    return out;
}

