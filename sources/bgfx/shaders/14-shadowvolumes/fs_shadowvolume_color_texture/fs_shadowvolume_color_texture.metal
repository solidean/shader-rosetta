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
};

struct xlatMtlMain_in
{
    float2 v_texcoord0 [[user(locn0)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _230 = s_texColor.sample(s_texColorSampler, in.v_texcoord0);
    float3 _249 = powr(abs(_230.xyz), float3(2.2000000476837158203125));
    float _239 = _249.x;
    if (_239 < 0.100000001490116119384765625)
    {
        discard_fragment();
    }
    float4 _215 = float4(_239, _249.yz, _230.w) + _mtl_u.u_color;
    out.bgfx_FragData0 = float4(powr(abs(_215.xyz), float3(0.4545454680919647216796875)), _215.w);
    return out;
}

