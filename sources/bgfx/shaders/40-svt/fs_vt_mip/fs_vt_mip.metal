#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_vt_settings_1;
    float4 u_vt_settings_2;
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
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _224 = in.v_texcoord0 * _mtl_u.u_vt_settings_1.x;
    float2 _225 = dfdx(_224);
    float2 _230 = dfdy(-_224);
    float _191 = fast::clamp(floor(fast::max(0.5 * log2(fast::max(dot(_225, _225), dot(_230, _230))), 0.0) - _mtl_u.u_vt_settings_2.x), 0.0, log2(_mtl_u.u_vt_settings_2.y));
    out.bgfx_FragData0 = float4(floor(float3(floor(in.v_texcoord0 * _mtl_u.u_vt_settings_2.y) / float2(exp2(_191)), _191)) * float3(0.0039215688593685626983642578125), 1.0);
    return out;
}

