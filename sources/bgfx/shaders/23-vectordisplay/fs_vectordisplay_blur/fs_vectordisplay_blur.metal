#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _344 = 4.0 * _mtl_u.u_params.x;
    float _350 = 4.0 * _mtl_u.u_params.y;
    float _360 = 3.0 * _mtl_u.u_params.x;
    float _366 = 3.0 * _mtl_u.u_params.y;
    float _378 = 2.0 * _mtl_u.u_params.x;
    float _384 = 2.0 * _mtl_u.u_params.y;
    float4 _513 = (((((((((s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x - _344, in.v_texcoord0.y - _350)) * 0.0500000007450580596923828125) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x - _360, in.v_texcoord0.y - _366)) * 0.0900000035762786865234375)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x - _378, in.v_texcoord0.y - _384)) * 0.119999997317790985107421875)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x - _mtl_u.u_params.x, in.v_texcoord0.y - _mtl_u.u_params.y)) * 0.1500000059604644775390625)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x, in.v_texcoord0.y)) * 0.1599999964237213134765625)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x + _mtl_u.u_params.x, in.v_texcoord0.y + _mtl_u.u_params.y)) * 0.1500000059604644775390625)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x + _378, in.v_texcoord0.y + _384)) * 0.119999997317790985107421875)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x + _360, in.v_texcoord0.y + _366)) * 0.0900000035762786865234375)) + (s_texColor.sample(s_texColorSampler, float2(in.v_texcoord0.x + _344, in.v_texcoord0.y + _350)) * 0.0500000007450580596923828125)) * float4(_mtl_u.u_params.z, _mtl_u.u_params.z, _mtl_u.u_params.z, _mtl_u.u_params.z * _mtl_u.u_params.w);
    out.bgfx_FragData0 = _513;
    return out;
}

