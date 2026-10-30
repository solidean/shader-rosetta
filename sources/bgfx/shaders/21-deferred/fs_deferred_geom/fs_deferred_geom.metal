#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4x4 u_invView;
};

constant float3 _355 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float4 bgfx_FragData1 [[color(1)]];
};

struct xlatMtlMain_in
{
    float3 v_bitangent [[user(locn0)]];
    float3 v_normal [[user(locn1)]];
    float3 v_tangent [[user(locn2)]];
    float2 v_texcoord0 [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texNormal [[texture(1)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texNormalSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _254 = (s_texNormal.sample(s_texNormalSampler, in.v_texcoord0).xy * 2.0) - float2(1.0);
    float _256 = _254.x;
    float3 _348;
    _348.x = _256;
    _348.y = _254.y;
    out.bgfx_FragData0 = s_texColor.sample(s_texColorSampler, in.v_texcoord0);
    out.bgfx_FragData1 = float4((fast::normalize((_mtl_u.u_invView * float4(fast::normalize(float3(_256, _254.y, sqrt(1.0 - dot(_348.xy, _348.xy))) * float3x3(fast::normalize(in.v_tangent), fast::normalize(in.v_bitangent), fast::normalize(in.v_normal))), 0.0)).xyz) * 0.5) + float3(0.5), 1.0);
    return out;
}

