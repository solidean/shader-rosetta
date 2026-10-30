#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewRect;
    float4 u_s2hMouse;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_quadPostColor [[texture(0)]], sampler s_quadPostColorSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _368 = s_quadPostColor.sample(s_quadPostColorSampler, in.v_texcoord0);
    float2 _283 = (gl_FragCoord.xy - _mtl_u.u_s2hMouse.xy) - float2(24.0);
    float _285 = _283.x;
    float _288 = _283.y;
    float3 _392;
    if ((((_285 >= 0.0) && (_288 >= 0.0)) && (_285 < 160.0)) && (_288 < 160.0))
    {
        float2 _304 = _283 * float2(0.100000001490116119384765625);
        float2 _318 = fract(_304);
        _392 = select(s_quadPostColor.sample(s_quadPostColorSampler, ((floor((_mtl_u.u_s2hMouse.xy - float2(8.0)) + _304) + float2(0.5)) / _mtl_u.u_viewRect.zw)).xyz, float3(0.0), bool3((_318.x < 0.07999999821186065673828125) || (_318.y < 0.07999999821186065673828125)));
    }
    else
    {
        _392 = _368.xyz;
    }
    out.bgfx_FragData0 = float4(mix(_392, float3(1.0), float3(1.0 - smoothstep(0.0, 1.0, fast::min(abs(gl_FragCoord.x - _mtl_u.u_s2hMouse.x), abs(gl_FragCoord.y - _mtl_u.u_s2hMouse.y))))), 1.0);
    return out;
}

