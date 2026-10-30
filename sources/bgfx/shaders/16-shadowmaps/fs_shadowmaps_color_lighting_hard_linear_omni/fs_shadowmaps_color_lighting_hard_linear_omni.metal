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
    float4 u_tetraNormalGreen;
    float4 u_tetraNormalYellow;
    float4 u_tetraNormalBlue;
    float4 u_tetraNormalRed;
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
    float4 v_position [[user(locn1)]];
    float4 v_texcoord1 [[user(locn2)]];
    float4 v_texcoord2 [[user(locn3)]];
    float4 v_texcoord3 [[user(locn4)]];
    float4 v_texcoord4 [[user(locn5)]];
    float3 v_view [[user(locn6)]];
};

fragment xlatMtlMain_out xlatMtlMain(xlatMtlMain_in in [[stage_in]], constant _Global& _mtl_u [[buffer(0)]], texture2d<float> s_shadowMap0 [[texture(4)]], sampler s_shadowMap0Sampler [[sampler(4)]])
{
    xlatMtlMain_out out = {};
	if (bgfx_sampleMaskEnabled) { out.bgfx_metal_sampleMask = bgfx_sampleMask; }
    float _986 = dot(_mtl_u.u_tetraNormalGreen.xyz, in.v_position.xyz);
    float _992 = dot(_mtl_u.u_tetraNormalYellow.xyz, in.v_position.xyz);
    float _998 = dot(_mtl_u.u_tetraNormalBlue.xyz, in.v_position.xyz);
    float _1016 = fast::max(fast::max(_986, _992), fast::max(_998, dot(_mtl_u.u_tetraNormalRed.xyz, in.v_position.xyz)));
    float3 _1715;
    float4 _1770;
    if (_986 == _1016)
    {
        float2 _1028 = in.v_texcoord1.xy / float2(in.v_texcoord1.w);
        float _1030 = (all(_1028 > float2(0.0)) && all(_1028 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
        float _1032 = -_1030;
        _1770 = in.v_texcoord1;
        _1715 = float3(_1032, _1030, _1032);
    }
    else
    {
        float3 _1716;
        float4 _1771;
        if (_992 == _1016)
        {
            float2 _1049 = in.v_texcoord2.xy / float2(in.v_texcoord2.w);
            float _1051 = (all(_1049 > float2(0.0)) && all(_1049 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
            _1771 = in.v_texcoord2;
            _1716 = float3(_1051, _1051, -_1051);
        }
        else
        {
            bool _1060 = _998 == _1016;
            float3 _1717;
            if (_1060)
            {
                float2 _1068 = in.v_texcoord3.xy / float2(in.v_texcoord3.w);
                float _1070 = (all(_1068 > float2(0.0)) && all(_1068 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1072 = -_1070;
                _1717 = float3(_1072, _1072, _1070);
            }
            else
            {
                float2 _1084 = in.v_texcoord4.xy / float2(in.v_texcoord4.w);
                float _1086 = (all(_1084 > float2(0.0)) && all(_1084 < float2(1.0))) ? 0.300000011920928955078125 : 0.0;
                float _1089 = -_1086;
                _1717 = float3(_1086, _1089, _1089);
            }
            _1771 = select(in.v_texcoord4, in.v_texcoord3, bool4(_1060));
            _1716 = _1717;
        }
        _1770 = _1771;
        _1715 = _1716;
    }
    float _1709;
    do
    {
        float2 _1413 = float4(_1770.xy / float2(_1770.w), _1770.z, 1.0).xy;
        if (any(_1413 > float2(1.0)) || any(_1413 < float2(0.0)))
        {
            _1709 = 1.0;
            break;
        }
        _1709 = step(_1770.z - _mtl_u.u_params1.x, dot(s_shadowMap0.sample(s_shadowMap0Sampler, _1413, level(0.0)), float4(6.0308629201699659461155533790588e-08, 1.5378700481960549950599670410156e-05, 0.0039215688593685626983642578125, 1.0)));
        break;
    } while(false);
    float _1710;
    float3 _1711;
    if (0.0 != _mtl_u.u_lightPosition.w)
    {
        float3 _1509 = _mtl_u.u_lightPosition.xyz - in.v_view;
        float3 _1513 = fast::normalize(_1509);
        float _1546 = cos(radians(_mtl_u.u_lightAttenuationSpotOuter.w));
        float _1528 = length(_1509);
        _1711 = _1513;
        _1710 = (1.0 / ((_mtl_u.u_lightAttenuationSpotOuter.x + (_mtl_u.u_lightAttenuationSpotOuter.y * _1528)) + ((_mtl_u.u_lightAttenuationSpotOuter.z * _1528) * _1528))) * mix(fast::clamp((fast::max(0.0, dot(-_1513, fast::normalize(_mtl_u.u_lightSpotDirectionInner.xyz))) - _1546) / (cos(radians(fast::min(_mtl_u.u_lightSpotDirectionInner.w, _mtl_u.u_lightAttenuationSpotOuter.w - 0.001000000047497451305389404296875))) - _1546), 0.0, 1.0), 1.0, step(90.0, _mtl_u.u_lightAttenuationSpotOuter.w));
    }
    else
    {
        _1711 = -fast::normalize(_mtl_u.u_lightPosition.xyz);
        _1710 = 1.0;
    }
    float _1593 = dot(in.v_normal, _1711);
    float2 _1139 = fast::max(float2(_1593, ((step(0.0, _1593) * powr(fast::max(0.0, dot((in.v_normal * (2.0 * _1593)) - _1711, -fast::normalize(in.v_view))), _mtl_u.u_materialKs.w)) * (2.0 + _mtl_u.u_materialKs.w)) * 0.125), float2(0.0)) * _1710;
    float _1147 = length(in.v_view);
    out.bgfx_FragData0 = float4(mix(float3(0.0), powr(abs(abs((((_mtl_u.u_lightAmbientPower.xyz * _mtl_u.u_lightAmbientPower.w) * _mtl_u.u_materialKa.xyz) * _mtl_u.u_color.xyz) + ((((((_mtl_u.u_lightDiffusePower.xyz * _mtl_u.u_lightDiffusePower.w) * _mtl_u.u_materialKd.xyz) * _1139.x) + (((_mtl_u.u_lightSpecularPower.xyz * _mtl_u.u_lightSpecularPower.w) * _mtl_u.u_materialKs.xyz) * _1139.y)) * _mtl_u.u_color.xyz) * _1709))), float3(0.4545454680919647216796875)) + (_1715 * _mtl_u.u_params2.y), float3(fast::clamp(1.0 / exp2(((1.2250000509084202349185943603516e-05 * _1147) * _1147) * 1.44269502162933349609375), 0.0, 1.0))), 1.0);
    return out;
}

