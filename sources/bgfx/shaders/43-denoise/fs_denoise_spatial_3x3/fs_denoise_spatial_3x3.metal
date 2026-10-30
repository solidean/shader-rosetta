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
    float4 _556 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _562 = (_556.xyz * 2.0) - float3(1.0);
    float4 _571 = s_depth.sample(s_depthSampler, in.v_texcoord0);
    float _393 = _571.x;
    float _406 = _mtl_u.u_params[12].x * _mtl_u.u_viewTexel.x;
    float _411 = _mtl_u.u_params[12].x * _mtl_u.u_viewTexel.y;
    spvUnsafeArray<float, 3> _355;
    _355[0] = 0.25;
    _355[1] = 0.5;
    _355[2] = 0.25;
    float _419 = _355[1] * _355[1];
    float _630;
    float4 _631;
    _631 = s_color.sample(s_colorSampler, in.v_texcoord0) * _419;
    _630 = _419;
    float4 _634;
    float _635;
    for (int _629 = 0; _629 < 3; _631 = _634, _630 = _635, _629++)
    {
        _635 = _630;
        _634 = _631;
        float4 _638;
        float _639;
        for (int _632 = 0; _632 < 3; _635 = _639, _634 = _638, _632++)
        {
            if ((1 == _632) && (1 == _629))
            {
                _639 = _635;
                _638 = _634;
                continue;
            }
            float2 _653 = float2(in.v_texcoord0.x + ((float(_632) - 1.0) * _406), in.v_texcoord0.y + ((float(_629) - 1.0) * _411));
            float _512 = (exp((-abs(_393 - s_depth.sample(s_depthSampler, _653).x)) / fast::max(9.9999997473787516355514526367188e-06, _mtl_u.u_params[12].y * _mtl_u.u_params[12].y)) * powr(fast::clamp(dot(_562, (s_normal.sample(s_normalSampler, _653).xyz * 2.0) - float3(1.0)), 0.0, 1.0), _mtl_u.u_params[12].z)) * (_355[_632] * _355[_629]);
            _639 = _635 + _512;
            _638 = _634 + (s_color.sample(s_colorSampler, _653) * _512);
        }
    }
    out.bgfx_FragData0 = _631 / float4(fast::max(_630, 9.9999997473787516355514526367188e-06));
    return out;
}

