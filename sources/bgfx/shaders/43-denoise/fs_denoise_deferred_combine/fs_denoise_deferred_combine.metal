#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[13];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_normal [[texture(1)]], sampler s_normalSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _454;
    if (1.5 < _mtl_u.u_params[11].y)
    {
        _454 = (fract(sin(dot(gl_FragCoord.xy + (float2(314.0, 159.0) * _mtl_u.u_params[11].x), float2(12.98980045318603515625, 78.233001708984375))) * 43758.546875) < 0.5) ? 0.0 : 1.0;
    }
    else
    {
        float _455;
        if (0.5 < _mtl_u.u_params[11].y)
        {
            _455 = float(((int(gl_FragCoord.y - (2.0 * floor(gl_FragCoord.y * 0.5))) * 2) + int(gl_FragCoord.x - (2.0 * floor(gl_FragCoord.x * 0.5)))) == int(_mtl_u.u_params[11].x - (4.0 * floor(_mtl_u.u_params[11].x * 0.25))));
        }
        else
        {
            _455 = 1.0;
        }
        _454 = _455;
    }
    float _368 = fast::clamp(dot((s_normal.sample(s_normalSampler, in.v_texcoord0).xyz * 2.0) - float3(1.0), float3(-0.19245009124279022216796875, 0.9622504711151123046875, -0.19245009124279022216796875)), 0.0, 1.0);
    float _380 = (((_368 * 0.9900000095367431640625) + 0.00999999977648258209228515625) + (5.0 * powr(_368, 513.0))) * _454;
    out.bgfx_FragData0 = float4(_380, _380, _380, 1.0);
    return out;
}

