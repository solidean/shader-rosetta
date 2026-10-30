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
    float4 v_position [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _129 = ((in.v_position.z / in.v_position.w) * 0.5) + 0.5;
    float2 _151 = fract(float2(255.0, 1.0) * _129);
    float2 _163 = fract(float2(255.0, 1.0) * (_129 * _129));
    out.bgfx_FragData0 = float4(_151 - (_151.xx * float2(0.0, 0.0039215688593685626983642578125)), _163 - (_163.xx * float2(0.0, 0.0039215688593685626983642578125)));
    return out;
}

