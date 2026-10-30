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
    float v_eye [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = float4(in.v_color0.xyz * mix(float3(1.0, 0.1500000059604644775390625, 0.1500000059604644775390625), float3(0.1500000059604644775390625, 0.4000000059604644775390625, 1.0), float3(in.v_eye)), 1.0);
    return out;
}

