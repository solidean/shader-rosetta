#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_combineParams[2];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_normal [[texture(1)]], texture2d<float> s_ao [[texture(2)]], sampler s_colorSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]], sampler s_aoSampler [[sampler(2)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _225 = (in.v_texcoord0 * _mtl_u.u_combineParams[1].xy) + _mtl_u.u_combineParams[1].zw;
    bool _228 = _mtl_u.u_combineParams[0].x > 0.0;
    float3 _317;
    if (_228)
    {
        _317 = s_color.sample(s_colorSampler, _225).xyz;
    }
    else
    {
        _317 = float3(1.0);
    }
    float _319;
    if (_228)
    {
        _319 = (fast::max(0.0, dot((s_normal.sample(s_normalSampler, _225).xyz * 2.0) - float3(1.0), float3(-0.5390536785125732421875, 0.50536286830902099609375, -0.673817098140716552734375))) * 1.2000000476837158203125) + 0.300000011920928955078125;
    }
    else
    {
        _319 = 1.0;
    }
    float _320;
    if (_mtl_u.u_combineParams[0].y > 0.0)
    {
        _320 = s_ao.sample(s_aoSampler, _225).x;
    }
    else
    {
        _320 = 1.0;
    }
    out.bgfx_FragData0 = float4((_317 * _319) * _320, 1.0);
    return out;
}

