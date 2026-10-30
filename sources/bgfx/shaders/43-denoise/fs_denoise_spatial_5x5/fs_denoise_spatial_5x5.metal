#pragma clang diagnostic ignored "-Wmissing-prototypes"
#pragma clang diagnostic ignored "-Wmissing-braces"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template<typename T, size_t Num>
struct spvUnsafeArray
{
    T elements[Num ? Num : 1];
    
    thread T& operator [] (size_t pos) thread
    {
        return elements[pos];
    }
    constexpr const thread T& operator [] (size_t pos) const thread
    {
        return elements[pos];
    }
    
    device T& operator [] (size_t pos) device
    {
        return elements[pos];
    }
    constexpr const device T& operator [] (size_t pos) const device
    {
        return elements[pos];
    }
    
    constexpr const constant T& operator [] (size_t pos) const constant
    {
        return elements[pos];
    }
    
    threadgroup T& operator [] (size_t pos) threadgroup
    {
        return elements[pos];
    }
    constexpr const threadgroup T& operator [] (size_t pos) const threadgroup
    {
        return elements[pos];
    }
};

struct _Global
{
    float4 u_viewTexel;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_normal [[texture(1)]], texture2d<float> s_depth [[texture(2)]], sampler s_colorSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]], sampler s_depthSampler [[sampler(2)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _563 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _569 = (_563.xyz * 2.0) - float3(1.0);
    float4 _578 = s_depth.sample(s_depthSampler, in.v_texcoord0);
    float _398 = _578.x;
    float _411 = _mtl_u.u_params[12].x * _mtl_u.u_viewTexel.x;
    float _416 = _mtl_u.u_params[12].x * _mtl_u.u_viewTexel.y;
    spvUnsafeArray<float, 5> _360;
    _360[0] = 0.0625;
    _360[1] = 0.25;
    _360[2] = 0.375;
    _360[3] = 0.25;
    _360[4] = 0.0625;
    float _426 = _360[2] * _360[2];
    float _637;
    float4 _638;
    _638 = s_color.sample(s_colorSampler, in.v_texcoord0) * _426;
    _637 = _426;
    float4 _641;
    float _642;
    for (int _636 = 0; _636 < 5; _638 = _641, _637 = _642, _636++)
    {
        _642 = _637;
        _641 = _638;
        float4 _645;
        float _646;
        for (int _639 = 0; _639 < 5; _642 = _646, _641 = _645, _639++)
        {
            if ((2 == _639) && (2 == _636))
            {
                _646 = _642;
                _645 = _641;
                continue;
            }
            float2 _660 = float2(in.v_texcoord0.x + ((float(_639) - 2.0) * _411), in.v_texcoord0.y + ((float(_636) - 2.0) * _416));
            float _519 = (exp((-abs(_398 - s_depth.sample(s_depthSampler, _660).x)) / fast::max(9.9999997473787516355514526367188e-06, _mtl_u.u_params[12].y * _mtl_u.u_params[12].y)) * powr(fast::clamp(dot(_569, (s_normal.sample(s_normalSampler, _660).xyz * 2.0) - float3(1.0)), 0.0, 1.0), _mtl_u.u_params[12].z)) * (_360[_639] * _360[_636]);
            _646 = _642 + _519;
            _645 = _641 + (s_color.sample(s_colorSampler, _660) * _519);
        }
    }
    out.bgfx_FragData0 = _638 / float4(fast::max(_637, 9.9999997473787516355514526367188e-06));
    return out;
}

