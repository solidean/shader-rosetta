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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_texColor0 [[texture(0)]], texture2d<float> s_texColor1 [[texture(1)]], sampler s_texColor0Sampler [[sampler(0)]], sampler s_texColor1Sampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _183 = s_texColor0.sample(s_texColor0Sampler, in.v_texcoord0);
    out.bgfx_FragData0 = float4(_183.xyz / float3(fast::clamp(s_texColor1.sample(s_texColor1Sampler, in.v_texcoord0).x, 9.9999997473787516355514526367188e-05, 50000.0)), _183.w);
    return out;
}

