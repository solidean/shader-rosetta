#pragma clang diagnostic ignored "-Wmissing-prototypes"

#include <metal_stdlib>
#include <simd/simd.h>

using namespace metal;

// Implementation of the GLSL radians() function
template<typename T>
inline T radians(T d)
{
    return d * T(0.01745329251);
}

struct _Global
{
    float4 u_params1;
    float4 u_params2;
    float4 u_color;
    float4 u_materialKa;
    float4 u_materialKd;
    float4 u_materialKs;
    float4 u_lightPosition;
    float4 u_lightAmbientPower;
    float4 u_lightDiffusePower;
    float4 u_lightSpecularPower;
    float4 u_lightSpotDirectionInner;
    float4 u_lightAttenuationSpotOuter;
    float4 u_smSamplingParams;
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
    float3 v_normal [[user(locn0)]];
    float4 v_shadowcoord [[user(locn1)]];
    float3 v_view [[user(locn2)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float2 _832 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
    float _834 = (all(_832 > float2(0.0)) && all(_832 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
    float _837 = -_834;
    float _1340;
    do
    {
        float2 _1044 = float4(_832, in.v_shadowcoord.z, 1.0).xy;
        if (any(_1044 > float2(1.0)) || any(_1044 < float2(0.0)))
        {
            _1340 = 1.0;
            break;
        }
        _1340 = step(in.v_shadowcoord.z - _mtl_u.u_params1.x, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1044, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
        break;
    } while(false);
    float _1341;
    float3 _1342;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1140 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1144 = fast::normalize(_1140);
        float _1177 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1159 = length(_1140);
        _1342 = _1144;
        _1341 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1159)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1159) * _1159))) * mix(fast::clamp((fast::max(0.0, dot(-_1144, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1177) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1177), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1342 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1341 = 1.0;
    }
    float _1224 = dot(in.v_normal, _1342);
    float2 _884 = fast::max(float2(_1224, ((step(0.0, _1224) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1224)) - _1342, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1341;
    float _892 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _884.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _884.y)) * _mtl_u.u_color.xyz) * _1340))), float3(0.4545454680919647216796875)) + (float3(_834, _837, _837) * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _892) * _892) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

