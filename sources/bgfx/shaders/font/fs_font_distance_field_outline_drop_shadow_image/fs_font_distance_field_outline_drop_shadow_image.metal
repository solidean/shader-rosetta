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
    float4 v_texcoord1 [[user(locn3)]];
    float4 v_texcoord2 [[user(locn4)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texturecube<float> s_texColor [[texture(0)]], sampler s_texColorSampler [[sampler(0)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float4 _633;
    do
    {
        if (!any(in.v_texcoord1.xyz == float3(0.0)))
        {
            float4 _591 = s_texColor.sample(s_texColorSampler, in.v_texcoord1.xyz);
            _633 = float4(_591.xyz, _591.w * in.v_color0.w);
            break;
        }
        if (!any(in.v_texcoord2.xyz == float3(0.0)))
        {
            float4 _605 = s_texColor.sample(s_texColorSampler, in.v_texcoord2.xyz);
            spvUnsafeArray<float, 4> _386;
            _386[0] = _605.z;
            _386[1] = _605.y;
            _386[2] = _605.x;
            _386[3] = _605.w;
            float _472 = (length(fwidth(in.v_texcoord2.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y;
            float _478 = 0.5 - (_mtl_u.u_params.w * _472);
            float _482 = _472 * _mtl_u.u_params.z;
            _633 = float4(in.v_color0.xyz, smoothstep(_478 - _482, _478 + _482, _386[int((in.v_texcoord2.w * 4.0) + 0.5)]) * in.v_color0.w);
            break;
        }
        float4 _614 = s_texColor.sample(s_texColorSampler, in.v_texcoord0.xyz);
        int _511 = int((in.v_texcoord0.w * 4.0) + 0.5);
        spvUnsafeArray<float, 4> _397;
        _397[0] = _614.z;
        _397[1] = _614.y;
        _397[2] = _614.x;
        _397[3] = _614.w;
        float _535 = (length(fwidth(in.v_texcoord0.xyz)) * 11.31370830535888671875) * _mtl_u.u_params.y;
        float _541 = 0.5 - (_mtl_u.u_params.w * _535);
        _633 = float4(mix(in.v_color1.xyz, in.v_color0.xyz, float3(smoothstep(0.5 - _535, 0.5 + _535, _397[_511]))), smoothstep(_541 - _535, _541 + _535, _397[_511]) * in.v_color0.w);
        break;
    } while(false);
    out.bgfx_FragData0 = _633;
    return out;
}

