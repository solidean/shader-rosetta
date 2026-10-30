#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_sunDirection;
    float4 u_skyLuminanceXYZ;
    float4 u_parameters;
    float4 u_perezCoeff[5];
    float4x4 u_invViewProj;
};

struct xlatMtlMain_out
{
    float2 _entryPointOutput_v_screenPos [[user(locn0)]];
    float3 _entryPointOutput_v_skyColor [[user(locn1)]];
    float3 _entryPointOutput_v_viewDir [[user(locn2)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
    float4 _423 = _mtl_u.u_invViewProj * float4(in.a_position.xy, -1.0, 1.0);
    float4 _432 = float4(in.a_position.xy, 1.0, 1.0);
    float4 _435 = _mtl_u.u_invViewProj * _432;
    float3 _451 = fast::normalize((_435 / float4(_435.w)).xyz - (_423 / float4(_423.w)).xyz);
    float _455 = abs(_451.y);
    float3 _697 = _451;
    _697.y = _455;
    float3 _466 = fast::normalize(_mtl_u.u_sunDirection.xyz);
    float _491 = fast::clamp(dot(_697, _466), -0.99989998340606689453125, 0.99989998340606689453125);
    float _494 = _466.y;
    float _519 = (_mtl_u.u_skyLuminanceXYZ.x + _mtl_u.u_skyLuminanceXYZ.y) + _mtl_u.u_skyLuminanceXYZ.z;
    float3 _539 = (float3(_mtl_u.u_skyLuminanceXYZ.x / _519, _mtl_u.u_skyLuminanceXYZ.y / _519, _mtl_u.u_skyLuminanceXYZ.y) * ((float3(1.0) + (_mtl_u.u_perezCoeff[0].xyz * exp(_mtl_u.u_perezCoeff[1].xyz * (1.0 / fast::max(_455, 0.001000000047497451305389404296875))))) * ((float3(1.0) + (_mtl_u.u_perezCoeff[2].xyz * exp(_mtl_u.u_perezCoeff[3].xyz * acos(_491)))) + (_mtl_u.u_perezCoeff[4].xyz * (_491 * _491))))) / ((float3(1.0) + (_mtl_u.u_perezCoeff[0].xyz * exp(_mtl_u.u_perezCoeff[1].xyz * 1.0))) * ((float3(1.0) + (_mtl_u.u_perezCoeff[2].xyz * exp(_mtl_u.u_perezCoeff[3].xyz * acos(_494)))) + (_mtl_u.u_perezCoeff[4].xyz * (_494 * _494))));
    float _541 = _539.x;
    float _543 = _539.z;
    float _546 = _539.y;
    float3 _566 = float3((_541 * _543) / _546, _543, (((1.0 - _541) - _546) * _543) / _546) * _mtl_u.u_parameters.z;
    out.gl_Position = _432;
    out._entryPointOutput_v_screenPos = in.a_position.xy;
    out._entryPointOutput_v_skyColor = float3(dot(float3(3.240454196929931640625, -1.537138462066650390625, -0.498531401157379150390625), _566), dot(float3(-0.969265997409820556640625, 1.87601077556610107421875, 0.04155600070953369140625), _566), dot(float3(0.0556433983147144317626953125, -0.2040258944034576416015625, 1.05722522735595703125), _566));
    out._entryPointOutput_v_viewDir = _697;
    return out;
}

