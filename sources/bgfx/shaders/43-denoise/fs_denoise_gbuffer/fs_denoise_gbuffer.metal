#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
};

constant float3 _735 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float4 bgfx_FragData1 [[color(1)]];
    float4 bgfx_FragData2 [[color(2)]];
};

struct xlatMtlMain_in
{
    float3 v_normal [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_albedo [[texture(0)]], texture2d<float> s_normal [[texture(1)]], sampler s_albedoSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _576 = powr(abs(s_albedo.sample(s_albedoSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125));
    float3 _466 = fast::normalize(in.v_normal);
    float4 _589 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _711;
    _711.x = _589.x;
    _711.y = _589.y;
    float2 _479 = (_711.xy * 2.0) - float2(1.0);
    float _481 = _479.x;
    float3 _715;
    _715.x = _481;
    float _483 = _479.y;
    _715.y = _483;
    float _490 = sqrt(1.0 - dot(_715.xy, _715.xy));
    float3 _734 = float3(_481, _483, _490);
    _734.x = _483;
    _734.y = _481;
    float2 _610 = dfdx(in.v_texcoord0);
    float2 _613 = dfdy(-in.v_texcoord0);
    float3 _616 = cross(dfdy(-in.v_texcoord2.xyz), _466);
    float3 _619 = cross(_466, dfdx(in.v_texcoord2.xyz));
    float3 _628 = (_616 * _610.x) + (_619 * _613.x);
    float3 _637 = (_616 * _610.y) + (_619 * _613.y);
    float _645 = rsqrt(fast::max(dot(_628, _628), dot(_637, _637)));
    float2 _522 = in.v_texcoord1.xy * (1.0 / in.v_texcoord1.w);
    _522.y = _522.y * (-1.0);
    out.bgfx_FragData0 = float4(powr(abs(_576), float3(0.4545454680919647216796875)), 1.0);
    out.bgfx_FragData1 = float4((fast::normalize(_734 * transpose(float3x3(_628 * _645, _637 * _645, _466))) * 0.5) + float3(0.5), ((_490 * mix(0.89999997615814208984375, 1.0, _576.y)) * 0.60000002384185791015625) + 0.20000000298023223876953125);
    out.bgfx_FragData2 = float4((gl_FragCoord.xy * _mtl_u.u_viewTexel.xy) - ((_522 * 0.5) + float2(0.5)), 0.0, 0.0);
    return out;
}

