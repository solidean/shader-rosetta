#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_view;
    float4 u_lightPosRadius[1];
    float4 u_lightRgbInnerR[1];
    float4x4 u_mtx;
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_normal [[texture(0)]], texture2d<float> s_depth [[texture(1)]], sampler s_normalSampler [[sampler(0)]], sampler s_depthSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _418 = (in.v_texcoord0 * 2.0) - float2(1.0);
    float4 _510 = _mtl_u.u_mtx * float4(_418.x, -_418.y, s_depth.sample(s_depthSampler, in.v_texcoord0).x, 1.0);
    float3 _533 = _mtl_u.u_lightPosRadius[0].xyz - (_510.xyz / float3(_510.w));
    out.bgfx_FragData0 = float4(powr(abs((_mtl_u.u_lightRgbInnerR[0].xyz * fast::clamp(fast::max(0.0, dot((s_normal.sample(s_normalSampler, in.v_texcoord0).xyz * 2.0) - float3(1.0), fast::normalize(_533))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[0].w, 1.0, length(_533) / _mtl_u.u_lightPosRadius[0].w))), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

