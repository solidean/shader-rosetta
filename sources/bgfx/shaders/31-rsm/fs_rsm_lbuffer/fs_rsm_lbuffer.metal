#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_viewTexel;
    float4x4 u_invMvp;
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
    float4 v_color0 [[user(locn0)]];
    float4 v_lightCenterScale [[user(locn1)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_normal [[texture(0)]], texture2d<float> s_depth [[texture(1)]], sampler s_normalSampler [[sampler(0)]], sampler s_depthSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _279 = gl_FragCoord.xy * _mtl_u.u_viewTexel.xy;
    float4 _359 = s_depth.sample(s_depthSampler, _279);
    float2 _289 = (_279 * 2.0) - float2(1.0);
    float4 _376 = _mtl_u.u_invMvp * float4(_289.x, -_289.y, _359.x, 1.0);
    float4 _391 = s_normal.sample(s_normalSampler, _279);
    float3 _312 = in.v_lightCenterScale.xyz - (_376.xyz / float3(_376.w));
    float _316 = sqrt(dot(_312, _312));
    float _400;
    if (_316 > in.v_lightCenterScale.w)
    {
        _400 = 0.0;
    }
    else
    {
        _400 = 1.0 - (_316 / in.v_lightCenterScale.w);
    }
    out.bgfx_FragData0 = float4(in.v_color0.xyz * fast::max(0.0, dot((_391.xyz * 2.0) - float3(1.0), fast::normalize(_312) * _400)), 1.0);
    return out;
}

