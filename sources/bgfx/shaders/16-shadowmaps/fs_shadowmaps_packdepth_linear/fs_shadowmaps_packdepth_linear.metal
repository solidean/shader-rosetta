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
    float v_depth [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _108 = fract(float4(16581375.0, 65025.0, 255.0, 1.0) * in.v_depth);
    out.bgfx_FragData0 = _108 - (_108.xxyz * float4(0.0, 0.0039215688593685626983642578125, 0.0039215688593685626983642578125, 0.0039215688593685626983642578125));
    return out;
}

