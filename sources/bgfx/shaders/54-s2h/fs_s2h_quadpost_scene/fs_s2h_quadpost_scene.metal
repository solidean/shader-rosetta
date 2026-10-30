#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_s2hTime;
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
    float2 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = float4(mix(mix(float3(0.0599999986588954925537109375, 0.100000001490116119384765625, 0.25), float3(0.89999997615814208984375, 0.25, 0.100000001490116119384765625), float3(0.5 + (0.5 * sin((_mtl_u.u_s2hTime.x + (in.v_texcoord0.x * 8.0)) + (in.v_texcoord0.y * 5.0))))), float3(1.0), float3(step(0.959999978542327880859375, fract(in.v_texcoord0.x * 10.0)) + step(0.959999978542327880859375, fract(in.v_texcoord0.y * 10.0)))), 1.0);
    return out;
}

