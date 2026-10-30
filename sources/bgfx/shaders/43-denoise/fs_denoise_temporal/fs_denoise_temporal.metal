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
    float4 u_viewRect;
    float4 u_viewTexel;
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

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_color [[texture(0)]], texture2d<float> s_normal [[texture(1)]], texture2d<float> s_velocity [[texture(2)]], texture2d<float> s_previousColor [[texture(3)]], texture2d<float> s_previousNormal [[texture(4)]], sampler s_colorSampler [[sampler(0)]], sampler s_normalSampler [[sampler(1)]], sampler s_velocitySampler [[sampler(2)]], sampler s_previousColorSampler [[sampler(3)]], sampler s_previousNormalSampler [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _562 = s_color.sample(s_colorSampler, in.v_texcoord0);
    float4 _571 = s_normal.sample(s_normalSampler, in.v_texcoord0);
    float3 _577 = (_571.xyz * 2.0) - float3(1.0);
    float2 _438 = ((in.v_texcoord0 - s_velocity.sample(s_velocitySampler, in.v_texcoord0).xy) * _mtl_u.u_viewRect.zw) - float2(0.5);
    float2 _440 = floor(_438);
    float2 _442 = fract(_438);
    float _444 = _442.x;
    float _445 = 1.0 - _444;
    float _449 = _442.y;
    float _450 = 1.0 - _449;
    spvUnsafeArray<float, 4> _396;
    _396[0] = _445 * _450;
    _396[1] = _444 * _450;
    _396[2] = _445 * _449;
    _396[3] = _444 * _449;
    spvUnsafeArray<float2, 4> _397;
    _397[0] = (_440 + float2(0.5)) * _mtl_u.u_viewTexel.xy;
    _397[1] = (_440 + float2(1.5, 0.5)) * _mtl_u.u_viewTexel.xy;
    _397[2] = (_440 + float2(0.5, 1.5)) * _mtl_u.u_viewTexel.xy;
    _397[3] = (_440 + float2(1.5)) * _mtl_u.u_viewTexel.xy;
    float _653;
    float4 _654;
    _654 = float4(0.0);
    _653 = 0.0;
    for (int _652 = 0; _652 < 4; )
    {
        float _525 = ((dot(_577, (s_previousNormal.sample(s_previousNormalSampler, _397[_652]).xyz * 2.0) - float3(1.0)) < 0.707106769084930419921875) ? 0.0 : 1.0) * _396[_652];
        _654 += (s_previousColor.sample(s_previousColorSampler, _397[_652]) * _525);
        _653 += _525;
        _652++;
        continue;
    }
    float4 _656;
    if (0.0 < _653)
    {
        _656 = mix(_562, _654 * (1.0 / _653), float4(0.800000011920928955078125));
    }
    else
    {
        _656 = _562;
    }
    out.bgfx_FragData0 = _656;
    return out;
}

