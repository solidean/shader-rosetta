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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _180 = _mtl_u.u_parameters.x * _mtl_u.u_parameters.x;
    float _189 = 1.0 - dot(fast::normalize(in.v_viewDir), fast::normalize(_mtl_u.u_sunDirection.xyz));
    float _202 = exp(((_189 * (-2.0)) / _mtl_u.u_parameters.y) / _180) + step(2.0 * _189, _180);
    out.bgfx_FragData0 = float4(powr(abs(in.v_skyColor + float3(fast::min(_202 * _202, 1.0))), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

