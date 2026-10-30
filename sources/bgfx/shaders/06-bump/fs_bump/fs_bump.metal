#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_lightPosRadius[4];
    float4 u_lightRgbInnerR[4];
};

constant float _1039 = {};
constant float3 _1071 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float3 v_bitangent [[user(locn0)]];
    float3 v_normal [[user(locn1)]];
    float3 v_tangent [[user(locn2)]];
    float2 v_texcoord0 [[user(locn3)]];
    float3 v_wpos [[user(locn5)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texNormal [[texture(1)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texNormalSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3x3 _594 = transpose(float3x3(in.v_tangent, in.v_bitangent, in.v_normal));
    float2 _512 = (s_texNormal.sample(s_texNormalSampler, in.v_texcoord0).xy * 2.0) - float2(1.0);
    float _514 = _512.x;
    float3 _1041;
    _1041.x = _514;
    _1041.y = _512.y;
    float3 _1069 = float3(_514, _512.y, sqrt(1.0 - dot(_1041.xy, _1041.xy)));
    float3 _623 = _mtl_u.u_lightPosRadius[0].xyz - in.v_wpos;
    float3 _714 = _mtl_u.u_lightPosRadius[1].xyz - in.v_wpos;
    float3 _805 = _mtl_u.u_lightPosRadius[2].xyz - in.v_wpos;
    float3 _896 = _mtl_u.u_lightPosRadius[3].xyz - in.v_wpos;
    float3 _559 = fast::max(float3(0.0500000007450580596923828125), ((((_mtl_u.u_lightRgbInnerR[0].xyz * fast::clamp(fast::max(0.0, dot(_1069, _594 * fast::normalize(_623))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[0].w, 1.0, length(_623) / _mtl_u.u_lightPosRadius[0].w))) + ((_mtl_u.u_lightRgbInnerR[1].xyz * fast::clamp(fast::max(0.0, dot(_1069, _594 * fast::normalize(_714))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[1].w, 1.0, length(_714) / _mtl_u.u_lightPosRadius[1].w)))) + ((_mtl_u.u_lightRgbInnerR[2].xyz * fast::clamp(fast::max(0.0, dot(_1069, _594 * fast::normalize(_805))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[2].w, 1.0, length(_805) / _mtl_u.u_lightPosRadius[2].w)))) + ((_mtl_u.u_lightRgbInnerR[3].xyz * fast::clamp(fast::max(0.0, dot(_1069, _594 * fast::normalize(_896))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[3].w, 1.0, length(_896) / _mtl_u.u_lightPosRadius[3].w))));
    out.bgfx_FragData0 = float4(powr(abs(float4(_559 * float4(powr(abs(s_texColor.sample(s_texColorSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125)), _1039).xyz, 1.0).xyz), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

