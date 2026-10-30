#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_sunDirection;
    float4 u_sunLuminance;
    float4 u_skyLuminance;
    float4 u_parameters;
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
    float3 v_normal [[user(locn0)]];
    float2 v_texcoord0 [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texLightmap [[texture(0)]], sampler s_texLightmapSampler [[sampler(0)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _294 = fast::normalize(in.v_normal);
    float4 _442 = float4((((_mtl_u.u_sunLuminance.xyz * fast::max(0.0, dot(_294, fast::normalize(_mtl_u.u_sunDirection.xyz)))) + (((_mtl_u.u_skyLuminance.xyz * (1.0 + (0.5 * _294.z))) + float3(0.00999999977648258209228515625)) * powr(abs(s_texLightmap.sample(s_texLightmapSampler, in.v_texcoord0).x), 2.2000000476837158203125))) * 0.5) * _mtl_u.u_parameters.z, 1.0);
    float3 _353 = powr(abs(_442.xyz), float3(0.4545454680919647216796875)) + float3((fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy + (float2(13.0) * fract(_mtl_u.u_parameters.w)), float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) - 0.5) * 0.0039215688593685626983642578125);
    float4 _436 = _442;
    _436.x = _353.x;
    _436.y = _353.y;
    _436.z = _353.z;
    out.bgfx_FragData0 = _436;
    return out;
}

