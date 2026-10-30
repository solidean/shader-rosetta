#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_modelView;
    float4x4 u_modelViewProj;
    float4 u_time;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float3 _entryPointOutput_v_normal [[user(locn1)]];
    float3 _entryPointOutput_v_pos [[user(locn2)]];
    float3 _entryPointOutput_v_view [[user(locn3)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_normal [[attribute(0)]];
    float3 a_position [[attribute(1)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float _202 = _mtl_u.u_time.x * 4.0;
    float _206 = (sin((in.a_position.x * 32.0) + _202) * 0.5) + 0.5;
    float _216 = (cos((in.a_position.y * 32.0) + _202) * 0.5) + 0.5;
    float3 _222 = float3(_206, _216, _206 * _216);
    float3 _226 = (in.a_normal * 2.0) - float3(1.0);
    float4 _237 = float4(in.a_position + ((_226 * _222) * float3(0.0599999986588954925537109375)), 1.0);
    float4 _240 = _mtl_u.u_modelViewProj * _237;
    float _269 = (length(_222) * 0.4000000059604644775390625) + 0.60000002384185791015625;
    out.gl_Position = _240;
    out._entryPointOutput_v_color0 = float4(_269, _269, _269, 1.0);
    out._entryPointOutput_v_normal = (_mtl_u.u_modelView * float4(_226, 0.0)).xyz;
    out._entryPointOutput_v_pos = _240.xyz;
    out._entryPointOutput_v_view = (_mtl_u.u_modelView * _237).xyz;
    return out;
}

