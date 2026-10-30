#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float4 bgfx_FragData1 [[color(1)]];
};

struct xlatMtlMain_in
{
    float3 v_normal [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _270 = fast::normalize(in.v_normal);
    float _319 = _270.z;
    float2 _323 = _270.xy * (1.0 / ((abs(_270.x) + abs(_270.y)) + abs(_319)));
    float2 _358 = floor((fast::clamp((_319 <= 0.0) ? ((float2(1.0) - abs(_323.yx)) * float2((_323.x >= 0.0) ? 1.0 : (-1.0), (_323.y >= 0.0) ? 1.0 : (-1.0))) : _323, float2(-1.0), float2(1.0)) * 2047.0) + float2(2047.5));
    float _360 = _358.y;
    float _362 = floor(_360 * 0.00390625);
    float _365 = _358.x * 0.0625;
    out.bgfx_FragData0 = float4(powr(abs(float3(1.0)), float3(0.4545454680919647216796875)), 0.0);
    out.bgfx_FragData1 = float4(float3(floor(_365), (fract(_365) * 256.0) + _362, _360 - (_362 * 256.0)) * float3(0.0039215688593685626983642578125), 1.0);
    return out;
}

