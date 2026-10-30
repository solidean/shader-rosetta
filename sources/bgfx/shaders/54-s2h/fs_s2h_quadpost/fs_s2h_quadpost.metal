#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4 u_s2hMouse;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_quadPostColor [[texture(0)]], sampler s_quadPostColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    out.bgfx_FragData0 = float4(mix(s_quadPostColor.sample(s_quadPostColorSampler, in.v_texcoord0).xyz, float3(1.0, 1.0, 0.0), float3(1.0 - smoothstep(0.0199999995529651641845703125, 0.02500000037252902984619140625, length(in.v_texcoord0 - (_mtl_u.u_s2hMouse.xy / _mtl_u.u_viewRect.zw))))), 1.0);
    return out;
}

