#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_pixelSize;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_tex [[texture(0)]], sampler s_texSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _347 = float2(_mtl_u.u_pixelSize.x, _mtl_u.u_pixelSize.y);
    float2 _348 = _347 * 0.5;
    float2 _354 = _347 * 1.0;
    float _364 = _348.x;
    float _365 = -_364;
    float _367 = _348.y;
    float _368 = -_367;
    float _416 = _354.x;
    float _427 = -_416;
    float _437 = _354.y;
    float _448 = -_437;
    float4 _507 = ((((((((((((s_tex.sample(s_texSampler, in.v_texcoord0) * 0.125) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_365, _368))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + _348)) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_364, _368))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_365, _367))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_416, 0.0))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_427, 0.0))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(0.0, _437))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(0.0, _448))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + _354)) * 0.03125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_427, _437))) * 0.03125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_416, _448))) * 0.03125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_427, _448))) * 0.03125);
    out.bgfx_FragData0 = _507;
    return out;
}

