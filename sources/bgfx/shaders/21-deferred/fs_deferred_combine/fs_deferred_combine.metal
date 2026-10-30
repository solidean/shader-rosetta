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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_albedo [[texture(0)]], texture2d<float> s_light [[texture(1)]], sampler s_albedoSampler [[sampler(0)]], sampler s_lightSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _231 = s_albedo.sample(s_albedoSampler, in.v_texcoord0);
    float4 _263 = s_light.sample(s_lightSampler, in.v_texcoord0);
    float4 _217 = float4(powr(abs(_231.xyz), float3(2.2000000476837158203125)), _231.w) * float4(powr(abs(_263.xyz), float3(2.2000000476837158203125)), _263.w);
    out.bgfx_FragData0 = float4(powr(abs(_217.xyz), float3(0.4545454680919647216796875)), _217.w);
    return out;
}

