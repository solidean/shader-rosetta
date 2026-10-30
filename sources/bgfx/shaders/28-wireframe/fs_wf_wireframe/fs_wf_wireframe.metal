#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[3];
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
    float3 v_bc [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], bool gl_FrontFacing [[front_facing]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _223;
    if (gl_FrontFacing)
    {
        _223 = _mtl_u.u_params[1].w * 0.5;
    }
    else
    {
        _223 = _mtl_u.u_params[1].w;
    }
    float3 _196 = smoothstep(float3(0.0), (abs(dfdx(in.v_bc)) + abs(dfdy(-in.v_bc))) * _mtl_u.u_params[2].y, in.v_bc);
    out.bgfx_FragData0 = float4(_mtl_u.u_params[1].xyz, (1.0 - fast::min(fast::min(_196.x, _196.y), _196.z)) * _223);
    return out;
}

