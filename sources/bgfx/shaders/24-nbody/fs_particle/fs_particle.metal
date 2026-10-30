#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float3 v_texCoord [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = float4(mix(float3(0.100000001490116119384765625, 0.800000011920928955078125, 0.20000000298023223876953125), float3(0.1500000059604644775390625, 0.125, 0.02500000037252902984619140625), float3(in.v_texCoord.z)) * (_mtl_u.u_params[1].x * powr(fast::max(1.0 - length(in.v_texCoord.xy), 0.0), _mtl_u.u_params[1].w)), 1.0);
    return out;
}

