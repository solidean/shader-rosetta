#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_viewProj;
    float4 u_sphereInfo;
    float4x4 u_invMvpShadow;
};

struct xlatMtlMain_out
{
    float4 _entryPointOutput_v_color0 [[user(locn0)]];
    float4 _entryPointOutput_v_lightCenterScale [[user(locn1)]];
    float4 gl_Position [[position]];
};

struct xlatMtlMain_in
{
    float3 a_position [[attribute(0)]];
};

vertex xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap [[texture(2)]], texture2d<float> s_rsm [[texture(3)]], sampler s_shadowMapSampler [[sampler(2)]], sampler s_rsmSampler [[sampler(3)]])
{
    xlatMtlMain_out out = {};
    float2 _281 = (_mtl_u.u_sphereInfo.xy * 2.0) - float2(1.0);
    float4 _364 = _mtl_u.u_invMvpShadow * float4(_281.x, -_281.y, s_shadowMap.sample(s_shadowMapSampler, _mtl_u.u_sphereInfo.xy, level(0.0)).x, 1.0);
    float3 _370 = _364.xyz / float3(_364.w);
    float _296 = _370.y - 0.001000000047497451305389404296875;
    float3 _416 = _370;
    _416.y = _296;
    float4 _380 = s_rsm.sample(s_rsmSampler, _mtl_u.u_sphereInfo.xy, level(0.0));
    float _306 = _380.w * _mtl_u.u_sphereInfo.z;
    float4 _427 = float4(1.0, 0.0, 0.0, 1.0);
    _427.x = _380.x;
    _427.y = _380.y;
    _427.z = _380.z;
    out.gl_Position = _mtl_u.u_viewProj * float4(_416 + (in.a_position * _306), 1.0);
    out._entryPointOutput_v_color0 = _427;
    out._entryPointOutput_v_lightCenterScale = float4(_370.x, _296, _370.z, _306);
    return out;
}

