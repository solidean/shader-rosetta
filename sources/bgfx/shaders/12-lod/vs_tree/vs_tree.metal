#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
};

struct xlatMtlMain_out
{
    float3 _entryPointOutput_v_normal [[user(locn0)]];
    float3 _entryPointOutput_v_pos [[user(locn1)]];
    float2 _entryPointOutput_v_texcoord0 [[user(locn2)]];
    float3 _entryPointOutput_v_view [[user(locn3)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_normal [[attribute(0)]];
    float3 a_position [[attribute(1)]];
    float2 a_texcoord0 [[attribute(2)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _166 = float4(in.a_position, 1.0);
    float4 _169 = _mtl_u.u_modelViewProj * _166;
    out.gl_Position = _169;
    out._entryPointOutput_v_normal = (_mtl_u.u_modelView * float4((in.a_normal * 2.0) - float3(1.0), 0.0)).xyz;
    out._entryPointOutput_v_pos = _169.xyz / float3(_169.w);
    out._entryPointOutput_v_texcoord0 = in.a_texcoord0;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _166).xyz;
    return out;
}

