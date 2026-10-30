#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

struct _Global
{
    float4 u_params[12];
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_normal [[texture(1)]], texture2d<float> s_depth [[texture(2)]], texture2d<float> s_shadows [[texture(3)]], sampler s_colorSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]], sampler s_depthSampler [[sampler(2)]], sampler s_shadowsSampler [[sampler(3)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _662 = s_color.sample(s_colorSampler, in.v_texcoord0);
    float3 _669 = powr(abs(_662.xyz), float3(2.2000000476837158203125));
    float3 _878;
    if (0.0 < _662.w)
    {
        float4 _682 = s_normal.sample(s_normalSampler, in.v_texcoord0);
        float3 _699 = _682.xyz * 255.0;
        float _702 = _699.y * 0.0625;
        float2 _725 = fast::min(fast::max((float2((_699.x * 16.0) + floor(_702), (fract(_702) * 4096.0) + _699.z) * 0.000488519784994423389434814453125) - float2(1.0), float2(-1.0)), float2(1.0));
        float _732 = _725.x;
        float _736 = _725.y;
        float _738 = (1.0 - abs(_732)) - abs(_736);
        float3 _741 = float3(_732, _736, _738);
        float3 _906;
        if (_738 < 0.0)
        {
            float2 _754 = (float2(1.0) - abs(_741.yx)) * float2((_732 >= 0.0) ? 1.0 : (-1.0), (_736 >= 0.0) ? 1.0 : (-1.0));
            float3 _896 = _741;
            _896.x = _754.x;
            _896.y = _754.y;
            _906 = _896;
        }
        else
        {
            _906 = _741;
        }
        float4 _809 = s_depth.sample(s_depthSampler, in.v_texcoord0);
        float _591 = _809.x;
        float4 _839 = s_shadows.sample(s_shadowsSampler, in.v_texcoord0);
        float _598 = _839.x;
        float3 _608 = _mtl_u.u_params[3].xyz - float3(((_mtl_u.u_params[2].xy * in.v_texcoord0) + _mtl_u.u_params[2].zw) * _591, _591);
        float _618 = fast::clamp(dot((float4(fast::normalize(_906), 0.0) * transpose(float4x4(_mtl_u.u_params[4], _mtl_u.u_params[5], _mtl_u.u_params[6], _mtl_u.u_params[7]))).xyz, fast::normalize(_608)), 0.0, 1.0);
        float3 _879;
        if (0.0 < _mtl_u.u_params[3].w)
        {
            _879 = float3(_598);
        }
        else
        {
            _879 = powr(abs(_669 * (mix(_618 * (1.0 / (dot(_608, _608) + 9.9999997473787516355514526367188e-06)), 5.0 * powr(_618, (62.0 * (1.0 - _682.w)) + 2.0), 0.039999999105930328369140625) * _598)), float3(0.4545454680919647216796875));
        }
        _878 = _879;
    }
    else
    {
        _878 = _669;
    }
    out.bgfx_FragData0 = float4(_878, 1.0);
    return out;
}

