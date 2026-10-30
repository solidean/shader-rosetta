#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_color;
};

constant uint bgfx_sampleMask [[function_constant(0)]];
constant bool bgfx_sampleMaskEnabled = is_function_constant_defined(bgfx_sampleMask);

struct xlatMtlMain_out
{
	uint bgfx_metal_sampleMask [[sample_mask, function_constant(bgfx_sampleMaskEnabled)]];
    float4 bgfx_FragData0 [[color(0)]];
    float4 bgfx_FragData1 [[color(1)]];
};

struct xlatMtlMain_in
{
    float4 v_pos [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _131 = _mtl_u.u_color;
    float3 _141 = _131.xyz * _131.w;
    float4 _170 = _131;
    _170.x = _141.x;
    _170.y = _141.y;
    _170.z = _141.z;
    out.bgfx_FragData0 = _170 * (_131.w * fast::clamp(0.02999999932944774627685546875 / (9.9999997473787516355514526367188e-06 + powr((in.v_pos.z / in.v_pos.w) * 0.004999999888241291046142578125, 5.0)), 0.00999999977648258209228515625, 3000.0));
    out.bgfx_FragData1 = _170.wwww;
    return out;
}

