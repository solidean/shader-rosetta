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
    float4 v_texcoord1 [[user(locn1)]];
    float4 v_texcoord2 [[user(locn2)]];
    float4 v_texcoord3 [[user(locn3)]];
    float4 v_texcoord4 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = ((((((((s_texColor.sample(s_texColorSampler, in.v_texcoord0) * 0.2242152392864227294921875) + (s_texColor.sample(s_texColorSampler, in.v_texcoord1.xy) * 0.20179371535778045654296875)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord1.zw) * 0.20179371535778045654296875)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord2.xy) * 0.12331838905811309814453125)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord2.zw) * 0.12331838905811309814453125)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord3.xy) * 0.040358744561672210693359375)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord3.zw) * 0.040358744561672210693359375)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord4.xy) * 0.02242152392864227294921875)) + (s_texColor.sample(s_texColorSampler, in.v_texcoord4.zw) * 0.02242152392864227294921875);
    return out;
}

