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
    float4 v_texcoord1 [[user(locn3)]];
    float4 v_texcoord2 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _540;
    do
    {
        if (!any(in.v_texcoord2.xyz == float3(0.0)))
        {
            float4 _504 = s_texColor.sample(s_texColorSampler, in.v_texcoord2.xyz);
            spvUnsafeArray<float, 4> _331;
            _331[0] = _504.z;
            _331[1] = _504.y;
            _331[2] = _504.x;
            _331[3] = _504.w;
            float _395 = ((length(fwidth(in.v_texcoord2.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y) * _mtl_u.u_params.z;
            _540 = float4(in.v_color0.xyz, smoothstep(0.5 - _395, 0.5 + _395, _331[int((in.v_texcoord2.w * 4.0) + 0.5)]) * in.v_color0.w);
            break;
        }
        if (any(in.v_texcoord0.xyz == float3(0.0)))
        {
            float4 _518 = s_texColor.sample(s_texColorSampler, in.v_texcoord1.xyz);
            _540 = float4(_518.xyz, _518.w * in.v_color0.w);
            break;
        }
        float4 _527 = s_texColor.sample(s_texColorSampler, in.v_texcoord0.xyz);
        spvUnsafeArray<float, 4> _345;
        _345[0] = _527.z;
        _345[1] = _527.y;
        _345[2] = _527.x;
        _345[3] = _527.w;
        float _467 = (length(fwidth(in.v_texcoord0.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y;
        _540 = float4(in.v_color0.xyz, smoothstep(0.5 - _467, 0.5 + _467, _345[int((in.v_texcoord0.w * 4.0) + 0.5)]) * in.v_color0.w);
        break;
    } while(false);
    out.bgfx_FragData0 = _540;
    return out;
}

