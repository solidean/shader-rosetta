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
    float2 _843 = in.v_shadowcoord.xy / float2(in.v_shadowcoord.w);
    float _845 = (all(_843 > float2(0.0)) && all(_843 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
    float _848 = -_845;
    float _1374;
    do
    {
        if (any(_843 > float2(1.0)) || any(_843 < float2(0.0)))
        {
            _1374 = 1.0;
            break;
        }
        float _1067 = ((in.v_shadowcoord.z - _mtl_u.u_params1.x) / in.v_shadowcoord.w) * _mtl_u.u_params1.w;
        float4 _1136 = s_shadowMap0.sample(s_shadowMap0Sampler, _843);
        float2 _1079 = float2(dot(_1136.xy, float2(0.0039215688593685626983642578125, 1.0)), dot(_1136.zw, float2(0.0039215688593685626983642578125, 1.0))) * _mtl_u.u_params1.w;
        float _1082 = _1079.x;
        if (_1067 < _1082)
        {
            _1374 = 1.0;
            break;
        }
        float _1095 = fast::max(_1079.y - (_1082 * _1082), _mtl_u.u_params1.z);
        float _1099 = _1067 - _1082;
        _1374 = _1095 / (_1095 + (_1099 * _1099));
        break;
    } while(false);
    float _1375;
    float3 _1376;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1174 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1178 = fast::normalize(_1174);
        float _1211 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1193 = length(_1174);
        _1376 = _1178;
        _1375 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1193)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1193) * _1193))) * mix(fast::clamp((fast::max(0.0, dot(-_1178, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1211) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1211), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1376 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1375 = 1.0;
    }
    float _1258 = dot(in.v_normal, _1376);
    float2 _895 = fast::max(float2(_1258, ((step(0.0, _1258) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1258)) - _1376, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1375;
    float _903 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _895.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _895.y)) * _mtl_u.u_color.xyz) * _1374))), float3(0.4545454680919647216796875)) + (float3(_845, _848, _848) * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _903) * _903) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

