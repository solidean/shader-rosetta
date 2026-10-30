#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_modelParams[2];
};

constant float3 _642 = {};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
};

struct xlatMtlMain_in
{
    float3 v_normal [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_albedo [[texture(0)]], texture2d<float> s_normal [[texture(1)]], sampler s_albedoSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _409 = fast::normalize(in.v_normal);
    float4 _528 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _623;
    _623.x = _528.x;
    _623.y = _528.y;
    float2 _422 = (_623.xy * 2.0) - float2(1.0);
    float _424 = _422.x;
    float3 _627;
    _627.x = _424;
    _627.y = _422.y;
    float3 _641 = float3(_424, _422.y, sqrt(1.0 - dot(_627.xy, _627.xy)));
    float2 _437 = -_641.yx;
    float3 _633 = _641;
    _633.x = _437.x;
    _633.y = _437.y;
    float2 _549 = dfdx(in.v_texcoord0);
    float2 _552 = dfdy(-in.v_texcoord0);
    float3 _555 = cross(dfdy(-in.v_texcoord1.xyz), _409);
    float3 _558 = cross(_409, dfdx(in.v_texcoord1.xyz));
    float3 _567 = (_555 * _549.x) + (_558 * _552.x);
    float3 _576 = (_555 * _549.y) + (_558 * _552.y);
    float _584 = rsqrt(fast::max(dot(_567, _567), dot(_576, _576)));
    float3 _451 = fast::normalize(_633 * transpose(float3x3(_567 * _584, _576 * _584, _409)));
    float3 _458 = fast::normalize(_mtl_u.u_modelParams[1].xyz - in.v_texcoord1.xyz);
    out.bgfx_FragData0 = float4(((_mtl_u.u_modelParams[0].xyz * powr(abs(s_albedo.sample(s_albedoSampler, in.v_texcoord0).xyz), float3(2.2000000476837158203125))) * (0.100000001490116119384765625 + fast::clamp(dot(_451, _458), 0.0, 1.0))) + float3(5.0 * powr(fast::clamp(dot(_451, fast::normalize(in.v_texcoord2.xyz + _458)), 0.0, 1.0), 256.0)), 1.0);
    return out;
}

