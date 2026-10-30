#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_parameters;
    float4 u_sunDirection;
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
    float3 v_skyColor [[user(locn1)]];
    float3 v_viewDir [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _242 = _mtl_u.u_parameters.x * _mtl_u.u_parameters.x;
    float _251 = 1.0 - dot(fast::normalize(in.v_viewDir), fast::normalize(_mtl_u.u_sunDirection.xyz));
    float _264 = exp(((_251 * (-2.0)) / _mtl_u.u_parameters.y) / _242) + step(2.0 * _251, _242);
    out.bgfx_FragData0 = float4(powr(abs(in.v_skyColor + float3(fast::min(_264 * _264, 1.0))), float3(0.4545454680919647216796875)) + float3((fract(52.98291778564453125 * fract(dot(gl_FragCoord.xy + (float2(13.0) * fract(_mtl_u.u_parameters.w)), float2(0.067110560834407806396484375, 0.005837149918079376220703125)))) - 0.5) * 0.0039215688593685626983642578125), 1.0);
    return out;
}

