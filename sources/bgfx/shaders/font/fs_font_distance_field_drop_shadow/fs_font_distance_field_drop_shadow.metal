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
    float4 v_texcoord0 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _469;
    do
    {
        if (!any(in.v_texcoord2.xyz == float3(0.0)))
        {
            float4 _451 = s_texColor.sample(s_texColorSampler, in.v_texcoord2.xyz);
            spvUnsafeArray<float, 4> _304;
            _304[0] = _451.z;
            _304[1] = _451.y;
            _304[2] = _451.x;
            _304[3] = _451.w;
            float _363 = ((length(fwidth(in.v_texcoord2.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y) * _mtl_u.u_params.z;
            _469 = float4(in.v_color0.xyz, smoothstep(0.5 - _363, 0.5 + _363, _304[int((in.v_texcoord2.w * 4.0) + 0.5)]) * in.v_color0.w);
            break;
        }
        float4 _460 = s_texColor.sample(s_texColorSampler, in.v_texcoord0.xyz);
        spvUnsafeArray<float, 4> _313;
        _313[0] = _460.z;
        _313[1] = _460.y;
        _313[2] = _460.x;
        _313[3] = _460.w;
        float _414 = (length(fwidth(in.v_texcoord0.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y;
        _469 = float4(in.v_color0.xyz, smoothstep(0.5 - _414, 0.5 + _414, _313[int((in.v_texcoord0.w * 4.0) + 0.5)]) * in.v_color0.w);
        break;
    } while(false);
    out.bgfx_FragData0 = _469;
    return out;
}

