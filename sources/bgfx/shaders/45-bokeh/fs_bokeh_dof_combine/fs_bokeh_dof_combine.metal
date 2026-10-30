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
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_blurredColor [[texture(1)]], sampler s_colorSampler [[sampler(0)]], sampler s_blurredColorSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _266 = s_color.sample(s_colorSampler, in.v_texcoord0);
    float4 _275 = s_blurredColor.sample(s_blurredColorSampler, in.v_texcoord0);
    float3 _281 = mix(_266.xyz, _275.xyz, float3(fast::clamp(_275.w - 1.0, 0.0, 1.0)));
    float4 _304 = _266;
    _304.x = _281.x;
    _304.y = _281.y;
    _304.z = _281.z;
    float3 _288 = powr(abs(_304.xyz), float3(0.4545454680919647216796875));
    float4 _310 = _304;
    _310.x = _288.x;
    _310.y = _288.y;
    _310.z = _288.z;
    out.bgfx_FragData0 = _310;
    return out;
}

