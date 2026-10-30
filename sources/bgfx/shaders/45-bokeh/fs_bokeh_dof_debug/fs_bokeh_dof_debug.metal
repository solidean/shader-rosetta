#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[13];
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
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_depth [[texture(1)]], sampler s_colorSampler [[sampler(0)]], sampler s_depthSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _324 = float3(dot(powr(abs(s_color.sample(s_colorSampler, in.v_texcoord0).xyz), float3(0.4545454680919647216796875)), float3(0.3300000131130218505859375, 0.3400000035762786865234375, 0.3300000131130218505859375)));
    float _343 = fast::clamp(((1.0 / _mtl_u.u_params[3].y) - (1.0 / s_depth.sample(s_depthSampler, in.v_texcoord0).x)) * _mtl_u.u_params[3].z, -1.0, 1.0);
    out.bgfx_FragData0 = float4(mix(_324, select(float3(0.0431372560560703277587890625, 0.3490196168422698974609375, 0.541176497936248779296875), float3(0.7333333492279052734375, 0.23921568691730499267578125, 0.02745098061859607696533203125), bool3(_343 < 0.0)) * _324, float3(abs(_343))), 1.0);
    return out;
}

