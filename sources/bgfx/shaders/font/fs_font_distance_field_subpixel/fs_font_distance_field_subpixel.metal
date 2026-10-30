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
    float4 v_color0 [[user(locn0)]];
    float4 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], texturecube<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    int _229 = int((in.v_texcoord0.w * 4.0) + 0.5);
    float3 _232 = dfdx(in.v_texcoord0.xyz);
    float3 _238 = _232 * 0.16666699945926666259765625;
    float _252 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0.xyz - _238)).zyxw[_229];
    float _258 = s_texColor.sample(s_texColorSampler, (in.v_texcoord0.xyz + _238)).zyxw[_229];
    float _262 = 0.5 * (_252 + _258);
    float _270 = 8.0 * (length(_232) + length(dfdy(-in.v_texcoord0.xyz)));
    out.bgfx_FragData0 = float4(smoothstep(float3(0.5 - _270), float3(0.5 + _270), float3(_252, _262, _258)) * in.v_color0.w, _262 * in.v_color0.w);
    return out;
}

