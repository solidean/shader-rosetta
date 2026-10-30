#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_offset[16];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _517 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[0].xy));
    float4 _540 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[1].xy));
    float4 _563 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[2].xy));
    float4 _586 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[3].xy));
    float4 _609 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[4].xy));
    float4 _632 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[5].xy));
    float4 _655 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[6].xy));
    float4 _678 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[7].xy));
    float4 _701 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0 + _mtl_u.u_offset[8].xy));
    float _500 = (((((((dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _517.xyz * exp2((_517.w * 255.0) - 128.0)) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _540.xyz * exp2((_540.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _563.xyz * exp2((_563.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _586.xyz * exp2((_586.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _609.xyz * exp2((_609.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _632.xyz * exp2((_632.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _655.xyz * exp2((_655.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _678.xyz * exp2((_678.w * 255.0) - 128.0))) + dot(float3(0.21267290413379669189453125, 0.715152204036712646484375, 0.072175003588199615478515625), _701.xyz * exp2((_701.w * 255.0) - 128.0));
    float _502 = _500 * 0.111111111938953399658203125;
    float _829 = ceil(log2(_502));
    out.bgfx_FragData0 = float4(_502 / exp2(_829), 0.0, 0.0, (_829 + 128.0) * 0.0039215688593685626983642578125);
    return out;
}

