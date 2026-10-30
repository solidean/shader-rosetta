#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_time;
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
    float3 v_normal [[user(locn1)]];
    float3 v_pos [[user(locn2)]];
    float3 v_view [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float3 _322 = fast::normalize(in.v_normal);
    float _418 = dot(_322, float3(0.0, 0.0, -1.0));
    float _365 = 2.099999904632568359375 + (((sin((in.v_pos.x * 3.0) + _mtl_u.u_time.x) * 0.300000011920928955078125) + (cos((in.v_pos.y * 3.0) + _mtl_u.u_time.x) * 0.4000000059604644775390625)) + (cos((in.v_pos.z * 3.0) + _mtl_u.u_time.x) * 0.20000000298023223876953125));
    out.bgfx_FragData0 = float4(powr((float3(0.070000000298023223876953125, 0.0599999986588954925537109375, 0.07999999821186065673828125) + ((float3((sin(_365 * 25.1327419281005859375) * 0.4000000059604644775390625) + 0.60000002384185791015625, (sin(_365 * 12.56637096405029296875) * 0.4000000059604644775390625) + 0.60000002384185791015625, (sin(_365 * 6.283185482025146484375) * 0.4000000059604644775390625) + 0.60000002384185791015625) * in.v_color0.xyz) * fast::max(0.0, _418))) + float3(fast::max(0.20000000298023223876953125 + (0.800000011920928955078125 * powr(1.0 - _418, 5.0)), 0.0) * powr(step(0.0, _418) * fast::max(0.0, dot(float3(0.0, 0.0, -1.0) - (_322 * (2.0 * _418)), fast::normalize(in.v_view))), 128.0)), float3(0.4545454680919647216796875)), 1.0);
    return out;
}

