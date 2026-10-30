#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_pixelSize;
    float4 u_intensity;
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
    float _276 = -_mtl_u.u_pixelSize.x;
    float _307 = -_mtl_u.u_pixelSize.y;
    out.bgfx_FragData0 = (((((((((s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_276, 0.0))) * 0.125) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(0.0, _mtl_u.u_pixelSize.y))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_mtl_u.u_pixelSize.x, 0.0))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(0.0, _307))) * 0.125)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_276, _307))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_276, _mtl_u.u_pixelSize.y))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_mtl_u.u_pixelSize.x, _307))) * 0.0625)) + (s_tex.sample(s_texSampler, (in.v_texcoord0 + float2(_mtl_u.u_pixelSize.xy))) * 0.0625)) + (s_tex.sample(s_texSampler, in.v_texcoord0) * 0.25)) * _mtl_u.u_intensity.x;
    return out;
}

