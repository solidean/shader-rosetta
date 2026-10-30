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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d_array<float> s_albedo [[texture(0)]], texture2d<float> s_light [[texture(1)]], sampler s_albedoSampler [[sampler(0)]], sampler s_lightSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _234 = float3(in.v_texcoord0, 0.0);
    float4 _258 = s_albedo.sample(s_albedoSampler, _234.xy, uint(rint(_234.z)));
    float4 _290 = s_light.sample(s_lightSampler, in.v_texcoord0);
    float4 _244 = float4(powr(abs(_258.xyz), float3(2.2000000476837158203125)), _258.w) * float4(powr(abs(_290.xyz), float3(2.2000000476837158203125)), _290.w);
    out.bgfx_FragData0 = float4(powr(abs(_244.xyz), float3(0.4545454680919647216796875)), _244.w);
    return out;
}

