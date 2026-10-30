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
    float4 u_params;
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
    float4 v_color1 [[user(locn1)]];
    float4 v_texcoord0 [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _332 = s_texColor.sample(s_texColorSampler, in.v_texcoord0.xyz);
    int _259 = int((in.v_texcoord0.w * 4.0) + 0.5);
    spvUnsafeArray<float, 4> _238;
    _238[0] = _332.z;
    _238[1] = _332.y;
    _238[2] = _332.x;
    _238[3] = _332.w;
    float _283 = (length(fwidth(in.v_texcoord0.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y;
    float _289 = 0.5 - (_mtl_u.u_params.w * _283);
    out.bgfx_FragData0 = float4(mix(in.v_color1.xyz, in.v_color0.xyz, float3(smoothstep(0.5 - _283, 0.5 + _283, _238[_259]))), smoothstep(_289 - _283, _289 + _283, _238[_259]) * in.v_color0.w);
    return out;
}

