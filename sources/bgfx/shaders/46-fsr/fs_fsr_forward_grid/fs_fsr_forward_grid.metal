#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_modelParams[2];
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
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _347 = abs(floor(in.v_texcoord1.xz + float2(-0.00200000009499490261077880859375)));
    float _349 = _347.x;
    float _352 = _347.y;
    float3 _284 = fast::normalize(in.v_normal);
    float3 _291 = fast::normalize(_mtl_u.u_modelParams[1].xyz - in.v_texcoord1.xyz);
    out.bgfx_FragData0 = float4(((powr(abs(_mtl_u.u_modelParams[0].xyz), float3(2.2000000476837158203125)) * ((int(_349 - (2.0 * floor(_349 * 0.5))) == int(_352 - (2.0 * floor(_352 * 0.5)))) ? 0.75 : 1.25)) * (0.100000001490116119384765625 + fast::clamp(dot(_284, _291), 0.0, 1.0))) + float3(5.0 * powr(fast::clamp(dot(_284, fast::normalize(in.v_texcoord2.xyz + _291)), 0.0, 1.0), 256.0)), 1.0);
    return out;
}

