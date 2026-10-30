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
    float4 v_color0 [[user(locn0)]];
    float4 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _200 = s_texColor.sample(s_texColorSampler, in.v_texcoord0.xy);
    float _166 = _200.x;
    out.bgfx_FragData0 = float4(((_200.xxx * in.v_color0.xyz) * _166) * in.v_color0.w, (_166 * in.v_color0.w) * (1.0 - in.v_texcoord0.z));
    return out;
}

