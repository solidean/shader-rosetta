#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_albedo [[texture(1)]], sampler s_colorSampler [[sampler(0)]], sampler s_albedoSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = float4(powr(abs(s_color.sample(s_colorSampler, in.v_texcoord0).xyz * powr(abs(s_albedo.sample(s_albedoSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125))), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

