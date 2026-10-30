#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

template <typename ImageT>
void spvImageFence(ImageT img) { img.fence(); }

struct _Global
{
    float4x4 u_view;
    float4 u_lightPosRadius[1];
    float4 u_lightRgbInnerR[1];
    float4x4 u_mtx;
};

struct xlatMtlMain_in
{
    float2 v_texcoord0 [[user(locn0)]];
};

fragment void xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_normal [[texture(0)]], texture2d<float> s_depth [[texture(1)]], texture2d<float, access::read_write> i_light [[texture(3)]], sampler s_normalSampler [[sampler(0)]], sampler s_depthSampler [[sampler(1)]], float4 gl_FragCoord [[position]])
{
    float2 _462 = (in.v_texcoord0 * 2.0) - float2(1.0);
    float4 _562 = _mtl_u.u_mtx * float4(_462.x, -_462.y, s_depth.sample(s_depthSampler, in.v_texcoord0).x, 1.0);
    int2 _489 = int2(gl_FragCoord.xy);
    float3 _585 = _mtl_u.u_lightPosRadius[0].xyz - (_562.xyz / float3(_562.w));
    spvImageFence(i_light);
    i_light.write(i_light.read(uint2(_489)) + float4(powr(abs((_mtl_u.u_lightRgbInnerR[0].xyz * fast::clamp(fast::max(0.0, dot((s_normal.sample(s_normalSampler, in.v_texcoord0).xyz * 2.0) - float3(1.0), fast::normalize(_585))), 0.0, 1.0)) * (1.0 - smoothstep(_mtl_u.u_lightRgbInnerR[0].w, 1.0, length(_585) / _mtl_u.u_lightPosRadius[0].w))), float3(0.4545454680919647216796875)), 1.0), uint2(_489));
}

