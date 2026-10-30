#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4 u_stipple;
};

constant float4 _479 = {};

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
    float3 v_pos [[user(locn1)]];
    float2 v_texcoord0 [[user(locn2)]];
    float3 v_view [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], texture2d<float> s_texStipple [[texture(1)]], sampler s_texColorSampler [[sampler(0)]], sampler s_texStippleSampler [[sampler(1)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _395 = s_texColor.sample(s_texColorSampler, in.v_texcoord0);
    float _352 = _395.w;
    if ((((_mtl_u.u_stipple.x - s_texStipple.sample(s_texStippleSampler, (((_mtl_u.u_viewRect.zw - _mtl_u.u_viewRect.xy) * float2(0.125, 0.25)) * ((in.v_pos.xy * 0.5) + float2(0.5)))).x) * _mtl_u.u_stipple.y) > _mtl_u.u_stipple.z) || (_352 < 0.5))
    {
        discard_fragment();
    }
    float3 _358 = fast::normalize(in.v_normal);
    float3 _373 = powr(abs(_395.xyz), float3(2.2000000476837158203125)) * (fast::clamp(dot(float3(0.0, 0.0, -1.0) - (_358 * (2.0 * dot(_358, float3(0.0, 0.0, -1.0)))), fast::normalize(in.v_view)), 0.0, 1.0) + 0.119999997317790985107421875);
    float4 _473;
    _473.x = _373.x;
    _473.y = _373.y;
    _473.z = _373.z;
    out.bgfx_FragData0 = float4(powr(abs(_473.xyz), float3(0.4545454680919647216796875)), _352);
    return out;
}

